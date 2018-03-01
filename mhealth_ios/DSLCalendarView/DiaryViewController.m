//
//  DiaryViewController.m
//  mHealth
//
//  Created by gz dev team on 14年4月2日.
//
//

#import "HomeViewController.h"
#import "MR_ListViewController.h"
#import "AddReminderViewController.h"
#import "DiaryViewController.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "Utility.h"
#import "DBHelper.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "InformaitionViewController.h"
#import "DayChickViewController.h"
#import "SaveCalendarViewController.h"
#import <EventKit/EventKit.h>

@interface DiaryViewController ()
{
    MR_ListViewController * _mr_listt;
}

@end

@implementation DiaryViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"DiaryViewController" bundle:nibBundleOrNil];
    }
    else
    {
        ////NSLog(@"3.5 inch");
        self = [super initWithNibName:@"DiaryViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    monthViewHEnd.hidden=NO;
    scoloorView.hidden=NO;
    dayView.hidden=YES;
    _tableDayView.hidden=YES;
    addEvent.hidden=YES;
    addBUtton.hidden=NO;
    saveCalendarButton.hidden=NO;
    
    
    [self TextFonts];

}
-(void)TextFonts
{
 [mHealthHendTextFont setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    mHealthHendTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [monthTextFont setText:[Utility getStringByKey:@"Month"]];
    monthTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    [dayTextFont setText:[Utility getStringByKey:@"Day"]];
    dayTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    
    [addBUtton setTitle:[Utility getStringByKey:@"Events Summary"] forState:UIControlStateNormal];
    
     [saveCalendarButton setTitle:[Utility getStringByKey:@"Import to Calendae"] forState:UIControlStateNormal];
  //  addBUtton.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [addEvent setTitle:[Utility getStringByKey:@"Add Event"] forState:UIControlStateNormal];
    
    
    addEvent.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [monday setText:[Utility getStringByKey:@"Monday"]];
    monday.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [tuesday setText:[Utility getStringByKey:@"Tuesday"]];
    tuesday.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [wendseday setText:[Utility getStringByKey:@"Wendsday"]];
    wendseday.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [thrsday setText:[Utility getStringByKey:@"Tirsday"]];
    thrsday.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [firday setText:[Utility getStringByKey:@"Firday"]];
    firday.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [saterday setText:[Utility getStringByKey:@"Starteday"]];
    saterday.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [sunday setText:[Utility getStringByKey:@"Sunday"]];
    sunday.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    monthHendText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    labelDay.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];

    
    
    
    

    
}
- (void)viewDidLoad
{
    
       ////NSLog(@"-------------self.isCalendar----[DBHelper isSave]--------%d,------ int isgengxinle=[DBHelper gengxinguoma]=%d-----------------------------------------------------------------------------------------------------------------------------",[DBHelper isSave],[DBHelper gengxinguoma]);
    
    
    [super viewDidLoad];
    //删除所以通知记录
    // [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString * mothImageOn=[[NSBundle mainBundle] pathForResource:@"02_diary_tab_month_on" ofType:@"png"];
    __monthImageON=[[UIImage alloc]initWithContentsOfFile:mothImageOn];
    NSString * mothImageOff=[[NSBundle mainBundle] pathForResource:@"02_diary_tab_month_off" ofType:@"png"];
    __monthImageOff=[[UIImage alloc]initWithContentsOfFile:mothImageOff];
    NSString * dayImageOn=[[NSBundle mainBundle] pathForResource:@"02_diary_tab_day_on" ofType:@"png"];
    __dayImageON=[[UIImage alloc]initWithContentsOfFile:dayImageOn];
    NSString * dayImageOff=[[NSBundle mainBundle] pathForResource:@"02_diary_tab_day_off" ofType:@"png"];
    __dayImageOff=[[UIImage alloc]initWithContentsOfFile:dayImageOff];
    
    
    
    

    
    _timeArray=[[NSMutableArray alloc]initWithObjects:@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00", nil];

    

    
    //  self.dateDateStr=dateDate;
    strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];
    
    
    myArray=[[NSMutableArray alloc]initWithObjects:[Utility getStringByKey:@"Daily Measurement"],[Utility getStringByKey:@"Daily Medication"],[Utility getStringByKey:@"Others"],[Utility getStringByKey:@"Exercise"], nil];
    
    
    //活动指示器的创造
    //   remindAlert=[[UIAlertView alloc]initWithTitle:@"loading..." message:Nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    //
    //    act=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //    act.frame=CGRectMake(120, 68, 37, 37);
    //    [remindAlert addSubview:act];
    //    [act startAnimating];
    //
    //
    //    [remindAlert show];
    
    
    self.addView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.addView.backgroundColor=[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:100/255.0];
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
    
    scoloorView.backgroundColor=[UIColor clearColor];
    scoloorView.pagingEnabled=YES;
   scoloorView.bounces=YES;
    scoloorView.showsHorizontalScrollIndicator=NO;
   scoloorView.showsVerticalScrollIndicator=YES;
    scoloorView.bounces=NO;
//    if (iPhone5) {
//          scoloorView.contentSize=CGSizeMake(320, 640);//设置总画布的大小
//    }
//
// else
// {
//      scoloorView.contentSize=CGSizeMake(320,540);//设置总画布的大小
// }
    
    scoloorView.delegate=self;//实现代理
    
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
    
    _theView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    UIActivityIndicatorView*activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [activity setCenter:CGPointMake(160, 180)];
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_theView addSubview:activity];
    _theView.backgroundColor=[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:0.7];
    [activity startAnimating];
    
    UILabel * loading=[[UILabel alloc]initWithFrame:CGRectMake(110, 220, 100, 30)];
    loading.backgroundColor=[UIColor clearColor];
    loading.textColor=[UIColor whiteColor];
    loading.text=@"Loading...";
    loading.textAlignment=NSTextAlignmentCenter;
    [_theView addSubview:loading];
    [self.view addSubview:_theView];
    _theView.hidden=YES;
#pragma mark -- the day and the week name
    [self dayANDweek:[NSDate date]];
    
[self getHistoryRecord];
        ////NSLog(@"+++++++++++%@+++++++",self.adDateDate);
    [self thescrollViewHeight];
    
    
    
#pragma mark -- 日历创建
    
    
    NSDateFormatter* dateFormat000 = [[NSDateFormatter alloc] init];
    [dateFormat000 setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormat000 stringFromDate:[NSDate date]];
    dateDate=currentDateStr;

    
    NSString *timeStrRaindateDate111=[dateDate substringWithRange:NSMakeRange(0, 4)];
    NSString *timeStrRaindateDate222=[dateDate substringWithRange:NSMakeRange(5, 2)];
    NSString *timeStrRaindateDate333=[dateDate substringWithRange:NSMakeRange(8, 2)];
   timeStrRaindateDateSum111=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRaindateDate111,timeStrRaindateDate222,timeStrRaindateDate333];
    ////NSLog(@",timeStrRainSum===%@,",timeStrRaindateDateSum111);
    if ([self.walkStartDate length]>5) {
        NSString *timeStrRainStratDate111=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
        NSString *timeStrRainStratDate222=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
        NSString *timeStrRainStratDate333=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
        timeStrRainStratDateSum111=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainStratDate111,timeStrRainStratDate222,timeStrRainStratDate333];
        ////NSLog(@",timeStrRainSum===%@,",timeStrRainStratDateSum111);
    }
    if ([self.walkEndDate length]>6) {
        NSString *timeStrRainENDDate111=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
        NSString *timeStrRainENDDate222=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
        NSString *timeStrRainENDDate333=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
        timeStrRainENDDateSum111=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainENDDate111,timeStrRainENDDate222,timeStrRainENDDate333];
        ////NSLog(@",timeStrRainSum===%@,",timeStrRainENDDateSum111);
    }
    
    

    
    
    
    
 //   NSDateFormatter* dateFormat0000 = [[NSDateFormatter alloc] init];
   // [dateFormat0000 setDateFormat:@"yyyy-MM-dd"];
   // NSString *currentDateStr00 = [dateFormat0000 stringFromDate:[NSDate date]];
    ////NSLog(@"%@",currentDateStr00);
    
    NSDateFormatter* dateFormat11100 = [[NSDateFormatter alloc] init];
    [dateFormat11100 setDateFormat:@"yyyyMMdd"];
    currentDateStr11100 = [dateFormat11100 stringFromDate:[NSDate date]];
    ////NSLog(@"%@",currentDateStr11100);
    
    
    [self monthDairy:dateDate];
    


    
    NSString *timeBloodLength=[[NSString alloc]initWithFormat:@"%@",self.timeBloodMutableArray];
    if ([timeBloodLength length]>3) {
        timeBloodArray=[NSMutableArray new];
        for (int i=0; i<self.timeBloodMutableArray.count; i++) {
            NSString * temp=[NSString new];
            temp=[self.timeBloodMutableArray objectAtIndex:i];
            if ([temp length]>3) {
                NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                [timeBloodArray addObject:timeStr];
            }
  
        }
        
    }
    
    timeECGArray=[NSMutableArray new];
    for (int i=0; i<self.timeECGMutableArray.count; i++) {
        NSString * temp=[NSString new];
        temp=[self.timeECGMutableArray objectAtIndex:i];
        NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
        NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
        ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
        [timeECGArray addObject:timeStr];
    }
    timeGloodArray=[NSMutableArray new];
    for (int i=0; i<self.timeGlucoseMutableArray.count; i++) {
        NSString * temp=[NSString new];
        temp=[self.timeGlucoseMutableArray objectAtIndex:i];
        NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
        NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
        ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
        [timeGloodArray addObject:timeStr];
    }
    timeStartTime=[NSMutableArray new];
    
    for (int i=0; i<self.startTimesArray.count; i++) {
        NSString * temp=[NSString new];
        temp=[self.startTimesArray objectAtIndex:i];
        if ([temp length]>4) {
            NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
            NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
            ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
            [timeStartTime addObject:timeStr];
        }
     
    }
    timeWalkingArray=[NSMutableArray new];
    for (int i=0; i<self.timeWalkMustableArray.count; i++) {
        NSString * temp=[NSString new];
        temp=[self.timeWalkMustableArray objectAtIndex:i];
        NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
        NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
        ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
        [timeWalkingArray addObject:timeStr];
    }
    
    
    timeMationArray=[NSMutableArray new];
    for (int i = 0 ; i<[self.timesMedicationArray count]; i++) {
        NSString *timeMEdicationText=[self.timesMedicationArray objectAtIndex:i];
        float ff=[timeMEdicationText lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
        //NSLog(@">>>>>%f<<<<<",ff);
        NSMutableArray *timeTextArray=[NSMutableArray new];
        if (ff>1&&ff<7) {
            NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(0, 5)];
            NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
            NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
            //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
            
            [timeTextArray addObject:timeStr];
        }
        else if (ff>=7&&ff<=13)
        {
            for (int temmm=0; temmm<2; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
        }
        else if (ff>=13&&ff<=19)
        {
            for (int temmm=0; temmm<3; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
            
        }
        else if (ff>=19&&ff<=25)
        {
            for (int temmm=0; temmm<4; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
            
        }
        else if (ff>=25&&ff<=31)
        {
            for (int temmm=0; temmm<5; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
            
        }
        else if (ff>=31)
        {
            for (int temmm=0; temmm<2; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
            
        }
        else
        {
            //NSLog(@"Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error");
        }
        [timeMationArray addObject:timeTextArray];
        
    }
//    _whiteBackGuang=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 560)];
//    _whiteBackGuang.backgroundColor=[UIColor whiteColor];
//    _whiteBackGuang.alpha=0.7;
//    
//    
//    
//    
//    
//    
//    UILabel * loading1=[[UILabel alloc]initWithFrame:CGRectMake(110, 190, 100, 30)];
//    loading1.backgroundColor=[UIColor clearColor];
//    loading1.textColor=[UIColor blackColor];
//    loading1.text=@"Loading...";
//    loading1.textAlignment=NSTextAlignmentCenter;
//    [_whiteBackGuang addSubview:loading1];
//    [self.view addSubview:_whiteBackGuang];
//    [self VIP_Channel];
    
    
    
    ///////
#pragma mark -- Myrtle
//    
//    NSMutableArray *arrayTime=[[NSMutableArray alloc]init];
//    arrayTime=[self todayMeasurement];
//    
//    
//    NSLog(@" arrayTime=[self todayMeasurement];  arrayTime=%@", arrayTime);
    _tableDayView.allowsSelection=NO;
    if (!iPad) {
            _tableMonthView =[[UITableView alloc]initWithFrame:CGRectMake(0, 300, 320, 280) style:UITableViewStylePlain];
    }
    else
    { 
        _tableMonthView =[[UITableView alloc]initWithFrame:CGRectMake(0, 210, 320, 280) style:UITableViewStylePlain];
    }
    _tableMonthView.dataSource=self;
    _tableMonthView.delegate=self;
    _tableMonthView.allowsSelection=NO;
    _tableDayView.bounces=NO;
    [_tableDayView setSeparatorColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1]];
    [_tableMonthView setSeparatorColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1]];
    _tableMonthView.backgroundColor=[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    _tableMonthView.scrollEnabled = NO;
   
    [scoloorView addSubview:_tableMonthView];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableMonthView setTableFooterView:v];

    
    
    theAllTakenMadicon=[NSMutableArray new];
    theAllTimeMadicon=[NSMutableArray new];
    
    for (int i=0; i<self.timesMedicationArray.count; i++)
    {
        
        float ff=[[self.timesMedicationArray objectAtIndex:i] length];
        //NSLog(@"[self.timesMedicationArray objectAtIndex:i]=%@",[self.timesMedicationArray objectAtIndex:i]);
        //NSLog(@"+++++++%f",ff);
        timesArray =[[NSMutableArray alloc]init];
        tikenArray =[[NSMutableArray alloc]init];
        //NSLog(@"[self.tikenMedicationArray objectAtIndex:i]=%@",[self.tikenMedicationArray objectAtIndex:i]);
        if (ff>1&&ff<8) {
            //
            NSString *string = [[self.timesMedicationArray objectAtIndex:i ]  substringWithRange:NSMakeRange(0,5)];
            NSString *tikenStr=@"N";
            if ([[self.tikenMedicationArray objectAtIndex:i]length]>0)
            {
                tikenStr=[[self.tikenMedicationArray objectAtIndex:i]substringWithRange:NSMakeRange(0, 1)];
            }
            
            [tikenArray addObject:tikenStr];
            //NSLog(@"tikenSTR====%@",tikenStr );
            [timesArray addObject:string];
            //NSLog(@"__%@--",string);
        }
        else if (ff>=7.0&&ff<=13)
        {
            for (int temmm=0; temmm<2; temmm++) {
                NSString *string = [[self.timesMedicationArray objectAtIndex:i]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                 NSString *tikenStr=@"N";
                if ([[self.tikenMedicationArray objectAtIndex:i] length]>2) {
                     tikenStr=[[self.tikenMedicationArray objectAtIndex:i] substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                }
           
                [tikenArray addObject:tikenStr];
                [timesArray addObject:string];
                //NSLog(@"__%@--",string);
            }
            
            
        }
        else if (ff>=13.0&&ff<=19)
        {
            for (int temmm=0; temmm<3; temmm++)
            {
                NSString *string = [[self.timesMedicationArray objectAtIndex:i] substringWithRange:NSMakeRange(0+(temmm*6),5)];
                
                NSString *tikenStr=@"N";
                if ([[self.tikenMedicationArray objectAtIndex:i] length]>4)
                {
                    tikenStr=[[self.tikenMedicationArray objectAtIndex:i] substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                }
                [tikenArray addObject:tikenStr];
                [timesArray addObject:string];
                //NSLog(@"__%@--",string);
            }
            
        }
        else if (ff>=19.0&&ff<=25)
        {
            for (int temmm=0; temmm<4; temmm++) {
                NSString *string = [[self.timesMedicationArray objectAtIndex:i]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                NSString *tikenStr=@"N";
                if ([[self.tikenMedicationArray objectAtIndex:i] length]>6) {
                    tikenStr=[[self.tikenMedicationArray objectAtIndex:i] substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                }
                [tikenArray addObject:tikenStr];
                [timesArray addObject:string];
                //NSLog(@"__%@--",string);
            }
            
        }
        else if (ff>=25.0&&ff<=31)
        {
            for (int temmm=0; temmm<5; temmm++) {
                NSString *string = [[self.timesMedicationArray objectAtIndex:i]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                NSString *tikenStr=@"N";
                if ([[self.tikenMedicationArray objectAtIndex:i] length]>8) {
                    tikenStr=[[self.tikenMedicationArray objectAtIndex:i] substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                }
                [tikenArray addObject:tikenStr];
                //NSLog(@"__%@--",string);
                [timesArray addObject:string];
                
                
            }
            
            
        }
        else if (ff>=31.0)
        {
            for (int temmm=0; temmm<6; temmm++)
            {
                NSString *string = [[self.timesMedicationArray objectAtIndex:i] substringWithRange:NSMakeRange(0+(temmm*6),5)];
                NSString *tikenStr=@"N";
                if ([[self.tikenMedicationArray objectAtIndex:i] length]>10) {
                    tikenStr=[[self.tikenMedicationArray objectAtIndex:i] substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                }
                [tikenArray addObject:tikenStr];
                //NSLog(@"__%@--",string);
                [timesArray addObject:string];
                
            }
        }

        [theAllTakenMadicon addObject:tikenArray];
        [theAllTimeMadicon addObject:timesArray];
        
    }
    [self adhocOther];
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(beginPPPDDD) object:nil];
    [myThread start];
    

}
#pragma mark --判斷
-(void)beginPPPDDD
{

    _theView.hidden=NO;
    self.isCalendar=[DBHelper isSave];
    
    if (self.isCalendar==1) {
        
        int isgengxinle=[DBHelper gengxinguoma];
        
        
        
        
        //NSLog(@"-------------self.isCalendar----[DBHelper isSave]--------%d,------ int isgengxinle=[DBHelper gengxinguoma]=%d-----------------------------------------------------------------------------------------------------------------------------",[DBHelper isSave],[DBHelper gengxinguoma]);
        if (isgengxinle==1) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *loadfromFGTC_Key=[defaults objectForKey:@"Frist Go to Calendar Key"];
            //NSLog(@"LoadFromKey==%@",loadfromFGTC_Key);
            if ([loadfromFGTC_Key isEqualToString:@"Y"])
            {
                
                [self deleteEvent];
                //NSLog(@"OK++++++++++ I'm OK Yes");
                [self beginSaveTheArray];
                isgengxinle=0;
                [DBHelper zhendeyouma:0];
                [defaults setObject:@"N" forKey:@"Frist Go to Calendar Key"];
                [defaults synchronize];
                //NSLog(@"LoadFromKey==%@",loadfromFGTC_Key);
                
            }
            else
            {
                
            }

            
            
        }
        else
        {
            
        }

        
        
    }
    else
    {
        [self deleteEvent];
      
        [DBHelper zhendeyouma:0];
        
        //NSLog(@"Sorry+++++++ I'm Not OK");
        
    }
    //NSLog(@"YEAR YEAR YEAR WOW WOW OH OH OH AHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAH");
    _theView.hidden=YES;
    
}
-(void)dayANDweek:(NSDate*)date
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE"];
    NSString *currentWeekday = [dateFormat stringFromDate:date];
    //NSLog(@"------%@----",currentWeekday);
    NSDateFormatter* dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDayday = [dateFormat2 stringFromDate:date];
    //NSLog(@"------%@----",currentDayday);
    
    NSString *theWeekName;
    if ([currentWeekday isEqualToString:@"Mon"]||[currentWeekday isEqualToString:@"周一"]||[currentWeekday isEqualToString:@"週一"]||[currentWeekday isEqualToString:@"星期一"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Monday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期一"];
        }
    }
    else if ([currentWeekday isEqualToString:@"Tue"]||[currentWeekday isEqualToString:@"周二"]||[currentWeekday isEqualToString:@"週二"]||[currentWeekday isEqualToString:@"星期二"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Tuesday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期二"];
        }

    }
    else if ([currentWeekday isEqualToString:@"Wed"]||[currentWeekday isEqualToString:@"周三"]||[currentWeekday isEqualToString:@"週三"]||[currentWeekday isEqualToString:@"星期三"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             theWeekName=[[NSString alloc] initWithFormat:@"Wednesday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期三"];
        }
     
    }
    else if ([currentWeekday isEqualToString:@"Thu"]||[currentWeekday isEqualToString:@"周四"]||[currentWeekday isEqualToString:@"週四"]||[currentWeekday isEqualToString:@"星期四"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             theWeekName=[[NSString alloc] initWithFormat:@"Thursday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期四"];
        }
  
    }
    else if ([currentWeekday isEqualToString:@"Fri"]||[currentWeekday isEqualToString:@"周五"]||[currentWeekday isEqualToString:@"週五"]||[currentWeekday isEqualToString:@"星期五"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
           theWeekName=[[NSString alloc] initWithFormat:@"Firday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期五"];
        }
     
    }
    else if ([currentWeekday isEqualToString:@"Sat"]||[currentWeekday isEqualToString:@"周六"]||[currentWeekday isEqualToString:@"週六"]||[currentWeekday isEqualToString:@"星期六"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
       theWeekName=[[NSString alloc] initWithFormat:@"Saturday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期六"];
        }
      
    }
    else if ([currentWeekday isEqualToString:@"Sun"]||[currentWeekday isEqualToString:@"周日"]||[currentWeekday isEqualToString:@"週日"]||[currentWeekday isEqualToString:@"星期日"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
                theWeekName=[[NSString alloc] initWithFormat:@"Sunday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期日"];
        }
   
    }

    
    NSString * timeStrRain111=[currentDayday substringWithRange:NSMakeRange(8,2)];
    
    NSString * timeStrRain222=[currentDayday substringWithRange:NSMakeRange(0,4)];
    NSString *timeStrRain333=[currentDayday substringWithRange:NSMakeRange(5, 2)];
    NSString * allTheDay;
    if ([timeStrRain333 isEqualToString:@"01"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
                allTheDay=[[NSString alloc]initWithFormat:@"Jan %@",timeStrRain222];
        }
        else
        {
                allTheDay=[[NSString alloc]initWithFormat:@"%@年1月",timeStrRain222];
        }
    }
    else  if ([timeStrRain333 isEqualToString:@"02"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
             allTheDay=[[NSString alloc]initWithFormat:@"Feb %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年2月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"03"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Mar %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年3月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"04"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Apr %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年4月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"05"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"May %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年5月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"06"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
           allTheDay=[[NSString alloc]initWithFormat:@"Jun %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年6月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"07"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Jul %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年7月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"08"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
             allTheDay=[[NSString alloc]initWithFormat:@"Aug %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年8月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"09"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
             allTheDay=[[NSString alloc]initWithFormat:@"Sep %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年9月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"10"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Oct %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年10月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"11"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
           allTheDay=[[NSString alloc]initWithFormat:@"Nov %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年11月",timeStrRain222];
        }
        
    }
    else
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Dec %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年12月",timeStrRain222];
        }
 
    }
    //NSLog(@"<<<%@-%@-%@>>>",timeStrRain111,allTheDay,timeStrRain222);
    NSString *sumDay;
    if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
        
       sumDay =[[NSString alloc]initWithFormat:@" %@,%d %@",theWeekName,[timeStrRain111 intValue],allTheDay];
        
    }
   else
   {
       sumDay=[[NSString alloc]initWithFormat:@" %@%d日 (%@)",allTheDay,[timeStrRain111 intValue],theWeekName];
       

   }
    
    labelDay.text=sumDay;
    
    
    
    
    
    

}



-(void)addButtonYes
{
    [self backToHome];
}








-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString*cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellIdentifier];
    }
    
    else
    {
        cell=nil;
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellIdentifier];
    }
    //  scoloorView.contentSize=CGSizeMake(320, theTableViewMonthHEight+(45*6)+30);//设置总画布的大小
    //cell.backgroundColor=[UIColor gray];
    //NSLog(@"___________________++++++++++++++++++++++++++theTableViewMonthHEight=%d",theTableViewMonthHEight);
    cell.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    if (tableView==_tableMonthView)
    {
        
        
        //NSLog(@" dateDate===================      %@",dateDate);
        //NSLog(@"self.dateDateStr===============   %@",self.dateDateStr);
        

        
        
        
        
        
        UILabel *_laber1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 280, 22)];
        _laber1.backgroundColor =[UIColor clearColor];
        _laber1.text=[myArray objectAtIndex:indexPath.row];
        _laber1.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
        switch (indexPath.row)
        {
            case 0:
                if (((self.timeECGMutableArray.count+self.timeBloodMutableArray.count+self.timeGlucoseMutableArray.count>0))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue])) {
                    _laber1.textColor=[UIColor colorWithRed:240/255.0 green:50/255.0 blue:50/255.0 alpha:1];
                    UILabel *_label2=[[UILabel alloc]initWithFrame:CGRectMake(20, 32, 280, 85)];
                    
                    _label2.backgroundColor=[UIColor clearColor];
                    NSString * timeBloodmutableArrayStr=[[NSString alloc]init];
                    for (int i=0 ; i<self.timeBloodMutableArray.count; i++) {
                        NSString *tempTimeStr=[[NSString alloc]initWithFormat:@"%@  ",[self.timeBloodMutableArray objectAtIndex:i]];
                        timeBloodmutableArrayStr=[timeBloodmutableArrayStr stringByAppendingString:tempTimeStr];
                    }
                    for (int i=0; i<self.timeECGMutableArray.count; i++) {
                        NSString *timeTimeStr=[[NSString alloc]initWithFormat:@"%@  ",[self.timeECGMutableArray objectAtIndex:i]];
                        timeBloodmutableArrayStr=[timeBloodmutableArrayStr stringByAppendingString:timeTimeStr];
                    }
                    for (int i=0; i<self.timeGlucoseMutableArray.count; i++) {
                        NSString * strTimeTemp=[[NSString alloc]initWithFormat:@"%@  ",[self.timeGlucoseMutableArray objectAtIndex:i]];
                        timeBloodmutableArrayStr=[timeBloodmutableArrayStr stringByAppendingString:strTimeTemp];
                    }
                    
                    _label2.text=timeBloodmutableArrayStr;
                    _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
                    _label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    _label2.numberOfLines=3;
                    [_label2 sizeToFit];
                        [cell.contentView addSubview:_laber1];
                    [cell.contentView addSubview:_label2];
                    
                }
                else
                {
                    _laber1.textColor=[UIColor clearColor];
                       _laber1.frame=CGRectMake(0, 0, 0, 0);
                }
                
                break;
            case 1:
                if (((self.timesMedicationArray.count>0))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
                {
                    _laber1.textColor=[UIColor colorWithRed:41/255.0 green:137/255.0 blue:173/255.0 alpha:1];
                    UILabel *_label2=[[UILabel alloc]initWithFrame:CGRectMake(20, 32, 280, 85)];
                    _label2.backgroundColor=[UIColor clearColor];
                    NSString *strTimeMedication=[[NSString alloc]init];
                    for (int i=0; i<[self.everyONEmedicationTimeArray count]; i++) {
                        NSString *stringNNNN=[[NSString alloc] initWithFormat:@"%@  ",[self.everyONEmedicationTimeArray objectAtIndex:i]];
                        strTimeMedication=[strTimeMedication stringByAppendingString:stringNNNN];
                    }
                    _label2.text=strTimeMedication;
                    _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
                    _label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    _label2.numberOfLines=10;
                    [_label2 sizeToFit];
                        [cell.contentView addSubview:_laber1];
                    [cell.contentView addSubview:_label2];
                }
                else
                {
                    _laber1.textColor=[UIColor clearColor];
                       _laber1.frame=CGRectMake(0, 0, 0, 0);
                }
                break;
            case 2:
                
                if ([todyAdhocTime length]>3)
                {
                    _laber1.textColor=[UIColor colorWithRed:50/255.0 green:140/255.0 blue:140/255.0 alpha:1];
                    UILabel *_label2=[[UILabel alloc]initWithFrame:CGRectMake(20, 32, 280, 28)];
                    _label2.backgroundColor=[UIColor clearColor];
                    
                    
                    _label2.text=todyAdhocTime;
                    _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
                    _label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    _label2.numberOfLines=1;
                    [cell.contentView addSubview:_laber1];
                    [cell.contentView addSubview:_label2];
                    
                    
                    
                }
                else
                {
                    _laber1.textColor=[UIColor clearColor];
                    _laber1.frame=CGRectMake(0, 0, 0, 0);
                }
                
                break;
            case 3:
                if((self.timeWalkMustableArray.count>0)&&(([timeStrRaindateDateSum111 intValue]>=[timeStrRainStratDateSum111 intValue])&&([timeStrRaindateDateSum111 intValue]<=[timeStrRainENDDateSum111 intValue])))
                {
                    _laber1.textColor=[UIColor colorWithRed:0/255.0 green:238/255.0 blue:118/255.0 alpha:1];
                    UILabel *_label2=[[UILabel alloc]initWithFrame:CGRectMake(20, 32, 280, 28)];
                    
                    _label2.backgroundColor=[UIColor clearColor];
                    NSString * timeWALKmutableArrayStr=[[NSString alloc]init];
                    for (int i=0 ; i<self.timeWalkMustableArray.count; i++) {
                        NSString *tempTimeStr=[[NSString alloc]initWithFormat:@"%@  ",[self.timeWalkMustableArray objectAtIndex:i]];
                        timeWALKmutableArrayStr=[timeWALKmutableArrayStr stringByAppendingString:tempTimeStr];
                    }
                    
                    _label2.text=timeWALKmutableArrayStr;
                    _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
                    _label2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    _label2.numberOfLines=1;
                        [cell.contentView addSubview:_laber1];
                    [cell.contentView addSubview:_label2];
                    
                }
                else
                {
                    _laber1.textColor=[UIColor clearColor];
                    _laber1.frame=CGRectMake(0, 0, 0, 0);
                }
                break;
            default:
                   _laber1.textColor=[UIColor clearColor];
                   _laber1.frame=CGRectMake(0, 0, 0, 0);
                break;
            }
       
        
        

    
        
        
        
    }
    else
    {
        
        
        
        
        switch (indexPath.row) {
            case 0:
                [cell.contentView addSubview:_cellView00];
                break;
            case 1:
                
                [cell.contentView addSubview:_cellView01];
                break;
            case 2:
                
                [cell.contentView addSubview:_cellView02];
                break;
            case 3:
                
                [cell.contentView addSubview:_cellView03];
                break;
            case 4:
                
                [cell.contentView addSubview:_cellView04];
                break;
            case 5:
                
                [cell.contentView addSubview:_cellView05];
                break;
            case 6:
                
                [cell.contentView addSubview:_cellView06];
                break;
            case 7:
                
                [cell.contentView addSubview:_cellView07];
                break;
            case 8:
                
                [cell.contentView addSubview:_cellView08];
                break;
            case 9:
                
                [cell.contentView addSubview:_cellView09];
                break;
            case 10:
                
                [cell.contentView addSubview:_cellView10];
                break;
            case 11:
                
                
                [cell.contentView addSubview:_cellView11];
                break;
            case 12:
                
                [cell.contentView addSubview:_cellView12];
                break;
            case 13:
                
                
                [cell.contentView addSubview:_cellView13];
                break;
            case 14:
                
                
                [cell.contentView addSubview:_cellView14];
                break;
            case 15:
                
                
                [cell.contentView addSubview:_cellView15];
                break;
            case 16:
                
                
                [cell.contentView addSubview:_cellView16];
                break;
            case 17:
                
                [cell.contentView addSubview:_cellView17];
                break;
            case 18:
                
                
                [cell.contentView addSubview:_cellView18];
                break;
            case 19:
                
                
                [cell.contentView addSubview:_cellView19];
                break;
            case 20:
                
                
                [cell.contentView addSubview:_cellView20];
                break;
            case 21:
                
                [cell.contentView addSubview:_cellView21];
                break;
            case 22:
                [cell.contentView addSubview:_cellView22];
                break;
            case 23:
                
                [cell.contentView addSubview:_cellView23];
                break;
            default:
                break;
        }
        
        
    }
    
    return cell;
}
-(void)adhocOther
{
    NSString *strOtherTime=[[NSString alloc]init];
        for (int i =0; i< [self.adDateDate count]; i++)
        {
            if ([dateDate isEqualToString:[self.adDateDate objectAtIndex:i]])
            {
             
              
                
                NSString *temp=[[NSString alloc]initWithFormat:@"%@  ",[self.startTimesArray objectAtIndex:i]];
                strOtherTime =[strOtherTime stringByAppendingString:temp];
     
            }
            else
            {
                
                NSString *temp=[[NSString alloc]initWithFormat:@""];
                strOtherTime =[strOtherTime stringByAppendingString:temp];

            }
        }
    todyAdhocTime=strOtherTime;

}
-(void)monthDairy:(NSString *)datter
{
    
    NSDateFormatter* dateFormat000 = [[NSDateFormatter alloc] init];
    [dateFormat000 setDateFormat:@"yyyy-MM-d"];
    NSString *currentDateStr = [dateFormat000 stringFromDate:[NSDate date]];
    
    NSDateFormatter* dateFormat2222 = [[NSDateFormatter alloc] init];
    [dateFormat2222 setDateFormat:@"yyyyMMdd"];
    NSString *currentDateStr2222 = [dateFormat2222 stringFromDate:[NSDate date]];
    NSString *timeStrRainTheMonth1=[datter substringWithRange:NSMakeRange(0, 4)];
    NSString *timeStrRainTheMonth2=[datter substringWithRange:NSMakeRange(5, 2)];
    NSString *timeStrRainSum=[[NSString alloc]initWithFormat:@"%@%@",timeStrRainTheMonth1,timeStrRainTheMonth2];
    //NSLog(@",timeStrRainSum===%@,",timeStrRainSum);
  
    //NSLog(@"------%lu-------dateDate=%@",(unsigned long)[datter length],datter);
    NSString * timeStrRain=[datter substringWithRange:NSMakeRange(0, 8)];
    
        NSString * timeStrRain222=[datter substringWithRange:NSMakeRange(0,4)];
    NSString *timeStrRain333=[datter substringWithRange:NSMakeRange(5, 2)];
    NSString * allTheDay;
    if ([timeStrRain333 isEqualToString:@"01"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             allTheDay=[[NSString alloc]initWithFormat:@"Jan %@",timeStrRain222];
        }
       else
       {
             allTheDay=[[NSString alloc]initWithFormat:@"%@年1月",timeStrRain222];
       }
    }
    else  if ([timeStrRain333 isEqualToString:@"02"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            allTheDay=[[NSString alloc]initWithFormat:@"Feb %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年2月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"03"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             allTheDay=[[NSString alloc]initWithFormat:@"Mar %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年3月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"04"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             allTheDay=[[NSString alloc]initWithFormat:@"Apr %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年4月",timeStrRain222];
        }
     
    }
    else  if ([timeStrRain333 isEqualToString:@"05"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             allTheDay=[[NSString alloc]initWithFormat:@"May %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年5月",timeStrRain222];
        }
      
    }
    else  if ([timeStrRain333 isEqualToString:@"06"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             allTheDay=[[NSString alloc]initWithFormat:@"Jun %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年6月",timeStrRain222];
        }
      
    }
    else  if ([timeStrRain333 isEqualToString:@"07"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
           allTheDay=[[NSString alloc]initWithFormat:@"Jul %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年7月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"08"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
           allTheDay=[[NSString alloc]initWithFormat:@"Aug %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年8月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"09"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             allTheDay=[[NSString alloc]initWithFormat:@"Sep %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年9月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"10"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            allTheDay=[[NSString alloc]initWithFormat:@"Oct %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年10月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"11"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
           allTheDay=[[NSString alloc]initWithFormat:@"Nov %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年11月",timeStrRain222];
        }
        
    }
    else
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            allTheDay=[[NSString alloc]initWithFormat:@"Dec %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年12月",timeStrRain222];
        }
        
    }
      monthHendText.text=allTheDay;
    
    
    
    NSString * modifyTheDay=[[NSString alloc]initWithFormat:@"%@01",timeStrRain];
    //NSLog(@"modif%@",modifyTheDay);
    NSDateFormatter*dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *theMonthFirstDay=[dateFormat dateFromString:modifyTheDay];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    NSString *currentWeekday = [dateFormatter stringFromDate:theMonthFirstDay];
    //NSLog(@"------%@----",currentWeekday);
    
    NSString *currentDayRain=[datter substringWithRange:NSMakeRange(5, 2)];
    
    NSString *HowtheyearStr=[datter substringWithRange:NSMakeRange(0, 4)];
    
    int howTheYear=[HowtheyearStr intValue];
    int howTHeDay;
    if ([currentDayRain isEqualToString:@"01"]) {
        //
        howTHeDay=31;
    }
    else if ([currentDayRain isEqualToString:@"02"])
    {
        if (howTheYear%400==0) {
            
            howTHeDay=29;
        }
        else
        {
            if (howTheYear%4==0&&howTheYear%100!=0) {
                howTHeDay=29;
            }
            else
            {
                howTHeDay=28;
            }
        }
    }
    else if ([currentDayRain isEqualToString:@"03"])
    {
           howTHeDay=31;
    }
    else if ([currentDayRain isEqualToString:@"04"])
    {
        howTHeDay=30;
    }
    else if ([currentDayRain isEqualToString:@"05"])
    {
           howTHeDay=31;
    }
    else if ([currentDayRain isEqualToString:@"06"])
    {
        howTHeDay=30;
    }
    else if ([currentDayRain isEqualToString:@"07"])
    {
           howTHeDay=31;
    }
    else if ([currentDayRain isEqualToString:@"08"])
    {
           howTHeDay=31;
    }
    else if ([currentDayRain isEqualToString:@"09"])
    {
        howTHeDay=30;
    }
    else if ([currentDayRain isEqualToString:@"10"])
    {
           howTHeDay=31;
    }
    else if ([currentDayRain isEqualToString:@"11"])
    {
           howTHeDay=30;
    }
    else
    {
           howTHeDay=31;
    }
    
    
    
    int k=1;
    for (int i=0; i<6; i++)
    {
        for (int j=0; j<7; j++)
        {
            everyDayButton=[UIButton buttonWithType:UIButtonTypeCustom];
            if (!iPad) {
                 everyDayButton.frame=CGRectMake((j*45)+j, i*45+i, 45, 45);
            }
            else
            {
                   everyDayButton.frame=CGRectMake((j*45)+j, i*30+i, 45, 30);
            }
           
            
            everyDayButton.backgroundColor=[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
            everyDayButton.titleLabel.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
            everyDayButton.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:20];
                     [everyDayButton setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]forState:UIControlStateNormal];
            
            
            everyDayButton.tag=(i*7)+j;
            
            
            if ([currentWeekday isEqualToString:@"Mon"]||[currentWeekday isEqualToString:@"周一"]||[currentWeekday isEqualToString:@"週一"]) {
                //
                if (everyDayButton.tag>0&&k<howTHeDay+1)
                {
                    
                    NSString *dayNUmber=[[NSString alloc]initWithFormat:@"%d",k++];
                    [everyDayButton setTitle:dayNUmber  forState:UIControlStateNormal];
                  
                         NSString *tempDateDate=[[NSString alloc]initWithFormat:@"%@%d",timeStrRain,k-1 ];
     
                    
                    if ([tempDateDate isEqualToString:currentDateStr])
                    {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"9" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
                        }
                        else
                        {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
                        }
        
                        self.oldButton=everyDayButton;
                       self.oldButton.backgroundColor=[UIColor colorWithRed:30/255.0 green:62/255.0 blue:58/255.0 alpha:1];
                        [self.oldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                      
                        
                    }
          
                    NSString *tempDateDate222;
                    if (k-1<10)
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@0%d",timeStrRainSum,k-1 ];
                    }
                    else
                    {
                        
                        
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@%d",timeStrRainSum,k-1 ];
                    }
                    if ((self.timeWalkMustableArray>0)&&([self.walkStartDate length]>5)&&([self.walkEndDate length]>6)) {
                        NSString *timeStrRainTheWalkStart1=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkStart2=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkStart3=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainStartSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkStart1,timeStrRainTheWalkStart2,timeStrRainTheWalkStart3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainStartSum);
                        
                        
                        NSString *timeStrRainTheWalkEnd1=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkEnd2=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkEnd3=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainEndSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkEnd1,timeStrRainTheWalkEnd2,timeStrRainTheWalkEnd3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainEndSum);
                        
                        if (([tempDateDate222 intValue]>=[timeStrRainStartSum intValue])&&([tempDateDate222 intValue]<=[timeStrRainEndSum intValue]))
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                   todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                      else
                      {
                             todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                      }
                          
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }

                        
                        
                    }
                    if (self.adDateDate.count>0)
                    {
                        for (int addate=0; addate<self.adDateDate.count; addate++)
                        {
                            
                            NSString *timeStrRainTheOther1=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(0, 4)];
                            NSString *timeStrRainTheOther2=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(5, 2)];
                            NSString *timeStrRainTheOther3=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(8, 2)];
                            
                            NSString *timeStrRainOtherSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheOther1,timeStrRainTheOther2,timeStrRainTheOther3];
                            //NSLog(@",timeStrRainSum===%@,",timeStrRainOtherSum);
                            if ([tempDateDate222 intValue]==[timeStrRainOtherSum intValue]) {
                                NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                                UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                                UIImageView *todayImageView;
                                if (!iPad) {
                                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                                }
                                else
                                {
                                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                                }
                                
                                todayImageView.image=image;
                                [everyDayButton addSubview:todayImageView];
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    if (self.timeBloodMutableArray.count>0||self.timeECGMutableArray.count>0||self.timeGlucoseMutableArray.count>0||self.timesMedicationArray.count>0) {
                        
                    
                    if ([tempDateDate222 intValue]>=[currentDateStr2222 intValue])
                    {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                        }
                        else
                        {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                        }
                     
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                    
                    }
                    
                    
                    }
                }
         
            }
            else if ([currentWeekday isEqualToString:@"Tue"]||[currentWeekday isEqualToString:@"周二"]||[currentWeekday isEqualToString:@"週二"]) {
                //
                if (everyDayButton.tag>1&&k<howTHeDay+1) {
                    NSString *dayNUmber=[[NSString alloc]initWithFormat:@"%d",k++];
                    [everyDayButton setTitle:dayNUmber  forState:UIControlStateNormal];
                    NSString *tempDateDate=[[NSString alloc]initWithFormat:@"%@%d",timeStrRain,k-1 ];
                    if ([tempDateDate isEqualToString:currentDateStr])
                    {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"9" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                             todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
                        }
                       else
                       {
                           todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];

                       }
                        self.oldButton=everyDayButton;
                        self.oldButton.backgroundColor=[UIColor colorWithRed:30/255.0 green:62/255.0 blue:58/255.0 alpha:1];
                        [self.oldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                      
                        
                    }
                    NSString *tempDateDate222;
                    if (k-1<10)
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@0%d",timeStrRainSum,k-1 ];
                    }
                    else
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@%d",timeStrRainSum,k-1 ];
                    }
                    if (self.timeWalkMustableArray>0&&[self.walkEndDate length]>5&&[self.walkStartDate length]>5) {
                        NSString *timeStrRainTheWalkStart1=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkStart2=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkStart3=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainStartSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkStart1,timeStrRainTheWalkStart2,timeStrRainTheWalkStart3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainStartSum);
                        
                        
                        NSString *timeStrRainTheWalkEnd1=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkEnd2=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkEnd3=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainEndSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkEnd1,timeStrRainTheWalkEnd2,timeStrRainTheWalkEnd3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainEndSum);
                        
                        if (([tempDateDate222 intValue]>=[timeStrRainStartSum intValue])&&([tempDateDate222 intValue]<=[timeStrRainEndSum intValue]))
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                            }
                            
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                        
                        
                        
                    }

                    if (self.adDateDate.count>0)
                    {
                        for (int addate=0; addate<self.adDateDate.count; addate++)
                        {
                            
                            NSString *timeStrRainTheOther1=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(0, 4)];
                            NSString *timeStrRainTheOther2=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(5, 2)];
                            NSString *timeStrRainTheOther3=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(8, 2)];
                            
                            NSString *timeStrRainOtherSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheOther1,timeStrRainTheOther2,timeStrRainTheOther3];
                            //NSLog(@",timeStrRainSum===%@,",timeStrRainOtherSum);
                            if ([tempDateDate222 intValue]==[timeStrRainOtherSum intValue]) {
                                NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                                UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                                UIImageView *todayImageView;
                                if (!iPad) {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                                }
                                else
                                {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                                }
                                
                                
                                todayImageView.image=image;
                                [everyDayButton addSubview:todayImageView];
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                       if (self.timeBloodMutableArray.count>0||self.timeECGMutableArray.count>0||self.timeGlucoseMutableArray.count>0||self.timesMedicationArray.count>0)
                       {
                    if ([tempDateDate222 intValue]>=[currentDateStr2222 intValue])
                    {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                        }
                        else
                        {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                        }
                        
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                    }
                       }
                }
                
            }
            else if ([currentWeekday isEqualToString:@"Wed"]||[currentWeekday isEqualToString:@"周三"]||[currentWeekday isEqualToString:@"週三"]) {
                //
                if (everyDayButton.tag>2&&k<howTHeDay+1) {
                    NSString *dayNUmber=[[NSString alloc]initWithFormat:@"%d",k++];
                    [everyDayButton setTitle:dayNUmber  forState:UIControlStateNormal];
                    NSString *tempDateDate=[[NSString alloc]initWithFormat:@"%@%d",timeStrRain,k-1 ];
                    if ([tempDateDate isEqualToString:currentDateStr])
                    {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"9" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        
                        UIImageView *todayImageView;
                        if (!iPad) {
                              todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
                        }
                        else
                        {
                              todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
                        }
                        self.oldButton=everyDayButton;
                        self.oldButton.backgroundColor=[UIColor colorWithRed:30/255.0 green:62/255.0 blue:58/255.0 alpha:1];
                        [self.oldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                   
                        
                        
                    }
                    NSString *tempDateDate222;
                    if (k-1<10)
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@0%d",timeStrRainSum,k-1 ];
                    }
                    else
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@%d",timeStrRainSum,k-1 ];
                    }
                    if (self.timeWalkMustableArray>0&&[self.walkStartDate length]>5&&[self.walkEndDate length]>5) {
                        NSString *timeStrRainTheWalkStart1=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkStart2=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkStart3=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainStartSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkStart1,timeStrRainTheWalkStart2,timeStrRainTheWalkStart3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainStartSum);
                        
                        
                        NSString *timeStrRainTheWalkEnd1=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkEnd2=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkEnd3=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainEndSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkEnd1,timeStrRainTheWalkEnd2,timeStrRainTheWalkEnd3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainEndSum);
                        
                        if (([tempDateDate222 intValue]>=[timeStrRainStartSum intValue])&&([tempDateDate222 intValue]<=[timeStrRainEndSum intValue]))
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20,25, 5, 5)];
                            }
                            
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                        
                        
                        
                    }

                    if (self.adDateDate.count>0)
                    {
                        for (int addate=0; addate<self.adDateDate.count; addate++)
                        {
                            
                            NSString *timeStrRainTheOther1=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(0, 4)];
                            NSString *timeStrRainTheOther2=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(5, 2)];
                            NSString *timeStrRainTheOther3=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(8, 2)];
                            
                            NSString *timeStrRainOtherSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheOther1,timeStrRainTheOther2,timeStrRainTheOther3];
                            //NSLog(@",timeStrRainSum===%@,",timeStrRainOtherSum);
                            if ([tempDateDate222 intValue]==[timeStrRainOtherSum intValue]) {
                                NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                                UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                                UIImageView *todayImageView;
                                if (!iPad) {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                                }
                                else
                                {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20,25, 5, 5)];
                                }
                                
                                todayImageView.image=image;
                                [everyDayButton addSubview:todayImageView];
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                       if (self.timeBloodMutableArray.count>0||self.timeECGMutableArray.count>0||self.timeGlucoseMutableArray.count>0||self.timesMedicationArray.count>0)
                       {
                    if ([tempDateDate222 intValue]>=[currentDateStr2222 intValue])
                    {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                        }
                        else
                        {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20,25, 5, 5)];
                        }
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                     
                    }
                       }
                }
                
            }
            else if ([currentWeekday isEqualToString:@"Thu"]||[currentWeekday isEqualToString:@"周四"]||[currentWeekday isEqualToString:@"週四"]) {
                //
                if (everyDayButton.tag>3&&k<howTHeDay+1) {
                    NSString *dayNUmber=[[NSString alloc]initWithFormat:@"%d",k++];
                    [everyDayButton setTitle:dayNUmber  forState:UIControlStateNormal];
                    NSString *tempDateDate=[[NSString alloc]initWithFormat:@"%@%d",timeStrRain,k-1 ];
                    if ([tempDateDate isEqualToString:currentDateStr]) {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"9" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                              todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
                        }
                        else
                        {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
                        }
                        self.oldButton=everyDayButton;
                        self.oldButton.backgroundColor=[UIColor colorWithRed:30/255.0 green:62/255.0 blue:58/255.0 alpha:1];
                        [self.oldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                        
                        
                        
                    }
                    NSString *tempDateDate222;
                    if (k-1<10)
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@0%d",timeStrRainSum,k-1 ];
                    }
                    else
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@%d",timeStrRainSum,k-1 ];
                    }
                    if (self.timeWalkMustableArray>0&&[self.walkEndDate length]>5&&[self.walkStartDate length]>5) {
                        NSString *timeStrRainTheWalkStart1=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkStart2=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkStart3=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainStartSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkStart1,timeStrRainTheWalkStart2,timeStrRainTheWalkStart3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainStartSum);
                        
                        
                        NSString *timeStrRainTheWalkEnd1=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkEnd2=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkEnd3=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainEndSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkEnd1,timeStrRainTheWalkEnd2,timeStrRainTheWalkEnd3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainEndSum);
                        
                        if (([tempDateDate222 intValue]>=[timeStrRainStartSum intValue])&&([tempDateDate222 intValue]<=[timeStrRainEndSum intValue]))
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                                  todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                                  todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                            }
                            
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                        
                        
                        
                    }

                    if (self.adDateDate.count>0)
                    {
                        for (int addate=0; addate<self.adDateDate.count; addate++)
                        {
                            
                            NSString *timeStrRainTheOther1=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(0, 4)];
                            NSString *timeStrRainTheOther2=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(5, 2)];
                            NSString *timeStrRainTheOther3=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(8, 2)];
                            
                            NSString *timeStrRainOtherSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheOther1,timeStrRainTheOther2,timeStrRainTheOther3];
                            //NSLog(@",timeStrRainSum===%@,",timeStrRainOtherSum);
                            if ([tempDateDate222 intValue]==[timeStrRainOtherSum intValue]) {
                                NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                                UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                                UIImageView *todayImageView;
                                if (!iPad) {
                                      todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                                }
                                else
                                {
                                      todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                                }
                                todayImageView.image=image;
                                [everyDayButton addSubview:todayImageView];
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                       if (self.timeBloodMutableArray.count>0||self.timeECGMutableArray.count>0||self.timeGlucoseMutableArray.count>0||self.timesMedicationArray.count>0)
                       {
                    if ([tempDateDate222 intValue]>=[currentDateStr2222 intValue])
                    {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                        }
                        else
                        {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                        }
                    
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                   
                    }
                       }
                }
                
            }
            else if ([currentWeekday isEqualToString:@"Fri"]||[currentWeekday isEqualToString:@"周五"]||[currentWeekday isEqualToString:@"週五"]) {
                //
                if (everyDayButton.tag>4&&k<howTHeDay+1) {
                    NSString *dayNUmber=[[NSString alloc]initWithFormat:@"%d",k++];
                    [everyDayButton setTitle:dayNUmber  forState:UIControlStateNormal];
                    NSString *tempDateDate=[[NSString alloc]initWithFormat:@"%@%d",timeStrRain,k-1 ];
                    if ([tempDateDate isEqualToString:currentDateStr]) {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"9" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                        }
                        else
                        {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                        }
                        self.oldButton=everyDayButton;
                        self.oldButton.backgroundColor=[UIColor colorWithRed:30/255.0 green:62/255.0 blue:58/255.0 alpha:1];
                        [self.oldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                     
                        
                        
                    }
                    NSString *tempDateDate222;
                    if (k-1<10)
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@0%d",timeStrRainSum,k-1 ];
                    }
                    else
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@%d",timeStrRainSum,k-1 ];
                    }
                    if (self.timeWalkMustableArray>0&&[self.walkEndDate length]>5&&[self.walkStartDate length]>5) {
                        NSString *timeStrRainTheWalkStart1=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkStart2=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkStart3=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainStartSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkStart1,timeStrRainTheWalkStart2,timeStrRainTheWalkStart3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainStartSum);
                        
                        
                        NSString *timeStrRainTheWalkEnd1=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkEnd2=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkEnd3=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainEndSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkEnd1,timeStrRainTheWalkEnd2,timeStrRainTheWalkEnd3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainEndSum);
                        
                        if (([tempDateDate222 intValue]>=[timeStrRainStartSum intValue])&&([tempDateDate222 intValue]<=[timeStrRainEndSum intValue]))
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                            }
                            
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                        
                        
                        
                    }

                    if (self.adDateDate.count>0)
                    {
                        for (int addate=0; addate<self.adDateDate.count; addate++)
                        {
                            
                            NSString *timeStrRainTheOther1=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(0, 4)];
                            NSString *timeStrRainTheOther2=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(5, 2)];
                            NSString *timeStrRainTheOther3=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(8, 2)];
                            
                            NSString *timeStrRainOtherSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheOther1,timeStrRainTheOther2,timeStrRainTheOther3];
                            //NSLog(@",timeStrRainSum===%@,",timeStrRainOtherSum);
                            if ([tempDateDate222 intValue]==[timeStrRainOtherSum intValue]) {
                                NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                                UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                                UIImageView *todayImageView;
                                if (!iPad) {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                                }
                                else
                                {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                                }
                                
                                todayImageView.image=image;
                                [everyDayButton addSubview:todayImageView];
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    if (self.timeBloodMutableArray.count>0||self.timeECGMutableArray.count>0||self.timeGlucoseMutableArray.count>0||self.timesMedicationArray.count>0)
                    {
                        
                        if ([tempDateDate222 intValue]>=[currentDateStr2222 intValue])
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                            }
                            
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                    }
                }
                
            }
            else if ([currentWeekday isEqualToString:@"Sat"]||[currentWeekday isEqualToString:@"周六"]||[currentWeekday isEqualToString:@"週六"]) {
                //
                if (everyDayButton.tag>5&&k<howTHeDay+1) {
                    NSString *dayNUmber=[[NSString alloc]initWithFormat:@"%d",k++];
                    [everyDayButton setTitle:dayNUmber  forState:UIControlStateNormal];
                    NSString *tempDateDate=[[NSString alloc]initWithFormat:@"%@%d",timeStrRain,k-1 ];
                    if ([tempDateDate isEqualToString:currentDateStr]) {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"9" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
                        }
                        else
                        {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
                        }
                        self.oldButton=everyDayButton;
                        self.oldButton.backgroundColor=[UIColor colorWithRed:30/255.0 green:62/255.0 blue:58/255.0 alpha:1];
                        [self.oldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                        
                    }
                    
                    NSString *tempDateDate222;
                    if (k-1<10)
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@0%d",timeStrRainSum,k-1 ];
                    }
                    else
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@%d",timeStrRainSum,k-1 ];
                    }
                    if (self.timeWalkMustableArray>0&&[self.walkEndDate length]>5&&[self.walkStartDate length]>5) {
                        NSString *timeStrRainTheWalkStart1=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkStart2=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkStart3=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainStartSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkStart1,timeStrRainTheWalkStart2,timeStrRainTheWalkStart3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainStartSum);
                        
                        
                        NSString *timeStrRainTheWalkEnd1=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkEnd2=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkEnd3=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainEndSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkEnd1,timeStrRainTheWalkEnd2,timeStrRainTheWalkEnd3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainEndSum);
                        
                        if (([tempDateDate222 intValue]>=[timeStrRainStartSum intValue])&&([tempDateDate222 intValue]<=[timeStrRainEndSum intValue]))
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                   todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                   todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                            }
                        
                            
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                        
                        
                        
                    }

                    if (self.adDateDate.count>0)
                    {
                        for (int addate=0; addate<self.adDateDate.count; addate++)
                        {
                            
                            NSString *timeStrRainTheOther1=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(0, 4)];
                            NSString *timeStrRainTheOther2=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(5, 2)];
                            NSString *timeStrRainTheOther3=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(8, 2)];
                            
                            NSString *timeStrRainOtherSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheOther1,timeStrRainTheOther2,timeStrRainTheOther3];
                            //NSLog(@",timeStrRainSum===%@,",timeStrRainOtherSum);
                            if ([tempDateDate222 intValue]==[timeStrRainOtherSum intValue]) {
                                NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                                UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                                UIImageView *todayImageView;
                                if (!iPad) {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                                }
                                else
                                {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                                }
                                todayImageView.image=image;
                                [everyDayButton addSubview:todayImageView];
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    if (self.timeBloodMutableArray.count>0||self.timeECGMutableArray.count>0||self.timeGlucoseMutableArray.count>0||self.timesMedicationArray.count>0)
                    {
                        if ([tempDateDate222 intValue]>=[currentDateStr2222 intValue])
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                            }
                            
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                    }
                }
                
            }
            else
            {
                if (k<howTHeDay+1) {
                    NSString *dayNUmber=[[NSString alloc]initWithFormat:@"%d",k++];
                    [everyDayButton setTitle:dayNUmber  forState:UIControlStateNormal];
                    NSString *tempDateDate=[[NSString alloc]initWithFormat:@"%@%d",timeStrRain,k-1 ];
                    if ([tempDateDate isEqualToString:currentDateStr]) {
                        NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"9" ofType:@"png"];
                        UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                        UIImageView *todayImageView;
                        if (!iPad) {
                            
                        todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
                        }
                        else
                        {
                            todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
                        }
                        self.oldButton=everyDayButton;
                        self.oldButton.backgroundColor=[UIColor colorWithRed:30/255.0 green:62/255.0 blue:58/255.0 alpha:1];
                        [self.oldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        todayImageView.image=image;
                        [everyDayButton addSubview:todayImageView];
                        
                        
                        
                    }
                    
                    NSString *tempDateDate222;
                    if (k-1<10)
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@0%d",timeStrRainSum,k-1 ];
                    }
                    else
                    {
                        tempDateDate222=[[NSString alloc]initWithFormat:@"%@%d",timeStrRainSum,k-1 ];
                    }
                    if (self.timeWalkMustableArray>0&&[self.walkEndDate length]>5&&[self.walkStartDate length]>5) {
                        NSString *timeStrRainTheWalkStart1=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkStart2=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkStart3=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainStartSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkStart1,timeStrRainTheWalkStart2,timeStrRainTheWalkStart3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainStartSum);
                        
                        
                        NSString *timeStrRainTheWalkEnd1=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
                        NSString *timeStrRainTheWalkEnd2=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
                        NSString *timeStrRainTheWalkEnd3=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
                        NSString *timeStrRainEndSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheWalkEnd1,timeStrRainTheWalkEnd2,timeStrRainTheWalkEnd3];
                        //NSLog(@",timeStrRainSum===%@,",timeStrRainEndSum);
                        
                        if (([tempDateDate222 intValue]>=[timeStrRainStartSum intValue])&&([tempDateDate222 intValue]<=[timeStrRainEndSum intValue]))
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                            }
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                        
                        
                        
                    }

                    if (self.adDateDate.count>0)
                    {
                        for (int addate=0; addate<self.adDateDate.count; addate++)
                        {
                
                            NSString *timeStrRainTheOther1=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(0, 4)];
                            NSString *timeStrRainTheOther2=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(5, 2)];
                            NSString *timeStrRainTheOther3=[[self.adDateDate objectAtIndex:addate ] substringWithRange:NSMakeRange(8, 2)];
                            
                            NSString *timeStrRainOtherSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainTheOther1,timeStrRainTheOther2,timeStrRainTheOther3];
                            //NSLog(@",timeStrRainSum===%@,",timeStrRainOtherSum);
                            if ([tempDateDate222 intValue]==[timeStrRainOtherSum intValue]) {
                                NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                                UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                                UIImageView *todayImageView;
                                if (!iPad) {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                                }
                                else
                                {
                                    todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                                }
                                todayImageView.image=image;
                                [everyDayButton addSubview:todayImageView];

                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    if (self.timeBloodMutableArray.count>0||self.timeECGMutableArray.count>0||self.timeGlucoseMutableArray.count>0||self.timesMedicationArray.count>0)
                    {
                        if ([tempDateDate222 intValue]>=[currentDateStr2222 intValue])
                        {
                            NSString *toDayPicture=[[NSBundle mainBundle]pathForResource:@"02_diary_mark_p1" ofType:@"png"];
                            UIImage * image=[[UIImage alloc]initWithContentsOfFile:toDayPicture];
                            UIImageView *todayImageView;
                            if (!iPad) {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 37, 5, 5)];
                            }
                            else
                            {
                                todayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 5, 5)];
                            }

                            
                            todayImageView.image=image;
                            [everyDayButton addSubview:todayImageView];
                            
                        }
                    }
                }
                
            }
            
            
            
            
            
            [everyDayButton addTarget:self action:@selector(buttonclickMonth:) forControlEvents:UIControlEventTouchUpInside];
            [buttonMonthDayVIew addSubview:everyDayButton];
            
            
        }
    }
}

