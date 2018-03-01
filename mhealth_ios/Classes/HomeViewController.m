//
//  HomeViewController.m
//  mHealth
//
//  Created by sngz on 13-12-30.
//
//


#import "HomeViewController.h"
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

#import "RNCryptor.h"
#import "RNEncryptor.h"
#import "RNDecryptor.h"

#import "SyncGame.h"

#import "NSNotificationCenter+MainThread.h"
#import "LearnMoreFirstViewController.h"

#import "Alarm.h"
#import "syncMessage.h"
//#import "CalsHistoryDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    int getDataCount;
    int getChatDataCount;
}

@synthesize BPUIButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"HomeViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
       
        self = [super initWithNibName:@"HomeViewController" bundle:nibBundleOrNil];
    }
    if (self) {
        
        [self reloadViewText];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
               NSString *strWarn=[defaults objectForKey:@"strWarn"];
    if ([strWarn isEqualToString:@""]||[strWarn isEqualToString:@"(null)"]||strWarn==nil||strWarn==NULL)
    {
        strWarn=@"normal";
    }
           //  strWarn=@"Remind_4214";
            if ([strWarn isEqualToString:@"normal"]) {
                // normal
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@" " forKey:@"update_HealthReach_Day"];
                [defaults synchronize];
            }
            else if([strWarn isEqualToString:@"force"])
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@" " forKey:@"update_HealthReach_Day"];
                [defaults synchronize];
                //force
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
                NSString *tempHenderText=[Utility getStringByKey:@"HealthReach Calendar"];
                if ([tempHenderText isEqualToString:@"HealthReach Calendar"]) {
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
                
                if ([tempHenderText isEqualToString:@"HealthReach Calendar"]) {
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
                
                
                NSLog(@"!~~~~~~~~!~!~!!~!~!~!!~!~!~!~");
                
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
                    NSString *tempHenderText=[Utility getStringByKey:@"HealthReach Calendar"];
                    if ([tempHenderText isEqualToString:@"HealthReach Calendar"]) {
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
                    
                  
                    if ([tempHenderText isEqualToString:@"HealthReach Calendar"]) {
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
                }
                
                
            }
            

    
    
    
    

    // Do any additional setup after loading the view from its nib.
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  
    
    
    
    [defaults setObject: @"Y" forKey: @"Frist Go to Calendar Key"];
 
    


//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(syncAllDataInHome) object:nil];
//    [thread start];
    


    NSString *theflaseTP=[self bownTheTP100];
    [defaults setObject:theflaseTP forKey:@"The number of training false"];
    NSLog(@"theflaseTP=theflaseTP=theflaseTP=theflaseTP=theflaseTP=%@",theflaseTP);
    [defaults setBool: true forKey: @"reallogin"];
    [defaults synchronize];
//
    
//    
//    DBHelper *dababa=[[DBHelper alloc]init];
//    NSMutableArray *array=[dababa todayMeasurement];
//    NSLog(@"NSMutableArray *array=[dababa todayMeasurement],array=%@",array);

    
}

- (void)uploadUnloadData
{
//    NSMutableArray *uploadBPNotUploadArray = [DBHelper getBPNotUpload];
//    [syncBP uploadBPNotUpload:uploadBPNotUploadArray];
//
//    NSMutableArray *uploadFoodNotUploadArray = [DBHelper getFoodNotUpload];
//    [syncCalories uploadFoodNotUpload:uploadFoodNotUploadArray];
//
//    [syncWeight uploadData];
//    
//    NSMutableArray *uploadBGNotUploadArray = [DBHelper getBGNotUpload];
//    [syncBG uploadBGNotUpload:uploadBGNotUploadArray];

}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)syncCalories {
    // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[syncBP syncAllBPData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_B_%@",[GlobalVariables shareInstance].login_id]]];
    [syncCalories checkFoodList];
    [syncCalories syncAllCaloriesData];
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromAPI" object:nil];
}


-(void)quit:(id)sender
{
    NSLog(@"Quit");
    NSMutableArray *muatarar=[[NSMutableArray alloc]initWithObjects:@"",@"" , nil];
    NSString *sss=[muatarar objectAtIndex:4];
    NSLog(@"%@",sss);
    
}


