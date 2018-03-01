//
//  NotiMR_ListViewController.m
//  mHealth
//
//  Created by gz dev team on 14年11月24日.
//
//

#import "NotiMR_ListViewController.h"

#import "MR_ListViewController.h"
#import "HomeViewController.h"
#import "AddReminderViewController.h"
#import "InformaitionViewController.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "Utility.h"
#import "DBHelper.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "DayChickViewController.h"
#import <EventKit/EventKit.h>
#import "mHealth_iPhoneAppDelegate.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "NSString+URLEncoding.h"
#import "Alarm.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "TKAlertCenter.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "syncUtility.h"
@interface NotiMR_ListViewController ()

@end

@implementation NotiMR_ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"NotiMR_ListViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"NotiMR_ListViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}


#pragma mark - Scrol
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 40;
    //固定section 随着cell滚动而滚动
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [self TextFonts];


    
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
//{;
//     [self.navigationController popViewControllerAnimated:YES];
//}
-(void)TextFonts
{
    [mHealthHandTextFOnt setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    mHealthHandTextFOnt.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [msehsHandTextFont setText:[Utility getStringByKey:@"Events Summary"]];
    msehsHandTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    backGuangView.hidden=NO;
    [addReminderTextFont setTitle:[Utility getStringByKey:@"Done"] forState:UIControlStateNormal];
    addReminderTextFont.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [addEventButton setTitle:[Utility getStringByKey:@"Add Event"] forState:UIControlStateNormal];
    addEventButton.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    _littleBackguandView.layer.cornerRadius = 12;//设置那个圆角的有多圆
    helthIcon.layer.cornerRadius = 12;//设置那个圆角的有多圆
    ImageBackView.layer.cornerRadius=12;
    
    
    NSString * ismHEalth=[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];

    
    if ([ismHEalth isEqualToString:@"HealthReach Calendar"])
    {
        reminder_backguand.text=@"Reminder:";
        NSString * btnBG=[[NSBundle mainBundle] pathForResource:@"00_reminder_btn_ok_en" ofType:@"png"];
        UIImage *imageBTn=[[UIImage alloc]initWithContentsOfFile:btnBG];
        [backDoneBull setImage:imageBTn forState:UIControlStateNormal];
        NSString * btnBG1=[[NSBundle mainBundle] pathForResource:@"reminder_btn_entry" ofType:@"png"];
        UIImage *imageBTn1=[[UIImage alloc]initWithContentsOfFile:btnBG1];
        [thatisOKbuttonText setImage:imageBTn1 forState:UIControlStateNormal];
    }
    else
    {
        reminder_backguand.text=@"提示:";
        NSString * btnBG=[[NSBundle mainBundle] pathForResource:@"00_reminder_btn_ok" ofType:@"png"];
        UIImage *imageBTn=[[UIImage alloc]initWithContentsOfFile:btnBG];
        [backDoneBull setImage:imageBTn forState:UIControlStateNormal];
        NSString * btnBG1=[[NSBundle mainBundle] pathForResource:@"00_reminder_btn_entry (6)" ofType:@"png"];
        UIImage *imageBTn1=[[UIImage alloc]initWithContentsOfFile:btnBG1];
        [thatisOKbuttonText setImage:imageBTn1 forState:UIControlStateNormal];
    }
    [other_backguand setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];

    
    
    
    if ([self.str1 isEqualToString:@"Blood Pressure"]||[self.str1 isEqualToString:@"血壓"])
    {
        if ([self.str1 isEqualToString:@"Blood Pressure"]) {
                other_backguand.text=@"Blood Pressure Measurement";
        }
        else
        {
            other_backguand.text=@"量度血壓";
        }
        other_backguand.textColor=[UIColor redColor];
    }
    else if([self.str1 isEqualToString:@"ECG"]||[self.str1 isEqualToString:@"心電圖"])
    {
        if ([self.str1 isEqualToString:@"ECG"]) {
            other_backguand.text=@"ECG Measurement";
        }
        else
        {
            other_backguand.text=@"量度心電圖";
        }
        other_backguand.textColor=[UIColor orangeColor];
    }
    
    
    else if([self.str1 isEqualToString:@"Blood Glucose"]||[self.str1 isEqualToString:@"血糖"])
    {
        if ([self.str1 isEqualToString:@"Blood Glucose"]) {
            other_backguand.text=@"Blood Glucose Measurement";
        }
        else
        {
            other_backguand.text=@"量度血糖";
        }
        other_backguand.textColor=[UIColor purpleColor];
    }
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    
    self.dateDateStr= currentDateStr;
    
    
    self.titleMedicationArray=[self.diction objectForKey:@"me_title"];
    self.timesMedicationArray=[self.diction objectForKey:@"times"];
    self.dosageMedicationArray=[self.diction objectForKey:@"dosage"];
    
    
    self.timeBloodMutableArray=[self.diction objectForKey:@"bptime"];
    
    self.timeECGMutableArray=[self.diction objectForKey:@"ecgtime"];
    
    self.timeGlucoseMutableArray=[self.diction objectForKey:@"bgtime"];
    
    self.timeWalkMustableArray=[self.diction objectForKey:@"walktime"];
    
    self.titleAdhocArray=[self.diction objectForKey:@"others_title"];
    self.startTimesArray=[self.diction objectForKey:@"others_starttime"];
    self.endTimesArray=[self.diction objectForKey:@"others_endtime"];
    self.adHoNote=[self.diction objectForKey:@"others_note"];
    self.adDateDate=[self.diction objectForKey:@"others_date"];
    
    
  
    
    _tableView=[[UITableView alloc] initWithFrame:_table.bounds style: UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled=YES;
    _tableView.bounces=YES;
    
    [_table addSubview:_tableView];
    NSLog(@"%@==-===--",self.dateDateStr);
    
    
    self.addView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.addView.backgroundColor=[UIColor whiteColor];
    self.addView.alpha=0.6;
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(40, 180, 240, 200)];
    imageView.backgroundColor=[UIColor blackColor];
    imageView.layer.cornerRadius = 12;//设置那个圆角的有多圆
    imageView.userInteractionEnabled=YES;
    imageView.alpha=1;
    [self.view addSubview:imageView];
    UILabel*longlongLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 200, 100)];
    longlongLabel.text=@" Sorry, The conflict of the network, please try again later!";
    longlongLabel.textColor=[UIColor whiteColor];
    longlongLabel.backgroundColor=[UIColor clearColor];
    longlongLabel.numberOfLines=3;
    longlongLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    [imageView addSubview:longlongLabel];
    
    
    NSString*str22=[[NSBundle mainBundle]pathForResource:@"hr_btn_wa_green_2" ofType:@"png"];
    
    UIImage*greenImage=[[UIImage alloc]initWithContentsOfFile:str22];
    
    
    UIButton*yesButton=[UIButton buttonWithType:UIButtonTypeCustom];
    yesButton.frame=CGRectMake(70, 150, 90, 40);
    [yesButton setImage:greenImage forState:UIControlStateNormal];
    [yesButton addTarget:self action:@selector(addButtonYes) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:yesButton];
    imageView.hidden=YES;
    
    
    UILabel*yesLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 5, 30, 30)];
    yesLabel.textColor=[UIColor whiteColor];
    yesLabel.text=@"Yes";
    yesLabel.backgroundColor=[UIColor clearColor];
    [yesButton addSubview:yesLabel];
    
    
    
    
    [self.view addSubview:self.addView];
    self.addView.hidden=YES;
    
    
    
    
   // NSLog(@"self.BPcount====%d,self.ECGcount===%d,self.BGcount===%d",self.timeBloodMutableArray.count,self.timeECGMutableArray.count,self.timeGlucoseMutableArray.count);
