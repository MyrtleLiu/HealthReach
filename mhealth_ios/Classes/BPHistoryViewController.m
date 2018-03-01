//
//  BPHistoryViewController.m
//  mHealth
//
//  Created by gz dev team on 14年1月17日.
//
//


#import "BPHistoryViewController.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "BloodPressure.h"
#import "Constants.h"
#import "Utility.h"
#import "DBHelper.h"
#import "BPRotateChartViewController.h"
#import "WeeklyCustomCellView.h"
#import "MonthlyCustomCellView.h"
#import "GlobalVariables.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "syncBP.h"
#import "TKAlertCenter.h"

@interface BPHistoryViewController ()

@property (nonatomic, strong) NSMutableArray *menuList;

@end

@implementation BPHistoryViewController

@synthesize timeLabel;
@synthesize dateLabel;
@synthesize sysLabel;
@synthesize diaLabel;
@synthesize pulValueLabel;
@synthesize monthlyAverageLabel_1;
@synthesize monthlyAverageLabel_2;
@synthesize weeklyAverageLabel_1;
@synthesize weeklyAverageLabel_2;
@synthesize dataList;

#pragma mark -
#pragma mark Main interface Setting up

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"BPHistoryViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"BPHistoryViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    
     [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setAverageBPView:self];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    if (iPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        self.view.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
    
//    if ([[GlobalVariables shareInstance].BPAlreadySync isEqualToString:@"0"]) {
//        NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(syncBPData) object:nil];
//        [syncThread start];
    

    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait) {
//        
//        NSLog(@"UIInterfaceOrientationPortrait..............bp");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeLeft..............bp");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeRight..............bp");
//    }
//}
}
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataList = [DBHelper getBPHistoryRecord];
    [self reloadViewText];
    [self updateColumn];
    
    [self.HistoryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.weeklyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.monthlyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.weeklyTableView setHidden:TRUE];
    [self.monthlyTableView setHidden:TRUE];
    [self.HistoryTableView setTag:0];
    [self.weeklyTableView setTag:1];
    [self.monthlyTableView setTag:2];
    
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)syncBPData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [syncBP syncAllBPData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_B_%@",[GlobalVariables shareInstance].login_id]]];
}

- (void)didFinishSyncData
{
//    [self.WaitingView setHidden:YES];
    self.dataList = [DBHelper getBPHistoryRecord];
    [self updateColumn];
    [self performSelectorOnMainThread:@selector(refreshMonthlyTable) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(refreshMeasurementTable) withObject:nil waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(refreshWeeklyTable) withObject:nil waitUntilDone:NO];
}

- (void)noDataConnection
{
//    [self.WaitingView setHidden:YES];
    [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"network_unavailable"]];
}

- (void)unknownErrorCaught
{
//    [self.WaitingView setHidden:YES];
}

- (void)reloadViewText{
    [self.bloodpressureLabel setText:[Utility getStringByKey:@"bloodpressure"]];
    [self.bloodpressureLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTP ro-Md" size:18]];
    
    [self.historyLabel setText:[Utility getStringByKey:@"history_data"]];
    [self.historyLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
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
    
    [self.sysLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:35]];
    [self.slashLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:35]];
    [self.diaLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:35]];
    [self.pulValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:35]];
    [self.bpUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:13]];
    [self.pulUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:13]];
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    
}