-(IBAction)turnleftMONTH:(id)sender
{
    //NSLog(@"------%lu-------dateDate=%@",(unsigned long)[dateDate length],dateDate);
    self.oldButton=nil;
    NSString * timeStrRain=[dateDate substringWithRange:NSMakeRange(5, 2)];
    
        NSString * yearRain=[dateDate substringWithRange:NSMakeRange(0, 4)];
    
    int monthRainInt=[timeStrRain intValue];
    
    int yearModifINt=[yearRain intValue];
    
    monthRainInt--;
    
    if (monthRainInt<1)
    {
        yearModifINt--;
        monthRainInt=12;
    }
    NSString * modifyTheDay;
    if (monthRainInt<10) {
        modifyTheDay    =[[NSString alloc]initWithFormat:@"%d-0%d-01",yearModifINt,monthRainInt];
    }
    else
    {
        modifyTheDay=[[NSString alloc]initWithFormat:@"%d-%d-01",yearModifINt,monthRainInt];
    }
    
    //NSLog(@"modif---------%@",modifyTheDay);
    dateDate=modifyTheDay;
    [self monthDairy:dateDate];
      //  [self thescrollViewHeight];
}
-(IBAction)turnrightMONTH:(id)sender
{
       self.oldButton=nil;
    //NSLog(@"------%lu-------dateDate=%@",(unsigned long)[dateDate length],dateDate);
    NSString * timeStrRain=[dateDate substringWithRange:NSMakeRange(5, 2)];
    NSString * yearRain=[dateDate substringWithRange:NSMakeRange(0, 4)];
    int monthRainInt=[timeStrRain intValue];
    int yearModifINt=[yearRain intValue];
    monthRainInt++;
    if (monthRainInt>12)
    {
        yearModifINt++;
        monthRainInt=1;
    }
    NSString * modifyTheDay;
    if (monthRainInt<10) {
    modifyTheDay    =[[NSString alloc]initWithFormat:@"%d-0%d-01",yearModifINt,monthRainInt];
    }
    else
    {
    modifyTheDay=[[NSString alloc]initWithFormat:@"%d-%d-01",yearModifINt,monthRainInt];
    }

    //NSLog(@"modif---------%@",modifyTheDay);
    dateDate=modifyTheDay;
    [self monthDairy:dateDate];
   //     [self thescrollViewHeight];
}

