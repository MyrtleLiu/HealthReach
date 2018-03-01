//
//  WeightHistoryViewController.m
//  mHealth
//
//  Created by sngz on 14-3-13.
//
//

#import "WeightHistoryCustomCell.h"
#import "WeightViewController.h"
#import "HomeViewController.h"
#import "WeightHistoryViewController.h"
#import "DBHelper.h"
#import "Utility.h"
#import "WeightRotateViewController.h"
#import "GlobalVariables.h"
#import "WeightMonthHistoryCustomCell.h"
#import "WeightWeekHistoryCustomCell.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "syncWeight.h"
#import "TKAlertCenter.h"

@interface WeightHistoryViewController ()

@end

@implementation WeightHistoryViewController

@synthesize LBSLabel;
@synthesize BMILabel;
@synthesize warningButton;
@synthesize infoButton;
@synthesize dateLabel;
@synthesize timeLabel;

@synthesize dataList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"WeightHistoryViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"WeightHistoryViewController_iphone4" bundle:nibBundleOrNil];
    }
    
     [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setAverageWeightView:self];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    if (iPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        self.view.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    }
    
//    if ([[GlobalVariables shareInstance].WeightAlreadySync isEqualToString:@"0"]) {
//        [GlobalVariables shareInstance].WeightAlreadySync = @"1";
//        NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(syncWeightData) object:nil];
//        [syncThread start];
//    
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishSyncData) name:@"SyncWeightFinish" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noDataConnection) name:@"SyncWeightNoDataConnection" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncWeightError) name:@"SyncWeightError" object:nil];
//        [self.waitingView setHidden:NO];
//    } else {
//        [self.waitingView setHidden:YES];
//    }
    
    UIDevice *device = [UIDevice currentDevice];
	[device beginGeneratingDeviceOrientationNotifications];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataList = [DBHelper getWeightHistoryRecord];
    [self updateColumn];
    [self reloadViewText];
    [self.historyTableView setSeparatorStyle:0];
    [self.monthlyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.weeklyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.weeklyTableView setHidden:TRUE];
    [self.monthlyTableView setHidden:TRUE];
    [self.historyTableView setTag:0];
    [self.weeklyTableView setTag:1];
    [self.monthlyTableView setTag:2];
    
    
    
    [self.infoView setHidden:TRUE];
//    [self.monthlyAverageView setHidden:TRUE];
//    [self.weeklyAverageView setHidden:TRUE];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)syncWeightData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [syncWeight syncAllWeightData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_W_%@",[GlobalVariables shareInstance].login_id]]];
}

- (void)didFinishSyncData
{
    [self.waitingView setHidden:YES];
    
    self.dataList = [DBHelper getWeightHistoryRecord];
    [self updateColumn];
    [self performSelectorOnMainThread:@selector(refreshMonthlyTable) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(refreshMeasurementTable) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(refreshWeeklyTable) withObject:nil waitUntilDone:NO];
}

- (void)noDataConnection
{
    [self.waitingView setHidden:YES];
    [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"network_unavailable"]];
}

- (void)syncWeightError
{
    [self.waitingView setHidden:YES];
}

- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
	switch (o) {
		case UIDeviceOrientationLandscapeLeft:
            [self rotateView];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self rotateView];
            break;
            
		default:
			break;
	}
}

- (void)rotateView {
    WeightRotateViewController *rotateView = [[WeightRotateViewController alloc]initWithNibName:@"WeightRotateViewController" bundle:nil];
    
//    if (!iPad) {
//        
//        [self.navigationController presentViewController:rotateView animated:YES completion:nil];
//
//        
//    }else{
    
         [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] showRotateView:rotateView];
        
//    }
    
   
    
    
}

-(BOOL)bmiWarning:(NSString *)bmi{
    float bmiValue = [bmi floatValue];
    if ((bmiValue>=18.5)&&(bmiValue<=22.9)){
        return FALSE;
    }
    return TRUE;
}

