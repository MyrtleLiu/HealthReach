

#import "mHealth_iPhoneAppDelegate.h"
#import "LoginViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "DBHelper.h"
#import "MenuViewController.h"
#import "UserInfoViewController.h"
#import "GlobalVariables.h"
#import "DayChickViewController.h"
#import "FirstTimeSlideViewController.h"
#import "MedicationAlapk.h"
#import "HomeViewControllerFirst.h"
#import "PedometerViewController.h"
#import "TrainingPedometerViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "NoNetWorkViewController.h"
#import "NotiMR_ListViewController.h"
#import "NotiInForMationViewController.h"
#import "MR_ListViewController.h"
#import "syncUtility.h"
#import "GlobalVariables.h"

#import "NSNotificationCenter+MainThread.h"


@implementation mHealth_iPhoneAppDelegate

@synthesize session_id;
@synthesize login_id;

@synthesize window;
@synthesize navController;

@synthesize dbQueue;

@synthesize revealController;


-(void)applicationDidFinishLaunching:(UIApplication *)application
{
    
    NSLog(@"%d.........%@",[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue],[[UIDevice currentDevice] systemVersion]);

    
    UIApplication* app= [UIApplication sharedApplication];
    
    if( [app respondsToSelector:@selector(registerUserNotificationSettings:)] ){
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
    } else {
//        NSUInteger notifTypes = UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeNewsstandContentAvailability;
//        [app registerForRemoteNotificationTypes:notifTypes];
    }
    
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {

        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }else{
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//         UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }

    
    [GlobalVariables shareInstance].BGAlreadySync = @"0";
    [GlobalVariables shareInstance].BPAlreadySync = @"0";
    [GlobalVariables shareInstance].WeightAlreadySync = @"0";
    [GlobalVariables shareInstance].CaloriesAlreadySync = @"0";
    
    [GMSServices provideAPIKey:@"AIzaSyDXaJFH3U7g0WOp6EZyZi9Dxk9XpVHWZlI"];
    
    //LoginViewController *loginView=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    //[self.navController pushViewController:loginView animated:YES];
    
    
    //1
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL helpCheck=[defaults boolForKey:@"checkFirstTimeSlide"];
    BOOL logincheck=[defaults boolForKey:@"reallogin"];

    if(logincheck){
        isrunning=false;
        isHiddenWalkLoad=false;
        isHiddenDashBoardLoad=false;
        isHiddenAverageBPLoad=false;
        isHiddenAverageBGLoad=false;
        isHiddenAverageWeightLoad=false;
        if(self.isNetworkEnabled){
            LoginViewController *loginView=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navController pushViewController:loginView animated:YES];

        }
        else{
            NoNetWorkViewController *loginView2=[[NoNetWorkViewController alloc] initWithNibName:@"NoNetWorkViewController" bundle:nil];
            [loginView2 setLink:@"login"];
            [self.navController pushViewController:loginView2 animated:YES];
        }
        
        
        
//                    HomeViewControllerFirst *loginView=[[HomeViewControllerFirst alloc] initWithNibName:@"HomeViewControllerFirst" bundle:nil];
//                    [self.navController pushViewController:loginView animated:YES];
    }
    else{
//        NSLog(@"test the helpCheck : %hhd",helpCheck);
        if(helpCheck){
            HomeViewControllerFirst *loginView=[[HomeViewControllerFirst alloc] initWithNibName:@"HomeViewControllerFirst" bundle:nil];
            [self.navController pushViewController:loginView animated:YES];
        }
        else{
            FirstTimeSlideViewController *loginView=[[FirstTimeSlideViewController alloc] initWithNibName:@"FirstTimeSlideViewController" bundle:nil];
            [self.navController pushViewController:loginView animated:YES];
            
        }
//        FirstTimeSlideViewController *loginView=[[FirstTimeSlideViewController alloc] initWithNibName:@"FirstTimeSlideViewController" bundle:nil];
//        [self.navController pushViewController:loginView animated:YES];
//

        


    }
    
       //
    //    if ( [self.window respondsToSelector:@selector(setRootViewController:)] ) {
    //        self.window.rootViewController = self.navController;
    //        NSLog(@"set root...");
    //    }
    //    else {
    //        [self.window addSubview:self.navController.view];
    //    }
    //    [self.window makeKeyAndVisible];
    
    
    //    HomeViewController *homeView=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    //    [self.navController pushViewController:homeView animated:YES];
    
    MenuViewController *menuView=[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    self.revealController = [PKRevealController revealControllerWithFrontViewController:self.navController
                                                                     leftViewController:nil
                                                                    rightViewController:menuView];
    self.revealController.delegate = self;
    self.revealController.animationDuration = 0.25;
    self.revealController.recognizesPanningOnFrontView=false;
    [self.revealController setMinimumWidth:210 maximumWidth:210 forViewController:menuView];
    
    //[self.revealController setMinimumWidth:110 maximumWidth:110 forViewController:self.navController];
    
    if ( [self.window respondsToSelector:@selector(setRootViewController:)] ) {
        //self.window.rootViewController = self.navController;
        self.window.rootViewController = self.revealController;
        
    }
    else {
        //[self.window addSubview:self.n/Users/yiujolly/Desktop/项目一一一/mhealth/Classes/mHealth_iPhoneAppDelegate.mavController.view];
        [self.window addSubview:self.revealController.view];
    }
    //NSLog(@"set up 1.......");
    [self setShowNotification:YES];
    //NSLog(@"set up 2.......");
    [self.window makeKeyAndVisible];

    
//    LoginViewController *loginView=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    [self.navController pushViewController:loginView animated:YES];

    
   

    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(func) name:@"callAppDelegate" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(funcDasboard) name:@"callAppDelegateDasboard" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(funcAverageBP) name:@"callAppDelegateAverageBP" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(funcAverageBG) name:@"callAppDelegateAverageBG" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(funcAverageWeight) name:@"callAppDelegateAverageWeight" object:nil];
    

    

    

    
    
    
    
    
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification
{
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"mHealth" message:notification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    // [alert show];
    // 图标上的数字减1
    
    application.applicationIconBadgeNumber = 0;
    NSLog(@"application.time===%@",notification.fireDate);
    NSLog(@"[GlobalVariables shareInstance].session_id=====%@",[GlobalVariables shareInstance].session_id);
    float  idlength=[[GlobalVariables shareInstance].session_id length];
    //NSLog(@"idlenggt======================%f-------------",idlength);
    
    BOOL isGameNotification=false;
    
    @try {
        if ([[notification.userInfo objectForKey:@"title"]isEqualToString:@"cw1"]||[[notification.userInfo objectForKey:@"title"]isEqualToString:@"cw2"]||[[notification.userInfo objectForKey:@"title"]isEqualToString:@"tp1"]||[[notification.userInfo objectForKey:@"title"]isEqualToString:@"tp2"]||[[notification.userInfo objectForKey:@"title"]isEqualToString:@"tp3"]||[[notification.userInfo objectForKey:@"title"]isEqualToString:@"tp4"])
        {
        
            isGameNotification=true;
        
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    if (isGameNotification)
    {
        
    }
    else
    {



        
        
        if ([[notification.userInfo objectForKey:@"title"]isEqualToString:@"Blood Pressure"]||[[notification.userInfo objectForKey:@"title"]isEqualToString:@"血壓"])
        {
            NSLog(@"notification==%@",notification.alertBody);
            [application cancelLocalNotification:notification];
            
            NotiMR_ListViewController * mrList=[[NotiMR_ListViewController alloc] initWithNibName:@"NotiMR_ListViewController" bundle:nil];
              NSLog(@"Blood Pressure-------------------------");
            
            NSLog(@"set up 3.......");
            [self setShowNotification:YES];
            NSLog(@"set up 4.......");
            mrList.str1=notification.alertBody;
            mrList.diction=[[NSDictionary alloc]initWithDictionary:notification.userInfo];
            if (idlength<8)
            {
                self.window.rootViewController=mrList;
            }
            else
            {
                [self.navController pushViewController:mrList animated:YES];
            }
            
            
        }
        else if([[notification.userInfo objectForKey:@"title"] isEqualToString:@"ECG"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"心電圖"])
        {
            NSLog(@"notification==%@",notification.alertBody);
            [application cancelLocalNotification:notification];
              NSLog(@"ECG-------------------------");
            
            NotiMR_ListViewController * mrList=[[NotiMR_ListViewController alloc] initWithNibName:@"NotiMR_ListViewController" bundle:nil];
            NSLog(@"set up 3.......");
            [self setShowNotification:YES];
            NSLog(@"set up 4.......");
            mrList.str1=notification.alertBody;
          
            mrList.diction=[[NSDictionary alloc]initWithDictionary:notification.userInfo];
            if (idlength<8)
            {
                self.window.rootViewController=mrList;
            }
            else
            {
                [self.navController pushViewController:mrList animated:YES];
            }
            
            
        }
        
        
        else if([[notification.userInfo objectForKey:@"title"] isEqualToString:@"Blood Glucose"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"血糖"])
        {
            
              NSLog(@"Blood Glucose------------------------");
            NSLog(@"notification==%@",notification.alertBody);
            [application cancelLocalNotification:notification];
            NotiMR_ListViewController * mrList=[[NotiMR_ListViewController alloc] initWithNibName:@"NotiMR_ListViewController" bundle:nil];
            NSLog(@"set up 3.......");
            [self setShowNotification:YES];
            NSLog(@"set up 4.......");
            mrList.str1=notification.alertBody;
           
            mrList.diction=[[NSDictionary alloc]initWithDictionary:notification.userInfo];
            if (idlength<8)
            {
                self.window.rootViewController=mrList;
            }
            else
            {
                [self.navController pushViewController:mrList animated:YES];
            }
        }
        else if ([[notification.userInfo objectForKey:@"title"] isEqualToString:@"Exercise"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"運動"] )
        {
              NSLog(@"Exercise-------------------------");
            NSLog(@"notification==%@",notification.alertBody);
            [application cancelLocalNotification:notification];
            NotiInForMationViewController * mrList=[[ NotiInForMationViewController alloc] initWithNibName:@"NotiInForMationViewController" bundle:nil];
            
            NSLog(@"set up 3.......");
            [self setShowNotification:YES];
            NSLog(@"set up 4.......");
            mrList.alaicBody=notification.alertBody;
            
            mrList.medicationDic=[[NSDictionary alloc]initWithDictionary:notification.userInfo];
            self.window.rootViewController=mrList;
            
        }
        else if([[notification.userInfo objectForKey:@"title"]isEqualToString:@"Others"])
        {
            
            
            
            //
            NSLog(@"Others-------------------------");
            
            NSLog(@"notification==%@",notification.alertBody);
            
            //不推送 取消推送
            [application cancelLocalNotification:notification];
            NotiInForMationViewController *_information=[[NotiInForMationViewController alloc]initWithNibName:@"NotiInForMationViewController" bundle:nil];
            
            NSLog(@"set up 3.......");
            [self setShowNotification:YES];
            NSLog(@"set up 4.......");
            
            _information.alaicBody=notification.alertBody;
                       _information.medicationDic=[[NSDictionary alloc]initWithDictionary:notification.userInfo];
            self.window.rootViewController=_information;
            
            
            
            
        }
        else if([[notification.userInfo objectForKey:@"title"]isEqualToString:@"Medication"])
        {
            MedicationAlapk * medication=[[MedicationAlapk alloc ]initWithNibName:@"MedicationAlapk" bundle:nil];
              NSLog(@"Medication-------------------------");
            NSLog(@"notification==%@",notification.alertBody);
            [application cancelLocalNotification:notification];
            
            NSLog(@"set up 3.......");
            [self setShowNotification:YES];
            NSLog(@"set up 4.......");
            
            
            medication.str1=notification.alertBody;
                        medication.medicationDic=[[NSDictionary alloc]initWithDictionary:notification.userInfo];
            
            
            
            NSLog(@"show notificaiton................");
            
            if (idlength <8) {
                self.window.rootViewController= medication;
            }
            else
            {
                [self.navController pushViewController:medication animated:YES];
            }
            
            
        }
        
    }
    
}



#pragma mark - PKRevealing

- (void)revealController:(PKRevealController *)revealController didChangeToState:(PKRevealControllerState)state
{
   // NSLog(@"%@ (%d)", NSStringFromSelector(_cmd), (int)state);
}

- (void)revealController:(PKRevealController *)revealController willChangeToState:(PKRevealControllerState)next
{
    //PKRevealControllerState current = self.revealController.state;
    //NSLog(@"%@ (%d -> %d)", NSStringFromSelector(_cmd), (int)current, (int)next);
}


- (void)showHideMenu
{
    NSLog(@"111 temp test");

    if (![self.revealController isPresentationModeActive])
    {
        NSLog(@"222 temp test");
        [GlobalVariables shareInstance].viewId = self;
        [self.revealController enterPresentationModeAnimated:YES completion:nil];
        
    }
    else
    {
        NSLog(@"333 temp test");
        [self.revealController resignPresentationModeEntirely:NO animated:YES completion:nil];


    }
}



- (void)backToHome{

    int homeIndex=-1;
    
    for (int i=0; i<[self.navController.viewControllers count]; i++) {
        
        UIViewController *view=[self.navController.viewControllers objectAtIndex:i];
        
        

         NSLog(@"find home index...0...%d.....%@",i,[view class]);
        
        if(session_id==NULL||login_id==NULL){
            
            if ([view isMemberOfClass:[HomeViewControllerFirst class]]) {
                
                homeIndex=i;
                
                 NSLog(@"find home index..1....%d",homeIndex);
                            }
            
            
        }
        else{
            if ([view isMemberOfClass:[HomeViewController class]]) {
                
                homeIndex=i;
                
                 NSLog(@"find home index...2...%d",homeIndex);
            }
            
        }
        
        
        
    }
     NSLog(@"find home index...3...%d",homeIndex);
    
    if (homeIndex==-1) {
        
        HomeViewController *loginViewController = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        
        [self.navController pushViewController:loginViewController animated:YES];
        
    }else{
        
        [self.navController popToViewController: [self.navController.viewControllers objectAtIndex: homeIndex] animated:YES];
        
    }
    
    
    
    [self.revealController resignPresentationModeEntirely:YES animated:NO completion:nil];
    [self.revealController setFrontViewController:self.navController];
    [self.revealController showViewController:self.revealController.frontViewController];
    
}


- (BOOL)isLoginView{
    
    BOOL hasLoginView=false;
    
    for (int i=0; i<[self.navController.viewControllers count]; i++) {
        
        UIViewController *view=[self.navController.viewControllers objectAtIndex:i];
        
        
        
        if ([view isMemberOfClass:[LoginViewController class]]) {
            
            hasLoginView=true;
            
        }
        
        
    }
    
    if (hasLoginView) {
        
        UIViewController *view=[self.navController.viewControllers objectAtIndex:[self.navController.viewControllers count]-1];
        
        if ([view isMemberOfClass:[LoginViewController class]]) {
            
            return true;
            
        }
    }
    
    
    
    return false;
}


- (void)backToLogin
{
    

    if ([self isLoginView]) {
        
        return;
    }

    NSInteger homeIndex=-1;
    
    for (int i=0; i<[self.navController.viewControllers count]; i++) {
        
        UIViewController *view=[self.navController.viewControllers objectAtIndex:i];
        

        
        if ([view isMemberOfClass:[LoginViewController class]]) {
                
                homeIndex=i;
           
        }
            
        
        
        
        
    }
    
    
    [self performSelectorOnMainThread:@selector(loadBlankPage:) withObject:[NSString stringWithFormat:@"%ld",(long)homeIndex] waitUntilDone:NO];
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        
//        NSLog(@"3........");
//        
//        if (homeIndex==-1) {
//            
//            
//            LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//            
//            [self.navController pushViewController:loginViewController animated:YES];
//            
//        }else{
//            
//            [self.navController popToViewController: [self.navController.viewControllers objectAtIndex: homeIndex] animated:YES];
//            
//        }
//        
//        
//        
//        //[self.navController popToRootViewControllerAnimated:YES];
//        [self.revealController setFrontViewController:self.navController];
//        [self.revealController showViewController:self.revealController.frontViewController];
//        
//    });
    
    
    
    
    //need clear ?
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    [defaults setObject: @"" forKey: @"sessionid"];
//    [defaults setObject: @"" forKey: @"login"];
//    [defaults synchronize];
//
//    [GlobalVariables shareInstance].login_id = nil;
//    [GlobalVariables shareInstance].session_id = nil;
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
    
    [sharedDefaults setObject: @"N" forKey: @"isLogin"];

    [sharedDefaults synchronize];
    
}

- (void)loadBlankPage:(NSString*)theIndex
{
    
    NSInteger homeindex=[theIndex integerValue];
    
    if (homeindex==-1) {
        
        
        LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        
        [self.navController pushViewController:loginViewController animated:YES];
        
    }else{
        
        [self.navController popToViewController: [self.navController.viewControllers objectAtIndex: homeindex] animated:YES];
        
    }
    
    ///Vaycent set the thrid part focus
//        [self.revealController resignPresentationModeEntirely:NO animated:YES completion:nil];

    [self.revealController setFrontViewController:self.navController];

    [self.revealController showViewController:self.revealController.frontViewController];
    
    [revealController screenSet];
    
    ///////////////
}

- (void)showRotateView:(UIViewController *)theView {
    
    [self.revealController setFrontViewController:theView];
    [self.revealController showViewController:self.revealController.frontViewController];
}

- (void)hideRotateView {
    
    [self.revealController setFrontViewController:self.navController];
    [self.revealController showViewController:self.revealController.frontViewController];
}

- (BOOL)initDatabase:(NSString *)dbname {
    
    BOOL success;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",dbname]];
    success = [fm fileExistsAtPath:writableDBPath];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *version=[defaults objectForKey:@"version"];
    

    
    if (/*version==nil||[version isEqualToString:@""]
        ||*/
        [version isEqualToString:@"1.0.2"]
        ||[version isEqualToString:@"1.0.1"]
        ||[version isEqualToString:@"1.0"]
        ||[version isEqualToString:@"1.0.6"]
        ) {

//        if([dbname rangeOfString:@"/"].location== NSNotFound){
            if([self isAllNum:dbname]){
            
            [fm removeItemAtPath:writableDBPath error:nil];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject: @"Y" forKey: @"loaddata"];
            [defaults synchronize];

        }
    }
    
  
    
    
    
    
    
    if(!success){
        
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:writableDBPath];
        //NSLog(@"----------------1-----------");
        success=[DBHelper initDB];
        
        
        
        //NSLog(@"----------------2-----------");
        
    } else {
        
//
        
        
        
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:writableDBPath];
        [DBHelper initDB];
        
        
        
        
        
        
        
        
        success =YES;
        /*
         db = [FMDatabase databaseWithPath:writableDBPath];
         if ([db open]) {
         [db setShouldCacheStatements:YES];
         success =YES;
         }*/
        
    }
    
	return success;
	
}