//    self.isCalendar=[DBHelper isSave];
//    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadInMainMethod) object:nil];
//    [myThread start];
    
   
    
    
    
}

//
//-(IBAction)AddReminder:(id)sender
//{
//    
//    // [self saveEvent];
//    AddReminderViewController *homeView = [[AddReminderViewController alloc]initWithNibName:@"AddReminderViewController" bundle:nil];
//    homeView.dateDateStr=self.dateDateStr;
//    
//    homeView.timeGlucoseMutableArray=[[NSMutableArray alloc]init];
//    homeView.timeECGMutableArray=[[NSMutableArray alloc]init];
//    homeView.timeBloodMutableArray=[[NSMutableArray alloc]init];
//    homeView.timeWalkMutableArray=[[NSMutableArray alloc]init];
//    
//    homeView.timeBloodMutableArray  =self.timeBloodMutableArray ;
//    homeView.timeECGMutableArray=  self.timeECGMutableArray ;
//    homeView.timeGlucoseMutableArray =self.timeGlucoseMutableArray;
//    
//    homeView.timeWalkMutableArray=self.timeWalkMustableArray;
//    homeView.mediationidCOnt=self.medID.count;
//    [self.navigationController pushViewController:homeView animated:YES];
//    //[self dismissViewControllerAnimated:YES completion:nil];
//    //[self presentViewController:homeView animated:YES completion:nil];
//    
//    
//}