-(void)reloadViewText{
    [_weightTitle setText:[Utility getStringByKey:@"home_title_Weight"]];
    [_weightTitle setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [_historyTitle setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    [_measurementRecordLabel_1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:14]];
    [_measurementRecordLabel_1 setText:[Utility getStringByKey:@"measurement"]];
    [_measurementRecordLabel_2 setText:[Utility getStringByKey:@"record"]];
    [_measurementRecordLabel_2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [_monthlyAverageLabel_1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:14]];
    [_monthlyAverageLabel_1 setText:[Utility getStringByKey:@"monthly"]];
    [_monthlyAverageLabel_2 setText:[Utility getStringByKey:@"average"]];
    [_monthlyAverageLabel_2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [_weeklyAverageLabel_1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:14]];
    [_weeklyAverageLabel_1 setText:[Utility getStringByKey:@"weekly"]];
    [_weeklyAverageLabel_2 setText:[Utility getStringByKey:@"average"]];
    [_weeklyAverageLabel_2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    
    [self.LBSLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:35]];
    [_lbsUnitLabel setText:[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"]];
    [self.BMILabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:35]];
    [_lbsUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:15]];
    [_bmiUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:15]];
    
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];

    [_historyTitle setText:[Utility getStringByKey:@"history_data"]];
    
    [_infoLabel_1 setText:[Utility getStringByKey:@"weight_info_label_1"]];
    [_infoLabel_2 setText:[Utility getStringByKey:@"weight_info_label_2"]];
    [_infoLabel_3 setText:[Utility getStringByKey:@"weight_info_label_3"]];
    [_infoLabel_4 setText:[Utility getStringByKey:@"weight_info_label_4"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)measurementTap:(id)sender
{
    self.dataList = [DBHelper getWeightHistoryRecord];
    NSLog(@"self.dataList:%@",self.dataList);
    [self performSelectorOnMainThread:@selector(refreshMeasurementTable) withObject:nil waitUntilDone:NO];
    [self.weeklyTableView setHidden:TRUE];
    [self.monthlyTableView setHidden:TRUE];
    [self.historyTableView setHidden:FALSE];
    [self.measurementRecordView setBackgroundColor:[UIColor colorWithRed:43/255.0f green:109/255.0f blue:162/255.0f alpha:1.0f]];
    [self.monthlyAverageView setBackgroundColor:[UIColor colorWithRed:13/255.0f green:55/255.0f blue:88/255.0f alpha:1.0f]];
    [self.weeklyAverageView setBackgroundColor:[UIColor colorWithRed:13/255.0f green:55/255.0f blue:88/255.0f alpha:1.0f]];
    [self.leftPlate setBackgroundColor:[UIColor colorWithRed:117/255.0f green:160/255.0f blue:194/255.0f alpha:1.0f]];
    [self.rightPlate setBackgroundColor:[UIColor colorWithRed:7/255.0f green:33/255.0f blue:54/255.0f alpha:1.0f]];
}

- (IBAction)monthlyAverageTap:(id)sender
{
    
    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenAverageWeightLoad];
    NSLog(@"checkLoadView:%d",checkLoadView);
    if(checkLoadView){
        _waitingView.hidden=true;
        
        self.dataList = [DBHelper getAllWeightMonthRecord];
        NSLog(@"self.dataList:%@",self.dataList);
        [self performSelectorOnMainThread:@selector(refreshMonthlyTable) withObject:nil waitUntilDone:NO];
        [self.weeklyTableView setHidden:TRUE];
        [self.monthlyTableView setHidden:FALSE];
        [self.historyTableView setHidden:TRUE];
        [self.measurementRecordView setBackgroundColor:[UIColor colorWithRed:13/255.0f green:55/255.0f blue:88/255.0f alpha:1.0f]];
        [self.monthlyAverageView setBackgroundColor:[UIColor colorWithRed:43/255.0f green:109/255.0f blue:162/255.0f alpha:1.0f]];
        [self.weeklyAverageView setBackgroundColor:[UIColor colorWithRed:13/255.0f green:55/255.0f blue:88/255.0f alpha:1.0f]];
        [self.leftPlate setBackgroundColor:[UIColor colorWithRed:7/255.0f green:33/255.0f blue:54/255.0f alpha:1.0f]];
        [self.rightPlate setBackgroundColor:[UIColor colorWithRed:117/255.0f green:160/255.0f blue:194/255.0f alpha:1.0f]];

    }
    else{
        
        _waitingView.hidden=false;
    }
}