/*
 * // Optional UITabBarControllerDelegate method
 * - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
 * }
 */

/*
 * // Optional UITabBarControllerDelegate method
 * - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
 * }
 */



- (void)applicationDidEnterBackground:(UIApplication *)application{
    
    
    NSLog(@"go to bg......");
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *currentTime=[NSDate date];
    
    double getTime=[currentTime timeIntervalSince1970];
    
    [defaults setObject:[NSString stringWithFormat:@"%f",getTime] forKey:@"sleep_time"];
    
    [defaults synchronize];
    
    
    
//    
//    UIDevice *device = [UIDevice currentDevice];
//    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//	[nc addObserver:self selector:@selector(goToBackground) name:UIDeviceOrientationDidChangeNotification object:device];
    
    
    
    NSString *session_ids = [GlobalVariables shareInstance].session_id;
    NSString *login_ids = [GlobalVariables shareInstance].login_id;
    if(session_ids==NULL||login_ids==NULL){
        
        for (int i=0; i<[self.navController.viewControllers count]; i++) {
            
            UIViewController *view=[self.navController.viewControllers objectAtIndex:i];
            if ([view isMemberOfClass:[PedometerViewController class]]) {
                [ ((PedometerViewController*)view) goToBackground];
            }
        }
        for (int i=0; i<[self.navController.viewControllers count]; i++) {
            
            UIViewController *view=[self.navController.viewControllers objectAtIndex:i];
            if ([view isMemberOfClass:[TrainingPedometerViewController class]]) {
                [ ((TrainingPedometerViewController*)view) goToBackground];
            }
        }

    }

    
    
    
    
    if ([self.window.rootViewController isKindOfClass:[MedicationAlapk class]]) {
        
        [self setShowNotification:false];
        
    }
    else if([self.window.rootViewController isKindOfClass:[NotiInForMationViewController class]]) {
        
        [self setShowNotification:false];
        
    }
    
   
    
   
    
    
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"go to front......");