-(NSString *)bownTheTP100
{
    self.recordTTTT=[DBHelper getLatestTrainRecord];
  long starttime=  [self.recordTTTT getStarttime];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString * theFristTimeStr=[defaults objectForKey:@"Frist training time"];
//    long starttime=[theFristTimeStr intValue];
//    
    NSLog(@"startime==%ld",starttime);
    
    if (starttime<=0)
    {
        starttime= [[NSDate date] timeIntervalSince1970];

    }
    
    
    
    NSMutableArray *dateLabels=[[NSMutableArray alloc] initWithCapacity:7];
    
    NSDate *startDate=[[NSDate alloc] initWithTimeIntervalSince1970:starttime];

    int  lastResult=0;

    long nowtime = [[NSDate date] timeIntervalSince1970];
    
    NSLog(@"nowtime=%ld",nowtime);
    NSLog(@"starttime=%ld",starttime);
    
    long theSubtractiontime=nowtime-starttime;
    NSLog(@"theSubtractiontime=%ld",theSubtractiontime);
    long theSubtractionDay=theSubtractiontime/60/60/24;
    
    NSLog(@"theSubtractionDay=%ld",theSubtractionDay);
    if (theSubtractionDay>7) {
        theSubtractionDay=0;
    }
    for (int i=0; i<theSubtractionDay; i++) {

        
        NSDate *tmp=[startDate dateByAddingTimeInterval:24*60*60*i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
            [dateFormatter setDateFormat:@"yyyy年M月dd日"];
        } else {
            [dateFormatter setDateFormat:@"dd MMM yyyy"];
        }
        NSString *dateString = [dateFormatter stringFromDate:tmp];
        
        
        
        
        
        
        [dateLabels addObject:[NSString formatTimeddMMM:[tmp timeIntervalSince1970]]];
        
        
        NSLog(@"dateString:%@",dateString);
        
        //   [self.historyDateLabels addObject:dateString];
        
        
        //        [self.historyDateLabels addObject:[NSString formatTimeddMMMyyyy:[tmp timeIntervalSince1970]]];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
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
        
        //        NSLog(@"%d.....%d.....%d",year,month,day);
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
        
        NSLog(@"%@............start",[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]);
        
        NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
        
        NSLog(@"%@............end",[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]);
        
        //NSLog(@"%@........date.....%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
        
        
        NSLog(@"recordStart:%@",recordStart);
        NSLog(@"recordEnd:%@",recordEnd);
        NSLog(@"id:%ld",(long)[self.record.trainid integerValue]);
        
        
        NSMutableArray *cwResultArray = [DBHelper getCWRecordDate:[recordStart timeIntervalSince1970] enddate:[recordEnd timeIntervalSince1970] type:[self.record.trainid integerValue]];
        NSLog(@"cwResultArray.len:%lu",(unsigned long)cwResultArray.count);
        
        //NSLog(@"get count........%d",[cwResultArray count]);
  
        NSInteger temp_result=0;
        BOOL isfalse=true;
        for (int i=0; i<[cwResultArray count]; i++)
        {
            
            WalkingRecord *cwResult = [cwResultArray objectAtIndex:i];

           
 
                temp_result=[cwResult.result integerValue];
            if (temp_result>=100)
            {
                isfalse=false;
            }
            
          
        }
        
        if (isfalse==true)
        {
            lastResult++;
        }

    }
    
    NSString *lastResultStr =[[NSString alloc]initWithFormat:@"%d",lastResult];
    NSLog(@"lastResultStr======================%@",lastResultStr);
    
    return lastResultStr;
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

-(void)syncGraph{
    
    [SyncAverageChart syncAverageChartData];

    
}



-(void)syncNews{
    [syncMessage getAllNewsRecord];
}
-(void)syncMessage{
    [syncMessage getAllMessageRecord];
}



-(void)syncFoodDetails{

    NSMutableArray *datalist = [DBHelper getAllCaloriesRecords];
    
    for (int i=0; i<datalist.count; i++) {
        
        NSDictionary *fooddata=[datalist objectAtIndex:i];
        
        NSString *fooddetail=[fooddata objectForKey:@"record_detail"];
        
        
        if (fooddetail==nil||[fooddetail isEqualToString:@""]) {

            NSString *recordid=[fooddata objectForKey:@"record_id"];

            //NSLog(@"%@...foodtest....record id",recordid);
            
            NSString *fooddetail=[syncCalories getRecordDetailById:recordid];
            
            //NSLog(@"%@....foodtest...detail",fooddetail);
            
            [fooddata setValue:fooddetail forKey:@"record_detail"];

            
            [DBHelper updateFoodDetail:recordid foodRecordDetail:fooddetail];
        }
        
    }
    
    
}

- (void)syncBPWeekMonth {
    
    [syncBP syncBPMonthAndWeekData];
    
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getAverageBPAPIAlready" object:nil];
    
}

- (void)syncBGWeekMonth {
    
    [syncBG syncBGMonthAndWeekData];
    
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getAverageBGAPIAlready" object:nil];
    
    
}

- (void)syncWeightWeekMonth {
    
    [syncWeight syncWeightMonthAndWeekData];
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getAverageWeightAPIAlready" object:nil];

    
    
}

-(void)didFinishLoadWalkingAPIHome{
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"callAppDelegate" object:nil];
    NSLog(@"check here");
}