-(void)buttonclickMonth:(UIButton*)sender
{
    
    //NSLog(@"%ld",(long)sender.tag);

    if (self.oldButton) {
        self.oldButton.backgroundColor=[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
        [self.oldButton setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
    }
    

    
    if (sender.currentTitle ==NULL) {
            //NSLog(@"sender===%@",sender.currentTitle);
        
        if (sender.tag<10)
        {
            //NSLog(@"我要回到上個月");
            [self turnleftMONTH:nil];
            return;
            
        }
        else
        {
            //NSLog(@"我要跳到下個月");
            [self turnrightMONTH:nil];
            return;
        }
        
        
        
        
    }
    else
    {
    sender.backgroundColor=[UIColor colorWithRed:30/255.0 green:62/255.0 blue:58/255.0 alpha:1];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //NSLog(@"sender===%@",sender.currentTitle);
    }
    
    self.oldButton=sender;
    
    NSString * timeStrRain222;
    NSString *timeStrRain333;
  
    if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
        timeStrRain222 =[monthHendText.text substringWithRange:NSMakeRange(4,4)];
       timeStrRain333  =[monthHendText.text substringWithRange:NSMakeRange(0, 3)];
    }
    else
    {
        //NSLog(@"TimeStrRinlentf=%lu",(unsigned long)[monthHendText.text length]);
        if ([monthHendText.text length]==7) {
            timeStrRain222 =[monthHendText.text substringWithRange:NSMakeRange(0,4)];
            timeStrRain333  =[monthHendText.text substringWithRange:NSMakeRange(5,1)];
        }
        else if([monthHendText.text length]==8)
        {
            timeStrRain222 =[monthHendText.text substringWithRange:NSMakeRange(0,4)];
            timeStrRain333  =[monthHendText.text substringWithRange:NSMakeRange(5,2)];
        }
  
    }
    //NSLog(@"timeStrRain333=====%@",timeStrRain333);
    
 
    NSString * allTheDay;
    if ([timeStrRain333 isEqualToString:@"Jan"]||[timeStrRain333 isEqualToString:@"1"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-01",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Feb"]||[timeStrRain333 isEqualToString:@"2"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-02",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Mar"]||[timeStrRain333 isEqualToString:@"3"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-03",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Apr"]||[timeStrRain333 isEqualToString:@"4"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-04",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"May"]||[timeStrRain333 isEqualToString:@"5"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-05",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Jun"]||[timeStrRain333 isEqualToString:@"6"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-06",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Jul"]||[timeStrRain333 isEqualToString:@"7"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-07",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Aug"]||[timeStrRain333 isEqualToString:@"8"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-08",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Sep"]||[timeStrRain333 isEqualToString:@"9"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-09",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Oct"]||[timeStrRain333 isEqualToString:@"10"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-10",timeStrRain222];
    }
    else  if ([timeStrRain333 isEqualToString:@"Nov"]||[timeStrRain333 isEqualToString:@"11"]) {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-11",timeStrRain222];
    }
    else
    {
        allTheDay=[[NSString alloc]initWithFormat:@"%@-12",timeStrRain222];
    }
    //NSLog(@"<<<-%@-%@>>>",allTheDay,timeStrRain222);
    
    NSString*str=[[NSString alloc]initWithFormat:@"%@-%@",allTheDay,sender.currentTitle];
    
    //NSLog(@"%@",str);
    NSString*str2;
    if ([sender.currentTitle intValue]<10) {
          str2=[[NSString alloc]initWithFormat:@"%@-0%@",allTheDay,sender.currentTitle];
    }
    else
    {
        str2=[[NSString alloc]initWithFormat:@"%@-%@",allTheDay,sender.currentTitle];
    }
    self.dateDateStr=str;
    
    dateDate=str2;
    
    NSString *timeStrRaindateDate111=[dateDate substringWithRange:NSMakeRange(0, 4)];
    NSString *timeStrRaindateDate222=[dateDate substringWithRange:NSMakeRange(5, 2)];
    NSString *timeStrRaindateDate333=[dateDate substringWithRange:NSMakeRange(8, 2)];
    timeStrRaindateDateSum111=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRaindateDate111,timeStrRaindateDate222,timeStrRaindateDate333];
    //NSLog(@",timeStrRainSum===%@,",timeStrRaindateDateSum111);
    if ([self.walkStartDate length]>5) {
        NSString *timeStrRainStratDate111=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
        NSString *timeStrRainStratDate222=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
        NSString *timeStrRainStratDate333=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
        timeStrRainStratDateSum111=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainStratDate111,timeStrRainStratDate222,timeStrRainStratDate333];
    }
 
    //NSLog(@",timeStrRainSum===%@,",timeStrRainStratDateSum111);
    if ([self.walkEndDate length]>6) {
        NSString *timeStrRainENDDate111=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
        NSString *timeStrRainENDDate222=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
        NSString *timeStrRainENDDate333=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
        timeStrRainENDDateSum111=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainENDDate111,timeStrRainENDDate222,timeStrRainENDDate333];
    }
    
 
    //NSLog(@",timeStrRainSum===%@,",timeStrRainENDDateSum111);
    
    
    
    
  //  NSDateFormatter* dateFormat0000 = [[NSDateFormatter alloc] init];
 //   [dateFormat0000 setDateFormat:@"yyyy-MM-dd"];
   // NSString *currentDateStr00 = [dateFormat0000 stringFromDate:[NSDate date]];
    //NSLog(@"%@",currentDateStr00);
    
    NSDateFormatter* dateFormat11100 = [[NSDateFormatter alloc] init];
    [dateFormat11100 setDateFormat:@"yyyyMMdd"];
    currentDateStr11100 = [dateFormat11100 stringFromDate:[NSDate date]];
    //NSLog(@"%@=========",currentDateStr11100);
        [self adhocOther];
      [self VIP_Channel];
      [_tableMonthView reloadData];
 
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date =[dateFormat dateFromString:dateDate];
    [self dayANDweek:date];
      [self thescrollViewHeight];
    
}
-(void)buttonclick:(UIButton*)sender
{
    //NSLog(@"______BLUe=UIDeviceRGBColorSpace 0 0 1 1 _____Red=UIDeviceRGBColorSpace 1 0 0 1____%ld_____Puple=UIDeviceRGBColorSpace 0.5 0 0.5 1__orange=UIDeviceRGBColorSpace 1 0.5 0 1___",(long)sender.tag);
    //NSLog(@"________%@",sender.titleLabel.text);
    //NSLog(@"_____%@",[sender.backgroundColor description]);
    DayChickViewController*_information=[[DayChickViewController alloc]initWithNibName:@"DayChickViewController" bundle:nil];
    //NSLog(@"--%@,",sender.superview.viewForBaselineLayout);
    if (sender.superview==_cellView00) {
             //NSLog(@"我是 0 --點鐘");
        self.theTime=@"00";
    }
    else if (sender.superview==_cellView01)
    {
            //NSLog(@"我是 1 --點鐘");
         self.theTime=@"01";
    }
   else if (sender.superview==_cellView02) {
             //NSLog(@"我是 2 --點鐘");
        self.theTime=@"02";
    }
    else if (sender.superview==_cellView03)
    {
             //NSLog(@"我是 3 --點鐘");
         self.theTime=@"03";
    }
    else if (sender.superview==_cellView04)
    {
             //NSLog(@"我是 4 --點鐘");
         self.theTime=@"04";
    }
    else if (sender.superview==_cellView05) {
             //NSLog(@"我是 5 --點鐘");
         self.theTime=@"05";
    }
    else if (sender.superview==_cellView06)
    {
             //NSLog(@"我是 6 --點鐘");
         self.theTime=@"06";
    }
    else if (sender.superview==_cellView07)
    {
             //NSLog(@"我是 7 --點鐘");
         self.theTime=@"07";
    }
    else if (sender.superview==_cellView08) {
             //NSLog(@"我是 8 --點鐘");
         self.theTime=@"08";
    }
    else if (sender.superview==_cellView09)
    {
              //NSLog(@"我是 9 --點鐘");
         self.theTime=@"09";
    }
    else if (sender.superview==_cellView10)
    {
        //NSLog(@"我是 10 --點鐘");
         self.theTime=@"10";
    }
    else if (sender.superview==_cellView11) {
        //NSLog(@"我是 11 --點鐘");
         self.theTime=@"11";
    }
    else if (sender.superview==_cellView12)
    {
        //NSLog(@"我是 12 --點鐘");
         self.theTime=@"12";
    }
    else if (sender.superview==_cellView13)
    {
        //NSLog(@"我是 13 --點鐘");
         self.theTime=@"13";
    }
    else if (sender.superview==_cellView14) {
        //NSLog(@"我是 14 --點鐘");
         self.theTime=@"14";
    }
    else if (sender.superview==_cellView15)
    {
        //NSLog(@"我是 15 --點鐘");
         self.theTime=@"15";
    }
    else if (sender.superview==_cellView16)
    {
        //NSLog(@"我是 16 --點鐘");
         self.theTime=@"16";
    }
    else if (sender.superview==_cellView17) {
        //NSLog(@"我是 17 --點鐘");
         self.theTime=@"17";
    }
    else if (sender.superview==_cellView18)
    {
        //NSLog(@"我是 18 --點鐘");
         self.theTime=@"18";
    }
    else if (sender.superview==_cellView19)
    {
        //NSLog(@"我是 19 --點鐘");
         self.theTime=@"19";
    }
    else if (sender.superview==_cellView20) {
        //NSLog(@"我是 20 --點鐘");
         self.theTime=@"20";
    }
    else if (sender.superview==_cellView21)
    {
        //NSLog(@"我是 21 --點鐘");
         self.theTime=@"21";
    }
    else if (sender.superview==_cellView22) {
        //NSLog(@"我是 22 --點鐘");
         self.theTime=@"22";
    }
    else if (sender.superview==_cellView23)
    {
        //NSLog(@"我是 23 --點鐘");
         self.theTime=@"23";
    }
    
    _information.theTime=[[NSString alloc]initWithString:self.theTime];
    _information.dateDateStr=labelDay.text;
    
    if (sender.tag>=10000&&sender.tag<20000)
    {
        //BG
        _information.str1=[Utility getStringByKey:@"Daily Measurement"];
        _information.str2=[Utility getStringByKey:@"Blood Pressure"];
        _information._allArray=self.timeBloodMutableArray;
        
        //NSLog(@"BP");
        
    }
    else if (sender.tag>=20000&&sender.tag<30000)
    {
        _information.str1=[Utility getStringByKey:@"Daily Measurement"];
        _information.str2=[Utility getStringByKey:@"ECG"];
    
        _information._allArray=self.timeECGMutableArray;
        //NSLog(@"ECG");
    }
    else if(sender.tag>=30000&&sender.tag<40000)
    {
        _information.str1=[Utility getStringByKey:@"Daily Measurement"];
        _information.str2=[Utility getStringByKey:@"Blood Glucose"];
        _information._allArray=self.timeGlucoseMutableArray;
        //NSLog(@"BGG");
    }
    else if(sender.tag>=40000&&sender.tag<50000)

    {

        _information._array=self.titleMedicationArray;
        _information._allArray=self.timesMedicationArray;
        _information.docAgeArray=self.dosageMedicationArray;
        _information.medientID=self.medID ;
        _information.imageArray=self.imageMedicationArray;

        _information.str1=[Utility getStringByKey:@"Daily Medication"];
        _information.str2=sender.titleLabel.text;
        //NSLog(@"self Didle.AEEAY=%@",self.titleMedicationArray);
        for (int i=0; i<[self.titleMedicationArray count]; i++)
        {
            NSString * strTEMP=[[NSString alloc]initWithFormat:@" %@",[self.titleMedicationArray objectAtIndex:i ]];
            //NSLog(@"stRTEMP=%@,,,,,,ARRAO=%@",strTEMP,sender.titleLabel.text);
            if ([strTEMP isEqualToString:sender.titleLabel.text])
            {
                
                _information.str2=[self.titleMedicationArray objectAtIndex:i];
                
                _information.str3=[self.timesMedicationArray objectAtIndex:i];
                //NSLog(@"%@_____________",[self.timesMedicationArray objectAtIndex:i]);
                _information.str4=[self.dosageMedicationArray objectAtIndex:i];
                _information.medWitchID=i;
                _information.ididid=[self.medID objectAtIndex:i];
                _information.tiken=[self.tikenMedicationArray objectAtIndex:i];
                _information.imageStr=[self.imageMedicationArray objectAtIndex:i];
                _information.strNote =[self.noteMedicationArray objectAtIndex:i];
                
            }
            
        }
        
        
        _information.turntikenMedicationArray=[[NSMutableArray alloc]initWithArray:self.tikenMedicationArray];
        _information.turntitleMedicationArray=[[NSMutableArray alloc]initWithArray:self.titleMedicationArray];
        _information.turntimesMedicationArray=[[NSMutableArray alloc]initWithArray:self.timesMedicationArray];
        _information.turnmedID=[[NSMutableArray alloc]initWithArray: self.medID];
        _information.turndosageMedicationArray=[[NSMutableArray alloc]initWithArray:self.dosageMedicationArray];
        _information.turnMealMedicationArray=[[NSMutableArray alloc]initWithArray:self.mealMedicationArray];
        _information.turnImageMedicationArray=[[NSMutableArray alloc]initWithArray:self.imageMedicationArray];
        _information.turnNoteMedicationArray=[[NSMutableArray alloc]initWithArray:self.noteMedicationArray];

        //NSLog(@"Madinon");
    }
    else if (sender.tag>=50000&&sender.tag<60000)
    {
        _information.str1=[Utility getStringByKey:@"Others"];
        for (int i =0; i< [self.adDateDate count]; i++)
            
        {
            if ( [dateDate isEqualToString:[self.adDateDate objectAtIndex:i ]])
                
            {
                
                NSString *temp=[[self.startTimesArray objectAtIndex:i] substringWithRange:NSMakeRange(0, 2)];
                if ([temp isEqualToString:self.theTime]) {
                    //NSLog(@"TEMP======%@,THE TIME=======%@",temp,self.theTime);
                    _information.str2=[self.titleAdhocArray objectAtIndex:i];
                    _information.str3=[self.adHoNote objectAtIndex:i];
                    
                    _information.str4=[self.adDateDate objectAtIndex:i];
                    _information._timeStart=[self.startTimesArray objectAtIndex:i];
                    _information._timeEnd=[self.endTimesArray objectAtIndex:i];
                    
                    _information.otherID=[self.adHocID objectAtIndex:i];
                    
                    break;

                }
                          }
            
        }
        
    }
    else
    {
        _information.str1=[Utility getStringByKey:@"Exercise"];
        NSString *str=[[NSString alloc]init];
        for (int o=0; o<self.timeWalkMustableArray.count; o++)
        {
            str=[str stringByAppendingString:[self.timeWalkMustableArray objectAtIndex:o]];
            str=[str stringByAppendingString:@" "];
            
        }
        _information.str2=str;
        _information.turnWalkingArray=[[NSMutableArray alloc]initWithArray:self.timeWalkMustableArray];
    }
    
    
    [self.navigationController pushViewController:_information animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tableMonthView)
    {
        //NSLog(@"%lu",(unsigned long)mutableArray.count);
        return [myArray count];
        
    }
    else
    {
        return [_timeArray count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       [self thescrollViewHeight];
    if (tableView==_tableMonthView)
    {
        int scollowINT=0;
        switch (indexPath.row)
        {
            case 0:
                if (((self.timeECGMutableArray.count+self.timeBloodMutableArray.count+self.timeGlucoseMutableArray.count>0))&&((self.timeECGMutableArray.count+self.timeBloodMutableArray.count+self.timeGlucoseMutableArray.count<6))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
                {
                    scollowINT+=60;
                    return 70;
                  
                }
                else if(((self.timeECGMutableArray.count+self.timeBloodMutableArray.count+self.timeGlucoseMutableArray.count>=6))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
                {
                     scollowINT+=80;
                    return 85;
                   
                }
                else
                {
                     scollowINT+=0;
                    return 0;
                    
                }
                break;
            case 1:
                if (((self.timesMedicationArray.count>0))&&((self.timesMedicationArray.count<=6))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
                {
                    scollowINT+=60;
                    return 70;
                    
                }
                else if (((self.timesMedicationArray.count>5))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
                {
                    return self.timesMedicationArray.count/5*20+70;
                    //scollowINT+=self.timesMedicationArray.count/5*25+50;
                    //NSLog(@" scollowINT+=self.timesMedicationArray.count/5*100+70;=%d",scollowINT);
                }
                else
                {
                     scollowINT+=0;
                    return 0;
                    
                }
                break;
            case 2:
                if([todyAdhocTime length]>3)
                {
                     scollowINT+=60;
                    return 70;
                    
                   
                }
                else
                {
                     scollowINT+=0;
                    return 0;
                    
                }
                
                break;
            case 3:
                if((self.timeWalkMustableArray.count>0)&&(([timeStrRaindateDateSum111 intValue]>=[timeStrRainStratDateSum111 intValue])&&([timeStrRaindateDateSum111 intValue]<=[timeStrRainENDDateSum111 intValue])))
                {
                      scollowINT+=60;
                    return 70;
                   
                }
                else
                {
                      scollowINT+=0;
                    return 0;
                   
                }
                break;
                
            default:
                  scollowINT+=0;
                return 0;
               
                break;
          
                //NSLog(@"scollowINT=%d",scollowINT);
           
        }
     theTableViewMonthHEight=scollowINT;
        
    }
    
    else
    {
        switch (indexPath.row)
        {
            case 0:
                if (_cellView00.frame.size.height+4>30)
                {
                    return _cellView00.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 1:
                if (_cellView01.frame.size.height+4>30)
                {
                    return _cellView01.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 2:
                if (_cellView02.frame.size.height+4>30)
                {
                    return _cellView02.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 3:
                if (_cellView03.frame.size.height+4>30)
                {
                    return _cellView03.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 4:
                if (_cellView04.frame.size.height+4>30)
                {
                    return _cellView04.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 5:
                if (_cellView05.frame.size.height+4>30)
                {
                    return _cellView05.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 6:
                if (_cellView06.frame.size.height+4>30)
                {
                    return _cellView06.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 7:
                
                if (_cellView07.frame.size.height+4>30)
                {
                    return _cellView07.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 8:
                if (_cellView08.frame.size.height+4>30)
                {
                    return _cellView08.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 9:
                if (_cellView09.frame.size.height+4>30)
                {
                    return _cellView09.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 10:
                if (_cellView10.frame.size.height+4>30)
                {
                    return _cellView10.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 11:
                if (_cellView11.frame.size.height+4>30)
                {
                    return _cellView11.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 12:
                if (_cellView12.frame.size.height+4>30)
                {
                    return _cellView12.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 13:
                if (_cellView13.frame.size.height+4>30)
                {
                    return _cellView13.frame.size.height+8;
                }
                else
                {
                    return 334;
                }
                break;
            case 14:
                if (_cellView14.frame.size.height+4>30)
                {
                    return _cellView14.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 15:
                if (_cellView15.frame.size.height+4>30)
                {
                    return _cellView15.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 16:
                if (_cellView16.frame.size.height+4>30)
                {
                    return _cellView16.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 17:
                if (_cellView17.frame.size.height+4>30)
                {
                    return _cellView17.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 18:
                if (_cellView18.frame.size.height+4>30)
                {
                    return _cellView18.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 19:
                if (_cellView19.frame.size.height+4>30)
                {
                    return _cellView19.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 20:
                if (_cellView20.frame.size.height+4>30)
                {
                    return _cellView20.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 21:
                if (_cellView21.frame.size.height+4>30)
                {
                    return _cellView21.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 22:
                if (_cellView22.frame.size.height+4>30)
                {
                    return _cellView22.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            case 23:
                if (_cellView23.frame.size.height+4>30)
                {
                    return _cellView23.frame.size.height+8;
                }
                else
                {
                    return 34;
                }
                break;
            default:
                return 34;
                break;
        }
    }
    return 0;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(IBAction)turnleftday:(id)sender
{
    
    //NSLog(@"%@",dateDate);
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *dates=[dateFormat dateFromString:dateDate];
    NSTimeInterval secondsPerDay = -(24*60*60);
    NSDate *tomorrow = [dates dateByAddingTimeInterval:secondsPerDay];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr=[dateFormatter stringFromDate:tomorrow];
   dateDate=currentDateStr;
    //NSLog(@"tomorrow= %@  currentDateStr=%@ ",tomorrow,currentDateStr);
    NSDateFormatter* dateFormatWeek = [[NSDateFormatter alloc] init];
    [dateFormatWeek setDateFormat:@"EEE"];
    NSString *currentWeekday = [dateFormatWeek stringFromDate:tomorrow];
    //NSLog(@"------%@----",currentWeekday);
    
    
    NSString *theWeekName;
    if ([currentWeekday isEqualToString:@"Mon"]||[currentWeekday isEqualToString:@"周一"]||[currentWeekday isEqualToString:@"週一"]||[currentWeekday isEqualToString:@"星期一"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Monday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期一"];
        }
    }
    else if ([currentWeekday isEqualToString:@"Tue"]||[currentWeekday isEqualToString:@"周二"]||[currentWeekday isEqualToString:@"週二"]||[currentWeekday isEqualToString:@"星期二"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Tuesday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期二"];
        }
        
    }
    else if ([currentWeekday isEqualToString:@"Wed"]||[currentWeekday isEqualToString:@"周三"]||[currentWeekday isEqualToString:@"週三"]||[currentWeekday isEqualToString:@"星期三"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Wednesday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期三"];
        }
        
    }
    else if ([currentWeekday isEqualToString:@"Thu"]||[currentWeekday isEqualToString:@"周四"]||[currentWeekday isEqualToString:@"週四"]||[currentWeekday isEqualToString:@"星期四"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Thursday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期四"];
        }
        
    }
    else if ([currentWeekday isEqualToString:@"Fri"]||[currentWeekday isEqualToString:@"周五"]||[currentWeekday isEqualToString:@"週五"]||[currentWeekday isEqualToString:@"星期五"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Firday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期五"];
        }
        
    }
    else if ([currentWeekday isEqualToString:@"Sat"]||[currentWeekday isEqualToString:@"周六"]||[currentWeekday isEqualToString:@"週六"]||[currentWeekday isEqualToString:@"星期六"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Saturday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期六"];
        }
        
    }
    else if ([currentWeekday isEqualToString:@"Sun"]||[currentWeekday isEqualToString:@"周日"]||[currentWeekday isEqualToString:@"週日"]||[currentWeekday isEqualToString:@"星期日"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Sunday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期日"];
        }
        
    }
    
    NSString * timeStrRain111=[currentDateStr substringWithRange:NSMakeRange(8,2)];
    
    NSString * timeStrRain222=[currentDateStr substringWithRange:NSMakeRange(0,4)];
    NSString *timeStrRain333=[currentDateStr substringWithRange:NSMakeRange(5, 2)];
    NSString * allTheDay;
    if ([timeStrRain333 isEqualToString:@"01"]) {
          if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
          {
              allTheDay=[[NSString alloc]initWithFormat:@"Jan %@",timeStrRain222];
          }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年1月",timeStrRain222];
        }
    }
    else  if ([timeStrRain333 isEqualToString:@"02"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Feb %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年2月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"03"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Mar %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年3月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"04"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Apr %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年4月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"05"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"May %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年5月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"06"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
           allTheDay=[[NSString alloc]initWithFormat:@"Jun %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年6月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"07"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Jul %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年7月",timeStrRain222];
        }
       
    }
    else  if ([timeStrRain333 isEqualToString:@"08"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
          allTheDay=[[NSString alloc]initWithFormat:@"Aug %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年8月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"09"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
           allTheDay=[[NSString alloc]initWithFormat:@"Sep %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年9月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"10"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Oct %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年10月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"11"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Nov %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年11月",timeStrRain222];
        }
        
    }
    else
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Dec %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年12月",timeStrRain222];
        }
        
    }
    //NSLog(@"<<<%@-%@-%@>>>",timeStrRain111,allTheDay,timeStrRain222);
    NSString *sumDay;
    if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
          sumDay =[[NSString alloc]initWithFormat:@"%@%d %@",theWeekName,[timeStrRain111 intValue],allTheDay];
    }
 else
 {
 
       sumDay=[[NSString alloc]initWithFormat:@" %@%d日 (%@)",allTheDay,[timeStrRain111 intValue],theWeekName];
 }
    labelDay.text=sumDay;
    
    [self VIP_Channel];
}
-(IBAction)turnrightday:(id)sender
{

    //NSLog(@"%@",dateDate);
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *dates=[dateFormat dateFromString:dateDate];
    NSTimeInterval secondsPerDay = +(24*60*60);
    NSDate *tomorrow = [dates dateByAddingTimeInterval:secondsPerDay];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr=[dateFormatter stringFromDate:tomorrow];
    dateDate=currentDateStr;
    NSDateFormatter* dateFormatWeek = [[NSDateFormatter alloc] init];
    
    [dateFormatWeek setDateFormat:@"EEE"];
    NSString *currentWeekday = [dateFormatWeek stringFromDate:tomorrow];
    //NSLog(@"------%@----",currentWeekday);
    
    NSString *theWeekName;
    if ([currentWeekday isEqualToString:@"Mon"]||[currentWeekday isEqualToString:@"周一"]||[currentWeekday isEqualToString:@"週一"]||[currentWeekday isEqualToString:@"星期一"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             theWeekName=[[NSString alloc] initWithFormat:@"Monday"];
        }
       else
       {
              theWeekName=[[NSString alloc] initWithFormat:@"星期一"];
       }
    }
    else if ([currentWeekday isEqualToString:@"Tue"]||[currentWeekday isEqualToString:@"周二"]||[currentWeekday isEqualToString:@"週二"]||[currentWeekday isEqualToString:@"星期二"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
                theWeekName=[[NSString alloc] initWithFormat:@"Tuesday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期二"];
        }
    
    }
    else if ([currentWeekday isEqualToString:@"Wed"]||[currentWeekday isEqualToString:@"周三"]||[currentWeekday isEqualToString:@"週三"]||[currentWeekday isEqualToString:@"星期三"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
             theWeekName=[[NSString alloc] initWithFormat:@"Wednesday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期三"];
        }
       
    }
    else if ([currentWeekday isEqualToString:@"Thu"]||[currentWeekday isEqualToString:@"周四"]||[currentWeekday isEqualToString:@"週四"]||[currentWeekday isEqualToString:@"星期四"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
           theWeekName=[[NSString alloc] initWithFormat:@"Thursday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期四"];
        }
        
    }
    else if ([currentWeekday isEqualToString:@"Fri"]||[currentWeekday isEqualToString:@"周五"]||[currentWeekday isEqualToString:@"週五"]||[currentWeekday isEqualToString:@"星期五"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
           theWeekName=[[NSString alloc] initWithFormat:@"Firday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期五"];
        }
        
    }
    else if ([currentWeekday isEqualToString:@"Sat"]||[currentWeekday isEqualToString:@"周六"]||[currentWeekday isEqualToString:@"週六"]||[currentWeekday isEqualToString:@"星期六"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
           theWeekName=[[NSString alloc] initWithFormat:@"Saturday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期六"];
        }
        
    }
    else if ([currentWeekday isEqualToString:@"Sun"]||[currentWeekday isEqualToString:@"周日"]||[currentWeekday isEqualToString:@"週日"]||[currentWeekday isEqualToString:@"星期日"])
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
            theWeekName=[[NSString alloc] initWithFormat:@"Sunday"];
        }
        else
        {
            theWeekName=[[NSString alloc] initWithFormat:@"星期日"];
        }
       
    }

    
    NSString * timeStrRain111=[currentDateStr substringWithRange:NSMakeRange(8,2)];
    
    NSString * timeStrRain222=[currentDateStr substringWithRange:NSMakeRange(0,4)];
    NSString *timeStrRain333=[currentDateStr substringWithRange:NSMakeRange(5, 2)];
    NSString * allTheDay;
    if ([timeStrRain333 isEqualToString:@"01"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Jan %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年1月",timeStrRain222];
        }
    }
    else  if ([timeStrRain333 isEqualToString:@"02"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Feb %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年2月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"03"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Mar %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年3月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"04"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Apr %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年4月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"05"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"May %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年5月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"06"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Jun %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年6月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"07"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Jul %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年7月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"08"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Aug %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年8月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"09"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Sep %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年9月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"10"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Oct %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年10月",timeStrRain222];
        }
        
    }
    else  if ([timeStrRain333 isEqualToString:@"11"]) {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Nov %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年11月",timeStrRain222];
        }
        
    }
    else
    {
        if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
        {
            allTheDay=[[NSString alloc]initWithFormat:@"Dec %@",timeStrRain222];
        }
        else
        {
            allTheDay=[[NSString alloc]initWithFormat:@"%@年12月",timeStrRain222];
        }
        
    }
    //NSLog(@"<<<%@-%@-%@>>>",timeStrRain111,allTheDay,timeStrRain222);
    NSString *sumDay;
    if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
        sumDay =[[NSString alloc]initWithFormat:@"%@%d %@",theWeekName,[timeStrRain111 intValue],allTheDay];
    }
    else
    {
        
        sumDay=[[NSString alloc]initWithFormat:@" %@%d日 (%@)",allTheDay,[timeStrRain111 intValue],theWeekName];
    }
    labelDay.text=sumDay;
    
    [self VIP_Channel];
}

-(IBAction)ReminderList:(id)sender
{
    
    [addBUtton setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
   
    
    [self performSelector:@selector(delayReminderListThread) withObject:nil afterDelay:0.1];
}

-(void)delayReminderListThread{
    _theView.hidden=NO;
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in notifications )
    {
        
        @try {
            
            if( ([[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp1"] ||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp2"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp3"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp4"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw1"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw2"]))
            {
                //NSLog(@"========================");
                
            }
            else
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                //NSLog(@"========================");
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    }
    
    MR_ListViewController *homeView = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
    if ([self.dateDateStr length]>8) {
        homeView.dateDateStr=self.dateDateStr;
    }
    else
    {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        self.dateDateStr=currentDateStr;
        homeView.dateDateStr=self.dateDateStr;
    }
    
    [self.navigationController pushViewController:homeView animated:YES];
    // [self presentViewController:homeView animated:YES completion:nil];
    
    
    [addBUtton setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p3.png"] forState:UIControlStateNormal];
}
//-(IBAction)Back:(id)sender
//{
//   [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: 1] animated:YES];
//}



-(void)delayAddReminderThread{
    AddReminderViewController *homeView = [[AddReminderViewController alloc]initWithNibName:@"AddReminderViewController" bundle:nil];
    //NSLog(@"--------%@-----",self.serverTimeMedicationArray);
    if (dateDate) {
        homeView.dateDateStr=dateDate;
        //NSLog(@"++++++++++++++++%@+++++++++++++++++++++",dateDate);
        
    }
    else
    {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        dateDate=currentDateStr;
        homeView.dateDateStr=dateDate;
        
    }
    homeView.timeGlucoseMutableArray=[[NSMutableArray alloc]init];
    homeView.timeECGMutableArray=[[NSMutableArray alloc]init];
    homeView.timeBloodMutableArray=[[NSMutableArray alloc]init];
    homeView.timeWalkMutableArray=[[NSMutableArray alloc]init];
    homeView.timeBloodMutableArray  =self.timeBloodMutableArray ;
    homeView.timeECGMutableArray=  self.timeECGMutableArray ;
    homeView.timeGlucoseMutableArray =self.timeGlucoseMutableArray;
    homeView.timeWalkMutableArray=self.timeWalkMustableArray;
    homeView.idBloodMutbaleArray=[[NSMutableArray alloc]initWithArray:self.idBloodMutableArray];
    homeView.idECGMutableArray=[[NSMutableArray alloc]initWithArray:self.idECGMutableArray];
    homeView.idGlucoseMutableArray=[[NSMutableArray alloc]initWithArray:self.idGlucoseMutableArray];
    homeView.idWalkingMutableArray=[[NSMutableArray alloc]initWithArray:self.idWalkinfMustableArray];
    homeView.mediationidCOnt=self.medID.count;
    
    
    [self.navigationController pushViewController:homeView animated:YES];
    // [self presentViewController:homeView animated:YES completion:nil];
    
    
    [addEvent setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p3.png"] forState:UIControlStateNormal];
    
}

-(IBAction)AddReminder:(id)sender
{
    [addEvent setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    
    [self performSelector:@selector(delayAddReminderThread) withObject:nil afterDelay:0.1];
    
    
    
   
}
-(IBAction)buttonDay:(id)sender
{
    _poiuyt=1;
    
    [__buttonMonth setImage:__monthImageOff forState:UIControlStateNormal];
    [__buttonDay setImage:__dayImageON forState:UIControlStateNormal];
    
    
      [self VIP_Channel];
    monthViewHEnd.hidden=YES;
    scoloorView.hidden=YES;
    dayView.hidden=NO;
    _tableDayView.hidden=NO;
    addEvent.hidden=NO;
    addBUtton.hidden=YES;
    saveCalendarButton.hidden=YES;
}
-(IBAction)buttonMonth:(id)sender
{
    _poiuyt=0;
    [__buttonMonth setImage:__monthImageON forState:UIControlStateNormal];
    [__buttonDay setImage:__dayImageOff forState:UIControlStateNormal];
    monthViewHEnd.hidden=NO;
    scoloorView.hidden=NO;
    dayView.hidden=YES;
    _tableDayView.hidden=YES;
    addEvent.hidden=YES;
    addBUtton.hidden=NO;
    saveCalendarButton.hidden=NO;
}


-(void)getHistoryRecord
{
    
    NSMutableArray*arrau=[DBHelper getCalendarBPRecode];
    //NSLog(@"CALENDAR___BP===%@------>%lu",arrau,(unsigned long)arrau.count);
    NSMutableArray * bloodpressueMutableArray=[[NSMutableArray alloc]init];
    NSMutableArray * idBloodArray=[[NSMutableArray alloc]init];
    for (int i=0; i<arrau.count; i++) {
        NSDictionary * dicTion=[arrau objectAtIndex:i];
        NSString * timeBPStr=[dicTion objectForKey:@"time"];
        NSString * idBPstr=[dicTion objectForKey:@"id"];
        [idBloodArray addObject:idBPstr];
        [bloodpressueMutableArray addObject:timeBPStr];
    }
    self.timeBloodMutableArray =[[NSMutableArray alloc]initWithArray:bloodpressueMutableArray];
    self.idBloodMutableArray =[[NSMutableArray alloc]initWithArray:idBloodArray];
    
    NSMutableArray*arrau1=[DBHelper getCalendarECGRecode];
    //NSLog(@"CALENDAR___ECG===%@------>%lu",arrau1,(unsigned long)arrau1.count);
    NSMutableArray * ecgMutableArray=[[NSMutableArray alloc]init];
    NSMutableArray * idECGArray=[[NSMutableArray alloc]init];
    for (int i=0; i<arrau1.count; i++) {
        NSDictionary * dicTion=[arrau1 objectAtIndex:i];
        NSString *timeECGStR=[dicTion objectForKey:@"time"];
        NSString *idECGStr=[dicTion objectForKey:@"id"];
        [ecgMutableArray addObject:timeECGStR];
        [idECGArray addObject:idECGStr];
    }
    self.timeECGMutableArray =[[NSMutableArray alloc]initWithArray:ecgMutableArray];
    self.idECGMutableArray=[[NSMutableArray alloc]initWithArray:idECGArray];
    
    NSMutableArray*arrau2=[DBHelper getCalendarBGRecode];
 //   //NSLog(@"CALENDAR___BG===%@------>%lu",arrau2,(unsigned long)arrau2.count);
    NSMutableArray * glucoseMutableArray=[[NSMutableArray alloc]init];
    NSMutableArray * idGlucosArray=[[NSMutableArray alloc]init];
    for (int i=0; i<arrau2.count; i++) {
        NSDictionary * dicTion=[arrau2 objectAtIndex:i];
        NSString *timeBGSTR=[dicTion objectForKey:@"time"];
        NSString *idBGSTR=[dicTion objectForKey:@"id"];
        [glucoseMutableArray addObject:timeBGSTR];
        [idGlucosArray addObject:idBGSTR];
    }
    self.timeGlucoseMutableArray=[[NSMutableArray alloc]initWithArray:glucoseMutableArray];
    self.idGlucoseMutableArray =[[NSMutableArray alloc]initWithArray:idGlucosArray];
    
    
    
    
    
    
    NSMutableArray*arrau3=[DBHelper getCalendarOthersRecode];
  //  //NSLog(@"CALENDAR___OTHERS===%@------>%lu",arrau3,(unsigned long)arrau3.count);
  
    
    NSMutableArray *otherIDArray=[NSMutableArray new];
    NSMutableArray *otherStartTimeArray=[NSMutableArray new];
    NSMutableArray *otherEndTimeArray=[NSMutableArray new];
    NSMutableArray *otherTitleArray=[NSMutableArray new];
    NSMutableArray *otherNoteArray=[NSMutableArray new];
    NSMutableArray *otherDateDateArray=[NSMutableArray new];
    
    for (int i=0; i<arrau3.count; i++)
    {
        NSDictionary * dicTion=[arrau3 objectAtIndex:i];
        NSString * otheridStr=[dicTion objectForKey:@"id"];
        NSString * otherstartimeStr=[dicTion objectForKey:@"start_time"];
        NSString * othersendtimeStr=[dicTion objectForKey:@"end_time"];
        NSString * othertitleStr=[dicTion objectForKey:@"title"];
        NSString * otherNoteStr=[dicTion objectForKey:@"note"];
        NSString * otherDateStr=[dicTion objectForKey:@"date"];
        
        [otherIDArray addObject:otheridStr];
        [otherStartTimeArray addObject:otherstartimeStr];
        [otherEndTimeArray addObject:othersendtimeStr];
        [otherTitleArray addObject:othertitleStr];
        [otherNoteArray addObject:otherNoteStr];
        [otherDateDateArray addObject:otherDateStr];

        
    }
    self.titleAdhocArray =[[NSMutableArray alloc]initWithArray:otherTitleArray];
    self.startTimesArray =[[NSMutableArray alloc]initWithArray:otherStartTimeArray];
    self.endTimesArray   =[[NSMutableArray alloc]initWithArray:otherEndTimeArray];
    self.adHocID         =[[NSMutableArray alloc]initWithArray:otherIDArray];
    self.adHoNote        =[[NSMutableArray alloc]initWithArray:otherNoteArray];
    self.adDateDate      =[[NSMutableArray alloc]initWithArray:otherDateDateArray];
    
    
    
    NSMutableArray*arrau4=[DBHelper getCalendarWalkingRecode];
  //  //NSLog(@"CALENDAR___WALKING===%@------>%lu",arrau4,(unsigned long)arrau4.count);
    
     NSMutableArray * timeArrayWalking=[NSMutableArray new];
    NSMutableArray * idArrayWalking=[[NSMutableArray alloc]init];
    for (int i=0; i<arrau4.count; i++)
    {
           NSDictionary * dicTion=[arrau4 objectAtIndex:i];
        NSString * walkingStr=[dicTion objectForKey:@"time"];
        [timeArrayWalking addObject:walkingStr];
        NSString *idWalkingSTR=[dicTion objectForKey:@"id"];
        [idArrayWalking addObject:idWalkingSTR];
        self.walkStartDate=[dicTion objectForKey:@"start_date"];
        self.walkEndDate=[dicTion objectForKey:@"end_date"];
    }
    self.timeWalkMustableArray=[[NSMutableArray alloc]initWithArray:timeArrayWalking];
    self.idWalkinfMustableArray=[[NSMutableArray alloc]initWithArray:idArrayWalking];
    NSMutableArray*arrau5=[DBHelper getCalendarMedicationRecode];
    ////NSLog(@"CALENDAR___MEDICATION===%@------>%lu",arrau5,(unsigned long)arrau5.count);
    
    NSMutableArray * medidArray=[NSMutableArray new];
    NSMutableArray *titleArrayMedication=[NSMutableArray new];
    NSMutableArray *dosageArray=[NSMutableArray new];
    NSMutableArray *reminderArrayMedication=[NSMutableArray new];
    NSMutableArray *mealArray=[NSMutableArray new];
    NSMutableArray *reminderidArray=[NSMutableArray new];
    NSMutableArray *takenArray=[NSMutableArray new];
    NSMutableArray *serverTimeArray=[NSMutableArray new];
    NSMutableArray *imageArray=[NSMutableArray new];
    for (int i=0; i<arrau5.count; i++)
    {
        NSDictionary * dicTion=[arrau5 objectAtIndex:i];
        NSString * titleMedicationStr=[dicTion objectForKey:@"title"];
        NSString * timesMEdicationStr=[dicTion objectForKey:@"reminder_time"];
        NSString *meidStr=[dicTion objectForKey:@"meid"];
        NSString *dosageMedicationStr=[dicTion objectForKey:@"dosage"];
        NSString *mealMedicationStr=[dicTion objectForKey:@"meal"];
        NSString *reminderIDSTR=[dicTion objectForKey:@"reminder_id"];
        NSString *takenstr=[dicTion objectForKey:@"reminder_ticken"];
        NSString *serverTimeStr=[dicTion objectForKey:@"servertime"];
        NSString *imageStr=[dicTion objectForKey:@"reminder_image_string"];
        [serverTimeArray addObject:serverTimeStr];
        
        [medidArray addObject:meidStr];
        [titleArrayMedication addObject:titleMedicationStr];
        [reminderArrayMedication addObject:timesMEdicationStr];
        [dosageArray addObject:dosageMedicationStr];
        [mealArray addObject:mealMedicationStr];
        [reminderidArray addObject:reminderIDSTR];
        [takenArray addObject:takenstr];
        [imageArray addObject:imageStr];
    }
  //  //NSLog(@"reminder_ticken====%@",takenArray);
    
    self.titleMedicationArray=[[NSMutableArray alloc]initWithArray:titleArrayMedication];
    self.timesMedicationArray=[[NSMutableArray alloc]initWithArray:reminderArrayMedication];
    self.medID=[[NSMutableArray alloc]initWithArray:medidArray];
    self.dosageMedicationArray=[[NSMutableArray alloc]initWithArray:dosageArray];
    self.mealMedicationArray=[[NSMutableArray alloc]initWithArray:mealArray];
    self.reminderIDMedicationArray=[[NSMutableArray alloc]initWithArray:reminderidArray];
    self.tikenMedicationArray=[[NSMutableArray alloc]initWithArray:takenArray];
    self.serverTimeMedicationArray=[[NSMutableArray alloc]initWithArray:serverTimeArray];
    self.imageMedicationArray=[[NSMutableArray alloc]initWithArray:imageArray];
      NSMutableArray *  _timesArray =[[NSMutableArray alloc]init];
    for (int hh=0; hh<self.timesMedicationArray.count; hh++)
    {
        float ff=[[self.timesMedicationArray objectAtIndex:hh] lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
        //NSLog(@"+++++++%f",ff);
        
        
        
        if (ff>1&&ff<7) {
            //
            NSString *string = [[self.timesMedicationArray objectAtIndex:hh] substringWithRange:NSMakeRange(0,5)];
            [_timesArray addObject:string];
            
        }
        else if (ff>=7.0&&ff<=13)
        {
            for (int temmm=0; temmm<2; temmm++) {
                NSString *string = [[self.timesMedicationArray objectAtIndex:hh] substringWithRange:NSMakeRange(0+(temmm*6),5)];
                [_timesArray addObject:string];
                
            }
            
        }
        else if (ff>=13.0&&ff<=19)
        {
            for (int temmm=0; temmm<3; temmm++)
            {
                NSString *string = [[self.timesMedicationArray objectAtIndex:hh] substringWithRange:NSMakeRange(0+(temmm*6),5)];
                [_timesArray addObject:string];
                
            }
        }
        else if (ff>=19.0&&ff<=25)
        {
            for (int temmm=0; temmm<4; temmm++) {
                NSString *string = [[self.timesMedicationArray objectAtIndex:hh] substringWithRange:NSMakeRange(0+(temmm*6),5)];
                [_timesArray addObject:string];
                
            }
            
        }
        else if (ff>=25.0&&ff<=31)
        {
            for (int temmm=0; temmm<5; temmm++) {
                NSString *string = [[self.timesMedicationArray objectAtIndex:hh] substringWithRange:NSMakeRange(0+(temmm*6),5)];
                [_timesArray addObject:string];
                
                
            }
            
            
        }
        else if (ff>=31.0)
        {
            for (int temmm=0; temmm<6; temmm++)
            {
                NSString *string = [[self.timesMedicationArray objectAtIndex:hh] substringWithRange:NSMakeRange(0+(temmm*6),5)];
                //NSLog(@"__%@--",string);
                [_timesArray addObject:string];
            }
        }
        else
        {
            [_timesArray addObject:@" "];
        }
        
    }
      self.everyONEmedicationTimeArray=[[NSMutableArray alloc]initWithArray:_timesArray];
    
    
    NSMutableArray*arrau6=[DBHelper getCalendarMedicationRecode_Notes];
    
    
    NSMutableArray *note_medicationNote=[NSMutableArray new];
    
    for (int i=0; i<arrau6.count; i++)
    {
        
        NSDictionary * dicTion=[arrau6 objectAtIndex:i];
        
        NSString *note=[dicTion objectForKey:@"note"];
        
        [note_medicationNote addObject:note];
        
        
        
    }
    NSLog(@"noteMedicationArray=%@",self.noteMedicationArray);
    self.noteMedicationArray=[[NSMutableArray alloc]initWithArray:note_medicationNote];
    
    
    
    
    
}
-(NSString*)uelEncode:(NSString*)uriString
{
    NSString *outPutStr=[(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)uriString, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#^[]{}", kCFStringEncodingUTF8))copy];
    return outPutStr;
}
-(void)thescrollViewHeight
{
    
    //NSLog(@"--------------------Look For Me--------------------------");
    int scollowINT=0;
    if (((self.timeECGMutableArray.count+self.timeBloodMutableArray.count+self.timeGlucoseMutableArray.count>0))&&((self.timeECGMutableArray.count+self.timeBloodMutableArray.count+self.timeGlucoseMutableArray.count<6))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
    {
    
        scollowINT+=80;
    }
    else if(((self.timeECGMutableArray.count+self.timeBloodMutableArray.count+self.timeGlucoseMutableArray.count>=6))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
    {
  
        scollowINT+=90;
    }
    else
    {
      
        scollowINT+=0;
    }

    if (((self.timesMedicationArray.count>0))&&((self.timesMedicationArray.count<=6))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
    {

        scollowINT+=80;
    }
    else if (((self.timesMedicationArray.count>6))&&([timeStrRaindateDateSum111 intValue]>=[currentDateStr11100 intValue]))
    {
 
         scollowINT+=self.timesMedicationArray.count/5*20+70;
    }
    else
    {

        scollowINT+=0;
    }

    if([todyAdhocTime length]>3)
    {
        scollowINT+=80;
        
    }
    else
    {
       
        scollowINT+=0;
    }

    if((self.timeWalkMustableArray.count>0)&&(([timeStrRaindateDateSum111 intValue]>=[timeStrRainStratDateSum111 intValue])&&([timeStrRaindateDateSum111 intValue]<=[timeStrRainENDDateSum111 intValue])))
    {
  
        scollowINT+=80;
    }
    else
    {
  
        scollowINT+=0;

    }
    if (!iPad)
    {
        scoloorView.contentSize=CGSizeMake(320, scollowINT+21+330);//设置总画布的大小
        //NSLog(@"----------%d",scollowINT);
    }
    else
    {
       scoloorView.contentSize=CGSizeMake(320, scollowINT+21+195);//设置总画布的大小
          //NSLog(@"----------%d",scollowINT);
    }
}
-(void)backtoDairy
{
    [__buttonMonth setImage:__monthImageON forState:UIControlStateNormal];
    [__buttonDay setImage:__dayImageOff forState:UIControlStateNormal];
}





-(void)VIP_Channel
{
    
    
    NSString *timeStrRaindateDate1=[dateDate substringWithRange:NSMakeRange(0, 4)];
    NSString *timeStrRaindateDate2=[dateDate substringWithRange:NSMakeRange(5, 2)];
    NSString *timeStrRaindateDate3=[dateDate substringWithRange:NSMakeRange(8, 2)];
    NSString *timeStrRaindateDateSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRaindateDate1,timeStrRaindateDate2,timeStrRaindateDate3];
    
    NSString *timeStrRainStratDateSum;
    NSString *timeStrRainENDDateSum;
    
    if([self.walkStartDate length]>6)
    {
    NSString *timeStrRainStratDate1=[self.walkStartDate substringWithRange:NSMakeRange(0, 4)];
    NSString *timeStrRainStratDate2=[self.walkStartDate substringWithRange:NSMakeRange(5, 2)];
    NSString *timeStrRainStratDate3=[self.walkStartDate substringWithRange:NSMakeRange(8, 2)];
  timeStrRainStratDateSum =[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainStratDate1,timeStrRainStratDate2,timeStrRainStratDate3];
    }
    else
    {
         timeStrRainStratDateSum=@"0";
    }
     if([self.walkEndDate length]>6)
     {
    NSString *timeStrRainENDDate1=[self.walkEndDate substringWithRange:NSMakeRange(0, 4)];
    NSString *timeStrRainENDDate2=[self.walkEndDate substringWithRange:NSMakeRange(5, 2)];
    NSString *timeStrRainENDDate3=[self.walkEndDate substringWithRange:NSMakeRange(8, 2)];
  timeStrRainENDDateSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainENDDate1,timeStrRainENDDate2,timeStrRainENDDate3];
     }
    else
    {
        timeStrRainENDDateSum=@"0";
    }
    
    
    NSDateFormatter* dateFormat000 = [[NSDateFormatter alloc] init];
    [dateFormat000 setDateFormat:@"yyyy-MM-dd"];
   // NSString *currentDateStr = [dateFormat000 stringFromDate:[NSDate date]];
    //NSLog(@"%@",currentDateStr);
    
    NSDateFormatter* dateFormat111 = [[NSDateFormatter alloc] init];
    [dateFormat111 setDateFormat:@"yyyyMMdd"];
    NSString *currentDateStr111 = [dateFormat111 stringFromDate:[NSDate date]];
    //NSLog(@"%@",currentDateStr111);
    
    
    
    
    _cellView00 =[[UIView alloc]init];
    
    _cellView01 =[[UIView alloc]init];
    _cellView02 =[[UIView alloc]init];
    _cellView03 =[[UIView alloc]init];
    _cellView04 =[[UIView alloc]init];
    _cellView05 =[[UIView alloc]init];
    _cellView06 =[[UIView alloc]init];
    _cellView07 =[[UIView alloc]init];
    _cellView08 =[[UIView alloc]init];
    _cellView09 =[[UIView alloc]init];
    
    _cellView10 =[[UIView alloc]init];
    _cellView11 =[[UIView alloc]init];
    _cellView12 =[[UIView alloc]init];
    _cellView13 =[[UIView alloc]init];
    _cellView14 =[[UIView alloc]init];
    _cellView15 =[[UIView alloc]init];
    _cellView16 =[[UIView alloc]init];
    _cellView17 =[[UIView alloc]init];
    _cellView18 =[[UIView alloc]init];
    _cellView19 =[[UIView alloc]init];
    
    _cellView20 =[[UIView alloc]init];
    _cellView21 =[[UIView alloc]init];
    _cellView22 =[[UIView alloc]init];
    _cellView23 =[[UIView alloc]init];
    
    for (int joker=0; joker<_timeArray.count; joker++)
    {
        
        buttonHeiger00=0;
        if ([timeStrRaindateDateSum intValue]>=[currentDateStr111 intValue]) {
            
            
            for (int i=0; i<[timeBloodArray count]; i++)
            {
                if ([[timeBloodArray objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
                {
                    
                    UIButton *_button=[UIButton buttonWithType:UIButtonTypeSystem];
                  

                //    _button .backgroundColor=[UIColor colorWithRed:250/255.0 green:150/255.0 blue:150/255.0 alpha:1];

                    _button.tag=10000+i;
                    NSString * str=[[NSString alloc]initWithFormat:@" %@",[Utility getStringByKey:@"Blood Pressure"]];
                    [_button setTitle:str forState:UIControlStateNormal];
                    _button.titleLabel.textAlignment=NSTextAlignmentLeft;
                    _button.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
                    _button.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
                        //   [_button setTitleColor:[UIColor colorWithRed:240/255.0 green:50/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
                    _button.backgroundColor=[UIColor colorWithRed:186/255.0 green:237/255.0 blue:232/255.0 alpha:1];
                    [ _button setTitleColor:[UIColor colorWithRed:70/255.0 green:100/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
                    _button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
                    [_button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    _button.frame=CGRectMake(75,4+ buttonHeiger00*30, 255-30, 30);
                    ////NSLog(@"buttonHEIger====%d",buttonHeiger00);
                    [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                    buttonHeiger00=buttonHeiger00+1;
                    
                    switch (joker) {
                        case 0:
                            [_cellView00 addSubview:_button];
                            _cellView00.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView00.frame.size.height);
                            break;
                        case 1:
                            [_cellView01 addSubview:_button];
                            _cellView01.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView01.frame.size.height);
                            break;
                        case 2:
                            [_cellView02 addSubview:_button];
                            _cellView02.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView02.frame.size.height);
                            break;
                        case 3:
                            [_cellView03 addSubview:_button];
                            _cellView03.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView03.frame.size.height);
                            break;
                        case 4:
                            [_cellView04 addSubview:_button];
                            _cellView04.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView04.frame.size.height);
                            break;
                        case 5:
                            [_cellView05 addSubview:_button];
                            _cellView05.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView05.frame.size.height);
                            break;
                        case 6:
                            [_cellView06 addSubview:_button];
                            _cellView06.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView06.frame.size.height);
                            break;
                        case 7:
                            [_cellView07 addSubview:_button];
                            _cellView07.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView07.frame.size.height)
                            ;
                            break;
                        case 8:
                            [_cellView08 addSubview:_button];
                            _cellView08.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView08.frame.size.height);
                            break;
                        case 9:
                            [_cellView09 addSubview:_button];
                            _cellView09.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView09.frame.size.height);
                            break;
                        case 10:
                            [_cellView10 addSubview:_button];
                            _cellView10.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView10.frame.size.height);
                            break;
                        case 11:
                            [_cellView11 addSubview:_button];
                            _cellView11.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView11.frame.size.height);
                            break;
                        case 12:
                            [_cellView12 addSubview:_button];
                            _cellView12.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView12.frame.size.height);
                            break;
                        case 13:
                            [_cellView13 addSubview:_button];
                            _cellView13.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView13.frame.size.height);
                            break;
                        case 14:
                            [_cellView14 addSubview:_button];
                            _cellView14.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView14.frame.size.height);
                            break;
                        case 15:
                            [_cellView15 addSubview:_button];
                            _cellView15.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView15.frame.size.height);
                            break;
                        case 16:
                            [_cellView16 addSubview:_button];
                            _cellView16.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView16.frame.size.height);
                            break;
                        case 17:
                            [_cellView17 addSubview:_button];
                            _cellView17.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView17.frame.size.height);
                            break;
                        case 18:
                            [_cellView18 addSubview:_button];
                            _cellView18.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView18.frame.size.height);
                            break;
                        case 19:
                            [_cellView19 addSubview:_button];
                            _cellView19.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView19.frame.size.height);
                            break;
                        case 20:
                            [_cellView20 addSubview:_button];
                            _cellView20.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView20.frame.size.height);
                            break;
                        case 21:
                            [_cellView21 addSubview:_button];
                            _cellView21.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView21.frame.size.height);
                            break;
                        case 22:
                            [_cellView22 addSubview:_button];
                            _cellView22.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView22.frame.size.height);
                            break;
                        case 23:
                            [_cellView23 addSubview:_button];
                            _cellView23.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView23.frame.size.height);
                            break;
                        default:
                            break;
                    }
                    
                    
                }
            }
        }
        if ([timeStrRaindateDateSum intValue]>=[currentDateStr111 intValue]) {
            
            
            for (int i=0; i<[timeECGArray count]; i++)
            {
                
                if ([[timeECGArray objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
                {
                    
                    UIButton *_button=[UIButton buttonWithType:UIButtonTypeSystem];
                    {
                        
                        _button.frame=CGRectMake(75,4+ buttonHeiger00*30, 255-30,30);
                        ////NSLog(@"buttonHEIger====%d",buttonHeiger00);
                        buttonHeiger00=buttonHeiger00+1;
                    }
                    
                    _button.tag=20000+i;
                  //  _button .backgroundColor=[UIColor colorWithRed:250/255.0 green:150/255.0 blue:150/255.0 alpha:1];
                    
                    NSString *str=[[NSString alloc] initWithFormat:@" %@",[Utility getStringByKey:@"ECG"]];
                     [_button setTitle:str forState:UIControlStateNormal];
                     _button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
                    
                    _button.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
                 //   [_button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    _button.backgroundColor=[UIColor colorWithRed:186/255.0 green:237/255.0 blue:232/255.0 alpha:1];
                    [ _button setTitleColor:[UIColor colorWithRed:70/255.0 green:100/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
                           [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                    _button.titleLabel.textAlignment=NSTextAlignmentLeft;
                                    [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                       _button.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
                    [_button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    switch (joker) {
                        case 0:
                            [_cellView00 addSubview:_button];
                            _cellView00.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView00.frame.size.height);
                            break;
                        case 1:
                            [_cellView01 addSubview:_button];
                            _cellView01.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView01.frame.size.height);
                            break;
                        case 2:
                            [_cellView02 addSubview:_button];
                            _cellView02.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView02.frame.size.height);
                            break;
                        case 3:
                            [_cellView03 addSubview:_button];
                            _cellView03.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView03.frame.size.height);
                            break;
                        case 4:
                            [_cellView04 addSubview:_button];
                            _cellView04.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView04.frame.size.height);
                            break;
                        case 5:
                            [_cellView05 addSubview:_button];
                            _cellView05.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView05.frame.size.height);
                            break;
                        case 6:
                            [_cellView06 addSubview:_button];
                            _cellView06.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView06.frame.size.height);
                            break;
                        case 7:
                            [_cellView07 addSubview:_button];
                            _cellView07.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView07.frame.size.height)
                            ;
                            break;
                        case 8:
                            [_cellView08 addSubview:_button];
                            _cellView08.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView08.frame.size.height);
                            break;
                        case 9:
                            [_cellView09 addSubview:_button];
                            _cellView09.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView09.frame.size.height);
                            break;
                        case 10:
                            [_cellView10 addSubview:_button];
                            _cellView10.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView10.frame.size.height);
                            break;
                        case 11:
                            [_cellView11 addSubview:_button];
                            _cellView11.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView11.frame.size.height);
                            break;
                        case 12:
                            [_cellView12 addSubview:_button];
                            _cellView12.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView12.frame.size.height);
                            break;
                        case 13:
                            [_cellView13 addSubview:_button];
                            _cellView13.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView13.frame.size.height);
                            break;
                        case 14:
                            [_cellView14 addSubview:_button];
                            _cellView14.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView14.frame.size.height);
                            break;
                        case 15:
                            [_cellView15 addSubview:_button];
                            _cellView15.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView15.frame.size.height);
                            break;
                        case 16:
                            [_cellView16 addSubview:_button];
                            _cellView16.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView16.frame.size.height);
                            break;
                        case 17:
                            [_cellView17 addSubview:_button];
                            _cellView17.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView17.frame.size.height);
                            break;
                        case 18:
                            [_cellView18 addSubview:_button];
                            _cellView18.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView18.frame.size.height);
                            break;
                        case 19:
                            [_cellView19 addSubview:_button];
                            _cellView19.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView19.frame.size.height);
                            break;
                        case 20:
                            [_cellView20 addSubview:_button];
                            _cellView20.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView20.frame.size.height);
                            break;
                        case 21:
                            [_cellView21 addSubview:_button];
                            _cellView21.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView21.frame.size.height);
                            break;
                        case 22:
                            [_cellView22 addSubview:_button];
                            _cellView22.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView22.frame.size.height);
                            break;
                        case 23:
                            [_cellView23 addSubview:_button];
                            _cellView23.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView23.frame.size.height);
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    ////NSLog(@"////NSLog==%d",buttonHeiger00);
                }
            }
            
        }
    
        if ([timeStrRaindateDateSum intValue]>=[currentDateStr111 intValue]) {
            
            
            for (int i =0; i< [timeGloodArray count]; i++)
                
            {
                if ([[timeGloodArray objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
                {
                    UIButton *_button=[UIButton buttonWithType:UIButtonTypeSystem];
                    
               
                 
                   
                    
                    _button.tag=30000+i;
                //    _button .backgroundColor=[UIColor colorWithRed:250/255.0 green:150/255.0 blue:150/255.0 alpha:1];
                    
                  //  [_button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
                    
                    
                    _button.backgroundColor=[UIColor colorWithRed:186/255.0 green:237/255.0 blue:232/255.0 alpha:1];
                    [ _button setTitleColor:[UIColor colorWithRed:70/255.0 green:100/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
                    NSString *str=[[NSString alloc]initWithFormat:@" %@",[Utility getStringByKey:@"Blood Glucose"]];
                    [_button setTitle:str forState:UIControlStateNormal];
                    _button.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
                           [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                       _button.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
                    _button.titleLabel.textAlignment=NSTextAlignmentLeft;
                    [_button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
                     _button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
                                        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    _button.frame=CGRectMake(75,4+ buttonHeiger00*30, 255-30, 30);
                    ////NSLog(@"buttonHEIger====%d",buttonHeiger00);
                    buttonHeiger00=buttonHeiger00+1;
                    switch (joker) {
                        case 0:
                            [_cellView00 addSubview:_button];
                            _cellView00.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView00.frame.size.height);
                            break;
                        case 1:
                            [_cellView01 addSubview:_button];
                            _cellView01.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView01.frame.size.height);
                            break;
                        case 2:
                            [_cellView02 addSubview:_button];
                            _cellView02.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView02.frame.size.height);
                            break;
                        case 3:
                            [_cellView03 addSubview:_button];
                            _cellView03.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView03.frame.size.height);
                            break;
                        case 4:
                            [_cellView04 addSubview:_button];
                            _cellView04.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView04.frame.size.height);
                            break;
                        case 5:
                            [_cellView05 addSubview:_button];
                            _cellView05.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView05.frame.size.height);
                            break;
                        case 6:
                            [_cellView06 addSubview:_button];
                            _cellView06.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView06.frame.size.height);
                            break;
                        case 7:
                            [_cellView07 addSubview:_button];
                            _cellView07.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView07.frame.size.height)
                            ;
                            break;
                        case 8:
                            [_cellView08 addSubview:_button];
                            _cellView08.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView08.frame.size.height);
                            break;
                        case 9:
                            [_cellView09 addSubview:_button];
                            _cellView09.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView09.frame.size.height);
                            break;
                        case 10:
                            [_cellView10 addSubview:_button];
                            _cellView10.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView10.frame.size.height);
                            break;
                        case 11:
                            [_cellView11 addSubview:_button];
                            _cellView11.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView11.frame.size.height);
                            break;
                        case 12:
                            [_cellView12 addSubview:_button];
                            _cellView12.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView12.frame.size.height);
                            break;
                        case 13:
                            [_cellView13 addSubview:_button];
                            _cellView13.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView13.frame.size.height);
                            break;
                        case 14:
                            [_cellView14 addSubview:_button];
                            _cellView14.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView14.frame.size.height);
                            break;
                        case 15:
                            [_cellView15 addSubview:_button];
                            _cellView15.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView15.frame.size.height);
                            break;
                        case 16:
                            [_cellView16 addSubview:_button];
                            _cellView16.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView16.frame.size.height);
                            break;
                        case 17:
                            [_cellView17 addSubview:_button];
                            _cellView17.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView17.frame.size.height);
                            break;
                        case 18:
                            [_cellView18 addSubview:_button];
                            _cellView18.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView18.frame.size.height);
                            break;
                        case 19:
                            [_cellView19 addSubview:_button];
                            _cellView19.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView19.frame.size.height);
                            break;
                        case 20:
                            [_cellView20 addSubview:_button];
                            _cellView20.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView20.frame.size.height);
                            break;
                        case 21:
                            [_cellView21 addSubview:_button];
                            _cellView21.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView21.frame.size.height);
                            break;
                        case 22:
                            [_cellView22 addSubview:_button];
                            _cellView22.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView22.frame.size.height);
                            break;
                        case 23:
                            [_cellView23 addSubview:_button];
                            _cellView23.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView23.frame.size.height);
                            break;
                        default:
                            break;
                    }
                }
                
            }
        }
        if ([timeStrRaindateDateSum intValue]>=[currentDateStr111 intValue]) {
            
            
            for (int i=0; i<[timeMationArray count]; i++)
            {
                NSMutableArray *obTimeMation=[timeMationArray objectAtIndex:i];
                ////NSLog(@"obTImeMation ==%@",obTimeMation);
                NSMutableArray*theTimeMationOB=[theAllTimeMadicon objectAtIndex:i];
                NSMutableArray*theTakenMationOB=[theAllTakenMadicon objectAtIndex:i];
                
//                NSMutableArray *theTureMationTime=[self.timesMedicationArray objectAtIndex:i];
                for (int j=0; j<[obTimeMation count]; j++)
                {
                    if ([[obTimeMation objectAtIndex:j]isEqualToString:[_timeArray objectAtIndex:joker]])
                    {
                        ////NSLog(@"the TakenTIme===%@",[theTimeMationOB objectAtIndex:j]);
                        ////NSLog(@"The TakenTimeTaken==%@",[theTakenMationOB objectAtIndex:j]);
                        
                        NSString *rainTakenTimeSTrhours=[[theTimeMationOB objectAtIndex:j]substringWithRange:NSMakeRange(0, 2)];
                   
                              NSString *rainTakenTimeSTrmints=[[theTimeMationOB objectAtIndex:j]substringWithRange:NSMakeRange(3, 2)];
                        NSString *subAllTakenTimeStr=[[NSString alloc]initWithFormat:@"%@%@",rainTakenTimeSTrhours,rainTakenTimeSTrmints];
                        
                        UILabel * _theTakeningYES=[[UILabel alloc]initWithFrame:CGRectMake(225-30, 0, 30, 30)];
                        _theTakeningYES.backgroundColor=[UIColor clearColor];
                        
                        
                        UIButton *_button =[UIButton buttonWithType:UIButtonTypeSystem];
                        
                        
                        
                        _button.tag=40000+(7*i)+j;
                        _button.backgroundColor=[UIColor colorWithRed:186/255.0 green:237/255.0 blue:232/255.0 alpha:1];
                        NSString *str=[[NSString alloc]initWithFormat:@" %@",[self.titleMedicationArray objectAtIndex:i]];
                        [_button setTitle:str forState:UIControlStateNormal];
                        _button.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
                        [ _button setTitleColor:[UIColor colorWithRed:70/255.0 green:100/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
                        _button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
                        [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                        _button.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
                        
                        _button.frame=CGRectMake(75,4+ buttonHeiger00*30, 255-30, 30);
                        ////NSLog(@"buttonHEIger====%d",buttonHeiger00);
                        buttonHeiger00=buttonHeiger00+1;
                        [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                        _button.titleLabel.textAlignment=NSTextAlignmentLeft;
                        
                        if (dateDate)
                        {
                   
                            ////NSLog(@"++++++++++++++++%@+++++++++++++++++++++",dateDate);
                            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
                            [dateFormat setDateFormat:@"yyyy-MM-dd"];
                            NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
                            if ([dateDate isEqualToString:currentDateStr])
                            {
                                NSDateFormatter* timeFormat = [[NSDateFormatter alloc] init];
                                [timeFormat setDateFormat:@"HHmm"];
                                NSString *currentTimeStr = [timeFormat stringFromDate:[NSDate date]];
                                
                                ////NSLog(@"%@",currentTimeStr);
                                if ([subAllTakenTimeStr intValue]<[currentTimeStr intValue]&&[[theTakenMationOB objectAtIndex:j]isEqualToString:@"N"])
                                {
                                    _theTakeningYES.text=@"( ! )";
                                    _theTakeningYES.textColor=[UIColor redColor];
                                    _button.backgroundColor=[UIColor colorWithRed:241/255.0 green:192/255.0 blue:192/255.0 alpha:1];
                                    [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                                }
                                
                            }
                        }
                        else
                        {
                            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
                            [dateFormat setDateFormat:@"yyyy-MM-dd"];
                            NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
                            dateDate=currentDateStr;
                            NSDateFormatter* timeFormat = [[NSDateFormatter alloc] init];
                            [timeFormat setDateFormat:@"HHmm"];
                            NSString *currentTimeStr = [timeFormat stringFromDate:[NSDate date]];

                            
                            ////NSLog(@"%@",currentTimeStr);
                            if ([subAllTakenTimeStr intValue]<[currentTimeStr intValue]&&[[theTakenMationOB objectAtIndex:j]isEqualToString:@"N"])
                            {
                                _theTakeningYES.text=@"( ! )";
                                _theTakeningYES.textColor=[UIColor redColor];
                                
                                _button.backgroundColor=[UIColor colorWithRed:241/255.0 green:192/255.0 blue:192/255.0 alpha:1];
                                [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                            }
                            

                            
                            
                           
                            
                        }
                        
                        
                        
                        
//                        NSString * theTakenTime=[theTureMationTime objectAtIndex:j];
//                        
//                        ////NSLog(@"%@ ------  ",theTakenTime);
//                        
                        
                        
                        
                        
                    
                        [_button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
                        [_button addSubview:_theTakeningYES];
                        
                        switch (joker)
                        {
                            case 0:
                                [_cellView00 addSubview:_button];
                                _cellView00.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView00.frame.size.height);
                                break;
                            case 1:
                                [_cellView01 addSubview:_button];
                                _cellView01.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView01.frame.size.height);
                                break;
                            case 2:
                                [_cellView02 addSubview:_button];
                                _cellView02.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView02.frame.size.height);
                                break;
                            case 3:
                                [_cellView03 addSubview:_button];
                                _cellView03.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView03.frame.size.height);
                                break;
                            case 4:
                                [_cellView04 addSubview:_button];
                                _cellView04.frame=CGRectMake(0, 0,320,_button.frame.size.height+_cellView04.frame.size.height);
                                break;
                            case 5:
                                [_cellView05 addSubview:_button];
                                _cellView05.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView05.frame.size.height);
                                break;
                            case 6:
                                [_cellView06 addSubview:_button];
                                _cellView06.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView06.frame.size.height);
                                break;
                            case 7:
                                [_cellView07 addSubview:_button];
                                _cellView07.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView07.frame.size.height)
                                ;
                                break;
                            case 8:
                                [_cellView08 addSubview:_button];
                                _cellView08.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView08.frame.size.height);
                                break;
                            case 9:
                                [_cellView09 addSubview:_button];
                                _cellView09.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView09.frame.size.height);
                                break;
                            case 10:
                                [_cellView10 addSubview:_button];
                                _cellView10.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView10.frame.size.height);
                                break;
                            case 11:
                                [_cellView11 addSubview:_button];
                                _cellView11.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView11.frame.size.height);
                                break;
                            case 12:
                                [_cellView12 addSubview:_button];
                                _cellView12.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView12.frame.size.height);
                                break;
                            case 13:
                                [_cellView13 addSubview:_button];
                                _cellView13.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView13.frame.size.height);
                                break;
                            case 14:
                                [_cellView14 addSubview:_button];
                                _cellView14.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView14.frame.size.height);
                                break;
                            case 15:
                                [_cellView15 addSubview:_button];
                                _cellView15.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView15.frame.size.height);
                                break;
                            case 16:
                                [_cellView16 addSubview:_button];
                                _cellView16.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView16.frame.size.height);
                                break;
                            case 17:
                                [_cellView17 addSubview:_button];
                                _cellView17.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView17.frame.size.height);
                                break;
                            case 18:
                                [_cellView18 addSubview:_button];
                                _cellView18.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView18.frame.size.height);
                                break;
                            case 19:
                                [_cellView19 addSubview:_button];
                                _cellView19.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView19.frame.size.height);
                                break;
                            case 20:
                                [_cellView20 addSubview:_button];
                                _cellView20.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView20.frame.size.height);
                                break;
                            case 21:
                                [_cellView21 addSubview:_button];
                                _cellView21.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView21.frame.size.height);
                                break;
                            case 22:
                                [_cellView22 addSubview:_button];
                                _cellView22.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView22.frame.size.height);
                                break;
                            case 23:
                                [_cellView23 addSubview:_button];
                                _cellView23.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView23.frame.size.height);
                                break;
                            default:
                                break;
                        }
                        
                        
                    }
                }
            }
        }
        
        
        for (int i =0; i< [self.adDateDate count]; i++)
                
            {
             //        ////NSLog(@"<MMMMMMMMMMMMMMMMMMMMMMMMMMMVVVVVVVVPPPPPPP");
          //      ////NSLog(@"%@______________555",dateDate);
           //     ////NSLog(@"%@______________111",[self.adDateDate objectAtIndex:i]);
                if ( [dateDate isEqualToString:[self.adDateDate objectAtIndex:i ]])
                    
                {
                    ////NSLog(@"<MMMMMMMMMMMMMMMMMMMMMMMMMMMVVVVVVVVPPPPPPP");
  
                    if ([[timeStartTime objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
                    {
                        UIButton *_button=[UIButton buttonWithType:UIButtonTypeSystem];
                        
                        {
                            _button.frame=CGRectMake(75,4+ buttonHeiger00*30, 255-30, 30);
                            ////NSLog(@"buttonHEIger====%d",buttonHeiger00);
                            buttonHeiger00=buttonHeiger00+1;
                        }
                        
                        _button.tag=50000+i;
                   //     _button .backgroundColor=[UIColor colorWithRed:200/255.0 green:250/255.0 blue:160/255.0 alpha:1];
                        
                     //   [_button setTitleColor:[UIColor colorWithRed:60/255.0 green:220/255.0 blue:60/255.0 alpha:1] forState:UIControlStateNormal];
                        _button.backgroundColor=[UIColor colorWithRed:186/255.0 green:237/255.0 blue:232/255.0 alpha:1];
                        [ _button setTitleColor:[UIColor colorWithRed:70/255.0 green:100/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
                        NSString *str=[[NSString alloc]initWithFormat:@" %@",[Utility getStringByKey:@"Others"]];
                        [_button setTitle:str forState:UIControlStateNormal];
                        _button.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Romaqn" size:18];
                               [_button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                                            [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                         _button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
                        _button.titleLabel.textAlignment=NSTextAlignmentLeft;
                           _button.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
                        [_button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
                        switch (joker) {
                            case 0:
                                [_cellView00 addSubview:_button];
                                _cellView00.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView00.frame.size.height);
                                break;
                            case 1:
                                [_cellView01 addSubview:_button];
                                _cellView01.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView01.frame.size.height);
                                break;
                            case 2:
                                [_cellView02 addSubview:_button];
                                _cellView02.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView02.frame.size.height);
                                break;
                            case 3:
                                [_cellView03 addSubview:_button];
                                _cellView03.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView03.frame.size.height);
                                break;
                            case 4:
                                [_cellView04 addSubview:_button];
                                _cellView04.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView04.frame.size.height);
                                break;
                            case 5:
                                [_cellView05 addSubview:_button];
                                _cellView05.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView05.frame.size.height);
                                break;
                            case 6:
                                [_cellView06 addSubview:_button];
                                _cellView06.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView06.frame.size.height);
                                break;
                            case 7:
                                [_cellView07 addSubview:_button];
                                _cellView07.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView07.frame.size.height)
                                ;
                                break;
                            case 8:
                                [_cellView08 addSubview:_button];
                                _cellView08.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView08.frame.size.height);
                                break;
                            case 9:
                                [_cellView09 addSubview:_button];
                                _cellView09.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView09.frame.size.height);
                                break;
                            case 10:
                                [_cellView10 addSubview:_button];
                                _cellView10.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView10.frame.size.height);
                                break;
                            case 11:
                                [_cellView11 addSubview:_button];
                                _cellView11.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView11.frame.size.height);
                                break;
                            case 12:
                                [_cellView12 addSubview:_button];
                                _cellView12.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView12.frame.size.height);
                                break;
                            case 13:
                                [_cellView13 addSubview:_button];
                                _cellView13.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView13.frame.size.height);
                                break;
                            case 14:
                                [_cellView14 addSubview:_button];
                                _cellView14.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView14.frame.size.height);
                                break;
                            case 15:
                                [_cellView15 addSubview:_button];
                                _cellView15.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView15.frame.size.height);
                                break;
                            case 16:
                                [_cellView16 addSubview:_button];
                                _cellView16.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView16.frame.size.height);
                                break;
                            case 17:
                                [_cellView17 addSubview:_button];
                                _cellView17.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView17.frame.size.height);
                                break;
                            case 18:
                                [_cellView18 addSubview:_button];
                                _cellView18.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView18.frame.size.height);
                                break;
                            case 19:
                                [_cellView19 addSubview:_button];
                                _cellView19.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView19.frame.size.height);
                                break;
                            case 20:
                                [_cellView20 addSubview:_button];
                                _cellView20.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView20.frame.size.height);
                                break;
                            case 21:
                                [_cellView21 addSubview:_button];
                                _cellView21.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView21.frame.size.height);
                                break;
                            case 22:
                                [_cellView22 addSubview:_button];
                                _cellView22.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView22.frame.size.height);
                                break;
                            case 23:
                                [_cellView23 addSubview:_button];
                                _cellView23.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView23.frame.size.height);
                                break;
                            default:
                                break;
                        }
                    }
                    
                }
            
            
            
     }
        
        if (([timeStrRaindateDateSum intValue]>=[timeStrRainStratDateSum intValue])&&([timeStrRaindateDateSum intValue]<=[timeStrRainENDDateSum intValue])) {
   
            for (int i=0; i<[timeWalkingArray count]; i++)
            {
                
                if ([[timeWalkingArray objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
                {
                    
                    UIButton *_button=[UIButton buttonWithType:UIButtonTypeSystem];
                    {
                        _button.frame=CGRectMake(75,4+ buttonHeiger00*30, 255-30, 30);
                        ////NSLog(@"buttonHEIger====%d",buttonHeiger00);
                        buttonHeiger00=buttonHeiger00+1;
                    }
                    
                    _button.tag=60000+i;
              //      _button .backgroundColor=[UIColor colorWithRed:0/255.0 green:238/255.0 blue:118/255.0 alpha:1];

                
               //     [_button setTitleColor:[UIColor colorWithRed:0/255.0 green:205/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
                    _button.backgroundColor=[UIColor colorWithRed:186/255.0 green:237/255.0 blue:232/255.0 alpha:1];
                    [ _button setTitleColor:[UIColor colorWithRed:70/255.0 green:100/255.0 blue:100/255.0 alpha:1] forState:UIControlStateNormal];
     
                    NSString *str=[[NSString alloc]initWithFormat:@"  %@",[Utility getStringByKey:@"Exercise"]];
                         [_button setTitle:str forState:UIControlStateNormal];
                                               _button.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
                    [_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    _button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
                    _button.titleLabel.textAlignment=NSTextAlignmentLeft;
                    _button.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
                    [_button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    switch (joker) {
                        case 0:
                            [_cellView00 addSubview:_button];
                            _cellView00.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView00.frame.size.height);
                            break;
                        case 1:
                            [_cellView01 addSubview:_button];
                            _cellView01.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView01.frame.size.height);
                            break;
                        case 2:
                            [_cellView02 addSubview:_button];
                            _cellView02.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView02.frame.size.height);
                            break;
                        case 3:
                            [_cellView03 addSubview:_button];
                            _cellView03.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView03.frame.size.height);
                            break;
                        case 4:
                            [_cellView04 addSubview:_button];
                            _cellView04.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView04.frame.size.height);
                            break;
                        case 5:
                            [_cellView05 addSubview:_button];
                            _cellView05.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView05.frame.size.height);
                            break;
                        case 6:
                            [_cellView06 addSubview:_button];
                            _cellView06.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView06.frame.size.height);
                            break;
                        case 7:
                            [_cellView07 addSubview:_button];
                            _cellView07.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView07.frame.size.height)
                            ;
                            break;
                        case 8:
                            [_cellView08 addSubview:_button];
                            _cellView08.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView08.frame.size.height);
                            break;
                        case 9:
                            [_cellView09 addSubview:_button];
                            _cellView09.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView09.frame.size.height);
                            break;
                        case 10:
                            [_cellView10 addSubview:_button];
                            _cellView10.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView10.frame.size.height);
                            break;
                        case 11:
                            [_cellView11 addSubview:_button];
                            _cellView11.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView11.frame.size.height);
                            break;
                        case 12:
                            [_cellView12 addSubview:_button];
                            _cellView12.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView12.frame.size.height);
                            break;
                        case 13:
                            [_cellView13 addSubview:_button];
                            _cellView13.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView13.frame.size.height);
                            break;
                        case 14:
                            [_cellView14 addSubview:_button];
                            _cellView14.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView14.frame.size.height);
                            break;
                        case 15:
                            [_cellView15 addSubview:_button];
                            _cellView15.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView15.frame.size.height);
                            break;
                        case 16:
                            [_cellView16 addSubview:_button];
                            _cellView16.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView16.frame.size.height);
                            break;
                        case 17:
                            [_cellView17 addSubview:_button];
                            _cellView17.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView17.frame.size.height);
                            break;
                        case 18:
                            [_cellView18 addSubview:_button];
                            _cellView18.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView18.frame.size.height);
                            break;
                        case 19:
                            [_cellView19 addSubview:_button];
                            _cellView19.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView19.frame.size.height);
                            break;
                        case 20:
                            [_cellView20 addSubview:_button];
                            _cellView20.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView20.frame.size.height);
                            break;
                        case 21:
                            [_cellView21 addSubview:_button];
                            _cellView21.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView21.frame.size.height);
                            break;
                        case 22:
                            [_cellView22 addSubview:_button];
                            _cellView22.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView22.frame.size.height);
                            break;
                        case 23:
                            [_cellView23 addSubview:_button];
                            _cellView23.frame=CGRectMake(0, 0,320, _button.frame.size.height+_cellView23.frame.size.height);
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    ////NSLog(@"////NSLog==%d",buttonHeiger00);
                }
            }
            
        }
        

        
        
        UILabel* timeHandName=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 50, 50)];
        
        timeHandName.text=[_timeArray objectAtIndex:joker];
        timeHandName.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
        
        timeHandName.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        timeHandName.backgroundColor=[UIColor clearColor];
        
        switch (joker) {
            case 0:
                
                
                [_cellView00 sizeToFit];
                if (_cellView00.frame.size.height<30) {
                    _cellView00.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView00 addSubview:timeHandName];
                break;
            case 1:
                [_cellView01 sizeToFit];
                if (_cellView01.frame.size.height<30) {
                    _cellView01.frame=CGRectMake(0, 0,320,30);
                }
                [_cellView01 addSubview:timeHandName];
                break;
            case 2:
                if (_cellView02.frame.size.height<30) {
                    _cellView02.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView02 addSubview:timeHandName];
                [_cellView02 sizeToFit];
                break;
            case 3:
                if (_cellView03.frame.size.height<30) {
                    _cellView03.frame=CGRectMake(0, 0,320,30);
                }
                [_cellView03 addSubview:timeHandName];
                [_cellView03 sizeToFit];
                break;
            case 4:
                
                if (_cellView04.frame.size.height<30) {
                    _cellView04.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView04 addSubview:timeHandName];
                [_cellView04 sizeToFit];
                break;
            case 5:
                if (_cellView05.frame.size.height<30) {
                    _cellView05.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView05 addSubview:timeHandName];
                [_cellView05 sizeToFit];
                break;
            case 6:
                if (_cellView06.frame.size.height<30) {
                    _cellView06.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView06 addSubview:timeHandName];
                [_cellView06 sizeToFit];
                break;
            case 7:
                
                if (_cellView07.frame.size.height<30) {
                    _cellView07.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView07 addSubview:timeHandName];
                [_cellView07 sizeToFit];
                break;
            case 8:
                if (_cellView08.frame.size.height<30) {
                    _cellView08.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView08 addSubview:timeHandName];
                [_cellView08 sizeToFit];
                break;
            case 9:
                if (_cellView09.frame.size.height<30) {
                    _cellView09.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView09 addSubview:timeHandName];
                [_cellView09 sizeToFit];
                break;
            case 10:
                if (_cellView10.frame.size.height<30) {
                    _cellView10.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView10 addSubview:timeHandName];
                [_cellView10 sizeToFit];
                break;
            case 11:
                if (_cellView11.frame.size.height<30) {
                    _cellView11.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView11 addSubview:timeHandName];
                
                [_cellView11 sizeToFit];
                break;
            case 12:
                if (_cellView12.frame.size.height<30) {
                    _cellView12.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView12 addSubview:timeHandName];
                
                [_cellView12 sizeToFit];
                break;
            case 13:
                if (_cellView13.frame.size.height<30) {
                    _cellView13.frame=CGRectMake(0, 0,320,30);
                }
                [_cellView13 addSubview:timeHandName];
                
                [_cellView13 sizeToFit];
                break;
            case 14:
                if (_cellView14.frame.size.height<30) {
                    _cellView14.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView14 addSubview:timeHandName];
                
                [_cellView14 sizeToFit];
                break;
            case 15:
                if (_cellView15.frame.size.height<30) {
                    _cellView15.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView15 addSubview:timeHandName];
                
                [_cellView15 sizeToFit];
                break;
            case 16:
                if (_cellView16.frame.size.height<30) {
                    _cellView16.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView16 addSubview:timeHandName];
                
                [_cellView16 sizeToFit];
                break;
            case 17:
                if (_cellView17.frame.size.height<30) {
                    _cellView17.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView17 addSubview:timeHandName];
                
                [_cellView17 sizeToFit];
                break;
            case 18:
                if (_cellView18.frame.size.height<30) {
                    _cellView18.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView18 addSubview:timeHandName];
                
                [_cellView18 sizeToFit];
                break;
            case 19:
                if (_cellView19.frame.size.height<30) {
                    _cellView19.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView19 addSubview:timeHandName];
                
                [_cellView19 sizeToFit];
                break;
            case 20:
                if (_cellView20.frame.size.height<30) {
                    _cellView20.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView20 addSubview:timeHandName];
                
                [_cellView20 sizeToFit];
                break;
            case 21:
                if (_cellView21.frame.size.height<30) {
                    _cellView21.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView21 addSubview:timeHandName];
                [_cellView21 sizeToFit];
                break;
            case 22:
                if (_cellView22.frame.size.height<30) {
                    _cellView22.frame=CGRectMake(0, 0,320,30);
                }
                [_cellView22 addSubview:timeHandName];
                [_cellView22 sizeToFit];
                break;
            case 23:
                
                if (_cellView23.frame.size.height<30) {
                    _cellView23.frame=CGRectMake(0, 0,320, 30);
                }
                [_cellView23 addSubview:timeHandName];
                [_cellView23 sizeToFit];
                break;
            default:
                break;
        }
    }
    
    [_tableDayView reloadData];
    
    
}
-(IBAction)saveCalendar:(id)sender
{
    [saveCalendarButton setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    [self performSelector:@selector(delaySaveCalendarThread) withObject:nil afterDelay:0.1];
    
    
   
    
}
-(void)delaySaveCalendarThread{
    SaveCalendarViewController * saveCalendarView=[[SaveCalendarViewController alloc]initWithNibName:@"SaveCalendarViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:saveCalendarView animated:YES];
    
    [saveCalendarButton setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p3.png"] forState:UIControlStateNormal];
}
- (void)saveEvent:(NSString*)title note:(NSString*)note startDate:(NSDate*)statDate endDate:(NSDate*)endDate
{
    
    
    //事件市场
 
    
    //6.0及以上通过下面方式写入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    
                    
                    
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    event.title     =title;
            
                    event.notes=note;
                    ////NSLog(@"------------%ld",(long)event.birthdayPersonID);
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = statDate;
                    event.endDate   = endDate;
                    
                    //   event.allDay = YES; //一整天的意思--
                    
                    
                    NSDateFormatter* theEndDate = [[NSDateFormatter alloc] init];
                    [theEndDate setDateFormat:@"yyyy-MM-dd"];
                    NSTimeInterval endDayNumber = +(24*60*60)*366;
                    NSDate *_intheEND = [[NSDate date] dateByAddingTimeInterval:endDayNumber];
                    
                    EKRecurrenceEnd * endEkRecurrence=[EKRecurrenceEnd recurrenceEndWithEndDate:_intheEND];
                    EKRecurrenceRule * rucer=[[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyDaily interval:1 end:endEkRecurrence];
                    
                    
                    
                    [event addRecurrenceRule:rucer];
            
                    
                    
                    
                    //添加提醒
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    //
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    
                    
                   // [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                    
                    ////NSLog(@"event.calendarItemIdentifier==%@",event.calendarItemIdentifier);
                    
                    ////NSLog(@"Hold on a Minutes I can Save Now ");
                    
                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
        
        //4.0和5.0通过下述方式添加
        
        //保存日历
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
        event.title     = title;
    
        event.notes=note;
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
        
        [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        event.startDate = statDate;
        event.endDate   = endDate;
        // event.allDay = YES;
        
        
        // [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
        //  [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        
        //        UIAlertView *alert = [[UIAlertView alloc]
        //                              initWithTitle:@"Event Created"
        //                              message:@"Yay!?"
        //                              delegate:nil
        //                              cancelButtonTitle:@"Okay"
        //                              otherButtonTitles:nil];
        //        [alert show];
        
        ////NSLog(@"保存成功");
        
    }
}
- (void)saveEvent2:(NSString*)title note:(NSString*)note startDate:(NSDate*)statDate endDate:(NSDate*)endDate
{
    
    
    //事件市场
    
    
    //6.0及以上通过下面方式写入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    
                    
                    
                    //创建事件
                    EKEvent *event2  = [EKEvent eventWithEventStore:eventStore];
                  event2.title     =title;
                    event2.notes=note;
                    ////NSLog(@"------------%ld",(long)event2.birthdayPersonID);
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event2.startDate = statDate;
                    event2.endDate   = endDate;
                    
                    //   event.allDay = YES; //一整天的意思--
                    //添加提醒
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    //
            
                 
                    
                    
                    [event2 setCalendar:[eventStore defaultCalendarForNewEvents]];

                    NSError *err;
                    //[eventStore2 saveEvent:event2 span:EKSpanThisEvent error:&err];
                    [eventStore saveEvent:event2 span:EKSpanThisEvent commit:YES error:&err];
                    
                    ////NSLog(@"event.calendarItemIdentifier==%@",event2.calendarItemIdentifier);

                    
                    ////NSLog(@"Hold on a Minutes I can Save Now ");
                    
                }
            });
        }];
    }
    else
    {
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
        
        //4.0和5.0通过下述方式添加
        
        //保存日历
        EKEvent *event2  = [EKEvent eventWithEventStore:eventStore];
        event2.title     =title;
        
        event2.notes=note;
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
        
        [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        event2.startDate = statDate;
        event2.endDate   = endDate;
        // event.allDay = YES;
        
        
        // [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
        //  [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
        
        [event2 setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event2 span:EKSpanThisEvent error:&err];
        
        //        UIAlertView *alert = [[UIAlertView alloc]
        //                              initWithTitle:@"Event Created"
        //                              message:@"Yay!?"
        //                              delegate:nil
        //                              cancelButtonTitle:@"Okay"
        //                              otherButtonTitles:nil];
        //        [alert show];
        
        ////NSLog(@"保存成功");
        
    }
}

