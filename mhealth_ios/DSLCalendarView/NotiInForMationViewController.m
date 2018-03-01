//
//  NotiInForMationViewController.m
//  mHealth
//
//  Created by gz dev team on 14年11月24日.
//
//

#import "NotiInForMationViewController.h"
#import "HomeViewController.h"
#import "AddReminderViewController.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "NSString+URLEncoding.h"
#import "DBHelper.h"
#import "Alarm.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "TKAlertCenter.h"
#import "syncUtility.h"
@interface NotiInForMationViewController ()

@end

@implementation NotiInForMationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"NotiInForMationViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"NotiInForMationViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self textFontText];

}


-(void)textFontText
{
    [hendLabelFont setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    hendLabelFont.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _label1.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [btn_edit setTitle:[Utility getStringByKey:@"Done"] forState:UIControlStateNormal];
    btn_edit.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
        backGuangView.hidden=NO;
}
- (void)viewDidLoad
{
    

    
    NSLog(@"______________________---------------------------------------------------------------________________________________");
    [super viewDidLoad];
    
    _littleBackguandView.layer.cornerRadius = 12;//设置那个圆角的有多圆
    helthIcon.layer.cornerRadius = 12;//设置那个圆角的有多圆

    imageBackGuandView.layer.cornerRadius=12;
    NSString * ismHEalth=[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];
    
    if ([ismHEalth isEqualToString:@"HealthReach Calendar"])
    {
        reminder_backguand.text=@"Reminder:";
        NSString * btnBG=[[NSBundle mainBundle] pathForResource:@"00_reminder_ok_btn" ofType:@"png"];
        UIImage *imageBTn=[[UIImage alloc]initWithContentsOfFile:btnBG];
        [thatisOKbuttonText setImage:imageBTn forState:UIControlStateNormal];
    }
    else
    {
        reminder_backguand.text=@"提示:";
        NSString * btnBG=[[NSBundle mainBundle] pathForResource:@"00_reminder_ok_ch_btn" ofType:@"png"];
        UIImage *imageBTn=[[UIImage alloc]initWithContentsOfFile:btnBG];
        [thatisOKbuttonText setImage:imageBTn forState:UIControlStateNormal];
    }
    self.titleAdhocArray=[self.medicationDic objectForKey:@"others_title"];
    self.startTimesArray=[self.medicationDic objectForKey:@"others_starttime"];
    self.endTimesArray=[self.medicationDic objectForKey:@"others_endtime"];
    self.adHoNote=[self.medicationDic objectForKey:@"others_note"];
    self.adDateDate=[self.medicationDic objectForKey:@"others_date"];
    for (int i= 0; i<self.titleAdhocArray.count; i++)
    {
        if ([self.alaicBody isEqualToString:[self.titleAdhocArray objectAtIndex:i]])
        {
            
            
            self.str1=[Utility getStringByKey:@"Others"];
            self.str2=[self.titleAdhocArray objectAtIndex:i];
            
            self.str3=[self.adHoNote objectAtIndex:i];
            self.str4=[self.adDateDate objectAtIndex:i];
            
            self._timeStart=[self.startTimesArray objectAtIndex:i];
            
            self._timeEnd=[self.endTimesArray objectAtIndex:i];
            self.otherID=[self.adHocID objectAtIndex:i];
            

            
            
        }
    }
    
    
    
    
    other_backguand.text=self.alaicBody;
     [other_backguand setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20]];
    
    
    _label1.text=self.str1;
        _label2.text=self.str2;
        
        
        
        _label2.textColor= [UIColor colorWithRed:50/255.0 green:140/255.0 blue:140/255.0 alpha:1];
        _label2.numberOfLines=10;
        
        [_label2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20]];
        
        [_label2 sizeToFit];
        _label2.frame=CGRectMake(25, 48, 250, _label2.frame.size.height+5);
        
        _label3=[[UILabel alloc] initWithFrame:CGRectMake(25, _label2.frame.size.height+48+10, 300, 100)];
    NSString * timeStrRain111=[self.str4 substringWithRange:NSMakeRange(8,2)];
    
    NSString * timeStrRain222=[self.str4  substringWithRange:NSMakeRange(0,4)];
    NSString *timeStrRain333=[self.str4  substringWithRange:NSMakeRange(5, 2)];
    NSString * allTheDay;
    if ([timeStrRain333 isEqualToString:@"01"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Jan %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"02"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Feb %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"03"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Mar %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"04"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Apr %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"05"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"May %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"06"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Jun %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"07"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Jul %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"08"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Aug %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"09"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Sep %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"10"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Oct %@",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"11"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"Nov %@",timeStrRain222];
    }
    else
    {
        allTheDay=[[NSString alloc]initWithFormat:@"Dec %@",timeStrRain222];
    }
    NSLog(@"<<<%@-%@-%@>>>",timeStrRain111,allTheDay,timeStrRain222);
    NSString *english_OR_chinese=[[NSString alloc]initWithFormat:@"%@",[Utility getStringByKey:@"HealthReach Calendar"]];
    NSString *sumDay;
    if ([english_OR_chinese isEqualToString:@"HealthReach Calendar"]) {
        sumDay=[[NSString alloc]initWithFormat:@"%@ %@",timeStrRain111,allTheDay];
    }
    else
    {
        sumDay=[[NSString alloc]initWithFormat:@"%@年%@月%@日",timeStrRain222,timeStrRain333,timeStrRain111];
    }
    
    
    
        NSString *str1=[[NSString alloc] initWithFormat:@"%@\r%@-%@",sumDay,self._timeStart,self._timeEnd];
        _label3.text=str1;
        _label3.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        
        _label3.numberOfLines=3;
        _label3.backgroundColor=[UIColor clearColor];
        
        
        _label3.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:26];
        [_label3 sizeToFit];
        _label3.frame=CGRectMake(25, _label2.frame.size.height+48+10, 250, _label3.frame.size.height+5);
        [aView addSubview:_label3];
        
        _label4=[[UILabel alloc] initWithFrame:CGRectMake(25, _label2.frame.size.height+10+40+30+_label3.frame.size.height, 250, 200)];
        _label4.text=self.str3;
        
        _label4.backgroundColor=[UIColor clearColor];
        
        _label4.numberOfLines=10;
        
        _label4.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
        
        [_label4 sizeToFit];
        _label4.frame=CGRectMake(25, _label2.frame.size.height+10+40+30+_label3.frame.size.height, 250, _label4.frame.size.height+5);
        
        _label3.backgroundColor=[UIColor clearColor];
        _label4.backgroundColor=[UIColor clearColor];
        [aView addSubview:_label4];
        
 
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)GoHome:(id)sender
{
    int homeIndex=1;
    
    for (int i=0; i<[self.navigationController.viewControllers count]; i++) {
        
        UIViewController *view=[self.navigationController.viewControllers objectAtIndex:i];
        
        
        if ([view isMemberOfClass:[HomeViewController class]]) {
            
            homeIndex=i;
        }
        
    }
    
    
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: homeIndex] animated:YES];
   
}
//-(IBAction)back:(id)sender
//{
//     [self.navigationController popViewControllerAnimated:YES];
//}
-(IBAction)thatisOK:(id)sender
{
        
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   NSString * strWarn=[defaults objectForKey:@"strWarn"];
    if ([strWarn isEqualToString:@""]||[strWarn isEqualToString:@"(null)"]||strWarn==nil||strWarn==NULL)
    {
        strWarn=@"normal";
    } 

            //         strWarn=@"Remind_4214";
            if ([strWarn isEqualToString:@"normal"]) {
                // normal
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@" " forKey:@"update_HealthReach_Day"];
                [defaults synchronize];
                if ([self.alaicBody isEqualToString:@"Exercise"]||[self.alaicBody isEqualToString:@"運動"]) {
                    
                    
                    
                    
                }
                else
                {
                    backGuangView.hidden=YES;
                }
                
                
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
                label1.text=[Utility getStringByKey:@"Quit"];
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
                label2.text=[Utility getStringByKey:@"Update"];
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
                    label1.text=[Utility getStringByKey:@"Remind me later"];
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
                    label2.text=[Utility getStringByKey:@"Update now"];
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
                else
                {
                    backGuangView.hidden=YES;
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
    if ([self.alaicBody isEqualToString:@"Exercise"]||[self.alaicBody isEqualToString:@"運動"]) {
        
        
        NSMutableArray * annay=[[NSMutableArray alloc]initWithObjects:@"",@"", nil];
        NSString *a=[annay objectAtIndex:9];
        NSLog(@"a=%@",a);
        
        
    }
    else
    {
        backGuangView.hidden=YES;
    }
    
}
-(void)upDateNow:(id)sender
{
    NSLog(@"Update now");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id910396784"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