-(void)didFinishLoadGraphInDasboardAPIHome{
    
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"callAppDelegateDasboard" object:nil];
}


-(void)didFinishLoadAverageBPAPIHome{
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"callAppDelegateAverageBP" object:nil];
}

-(void)didFinishLoadAverageBGAPIHome{
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"callAppDelegateAverageBG" object:nil];
}



-(void)didFinishLoadAverageWeightAPIHome{
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"callAppDelegateAverageWeight" object:nil];
}




-(void)syncAllDataInHome{
    
  //  [self getMessageCount];
    
       
//    [self syncGameAPI];
//    [self syncCalories];
//    [self syncBPAPI];
//    [self syncWeightAPI];
//    [self syncBGAPI];
//    [self syncWalkingAPI];
//    [self syncCanlendarAPI];
    
    
    
    
    

    
    
    
    
    
    
    
    
    

   //
//    [SyncAverageChart syncAverageChartData];
    

    
    
    
    
    
    
    //vaycent edit
    
    //[syncBP syncBPMonthAndWeekData];
//    [syncWeight syncWeightMonthAndWeekData];
//    [syncBG syncBGMonthAndWeekData];
    
    //===============>
    
   
    
    
   
    
   
    
       // Do any additional setup after loading the view from its nib.
    

}



-(void)didFinishLoadDataFromAPI{
    getDataCount++;
    NSLog(@"getDataCount:%d",getDataCount);
    if(getDataCount==5){
        NSLog(@"It is time to hidden loading");
        _WaitingView.hidden=true;

        
        NSThread *threadGame = [[NSThread alloc]initWithTarget:self selector:@selector(syncGameAPI) object:nil];
        [threadGame start];
        
        NSThread *threadWalk = [[NSThread alloc]initWithTarget:self selector:@selector(syncWalkingAPI) object:nil];
        [threadWalk start];
        
        NSThread *threadGraph = [[NSThread alloc]initWithTarget:self selector:@selector(syncGraph) object:nil];
        [threadGraph start];
        
        NSThread *threadBPWeekMonth = [[NSThread alloc]initWithTarget:self selector:@selector(syncBPWeekMonth) object:nil];
        [threadBPWeekMonth start];
        
        NSThread *threadBGWeekMonth = [[NSThread alloc]initWithTarget:self selector:@selector(syncBGWeekMonth) object:nil];
        [threadBGWeekMonth start];
        
        NSThread *threadWeightWeekMonth = [[NSThread alloc]initWithTarget:self selector:@selector(syncWeightWeekMonth) object:nil];
        [threadWeightWeekMonth start];
        
        NSThread *threadFoodDetails = [[NSThread alloc]initWithTarget:self selector:@selector(syncFoodDetails) object:nil];
        [threadFoodDetails start];
        
        
//        NSThread *threadNews = [[NSThread alloc]initWithTarget:self selector:@selector(syncNews) object:nil];
//        [threadNews start];
//
        NSThread *threadMessage = [[NSThread alloc]initWithTarget:self selector:@selector(syncMessage) object:nil];
        [threadMessage start];

        
        
        //*************************************************
      
        

        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: @"N" forKey: @"loaddata"]; //設置下次不再force load
        [defaults synchronize];
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        NSLocale *locale;
        if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
            
            locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
            
            [formatter setDateFormat:@"MMM dd "];
            
        } else {
            
            
            locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            
            [formatter setDateFormat:@"dd MMM"];
            
        }
        
        [formatter setLocale:locale];
        
        NSDate *date = [NSDate date];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitWeekday |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        NSCalendarUnitSecond;
        
        comps = [calendar components:unitFlags fromDate:date];
        
        int year=(int)[comps year];
        
        float weight=[[Utility getWeight] floatValue]/2.2f;//get weight,unit is kg;
        float height=[[Utility getHeight] floatValue];//get height,unit is cm;
        float age=year-[[Utility getBirth] integerValue];//get age;

        
        BOOL isMale=[[Utility getGender] isEqualToString:@"M"];
        
        
        [sharedDefaults setObject: [NSString stringWithFormat:@"%f",weight] forKey: @"user_weight"];
        [sharedDefaults setObject: [NSString stringWithFormat:@"%f",height] forKey: @"user_height"];
        [sharedDefaults setObject: [NSString stringWithFormat:@"%f",age] forKey: @"user_age"];
        [sharedDefaults setObject: isMale?@"M":@"F" forKey: @"user_gender"];
        
        
        NSString *updatedateStr=[formatter stringFromDate:[NSDate date]];
        
        [sharedDefaults setObject: updatedateStr forKey: @"data_update_date"];
        [sharedDefaults synchronize];
       
    }
}

