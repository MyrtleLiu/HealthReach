//
//  HomeViewController.m
//  mHealth
//
//  Created by sngz on 13-12-30.
//
//


#import "HomeViewControllerFirst.h"
#import "BPViewController.h"
#import "RoutePlannerViewController.h"
#import "WalkForHealthViewController.h"
#import "WeightViewController.h"
#import "Utility.h"
#import "syncBP.h"
#import "syncWeight.h"
#import "syncCalories.h"
#import "syncUtility.h"
#import "BGViewController.h"
#import "syncBG.h"
#import "DiaryViewController.h"
#import "CalsHomeViewController.h"
#import "syncDaily.h"
#import "DashBoardViewController.h"

#import "SyncWalking.h"
#import "SyncAverageChart.h"

#import "syncAlertLevel.h"

#import "mHealth_iPhoneAppDelegate.h"
#import "webViewLinkViewController.h"
#import "PedometerViewController.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "LearnMoreFirstViewController.h"
#import "DateWidgetViewController.h"
#import "dasboardFirstViewController.h"

//#import "CalsHistoryDetailViewController.h"

@interface HomeViewControllerFirst ()

@end

@implementation HomeViewControllerFirst

@synthesize BPUIButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"HomeViewController_iphone5First" bundle:nibBundleOrNil];
    }
    else
    {
       
        self = [super initWithNibName:@"HomeViewControllerFirst" bundle:nibBundleOrNil];
    }
    if (self) {
        
        [self reloadViewText];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *sessionid=[defaults objectForKey:@"sessionid"];
//    
//    NSString *login=[defaults objectForKey:@"login"];
//    
//    
//
//    
//    
//    NSLog(@"get..............home................sessionid=%@,login=%@",sessionid,login);
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(syncAllData) object:nil];
//    [thread start];
//
    mHealth_iPhoneAppDelegate *mHealth_delegate =(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication]delegate];
//    mHealth_delegate.session_id = sessionid;
//    mHealth_delegate.login_id = login;
    BOOL result=[mHealth_delegate initDatabase:@"firsttime99999999"];
    if(result)
        NSLog(@"check db %d",true);
    
    
    NSThread *threadForCalories = [[NSThread alloc]initWithTarget:self selector:@selector(syncCalories) object:nil];
    [threadForCalories start];

    
}




- (void)syncCalories {
    //
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [syncBP syncAllBPData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_B_%@",[GlobalVariables shareInstance].login_id]]];
    [syncCalories checkFoodList];
//    [syncCalories syncAllCaloriesData];
}
//
//-(void)syncAllData{
//    
//    [self getMessageCount];
//    
//    [syncAlertLevel syncAlertLevelData];
//    
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//    [syncBP syncAllBPData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_B_%@",[GlobalVariables shareInstance].login_id]]];
//    
//    [syncWeight syncAllWeightData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_W_%@",[GlobalVariables shareInstance].login_id]]];
//    [syncBG syncAllBGData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_G_%@",[GlobalVariables shareInstance].login_id]]];
//    [SyncWalking syncAllWalkingData];
//    
//    [SyncAverageChart syncAverageChartData];
//    
//    [syncDaily getHistoryRecord];
//    
//    
//    
//   
//    
//    
//   
//    
//    [DBHelper deleteCalendarBP];
//    [DBHelper deleteCalendarBG];
//    [DBHelper deleteCalendarECG];
//    [DBHelper deleteCalendarOthers];
//    [DBHelper deleteCalendarWalking];
//    [DBHelper deleteCalendarMedication];
//
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"come to HomeViewControllerFirst");
    
    if (iPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        self.view.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [self reloadViewText];
    
    
    


    
//    int checkRead=[[GlobalVariables shareInstance].messageNotReadCount intValue];
//    NSLog(@"HOME checkRead is %d",checkRead);
//    if(checkRead>0&&checkRead<10){
//        
//        NSString *temp = [[GlobalVariables shareInstance].messageNotReadCount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        _readLabel1.text=temp;
//        _readViewAll.hidden=false;
//        _readView1.hidden=false;
//        _readView2.hidden=true;
//        _readView3.hidden=true;
//        
//    }
//    else if(checkRead>=10&&checkRead<100){
//        NSString *temp = [[GlobalVariables shareInstance].messageNotReadCount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        _readLabel2.text=temp;
//        _readViewAll.hidden=false;
//        _readView1.hidden=true;
//        _readView2.hidden=false;
//        _readView3.hidden=true;
//    }
//    else if(checkRead>=100){
//        NSString *temp = [[GlobalVariables shareInstance].messageNotReadCount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        _readLabel3.text=temp;
//        _readViewAll.hidden=false;
//        _readView1.hidden=true;
//        _readView2.hidden=true;
//        _readView3.hidden=false;
//    }
    
    
    
    BaseNavigationController *navController;
    for (int i=0; i<[navController.viewControllers count]; i++) {
        
        UIViewController *view=[navController.viewControllers objectAtIndex:i];
        NSLog(@"test the page first %d :%@",i,view);
    }


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    //[TUNinePatchCache flushCache];
    
    // Dispose of any resources that can be recreated.
}


