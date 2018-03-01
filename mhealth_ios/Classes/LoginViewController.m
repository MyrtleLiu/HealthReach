//
//  LoginViewController.m
//  mHealth
//
//  Created by sngz on 13-12-24.
//
//

#import "LoginViewController.h"
#import "NSString+Utils.h"
#import "HomeViewController.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "BaseNavigationController.h"
#import "Utility.h"
#import "DBHelper.h"
#import "BloodPressure.h"
#import "UserInfoViewController.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "syncUtility.h"
#import "NoNetWorkViewController.h"
#import "syncAlertLevel.h"
#import "syncBP.h"
#import "syncWeight.h"
#import "syncBG.h"
#import "SyncWalking.h"
#import "SyncAverageChart.h"
#import "webViewLinkViewController.h"
#import "SyncGame.h"


@interface LoginViewController (){
    
}

@end

@implementation LoginViewController



//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//       self = [super initWithNibName:@"LoginViewController" bundle:nibBundleOrNil];
//       return self;
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    NSLog(@"Login viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *strWarn=[defaults objectForKey:@"strWarn"];
    
    if ([strWarn isEqualToString:@""]||[strWarn isEqualToString:@"(null)"]||strWarn==nil||strWarn==NULL)
    {
        strWarn=@"normal";
    }
    
        //   strWarn=@"Remind_42";
            if ([strWarn isEqualToString:@"normal"]) {
                // normal
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@" " forKey:@"update_HealthReach_Day"];
                [defaults synchronize];
            }
            else if([strWarn isEqualToString:@"force"])
            {
                //force
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@" " forKey:@"update_HealthReach_Day"];
                [defaults synchronize];
                appForceView=[[UIView alloc] init];
                
                imagehandImageView=[[UIImageView alloc]init];
                
                [imagehandImageView setImage:[UIImage imageNamed:@"01_index_header_p1b.png"]];
                
                healthReachImageView=[[UIImageView alloc]init];
                
                NSString *ver = [[UIDevice currentDevice] systemVersion];
                float ver_float = [ver floatValue];
                if (ver_float >= 7.0)
                {
                    //iOS >=7
                    imagehandImageView.frame=CGRectMake(0, 20, 320, 50);
                    healthReachImageView.frame=CGRectMake(20, 12+20, 162, 25);
                    appForceView.frame=CGRectMake(0, 20, 320, 548);
                }  
                else{  
                    //iOS <7
                    imagehandImageView.frame=CGRectMake(0, 0, 320, 50);
                    healthReachImageView.frame=CGRectMake(20, 12, 162, 25);
                    appForceView.frame=CGRectMake(0, 0, 320, 548);
                }
                if (iPad) {
                    imagehandImageView.frame=CGRectMake(0, 0, 320, 50);
                    healthReachImageView.frame=CGRectMake(20, 12, 162, 25);
                    appForceView.frame=CGRectMake(0, 0, 320, 548);
                }
             
                
                
                appForceView.backgroundColor=[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
                
                
                UIView *blackLittleView=[[UIView alloc]initWithFrame:CGRectMake(60, 170, 200, 180)];
                blackLittleView.backgroundColor=[UIColor blackColor];
                
                UILabel *labelText=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 190, 100)];
                if ([[Utility getLanguageCode] isEqualToString:@"en"])
                {
                    [healthReachImageView setImage:[UIImage imageNamed:@"01_index_logo.png"]];
                    labelText.text=@"A new version of HealthReach™\n has been launched.\n Please update now.";
                }
                else{
                    [healthReachImageView setImage:[UIImage imageNamed:@"00_logo.png"]];
                    labelText.text=@"健易達™最新版本已經推出\n請立即更新。";
                }
                
                
                labelText.textAlignment=NSTextAlignmentCenter;
                labelText.textColor=[UIColor whiteColor];
                labelText.numberOfLines=3;
                labelText.font=[UIFont systemFontOfSize:12];
                
                [blackLittleView addSubview:labelText];
                
                
                UIButton *buttonRed=[UIButton buttonWithType:UIButtonTypeCustom];
                buttonRed.frame=CGRectMake(10, 145, 85, 25);
                [buttonRed setImage:[UIImage imageNamed:@"00_btn_red_p1.png"] forState:UIControlStateNormal];
                
                [buttonRed addTarget:self action:@selector(quit:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
              
                NSString *tempHand=[Utility getStringByKey:@"HealthReach Calendar"];
                if ([tempHand isEqualToString:@"HealthReach Calendar"]) {
                    label1.text=@"Quit";

                }
                else
                {
                    label1.text=@"離開";

                }
                

                
                
                
                
                label1.textAlignment=NSTextAlignmentCenter;
                label1.backgroundColor=[UIColor clearColor];
                label1.textColor=[UIColor whiteColor];
                [buttonRed addSubview:label1];
                
                [blackLittleView addSubview:buttonRed];
                
                
                
                
                
                
                UIButton*buttonGreen=[UIButton buttonWithType:UIButtonTypeCustom];
                buttonGreen.frame=CGRectMake(10+85+10, 145, 85, 25);
                [buttonGreen setImage:[UIImage imageNamed:@"00_btn_green_p1.png"] forState:UIControlStateNormal];
                [buttonGreen addTarget:self action:@selector(upDate:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
           
                if ([tempHand isEqualToString:@"HealthReach Calendar"]) {
                    label2.text=@"Update";
                    
                }
                else
                {
                    label2.text=@"更新";
                    
                }
                label2.textAlignment=NSTextAlignmentCenter;
                label2.backgroundColor=[UIColor clearColor];
                label2.textColor=[UIColor whiteColor];
                [buttonGreen addSubview:label2];
                
                [blackLittleView addSubview:buttonGreen];
                
                
                [appForceView addSubview:blackLittleView];
                [self.view addSubview:appForceView];
                [self.view addSubview:imagehandImageView];
                [self.view addSubview:healthReachImageView];
                
                
                
                
                
                
                
            }
            else
            {
                
                //remind_x
                NSString *remind_x=@"1" ;
                if ([strWarn length]>7)
                {
                    remind_x = [strWarn substringFromIndex:7];
                    
                }
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString * old_remind_x=  [defaults objectForKey:@"update_HealthReach_Day"];
                
                if ([remind_x intValue]!=[old_remind_x intValue])
                {
                    
                    appForceView=[[UIView alloc] init];
                    
                    imagehandImageView=[[UIImageView alloc]init];
                    
                    [imagehandImageView setImage:[UIImage imageNamed:@"01_index_header_p1b.png"]];
                    
                    healthReachImageView=[[UIImageView alloc]init];
                    
                    NSString *ver = [[UIDevice currentDevice] systemVersion];
                    float ver_float = [ver floatValue];
                    if (ver_float >= 7.0)
                    {
                        //iOS >=7
                        imagehandImageView.frame=CGRectMake(0, 20, 320, 50);
                        healthReachImageView.frame=CGRectMake(20, 12+20, 162, 25);
                        appForceView.frame=CGRectMake(0, 20, 320, 548);
                    }
                    else{
                        //iOS <7
                        imagehandImageView.frame=CGRectMake(0, 0, 320, 50);
                        healthReachImageView.frame=CGRectMake(20, 12, 162, 25);
                        appForceView.frame=CGRectMake(0, 0, 320, 548);
                    }
                    
                    if (iPad) {
                        imagehandImageView.frame=CGRectMake(0, 0, 320, 50);
                        healthReachImageView.frame=CGRectMake(20, 12, 162, 25);
                        appForceView.frame=CGRectMake(0, 0, 320, 548);
                    }
                    
                    appForceView.backgroundColor=[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
                    
                    
                    UIView *blackLittleView=[[UIView alloc]initWithFrame:CGRectMake(60, 170, 200, 180)];
                    blackLittleView.backgroundColor=[UIColor blackColor];
                    
                    UILabel *labelText=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 190, 100)];
                    if ([[Utility getLanguageCode] isEqualToString:@"en"])
                    {
                        [healthReachImageView setImage:[UIImage imageNamed:@"01_index_logo.png"]];
                        NSString *strEn=[[NSString alloc]initWithFormat:@"A new version of HealthReach™ has been launched. For a better experience, Please update it within %@ days.",remind_x];
                        labelText.numberOfLines=4;
                        labelText.text=strEn;
                    }
                    else{
                        [healthReachImageView setImage:[UIImage imageNamed:@"00_logo.png"]];
                        NSString *strCh=[[NSString alloc] initWithFormat:@"健易達™最新版本已經推出。\n為達更佳體驗，\n請於%@天內更新。",remind_x];
                        labelText.text=strCh;
                        labelText.numberOfLines=3;
                    }
                    
                    labelText.textAlignment=NSTextAlignmentCenter;
                    labelText.textColor=[UIColor whiteColor];
                    
                    labelText.font=[UIFont systemFontOfSize:12];
                    
                    [blackLittleView addSubview:labelText];
                    
                    
                    UIButton *buttonRed=[UIButton buttonWithType:UIButtonTypeCustom];
                    buttonRed.frame=CGRectMake(10, 145, 85, 25);
                    [buttonRed setImage:[UIImage imageNamed:@"00_btn_red_p1.png"] forState:UIControlStateNormal];
                    
                    [buttonRed addTarget:self action:@selector(remindMeLater:) forControlEvents:UIControlEventTouchUpInside];
                    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
                    
                    NSString *tempHand=[Utility getStringByKey:@"HealthReach Calendar"];
                    if ([tempHand isEqualToString:@"HealthReach Calendar"]) {
                        label1.text=@"Remind me later";
                        
                    }
                    else
                    {
                        label1.text=@"稍後更新";
                        
                    }
                    label1.textAlignment=NSTextAlignmentCenter;
                    label1.backgroundColor=[UIColor clearColor];
                    label1.textColor=[UIColor whiteColor];
                    [buttonRed addSubview:label1];
                    if ([label1.text isEqualToString:@"Remind me later"]) {
                        label1.font=[UIFont systemFontOfSize:9];
                    }
                    else
                    {
                        label1.font=[UIFont systemFontOfSize:15];
                    }
                    [blackLittleView addSubview:buttonRed];
                    
                    
                    
                    
                    
                    
                    UIButton*buttonGreen=[UIButton buttonWithType:UIButtonTypeCustom];
                    buttonGreen.frame=CGRectMake(10+85+10, 145, 85, 25);
                    [buttonGreen setImage:[UIImage imageNamed:@"00_btn_green_p1.png"] forState:UIControlStateNormal];
                    [buttonGreen addTarget:self action:@selector(upDateNow:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
                    
                if ([tempHand isEqualToString:@"HealthReach Calendar"]) {
                        label2.text=@"Update now";
                    }
                    else
                    {
                        label2.text=@"立即跟新";
                    }
                  
                    label2.textAlignment=NSTextAlignmentCenter;
                    label2.backgroundColor=[UIColor clearColor];
                    label2.textColor=[UIColor whiteColor];
                    [buttonGreen addSubview:label2];
                    if ([label2.text isEqualToString:@"Update now"]) {
                        label2.font=[UIFont systemFontOfSize:9];
                    }
                    else
                    {
                        label2.font=[UIFont systemFontOfSize:15];
                    }
                    [blackLittleView addSubview:buttonGreen];
                    
                    
                    [appForceView addSubview:blackLittleView];
                    [self.view addSubview:appForceView];
                    [self.view addSubview:imagehandImageView];
                    [self.view addSubview:healthReachImageView];
                    
                    [defaults setObject:remind_x forKey:@"update_HealthReach_Day"];
                    [defaults synchronize];
                    
                    
                    
                    NSLog(@"121212121211212");
                    
                    
                    
                    
                    
                    
                }
            }
            
    
}




-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    if (iPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        self.view.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    }
    

    
    NSLog(@"show login page.....");
    
    loadView.hidden=false;
    
    NSString *lanuage = [Utility getLanguageCode];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];


    NSString *sessionid=[defaults objectForKey:@"sessionid"];
    
    NSString *login=[defaults objectForKey:@"login"];
    oldLogin=login;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//     NSString *build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    
    
    NSString *loginAPI=[Constants getAPIBase1];
    
    
    
    
    //NSString *login_url=@"http://202.140.96.155/wmc/jsp/mhealth/app_login.jsp?lang=en"; // en
    
    
    
   NSString *login_url =[NSString stringWithFormat:@"%@wmc/jsp/mhealth/app_login.jsp?lang=en",loginAPI];
    
    if (lanuage!=nil) {
        
        if ([lanuage isEqualToString:@"cn"]||[lanuage isEqualToString:@"zh"]) {// cn
            
//            login_url=@"http://202.140.96.155/wmc/jsp/mhealth/app_login.jsp?lang=zh";
            login_url =[NSString stringWithFormat:@"%@wmc/jsp/mhealth/app_login.jsp?lang=zh",loginAPI];
        }
    }
    
    if (sessionid!=nil&&login!=nil)
    {
        
        login_url=[NSString stringWithFormat:@"%@&sessionid=%@&login=%@",login_url,sessionid,login];
    }
    
    if(build!=nil)
        login_url=[NSString stringWithFormat:@"%@&verno=%@",login_url,build];
    
    
    
    login_url=[NSString stringWithFormat:@"%@&iscloudsupport=Y",login_url];
    
    login_url=[NSString stringWithFormat:@"%@&platform=%@",login_url,[[Utility deviceModelName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    login_url=[NSString stringWithFormat:@"%@&os=%@%@",login_url,@"iOS",[[UIDevice currentDevice] systemVersion]];
    

    
    loginView.delegate=self;
    @try {
        [loginView performSelectorOnMainThread:@selector(loadRequest:) withObject:[NSURLRequest requestWithURL:[NSURL URLWithString:login_url]] waitUntilDone:NO];
    }
    
    @catch (NSException *exception) {
        // NSLog(@"here..........%@",[exception debugDescription]);
        
    }
    @finally { 
    } 
    
    

//    float sysVer =[[[UIDevice currentDevice]systemVersion]floatValue];
//    if(sysVer>=7.0){
//        if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
//            self.automaticallyAdjustsScrollViewInsets=NO;
//        }
//    }


    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
    
    [sharedDefaults setObject: @"N" forKey: @"isLogin"];
    
    [sharedDefaults synchronize];
    
    
    
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

#pragma mark UIWebView delegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
//    loadView.hidden=false;
	
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *target=[[request URL] absoluteString];

    
    //cancel btn
    if([target rangeOfString:@"type=BackToApp"].location != NSNotFound ){
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL logincheck=[defaults boolForKey:@"reallogin"];
        NSLog(@"logincheck:%d",logincheck);

        if(logincheck){
            NSLog(@"11111111");
            exit(0);
            return false;
            
           
        }else{
            NSLog(@"2222222");

            [self.navigationController popViewControllerAnimated:YES];
            return false;
        }
        
        
    }
    
    
    if ([target rangeOfString:@"sessionid"].location != NSNotFound
        &&[target rangeOfString:@"login"].location != NSNotFound
        &&[target rangeOfString:@"LoginResult"].location != NSNotFound) {
        
        
        
        
       
        
        
        NSString *sessionid=[NSString getSubString:target fromStr:@"sessionid=" toStr:@"&"];
        
        NSString *login=[NSString getSubString:target fromStr:@"&login=" toStr:@"&"];

        
        NSString *loaddata=[NSString getSubString:target fromStr:@"forceload" toStr:@"N"];

        if ([loaddata isEqualToString:@""]) {
            
            loaddata=@"Y";
            
        }else{
            
            loaddata=@"N";
        }
        
        nowLogin=login;
        if (![sessionid isEqualToString:@""])
         {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             
             NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];

             [sharedDefaults setObject: @"Y" forKey: @"isLogin"];
             [sharedDefaults synchronize];
            
            [defaults setObject: sessionid forKey: @"sessionid"];
            [defaults setObject: login forKey: @"login"];
            [defaults setObject: loaddata forKey: @"loaddata"];
            [defaults synchronize];
            
            [GlobalVariables shareInstance].login_id = login;
            [GlobalVariables shareInstance].session_id = sessionid;
            
            if ([target rangeOfString:@"lang=zh"].location != NSNotFound) {
                NSLog(@"123132131313321321");
                [Utility setLanguage:@"cn"];
                
            }else{
                
                [Utility setLanguage:@"en"];
                
            }
             
            mHealth_iPhoneAppDelegate *mHealth_delegate =(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication]delegate];
            mHealth_delegate.session_id = sessionid;
            mHealth_delegate.login_id = login;
            BOOL result=[mHealth_delegate initDatabase:login];
             
             
             
             //
             [syncUtility getAllNewestDate_server];
             [syncUtility getPersonInfo];
             
             [syncUtility getMessageCount];
             [syncUtility getNewsCount];
             [syncAlertLevel syncAlertLevelData];

             
             
             
             
             
             
            if (result) {
                
                NSLog(@"init db ok.");
                
                //test db....
                
                
                
                //            NSDate *date=[NSDate date];
                
                //            long time=[date timeIntervalSince1970];
                
                //            BloodPressure *bp=[[BloodPressure alloc] initWithSys:@"sdlf" time:time dia:@"seef" heartrate:@"xcvsdf" status:1 missprevious:1];
                
                
                //            [DBHelper addBPRecord:bp];
                
                
                //            NSDate *date2=[NSDate date];
                
                //            long time2=[date2 timeIntervalSince1970];
                
                //            time2=time2-10000;
                //            NSLog(@"time2:%ld",time2);
                //            BloodPressure *bp2=[[BloodPressure alloc] initWithSys:@"111" time:time2 dia:@"222" heartrate:@"333" status:1 missprevious:1];
                
                //            [DBHelper addBPRecord:bp2];
                
                //            BloodPressureList *result2=[DBHelper getBPByDate:0 enddate:0 status:1];
                
                //            NSLog(@"count -----2-----%d",[result2.bpList count]);
                
                //            BloodPressure *test2=result2.bp;
                
                //            NSDate *resulttime2 = [NSDate dateWithTimeIntervalSince1970:[test2 getRecordtime]];
                
                //            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
                //            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                //            NSLog(@"sys:%@,dia:%@,hr:%@,status:%d,time:%@",test2.sys,test2.dia,test2.heartrate,[test2 getStatus],[dateFormat stringFromDate:resulttime2]);
                
                
                
            }
            
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            
            [defaults setObject: build forKey: @"version"];
            [defaults synchronize];
            
            //NSString *version=[defaults objectForKey:@"version"];
            //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            //[syncBP syncAllBPData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_B_%@",[GlobalVariables shareInstance].login_id]]];
            
           // [syncWeight syncAllWeightData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_W_%@",[GlobalVariables shareInstance].login_id]]];
            
            //[syncBG syncAllBGData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_G_%@",[GlobalVariables shareInstance].login_id]]];
            
//            NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(syncAllData) object:nil];
//            [thread start];
            
            //vaycent edit
//            NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(syncWalkingData) object:nil];
//            [thread2 start];
            
            NSLog(@"go to page.....");
            
           // loadView.hidden=true;
            
            
            if ([Utility getCloudStatus]!=nil&&![[Utility getCloudStatus] isEqualToString:@""]
                && [[Utility getCloudStatus] isEqualToString:@"INACTIVE"]) {
                
                webViewLinkViewController *webViewController = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
                [webViewController setLink:[Utility getCloudUrl]];
                [webViewController setIsSetupCloud:@"Y"];
                
                 if ([Utility isFirstTimeLogin]) {
                     
                     [self performSelectorOnMainThread:@selector(loadBlankPage) withObject:nil waitUntilDone:NO];
                     
                 }else{
                     
                     [self performSelectorOnMainThread:@selector(loadBlankPage) withObject:nil waitUntilDone:NO];
                     
                     if ([oldLogin isEqualToString:nowLogin]) {
                        
                         [webViewController setIsLoginT:@"0"];
                         
                     }
                     else
                     {

                         [webViewController setIsLoginT:@"1"];
                   [[UIApplication sharedApplication] cancelAllLocalNotifications];
                         
                     }
                 }
                
                [self.navigationController pushViewController:webViewController animated:YES];
                
                
            }else{
                
                if ([Utility isFirstTimeLogin]) {
                    // NSLog(@"111111111111111111");
                    
                    [self performSelectorOnMainThread:@selector(loadBlankPage) withObject:nil waitUntilDone:NO];
                    
                    UserInfoViewController *userInfo=[[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController_iphone5" bundle:nil];
                    
                    userInfo.from=@"login";
                    
                    [self.navigationController pushViewController:userInfo animated:NO ];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setBool: true forKey: @"checkFirstTimeSlide"];
                    
                }else{
                    //  NSLog(@"2222222222222222222");
                    
                    
                    [self performSelectorOnMainThread:@selector(loadBlankPage) withObject:nil waitUntilDone:NO];
                    // NSLog(@"check1");
                    
                    
                    HomeViewController *homeView=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
                    //NSLog(@"check2");
                    if ([oldLogin isEqualToString:nowLogin]) {
                        homeView.isloginT=0;
                    }
                    else
                    {
                        homeView.isloginT=1;
                        [[UIApplication sharedApplication] cancelAllLocalNotifications];
                    }
                    //NSLog(@"push home.................");
                    [self.navigationController pushViewController:homeView animated:NO ];
                    //NSLog(@"check3");
                    
                }

            }
            
            
            
           
    
    
        }
    
    }
    
    
    //loadView.hidden=true;
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	
    
	loadView.hidden=true;
    
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

    NSLog(@"Fail to load web: %@",error.description);
    
    if([error code]==NSURLErrorCancelled||[error.localizedDescription isEqualToString:@"Frame load interrupted"]||[error.localizedDescription isEqualToString:@"帧框加载已中断"]||[error.localizedDescription isEqualToString:@"頁框載入中斷"]){
        return;
        //
    }

    
    NoNetWorkViewController *loginView2=[[NoNetWorkViewController alloc] initWithNibName:@"NoNetWorkViewController" bundle:nil];
    [loginView2 setLink:@"login"];
    [self.navigationController pushViewController:loginView2 animated:YES];

}

- (void)loadBlankPage
{
    
    @try {
        
        
       
        [loginView loadHTMLString:@"" baseURL:nil];
        
        
    }
    @catch (NSException *exception) {
        
        //NSLog(@"here....2......%@",[exception debugDescription]);
    }
    @finally {
        
    }
    
    
    
}

-(void)syncWalkingData{
    
    [SyncWalking syncAllWalkingData];
}


-(void)syncAllData{

//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
//    [syncBP syncAllBPData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_B_%@",[GlobalVariables shareInstance].login_id]]];
    
//    [syncWeight syncAllWeightData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_W_%@",[GlobalVariables shareInstance].login_id]]];
//    [syncBG syncAllBGData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_G_%@",[GlobalVariables shareInstance].login_id]]];
    
    
//    [SyncAverageChart syncAverageChartData];
    
    

    
    
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
    
    return YES;
    
}



    
    
    
    
    
    
   
@end