- (IBAction)weeklyAverageTap:(id)sender
{
    
    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenAverageWeightLoad];
    NSLog(@"checkLoadView:%d",checkLoadView);
    if(checkLoadView){
        _waitingView.hidden=true;
        
        self.dataList = [DBHelper getAllWeightWeekRecord];
        NSLog(@"self.dataList:%@",self.dataList);
        [self performSelectorOnMainThread:@selector(refreshWeeklyTable) withObject:nil waitUntilDone:NO];
        [self.weeklyTableView setHidden:FALSE];
        [self.monthlyTableView setHidden:TRUE];
        [self.historyTableView setHidden:TRUE];
        [self.measurementRecordView setBackgroundColor:[UIColor colorWithRed:13/255.0f green:55/255.0f blue:88/255.0f alpha:1.0f]];
        [self.monthlyAverageView setBackgroundColor:[UIColor colorWithRed:13/255.0f green:55/255.0f blue:88/255.0f alpha:1.0f]];
        [self.weeklyAverageView setBackgroundColor:[UIColor colorWithRed:43/255.0f green:109/255.0f blue:162/255.0f alpha:1.0f]];
        [self.leftPlate setBackgroundColor:[UIColor colorWithRed:117/255.0f green:160/255.0f blue:194/255.0f alpha:1.0f]];
        [self.rightPlate setBackgroundColor:[UIColor colorWithRed:117/255.0f green:160/255.0f blue:194/255.0f alpha:1.0f]];

    }
    else{
        
        _waitingView.hidden=false;
    }
}

- (void)refreshWeeklyTable
{
    [self.weeklyTableView reloadData];
}

- (void)refreshMeasurementTable
{
    [self.historyTableView reloadData];
}

