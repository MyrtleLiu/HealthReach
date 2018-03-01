//
//  BGHistoryViewController.m
//  mHealth
//
//  Created by sngz on 14-3-27.
//
//

#import "BGHistoryViewController.h"
#import "Utility.h"
#import "DBHelper.h"
#import "BloodGlucose.h"
#import "BGTitleCustomCell.h"
#import "BGViewController.h"
#import "BGRotateChartViewController.h"
#import "BGWeeklyCustomCellView.h"
#import "BGMonthlyCustomCellView.h"
#import "GlobalVariables.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "syncBG.h"
#import "TKAlertCenter.h"

@interface BGHistoryViewController ()

@end

@implementation BGHistoryViewController

@synthesize timeLabel;
@synthesize dateLabel;
@synthesize BGValueLabel;
@synthesize typeLabel;

@synthesize dataList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"BGHistoryViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"BGHistoryViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setAverageBGView:self];

    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    if (iPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        self.view.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    }
    
//    if ([[GlobalVariables shareInstance].BGAlreadySync isEqualToString:@"0"]) {
//        [GlobalVariables shareInstance].BGAlreadySync = @"1";
//        NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(syncBGData) object:nil];
//        [syncThread start];
//    
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishSyncData) name:@"SyncBGFinish" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noDataConnection) name:@"SyncBGNoDataConnection" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncBGError) name:@"SyncBGError" object:nil];
//        [self.waitingView setHidden:NO];
//    } else {
//        [self.waitingView setHidden:YES];
//    }
    
    UIDevice *device = [UIDevice currentDevice];
	[device beginGeneratingDeviceOrientationNotifications];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
}

- (void)didFinishSyncData
{
//    [self.waitingView setHidden:YES];
    
    self.dataList = [DBHelper getBGHistoryRecord];
    [self updateColumn];    
    [self performSelectorOnMainThread:@selector(refreshMonthlyTable) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(refreshMeasurementTable) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(refreshWeeklyTable) withObject:nil waitUntilDone:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataList = [DBHelper getBGHistoryRecord];
    
    [self reloadViewText];
    [self updateColumn];
    
    [self.weeklyView setBackgroundColor:[UIColor colorWithRed:73/255.0f green:33/255.0f blue:88/255.0f alpha:1.0f]];
    [self.monthlyView setBackgroundColor:[UIColor colorWithRed:73/255.0f green:33/255.0f blue:88/255.0f alpha:1.0f]];
    [self.dailyView setBackgroundColor:[UIColor colorWithRed:166/255.0f green:81/255.0f blue:183/255.0f alpha:1.0f]];
    [self.leftPlate setBackgroundColor:[UIColor colorWithRed:210/255.0f green:156/255.0f blue:220/255.0f alpha:1.0f]];
    [self.rightPlate setBackgroundColor:[UIColor colorWithRed:51/255.0f green:23/255.0f blue:61/255.0f alpha:1.0f]];
    
    [self.historyTableView setSeparatorStyle:0];
    [self.weeklyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.monthlyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.weeklyTableView setHidden:TRUE];
    [self.monthlyTableView setHidden:TRUE];
    [self.historyTableView setTag:0];
    [self.weeklyTableView setTag:1];
    [self.monthlyTableView setTag:2];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)syncBGData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [syncBG syncAllBGData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_G_%@",[GlobalVariables shareInstance].login_id]]];
}

- (void)noDataConnection
{
//    [self.waitingView setHidden:YES];
    [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"network_unavailable"]];
}

- (void)syncBGError
{
//    [self.waitingView setHidden:YES];
}

- (void)reloadViewText{
    [_bloodGlucoseLabel setText:[Utility getStringByKey:@"bloodglucose"]];
    [_bloodGlucoseLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [_historyLabel setText:[Utility getStringByKey:@"history_data"]];
    [_historyLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [self.dailyRecordLabel_1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14]];
    [self.dailyRecordLabel_1 setText:[Utility getStringByKey:@"measurement"]];
    [self.dailyRecordLabel_2 setText:[Utility getStringByKey:@"record"]];
    [self.dailyRecordLabel_2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.weeklyAverageLabel_1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:14]];
    [self.weeklyAverageLabel_1 setText:[Utility getStringByKey:@"weekly"]];
    [self.weeklyAverageLabel_2 setText:[Utility getStringByKey:@"average"]];
    [self.weeklyAverageLabel_2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.monthlyAverageLabel_1 setText:[Utility getStringByKey:@"monthly"]];
    [self.monthlyAverageLabel_1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:14]];
    [self.monthlyAverageLabel_2 setText:[Utility getStringByKey:@"average"]];
    [self.monthlyAverageLabel_2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    
    [self.BGValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:56]];
    [_unitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14]];
    [self.typeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14]];
    
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    
}