-(void)updateColumn{
    BloodPressure *newestBP = [DBHelper getNewestBPRecord];
    if ([newestBP sys].length>0) {
        [sysLabel setText:[newestBP sys]];
        [diaLabel setText:[newestBP dia]];
        [pulValueLabel setText:[newestBP heartrate]];
        
        dateLabel.text = [Utility extractDateString:[newestBP timeStr] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
        timeLabel.text = [Utility extractTimeString:[newestBP timeStr] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    }
}

- (IBAction)clickLeftButton:(id)sender {
    BPViewController *bpView = [[BPViewController alloc]initWithNibName:@"BPViewController" bundle:nil];
    [self.navigationController pushViewController:bpView animated:YES];
}

#pragma mark -
#pragma mark Three table setting up

- (IBAction)weeklyAverageTap:(id)sender {
    NSLog(@"come here to 4");

   
    
    
    
    
    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenAverageBPLoad];
    NSLog(@"checkLoadView:%d",checkLoadView);
    if(checkLoadView){
        _WaitingView.hidden=true;
        
        self.dataList = [DBHelper getAllBPWeekRecord];
        [self performSelectorOnMainThread:@selector(refreshWeeklyTable) withObject:nil waitUntilDone:NO];
        [self.weeklyTableView setHidden:FALSE];
        [self.monthlyTableView setHidden:TRUE];
        [self.HistoryTableView setHidden:TRUE];
        [self.dailyView setBackgroundColor:[UIColor colorWithRed:119/255.0f green:31/255.0f blue:33/255.0f alpha:1.0f]];
        [self.monthlyView setBackgroundColor:[UIColor colorWithRed:119/255.0f green:31/255.0f blue:33/255.0f alpha:1.0f]];
        [self.weeklyView setBackgroundColor:[UIColor colorWithRed:191/255.0f green:70/255.0f blue:69/255.0f alpha:1.0f]];
        [self.leftPlate setBackgroundColor:[UIColor colorWithRed:215/255.0f green:135/255.0f blue:135/255.0f alpha:1.0f]];
        [self.rightPlate setBackgroundColor:[UIColor colorWithRed:215/255.0f green:135/255.0f blue:135/255.0f alpha:1.0f]];
    }
    else{
        
        _WaitingView.hidden=false;
        
        
        
    }

    
    
    
    
    
}


//-(void)refreshWeeklyData{
//    self.dataList = [DBHelper getAllBPWeekRecord];
//    [self performSelectorOnMainThread:@selector(refreshWeeklyTable) withObject:nil waitUntilDone:NO];
//    [self.weeklyTableView setHidden:FALSE];
//    [self.monthlyTableView setHidden:TRUE];
//    [self.HistoryTableView setHidden:TRUE];
//    [self.dailyView setBackgroundColor:[UIColor colorWithRed:119/255.0f green:31/255.0f blue:33/255.0f alpha:1.0f]];
//    [self.monthlyView setBackgroundColor:[UIColor colorWithRed:119/255.0f green:31/255.0f blue:33/255.0f alpha:1.0f]];
//    [self.weeklyView setBackgroundColor:[UIColor colorWithRed:191/255.0f green:70/255.0f blue:69/255.0f alpha:1.0f]];
//    [self.leftPlate setBackgroundColor:[UIColor colorWithRed:215/255.0f green:135/255.0f blue:135/255.0f alpha:1.0f]];
//    [self.rightPlate setBackgroundColor:[UIColor colorWithRed:215/255.0f green:135/255.0f blue:135/255.0f alpha:1.0f]];
//
//}

- (IBAction)measurementTap:(id)sender {
    
    [self.weeklyTableView setHidden:TRUE];
    [self.monthlyTableView setHidden:TRUE];
    [self.HistoryTableView setHidden:FALSE];
    self.dataList = [DBHelper getBPHistoryRecord];
    [self performSelectorOnMainThread:@selector(refreshMeasurementTable) withObject:nil waitUntilDone:NO];
    [self.weeklyView setBackgroundColor:[UIColor colorWithRed:119/255.0f green:31/255.0f blue:33/255.0f alpha:1.0f]];
    [self.monthlyView setBackgroundColor:[UIColor colorWithRed:119/255.0f green:31/255.0f blue:33/255.0f alpha:1.0f]];
    [self.dailyView setBackgroundColor:[UIColor colorWithRed:191/255.0f green:70/255.0f blue:69/255.0f alpha:1.0f]];
    [self.leftPlate setBackgroundColor:[UIColor colorWithRed:215/255.0f green:135/255.0f blue:135/255.0f alpha:1.0f]];
    [self.rightPlate setBackgroundColor:[UIColor colorWithRed:72/255.0f green:18/255.0f blue:18/255.0f alpha:1.0f]];
}

- (IBAction)monthlyAverageTap:(id)sender {
    
    
    
    
    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenAverageBPLoad];
    NSLog(@"checkLoadView:%d",checkLoadView);
    if(checkLoadView){
        _WaitingView.hidden=true;
        
        self.dataList = [DBHelper getAllBPMonthRecord];
        NSLog(@"!!All month:%@",self.dataList);
        [self performSelectorOnMainThread:@selector(refreshMonthlyTable) withObject:nil waitUntilDone:NO];
        [self.weeklyTableView setHidden:TRUE];
        [self.monthlyTableView setHidden:FALSE];
        [self.HistoryTableView setHidden:TRUE];
        [self.dailyView setBackgroundColor:[UIColor colorWithRed:119/255.0f green:31/255.0f blue:33/255.0f alpha:1.0f]];
        [self.weeklyView setBackgroundColor:[UIColor colorWithRed:119/255.0f green:31/255.0f blue:33/255.0f alpha:1.0f]];
        [self.monthlyView setBackgroundColor:[UIColor colorWithRed:191/255.0f green:70/255.0f blue:69/255.0f alpha:1.0f]];
        [self.leftPlate setBackgroundColor:[UIColor colorWithRed:72/255.0f green:18/255.0f blue:18/255.0f alpha:1.0f]];
        [self.rightPlate setBackgroundColor:[UIColor colorWithRed:215/255.0f green:135/255.0f blue:135/255.0f alpha:1.0f]];

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
    [self.HistoryTableView reloadData];
}

- (void)refreshMonthlyTable
{
    [self.monthlyTableView reloadData];
}

#pragma mark -
#pragma mark Table column setting up

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch (tableView.tag) {
        case 0: {
            count = [self.dataList count];
            if (!iPad) {
                if (count<7) count = 7;
            } else
                if (count<5) count = 5;
            
            break;
        }
        case 1: {
            count = [[DBHelper getAllBPWeekRecord] count];
            if (!iPad)
                if (count<9) count = 9;
            break;
        }
        case 2: {
            count = [[DBHelper getAllBPMonthRecord] count];
            if (!iPad)
                if (count<9) count = 9;
            
            break;
        }
        default:
            break;
    }
	return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (tableView.tag) {
            // tableView.tag 0:Daily 1:weekly 2:monthly
        case 0: {
            static NSString *HistoryTitleCustomCellIdentifier = @"HistoryTitleCustomCellIdentifier";
            UINib *nib = [UINib nibWithNibName:@"HistoryTitleCustomCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:HistoryTitleCustomCellIdentifier];
            
            HistoryTitleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryTitleCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row<[self.dataList count])
            {
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                
                cell.timeString = [Utility extractTimeString:[rowData objectForKey:@"time"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
                cell.dateString = [Utility extractDateString:[rowData objectForKey:@"time"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
                cell.SYSString = [rowData objectForKey:@"sys"];
                cell.DIAString = [rowData objectForKey:@"dia"];
                cell.PULString = [rowData objectForKey:@"pul"];
            } else {
                cell.slashString = @"";
            }
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSMutableDictionary *alertLevelDict = [defaults objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
            
            if (([cell.SYSLabel.text intValue] >= [[alertLevelDict objectForKey:@"lsystolic"] intValue]) && ([[alertLevelDict objectForKey:@"lsystolic"] intValue] > 0))
                [cell.SYSLabel setTextColor:[UIColor redColor]];
            else
                [cell.SYSLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
            if (([cell.DIALabel.text intValue]>=[[alertLevelDict objectForKey:@"ldiastolic"]intValue]) && ([[alertLevelDict objectForKey:@"ldiastolic"] intValue] > 0))
                [cell.DIALabel setTextColor:[UIColor redColor]];
            else
                [cell.DIALabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
            if (([cell.PULLabel.text intValue]>=[[alertLevelDict objectForKey:@"bp_hheartrate"]intValue]) && ([[alertLevelDict objectForKey:@"bp_hheartrate"] intValue] > 0))
                [cell.PULLabel setTextColor:[UIColor redColor]];
            else
                [cell.PULLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
            if (row%2==1)
            {
                cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
            }
            
            return cell;
            
            break;
        }
        case 1: {
            static NSString *WeeklyHistoryTitleCustomCellIdentifier = @"BPHistoryWeeklyTitleCustomCellIdentifier";
            UINib *nib = [UINib nibWithNibName:@"WeeklyCustomCellView" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:WeeklyHistoryTitleCustomCellIdentifier];
            
            WeeklyCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:WeeklyHistoryTitleCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row < [self.dataList count])
            {
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                [cell prepareForReuse];
                cell.SYSString = [rowData objectForKey:@"sys"];
                cell.DIAString = [rowData objectForKey:@"dia"];
                cell.PULString = [rowData objectForKey:@"rate"];
                
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
            }
            
            if (row >= [self.dataList count])
            {
                cell.SYSString = @"-1";
            }
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSMutableDictionary *alertLevelDict = [defaults objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
            
            if (([cell.SYSLabel.text intValue] >= [[alertLevelDict objectForKey:@"lsystolic"] intValue]) && ([[alertLevelDict objectForKey:@"lsystolic"] intValue] > 0))
                [cell.SYSLabel setTextColor:[UIColor redColor]];
            else
                [cell.SYSLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
            if (([cell.DIALabel.text intValue]>=[[alertLevelDict objectForKey:@"ldiastolic"]intValue]) && ([[alertLevelDict objectForKey:@"ldiastolic"] intValue] > 0))
                [cell.DIALabel setTextColor:[UIColor redColor]];
            else
                [cell.DIALabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
            if (([cell.PULLabel.text intValue]>=[[alertLevelDict objectForKey:@"bp_hheartrate"]intValue]) && ([[alertLevelDict objectForKey:@"bp_hheartrate"] intValue] > 0))
                [cell.PULLabel setTextColor:[UIColor redColor]];
            else
                [cell.PULLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
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
            static NSString *MonthlyHistoryTitleCustomCellIdentifier = @"BPHistoryMonthlyTitleCustomCellIdentifier";
            UINib *nib = [UINib nibWithNibName:@"MonthlyCustomCellView" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:MonthlyHistoryTitleCustomCellIdentifier];
            
            MonthlyCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:MonthlyHistoryTitleCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row < [self.dataList count])
            {
                NSDictionary *rowData = [self.dataList objectAtIndex:row];
                cell.SYSString = [rowData objectForKey:@"sys"];
                cell.DIAString = [rowData objectForKey:@"dia"];
                cell.PULString = [rowData objectForKey:@"rate"];
                NSString *monthString = [rowData objectForKey:@"month"];
                monthString = [Utility extractDateString:monthString oldDateFormatter:@"yyyy-MM"];
                if ([[Utility getLanguageCode]isEqualToString:@"en"]) {
                    monthString = [monthString substringFromIndex:[monthString rangeOfString:@" "].location];
                } else if ([[Utility getLanguageCode]isEqualToString:@"cn"]) {
                    monthString = [monthString substringToIndex:([monthString rangeOfString:@"月"].location + [monthString rangeOfString:@"月"].length)];
                }
                cell.monthString = monthString;
            }
            
            if (row >= [self.dataList count])
            {
                cell.SYSString = @"-1";
            }
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSMutableDictionary *alertLevelDict = [defaults objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
            
            if (([cell.SYSLabel.text intValue] >= [[alertLevelDict objectForKey:@"lsystolic"] intValue]) && ([[alertLevelDict objectForKey:@"lsystolic"] intValue] > 0))
                [cell.SYSLabel setTextColor:[UIColor redColor]];
            else
                [cell.SYSLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
            if (([cell.DIALabel.text intValue]>=[[alertLevelDict objectForKey:@"ldiastolic"]intValue]) && ([[alertLevelDict objectForKey:@"ldiastolic"] intValue] > 0))
                [cell.DIALabel setTextColor:[UIColor redColor]];
            else
                [cell.DIALabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
            if (([cell.PULLabel.text intValue]>=[[alertLevelDict objectForKey:@"bp_hheartrate"]intValue]) && ([[alertLevelDict objectForKey:@"bp_hheartrate"] intValue] > 0))
                [cell.PULLabel setTextColor:[UIColor redColor]];
            else
                [cell.PULLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
            
            if (row%2==1)
            {
                cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
            } else {
                cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
            }
            
            return cell;
            break;
        }
            
        default:
            break;
    }
    return nil;
}

#pragma mark -
#pragma mark jump to ChartView when rotate

- (void)orientationChanged:(NSNotification *)note  {
    UIDevice * device = note.object;
    UIDeviceOrientation o = device.orientation;//[[UIDevice currentDevice] orientation];
	switch (o) {
		case UIDeviceOrientationLandscapeLeft:
        
            [self rotateView];
            break;
        case UIDeviceOrientationLandscapeRight:
        
            //[self rotateView];
            break;
            
		default:
			break;
	}
}

- (void)rotateView {
    
    if(self.weeklyTableView.hidden&&self.monthlyTableView.hidden){
        
        BPRotateChartViewController *rotateView = [[BPRotateChartViewController alloc]initWithNibName:@"BPRotateChartViewController" bundle:nil];
        
        
//        if (!iPad) {
//            
//            [self.navigationController presentViewController:rotateView animated:YES completion:nil];
//            
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


- (IBAction)hiddenView:(id)sender{
//     [self.WaitingView setHidden:YES];
    
}


@end