- (void)saveEvent3:(NSString*)title note:(NSString*)note startDate:(NSDate*)statDate endDate:(NSDate*)endDate
{
    
    
    //事件市场
    
    
    //6.0及以上通过下面方式写入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    
                    
                    
                    //创建事件
                    EKEvent *event3  = [EKEvent eventWithEventStore:eventStore];
               event3.title     =title;
                    event3.notes=note;
                    ////NSLog(@"------------%ld",(long)event3.birthdayPersonID);
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event3.startDate = statDate;
                    event3.endDate   = endDate;
                    
                    //   event.allDay = YES; //一整天的意思--
                    
                    
                    NSDateFormatter* theEndDate = [[NSDateFormatter alloc] init];
                    [theEndDate setDateFormat:@"yyyy-MM-dd"];
                    NSTimeInterval endDayNumber = +(24*60*60)*7;
                    NSDate *_intheEND = [event3.endDate dateByAddingTimeInterval:endDayNumber];
                    
                    EKRecurrenceEnd * endEkRecurrence=[EKRecurrenceEnd recurrenceEndWithEndDate:_intheEND];
                    EKRecurrenceRule * rucer=[[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyDaily interval:1 end:endEkRecurrence];
                    
                    
                    
                    [event3 addRecurrenceRule:rucer];
                    
                    
                    
                    
                    //添加提醒
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    //                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    //
                    
                    [event3 setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    
                    
                    // [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    [eventStore saveEvent:event3 span:EKSpanThisEvent commit:YES error:&err];
                    
                    ////NSLog(@"event.calendarItemIdentifier==%@",event3.calendarItemIdentifier);
                    
                    ////NSLog(@"Hold on a Minutes I can Save Now ");
                    
                }
            });
        }];
    }
    else
    {
             
        // this code runs in iOS 4 or iOS 5
        // ***** do the important stuff here *****
        
        //4.0和5.0通过下述方式添加
        
        //保存日历
        EKEvent *event3  = [EKEvent eventWithEventStore:eventStore];
        event3.title     = title;
        event3.notes=note;
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
        
        [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        event3.startDate = statDate;
        event3.endDate   = endDate;
        // event.allDay = YES;
        
        
        // [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
        //  [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
        
        [event3 setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event3 span:EKSpanThisEvent error:&err];
        
        //        UIAlertView *alert = [[UIAlertView alloc]
        //                              initWithTitle:@"Event Created"
        //                              message:@"Yay!?"
        //                              delegate:nil
        //                              cancelButtonTitle:@"Okay"
        //                              otherButtonTitles:nil];
        //        [alert show];
        
        ////NSLog(@"保存成功");
        
    }
}