//            NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadInMainMethod) object:nil];
//            myThread.threadPriority = 1.0;
//            [myThread start];
    [self threadInMainMethod];
    
    
    
    
//    NSString *encodedString=[[NSString alloc]initWithFormat:@"%@healthApp?action=C&apptype=iphone&version=%@",[Constants getAPIBase2],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    NSLog(@"App Action Apptype version=%@",encodedString);
//    NSURL *request_url = [NSURL URLWithString:encodedString];
//    
//    NSLog(@"App Action Apptype versionurl:%@",request_url);
//    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//    if ((xmlData  == nil) || [syncUtility XMLHasError:xmlData ]) {
//        NSLog(@"Get BP History error!");
//    }
//    NSLog(@"App Action Apptype versionxmlData:%@",xmlData);
//
//    if (xmlData)
//    {
//        
//        [syncUtility XMLHasError:xmlData];
//        
//        int isSucc = [Utility isSucc:xmlData];
//        NSLog(@"add walking recordCCCCCC succ:%d",isSucc);
//        if (isSucc==1)
//        {
//            NSString *strWarn=[syncUtility getAppVerrsioningCheckKey:xmlData];
//            NSLog(@"strWarn==%@",strWarn);
//     // strWarn=@"Remind_4214";
//            if ([strWarn isEqualToString:@"normal"]) {
//                // normal
//            }
//            else if([strWarn isEqualToString:@"force"])
//            {
//                //force
//                appForceView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 548)];
//               
//                imagehandImageView=[[UIImageView alloc]init];
//                imagehandImageView.frame=CGRectMake(0, 20, 320, 50);
//                [imagehandImageView setImage:[UIImage imageNamed:@"01_index_header_p1b.png"]];
//                
//                healthReachImageView=[[UIImageView alloc]init];
//                healthReachImageView.frame=CGRectMake(20, 12+20, 162, 25);
//          
//               
//                appForceView.backgroundColor=[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
//                
//                
//                UIView *blackLittleView=[[UIView alloc]initWithFrame:CGRectMake(60, 170, 200, 180)];
//                blackLittleView.backgroundColor=[UIColor blackColor];
//             
//                UILabel *labelText=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 190, 100)];
//                if ([[Utility getLanguageCode] isEqualToString:@"en"])
//                {
//                    [healthReachImageView setImage:[UIImage imageNamed:@"01_index_logo.png"]];
//                     labelText.text=@"A new version of HealthReach™\n has been launched.\n Please update now.";
//                }
//                else{
//                    [healthReachImageView setImage:[UIImage imageNamed:@"00_logo.png"]];
//                      labelText.text=@"健易達™最新版本已經推出\n請立即更新。";
//                }
//
//               
//                labelText.textAlignment=NSTextAlignmentCenter;
//                labelText.textColor=[UIColor whiteColor];
//                labelText.numberOfLines=3;
//                labelText.font=[UIFont systemFontOfSize:12];
//                
//                [blackLittleView addSubview:labelText];
//                
//                
//                UIButton *buttonRed=[UIButton buttonWithType:UIButtonTypeCustom];
//                buttonRed.frame=CGRectMake(10, 145, 85, 25);
//                [buttonRed setImage:[UIImage imageNamed:@"00_btn_red_p1.png"] forState:UIControlStateNormal];
//                
//                [buttonRed addTarget:self action:@selector(quit:) forControlEvents:UIControlEventTouchUpInside];
//                UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
//                label1.text=[Utility getStringByKey:@"Quit"];
//                label1.textAlignment=NSTextAlignmentCenter;
//                label1.backgroundColor=[UIColor clearColor];
//                label1.textColor=[UIColor whiteColor];
//                [buttonRed addSubview:label1];
//                
//                [blackLittleView addSubview:buttonRed];
//                
//                
//                
//                
//                
//                
//                UIButton*buttonGreen=[UIButton buttonWithType:UIButtonTypeCustom];
//                buttonGreen.frame=CGRectMake(10+85+10, 145, 85, 25);
//                [buttonGreen setImage:[UIImage imageNamed:@"00_btn_green_p1.png"] forState:UIControlStateNormal];
//                [buttonGreen addTarget:self action:@selector(upDate:) forControlEvents:UIControlEventTouchUpInside];
//            
//                UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
//                label2.text=[Utility getStringByKey:@"Update"];
//                label2.textAlignment=NSTextAlignmentCenter;
//                label2.backgroundColor=[UIColor clearColor];
//                label2.textColor=[UIColor whiteColor];
//                [buttonGreen addSubview:label2];
//                
//                [blackLittleView addSubview:buttonGreen];
//                
//                
//                [appForceView addSubview:blackLittleView];
//                [self.window addSubview:appForceView];
//                [self.window addSubview:imagehandImageView];
//                [self.window addSubview:healthReachImageView];
//                
//                
//                
//                
//                
//                
//                
//            }
//            else
//            {
//           
//                //remind_x
//                NSString *remind_x=@"1" ;
//                if ([strWarn length]>7) {
//                    remind_x = [strWarn substringFromIndex:7];
//                    NSLog(@"remind_x=%@",remind_x);
//                }
//                appForceView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 548)];
//                
//                imagehandImageView=[[UIImageView alloc]init];
//                imagehandImageView.frame=CGRectMake(0, 20, 320, 50);
//                [imagehandImageView setImage:[UIImage imageNamed:@"01_index_header_p1b.png"]];
//                
//                healthReachImageView=[[UIImageView alloc]init];
//                healthReachImageView.frame=CGRectMake(20, 12+20, 162, 25);
//          
//                
//                appForceView.backgroundColor=[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
//                
//                
//                UIView *blackLittleView=[[UIView alloc]initWithFrame:CGRectMake(60, 170, 200, 180)];
//                blackLittleView.backgroundColor=[UIColor blackColor];
//                
//                UILabel *labelText=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 190, 100)];
//                if ([[Utility getLanguageCode] isEqualToString:@"en"])
//                {
//                    [healthReachImageView setImage:[UIImage imageNamed:@"01_index_logo.png"]];
//                    NSString *strEn=[[NSString alloc]initWithFormat:@"A new version of HealthReach™ has been launched. For a better experience, Please update it within %@ days.",remind_x];
//                        labelText.numberOfLines=4;
//                       labelText.text=strEn;
//                }
//                else{
//                    [healthReachImageView setImage:[UIImage imageNamed:@"00_logo.png"]];
//                    NSString *strCh=[[NSString alloc] initWithFormat:@"健易達™最新版本已經推出。\n為達更佳體驗，\n請於%@天內更新。",remind_x];
//                       labelText.text=strCh;
//                        labelText.numberOfLines=3;
//                }
//             
//                labelText.textAlignment=NSTextAlignmentCenter;
//                labelText.textColor=[UIColor whiteColor];
//            
//                labelText.font=[UIFont systemFontOfSize:12];
//                
//                [blackLittleView addSubview:labelText];
//                
//                
//                UIButton *buttonRed=[UIButton buttonWithType:UIButtonTypeCustom];
//                buttonRed.frame=CGRectMake(10, 145, 85, 25);
//                [buttonRed setImage:[UIImage imageNamed:@"00_btn_red_p1.png"] forState:UIControlStateNormal];
//                
//                [buttonRed addTarget:self action:@selector(remindMeLater:) forControlEvents:UIControlEventTouchUpInside];
//                UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
//                label1.text=[Utility getStringByKey:@"Remind me later"];
//                label1.textAlignment=NSTextAlignmentCenter;
//                label1.backgroundColor=[UIColor clearColor];
//                label1.textColor=[UIColor whiteColor];
//                [buttonRed addSubview:label1];
//                if ([label1.text isEqualToString:@"Remind me later"]) {
//                    label1.font=[UIFont systemFontOfSize:9];
//                }
//                else
//                {
//                      label1.font=[UIFont systemFontOfSize:15];
//                }
//                [blackLittleView addSubview:buttonRed];
//                
//                
//                
//                
//                
//                
//                UIButton*buttonGreen=[UIButton buttonWithType:UIButtonTypeCustom];
//                buttonGreen.frame=CGRectMake(10+85+10, 145, 85, 25);
//                [buttonGreen setImage:[UIImage imageNamed:@"00_btn_green_p1.png"] forState:UIControlStateNormal];
//                [buttonGreen addTarget:self action:@selector(upDateNow:) forControlEvents:UIControlEventTouchUpInside];
//                
//                UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
//                label2.text=[Utility getStringByKey:@"Update now"];
//                label2.textAlignment=NSTextAlignmentCenter;
//                label2.backgroundColor=[UIColor clearColor];
//                label2.textColor=[UIColor whiteColor];
//                [buttonGreen addSubview:label2];
//                if ([label2.text isEqualToString:@"Update now"]) {
//                    label2.font=[UIFont systemFontOfSize:9];
//                }
//                else
//                {
//                    label2.font=[UIFont systemFontOfSize:15];
//                }
//                [blackLittleView addSubview:buttonGreen];
//                
//                
//                [appForceView addSubview:blackLittleView];
//                [self.window addSubview:appForceView];
//                [self.window addSubview:imagehandImageView];
//                [self.window addSubview:healthReachImageView];
//                
//                
//            }
//            
//            
//            
//            
//   
//        }
//        else
//        {
//            NSLog(@"32132111111");
//            
//        }
//        
//    }

    
//    @"iPad1,1":  @"iPad",
//    @"iPad2,1":  @"iPad 2(WiFi)",
//    @"iPad2,2":  @"iPad 2(GSM)",
//    @"iPad2,3":  @"iPad 2(CDMA)",
//    @"iPad2,4":  @"iPad 2(WiFi Rev A)",
    
    if ([[Utility deviceModelName] rangeOfString:@"iPhone 4"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPad 1"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPad 2(WiFi)"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPad 2(GSM)"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPad 2(CDMA)"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPad 2(WiFi Rev A)"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPhone 3"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPod 4"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPod 3"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPod 2"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPod 1"].location != NSNotFound
        ||[[Utility deviceModelName] rangeOfString:@"iPod 5"].location != NSNotFound) {
    
        //NSLog(@"find ......%@........",[Utility deviceModelName]);
        //NSString *lan = [Utility getLanguageCode];
        NSString *msg=[[Utility getLanguageCode] isEqualToString:@"cn"]?@"你的手機暫未支援此程式":@"This application is not supported by your handset";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:[Utility getStringByKey:@"confirm_btn"],nil];
        [alert show];
        