-(IBAction)addEvent:(id)sender
{
    AddReminderViewController *addReminder=[[AddReminderViewController alloc]initWithNibName:@"AddReminderViewController" bundle:nil];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    addReminder.dateDateStr=currentDateStr;
    
    [self.navigationController pushViewController:addReminder animated:YES];
    NSLog(@"addREMinder==%@",addReminder.dateDateStr);
    NSLog(@"self.View=%@",self.view);
      
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    static NSString*cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    // if (cell==nil) {
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                               reuseIdentifier:cellIdentifier];
    //  }
    cell.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    
    switch (indexPath.section) {
        case 0:
            
            if ([_measurementArray count]>0) {
                UILabel * _titles=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 130, 40)];
                _titles.text=[_measurementArray objectAtIndex:indexPath.row];
                UILabel *__times=[[UILabel alloc]initWithFrame:CGRectMake(140, 10, 170, 40)];
                [_titles sizeToFit];
                if ([_titles.text isEqualToString:[Utility getStringByKey:@"Blood Pressure"]])
                {
                    _titles.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:15];
                    _titles.textColor=[UIColor colorWithRed:255/255.0 green:20/255.0 blue:20/255.0 alpha:1];
                    _titles.backgroundColor=[UIColor clearColor];
                    NSString *bloodTimeStr=[NSString new];
                    for (int i=0; i<self.timeBloodMutableArray.count; i++)
                        
                    {
                        NSString *timeTrmp=[[NSString alloc]initWithFormat:@"%@ ",[self.timeBloodMutableArray objectAtIndex:i]];
                        bloodTimeStr=[bloodTimeStr stringByAppendingString:timeTrmp];
                    }
                    __times.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
                    __times.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    __times.text = bloodTimeStr;
                    __times.backgroundColor=[UIColor clearColor];
                    
                    __times.numberOfLines=2;
                    [__times sizeToFit];
                }
                if ([_titles.text isEqualToString:[Utility getStringByKey:@"ECG"]])
                {
                    _titles.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:15];
                    _titles.textColor=[UIColor orangeColor];
                    _titles.backgroundColor=[UIColor clearColor];
                    NSString *ecgTimeStr=[NSString new];
                    
                    for (int i=0; i<self.timeECGMutableArray.count; i++)
                    {
                        NSString *timeTrmp=[[NSString alloc]initWithFormat:@"%@ ",[self.timeECGMutableArray objectAtIndex:i]];
                        ecgTimeStr=[ecgTimeStr stringByAppendingString:timeTrmp];
                    }
                    
                    __times.text = ecgTimeStr;
                    __times.backgroundColor=[UIColor clearColor];
                    __times.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
                    __times.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    __times.numberOfLines=2;
                    [__times sizeToFit];
                    
                    
                }
                if ([_titles.text isEqualToString:[Utility getStringByKey:@"Blood Glucose"]])
                {
                    _titles.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:15];
                    _titles.textColor=[UIColor purpleColor];
                    _titles.backgroundColor=[UIColor clearColor];
                    NSString *glucoseTimeStr=[NSString new];
                    for (int i=0; i<self.timeGlucoseMutableArray.count; i++)
                    {
                        NSString *timeTrmp=[[NSString alloc]initWithFormat:@"%@ ",[self.timeGlucoseMutableArray objectAtIndex:i]];
                        glucoseTimeStr=[glucoseTimeStr stringByAppendingString:timeTrmp];
                    }
                    
                    __times.text = glucoseTimeStr;
                    __times.backgroundColor=[UIColor clearColor];
                    __times.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    __times.numberOfLines=2;
                    __times.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
                    [__times sizeToFit];
                    
                }
                _titles.frame=CGRectMake(10, 0, 140, _titles.frame.size.height+5);
                __times.frame=CGRectMake(140, 0, 170, __times.frame.size.height+5);
                [cell.contentView addSubview:__times];
                [cell.contentView addSubview:_titles];
            }
            else
            {
                cell.textLabel.text=0;
            }
            
            break;
        case 1:
            //Medication
            if (self.titleMedicationArray.count>0) {
                NSLog(@"-----=-=-============-====o=-==========self.timeMedicationArray=%@",self.timesMedicationArray);
                
                UILabel *titleText=[[UILabel alloc] initWithFrame:CGRectMake(10,10 , 110, 40)];
                titleText.text=[self.titleMedicationArray objectAtIndex:indexPath.row];
                
                titleText.numberOfLines=10;
                titleText.textColor=[UIColor colorWithRed:41/255.0 green:133/255.0 blue:173/255.0 alpha:1];
                titleText.backgroundColor=[UIColor clearColor];
                titleText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:15];
                [titleText sizeToFit];
                titleText.frame=CGRectMake(10, 0, 110, titleText.frame.size.height+5);
                
                [cell.contentView addSubview:titleText];
                
                
                
                UILabel *timesText=[[UILabel alloc]initWithFrame:CGRectMake(140, 10, 170, 40)];
                
                timesText.text=[self.timesMedicationArray objectAtIndex:indexPath.row];
                timesText.numberOfLines=2;
                timesText.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                timesText.backgroundColor=[UIColor clearColor];
                
                
                timesText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
                [timesText sizeToFit];
                timesText.frame=CGRectMake(140, 0, 170, timesText.frame.size.height+5);
                [cell.contentView addSubview:timesText];
                
                
                //self.madionHeight+=titleText.frame.size.height+10;
                
                
                
            }
            
            
            else
            {
                cell.textLabel.text = @" ";
                break;
            }
            break;
        case 2:
            //other
            
            if (self.titleAdhocArray.count>0) {
                
                UILabel * titleText=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 110, 40)];
                
                titleText.text=[self.titleAdhocArray objectAtIndex:indexPath.row];
                
                titleText.numberOfLines=10;
                titleText.textColor= [UIColor colorWithRed:50/255.0 green:140/255.0 blue:140/255.0 alpha:1];
                
                titleText.backgroundColor=[UIColor clearColor];
                [titleText setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:15]];
                [titleText sizeToFit];
                titleText.frame=CGRectMake(10, 0, 110, titleText.frame.size.height+5);
                [cell.contentView addSubview:titleText];
                
                UILabel *startDateText=[[UILabel alloc]initWithFrame:CGRectMake(140, 10, 180, 20)];
                
                
                
                
                NSString * timeStrRain111=[[self.adDateDate objectAtIndex:indexPath.row] substringWithRange:NSMakeRange(8,2)];
                
                NSString * timeStrRain222=[[self.adDateDate objectAtIndex:indexPath.row] substringWithRange:NSMakeRange(0,4)];
                NSString *timeStrRain333=[[self.adDateDate objectAtIndex:indexPath.row] substringWithRange:NSMakeRange(5, 2)];
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
                
                
                
                
                
                startDateText.text=sumDay;
                
                
                startDateText.backgroundColor=[UIColor clearColor];
                startDateText.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                startDateText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
                [startDateText sizeToFit];
                startDateText.frame=CGRectMake(140, 0, 180, startDateText.frame.size.height+5);
                [cell.contentView addSubview:startDateText];
                
                
                
                UILabel * startTimeText=[[UILabel alloc]initWithFrame:CGRectMake(140, 30, 80, 20)];
                NSString *strrr=[[NSString alloc]initWithFormat:@"%@ - %@",[self.startTimesArray objectAtIndex:indexPath.row],[self.endTimesArray objectAtIndex:indexPath.row]];
                startTimeText.text=strrr;
                
                [startTimeText sizeToFit];
                startTimeText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:14];
                startTimeText.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                startTimeText.backgroundColor=[UIColor clearColor];
                startTimeText.frame=CGRectMake(140, startDateText.frame.size.height, 180, startTimeText.frame.size.height+5);
                
                [cell.contentView addSubview:startTimeText];
   
                
                
                
                
            }
            
            else
            {
                cell.textLabel.text = @" ";
                break;
            }
            
            break;
        case 3:
            //walk
            if (self.timeWalkMustableArray.count>0) {
                UILabel *hendlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
                hendlabel.backgroundColor=[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
                
                
                UILabel * _titles=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 130, 40)];
                NSString *walkExercise=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"Exercise"]];
                _titles.text=walkExercise;
                
                UILabel *__times=[[UILabel alloc]initWithFrame:CGRectMake(140, 0, 170, 40)];
                
                
                
                _titles.textColor=[UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
                _titles.backgroundColor=[UIColor clearColor];
                NSString *walkingTimeStr=[NSString new];
                for (int i=0; i<self.timeWalkMustableArray.count; i++)
                    
                {
                    NSString *timeTrmp=[[NSString alloc]initWithFormat:@"%@ ",[self.timeWalkMustableArray objectAtIndex:i]];
                    walkingTimeStr=[walkingTimeStr stringByAppendingString:timeTrmp];
                }
                
                __times.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                __times.text = walkingTimeStr;
                __times.backgroundColor=[UIColor clearColor];
                
                __times.numberOfLines=2;
                
                
                __times.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
                _titles.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:15];
                [__times sizeToFit];
                __times.frame=CGRectMake(140, 10, 170, __times.frame.size.height+5);
                [cell.contentView addSubview:__times];
                
                [cell.contentView addSubview:_titles];
                [cell.contentView addSubview:hendlabel];
                
                
            }
            
            break;
            
        default:
            break;
            
    }
    NSString *imagestr=[[NSBundle mainBundle]pathForResource:@"hr_setting_icon_info" ofType:@"png"];
    UIImage * _imageimage=[[UIImage alloc]initWithContentsOfFile:imagestr];
    UIImageView *__imageViewimage=[[UIImageView alloc]initWithImage:_imageimage];
    __imageViewimage.frame=CGRectMake(300 , 10, 10 ,20);
    [cell.contentView addSubview:__imageViewimage];
    return cell;
    
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
    
    if ([(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsRunning])
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        
        float  idlength=[[GlobalVariables shareInstance].session_id length];
        NSLog(@"idlenggt======================%f-------------",idlength);
        if (idlength<8) {
            backGuangView.hidden=YES;
        }
        else
        {
            MR_ListViewController *homeView = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
            
            homeView.dateDateStr=currentDateStr;
            
            
            [self.navigationController pushViewController:homeView animated:YES];
        }
        
        
    }

}
-(void)upDateNow:(id)sender
{
    NSLog(@"Update now");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id910396784"]];
}