- (void)deleteEvent
{
    ////NSLog(@"-----------------------===========+++++++++++++++@@@@@@@@@@@@@@@@");
    
    [DiaryViewController cancelAnd_userCalendar];
    
    
}
+(void)cancelAnd_userCalendar
{
    EKEventStore* _eventStore = [[EKEventStore alloc] init];
    NSDate* ssdate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*30];//事件段，开始时间
    NSDate* ssend = [NSDate dateWithTimeIntervalSinceNow:30*24*60*60];//结束时间，取中间
    NSPredicate* predicate = [_eventStore predicateForEventsWithStartDate:ssdate
                                                                 endDate:ssend
                                                               calendars:nil];
    // NSPredicate*predicate=[eventStore predicateForRemindersInCalendars:nil];
    
    ////NSLog(@"-------pr");
    NSArray* events = [_eventStore eventsMatchingPredicate:predicate];//数组里面就是时间段中的EKEvent事件数组
    
    
    
//    ////NSLog(@"eventsArray=%@",events);
    for (int i=0; i<[events count]; i++) {
       
        NSString * eventSTEMP=[[NSString alloc] initWithFormat:@"%@",[[events objectAtIndex:i] title]];
        if ([eventSTEMP length]>=11) {
            NSString * strRain=[eventSTEMP substringWithRange:NSMakeRange(0, 11)];
            if ([strRain isEqualToString:@"HealthReach"]) {
                ////NSLog(@"--------------------");
                ////NSLog(@"+++++++++++++++++++++++");
                
                // [eventStore removeEvent:[events objectAtIndex:i] span:EKSpanFutureEvents error:nil];
                [_eventStore removeEvent:[events objectAtIndex:i] span:EKSpanFutureEvents commit:YES error:nil];
            }
            

        }
           }
    ////NSLog(@"_______======%@",predicate);
}
-(void)beginSaveTheArray
{
    eventStore = [[EKEventStore alloc] init];;
    if (self.titleAdhocArray.count>0)
    {
        for (int lbj=0; lbj<self.titleAdhocArray.count; lbj++)
        {
            
            NSString *startTimeDate=[[NSString alloc] initWithFormat:@"%@ %@",[self.adDateDate objectAtIndex:lbj],[self.startTimesArray objectAtIndex:lbj]];
            
            NSString *endTimeDate=[[NSString alloc] initWithFormat:@"%@ %@",[self.adDateDate objectAtIndex:lbj],[self.endTimesArray objectAtIndex:lbj]];
            NSString *strTEMP=[[NSString alloc] initWithFormat:@"%@, %@",[self.titleAdhocArray objectAtIndex:lbj],[self.adHoNote objectAtIndex:lbj]];
            
            [self beginSaveCalendar2:@"HealthReach - Others"  note:strTEMP startDate:startTimeDate endDate:endTimeDate];
            
            
        }
    }
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSDateFormatter* dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
   // NSDate *date9 =[dateFormat1 dateFromString:self.walkStartDate];
    
    NSDateFormatter* sssdateFormat19 = [[NSDateFormatter alloc] init];
    [sssdateFormat19 setDateFormat:@"yyyy-MM-dd"];
  //  NSTimeInterval secondsPerDay19 = +(24*60*60);
  //  NSDate *tomorrow19 = [date9 dateByAddingTimeInterval:secondsPerDay19];
   // NSString *currentDateStr1119=[sssdateFormat19 stringFromDate:tomorrow19];
    ////NSLog(@"%@",currentDateStr1119);
    
    
//    NSTimeInterval secondsPerDay219 = (24*60*60)*2;
 //   NSDate *tomorrow219 = [date9 dateByAddingTimeInterval:secondsPerDay219];
  //  NSString *currentDateStr2219=[sssdateFormat19 stringFromDate:tomorrow219];
    ////NSLog(@"%@",currentDateStr2219);
    
  //  NSTimeInterval secondsPerDay319 = (24*60*60)*3;
  //  NSDate *tomorrow319 = [date9 dateByAddingTimeInterval:secondsPerDay319];
  //  NSString *currentDateStr3319=[sssdateFormat19 stringFromDate:tomorrow319];
    ////NSLog(@"%@",currentDateStr3319);
 //   NSTimeInterval secondsPerDay419 = (24*60*60)*4;
 //   NSDate *tomorrow419 = [date9 dateByAddingTimeInterval:secondsPerDay419];
  //  NSString *currentDateStr4419=[sssdateFormat19 stringFromDate:tomorrow419];
    ////NSLog(@"%@",currentDateStr4419);
 //   NSTimeInterval secondsPerDay519 = (24*60*60)*5;
 //   NSDate *tomorrow519 = [date9 dateByAddingTimeInterval:secondsPerDay519];
 //   NSString *currentDateStr5519=[sssdateFormat19 stringFromDate:tomorrow519];
    ////NSLog(@"%@",currentDateStr5519);
  //  NSTimeInterval secondsPerDay619 = (24*60*60)*6;
 //   NSDate *tomorrow619 = [date9 dateByAddingTimeInterval:secondsPerDay619];
 //   NSString *currentDateStr6619=[sssdateFormat19 stringFromDate:tomorrow619];
    ////NSLog(@"%@",currentDateStr6619);
    
    for (int lbj=0; lbj<self.timeBloodMutableArray.count; lbj++) {
        NSString *startTimeDate=[[NSString alloc] initWithFormat:@"%@ %@",currentDateStr,[self.timeBloodMutableArray objectAtIndex:lbj]];
        [self beginSaveCalendar:@"HealthReach - Blood Pressure" note:@"Blood Pressure Measurement" startDate:startTimeDate endDate:startTimeDate];
     
    }
    for (int lbj=0; lbj<self.timeECGMutableArray.count; lbj++) {
        NSString *startTimeDate=[[NSString alloc] initWithFormat:@"%@ %@",currentDateStr,[self.timeECGMutableArray objectAtIndex:lbj]];
        [self beginSaveCalendar:@"HealthReach - ECG" note:@"ECG Measurement" startDate:startTimeDate endDate:startTimeDate];
 
    }
    
    for (int lbj=0; lbj<self.timeGlucoseMutableArray.count; lbj++) {
        NSString *startTimeDate=[[NSString alloc] initWithFormat:@"%@ %@",currentDateStr,[self.timeGlucoseMutableArray objectAtIndex:lbj]];
        [self beginSaveCalendar:@"HealthReach - Blood Glucose" note:@"Blood Glucose Measurement" startDate:startTimeDate endDate:startTimeDate];
        
    }
    for (int lbj=0; lbj<self.timeWalkMustableArray.count; lbj++)
    {
        
        
        NSString*startTimeDate=[[NSString alloc] initWithFormat:@"%@ %@",self.walkStartDate,[self.timeWalkMustableArray objectAtIndex:lbj]];
        ////NSLog(@"****************************************############################$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$StarTtimeDate=%@",startTimeDate);
        [self beginSaveCalendar3:@"HealthReach - Exercise" note:@"Exercise" startDate:startTimeDate endDate:startTimeDate];
        

    }
    
    
    
    if (self.titleMedicationArray.count>0) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        ////NSLog(@"currentDate==%@",currentDateStr);
        for (int dairrr=0; dairrr<self.timesMedicationArray.count; dairrr++)
        {
            
            float ff=[[self.timesMedicationArray objectAtIndex:dairrr ] lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
            ////NSLog(@"+++++++%f",ff);
            objectCakendarAtTekinTime=[[NSMutableArray alloc]init];
            
            
            if (ff>1&&ff<7) {
                //
                NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0,5)];
                [objectCakendarAtTekinTime addObject:string];
                ////NSLog(@"__%@--",string);
            }
            else if (ff>=7.0&&ff<=13)
            {
                for (int temmm=0; temmm<2; temmm++) {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [objectCakendarAtTekinTime addObject:string];
                    ////NSLog(@"__%@--",string);
                }
                
                
            }
            else if (ff>=13.0&&ff<=19)
            {
                for (int temmm=0; temmm<3; temmm++)
                {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [objectCakendarAtTekinTime addObject:string];
                    ////NSLog(@"__%@--",string);
                }
                
            }
            else if (ff>=19.0&&ff<=25)
            {
                for (int temmm=0; temmm<4; temmm++) {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [objectCakendarAtTekinTime addObject:string];
                    ////NSLog(@"__%@--",string);
                }
                
            }
            else if (ff>=25.0&&ff<=31)
            {
                for (int temmm=0; temmm<5; temmm++) {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    ////NSLog(@"__%@--",string);
                    [objectCakendarAtTekinTime addObject:string];
                    
                    
                }
                
                
            }
            else if (ff>=31.0)
            {
                for (int temmm=0; temmm<6; temmm++)
                {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    ////NSLog(@"__%@--",string);
                    [objectCakendarAtTekinTime addObject:string];
                    
                }
            }
            
            for (int lbj=0; lbj<objectCakendarAtTekinTime.count; lbj++)
            {
                ////NSLog(@"****************************************############################$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$StarTtimeDate=");
                ////NSLog(@"[self.mealMedicationArray objectAtIndex:dairrr]=%@,[self.mealMedicationArray objectAtIndex:dairrr]=%@,[self.mealMedicationArray objectAtIndex:dairrr]=%@",[self.mealMedicationArray objectAtIndex:dairrr],[self.mealMedicationArray objectAtIndex:dairrr],[self.mealMedicationArray objectAtIndex:dairrr]);
                NSString *theTYPE;
                if ([[self.mealMedicationArray objectAtIndex:dairrr]isEqualToString:@"B"]) {
                    theTYPE=@", Before meal";
                }
                else if ([[self.mealMedicationArray objectAtIndex:dairrr]isEqualToString:@"A"])
                {
                    theTYPE=@", After meal";
                }
                else
                {
                    theTYPE=@"";
                }
                NSString *sTRTEMP=[[NSString alloc]initWithFormat:@"%@, %@ dosage%@",[self.titleMedicationArray objectAtIndex:dairrr],[self.dosageMedicationArray objectAtIndex:dairrr],theTYPE ];
                NSString *startTimeDate=[[NSString alloc] initWithFormat:@"%@ %@",currentDateStr,[objectCakendarAtTekinTime objectAtIndex:lbj]];
                [self beginSaveCalendar:@"HealthReach - Medication" note:sTRTEMP startDate:startTimeDate endDate:startTimeDate];
                
                
            }
        }
        
        
        
    }
    
    
}-(void)beginSaveCalendar:(NSString*)title note:(NSString*)note startDate:(NSString*)statDate endDate:(NSString*)endDate