//        UIAlertController *alertController = [UIAlertController
//                                              alertControllerWithTitle:@""
//                                              message:msg
//                                              preferredStyle:UIAlertControllerStyleAlert];
//        
//        
//        UIAlertAction *okAction = [UIAlertAction
//                                   actionWithTitle:NSLocalizedString([Utility getStringByKey:@"confirm_btn"], @"OK action")
//                                   style:UIAlertActionStyleDefault
//                                   handler:^(UIAlertAction *action)
//                                   {
//                                       NSThread *threadForCalories = [[NSThread alloc]initWithTarget:self selector:@selector(syncCalories) object:nil];
//                                       [threadForCalories start];
//                                       NSLog(@"OK");
//                                   }];
//        
//    
//        [alertController addAction:okAction];
//        [self presentViewController:alertController animated:YES completion:nil];


        
     return;
        
   }
    
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *currentTime=[NSDate date];
    
    
    
    NSString *savetime=[defaults objectForKey:@"sleep_time"];
    
    if (savetime==nil) {
        
        savetime=@"-1";
    }
    
    double theTime=[savetime doubleValue];
    
    
    
    if (theTime+6*60<[currentTime timeIntervalSince1970]&&theTime!=-1&&!isrunning&&login_id!=nil) {
        
        [self backToLogin];
        
        [defaults setObject:@"-1"forKey:@"sleep_time"];
        
        [defaults synchronize];
    }
    
    
    if (!isShowNotification) {
        
        [self clearNotificationSetup];
        //NSLog(@"set up 5.......");
        [self setShowNotification:YES];
        //NSLog(@"set up 6.......");
    }
    
}
-(void)threadInMainMethod
{
    NSString *encodedString=[[NSString alloc]initWithFormat:@"%@healthApp?action=C&apptype=iphone&version=%@",[Constants getAPIBase2],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //NSLog(@"App Action Apptype version=%@",encodedString);
    NSURL *request_url = [NSURL URLWithString:encodedString];
    
    NSLog(@"App Action Apptype versionurl:%@",request_url);
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    
    if ((xmlData  == nil) || [syncUtility XMLHasError:xmlData ]) {
        NSLog(@"Get BP History error!");
    }
    //NSLog(@"App Action Apptype versionxmlData:%@",xmlData);
    
    if (xmlData)
    {
        
        [syncUtility XMLHasError:xmlData];
        
        int isSucc = [Utility isSucc:xmlData];
        //NSLog(@"add walking recordCCCCCC succ:%d",isSucc);
        if (isSucc==1)
        {
          NSString*  strWarn=[syncUtility getAppVerrsioningCheckKey:xmlData];
            
            //vaycent
//            strWarn=@"remind_1";
            
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:strWarn forKey:@"strWarn"];

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDate *today=[NSDate date];
            
            NSString *today_date=[dateFormatter stringFromDate:today];
            
            
            [defaults setValue:today_date forKey:@"app_update_date"];
            
            [defaults synchronize];
            
            //NSLog(@"strWarn=YYYYYYyyY ONE ::::::::%@",strWarn);
        }
    }

}
-(void)quit:(id)sender
{
    NSLog(@"Quit");
    NSMutableArray *muatarar=[[NSMutableArray alloc]initWithObjects:@"",@"" , nil];
    NSString *sss=[muatarar objectAtIndex:4];
    NSLog(@"%@",sss);
    
}
-(void)upDate:(id)sender
{
    NSLog(@"Update");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id910396784"]];
}
-(void)remindMeLater:(id)sender
{
    NSLog(@"Remind me later");
    appForceView.hidden=YES;
    imagehandImageView.hidden=YES;
    healthReachImageView.hidden=YES;
}
-(void)upDateNow:(id)sender
{
    NSLog(@"Update now");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id910396784"]];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"clickButtonAtIndex:%d",buttonIndex);
    
//    NSThread *threadForCalories = [[NSThread alloc]initWithTarget:self selector:@selector(syncCalories) object:nil];
//    [threadForCalories start];
}

- (void)setShowNotification:(BOOL)showNotification{
    
    isShowNotification=showNotification;
    
   // NSLog(@"set notification.........%hhd",showNotification);
    
//    if (!isShowNotification) {
//        
//        [self clearNotificationSetup];
//        
//        [self setShowNotification:YES];
//    }
}


- (void)clearNotificationSetup{
    
    NSLog(@"clear notification setup....");

    
    if ( [self.window respondsToSelector:@selector(setRootViewController:)] ) {
        
        self.window.rootViewController = self.revealController;
        
    }
    else {
        
        [self.window addSubview:self.revealController.view];
    }
    

}

-(void)func{
    
    //[[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"setToWalkForHealth" object:nil];
    NSLog(@"check again");
    
    if ([self getWalkForHealth]!=nil) {
        
        NSLog(@"check again");
        
        [self getWalkForHealth].WaitingView.hidden=true;
        isHiddenWalkLoad=true;
    }
    else{
        isHiddenWalkLoad=true;
    }
    
    
}


-(void)funcDasboard{
    
    
    
    if ([self getDashBoardView]!=nil) {

        [self getDashBoardView].WaitingView.hidden=true;
        isHiddenDashBoardLoad=true;
    }
    else{
        
        isHiddenDashBoardLoad=true;
    }
    
    
    
    if ([self getRotateBPView]!=nil) {
        [self getRotateBPView].WaitingView.hidden=true;
        isHiddenDashBoardLoad=true;
    }
    else{
        isHiddenDashBoardLoad=true;
    }

    
    if ([self getRotateBGView]!=nil) {
        [self getRotateBGView].WaitingView.hidden=true;
        isHiddenDashBoardLoad=true;
    }
    else{
        isHiddenDashBoardLoad=true;
    }

    
    
    
    if ([self getRotateWeightView]!=nil) {
        [self getRotateWeightView].WaitingView.hidden=true;
        isHiddenDashBoardLoad=true;
    }
    else{
        isHiddenDashBoardLoad=true;
    }

    
    
    
    
    
    
    
    
    

}