- (void)refreshMonthlyTable
{
    [self.monthlyTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (tableView.tag) {
        case 0: {
            count = [[DBHelper getWeightHistoryRecord] count];
            if (!iPad) {
                if (count<7) count = 7;
            } else
                if (count<5) count = 5;
            
            break;
        }
        case 1: {
            count = [[DBHelper getAllWeightWeekRecord] count];
            if (!iPad)
                if (count<9) count = 9;
            break;
        }
        case 2: {
            count = [[DBHelper getAllWeightMonthRecord] count];
            if (!iPad)
                if (count<9) count = 9;
            
            break;
        }
        default:
            break;
    }
	return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (tableView.tag) {
        case 0:{
            static NSString *wightHistoryCustomCellIdentifier = @"WeightHistoryCustomCellIdentifier";
            
            UINib *nib = [UINib nibWithNibName:@"WeightHistoryCustomCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:wightHistoryCustomCellIdentifier];
            
            WeightHistoryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:wightHistoryCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row<[self.dataList count]) {
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                cell.lbsString = [Utility transeferWeightValue:[rowData objectForKey:@"weight"] precision:0];
                [cell.bmiNameLabel setText:@"BMI"];
                cell.bmiString = [rowData objectForKey:@"bmi"];
                cell.timeString = [Utility extractTimeString:[rowData objectForKey:@"time"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
                cell.dateString = [Utility extractDateString:[rowData objectForKey:@"time"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
                [cell.lbsNameLabel setText:[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"]];
                
               
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary *alertLevelDict = [defaults objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
                
                if (([[rowData objectForKey:@"bmi"]floatValue] > [[alertLevelDict objectForKey:@"hbmi"]floatValue]) && ([[alertLevelDict objectForKey:@"hbmi"]floatValue] > 0))
                    [cell.bmiLabel setTextColor:[UIColor redColor]];
                else
                    [cell.bmiLabel setTextColor:[UIColor blackColor]];
                
            }
            
            
            
            
            
            else {
                cell.lbsString = @"";
            }
            
            if (row%2==1)
            {
                cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
            }
            return cell;
        }
            
        case 1:{
            static NSString *wightWeekHistoryCustomCellIdentifier = @"WeightWeekHistoryCustomCellIdentifier";
            
            UINib *nib = [UINib nibWithNibName:@"WeightWeekHistoryCustomCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:wightWeekHistoryCustomCellIdentifier];
            
            WeightWeekHistoryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:wightWeekHistoryCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row<[self.dataList count]) {
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                cell.lbsString = [Utility transeferWeightValue:[rowData objectForKey:@"weight"] precision:0];
                [cell.bmiNameLabel setText:@"BMI"];
                cell.bmiString = [rowData objectForKey:@"bmi"];
                [cell.lbsNameLabel setText:[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"]];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary *alertLevelDict = [defaults objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
                
                if (([[rowData objectForKey:@"bmi"]floatValue] > [[alertLevelDict objectForKey:@"hbmi"]floatValue]) && ([[alertLevelDict objectForKey:@"hbmi"]floatValue] > 0))
                    [cell.bmiLabel setTextColor:[UIColor redColor]];
                else
                    [cell.bmiLabel setTextColor:[UIColor blackColor]];

                NSString *weekNoString = [rowData objectForKey:@"weekno"];
                weekNoString = [weekNoString substringFromIndex:5];
                weekNoString = [NSString stringWithFormat:@"Week %@",weekNoString];
                cell.weeknoString = weekNoString;
                
                NSString *weekStartString = [rowData objectForKey:@"weekstart"];
                
                NSString *weekEndString = [rowData objectForKey:@"weekend"];
                weekEndString = [Utility extractDateString:weekEndString oldDateFormatter:@"yyyy-MM-dd"];
                
                weekStartString = [Utility extractDateString:weekStartString oldDateFormatter:@"yyyy-MM-dd"];
                if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                    weekStartString = [weekStartString substringFromIndex:5];
                    weekEndString = [weekEndString substringFromIndex:5];
                } else {
                    weekStartString = [weekStartString substringToIndex:6];
                    weekEndString = [weekEndString substringToIndex:6];
                }
                NSString *weekDetailString = [NSString stringWithFormat:@"%@ - %@",weekStartString, weekEndString];
                cell.weekDetailString = weekDetailString;
            } else {
                cell.lbsString = @"";
            }
            
            if (row%2==1)
            {
                cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
            }
            return cell;
        }
            
        case 2:{
            static NSString *wightMonthHistoryCustomCellIdentifier = @"WeightMonthHistoryCustomCellIdentifier";
            
            UINib *nib = [UINib nibWithNibName:@"WeightMonthHistoryCustomCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:wightMonthHistoryCustomCellIdentifier];
            
            WeightMonthHistoryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:wightMonthHistoryCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row<[self.dataList count]) {
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                cell.lbsString = [Utility transeferWeightValue:[rowData objectForKey:@"weight"] precision:0];
                [cell.bmiNameLabel setText:@"BMI"];
                cell.bmiString = [rowData objectForKey:@"bmi"];
                [cell.lbsNameLabel setText:[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"]];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary *alertLevelDict = [defaults objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
                
                if (([[rowData objectForKey:@"bmi"]floatValue] > [[alertLevelDict objectForKey:@"hbmi"]floatValue]) && ([[alertLevelDict objectForKey:@"hbmi"]floatValue] > 0))
                    [cell.bmiLabel setTextColor:[UIColor redColor]];
                else
                    [cell.bmiLabel setTextColor:[UIColor blackColor]];
                
                NSString *monthString = [rowData objectForKey:@"month"];
                monthString = [Utility extractDateString:monthString oldDateFormatter:@"yyyy-MM"];
                if ([[Utility getLanguageCode]isEqualToString:@"en"]) {
                    monthString = [monthString substringFromIndex:[monthString rangeOfString:@" "].location];
                } else if ([[Utility getLanguageCode]isEqualToString:@"cn"]) {
                    monthString = [monthString substringToIndex:([monthString rangeOfString:@"月"].location + [monthString rangeOfString:@"月"].length)];
                }
                NSLog(@"!!monthString:%@",monthString);
                cell.monthString = monthString;

            } else {
                cell.lbsString = @"";
            }
            
            if (row%2==1)
            {
                cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
            }
            return cell;
        }
    }
    return Nil;
    
}

-(void)updateColumn{
    Weight *newestWeight = [DBHelper getNewestWeightRecord];
    
    NSString *result = [Utility getRoundFloatNSString:[newestWeight weight] maximumFractionDigits:0];
    if ([result isEqualToString:@"0"])
        [LBSLabel setText:@"--"];
    else
        [LBSLabel setText:[Utility transeferWeightValue:result precision:0]];
    
    result = [Utility getRoundFloatNSString:[newestWeight bmi] maximumFractionDigits:0];
    if ([result isEqualToString:@"0"]) result=@"--";
    [BMILabel setText:result];

    [dateLabel setText:[Utility extractDateString:[newestWeight timeStr] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"]];
    [timeLabel setText:[Utility extractTimeString:[newestWeight timeStr] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"]];
    if (![self bmiWarning:[newestWeight bmi]])
        warningButton.hidden = TRUE;
}

- (IBAction)toWeightView:(id)sender
{
    WeightViewController *weightView = [[WeightViewController alloc]initWithNibName:@"WeightViewController" bundle:nil];
    
    [self.navigationController pushViewController:weightView animated:YES];
}


-(BOOL)shouldAutorotate {
    
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations{
#else
    - (UIInterfaceOrientationMask)supportedInterfaceOrientations{
#endif
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    
}

- (IBAction)bmiInfoOKButtonDown:(id)sender {
    [self.infoView setHidden:TRUE];	
}
- (IBAction)infoButtonDown:(id)sender {
    [self.infoView setHidden:FALSE];
}

@end