{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startdate =[dateFormat dateFromString:statDate];
    
    ////NSLog(@"%@",startdate);
    NSDate *enddate =[dateFormat dateFromString:endDate];
    ////NSLog(@"%@",enddate);
    [self saveEvent:title note:note startDate:startdate endDate:enddate];
}
-(void)beginSaveCalendar2:(NSString*)title note:(NSString*)note startDate:(NSString*)statDate endDate:(NSString*)endDate

{
 
   
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDateFormatter* dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [dateFormat2 stringFromDate:[NSDate date]];
    ////NSLog(@"%@",currentDateStr);
    
    ////NSLog(@"%@",statDate);
    
    NSString *subRainStrYear=[statDate substringWithRange:NSMakeRange(0, 4)];
    NSString *subRainStrMoon=[statDate substringWithRange:NSMakeRange(5, 2)];
    NSString *subRainStrDAy=[statDate substringWithRange:NSMakeRange(8, 2)];
    NSString *subRainStrHour=[statDate substringWithRange:NSMakeRange(11, 2)];
    NSString *subRainStrMine=[statDate substringWithRange:NSMakeRange(14, 2)];
    NSString *subRainAllStr=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear,subRainStrMoon,subRainStrDAy,subRainStrHour,subRainStrMine];
    ////NSLog(@"-=-=-=--=-=-=-=-=SUBRAIN==%f       NOW=%f",[subRainAllStr floatValue],[currentDateStr floatValue]);
    long long subRain=[subRainAllStr longLongValue];
    long long current=[currentDateStr longLongValue];
    
    
       ////NSLog(@"RAin===%lld,cCURRENT==%lld",subRain,current);
    
    if (subRain>current) {
        NSDate *startdate =[dateFormat dateFromString:statDate];
        ////NSLog(@"%@",startdate);
        NSDate *enddate =[dateFormat dateFromString:endDate];
        ////NSLog(@"%@",enddate);
        [self saveEvent2:title note:note startDate:startdate endDate:enddate];

    }
    else
    {
        ////NSLog(@"RAin===%lld,cCURRENT==%lld",subRain,current);
    }
    
}
-(void)beginSaveCalendar3:(NSString*)title note:(NSString*)note startDate:(NSString*)statDate endDate:(NSString*)endDate