-(void)funcAverageBP{
    if ([self getAverageBPView]!=nil) {
        NSLog(@"come here to 2");
        
        [self getAverageBPView].WaitingView.hidden=true;
        isHiddenAverageBPLoad=true;
    }
    else{
        NSLog(@"come here to 3");

        
        isHiddenAverageBPLoad=true;
    }

}

-(void)funcAverageBG{
    if ([self getAverageBGView]!=nil) {
        NSLog(@"come here to 2");
        
        [self getAverageBGView].WaitingView.hidden=true;
        isHiddenAverageBGLoad=true;
    }
    else{
        NSLog(@"come here to 3");
        
        
        isHiddenAverageBGLoad=true;
    }


}

-(void)funcAverageWeight{
    if ([self getAverageWeightView]!=nil) {
        NSLog(@"come here to 333");

        [self getAverageWeightView].waitingView.hidden=true;
        isHiddenAverageWeightLoad=true;
    }
    else{
        NSLog(@"come here to 222");
        
        
        isHiddenAverageWeightLoad=true;
    }

}












//-判断当前网络是否可用
-(BOOL) isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url = @"www.baidu.com";
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        //        kSCNetworkReachabilityFlagsReachable：能够连接网络
        //        kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
        //        kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    return bEnabled;
}


- (void)setIsRunning:(BOOL)running{
    
    isrunning=running;
}
- (BOOL)getIsRunning{
    
    return isrunning;
}

- (void)checkLocationService{
    
    if (iOS8) {
        
        NSLog(@"check location...");
        
        _locationManager = [[CLLocationManager alloc] init];
        
        BOOL enable=[CLLocationManager locationServicesEnabled];
        
        int status=[CLLocationManager authorizationStatus];
        if(!enable || status<3){
            
            
            [_locationManager requestAlwaysAuthorization];
            //[_locationManager requestWhenInUseAuthorization];
        }
        
    }
}

-(BOOL)getIsHiddenWalkLoad{
    return isHiddenWalkLoad;
}
-(BOOL)getIsHiddenDashBoard{
    return isHiddenDashBoardLoad;
}

-(BOOL)getIsHiddenAverageBPLoad{
    return isHiddenAverageBPLoad;
}

-(BOOL)getIsHiddenAverageBGLoad{
    return isHiddenAverageBGLoad;
}

-(BOOL)getIsHiddenAverageWeightLoad{
    return isHiddenAverageWeightLoad;
}






-(void)setIsHiddenWalkLoad{
    isHiddenWalkLoad=true;
}
-(void)setIsHiddenDashBoard{
    isHiddenDashBoardLoad=true;
}

-(void)setIsHiddenAverageBPLoad{
    isHiddenAverageBPLoad=true;
}

-(void)setIsHiddenAverageBGLoad{
    isHiddenAverageBGLoad=true;
}

-(void)setIsHiddenAverageWeightLoad{
    isHiddenAverageWeightLoad=true;
}

















- (void)setWalkForHealth:(WalkForHealthViewController*)walkForHealth{
    
    self.walkForHealthController=walkForHealth;
}
- (WalkForHealthViewController*)getWalkForHealth{
    
    return self.walkForHealthController;
}




- (void)setDashBoardView:(DashBoardViewController*)dashBoardView{
    
    self.dashBoardController=dashBoardView;
}
- (DashBoardViewController*)getDashBoardView{
    
    return self.dashBoardController;
}





- (void)setAverageBPView:(BPHistoryViewController*)bpHistoryView{
    
    self.bpHistoryView=bpHistoryView;
}
- (BPHistoryViewController*)getAverageBPView{
    
    return self.bpHistoryView;
}




- (void)setAverageBGView:(BGHistoryViewController*)bgHistoryView{
    
    self.bgHistoryView=bgHistoryView;
}
- (BGHistoryViewController*)getAverageBGView{
    
    return self.bgHistoryView;
}




- (void)setAverageWeightView:(WeightHistoryViewController*)weightHistoryView{
    
    self.weightHistoryView=weightHistoryView;
}
- (WeightHistoryViewController*)getAverageWeightView{
    
    return self.weightHistoryView;
}






- (void)setRotateBPView:(BPRotateChartViewController*)bpRotateView{
    
    self.bpRotateView=bpRotateView;
}
- (BPRotateChartViewController*)getRotateBPView{
    
    return self.bpRotateView;
}

- (void)setRotateBGView:(BGRotateChartViewController*)bgRotateView{
    
    self.bgRotateView=bgRotateView;
}
- (BGRotateChartViewController*)getRotateBGView{
    
    return self.bgRotateView;
}




- (void)setRotateWeightView:(WeightRotateViewController *)weightRotateView{
    
    self.weightRotateView= weightRotateView;
}
- (WeightRotateViewController *)getRotateWeightView{
    
    return self.weightRotateView;
}

#pragma mark - PushNotification Functions

//- (void)processRemoteNotification:(NSDictionary*)userInfo{
//    
//    
//    NSString *msgType=[userInfo objectForKey:@"type"];
//    
//    if (msgType!=nil&&![msgType isEqualToString:@""]) {
//        
//        NSString *url=[userInfo objectForKey:@"url"];
//        
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 1];
//        
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
//        
//        
//        if ([msgType isEqualToString:@"launchApp"]) {
//            
//            //just launch app
//            
//        }else if ([msgType isEqualToString:@"inAppBrowser"]){
//            
//            if (url!=nil&&![url isEqualToString:@""]) {
//                
//                NSDictionary *urlDataDict = [NSDictionary dictionaryWithObjectsAndKeys:url,@"url", nil];
//                [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"PushNotification" object:urlDataDict];
//            }
//            
//            
//        }else if ([msgType isEqualToString:@"extBrowser"]){
//            
//            if (url!=nil&&![url isEqualToString:@""]) {
//                
//                
//                NSURL *URL = [NSURL URLWithString:url];
//                
//                if ([[UIApplication sharedApplication] canOpenURL:URL]) {
//                    
//                    [[UIApplication sharedApplication] openURL:URL];
//                    
//                    
//                    
//                }else{
//                    
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[NSString stringWithFormat:@"Failed to open url: %@",url] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//                    
//                    [alert show];
//                }
//            }
//            
//        }
//    }
//    
//}
//
//
//
//
//- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
//    // NSLog(@"regisger success:%@",deviceToken);
//    
//    const unsigned char *tokenBuffer = [deviceToken bytes];
//    NSMutableString *tokenString = [NSMutableString stringWithCapacity:[deviceToken length]*2];
//    for(int i = 0; i < [deviceToken length]; ++i) {
//        [tokenString appendFormat:@"%02X", (unsigned int)tokenBuffer[i]];
//    }
//    
//    
//    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register success" message:[NSString stringWithFormat:@"device token: %@",tokenString] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//    //    [alert show];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:tokenString forKey:@"RemoteNotificationToken"];
//    [defaults synchronize];
//
//    
//}
//
//- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
//    NSLog(@"Registfail%@",error);
//    
//    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Regisger fail" message:[NSString stringWithFormat:@"device token: %@",error] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//    //    [alert show];
//    
//}
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    NSLog(@"Remote Notification userInfo is %@", userInfo);
//    
//    if (UIApplicationStateBackground == application.applicationState&&([userInfo objectForKey:@"aps"]&&[[userInfo objectForKey:@"aps"] objectForKey:@"content-available"])) {
//        
//        //[self refreshDataFetchWithCompletionHandler:completionHandler notificationStr:@"Remote Notification background running "];
//        
//        //completionHandler(UIBackgroundFetchResultNewData);
//        
//    }else{
//        
//        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remote Notification" message:[NSString stringWithFormat:@"user info: %@",userInfo] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//        //
//        //        [alert show];
//        
//        
//        [self processRemoteNotification:userInfo];
//    }
//    
//    
//    
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    
//    // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    
//    
//    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remote Notification" message:[NSString stringWithFormat:@"user info: %@",userInfo] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//    //
//    //    [alert show];
//    
//    
//    [self processRemoteNotification:userInfo];
//    
//}
//
//