-(void)reloadViewText{
    
    
    UIFont *buttonFont = [UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    [_home_title_Dairy setText:[Utility getStringByKey:@"home_title_Dairy"]];
    _home_title_Dairy.font = buttonFont;
    [_home_title_BloodPressure setText:[Utility getStringByKey:@"home_title_BloodPressure"]];
    _home_title_BloodPressure.font = buttonFont;
    [_home_title_ECG setText:[Utility getStringByKey:@"home_title_ECG"]];
    _home_title_ECG.font = buttonFont;
    [_home_title_BloodGlucose setText:[Utility getStringByKey:@"home_title_BloodGlucose"]];
    _home_title_BloodGlucose.font = buttonFont;
    [_home_title_Weight setText:[Utility getStringByKey:@"home_title_Weight"]];
    _home_title_Weight.font = buttonFont;
    [_home_title_Walk setText:[Utility getStringByKey:@"home_title_Walk"]];
    _home_title_Walk.font = buttonFont;
    [_home_title_forHealth setText:[Utility getStringByKey:@"home_title_forHealth"]];
    _home_title_forHealth.font = buttonFont;
    [_home_title_Route setText:[Utility getStringByKey:@"home_title_Route"]];
    _home_title_Route.font = buttonFont;
    [_home_title_Planner setText:[Utility getStringByKey:@"home_title_Planner"]];
    _home_title_Planner.font = buttonFont;
    [_home_title_CaloriesReckoner setText:[Utility getStringByKey:@"home_title_CaloriesReckoner"]];
    _home_title_CaloriesReckoner.font = buttonFont;
    
    
    if ([[Utility getLanguageCode] isEqualToString:@"en"])
    {
        [_login_logo setImage:[UIImage imageNamed:@"01_index_logo.png"]];
    }
    else{
         [_login_logo setImage:[UIImage imageNamed:@"00_logo.png"]];
    }
    
}

- (IBAction)BPJump:(id)sender
{
    BPViewController *bpView = [[BPViewController alloc] initWithNibName:@"BPViewController" bundle:nil];
    [self.navigationController pushViewController:bpView animated:YES ];
}

- (IBAction)toECG:(id)sender {
    /*
    TestingCorePlotViewController *testingCPTview = [[TestingCorePlotViewController alloc]initWithNibName:@"TestingCorePlotViewController" bundle:nil];
    [self.navigationController pushViewController:testingCPTview animated:YES];
    */
    
    //[self showEcgAlertMessage];
    
    
    
    
//    NSString *link;
//    if ([[Utility getLanguageCode] isEqualToString:@"en"])
//    {
//        link=@"http://202.140.96.155/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=ecg_not_support";
//    }
//    else{
//        link=@"http://202.140.96.155/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=ecg_not_support";
//    }
//    
//    
//    webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
//    [intent setLink:link];
//    [self.navigationController pushViewController:intent animated:YES ];

    LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
    [historyView setType:@"ecg"];
    [self.navigationController pushViewController:historyView animated:YES ];
    
}

- (IBAction)toRoutePlanner:(id)sender
{
    RoutePlannerViewController *rpView = [[RoutePlannerViewController alloc] initWithNibName:@"RoutePlannerViewController" bundle:nil];
    
    [self.navigationController pushViewController:rpView animated:YES ];
    
}
-(IBAction)toDiary:(id)sender
{

    DateWidgetViewController *__view=[[DateWidgetViewController alloc]initWithNibName:@"DateWidgetViewController" bundle:nil];
    [self.navigationController pushViewController:__view animated:YES];
    
//    DiaryViewController *__view=[[DiaryViewController alloc]initWithNibName:@"DiaryViewController" bundle:nil];
//    [self.navigationController pushViewController:__view animated:YES];
}
-(IBAction)toAllChar:(id)sender
{
//    DashBoardViewController *_allchar=[[DashBoardViewController alloc]initWithNibName:@"DashBoardViewController" bundle:nil];
//    [self.navigationController pushViewController:_allchar animated:YES];
    
    dasboardFirstViewController *_allchar=[[dasboardFirstViewController alloc]initWithNibName:@"dasboardFirstViewController" bundle:nil];
    [self.navigationController pushViewController:_allchar animated:YES];
}
-(IBAction)toWalkForHealth:(id)sender{

//    NSLog(@"------%@",[GlobalVariables shareInstance].running );
//    if([[GlobalVariables shareInstance].running isEqualToString:@"pedometer"]){
//        PedometerViewController *wfhView = [[PedometerViewController alloc] initWithNibName:@"PedometerViewController" bundle:nil];
//        
//        [self.navigationController pushViewController:wfhView animated:YES ];
//    }
//    else{
        WalkForHealthViewController *wfhView = [[WalkForHealthViewController alloc] initWithNibName:@"WalkForHealthViewController" bundle:nil];
        
        [self.navigationController pushViewController:wfhView animated:YES ];
//    }
    
    
    
   
}

- (IBAction)toWeight:(id)sender {
    WeightViewController *weightView = [[WeightViewController alloc]initWithNibName:@"WeightViewController" bundle:nil];
    
    [self.navigationController pushViewController:weightView animated:YES];
}

- (IBAction)toBG:(id)sender {
    BGViewController *bgView = [[BGViewController alloc]initWithNibName:@"BGViewController" bundle:nil];

    [self.navigationController pushViewController:bgView animated:YES];
}

- (IBAction)toCalories:(id)sender {
    CalsHomeViewController *calsHomeView = [[CalsHomeViewController alloc]initWithNibName:@"CalsHomeViewController" bundle:nil];
    
    [self.navigationController pushViewController:calsHomeView animated:YES];
}




#pragma create alertview
#pragma auto resize in center
#define ALERT_VIEW_WIDTH  260
#define ALERT_VIEW_PADDING  30
#define ALERT_VIEW_LABEL_PADDING_LEFT 30
#define ALERT_VIEW_BUTTON_HEIGHT 50


- (void) showEcgAlertMessage {
    CustomAlertView *alertView = [CustomAlertView new];
    alertView.tag = 10000;
    // Add some custom content to the alert view
    [alertView setContainerView:[self setUpEcgAlertView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:[Utility getStringByKey:@"alert_button_txt"], nil]];
    [alertView setDelegate:self];
    
    [alertView setUseMotionEffects:true];
    // And launch the dialog
    [alertView show];
    
}

-(UIView *)setUpEcgAlertView{
    
    UIView *containerView = [UIView new];
    
    NSString *msgTitle = [Utility getStringByKey:@"alert_title_ecg"];
    NSString *msg1 = [Utility getStringByKey:@"alert_title_ecg_msg1"];
    NSString *msg2 = [Utility getStringByKey:@"alert_title_ecg_msg2"];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20];
    UIFont *msgLightFont = [UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:18];
    UIFont *msgFont = [UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20];
    
    CGFloat msgWidth = ALERT_VIEW_WIDTH - 2 * ALERT_VIEW_LABEL_PADDING_LEFT;
    CGFloat totalHeight = ALERT_VIEW_PADDING;  // set padding top
    CGFloat msgDivPadding = 5.0f; //
    
    //set Title
    CGFloat titleHeight = [Utility calculateHeightForString:msgTitle usingWidth:ALERT_VIEW_WIDTH usingFont:titleFont] + msgDivPadding;
    
    if ([[Utility getLanguageCode] isEqualToString:@"en"]) {
        UILabel *titleLabel =  [UILabel new];
        [titleLabel setFrame:CGRectMake(0, totalHeight, ALERT_VIEW_WIDTH, titleHeight)];
        titleLabel.text = msgTitle;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor orangeColor];
        titleLabel.font = titleFont;
        titleLabel.numberOfLines  = 0;
        [containerView addSubview:titleLabel];
        totalHeight += titleHeight;
        
        CGFloat subTitleHeight = [Utility calculateHeightForString:msg1 usingWidth:msgWidth usingFont:msgLightFont] + msgDivPadding;
        
        UILabel *subtitleLabel =  [UILabel new];
        [subtitleLabel setFrame:CGRectMake(ALERT_VIEW_LABEL_PADDING_LEFT, totalHeight, msgWidth, subTitleHeight)];
        subtitleLabel.text = msg1;
        subtitleLabel.textAlignment = NSTextAlignmentCenter;
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.textColor = [UIColor blackColor];
        subtitleLabel.font = msgLightFont;
        subtitleLabel.numberOfLines  = 0;
        [containerView addSubview:subtitleLabel];
        totalHeight += (subTitleHeight);
    }else{
        
        CGFloat titleWidth = [Utility calculateWidthForString:msgTitle usingFont:titleFont];
        CGFloat subtitleWidth = [Utility calculateWidthForString:msg1 usingFont:msgLightFont];
        UILabel *titleLabel =  [UILabel new];
        CGFloat titlePadding = (ALERT_VIEW_WIDTH - titleWidth - subtitleWidth)/2;
        [titleLabel setFrame:CGRectMake(titlePadding, totalHeight, titleWidth, titleHeight)];
        titleLabel.text = msgTitle;
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor orangeColor];
        titleLabel.font = titleFont;
        titleLabel.numberOfLines  = 0;
        [containerView addSubview:titleLabel];
        
        
        UILabel *subtitleLabel =  [UILabel new];
        [subtitleLabel setFrame:CGRectMake(titlePadding +  titleWidth, totalHeight, subtitleWidth, titleHeight)];
        subtitleLabel.text = msg1;
        subtitleLabel.textAlignment = NSTextAlignmentLeft;
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.textColor = [UIColor blackColor];
        subtitleLabel.font = msgLightFont;
        subtitleLabel.numberOfLines  = 0;
        [containerView addSubview:subtitleLabel];
        totalHeight += (titleHeight );
    }
    
    //set msg
    CGFloat textHeight = [Utility calculateHeightForString:msg2 usingWidth:msgWidth usingFont:msgFont] +msgDivPadding;
    UILabel *msgLabel = [UILabel new];
    [msgLabel setFrame:CGRectMake(ALERT_VIEW_LABEL_PADDING_LEFT, totalHeight + msgDivPadding, msgWidth, textHeight)];
    msgLabel.text = msg2;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.backgroundColor = [UIColor clearColor];
    msgLabel.textColor = [UIColor blackColor];
    msgLabel.font = msgFont;
    msgLabel.numberOfLines = 0;
    [containerView addSubview:msgLabel];
    
    totalHeight += textHeight;
    
    //set button height / button padding bottom
    totalHeight += ( ALERT_VIEW_PADDING  + ALERT_VIEW_BUTTON_HEIGHT );
    
    //auto resize container frame here
    CGRect containerFrame = CGRectMake(0, 0, ALERT_VIEW_WIDTH, totalHeight);
    
    [containerView setFrame:containerFrame];
    
    return containerView;
}