{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startdate =[dateFormat dateFromString:statDate];
    
    NSTimeInterval yestheday24 = +(24*60*60)*10;
    NSDate *yestaday24 = [startdate dateByAddingTimeInterval:yestheday24];
    NSString *dateString=[dateFormat stringFromDate:yestaday24];
    ////NSLog(@"dateString==%@",dateString);
    
    NSDateFormatter* dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [dateFormat2 stringFromDate:[NSDate date]];
    ////NSLog(@"%@",currentDateStr);
    
    
    NSString *subRainStrYear=[dateString substringWithRange:NSMakeRange(0, 4)];
    NSString *subRainStrMoon=[dateString substringWithRange:NSMakeRange(5, 2)];
    NSString *subRainStrDAy=[dateString substringWithRange:NSMakeRange(8, 2)];
    NSString *subRainStrHour=[dateString substringWithRange:NSMakeRange(11, 2)];
    NSString *subRainStrMine=[dateString substringWithRange:NSMakeRange(14, 2)];
    NSString *subRainAllStr=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear,subRainStrMoon,subRainStrDAy,subRainStrHour,subRainStrMine];
    ////NSLog(@"-=-=-=--=-=-=-=-=SUBRAIN==%f       NOW=%f",[subRainAllStr floatValue],[currentDateStr floatValue]);
    long long subRain=[subRainAllStr longLongValue];
    long long current=[currentDateStr longLongValue];
    
    ////NSLog(@"RAin===%lld,cCURRENT==%lld",subRain,current);
    
    if (subRain>current) {
    
    ////NSLog(@"%@",startdate);
    NSDate *enddate =[dateFormat dateFromString:endDate];
    ////NSLog(@"%@",enddate);
    [self saveEvent3:title note:note startDate:startdate endDate:enddate];
    }
    else
    {
            ////NSLog(@"RAin===%lld,cCURRENT==%lld",subRain,current);
    }
}

@end