-(void)addButtonYes
{
    
}




//表头的代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   // NSLog(@"self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count=%d",self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count);
  //  NSLog(@"self.titleMedicationArray.count=%d",self.titleMedicationArray.count);
   // NSLog(@"self.titleAdhocArray=%d",self.titleAdhocArray.count);
    NSLog(@"self.timeWalkMustableArray.count>0=%d",self.timeWalkMustableArray.count>0);
    
    NSString *numberONE=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"Daily Measurement"]];
    NSString *numberTWO=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"Daily Medication"]];
    NSString *numberThree=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"Others"]];
    
    
    if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count>0&&self.titleAdhocArray.count>0&&self.timeWalkMustableArray.count>0 )
    {
        
        mr_ListArray=[[NSArray alloc]initWithObjects:numberONE,numberTWO,numberThree,@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count>0&&self.titleAdhocArray.count==0&&self.timeWalkMustableArray.count>0  )
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:numberONE,numberTWO,@"",@"", nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count==0&&self.titleAdhocArray.count>0&&self.timeWalkMustableArray.count>0 )
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:numberONE,@"",numberThree,@"", nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count>0&&self.titleAdhocArray.count>0&&self.timeWalkMustableArray.count>0 )
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:@"",numberTWO,numberThree,@"", nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count==0&&self.titleAdhocArray.count>0&&self.timeWalkMustableArray.count>0 )
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:@"",@"",numberThree,@"", nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count==0&&self.titleAdhocArray.count==0&&self.timeWalkMustableArray.count>0 )
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:numberONE,@"",@"",@"", nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count>0&&self.titleAdhocArray.count==0&&self.timeWalkMustableArray.count>0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:@"",numberTWO,@"",@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count>0&&self.titleAdhocArray.count>0&&self.timeWalkMustableArray.count==0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:numberONE,numberTWO,numberThree,@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count>0&&self.titleAdhocArray.count==0&&self.timeWalkMustableArray.count==0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:numberONE,numberTWO,@"",@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count==0&&self.titleAdhocArray.count>0&&self.timeWalkMustableArray.count==0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:numberONE,@"",numberThree,@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count==0&&self.titleAdhocArray.count==0&&self.timeWalkMustableArray.count==0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:numberONE,@"",@"",@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count>0&&self.titleAdhocArray.count>0&&self.timeWalkMustableArray.count==0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:@"",numberTWO,numberThree,@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count>0&&self.titleAdhocArray.count==0&&self.timeWalkMustableArray.count==0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:@"",numberTWO,@"",@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count==0&&self.titleAdhocArray.count>0&&self.timeWalkMustableArray.count==0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:@"",@"",numberThree,@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count==0&&self.titleAdhocArray.count==0&&self.timeWalkMustableArray.count>0)
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:@"",@"",@"",@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    
    else
    {
        mr_ListArray=[[NSArray alloc]initWithObjects:@"", @"",@"",@"",nil];
        return [mr_ListArray objectAtIndex:section];
    }
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle=[self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle==nil) {
        return nil;
    }
    else
    {
        UIView *sectionView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,320, 35)];
        
        if ([sectionTitle length]<2) {
            return nil;
        }
        // Create label with section title
        else
        {
            
            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
            label1.backgroundColor=[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
            
            UILabel *label=[[UILabel alloc] init];
            label.frame=CGRectMake(10, 10, 310, 20);
            label.textColor=[UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
            label.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:14];
            
            if ([sectionTitle isEqualToString:@"Walking:"]) {
                
                NSString *sstr2=[[NSString alloc]init];
                for (int obj=0; obj<self.timeWalkMustableArray.count; obj++)
                {
                    NSString *sstr=[[NSString alloc ]initWithFormat:@"%@ ",[self.timeWalkMustableArray objectAtIndex:obj]];
                   //m NSLog(@"self.TimeWalkKustableArray.count=%d,,,self.timeWalk=%@  ....str=%@",self.timeWalkMustableArray.count,[self.timeWalkMustableArray objectAtIndex:obj],sstr);
                    
                    sstr2 =[sstr2 stringByAppendingString:sstr];
                    
                }
                
                label.text=sectionTitle;
                UILabel *walkLabelTime=[[UILabel alloc]initWithFrame:CGRectMake(140, 0, 310-140, 20)];
                walkLabelTime.text=sstr2;
                walkLabelTime.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
                walkLabelTime.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                walkLabelTime.backgroundColor=[UIColor clearColor];
                [label addSubview:walkLabelTime];
                
                NSString *imagestr=[[NSBundle mainBundle]pathForResource:@"hr_setting_icon_info" ofType:@"png"];
                UIImage * _imageimage=[[UIImage alloc]initWithContentsOfFile:imagestr];
                UIImageView *__imageViewimage=[[UIImageView alloc]initWithImage:_imageimage];
                __imageViewimage.frame=CGRectMake(300 , 10, 10 ,20);
                [sectionView addSubview:__imageViewimage];
                
            }
            else
            {
                label.text=sectionTitle;
            }
            
            label.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            // Create header view and add label as a subview
            
            sectionView.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            
            [sectionView addSubview:label1];
            [sectionView addSubview:label];
        }
        return sectionView;
    }
}
//设置表头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle=[self tableView:tableView titleForHeaderInSection:section];
    if ([sectionTitle length] <2)
    {
        return 0;
    }
    else
    {
        
        return 30;
    }
    
}
//多少个section  多少个分区 跟文件调用要相同
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    //    if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count>0&&self.titleAdhocArray>0 )
    //    {
    //        return 3;
    //    }
    //   else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count>0&&self.titleAdhocArray==0 )
    //    {
    //        return 2;
    //    }
    //   else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count==0&&self.titleAdhocArray>0 )
    //   {
    //       return 2;
    //   }
    //   else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count>0&&self.titleAdhocArray>0 )
    //   {
    //       return 2;
    //   }
    //   else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count==0&&self.titleAdhocArray>0 )
    //   {
    //       return 1;
    //   }
    //   else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count>0&&self.titleMedicationArray.count==0&&self.titleAdhocArray==0 )
    //   {
    //       return 1;
    //   }
    //   else if (self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count==0&&self.titleMedicationArray.count>0&&self.titleAdhocArray==0 )
    //   {
    //       return 3;
    //   }
    //    else
    //    {
    //        return 0;
    //    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    switch (section) {
        case 0:
            if (self.timeBloodMutableArray.count>0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count>0) {
                _measurementArray=[[NSArray alloc]initWithObjects:[Utility getStringByKey:@"Blood Pressure"],[Utility getStringByKey:@"ECG"],[Utility getStringByKey:@"Blood Glucose"], nil];
                return 3;
            }
            else if (self.timeBloodMutableArray.count>0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count==0)
            {
                _measurementArray=[[NSArray alloc]initWithObjects:[Utility getStringByKey:@"Blood Pressure"],[Utility getStringByKey:@"ECG"], nil];
                return 2;
            }
            else if (self.timeBloodMutableArray.count>0&&self.timeECGMutableArray.count==0&&self.timeGlucoseMutableArray.count>0)
            {
                _measurementArray=[[NSArray alloc]initWithObjects:[Utility getStringByKey:@"Blood Pressure"],[Utility getStringByKey:@"Blood Glucose"], nil];
                return 2;
            }
            else if (self.timeBloodMutableArray.count>0&&self.timeECGMutableArray.count==0&&self.timeGlucoseMutableArray.count==0)
            {
                _measurementArray=[[NSArray alloc]initWithObjects:[Utility getStringByKey:@"Blood Pressure"], nil];
                return 1;
            }
            else if (self.timeBloodMutableArray.count==0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count>0)
            {
                _measurementArray=[[NSArray alloc]initWithObjects:[Utility getStringByKey:@"ECG"],[Utility getStringByKey:@"Blood Glucose"], nil];
                return 2;
            }
            else if (self.timeBloodMutableArray.count==0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count==0)
            {
                _measurementArray=[[NSArray alloc]initWithObjects:[Utility getStringByKey:@"ECG"], nil];
                return 1;
            }
            else if (self.timeBloodMutableArray.count==0&&self.timeECGMutableArray.count==0&&self.timeGlucoseMutableArray.count>0)
            {
                _measurementArray=[[NSArray alloc]initWithObjects:[Utility getStringByKey:@"Blood Glucose"], nil];
                return 1;
            }
            else
            {
                return 0;
            }
            break;
            
        case 1:
            if (self.titleMedicationArray.count>0) {
                return   self.titleMedicationArray.count;
            }
            else
            {
                return 0;
            }
            break;
        case 2:
            if (self.titleAdhocArray.count>0)
            {
                
                return self.titleAdhocArray.count;
            }
            else
            {
                return 0;
            }
            break;
        case 3:
            if (self.timeWalkMustableArray.count>0) {
                return 1;
            }
            else
            {
                return 0;
            }
        default:
            return 0;
            break;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