-(void)updateColumn
{
    BloodGlucose *newestBG = [DBHelper getNewestBGRecord];
    if ([newestBG bg].length>0){
        [BGValueLabel setText:[newestBG bg]];
        [typeLabel setText:[Utility getBGTypeString:[newestBG type]]];
        
        dateLabel.text = [Utility extractDateString:[newestBG timeStr] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
        timeLabel.text = [Utility extractTimeString:[newestBG timeStr] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    }
}

- (IBAction)toBGView:(id)sender {
    BGViewController *bgView = [[BGViewController alloc]initWithNibName:@"BGViewController" bundle:nil];
    [self.navigationController pushViewController:bgView animated:YES];
}

- (IBAction)measurementTap:(id)sender
{
    [self.weeklyTableView setHidden:YES];
    [self.monthlyTableView setHidden:YES];
    self.dataList = [DBHelper getBGHistoryRecord];
    [self performSelectorOnMainThread:@selector(refreshMeasurementTable) withObject:nil waitUntilDone:NO];
    [self.weeklyView setBackgroundColor:[UIColor colorWithRed:73/255.0f green:33/255.0f blue:88/255.0f alpha:1.0f]];
    [self.monthlyView setBackgroundColor:[UIColor colorWithRed:73/255.0f green:33/255.0f blue:88/255.0f alpha:1.0f]];
    [self.dailyView setBackgroundColor:[UIColor colorWithRed:166/255.0f green:81/255.0f blue:183/255.0f alpha:1.0f]];
    [self.leftPlate setBackgroundColor:[UIColor colorWithRed:210/255.0f green:156/255.0f blue:220/255.0f alpha:1.0f]];
    [self.rightPlate setBackgroundColor:[UIColor colorWithRed:51/255.0f green:23/255.0f blue:61/255.0f alpha:1.0f]];
}

- (IBAction)weeklyAverageTap:(id)sender {
    
    
    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenAverageBGLoad];
    NSLog(@"checkLoadView:%d",checkLoadView);
    if(checkLoadView){
        _WaitingView.hidden=true;
        
        self.dataList = [DBHelper getAllBGWeekRecord];
//        NSLog(@"Vaycent check dataList:%d",self.dataList.count);
        
        
        
        [self performSelectorOnMainThread:@selector(refreshWeeklyTable) withObject:nil waitUntilDone:NO];
        [self.weeklyTableView setHidden:FALSE];
        [self.monthlyTableView setHidden:TRUE];
        [self.dailyView setBackgroundColor:[UIColor colorWithRed:73/255.0f green:33/255.0f blue:88/255.0f alpha:1.0f]];
        [self.monthlyView setBackgroundColor:[UIColor colorWithRed:73/255.0f green:33/255.0f blue:88/255.0f alpha:1.0f]];
        [self.weeklyView setBackgroundColor:[UIColor colorWithRed:166/255.0f green:81/255.0f blue:183/255.0f alpha:1.0f]];
        [self.leftPlate setBackgroundColor:[UIColor colorWithRed:210/255.0f green:156/255.0f blue:220/255.0f alpha:1.0f]];
        [self.rightPlate setBackgroundColor:[UIColor colorWithRed:210/255.0f green:156/255.0f blue:220/255.0f alpha:1.0f]];

    }
    else{
        
        _WaitingView.hidden=false;
    }
    
}

- (IBAction)monthlyAverageTap:(id)sender {
    
    
    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenAverageBGLoad];
    NSLog(@"checkLoadView:%d",checkLoadView);
    if(checkLoadView){
        _WaitingView.hidden=true;
        
        self.dataList = [DBHelper getAllBGMonthRecord];
        [self performSelectorOnMainThread:@selector(refreshMonthlyTable) withObject:nil waitUntilDone:NO];
        [self.weeklyTableView setHidden:TRUE];
        [self.monthlyTableView setHidden:FALSE];
        [self.dailyView setBackgroundColor:[UIColor colorWithRed:73/255.0f green:33/255.0f blue:88/255.0f alpha:1.0f]];
        [self.weeklyView setBackgroundColor:[UIColor colorWithRed:73/255.0f green:33/255.0f blue:88/255.0f alpha:1.0f]];
        [self.monthlyView setBackgroundColor:[UIColor colorWithRed:166/255.0f green:81/255.0f blue:183/255.0f alpha:1.0f]];
        [self.leftPlate setBackgroundColor:[UIColor colorWithRed:51/255.0f green:23/255.0f blue:61/255.0f alpha:1.0f]];
        [self.rightPlate setBackgroundColor:[UIColor colorWithRed:210/255.0f green:156/255.0f blue:220/255.0f alpha:1.0f]];

    }
    else{
        
        _WaitingView.hidden=false;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 0:
            return 40;
            break;
            
        default:
            return 142;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *alertLevelDict = [defaults objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
    
    switch (tableView.tag) {
        case 0: {
            static NSString *BGHistoryTitleCustomCellIdentifier = @"BGHistoryTitleCustomCellIdentifier";
            
            UINib *nib = [UINib nibWithNibName:@"BGTitleCustomCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:BGHistoryTitleCustomCellIdentifier];
            
            BGTitleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:BGHistoryTitleCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row<[self.dataList count]) {
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                
                cell.BGValueString = [rowData objectForKey:@"bg"];
                NSString *typeString = [rowData objectForKey:@"type"];
                cell.typeString = [Utility getBGTypeString:typeString];
                
                cell.timeString = [Utility extractTimeString:[rowData objectForKey:@"time"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
                cell.dateString = [Utility extractDateString:[rowData objectForKey:@"time"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
                
                if ([typeString isEqualToString:@"F"]){
                    if (([cell.BGValueLabel.text floatValue] >= [[alertLevelDict objectForKey:@"hbg"]floatValue])&& ([[alertLevelDict objectForKey:@"hbg"]floatValue] > 0))
                        //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg"]floatValue]))
                        [cell.BGValueLabel setTextColor:[UIColor redColor]];
                    else
                        [cell.BGValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
                }
                if ([typeString isEqualToString:@"B"]){
                    if (([cell.BGValueLabel.text floatValue] >= [[alertLevelDict objectForKey:@"hbg_b"]floatValue])&& ([[alertLevelDict objectForKey:@"hbg_b"]floatValue] > 0)) {
                        //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg_b"]floatValue]))
                        [cell.BGValueLabel setTextColor:[UIColor redColor]];
                    }
                    else {
                        [cell.BGValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
                    }
                    
                }
                if ([typeString isEqualToString:@"A"]){
                    if (([cell.BGValueLabel.text floatValue] >= [[alertLevelDict objectForKey:@"hbg_a"]floatValue])&& ([[alertLevelDict objectForKey:@"hbg_a"]floatValue] > 0))
                        //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg_a"]floatValue]))
                        [cell.BGValueLabel setTextColor:[UIColor redColor]];
                    else
                        [cell.BGValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
                }
                if ([typeString isEqualToString:@"U"]){
                    [cell.BGValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
                }
                
            } else
                cell.mmolString = @"";
            
            if (row%2==1)
                cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
            else
                cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
            
            return cell;
            break;
        }
            
        case 1: {
            static NSString *BGWeeklyHistoryTitleCustomCellIdentifier = @"BGWeeklyHistoryTitleCustomCellIdentifier";
            UINib *nib = [UINib nibWithNibName:@"BGWeeklyCustomCellView" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:BGWeeklyHistoryTitleCustomCellIdentifier];
            
            BGWeeklyCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:BGWeeklyHistoryTitleCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            
            
           // NSLog(@"Vayent check [indexPath row]:%d",[indexPath row]);
           // NSLog(@"Vayent check [self.dataList count]:%d",[self.dataList count]);

            
            if (row < [self.dataList count])
            {
                
               
                
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                [cell prepareForReuse];
                cell.BGAfterValueString = [rowData objectForKey:@"A"];
                cell.BGBeforeValueString = [rowData objectForKey:@"B"];
                cell.BGFastingValueString = [rowData objectForKey:@"F"];
                cell.BGNotSpecifiedValueString = [rowData objectForKey:@"U"];
                
                NSString *weekNoString = [rowData objectForKey:@"weekno"];
                weekNoString = [weekNoString substringFromIndex:5];
                weekNoString = [NSString stringWithFormat:@"Week %@",weekNoString];
                cell.weeknoString = weekNoString;
                
                NSString *weekStartString = [rowData objectForKey:@"weekstart"];
                NSString *weekEndString = [rowData objectForKey:@"weekend"];
                weekStartString = [Utility extractDateString:weekStartString oldDateFormatter:@"yyyy-MM-dd"];
                weekEndString = [Utility extractDateString:weekEndString oldDateFormatter:@"yyyy-MM-dd"];
                if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                    weekStartString = [weekStartString substringFromIndex:5];
                    weekEndString = [weekEndString substringFromIndex:5];
                } else {
                    weekStartString = [weekStartString substringToIndex:6];
                    weekEndString = [weekEndString substringToIndex:6];
                }
                NSString *weekDetailString = [NSString stringWithFormat:@"%@ - %@",weekStartString, weekEndString];
                cell.weekDetailString = weekDetailString;
                
                if (([cell.BGFastingValueString floatValue] >= [[alertLevelDict objectForKey:@"hbg"]floatValue]) && ([[alertLevelDict objectForKey:@"hbg"]floatValue] > 0))
                    //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg"]floatValue]))
                    [cell.BGFastingValueLabel setTextColor:[UIColor redColor]];
                else
                    [cell.BGFastingValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
                
                if (([cell.BGBeforeValueString floatValue] >= [[alertLevelDict objectForKey:@"hbg_b"]floatValue])&& ([[alertLevelDict objectForKey:@"hbg_b"]floatValue] > 0))
                    //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg_b"]floatValue]))
                    [cell.BGBeforeValueLabel setTextColor:[UIColor redColor]];
                else
                    [cell.BGBeforeValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
                
                if (([cell.BGAfterValueString floatValue] >= [[alertLevelDict objectForKey:@"hbg_a"]floatValue])&& ([[alertLevelDict objectForKey:@"hbg_a"]floatValue] > 0))
                    //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg_a"]floatValue]))
                    [cell.BGAfterValueLabel setTextColor:[UIColor redColor]];
                else
                    [cell.BGAfterValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];

            }

            if (row%2==1)
            {
                cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
            }
            
            return cell;
            break;
        }
        case 2: {
            static NSString *BGMonthlyHistoryTitleCustomCellIdentifier = @"BGMonthlyHistoryTitleCustomCellIdentifier";
            UINib *nib = [UINib nibWithNibName:@"BGMonthlyCustomCellView" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:BGMonthlyHistoryTitleCustomCellIdentifier];
            
            BGMonthlyCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:BGMonthlyHistoryTitleCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row < [self.dataList count])
            {
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                [cell prepareForReuse];
                cell.BGAfterValueString = [rowData objectForKey:@"A"];
                cell.BGBeforeValueString = [rowData objectForKey:@"B"];
                cell.BGFastingValueString = [rowData objectForKey:@"F"];
                cell.BGNotSpecifiedValueString = [rowData objectForKey:@"U"];
                
                NSString *monthString = [rowData objectForKey:@"month"];
                monthString = [Utility extractDateString:monthString oldDateFormatter:@"yyyy-MM"];
                if ([[Utility getLanguageCode]isEqualToString:@"en"]) {
                    monthString = [monthString substringFromIndex:[monthString rangeOfString:@" "].location];
                } else if ([[Utility getLanguageCode]isEqualToString:@"cn"]) {
                    monthString = [monthString substringToIndex:([monthString rangeOfString:@"月"].location + [monthString rangeOfString:@"月"].length)];
                }
                cell.monthString = monthString;
                
                if (([cell.BGFastingValueString floatValue] >= [[alertLevelDict objectForKey:@"hbg"]floatValue]) && ([[alertLevelDict objectForKey:@"hbg"]floatValue] > 0))
                    //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg"]floatValue]))
                    [cell.BGFastingValueLabel setTextColor:[UIColor redColor]];
                else
                    [cell.BGFastingValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
                
                if (([cell.BGBeforeValueString floatValue] >= [[alertLevelDict objectForKey:@"hbg_b"]floatValue]) && ([[alertLevelDict objectForKey:@"hbg_b"]floatValue] > 0))
                    //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg_b"]floatValue]))
                    [cell.BGBeforeValueLabel setTextColor:[UIColor redColor]];
                else
                    [cell.BGBeforeValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
                
                if (([cell.BGAfterValueString floatValue] >= [[alertLevelDict objectForKey:@"hbg_a"]floatValue]) && ([[alertLevelDict objectForKey:@"hbg_a"]floatValue] > 0))
                    //            ||([cell.BGValueLabel.text floatValue] < [[alertLevelDict objectForKey:@"lbg_a"]floatValue]))
                    [cell.BGAfterValueLabel setTextColor:[UIColor redColor]];
                else
                    [cell.BGAfterValueLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            }
            
            if (row%2==1)
                cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
            else
                cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
            
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (tableView.tag) {
        case 0: {
            count = [self.dataList count]-1;
            if (!iPad) {
                if (count<7) count = 7;
            } else
                if (count<5) count = 5;
            
            break;
        }
        case 1: {
            count = [[DBHelper getAllBGWeekRecord] count];
            break;
        }
        case 2: {
            count = [[DBHelper getAllBGMonthRecord] count];
            break;
        }
        default:
            break;
    }
	return count;
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
    
    if(self.weeklyTableView.hidden&&self.monthlyTableView.hidden){
        
        BGRotateChartViewController *rotateView = [[BGRotateChartViewController alloc]initWithNibName:@"BGRotateChartViewController" bundle:nil];
       
        
//        if (!iPad) {
//            
//            NSLog(@"iphone......");
//             [self.navigationController presentViewController:rotateView animated:YES completion:nil];
//            
//            
//        }else{
        
            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] showRotateView:rotateView];
            
//        }

    }
    
    
    
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

@end
