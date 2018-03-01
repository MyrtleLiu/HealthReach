//
//  CalsHistoryViewController.m
//  mHealth
//
//  Created by smartone_sn3 on 8/29/14.
//
//

#import "CalsHistoryViewController.h"
#import "CalsHistoryCustomCell.h"
#import "CalsHomeViewController.h"
#import "DBHelper.h"
#import "Utility.h"
#import "NSNotificationCenter+MainThread.h"
#import "CalsHistoryDetailViewController.h"
#import "GlobalVariables.h"
#import "CalsRotateViewController.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "TKAlertCenter.h"
#import "syncCalories.h"

@interface CalsHistoryViewController ()

@end

@implementation CalsHistoryViewController

@synthesize datalist;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"CalsHistoryViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"CalsHistoryViewController_iphone4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (iPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        self.view.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
    
//    if ([[GlobalVariables shareInstance].CaloriesAlreadySync isEqualToString:@"0"]) {
//        NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(syncCaloriesData) object:nil];
//        [syncThread start];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishSyncData) name:@"SyncCaloriesFinish" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noDataConnection) name:@"SyncCaloiesNoDataConnection" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unknownErrorCaught) name:@"SyncCaloriesError" object:nil];
//        [self.waitingView setHidden:NO];
//        
//        [GlobalVariables shareInstance].CaloriesAlreadySync = @"1";
//    } else {
//        [self.waitingView setHidden:YES];
//    }
}

- (void)syncCaloriesData:(NSString*)recordindex
{

    NSDictionary *fooddata=[self.datalist objectAtIndex:[recordindex intValue]];
    
    //NSLog(@"%@.....food data",fooddata);
    
    NSString *recordid=[fooddata objectForKey:@"record_id"];
    
    
    //NSLog(@"%@.......record id",recordid);
    
    NSString *fooddetail=[syncCalories getRecordDetailById:recordid];
    
    //NSLog(@"%@.......detail",fooddetail);
 
    [fooddata setValue:fooddetail forKey:@"record_detail"];
    
    //[self.datalist replaceObjectAtIndex:([recordindex intValue]+1) withObject:fooddata];
    
    [DBHelper updateFoodDetail:recordid foodRecordDetail:fooddetail];
    [GlobalVariables shareInstance].foodHistoryDict = fooddata;
    
    [self performSelectorOnMainThread:@selector(goToDetailPage) withObject:nil waitUntilDone:NO];
    
}

- (void)goToDetailPage
{

    self.waitingView.hidden=true;
    
    CalsHistoryDetailViewController *calsHistoryDetailView = [[CalsHistoryDetailViewController alloc]initWithNibName:@"CalsHistoryDetailViewController" bundle:nil];
    [self.navigationController pushViewController:calsHistoryDetailView animated:YES];
    
}

- (void)didFinishSyncData
{
    [self.waitingView setHidden:YES];
    [self reloadViewText];
}

- (void)noDataConnection
{
    [self.waitingView setHidden:YES];
    [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"network_unavailable"]];
}

- (void)unknownErrorCaught
{
    [self.waitingView setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.caloriesHistoryTable setSeparatorStyle:0];
    [self reloadViewText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"JumpToHistoryDetail" object:nil];
    UIDevice *device = [UIDevice currentDevice];
	[device beginGeneratingDeviceOrientationNotifications];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
}

- (void)orientationChanged:(NSNotification *)note  {
    
   
    
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
    
     //NSLog(@"get rotate notication.......%d",o);
    
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
    CalsRotateViewController *rotateView = [[CalsRotateViewController alloc]initWithNibName:@"CalsRotateViewController" bundle:nil];
//    if (!iPad) {
//        
//        [self.navigationController presentViewController:rotateView animated:YES completion:nil];
//        
//        
//    }else{
    
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] showRotateView:rotateView];
        
   // }
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

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) notificationHandler:(NSNotification *) notification
{
    NSNumber *record_id = [notification object];
//    NSDictionary *sendingDict = [notification object];

    [GlobalVariables shareInstance].foodHistoryDict = [self.datalist objectAtIndex:[record_id intValue]];
    CalsHistoryDetailViewController *calsHistoryDetailView = [[CalsHistoryDetailViewController alloc]initWithNibName:@"CalsHistoryDetailViewController" bundle:nil];
    [self.navigationController pushViewController:calsHistoryDetailView animated:YES];
}