-(void)didFinishLoadChartData{
    getChatDataCount++;
    NSLog(@"getChatDataCount:%d",getChatDataCount);
    if(getChatDataCount==5){
        NSLog(@"didLoad ChatView Data");
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromAPI" object:nil];
        
         [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getGraphInDasboardAPIAlready" object:nil];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //NSLog(@"frame.....y:%f,x:%f",self.view.frame.origin.y,self.view.frame.origin.x);
    
    //NSLog(@"frame.....y:%f,x:%f",self.view.frame.origin.y,self.view.frame.origin.x);
    
    if (iPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        self.view.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    //NSLog(@"frame...222..y:%f,x:%f",self.view.frame.origin.y,self.view.frame.origin.x);
    

    [[UIApplication sharedApplication] setStatusBarOrientation:1 animated:NO];
    
    NSLog(@"come to HomeViewController viewWillAppear");
    //It is time to hidden loading
    
    
//    NSString *test1=[DBHelper encryptionString:@"AES"];
//    
//    NSLog(@"加密後：%@",test1);
//    
//    NSString *test2=[DBHelper decryptionString:test1];
//
//    NSLog(@"解密後：%@",test2);

    
    [self.dataLoading setText:[Utility getStringByKey:@"data_loading" ]];

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *loaddata=[defaults objectForKey:@"loaddata"];
    
    NSMutableArray  *medicationTikenidArray=[[NSMutableArray alloc ]initWithArray:[defaults objectForKey:@"Medication tiken id Array"]];
    
    NSMutableArray  *medicationTikenArray=[[NSMutableArray alloc ]initWithArray:[defaults objectForKey:@"Medication tiken Array"]];
    if ([medicationTikenidArray count]>0) {
        for (int i=0; i<medicationTikenidArray.count; i++)
        {
            Alarm* alarm=[[Alarm alloc]initWithMedicationId:[medicationTikenidArray objectAtIndex:i] Title:nil Meal:nil DosAge:nil Servertime:nil ReminderTime:nil ReminderID:nil ReminderType:nil ReminderRepeat:nil ReminderTicken:[medicationTikenArray objectAtIndex:i] ReminderCreateTime:@"" ReminderserverTime:nil ReminderImageString:@"" Note:@""];
            [DBHelper UPDateTakenMedication:alarm];
            
        }
      
    }
    

    if ([loaddata isEqualToString:@"Y"]) {
        
        
        //vaycent insert
        getDataCount=0;
        getChatDataCount=0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadDataFromAPI) name:@"getDataFromAPI" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadChartData) name:@"getDataFromChatAPI" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadWalkingAPIHome) name:@"getWalkingAPIAlready" object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadGraphInDasboardAPIHome) name:@"getGraphInDasboardAPIAlready" object:nil];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadAverageBPAPIHome) name:@"getAverageBPAPIAlready" object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadAverageBGAPIHome) name:@"getAverageBGAPIAlready" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadAverageWeightAPIHome) name:@"getAverageWeightAPIAlready" object:nil];
        
        
        
        
        NSThread *threadBP = [[NSThread alloc]initWithTarget:self selector:@selector(syncBPAPI) object:nil];
        [threadBP start];
        
        NSThread *threadWeight = [[NSThread alloc]initWithTarget:self selector:@selector(syncWeightAPI) object:nil];
        [threadWeight start];
        
        NSThread *threadBG = [[NSThread alloc]initWithTarget:self selector:@selector(syncBGAPI) object:nil];
        [threadBG start];

      
        NSThread *threadCalendar = [[NSThread alloc]initWithTarget:self selector:@selector(syncCanlendarAPI) object:nil];
        [threadCalendar start];
        
        NSThread *threadForCalories = [[NSThread alloc]initWithTarget:self selector:@selector(syncCalories) object:nil];
        [threadForCalories start];
       

    }else{
        
        _WaitingView.hidden=true;
        
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setIsHiddenWalkLoad];
         [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setIsHiddenDashBoard];
         [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setIsHiddenAverageBPLoad];
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setIsHiddenAverageBGLoad];
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setIsHiddenAverageWeightLoad];
        
        
        
    }
    
    
    
   
    
    [self reloadViewText];
    
    
    


    
    int checkReadMessage=[[defaults objectForKey:[NSString stringWithFormat:@"messageNotReadCount_%@",[GlobalVariables shareInstance].login_id]] intValue];
    int checkReadNews=[[defaults objectForKey:[NSString stringWithFormat:@"newsNotReadCount_%@",[GlobalVariables shareInstance].login_id]] intValue];
    
    NSLog(@"Count:---%d---%d",checkReadMessage,checkReadNews);
    int checkRead=checkReadMessage+checkReadNews;
    
    
    
    
    
    if(checkRead>0&&checkRead<10){
        
        
        
        NSString *temp = [[NSString alloc] initWithFormat:@"%d",checkRead];
        
        _readLabel1.text=temp;
        _readViewAll.hidden=false;
        _readView1.hidden=false;
        _readView2.hidden=true;
        _readView3.hidden=true;
        
    }
    else if(checkRead>=10&&checkRead<100){
        NSString *temp = [[NSString alloc] initWithFormat:@"%d",checkRead];

        _readLabel2.text=temp;
        _readViewAll.hidden=false;
        _readView1.hidden=true;
        _readView2.hidden=false;
        _readView3.hidden=true;
    }
    else if(checkRead>=100){
        NSString *temp = [[NSString alloc] initWithFormat:@"%d",checkRead];

        _readLabel3.text=temp;
        _readViewAll.hidden=false;
        _readView1.hidden=true;
        _readView2.hidden=true;
        _readView3.hidden=false;
    }
    else{
        _readViewAll.hidden=true;
        _readView1.hidden=true;
        _readView2.hidden=true;
        _readView3.hidden=true;
    }
    

    
    NSThread *uploadThread = [[NSThread alloc]initWithTarget:self selector:@selector(uploadUnloadData) object:nil];
    [uploadThread start];
    
    
    
    //share user info
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];

    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour|
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];
    
    int year=(int)[comps year];
    
    float weight=[[Utility getWeight] floatValue]/2.2f;//get weight,unit is kg;
    float height=[[Utility getHeight] floatValue];//get height,unit is cm;
    float age=year-[[Utility getBirth] integerValue];//get age;
    
    
    BOOL isMale=[[Utility getGender] isEqualToString:@"M"];
    
    
    [sharedDefaults setObject: [NSString stringWithFormat:@"%f",weight] forKey: @"user_weight"];
    [sharedDefaults setObject: [NSString stringWithFormat:@"%f",height] forKey: @"user_height"];
    [sharedDefaults setObject: [NSString stringWithFormat:@"%f",age] forKey: @"user_age"];
    [sharedDefaults setObject: isMale?@"M":@"F" forKey: @"user_gender"];

    [sharedDefaults synchronize];

    
    