#pragma mark - WatchKit Data
-(void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    NSString *type = userInfo[@"type"];  //[userInfo objectForKey:@"type"];
    

    NSDictionary *replyInfo;
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    NSString *whetherLogin = @"";
    if ([GlobalVariables shareInstance].session_id) {
        whetherLogin = @"Y";
    }else
    {
        whetherLogin =@"N";
    }
    
    [dic setObject:whetherLogin forKey:@"isLogin"];
    
    
    NSLog(@"type:%@",type);
    if ([type isEqualToString:@"latest_record_bp"])
    {
        
        BloodPressure *bp=[DBHelper getNewestBPRecord];
        
        if (bp.sys!=nil&&![bp.sys isEqualToString:@""]&&![bp.sys isEqualToString:@"(null)"]) {
            
            [dic setObject:bp.sys forKey:@"sys"];
            
            [dic setObject:bp.dia forKey:@"dia"];
            
            [dic setObject:bp.heartrate forKey:@"hr"];
            
            long theTime=[bp getRecordtime];
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *currentDateStr = [dateFormat stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:theTime]];
            
            [dic setObject:currentDateStr forKey:@"date"];
        }else{
            
            [dic setObject:@"N/A" forKey:@"sys"];
            
            [dic setObject:@"N/A" forKey:@"dia"];
            
            [dic setObject:@"N/A" forKey:@"hr"];

            [dic setObject:@" N/A" forKey:@"date"];
        }
        
        
        
    }
    else if ([type isEqualToString:@"latest_record_bg"])
    {
        
       BloodGlucose *bg = [DBHelper getNewestBGRecord];
        
        if (![bg.type isEqualToString:@""]&&bg.type!=nil&&![bg.type isEqualToString:@"(null)"]) {

            [dic setObject:bg.bg forKey:@"bg"];
            
            NSString *bgtype=@"Undefine";
            
            if ([bg.type isEqualToString:@"F"]) {
                
                bgtype=@"Fasting";
                
            }else if ([bg.type isEqualToString:@"A"]) {
                
                bgtype=@"After meal";
                
            }else if ([bg.type isEqualToString:@"B"]) {
                
                bgtype=@"Before meal";
                
            }else if ([bg.type isEqualToString:@"U"]) {
                
                bgtype=@"Undefine";
                
            }
            
            [dic setObject:bgtype forKey:@"type"];
            
            long theTime=[bg getRecordtime];
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *currentDateStr = [dateFormat stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:theTime]];
            
            [dic setObject:currentDateStr forKey:@"date"];
            
            
        }else{
            
            [dic setObject:@"N/A" forKey:@"bg"];
            [dic setObject:@"N/A" forKey:@"type"];
            [dic setObject:@" N/A" forKey:@"date"];
            
        }
        
        
        
    }
    else if ([type isEqualToString:@"latest_record_weight"])
    {
        
        Weight *weight=[DBHelper getNewestWeightRecord];
        
        if (weight.weight!=nil&&![weight.weight isEqualToString:@""]&&![weight.weight isEqualToString:@"(null)"]) {
            
            [dic setObject:[NSString stringWithFormat:@"%@ %@",weight.weight,[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"]] forKey:@"weight"];
            
            [dic setObject:weight.bmi forKey:@"bmi"];
            
            long theTime=[weight getRecordtime];
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *currentDateStr = [dateFormat stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:theTime]];
            
            [dic setObject:currentDateStr forKey:@"date"];
        }else{
            
            [dic setObject:@"N/A" forKey:@"weight"];
            [dic setObject:@"N/A" forKey:@"bmi"];
            [dic setObject:@" N/A" forKey:@"date"];
        }
        
        
        
    }
    else if ([type isEqualToString:@"latest_record_cal"])
    {
        NSMutableDictionary *calrecord=[DBHelper getNewestFoodRecords];
        
        if ([calrecord count]>0) {
            
            NSString *calvalue=[[calrecord objectForKey:@"totalCalories"] stringValue];
            NSString *recordtime=[calrecord objectForKey:@"recordTime"];
            
            [dic setObject:calvalue forKey:@"cal_value"];
            [dic setObject:recordtime forKey:@"date"];
            
        }else{
            
            [dic setObject:@"N/A" forKey:@"cal_value"];
            [dic setObject:@" N/A" forKey:@"date"];
            
        }
        
       
    }
    else if([type isEqualToString:@"casual_walk"]){
        self.stepCounter = [[CMPedometer alloc] init];
        
        
        
              [self.stepCounter startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {

//            if (self.stepCounter>0&&numberOfSteps==0) {
//                
//                self.beforeStepsCount=self.stepCounter;
//                
//            }
//            
////            if (isPauseed) {
////                
////                
////                
////                self.stepsCount=self.beforeStepsCount+numberOfSteps;
////            }
////            else{
//            
//                self.stepCounter=numberOfSteps;
////            }
//            
//            
////            [self performSelectorOnMainThread:@selector(updateStep) withObject:Nil waitUntilDone:NO];
            
            NSString *stringInt = [NSString stringWithFormat:@"%ld",(long)pedometerData.numberOfSteps];
            
             [dic setObject:stringInt  forKey:@"steps"];
            
            
            
            
        }];

        
        
        
        
               
        
    }
    else if([type isEqualToString:@"chart_data_bp"]){
        
        
        
        NSString *periodStr = userInfo[@"period"];
        
        int period=[periodStr intValue];

        NSString *result=[self setupBPChart:period];

        [dic setObject:result forKey:@"image_data"];
        
        
        
    }
    else if([type isEqualToString:@"chart_data_bg"]){
        
        
        
        NSString *periodStr = userInfo[@"period"];
        
        int period=[periodStr intValue];
        
        NSString *result=[self setupBGChart:period];
        
        [dic setObject:result forKey:@"image_data"];
        
        
        
    }
    else if([type isEqualToString:@"chart_data_weight"]){
        
        
        
        NSString *periodStr = userInfo[@"period"];
        
        int period=[periodStr intValue];
        
        NSString *result=[self setupWeightChart:period];
        
        [dic setObject:result forKey:@"image_data"];
        
        
        
    }
    else if([type isEqualToString:@"chart_data_cal"]){
        
        
        
        NSString *periodStr = userInfo[@"period"];
        
        int period=[periodStr intValue];
        
        NSString *result=[self setupCalsChart:period];
        
        [dic setObject:result forKey:@"image_data"];
        
        
        
    }

    
    replyInfo=[[NSDictionary alloc] initWithDictionary:dic];
    
    
    reply(replyInfo);
}

-(NSString *) setupBPChart:(int)period{
    
    
    NSDate *tmp=[NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
    
    
    //        NSLog(@"year: %i", dateComponent.year);
    //
    //        	NSLog(@"month:%i", dateComponent.month);
    //        	NSLog(@"day:%i", dateComponent.day);
    //        	NSLog(@"hour:%i", dateComponent.hour);
    //        	NSLog(@"minute:%i", dateComponent.minute);
    //        	NSLog(@"second:%i", dateComponent.second);
    
    NSInteger year=dateComponent.year;
    NSInteger month=dateComponent.month;
    NSInteger day=dateComponent.day;
    
    // NSLog(@"%d.....%d.....%d",year,month,day);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
    
    dateComponent.day=dateComponent.day-period+1;
    
    
    NSDate *dateFromDateComponentsForDate = [calendar dateFromComponents:dateComponent];
    
    dateComponent = [calendar components:unitFlags fromDate:dateFromDateComponentsForDate];
    
    year=dateComponent.year;
    month=dateComponent.month;
    day=dateComponent.day;
    
    
    NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
    
    
    //NSLog(@"%@.............%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
    
    BloodPressureList *bpList;
    
    if (period==7||period==14) {
        
        bpList=[DBHelper getBPByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:-1];
        
    }else{
        
        //NSLog(@"get average data...%d",period);
        
        bpList=[DBHelper getBPAverageChartByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:period];
    }
    
    
    //NSLog(@"count.......%lu",(unsigned long)[bpList.bpList count]);
    
    NSMutableArray *timeData=[[NSMutableArray alloc] init];
    NSMutableArray *sysData=[[NSMutableArray alloc] init];
    NSMutableArray *diaData=[[NSMutableArray alloc] init];
    NSMutableArray *hrData=[[NSMutableArray alloc] init];
    
    NSMutableArray *missData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger j=[bpList.bpList count]-1; j>-1; j--) {
        
        BloodPressure *bp=[bpList.bpList objectAtIndex:j];
        
        long time=[bp getRecordtime];
        
        [timeData addObject:@(time)];
        
        int miss=[bp getMissprevious];
        
        [missData addObject:@(miss)];
        
        NSInteger sys=[bp.sys integerValue];
        
        
        NSInteger dia=[bp.dia integerValue];
        
        NSInteger hr=[bp.heartrate integerValue];
        
        
        [hrData addObject:@(hr+BPALL_MOVE_POS)];
        
        //NSLog(@"%ld.......%ld.......%ld......%@",(long)sys,(long)dia,(long)hr,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
        
        [sysData addObject:@(sys)];
        
        [diaData addObject:@(dia)];
        
        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
        d1x.itemCount = [sysData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [sysData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }
    
    LineChartData *d2x = [LineChartData new];
    {
        
        d2x.xMin = [recordEnd timeIntervalSince1970];
        d2x.xMax = [recordStart timeIntervalSince1970];
        d2x.title = @" ";
        d2x.color = [UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1];
        d2x.itemCount = [diaData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        d2x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [diaData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            
            //NSLog(@"%@..   label   ...%@",label1,label2);
            
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }
    
    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1];
        d3x.itemCount = [hrData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [hrData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }
    
    CGRect rect = CGRectMake(0, 0,360 , 180);
    
    LineChartView *bpChart=[[LineChartView alloc] initWithFrame:rect];
    
    bpChart.yMin = 50;
    bpChart.yMax = 250;
    
    bpChart.xMin = [recordEnd timeIntervalSince1970];
    bpChart.xMax = [recordStart timeIntervalSince1970];
    
    bpChart.ySteps = @[@"100",@"120",@"140",@"160",@"180",@"200"];
    bpChart.data = @[d1x,d2x,d3x];
    
    
    bpChart.drawsDataPoints = YES;
    
    bpChart.drawsDataLines = YES;
    
    bpChart.drawsBG=YES;
    
    bpChart.enableTouch=NO;
    
    bpChart.isRotate=YES;
    
    bpChart.xLabelCount=period;
    
    bpChart.chartType=TYPE_BPALL;
    
    bpChart.isWatch=1;
    
    bpChart.startColor=[UIColor colorWithRed:210.0f/255.0f green:90.0f/255.0f blue:90.0f/255.0f alpha:1];
 
    bpChart.endColor=[UIColor colorWithRed:100.0f/255.0f green:30.0f/255.0f blue:30.0f/255.0f alpha:1];

    
    [bpChart setNeedsDisplay];
    
    UIImage *image=[bpChart graphImage];
    
    NSData* imageData = UIImageJPEGRepresentation(image,1);

    NSString *imageString =[imageData base64EncodedStringWithOptions:NO];
    
    
    return imageString;
    
}

-(NSString *) setupBGChart:(int)period{
    
    
    NSDate *tmp=[NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
    
    
    //        NSLog(@"year: %i", dateComponent.year);
    //
    //        	NSLog(@"month:%i", dateComponent.month);
    //        	NSLog(@"day:%i", dateComponent.day);
    //        	NSLog(@"hour:%i", dateComponent.hour);
    //        	NSLog(@"minute:%i", dateComponent.minute);
    //        	NSLog(@"second:%i", dateComponent.second);
    
    NSInteger year=dateComponent.year;
    NSInteger month=dateComponent.month;
    NSInteger day=dateComponent.day;
    
    // NSLog(@"%d.....%d.....%d",year,month,day);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
    
    dateComponent.day=dateComponent.day-period+1;
    
    
    NSDate *dateFromDateComponentsForDate = [calendar dateFromComponents:dateComponent];
    
    dateComponent = [calendar components:unitFlags fromDate:dateFromDateComponentsForDate];
    
    year=dateComponent.year;
    month=dateComponent.month;
    day=dateComponent.day;
    
    
    NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
    
    
    NSLog(@"%@.............%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
    
    BloodGlucoseList *bgResultList;
    
    if (period==7||period==14) {
        
        bgResultList=[DBHelper getBGByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:-1];
        
    }else{
        
        bgResultList=[DBHelper getBGAverageChartByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:period];
    }
    
    
    //NSLog(@"count.......%d",[bgResultList.bgList count]);
    
    NSMutableArray *timebeforData=[[NSMutableArray alloc] init];
    NSMutableArray *timeafterData=[[NSMutableArray alloc] init];
    NSMutableArray *timeemptyData=[[NSMutableArray alloc] init];
    NSMutableArray *timeundefineData=[[NSMutableArray alloc] init];
    
    
    NSMutableArray *beforData=[[NSMutableArray alloc] init];
    NSMutableArray *afterData=[[NSMutableArray alloc] init];
    NSMutableArray *emptyData=[[NSMutableArray alloc] init];
    NSMutableArray *undefineData=[[NSMutableArray alloc] init];
    
    NSMutableArray *beforMiss=[[NSMutableArray alloc] init];
    NSMutableArray *afterMiss=[[NSMutableArray alloc] init];
    NSMutableArray *emptyMiss=[[NSMutableArray alloc] init];
    NSMutableArray *undefineMiss=[[NSMutableArray alloc] init];
    
    
    for (NSInteger j=[bgResultList.bgList count]-1; j>-1; j--) {
        
        BloodGlucose *bg=[bgResultList.bgList objectAtIndex:j];
        
        long time=[bg getRecordtime];
        
        int miss=[bg getMissprevious];
        
        //NSLog(@"bg miss....2..%d",miss);
        
        float bgValue=[bg.bg floatValue];
        
        
        if ([bg.type isEqualToString:@"B"]) {
            
            [beforData addObject:@(bgValue)];
            
            [timebeforData addObject:@(time)];
            
            [beforMiss addObject:@(miss)];
            
        }else if ([bg.type isEqualToString:@"A"]){
            
            [afterData addObject:@(bgValue)];
            
            [timeafterData addObject:@(time)];
            
            [afterMiss addObject:@(miss)];
            
        }else if ([bg.type isEqualToString:@"F"]){
            
            [emptyData addObject:@(bgValue)];
            
            [timeemptyData addObject:@(time)];
            
            [emptyMiss addObject:@(miss)];
            
        }else if ([bg.type isEqualToString:@"U"]){
            
            [undefineData addObject:@(bgValue)];
            
            [timeundefineData addObject:@(time)];
            
            [undefineMiss addObject:@(miss)];
            
        }
        
        
        
        
        // NSLog(@"%f..........%@..........%@",bgValue,bg.type,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
        
        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1];
        d1x.itemCount = [beforData count];
        
        
        [timebeforData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [timebeforData[item] floatValue];
            float y = [beforData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[beforMiss[item] integerValue]];
        };
    }
    
    LineChartData *d2x = [LineChartData new];
    {
        
        d2x.xMin = [recordEnd timeIntervalSince1970];
        d2x.xMax = [recordStart timeIntervalSince1970];
        d2x.title = @" ";
        d2x.color = [UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1];
        d2x.itemCount = [afterData count];
        
        
        [timeafterData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        d2x.getData = ^(NSUInteger item) {
            float x = [timeafterData[item] floatValue];
            float y = [afterData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            
            //NSLog(@"%@..   label   ...%@",label1,label2);
            
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[afterMiss[item] integerValue]];
        };
    }
    
    
    
    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
        d3x.itemCount = [emptyData count];
        
        
        [timeemptyData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [timeemptyData[item] floatValue];
            float y = [emptyData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[emptyMiss[item] integerValue]];
        };
    }
    
    LineChartData *d4x = [LineChartData new];
    {
        
        d4x.xMin = [recordEnd timeIntervalSince1970];
        d4x.xMax = [recordStart timeIntervalSince1970];
        d4x.title = @" ";
        d4x.color = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1];
        d4x.itemCount = [undefineData count];
        
        
        [timeundefineData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d4x.getData = ^(NSUInteger item) {
            float x = [timeundefineData[item] floatValue];
            float y = [undefineData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[undefineMiss[item] integerValue]];
        };
    }
    
    CGRect rect = CGRectMake(0, 0,360 , 180);
    
    LineChartView *bgChart=[[LineChartView alloc] initWithFrame:rect];
    
    
    bgChart.yMin = 2;
    bgChart.yMax = 20;
    
    bgChart.xMin = [recordEnd timeIntervalSince1970];
    bgChart.xMax = [recordStart timeIntervalSince1970];
    
    bgChart.ySteps = @[@"100",@"120",@"140",@"160",@"180",@"200"];
    bgChart.data = @[d1x,d2x,d3x,d4x];
    
    bgChart.startColor=[UIColor colorWithRed:140.0f/255.0f green:70.0f/255.0f blue:140.0f/255.0f alpha:1];
    
    bgChart.endColor=[UIColor colorWithRed:140.0f/255.0f green:70.0f/255.0f blue:140.0f/255.0f alpha:1];
    
    
    bgChart.drawsDataPoints = YES;
    
    bgChart.drawsDataLines = YES;
    
    bgChart.drawsBG=YES;
    
    bgChart.enableTouch=NO;
    
    bgChart.isRotate=YES;
    
    bgChart.xLabelCount=period;
    
    bgChart.chartType=TYPE_BG;
    
    bgChart.isWatch=1;
    
    [bgChart setNeedsDisplay];
    
    UIImage *image=[bgChart graphImage];
    
    NSData* imageData = UIImageJPEGRepresentation(image,1);
    
    NSString *imageString =[imageData base64EncodedStringWithOptions:NO];
    
    
    return imageString;
    
}

-(NSString *) setupWeightChart:(int)period{
    
    
    NSDate *tmp=[NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
    
    
    //        NSLog(@"year: %i", dateComponent.year);
    //
    //        	NSLog(@"month:%i", dateComponent.month);
    //        	NSLog(@"day:%i", dateComponent.day);
    //        	NSLog(@"hour:%i", dateComponent.hour);
    //        	NSLog(@"minute:%i", dateComponent.minute);
    //        	NSLog(@"second:%i", dateComponent.second);
    
    NSInteger year=dateComponent.year;
    NSInteger month=dateComponent.month;
    NSInteger day=dateComponent.day;
    
    // NSLog(@"%d.....%d.....%d",year,month,day);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
    
    dateComponent.day=dateComponent.day-period+1;
    
    
    NSDate *dateFromDateComponentsForDate = [calendar dateFromComponents:dateComponent];
    
    dateComponent = [calendar components:unitFlags fromDate:dateFromDateComponentsForDate];
    
    year=dateComponent.year;
    month=dateComponent.month;
    day=dateComponent.day;
    
    
    NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
    
    
    //NSLog(@"%@.............%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
    
    WeightList *weightResultList;
    
    
    if (period==7||period==14) {
        
        weightResultList=[DBHelper getWeightByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:0];
        
    }else{
        
        
        weightResultList=[DBHelper getWeightAverageChartByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:period];
        
    }
    
    
    
    
    NSMutableArray *timeData=[[NSMutableArray alloc] init];
    
    NSMutableArray *weightData=[[NSMutableArray alloc] init];
    
    NSMutableArray *bmiData=[[NSMutableArray alloc] init];
    
    NSMutableArray *missData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger j=[weightResultList.weightList count]-1; j>-1; j--) {
        
        Weight *weight=[weightResultList.weightList objectAtIndex:j];
        
        long time=[weight getRecordtime];
        
        [timeData addObject:@(time)];
        
        NSInteger miss=[weight getMissprevious];
        
        [missData addObject:@(miss)];
        
        NSInteger weightValue=[weight.weight integerValue];
        
        
        NSInteger bmiValue=[weight.bmi integerValue];
        
        [weightData addObject:@(weightValue)];
        
        [bmiData addObject:@(bmiValue+WEIGHT_MOVE_POS)];
        
        //NSLog(@"%ld.......%ld.............%@",(long)weightValue,(long)bmiValue,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
        
        
        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1];
        d1x.itemCount = [weightData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [weightData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }
    
    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
        d3x.itemCount = [bmiData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [bmiData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }
    
    CGRect rect = CGRectMake(0, 0,360 , 180);
    
    LineChartView *weightChart=[[LineChartView alloc] initWithFrame:rect];
    

    
    weightChart.yMin = 10;
    weightChart.yMax = 300;
    
    weightChart.xMin = [recordEnd timeIntervalSince1970];
    weightChart.xMax = [recordStart timeIntervalSince1970];
    
    weightChart.ySteps = @[@"100",@"120",@"140",@"160",@"180",@"200"];
    weightChart.data = @[d1x,d3x];
    
    weightChart.startColor=[UIColor colorWithRed:22.0f/255.0f green:144.0f/255.0f blue:210.0f/255.0f alpha:1];

    weightChart.endColor=[UIColor colorWithRed:6.0f/255.0f green:87.0f/255.0f blue:138.0f/255.0f alpha:1];
    
    
    weightChart.drawsDataPoints = YES;
    
    weightChart.drawsDataLines = YES;
    
    weightChart.drawsBG=YES;
    
    weightChart.enableTouch=NO;
    
    weightChart.isRotate=YES;
    
    weightChart.xLabelCount=period;
    
    weightChart.chartType=TYPE_WEIGHT;
    weightChart.isWatch=1;
    
    [weightChart setNeedsDisplay];

    UIImage *image=[weightChart graphImage];
    
    NSData* imageData = UIImageJPEGRepresentation(image,1);
    
    NSString *imageString =[imageData base64EncodedStringWithOptions:NO];
    
    
    return imageString;
    
}

-(NSString *) setupCalsChart:(int)period{
    
    
    NSDate *tmp=[NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
    
    
    //        NSLog(@"year: %i", dateComponent.year);
    //
    //        	NSLog(@"month:%i", dateComponent.month);
    //        	NSLog(@"day:%i", dateComponent.day);
    //        	NSLog(@"hour:%i", dateComponent.hour);
    //        	NSLog(@"minute:%i", dateComponent.minute);
    //        	NSLog(@"second:%i", dateComponent.second);
    
    NSInteger year=dateComponent.year;
    NSInteger month=dateComponent.month;
    NSInteger day=dateComponent.day;
    
    // NSLog(@"%d.....%d.....%d",year,month,day);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
    
    dateComponent.day=dateComponent.day-period+1;
    
    
    NSDate *dateFromDateComponentsForDate = [calendar dateFromComponents:dateComponent];
    
    dateComponent = [calendar components:unitFlags fromDate:dateFromDateComponentsForDate];
    
    year=dateComponent.year;
    month=dateComponent.month;
    day=dateComponent.day;
    
    
    NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
    
    
    //NSLog(@"%@.............%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
    
    NSMutableArray *calsResultList=[DBHelper getCaloriesRecordsByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970]];
    
    NSArray *trainList;
    
    if (period==7||period==14) {
        
        trainList=[DBHelper getCWRecordDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] type:-2];
    }else{
        
        
        trainList=[DBHelper getTrainAverageChartRecordDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] type:period];
        
    }
    
    
    
    NSArray *cwList;
    
    if (period==7||period==14) {
        
        cwList=[DBHelper getCWRecordDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] type:-1];
    }else{
        
        cwList=[DBHelper getCWAverageChartRecordDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] type:period];
    }
    
    
    
    NSMutableArray *calsTimeData=[[NSMutableArray alloc] init];
    
    NSMutableArray *calsburnData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger x=0; x<period; x++) {
        
        NSDate *theDate=[recordEnd dateByAddingTimeInterval:(x*(24*60*60))];
        
        long theTime=[theDate timeIntervalSince1970];
        
        NSInteger theCals=0;
        
        for (NSInteger j=[trainList count]-1; j>-1; j--) {
            
            WalkingRecord *walking=[trainList objectAtIndex:j];
            
            long time=[walking getRecordtime];
            
            NSDate *wDate=[[NSDate alloc] initWithTimeIntervalSince1970:time];
            
            // NSLog(@"%@.........the train date",wDate);
            
            if ([Utility isSameDayDate:theDate theDate:wDate]) {
                
                NSInteger cals=[walking.calsburnt integerValue];
                
                theCals=theCals+cals;
                
                
                
                
            }
            
            
        }
        
        for (NSInteger j=[cwList count]-1; j>-1; j--) {
            
            WalkingRecord *walking=[cwList objectAtIndex:j];
            
            long time=[walking getRecordtime];
            
            NSDate *wDate=[[NSDate alloc] initWithTimeIntervalSince1970:time];
            
            // NSLog(@"%@.........the cw date",wDate);
            
            if ([Utility isSameDayDate:theDate theDate:wDate]) {
                
                NSInteger cals=[walking.calsburnt integerValue];
                
                theCals=theCals+cals;
                
                
                
                
            }
            
            
        }
        
        
        if (theCals>0) {
            
            [calsTimeData addObject:@(theTime)];
            
            [calsburnData addObject:@(theCals)];
        }
        
        
        
    }
    
    
    
    
    NSMutableArray *timeData=[[NSMutableArray alloc] init];
    
    NSMutableArray *calsData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger j=[calsResultList count]-1; j>-1; j--) {
        
        NSDictionary *cals=[calsResultList objectAtIndex:j];
        
        // NSLog(@"!!item..............:%@",cals);
        
        NSString *time=[cals objectForKey:@"recordtime"];
        
        [timeData addObject:@([time longLongValue])];
        
        NSString *calsValue=[cals objectForKey:@"total_cals"];
        
        
        [calsData addObject:@([calsValue longLongValue])];
        
        
        //NSLog(@"%@..........1........%@",calsValue,time);
        
        
        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1];
        d1x.itemCount = [calsData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [calsData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:-1];
        };
    }
    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
        d3x.itemCount = [calsburnData count];
        
        
        [calsTimeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [calsTimeData[item] floatValue];
            float y = [calsburnData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:1];
        };
    }
    
    CGRect rect = CGRectMake(0, 0,360 , 180);
    
    LineChartView *calsChart=[[LineChartView alloc] initWithFrame:rect];
    

    
    calsChart.yMin = 500;
    calsChart.yMax = 2000;
    calsChart.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    calsChart.data = @[d1x,d3x];
    
    
    NSNumber *max_food=[calsData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_food=[calsData valueForKeyPath:@"@min.self"];
    
    NSNumber *max_cals=[calsburnData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_cals=[calsburnData valueForKeyPath:@"@min.self"];
    
    
    
    int max_cals_value=max_food.floatValue>max_cals.floatValue?max_food.intValue:max_cals.intValue;
    
    int min_cals_value=min_food.floatValue<min_cals.floatValue?min_food.intValue:min_cals.intValue;
    
    
    // NSLog(@"%d.....hr test.....%d",max_cals_value,min_cals_value);
    
    if (max_cals_value>2000) {
        
        
        calsChart.yMax = max_cals_value+10;
        
    }
    
    if (min_cals_value<500&&min_cals_value>=0) {
        
        
        calsChart.yMin = min_cals_value-10<0?0:min_cals_value-10;
        
    }
    
    
    calsChart.startColor=[UIColor colorWithRed:94.0f/255.0f green:124.0f/255.0f blue:200.0f/255.0f alpha:1];
    
    calsChart.endColor=[UIColor colorWithRed:37.0f/255.0f green:66.0f/255.0f blue:127.0f/255.0f alpha:1];
    
    
    //calsChart.yMin = 0;
    //calsChart.yMax = 2000;
    
    calsChart.xMin = [recordEnd timeIntervalSince1970];
    calsChart.xMax = [recordStart timeIntervalSince1970];
    
    calsChart.ySteps = @[@"100",@"120",@"140",@"160",@"180",@"200"];
    calsChart.data = @[d1x,d3x];
    
    
    calsChart.drawsDataPoints = YES;
    
    calsChart.drawsDataLines = YES;
    
    calsChart.drawsBG=YES;
    
    calsChart.enableTouch=NO;
    
    calsChart.isRotate=YES;
    
    calsChart.xLabelCount=period;
    
    calsChart.isWatch=1;
    
    [calsChart setNeedsDisplay];
    
    UIImage *image=[calsChart graphImage];
    
    NSData* imageData = UIImageJPEGRepresentation(image,1);
    
    NSString *imageString =[imageData base64EncodedStringWithOptions:NO];
    
    
    return imageString;
    
}


- (NSOperationQueue *)operationQueue
{
            if (_operationQueue == nil)
            {
                _operationQueue = [NSOperationQueue new];
            }
            return _operationQueue;
}



- (BOOL)isAllNum:(NSString *)text{
    unichar c;
    for (int i=0; i<text.length; i++) {
        c=[text characterAtIndex:i];
        if(c>'0'&&c<'9'){
            continue;
        }else{
            return false;
        }
    }
    return YES;
}




@end