- (void)reloadViewText{
    self.datalist = [DBHelper getAllCaloriesRecords];
    [self.caloriesHistoryTable reloadData];
    if ([datalist count]>0) {
        NSDictionary *dataDict = [self.datalist objectAtIndex:0];
        self.newestCalsValueLabel.text = [NSString stringWithFormat:@"%lld",[[dataDict objectForKey:@"totalCalories"] longLongValue]];
        self.dateLabel.text = [Utility extractDateString:[dataDict objectForKey:@"recordTime"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
        self.timeLabel.text = [Utility extractTimeString:[dataDict objectForKey:@"recordTime"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        self.newestCalsValueLabel.text = @"--";
        self.dateLabel.text = @"";
        self.timeLabel.text = @"";
    }
    
    [_calsLabel setText:[Utility getStringByKey:@"home_title_cals"]];
    [_calsLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [_historyLabel setText:[Utility getStringByKey:@"history_title"]];
    [_historyLabel setFont:[UIFont fontWithName:font65 size:18]];
    
    [_newestCalsUnitLabel setText:[Utility getStringByKey:@"total_calories_cal"]];
    [_newestCalsUnitLabel setFont:[UIFont fontWithName:font55 size:13]];
    
    [_newestCalsValueLabel setFont:[UIFont fontWithName:font55 size:42]];
    [_dateLabel setFont:[UIFont fontWithName:font55 size:10]];
    [_timeLabel setFont:[UIFont fontWithName:font55 size:10]];

}

- (IBAction)sendCurrentHistoryDetail:(id)sender {
//    NSDictionary *historyDetail = [self.datalist objectAtIndex:0];
    NSNumber *record_id = [NSNumber numberWithInt:0];
    if (self.dateLabel.text.length > 4){
        
        //tom edit

        NSDictionary *fooddata=[self.datalist objectAtIndex:[record_id intValue]];
        
        NSString *fooddetail=[fooddata objectForKey:@"record_detail"];
        
        
        if (fooddetail==nil||[fooddetail isEqualToString:@""]) {
            
//            self.waitingView.hidden=false;
            
            NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(syncCaloriesData:) object:@"0"];
            [syncThread start];
            
        }else{

        
        [GlobalVariables shareInstance].foodHistoryDict = [self.datalist objectAtIndex:[record_id intValue]];
        CalsHistoryDetailViewController *calsHistoryDetailView = [[CalsHistoryDetailViewController alloc]initWithNibName:@"CalsHistoryDetailViewController" bundle:nil];
        [self.navigationController pushViewController:calsHistoryDetailView animated:YES];
            
        }

    }
}

- (IBAction)toCaloriesHome:(id)sender {
    CalsHomeViewController *calsHomeViewController = [[CalsHomeViewController alloc]initWithNibName:@"CalsHomeViewController" bundle:nil];
    [self.navigationController pushViewController:calsHomeViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.datalist count]-1;
    if (count<7) count = 7;
	return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *cellNib = [UINib nibWithNibName:@"CalsHistoryCustomCell" bundle:nil];
    static NSString *calsCustomCellIdentifier = @"CalsHistoryCustomCellIdentifier";
    [tableView registerNib:cellNib forCellReuseIdentifier:calsCustomCellIdentifier];
    CalsHistoryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:calsCustomCellIdentifier];
    
    NSUInteger row = [indexPath row];
    if ((row <([self.datalist count]-1)) && (row+1<=[self.datalist count]))
    {
        NSDictionary *rowData = [self.datalist objectAtIndex:row + 1];
        cell.calsLabelString = [NSString stringWithFormat:@"%lld",[[rowData objectForKey:@"totalCalories"] longLongValue]];
        cell.dateLabelString = [Utility extractDateString:[rowData objectForKey:@"recordTime"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];

        cell.timeLabelString = [Utility extractTimeString:[rowData objectForKey:@"recordTime"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
        
        cell.foodIdNumber = [NSNumber numberWithInt:(int)row];

    } else {
        cell.calsLabelString = @"";
    }
    
    if (row%2==1)
    {
        cell.contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
    } else {
        cell.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0f];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"!!indexPath:%ld",(long)[indexPath row]);
    if (([indexPath row]+1 > [self.datalist count]-1) || [self.datalist count] ==0) {
        return;
    }
    CalsHistoryCustomCell *cell = (CalsHistoryCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *fooddata=[self.datalist objectAtIndex:([cell.foodId intValue]+1)];

    NSString *fooddetail=[fooddata objectForKey:@"record_detail"];
    
    
    if (fooddetail==nil||[fooddetail isEqualToString:@""]) {
        
//        self.waitingView.hidden=false;
        
        NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(syncCaloriesData:) object:[NSString stringWithFormat:@"%d",([cell.foodId intValue]+1)]];
        
        [syncThread start];
        
    }else{
        
        [GlobalVariables shareInstance].foodHistoryDict = [self.datalist objectAtIndex:([cell.foodId intValue]+1)];
        
        CalsHistoryDetailViewController *calsHistoryDetailView = [[CalsHistoryDetailViewController alloc]initWithNibName:@"CalsHistoryDetailViewController" bundle:nil];
        [self.navigationController pushViewController:calsHistoryDetailView animated:YES];
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