//    BaseNavigationController *navController;
//    for (int i=0; i<[navController.viewControllers count]; i++) {
//
//        UIViewController *view=[navController.viewControllers objectAtIndex:i];
//        NSLog(@"test the page %d :%@",i,view);
//    }
    
    
    
    
    
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
    
    //fb share
//    NSString *texttoshare = @"http://www.google.com"; //this is your text string to share
//    //UIImage *imagetoshare = _img; //this is your image to share
//    NSArray *activityItems = @[texttoshare];
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
//    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
//    [self presentViewController:activityVC animated:TRUE completion:nil];
//    return;
    /*
    TestingCorePlotViewController *testingCPTview = [[TestingCorePlotViewController alloc]initWithNibName:@"TestingCorePlotViewController" bundle:nil];
    [self.navigationController pushViewController:testingCPTview animated:YES];
    */
    
    //[self showEcgAlertMessage];
    
//    NSString *contStr=[Constants getAPIBase1];
//    
//
//
//    
//    NSString *link;
//    if ([[Utility getLanguageCode] isEqualToString:@"en"])
//    {
////        link=@"http://202.140.96.155/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=ecg_not_support";
//        link=[[NSString alloc]initWithFormat:@"%@wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=ecg_not_support",contStr];
//    }
//    else{
////        link=@"http://202.140.96.155/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=ecg_not_support";
//        link=[[NSString alloc]initWithFormat:@"%@wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=ecg_not_support",contStr];
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
    
    DiaryViewController *__view=[[DiaryViewController alloc]initWithNibName:@"DiaryViewController" bundle:nil];