#pragma CustomAlertView button handler

- (void)dialogButtonTouchUpInside: (CustomAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    
    //NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
    if ([alertView tag]== 10000) {
        // click on ecg alertview here
    }
    
    [alertView close];

}


//-(void)getMessageCount{
//    NSString *session_id = [GlobalVariables shareInstance].session_id;
//    NSString *login_id = [GlobalVariables shareInstance].login_id;
//
//    NSString *urlStr = [[NSString alloc]init];
//    urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
//    urlStr = [urlStr stringByAppendingString:@"healthMessage?login="];
//    urlStr = [urlStr stringByAppendingString:login_id];
//    urlStr = [urlStr stringByAppendingString:@"&action=BC"];
//    urlStr = [urlStr stringByAppendingString:@"&sessionid="];
//    urlStr = [urlStr stringByAppendingString:session_id];
//    NSLog(@"rt url:%@",urlStr);
//    
//    NSURL *request_url = [NSURL URLWithString:urlStr];
//    
//   [NSData dataWithContentsOfURL:request_url];
//    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//
//    
//    if (xmlData) {
//        [syncUtility XMLHasError:xmlData];
//        static NSString *countFlag = @"//response";
//        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//        
//        NSArray *responseArray = [doc nodesForXPath:countFlag error:nil];
//        for (DDXMLElement *obj in responseArray){
//            DDXMLElement *statusElement = [obj elementForName:@"count"];
//         
//                NSString *messageNotReadCount= [statusElement stringValue];
//                NSLog(@"111-000111- %@",messageNotReadCount);
//            
//            [GlobalVariables shareInstance].messageNotReadCount=messageNotReadCount;
//            
//        }
//        
//        
//        int checkRead=[[GlobalVariables shareInstance].messageNotReadCount intValue];
//        if(checkRead>0&&checkRead<10){
//            _readLabel1.text=[GlobalVariables shareInstance].messageNotReadCount;
//            _readViewAll.hidden=false;
//            _readView1.hidden=false;
//            _readView2.hidden=true;
//            _readView3.hidden=true;
//            
//        }
//        else if(checkRead>=10&&checkRead<100){
//            _readLabel2.text=[GlobalVariables shareInstance].messageNotReadCount;
//            _readViewAll.hidden=false;
//            _readView1.hidden=true;
//            _readView2.hidden=false;
//            _readView3.hidden=true;
//        }
//        else if(checkRead>=100){
//            _readLabel3.text=[GlobalVariables shareInstance].messageNotReadCount;
//            _readViewAll.hidden=false;
//            _readView1.hidden=true;
//            _readView2.hidden=true;
//            _readView3.hidden=false;
//        }
//
//        
//        
//        
//        
//        
//        
//        
//
//    }
//}


@end