//    InformaitionViewController *_information=[[InformaitionViewController alloc]initWithNibName:@"InformaitionViewController" bundle:nil];
//    
//    
//    NSString *str=[[NSString alloc]init];
//    for (int o=0; o<self.timeWalkMustableArray.count; o++)
//    {
//        str=[str stringByAppendingString:[self.timeWalkMustableArray objectAtIndex:o]];
//        str=[str stringByAppendingString:@" "];
//        
//    }
//    
//    
//    switch (indexPath.section) {
//        case 0:
//            //
//            _information.str1=[Utility getStringByKey:@"Daily Measurement"];
//            _information.str2 =[_measurementArray objectAtIndex:indexPath.row];
//            
//            if ([_information.str2 isEqualToString:[Utility getStringByKey:@"Blood Pressure"]]) {
//                //
//                _information._allArray=self.timeBloodMutableArray;
//            }
//            else if ([_information.str2 isEqualToString:[Utility getStringByKey:@"ECG"]])
//            {
//                _information._allArray=self.timeECGMutableArray;
//                
//            }
//            else
//            {
//                _information._allArray=self.timeGlucoseMutableArray;
//            }
//            break;
//        case 1:
//            _information.str1=[Utility getStringByKey:@"Daily Medication"];
//            //
//            _information._array=self.titleMedicationArray;
//            _information._allArray=self.timesMedicationArray;
//            _information.docAgeArray=self.dosageMedicationArray;
//            _information.medientID=self.medID ;
//            _information.str2=[self.titleMedicationArray objectAtIndex:indexPath.row];
//            _information.str3=[self.timesMedicationArray objectAtIndex:indexPath.row];
//            _information.str4=[self.dosageMedicationArray objectAtIndex:indexPath.row];
//            _information.medWitchID=indexPath.row;
//            
//            _information.turntitleMedicationArray=[[NSMutableArray alloc]initWithArray:self.titleMedicationArray];
//            _information.turntimesMedicationArray=[[NSMutableArray alloc]initWithArray:self.timesMedicationArray];
//            _information.turnmedID=[[NSMutableArray alloc]initWithArray: self.medID];
//            _information.turndosageMedicationArray=[[NSMutableArray alloc]initWithArray:self.dosageMedicationArray];
//            
//            _information.turnMealMedicationArray=[[NSMutableArray alloc]initWithArray:self.mealMedicationArray];
//            
//            
//            break;
//        case 2:
//            //
//            
//            _information.str1=[Utility getStringByKey:@"Others"];
//            _information.str2=[self.titleAdhocArray objectAtIndex:indexPath.row];
//            _information.str3=[self.adHoNote objectAtIndex:indexPath.row];
//            _information.str4=[self.adDateDate objectAtIndex:indexPath.row];
//            _information._timeStart=[self.startTimesArray objectAtIndex:indexPath.row];
//            _information._timeEnd=[self.endTimesArray objectAtIndex:indexPath.row];
//            
//            _information.otherID=[self.adHocID objectAtIndex:indexPath.row];
//            
//            
//            
//            break;
//        case 3:
//            _information.str1=[Utility getStringByKey:@"Exercise"];
//            _information.turnWalkingArray=[[NSMutableArray alloc]initWithArray:self.timeWalkMustableArray];
//            _information.str2=str;
//            if ([self.walkStartDate length]>5) {
//                _information.dateDateStr=self.walkStartDate;
//            }
//            
//            
//            
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    
//    [self.navigationController pushViewController:_information animated:YES];
//    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section)
    {
        case 0:
            //
            if (self.timeBloodMutableArray.count>0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count>0)
            {
                switch (indexPath.row)
                {
                    case 0:
                        if (self.timeBloodMutableArray.count>3) {
                            return  60;
                        }
                        else
                            return 35;
                        
                        
                    case 1:
                        if (self.timeECGMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return 35;
                        
                    case 2:
                        if (self.timeGlucoseMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return 35;
                        break;
                        
                    default:
                        break;
                }
            }
            else   if (self.timeBloodMutableArray.count>0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count==0)
            {
                switch (indexPath.row) {
                    case 0:
                        if (self.timeBloodMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return 35;
                        
                        
                    case 1:
                        if (self.timeECGMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return 35;
                        
                        
                    default:
                        break;
                }
            }
            else   if (self.timeBloodMutableArray.count>0&&self.timeECGMutableArray.count==0&&self.timeGlucoseMutableArray.count>0)
            {
                switch (indexPath.row) {
                    case 0:
                        if (self.timeBloodMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return 35;
                        
                        
                    case 1:
                        if (self.timeGlucoseMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return 35;
                        
                        
                    default:
                        break;
                }
            }
            else   if (self.timeBloodMutableArray.count==0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count>0)
            {
                switch (indexPath.row) {
                    case 0:
                        if (self.timeECGMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return 35;
                        
                        
                    case 1:
                        if (self.timeGlucoseMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return  35;
                        
                        
                    default:
                        break;
                }
            }
            else   if (self.timeBloodMutableArray.count==0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count>0)
            {
                switch (indexPath.row) {
                    case 0:
                        if (self.timeECGMutableArray.count>3) {
                            return  60;
                        }
                        else
                            return 35;
                        
                        
                    case 1:
                        if (self.timeGlucoseMutableArray.count>3) {
                            return 60;
                        }
                        else
                            return  35;
                        
                        
                    default:
                        break;
                }
            }
            else   if (self.timeBloodMutableArray.count==0&&self.timeECGMutableArray.count==0&&self.timeGlucoseMutableArray.count>0)
            {
                
                if (self.timeGlucoseMutableArray.count>3)
                {
                    return  60;
                }
                else
                    return 35;
                
                
            }
            else   if (self.timeBloodMutableArray.count==0&&self.timeECGMutableArray.count>0&&self.timeGlucoseMutableArray.count==0)
            {
                
                if (self.timeECGMutableArray.count>3)
                {
                    return  60;
                }
                else
                    return  35;
                
            }
            else   if (self.timeBloodMutableArray.count>0&&self.timeECGMutableArray.count==0&&self.timeGlucoseMutableArray.count==0)
            {
                
                if (self.timeBloodMutableArray.count>3)
                {
                    return 60;
                }
                else
                    return 35;
                
            }
            else
            {
                return 0;
            }
            
            return 60;
            break;
        case 1:
            //
            self.otherHeight=0;
            if ([self.titleMedicationArray count]>0)
            {
                UILabel * titleText=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 140, 40)];
                
                titleText.text=[self.titleMedicationArray objectAtIndex:indexPath.row];
                titleText.numberOfLines=10;
                [titleText sizeToFit];
                
                if (titleText.frame.size.height>50) {
                    self.madionHeight=titleText.frame.size.height+20;
                }
                else
                {
                    self.madionHeight=50 ;
                }
            }
            else
            {
                self.madionHeight=0;
            }
            return self.madionHeight;
            
            break;
        case 2:
            //
            self.otherHeight=0;
            if (self.titleAdhocArray.count>0)
            {
                
                UILabel * titleText=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 140, 40)];
                
                titleText.text=[self.titleAdhocArray objectAtIndex:indexPath.row];
                titleText.numberOfLines=10;
                
                [titleText sizeToFit];
                if (titleText.frame.size.height<50)
                    
                {
                    self.otherHeight=50;
                }
                else
                {
                    self.otherHeight=titleText.frame.size.height+10;
                }
            }
            return self.otherHeight;
            break;
        case 3:
            if (self.timeWalkMustableArray.count>3) {
                return 60;
            }
            else
            {
                return 35;
            }
            return 0;
        default:
            return 0;
            break;
    }
}
-(IBAction)thatisOK:(id)sender
{
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   NSString * strWarn =[defaults objectForKey:@"strWarn"];

    if ([strWarn isEqualToString:@""]||[strWarn isEqualToString:@"(null)"]||strWarn==nil||strWarn==NULL)
    {
        strWarn=@"normal";
    }

            //         strWarn=@"Remind_4214";

    if ([strWarn isEqualToString:@"normal"])
            {
                // normal
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@" " forKey:@"update_HealthReach_Day"];
                [defaults synchronize];
                if ([(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsRunning])
                {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    
                    
                    float  idlength=[[GlobalVariables shareInstance].session_id length];
                    NSLog(@"idlenggt======================%f-------------",idlength);
                    if (idlength<8) {
                        backGuangView.hidden=YES;
                    }
                    else
                    {
                        MR_ListViewController *homeView = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
                        
                        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
                        [dateFormat setDateFormat:@"yyyy-MM-dd"];
                        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
                        
                        homeView.dateDateStr=currentDateStr;
                        
                        
                        [self.navigationController pushViewController:homeView animated:YES];
                    }
                    
                    
                }

                
                
                
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
-(IBAction)bullbug:(id)sender
{
    
    if ([(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsRunning]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        NSArray * array=[[NSArray alloc]initWithObjects:@"",@"", nil];
        NSString *rir=[array objectAtIndex:3];
        NSLog(@"%@",rir);
    }
   
    
//    float  idlength=[[GlobalVariables shareInstance].session_id length];
//    NSLog(@"idlenggt======================%f-------------",idlength);
//    if (idlength<8) {
//        
//        NSArray * array=[[NSArray alloc]initWithObjects:@"",@"", nil];
//        NSString *rir=[array objectAtIndex:3];
//        NSLog(@"%@",rir);
//    }
//    else
//    {
//        MR_ListViewController *homeView = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
//        
//        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:@"yyyy-MM-dd"];
//        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
//        
//        homeView.dateDateStr=currentDateStr;
//        
//        
//        [self.navigationController pushViewController:homeView animated:YES];
//    }
//    


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