//  Alarm *alarm=[[Alarm alloc]init];
//    NSMutableArray *arrary=[alarm todayMeasurement];
//    NSLog(@" NSMutableArray *arrary=[alarm todayMeasurement];array=%@",arrary);
    [self.navigationController pushViewController:__view animated:YES];
}
-(IBAction)toAllChar:(id)sender
{
    DashBoardViewController *_allchar=[[DashBoardViewController alloc]initWithNibName:@"DashBoardViewController" bundle:nil];
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
    
    wfhView.dicCW=[[NSMutableDictionary alloc] initWithDictionary:self.dicCW];
     wfhView.dicTP=[[NSMutableDictionary alloc] initWithDictionary:self.dicTP];
    
        [self.navigationController pushViewController:wfhView animated:YES ];
//    }
    
    
    
   
}


-(void)syncBPAPI{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [syncBP syncAllBPData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_B_%@",[GlobalVariables shareInstance].login_id]]];
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromAPI" object:nil];

   
}
-(void)syncWeightAPI{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [syncWeight syncAllWeightData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_W_%@",[GlobalVariables shareInstance].login_id]]];
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromAPI" object:nil];

 }
-(void)syncBGAPI{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [syncBG syncAllBGData:[defaults objectForKey:[NSString stringWithFormat:@"server_update_date_G_%@",[GlobalVariables shareInstance].login_id]]];
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromAPI" object:nil];

  }
-(void)syncWalkingAPI{
    
    [SyncWalking syncAllWalkingData];
    
    
  
}

-(void) syncGameAPI{
   
    [SyncGame getPlantProgress];
    
    [SyncGame getTrophyProgress];

    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromAPI" object:nil];

 
}


-(void)syncCanlendarAPI{
    [DBHelper deleteCalendarBP];
    [DBHelper deleteCalendarBG];
    [DBHelper deleteCalendarECG];
    [DBHelper deleteCalendarOthers];
    [DBHelper deleteCalendarWalking];
    [DBHelper deleteCalendarMedication];
    
    if (self.isloginT==1)
    {
        [DiaryViewController cancelAnd_userCalendar];
        [DBHelper addSaveCalendar:2];
        
    }
    else
    {
        NSLog(@"");
    }
    [syncDaily getHistoryRecord];
    
    NSLog(@"--------------------------------------------------------------");
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromAPI" object:nil];

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




- (void)parserBG{
    
    [syncBG parserBGData];
}

- (void)parserBP{
    
    [syncBP parserBPData];
}

- (void)parserWeight{
    
    [syncWeight parserWeightData];
}


- (void)parserAverageBP{
    
    [syncUtility parserAverageBP];
}
- (void)parserAverageBG{
    
    [syncUtility parserAverageBG];
    
}
- (void)parserAverageWeight{
    
    [syncUtility parserAverageWeight];
    
}
- (void)parserAverageCW{
    
    [syncUtility parserAverageCW];
}
- (void)parserAverageTP{
    
    [syncUtility parserAverageTP];
    
}


@end
