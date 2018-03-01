//
//  MR_ListViewController.m
//  mHealth
//
//  Created by gz dev team on 14年3月18日.
//
//

#import "MR_ListViewController.h"
#import "HomeViewController.h"
#import "AddReminderViewController.h"
#import "InformaitionViewController.h"
#import "DiaryViewController.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "Utility.h"
#import "DBHelper.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "DayChickViewController.h"
#import <EventKit/EventKit.h>

@interface MR_ListViewController ()

@end

@implementation MR_ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"MR_ListViewController" bundle:nibBundleOrNil];
    }
    else
    {
        ////NSLog(@"3.5 inch");
        self = [super initWithNibName:@"MR_ListViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}



- (void)resetClock:(NSDate*)date timeNAme:(NSString*)name title:(NSString*)title type:(int)type imageStr:(NSString*)imageStr
{

    if (date==NULL) {
        
    }
   else
   {
    
      NSDictionary*  dic=[[NSDictionary alloc]initWithObjectsAndKeys:title,@"title", self.titleMedicationArray,@"me_title",self.timesMedicationArray,@"times",self.medID,@"id",self.dosageMedicationArray,@"dosage",self.metickenArray,@"ticken",self.timeBloodMutableArray,@"bptime",self.timeECGMutableArray,@"ecgtime",self.timeGlucoseMutableArray,@"bgtime",self.timeWalkMustableArray,@"walktime",self.titleAdhocArray,@"others_title",self.startTimesArray,@"others_starttime",self.endTimesArray,@"others_endtime",self.adHoNote,@"others_note",self.adDateDate,@"others_date",imageStr,@"me_image",self.noteMedicationArray,@"me_note",nil];
    
    
    
    UILocalNotification *notification = [[UILocalNotification alloc] init] ;
    //设置時間
    ////NSLog(@"%@      %@    %@",date,[NSDate date],name);
    NSDate *pushDate = date ;
    if (notification != nil)
    {
        // 设置推送时间
        notification.fireDate = pushDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        if (type==0)
        {
              notification.repeatInterval = 0;
        }
        else
        {
            notification.repeatInterval = kCFCalendarUnitDay;
        }
        //  notification.repeatInterval = kCFCalendarUnitDay;
      
        // 推送声音
        notification.soundName =@"oldphone-mono-30s.caf";
        // 推送内容
        notification.alertBody =name;
        
  
        
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 0;
        
        
        
        //设置userinfo 方便在之后需要撤销的时候使用
      //  NSDictionary *info = [NSDictionary dictionaryWithObject:name forKey:@"id"];
        //////NSLog(@"info=%@",info);
        notification.userInfo = dic;
        //添加推送到UIApplication
        //[[UIApplication sharedApplication] scheduleLocalNotification:notification];
              //这句真的特别特别重要。如果不加这一句，通知到时间了，发现顶部通知栏提示的地方有了，然后你通过通知栏进去，然后你发现通知栏里边还有这个提示
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];

    }
   }
}
#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 40;
    //固定section 随着cell滚动而滚动
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}
-(void)takeTheTimes
{
    
   
    NSDateFormatter* sssdateFormat = [[NSDateFormatter alloc] init];
    [sssdateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [sssdateFormat stringFromDate:[NSDate date]];
    ////NSLog(@"%@",currentDateStr);
    
    NSTimeInterval secondsPerDay = +(24*60*60);
    NSDate *tomorrow = [[NSDate date] dateByAddingTimeInterval:secondsPerDay];
    NSString *currentDateStr11=[sssdateFormat stringFromDate:tomorrow];
    ////NSLog(@"%@",currentDateStr11);
    
 //   NSTimeInterval secondsPerDay2 = (24*60*60)*2;
  //  NSDate *tomorrow2 = [[NSDate date] dateByAddingTimeInterval:secondsPerDay2];
  //  NSString *currentDateStr22=[sssdateFormat stringFromDate:tomorrow2];
    ////NSLog(@"%@",currentDateStr22);
    
  //  NSTimeInterval secondsPerDay3 = (24*60*60)*3;
  //  NSDate *tomorrow3 = [[NSDate date] dateByAddingTimeInterval:secondsPerDay3];
 //   NSString *currentDateStr33=[sssdateFormat stringFromDate:tomorrow3];
    ////NSLog(@"%@",currentDateStr33);
    
 //   NSTimeInterval secondsPerDay4 = (24*60*60)*4;
 //   NSDate *tomorrow4 = [[NSDate date] dateByAddingTimeInterval:secondsPerDay4];
 //   NSString *currentDateStr44=[sssdateFormat stringFromDate:tomorrow4];
    ////NSLog(@"%@",currentDateStr44);
    
 //   NSTimeInterval secondsPerDay5 = (24*60*60)*5;
 //   NSDate *tomorrow5 = [[NSDate date] dateByAddingTimeInterval:secondsPerDay5];
 //   NSString *currentDateStr55=[sssdateFormat stringFromDate:tomorrow5];
    ////NSLog(@"%@",currentDateStr55);
    
//    NSTimeInterval secondsPerDay6 = (24*60*60)*6;
 //   NSDate *tomorrow6 = [[NSDate date] dateByAddingTimeInterval:secondsPerDay6];
 //   NSString *currentDateStr66=[sssdateFormat stringFromDate:tomorrow6];
    ////NSLog(@"%@",currentDateStr66);
    
 //   NSTimeInterval secondsPerDay7 = (24*60*60)*7;
 //   NSDate *tomorrow7 = [[NSDate date] dateByAddingTimeInterval:secondsPerDay7];
 //   NSString *currentDateStr77=[sssdateFormat stringFromDate:tomorrow7];
    ////NSLog(@"%@",currentDateStr77);
    
    
    
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    
    
    if (self.timeBloodMutableArray.count>0)
    {
        ////NSLog(@"________________________________________________");
        for (int dairyrrr=0;dairyrrr<self.timeBloodMutableArray.count; dairyrrr++)
        {
            
            
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString*temp=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr,[self.timeBloodMutableArray objectAtIndex:dairyrrr]];
            NSDate *now =[dateFormat dateFromString:temp];
            
            
            
            
         //   NSString *dateString=[dateFormat stringFromDate:now];
        
            
            NSDateFormatter* datedateF = [[NSDateFormatter alloc] init];
            [datedateF setDateFormat:@"yyyyMMddHHmmss"];
            NSString *currentDateStr123 = [datedateF stringFromDate:[NSDate date]];
        //    ////NSLog(@"now=====%@",currentDateStr123);
            
            
            
   
            
            
            NSString *subRainStrYear=[temp substringWithRange:NSMakeRange(0, 4)];
            NSString *subRainStrMoon=[temp substringWithRange:NSMakeRange(5, 2)];
            NSString *subRainStrDAy=[temp substringWithRange:NSMakeRange(8, 2)];
            NSString *subRainStrHour=[temp substringWithRange:NSMakeRange(11, 2)];
            NSString *subRainStrMine=[temp substringWithRange:NSMakeRange(14, 2)];
            NSString *subRainAllStr=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear,subRainStrMoon,subRainStrDAy,subRainStrHour,subRainStrMine];
            //   ////NSLog(@"闹钟时间等于  ＝＝＝%@,,,%@,,,%@",now,dateString,temp);
         //   ////NSLog(@"    currentDateStr=%@ subRainAllStr=%@",currentDateStr123,subRainAllStr);
          long long  sbuRain=[subRainAllStr longLongValue];
           long long current= [currentDateStr123 longLongValue];
                    ////NSLog(@"sub24====,sub2===,sub15==%lld,-------------CURRENT=%lld",sbuRain,current);
            if (sbuRain>current) {
            
                ////NSLog(@"YES______________________________________");
                typetitle=@"Blood Pressure";
                [self resetClock:now timeNAme:[Utility getStringByKey:@"Blood Pressure"]title:@"Blood Pressure"type:0 imageStr:@""];
            
            }
                NSString*temp1=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr11,[self.timeBloodMutableArray objectAtIndex:dairyrrr]];
                NSDate *now1 =[dateFormat dateFromString:temp1];
                typetitle=@"Blood Pressure";
                [self resetClock:now1 timeNAme:[Utility getStringByKey:@"Blood Pressure"]title:@"Blood Pressure"type:1 imageStr:@""];
           
        
            
//            NSString*temp2=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr22,[self.timeBloodMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now2 =[dateFormat dateFromString:temp2];
//         typetitle=@"Blood Pressure";
//                [self resetClock:now2 timeNAme:[Utility getStringByKey:@"Blood Pressure"]title:@"Blood Pressure"];
//            
//            NSString*temp3=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr33,[self.timeBloodMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now3 =[dateFormat dateFromString:temp3];
//         typetitle=@"Blood Pressure";
//               [self resetClock:now3 timeNAme:[Utility getStringByKey:@"Blood Pressure"]title:@"Blood Pressure"];
//            
//            
//            NSString*temp4=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr44,[self.timeBloodMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now4 =[dateFormat dateFromString:temp4];
//           typetitle=@"Blood Pressure";
//                [self resetClock:now4 timeNAme:[Utility getStringByKey:@"Blood Pressure"]title:@"Blood Pressure"];
//            
//            NSString*temp5=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr55,[self.timeBloodMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now5 =[dateFormat dateFromString:temp5];
//         typetitle=@"Blood Pressure";
//                [self resetClock:now5 timeNAme:[Utility getStringByKey:@"Blood Pressure"]title:@"Blood Pressure"];
//            
//            NSString*temp6=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr66,[self.timeBloodMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now6 =[dateFormat dateFromString:temp6];
//          typetitle=@"Blood Pressure";
//               [self resetClock:now6 timeNAme:[Utility getStringByKey:@"Blood Pressure"]title:@"Blood Pressure"];
//            
//            NSString*temp7=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr77,[self.timeBloodMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now7 =[dateFormat dateFromString:temp7];
//           typetitle=@"Blood Pressure";
//            [self resetClock:now7 timeNAme:[Utility getStringByKey:@"Blood Pressure"]title:@"Blood Pressure"];
//            
        }
        ////NSLog(@"________________________________________________");
    }
    
    if (self.timeECGMutableArray.count>0)
    {
        ////NSLog(@"________________________________________________");
        for (int dairyrrr=0; dairyrrr<self.timeECGMutableArray.count; dairyrrr++) {
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString*temp=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr,[self.timeECGMutableArray objectAtIndex:dairyrrr]];
            NSDate *now =[dateFormat dateFromString:temp];
       //     NSString *dateString=[dateFormat stringFromDate:now];
         //   ////NSLog(@"闹钟时间等于  ＝＝＝%@,,,%@,,,%@",now,dateString,temp);
            
            NSDateFormatter* datedateF = [[NSDateFormatter alloc] init];
            [datedateF setDateFormat:@"yyyyMMddHHmmss"];
            NSString *currentDateStr123 = [datedateF stringFromDate:[NSDate date]];
       //     ////NSLog(@"now=====%@",currentDateStr123);
            
            NSString *subRainStrYear=[temp substringWithRange:NSMakeRange(0, 4)];
            NSString *subRainStrMoon=[temp substringWithRange:NSMakeRange(5, 2)];
            NSString *subRainStrDAy=[temp substringWithRange:NSMakeRange(8, 2)];
            NSString *subRainStrHour=[temp substringWithRange:NSMakeRange(11, 2)];
            NSString *subRainStrMine=[temp substringWithRange:NSMakeRange(14, 2)];
            NSString *subRainAllStr=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear,subRainStrMoon,subRainStrDAy,subRainStrHour,subRainStrMine];
        //    ////NSLog(@"闹钟时间等于  ＝＝＝%@,,,%@,,,%@",now,dateString,temp);
        //    ////NSLog(@"    currentDateStr=%@ subRainAllStr=%@",currentDateStr123,subRainAllStr);
           long long subRain=[subRainAllStr longLongValue];
           long long current=[currentDateStr123 longLongValue];
         //           ////NSLog(@"sub24====,sub2===,sub15==%lld,-------------CURRENT=%lld",subRain,current);
            if (subRain>current) {
                
                ////NSLog(@"YES______________________");
            typetitle=@"ECG";
                [self resetClock:now timeNAme:[Utility getStringByKey:@"ECG"]title:@"ECG"type:0 imageStr:@""];
            
            }
            NSString*temp1=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr11,[self.timeECGMutableArray objectAtIndex:dairyrrr]];
            NSDate *now1 =[dateFormat dateFromString:temp1];
        typetitle=@"ECG";
             [self resetClock:now1 timeNAme:[Utility getStringByKey:@"ECG"]title:@"ECG" type:1 imageStr:@""];
            
//            NSString*temp2=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr22,[self.timeECGMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now2 =[dateFormat dateFromString:temp2];
//      typetitle=@"ECG";
//              [self resetClock:now2 timeNAme:[Utility getStringByKey:@"ECG"]title:@"ECG"];
//            
//            NSString*temp3=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr33,[self.timeECGMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now3 =[dateFormat dateFromString:temp3];
//       typetitle=@"ECG";
//              [self resetClock:now3 timeNAme:[Utility getStringByKey:@"ECG"]title:@"ECG"];
//            
//            
//            NSString*temp4=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr44,[self.timeECGMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now4 =[dateFormat dateFromString:temp4];
//          typetitle=@"ECG";
//              [self resetClock:now4 timeNAme:[Utility getStringByKey:@"ECG"]title:@"ECG"];
//            
//            NSString*temp5=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr55,[self.timeECGMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now5 =[dateFormat dateFromString:temp5];
//            typetitle=@"ECG";
//              [self resetClock:now5 timeNAme:[Utility getStringByKey:@"ECG"]title:@"ECG"];
//            
//            NSString*temp6=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr66,[self.timeECGMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now6 =[dateFormat dateFromString:temp6];
//           typetitle=@"ECG";
//              [self resetClock:now6 timeNAme:[Utility getStringByKey:@"ECG"]title:@"ECG"];
//            
//            NSString*temp7=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr77,[self.timeECGMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now7 =[dateFormat dateFromString:temp7];
//            typetitle=@"ECG";
//                         [self resetClock:now7 timeNAme:[Utility getStringByKey:@"ECG"]title:@"ECG"];
//            
            
        }
        ////NSLog(@"________________________________________________");
    }
    
    if (self.timeGlucoseMutableArray>0) {
        ////NSLog(@"________________________________________________");
        for (int dairyrrr=0; dairyrrr<self.timeGlucoseMutableArray.count; dairyrrr++) {
            
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString*temp=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr,[self.timeGlucoseMutableArray objectAtIndex:dairyrrr]];
            NSDate *now =[dateFormat dateFromString:temp];
       //     NSString *dateString=[dateFormat stringFromDate:now];
       //     ////NSLog(@"闹钟时间等于  ＝＝＝%@,,,%@,,,%@",now,dateString,temp);
            
            NSDateFormatter* datedateF = [[NSDateFormatter alloc] init];
            [datedateF setDateFormat:@"yyyyMMddHHmmss"];
            NSString *currentDateStr123 = [datedateF stringFromDate:[NSDate date]];
       //     ////NSLog(@"now=====%@",currentDateStr123);
            
            NSString *subRainStrYear=[temp substringWithRange:NSMakeRange(0, 4)];
            NSString *subRainStrMoon=[temp substringWithRange:NSMakeRange(5, 2)];
            NSString *subRainStrDAy=[temp substringWithRange:NSMakeRange(8, 2)];
            NSString *subRainStrHour=[temp substringWithRange:NSMakeRange(11, 2)];
            NSString *subRainStrMine=[temp substringWithRange:NSMakeRange(14, 2)];
            NSString *subRainAllStr=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear,subRainStrMoon,subRainStrDAy,subRainStrHour,subRainStrMine];
       //     ////NSLog(@"闹钟时间等于  ＝＝＝%@,,,%@,,,%@",now,dateString,temp);
       //     ////NSLog(@"    currentDateStr=%@ subRainAllStr=%@",currentDateStr123,subRainAllStr);
           long long subRain=[subRainAllStr longLongValue];
           long long current=[currentDateStr123 longLongValue];
            
              //      ////NSLog(@"sub24====,sub2===,sub15==%lld,-------------CURRENT=%lld",subRain,current);
            if (subRain>current) {
                ////NSLog(@"YES______________________");
                typetitle=@"Blood Glucose";
            [self resetClock:now timeNAme:[Utility getStringByKey:@"Blood Glucose"]title:@"Blood Glucose"type:0 imageStr:@""];
            }
            NSString*temp1=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr11,[self.timeGlucoseMutableArray objectAtIndex:dairyrrr]];
            NSDate *now1 =[dateFormat dateFromString:temp1];
         typetitle=@"Blood Glucose";
                    [self resetClock:now1 timeNAme:[Utility getStringByKey:@"Blood Glucose"]title:@"Blood Glucose"type:1 imageStr:@""];
//            
//            NSString*temp2=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr22,[self.timeGlucoseMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now2 =[dateFormat dateFromString:temp2];
//    typetitle=@"Blood Glucose";
//                     [self resetClock:now2 timeNAme:[Utility getStringByKey:@"Blood Glucose"]title:@"Blood Glucose"];
//            
//            NSString*temp3=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr33,[self.timeGlucoseMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now3 =[dateFormat dateFromString:temp3];
//            typetitle=@"Blood Glucose";
//                    [self resetClock:now3 timeNAme:[Utility getStringByKey:@"Blood Glucose"]title:@"Blood Glucose"];
//            
//            NSString*temp4=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr44,[self.timeGlucoseMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now4 =[dateFormat dateFromString:temp4];
//            typetitle=@"Blood Glucose";
//                   [self resetClock:now4 timeNAme:[Utility getStringByKey:@"Blood Glucose"]title:@"Blood Glucose"];
//            
//            NSString*temp5=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr55,[self.timeGlucoseMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now5 =[dateFormat dateFromString:temp5];
//            typetitle=@"Blood Glucose";
//                  [self resetClock:now5 timeNAme:[Utility getStringByKey:@"Blood Glucose"]title:@"Blood Glucose"];
//            
//            NSString*temp6=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr66,[self.timeGlucoseMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now6 =[dateFormat dateFromString:temp6];
//            typetitle=@"Blood Glucose";
//               [self resetClock:now6 timeNAme:[Utility getStringByKey:@"Blood Glucose"]title:@"Blood Glucose"];
//            
//            NSString*temp7=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr77,[self.timeGlucoseMutableArray objectAtIndex:dairyrrr]];
//            NSDate *now7 =[dateFormat dateFromString:temp7];
//            typetitle=@"Blood Glucose";
//                [self resetClock:now7 timeNAme:[Utility getStringByKey:@"Blood Glucose"]title:@"Blood Glucose"];
//            
            
        }
        ////NSLog(@"________________________________________________");
    }
    if (self.timeWalkMustableArray.count>0)
    {
            ////NSLog(@"________________________________________________");
        NSDateFormatter* datedateF = [[NSDateFormatter alloc] init];
        [datedateF setDateFormat:@"yyyyMMddHHmmss"];
    //    NSString *currentDateStr = [datedateF stringFromDate:[NSDate date]];
      //  ////NSLog(@"now=====%@",currentDateStr);
        if (self.walkStartDate)
        {
            NSDateFormatter* datedateF = [[NSDateFormatter alloc] init];
            [datedateF setDateFormat:@"yyyyMMddHHmmss"];
            NSString *currentDateStr = [datedateF stringFromDate:[NSDate date]];
      //      ////NSLog(@"now=====%@",currentDateStr);
            
            for (int jjjj=0; jjjj<self.timeWalkMustableArray.count; jjjj++) {
                NSString * allDateAndWAlking =[[NSString alloc]initWithFormat:@"%@ %@:01",self.walkStartDate,[self.timeWalkMustableArray objectAtIndex:jjjj]];
                NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *date =[dateFormat dateFromString:allDateAndWAlking];
              //  ////NSLog(@"allDateAndWAlking==%@",allDateAndWAlking);
                
                if ([allDateAndWAlking length]>15) {
                    NSDateFormatter* sssdateFormat1 = [[NSDateFormatter alloc] init];
                    [sssdateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSTimeInterval secondsPerDay1 = +(24*60*60);
                    NSDate *tomorrow1 = [date dateByAddingTimeInterval:secondsPerDay1];
                    NSString *currentDateStr111=[sssdateFormat1 stringFromDate:tomorrow1];
                    ////NSLog(@"%@",currentDateStr111);
                    
                    NSTimeInterval secondsPerDay21 = (24*60*60)*2;
                    NSDate *tomorrow21 = [date dateByAddingTimeInterval:secondsPerDay21];
                    NSString *currentDateStr221=[sssdateFormat1 stringFromDate:tomorrow21];
                    ////NSLog(@"%@",currentDateStr221);
                    
                    NSTimeInterval secondsPerDay31 = (24*60*60)*3;
                    NSDate *tomorrow31 = [date dateByAddingTimeInterval:secondsPerDay31];
                    NSString *currentDateStr331=[sssdateFormat1 stringFromDate:tomorrow31];
                    ////NSLog(@"%@",currentDateStr331);
                    
                    NSTimeInterval secondsPerDay41 = (24*60*60)*4;
                    NSDate *tomorrow41 = [date dateByAddingTimeInterval:secondsPerDay41];
                    NSString *currentDateStr441=[sssdateFormat1 stringFromDate:tomorrow41];
                    ////NSLog(@"%@",currentDateStr441);
                    
                    NSTimeInterval secondsPerDay51 = (24*60*60)*5;
                    NSDate *tomorrow51 = [date dateByAddingTimeInterval:secondsPerDay51];
                    NSString *currentDateStr551=[sssdateFormat1 stringFromDate:tomorrow51];
                    ////NSLog(@"%@",currentDateStr551);
                    
                    NSTimeInterval secondsPerDay61 = (24*60*60)*6;
                    NSDate *tomorrow61 = [date dateByAddingTimeInterval:secondsPerDay61];
                    NSString *currentDateStr661=[sssdateFormat1 stringFromDate:tomorrow61];
                    ////NSLog(@"%@",currentDateStr661);
                    
                    
                    
                    
                    NSString *subRainStrYear=[allDateAndWAlking substringWithRange:NSMakeRange(0, 4)];
                    NSString *subRainStrMoon=[allDateAndWAlking substringWithRange:NSMakeRange(5, 2)];
                    NSString *subRainStrDAy=[allDateAndWAlking substringWithRange:NSMakeRange(8, 2)];
                    NSString *subRainStrHour=[allDateAndWAlking substringWithRange:NSMakeRange(11, 2)];
                    NSString *subRainStrMine=[allDateAndWAlking substringWithRange:NSMakeRange(14, 2)];
                    NSString *subRainAllStr=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear,subRainStrMoon,subRainStrDAy,subRainStrHour,subRainStrMine];

               //     ////NSLog(@"    currentDateStr=%@ subRainAllStr=%@",currentDateStr,subRainAllStr);
                    
                    
                    NSDateFormatter* dateFormat1212 = [[NSDateFormatter alloc] init];
                    [dateFormat1212 setDateFormat:@"yyyyMMddHHmmss"];
                    NSDate *date9 =[dateFormat1212 dateFromString:subRainAllStr];
        
                    ////NSLog(@"subRainAllStr==%@",subRainAllStr);
                   long long subRain=[subRainAllStr longLongValue];
                   long long current=[currentDateStr longLongValue];
                    
                  //       ////NSLog(@"sub24====,sub2===,sub15==%lld,-------------CURRENT=%lld",subRain,current);
                    if (subRain>current) {
                        ////NSLog(@"YES______________________");
                        NSDate *now =[dateFormat dateFromString:allDateAndWAlking];
                        typetitle=@"Exercise";
                        [self resetClock:now timeNAme:[Utility getStringByKey:@"Exercise"]title:@"Exercise"type:0 imageStr:@""];

                    }
                    
                    NSDateFormatter* sssdateFormat19 = [[NSDateFormatter alloc] init];
                    [sssdateFormat19 setDateFormat:@"yyyyMMddHHmmss"];
                    NSTimeInterval secondsPerDay19 = +(24*60*60);
                    NSDate *tomorrow19 = [date9 dateByAddingTimeInterval:secondsPerDay19];
                    NSString *currentDateStr1119=[sssdateFormat19 stringFromDate:tomorrow19];
                    ////NSLog(@"%@",currentDateStr1119);
                    long long currentDateStr119Long=[currentDateStr1119 longLongValue];
                    if (currentDateStr119Long>current) {
                    
                    //NSLog(@"__________");
                        NSDate *now =[dateFormat dateFromString:currentDateStr111];
                        typetitle=@"Exercise";
                        [self resetClock:now timeNAme:[Utility getStringByKey:@"Exercise"]title:@"Exercise"type:0 imageStr:@""];
                        
                    }
                    
                    
                 //   NSTimeInterval secondsPerDay219 = (24*60*60)*2;
                 //   NSDate *tomorrow219 = [date9 dateByAddingTimeInterval:secondsPerDay219];
                  //  NSString *currentDateStr2219=[sssdateFormat19 stringFromDate:tomorrow219];
                    //NSLog(@"%@",currentDateStr2219);
                    long long currentDateStr219Long=[currentDateStr1119 longLongValue];
                    if (currentDateStr219Long>current) {
                        

                         //NSLog(@"__________");
                        NSDate *now =[dateFormat dateFromString:currentDateStr221];
                        typetitle=@"Exercise";
                        [self resetClock:now timeNAme:[Utility getStringByKey:@"Exercise"]title:@"Exercise"type:0 imageStr:@""];
                        
                    }
                    
                //    NSTimeInterval secondsPerDay319 = (24*60*60)*3;
             //       NSDate *tomorrow319 = [date9 dateByAddingTimeInterval:secondsPerDay319];
                //    NSString *currentDateStr3319=[sssdateFormat19 stringFromDate:tomorrow319];
                    //NSLog(@"%@",currentDateStr3319);
                    long long currentDateStr319Long=[currentDateStr1119 longLongValue];
                    if (currentDateStr319Long>current) {
                         //NSLog(@"__________");
                        NSDate *now =[dateFormat dateFromString:currentDateStr331];
                        typetitle=@"Exercise";
                        [self resetClock:now timeNAme:[Utility getStringByKey:@"Exercise"]title:@"Exercise"type:0 imageStr:@""];
                        
                    }
                    
                    
              //      NSTimeInterval secondsPerDay419 = (24*60*60)*4;
                //    NSDate *tomorrow419 = [date9 dateByAddingTimeInterval:secondsPerDay419];
                 //   NSString *currentDateStr4419=[sssdateFormat19 stringFromDate:tomorrow419];
                    //NSLog(@"%@",currentDateStr4419);
                    long long currentDateStr419Long=[currentDateStr1119 longLongValue];
                    if (currentDateStr419Long>current) {
                        
                         //NSLog(@"__________");
                        NSDate *now =[dateFormat dateFromString:currentDateStr441];
                        typetitle=@"Exercise";
                        [self resetClock:now timeNAme:[Utility getStringByKey:@"Exercise"]title:@"Exercise"type:0 imageStr:@""];
                        
                    }
                    
                //    NSTimeInterval secondsPerDay519 = (24*60*60)*5;
                //    NSDate *tomorrow519 = [date9 dateByAddingTimeInterval:secondsPerDay519];
                //    NSString *currentDateStr5519=[sssdateFormat19 stringFromDate:tomorrow519];
                    //NSLog(@"%@",currentDateStr5519);
                    long long currentDateStr519Long=[currentDateStr1119 longLongValue];
                    if (currentDateStr519Long>current) {
                        
                         //NSLog(@"__________");
                        NSDate *now =[dateFormat dateFromString:currentDateStr551];
                        typetitle=@"Exercise";
                        [self resetClock:now timeNAme:[Utility getStringByKey:@"Exercise"]title:@"Exercise"type:0 imageStr:@""];
                        
                    }
                //    NSTimeInterval secondsPerDay619 = (24*60*60)*6;
               //     NSDate *tomorrow619 = [date9 dateByAddingTimeInterval:secondsPerDay619];
               //     NSString *currentDateStr6619=[sssdateFormat19 stringFromDate:tomorrow619];
                    //NSLog(@"%@",currentDateStr6619);
                    long long currentDateStr619Long=[currentDateStr1119 longLongValue];
                    if (currentDateStr619Long>current) {
                        
                        //NSLog(@"__________");
                        NSDate *now =[dateFormat dateFromString:currentDateStr661];
                        typetitle=@"Exercise";
                        [self resetClock:now timeNAme:[Utility getStringByKey:@"Exercise"]title:@"Exercise"type:0 imageStr:@""];
                        
                    }
                    
                    
                }
                

            }
            
            
        }
        
        
        
        
        
    }
    if (self.startTimesArray.count>0)
    {
      
        //NSLog(@"StarTime24ARRAy=%@",startTime24);
             //NSLog(@"StarTime2ARRAy=%@",startTime2);
             //NSLog(@"StarTime015ARRAy=%@",startTime15);
        
        
        for (int dairyrrr=0; dairyrrr<self.startTimesArray.count; dairyrrr++)
        {
            
            if (([[self.startTimesArray objectAtIndex:dairyrrr] length]>4)&&([[self.adDateDate objectAtIndex:dairyrrr] length]>8))
            {
                //NSLog(@"________________________________________________");
                NSDateFormatter* datedateF = [[NSDateFormatter alloc] init];
                [datedateF setDateFormat:@"yyyyMMddHHmmss"];
                NSString *currentDateStr = [datedateF stringFromDate:[NSDate date]];
                //NSLog(@"now=====%@",currentDateStr);
                
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
               // NSString*temp=[[NSString alloc]initWithFormat:@"%@ %@:01",[self.adDateDate objectAtIndex:dairyrrr],[self.startTimesArray objectAtIndex:dairyrrr]];
          //      NSDate *now =[dateFormat dateFromString:temp];
                //NSLog(@"now=%@",now);
//                NSString * temp=[[NSString alloc]initWithFormat:@"%@",now];
                
          //      NSString *subRainStrYear=[temp substringWithRange:NSMakeRange(0, 4)];
         //       NSString *subRainStrMoon=[temp substringWithRange:NSMakeRange(5, 2)];
         //       NSString *subRainStrDAy=[temp substringWithRange:NSMakeRange(8, 2)];
         //       NSString *subRainStrHour=[temp substringWithRange:NSMakeRange(11, 2)];
        //        NSString *subRainStrMine=[temp substringWithRange:NSMakeRange(14, 2)];
           //     NSString *subRainAllStr=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear,subRainStrMoon,subRainStrDAy,subRainStrHour,subRainStrMine];
           //     //NSLog(@"-=-=-=--=-=-=-=-=SUBRAIN==%f       NOW=%f",[subRainAllStr floatValue],[currentDateStr floatValue]);
         //      long long subRain=[subRainAllStr longLongValue];
                long long current=[currentDateStr longLongValue];
               
                
                NSString *subRainStrYear24=[[startTime24 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(0, 4)];
                NSString *subRainStrMoon24=[[startTime24 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(5, 2)];
                NSString *subRainStrDAy24= [[startTime24 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(8, 2)];
                NSString *subRainStrHour24=[[startTime24 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(11, 2)];
                NSString *subRainStrMine24=[[startTime24 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(14, 2)];
                NSString *subRainAllStr24=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear24,subRainStrMoon24,subRainStrDAy24,subRainStrHour24,subRainStrMine24];
                long long sub24=[subRainAllStr24 longLongValue];
                
                
                
                NSString *subRainStrYear2=[[startTime2 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(0, 4)];
                NSString *subRainStrMoon2=[[startTime2 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(5, 2)];
                NSString *subRainStrDAy2= [[startTime2 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(8, 2)];
                NSString *subRainStrHour2=[[startTime2 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(11, 2)];
                NSString *subRainStrMine2=[[startTime2 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(14, 2)];
                NSString *subRainAllStr2=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear2,subRainStrMoon2,subRainStrDAy2,subRainStrHour2,subRainStrMine2];
                long long sub2=[subRainAllStr2 longLongValue];

                NSString *subRainStrYear15=[[startTime15 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(0, 4)];
                NSString *subRainStrMoon15=[[startTime15 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(5, 2)];
                NSString *subRainStrDAy15= [[startTime15 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(8, 2)];
                NSString *subRainStrHour15=[[startTime15 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(11, 2)];
                NSString *subRainStrMine15=[[startTime15 objectAtIndex:dairyrrr] substringWithRange:NSMakeRange(14, 2)];
                NSString *subRainAllStr15=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear15,subRainStrMoon15,subRainStrDAy15,subRainStrHour15,subRainStrMine15];
                long long sub015=[subRainAllStr15 longLongValue];
//
   
                NSString * titleAD=[[NSString alloc]initWithFormat:@"%@",[self.titleAdhocArray objectAtIndex:dairyrrr]];
              
                
            //NSLog(@"USBRanin=%lld  sub24====%lld,sub2===%lld,sub15==%lld,-------------CURRENT=%lld",subRain,sub24,sub2,sub015,current);
                if (sub24>current)
                {
                    typetitle=@"Others";
                    NSDate *date24=[dateFormat dateFromString:[startTime24 objectAtIndex:dairyrrr]];
                    NSDate *date2=[dateFormat dateFromString:[startTime2 objectAtIndex:dairyrrr]];
                    NSDate *date015=[dateFormat dateFromString:[startTime15 objectAtIndex:dairyrrr]];
                    [self resetClock:date24 timeNAme:titleAD title:@"Others"type:0 imageStr:@""];
                    [self resetClock:date2 timeNAme:titleAD title:@"Others"type:0 imageStr:@""];
                    [self resetClock:date015 timeNAme:titleAD title:@"Others"type:0 imageStr:@""];
                }
                else if (sub2>current)
                {
               typetitle=@"Others";
                    NSDate *date2=[dateFormat dateFromString:[startTime2 objectAtIndex:dairyrrr]];
                    NSDate *date015=[dateFormat dateFromString:[startTime15 objectAtIndex:dairyrrr]];
                    [self resetClock:date2 timeNAme:titleAD title:@"Others"type:0 imageStr:@""];
                    [self resetClock:date015 timeNAme:titleAD title:@"Others"type:0 imageStr:@""];

                }
               if (sub015>current)
                {
                    typetitle=@"Others";
                    NSDate *date015=[dateFormat dateFromString:[startTime15 objectAtIndex:dairyrrr]];
             
                    [self resetClock:date015 timeNAme:titleAD title:@"Others"type:0 imageStr:@""];

                }
//                else
//                {
//                    //NSLog(@"________________________________________________");
//                }
                
                
            }
            
        }
        //NSLog(@"________________________________________________");
    }
    
    if (self.timesMedicationArray.count>0)
    {
        //NSLog(@"________________________________________________");
        for (int dairrr=0; dairrr<self.timesMedicationArray.count; dairrr++)
        {
            float ff=[[self.timesMedicationArray objectAtIndex:dairrr ] lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
            //NSLog(@"+++++++%f",ff);
            timesArray =[[NSMutableArray alloc]init];
            
            
            if (ff>1&&ff<7) {
                //
                NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0,5)];
                [timesArray addObject:string];
                //NSLog(@"__%@--",string);
            }
            else if (ff>=7.0&&ff<=13)
            {
                for (int temmm=0; temmm<2; temmm++) {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [timesArray addObject:string];
                    //NSLog(@"__%@--",string);
                }
                
                
            }
            else if (ff>=13.0&&ff<=19)
            {
                for (int temmm=0; temmm<3; temmm++)
                {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [timesArray addObject:string];
                    //NSLog(@"__%@--",string);
                }
                
            }
            else if (ff>=19.0&&ff<=25)
            {
                for (int temmm=0; temmm<4; temmm++) {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [timesArray addObject:string];
                    //NSLog(@"__%@--",string);
                }
                
            }
            else if (ff>=25.0&&ff<=31)
            {
                for (int temmm=0; temmm<5; temmm++) {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    //NSLog(@"__%@--",string);
                    [timesArray addObject:string];
                    
                    
                }
                
                
            }
            else if (ff>=31.0)
            {
                for (int temmm=0; temmm<6; temmm++)
                {
                    NSString *string = [[self.timesMedicationArray objectAtIndex:dairrr ]  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    //NSLog(@"__%@--",string);
                    [timesArray addObject:string];
                    
                }
            }
            
            
            for (int dairyrrr=0; dairyrrr<timesArray.count; dairyrrr++)
            {
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
           
                
                        NSString*temp=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr,[timesArray objectAtIndex:dairyrrr]];
                        NSDate *now =[dateFormat dateFromString:temp];
                  //      NSString *dateString=[dateFormat stringFromDate:now];
                  //      //NSLog(@"闹钟时间等于  ＝＝＝%@,,,%@,,,%@",now,dateString,temp);
                
                NSDateFormatter* datedateF = [[NSDateFormatter alloc] init];
                [datedateF setDateFormat:@"yyyyMMddHHmmss"];
                NSString *currentDateStr123 = [datedateF stringFromDate:[NSDate date]];
                //NSLog(@"now=====%@",currentDateStr123);
                
                NSString *subRainStrYear=[temp substringWithRange:NSMakeRange(0, 4)];
                NSString *subRainStrMoon=[temp substringWithRange:NSMakeRange(5, 2)];
                NSString *subRainStrDAy=[temp substringWithRange:NSMakeRange(8, 2)];
                NSString *subRainStrHour=[temp substringWithRange:NSMakeRange(11, 2)];
                NSString *subRainStrMine=[temp substringWithRange:NSMakeRange(14, 2)];
                NSString *subRainAllStr=[[NSString alloc]initWithFormat:@"%@%@%@%@%@01",subRainStrYear,subRainStrMoon,subRainStrDAy,subRainStrHour,subRainStrMine];
            //    //NSLog(@"闹钟时间等于  ＝＝＝%@,,,%@,,,%@",now,dateString,temp);
            //    //NSLog(@"    currentDateStr=%@ subRainAllStr=%@",currentDateStr123,subRainAllStr);
               long long subRain=[subRainAllStr longLongValue];
               long long current=[currentDateStr123 longLongValue];
                if (subRain>current) {
                     typetitle=@"Medication";
                        [self resetClock:now timeNAme:[self.titleMedicationArray objectAtIndex:dairrr]title:@"Medication"type:0 imageStr:[self.imageStrMedicationArray objectAtIndex:dairrr]];
                }
                        NSString*temp1=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr11,[timesArray objectAtIndex:dairyrrr]];
                        NSDate *now1 =[dateFormat dateFromString:temp1];
              
                    typetitle=@"Medication";
                         [self resetClock:now1 timeNAme:[self.titleMedicationArray objectAtIndex:dairrr]title:@"Medication"type:1 imageStr:[self.imageStrMedicationArray objectAtIndex:dairrr]];
//            
//                        NSString*temp2=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr22,[timesArray objectAtIndex:dairyrrr]];
//                        NSDate *now2 =[dateFormat dateFromString:temp2];
//           typetitle=@"Medication";
//                          [self resetClock:now2 timeNAme:[self.titleMedicationArray objectAtIndex:dairrr]title:@"Medication"];
//                
//            
//                        NSString*temp3=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr33,[timesArray objectAtIndex:dairyrrr]];
//                        NSDate *now3 =[dateFormat dateFromString:temp3];
//                typetitle=@"Medication";
//                        [self resetClock:now3 timeNAme:[self.titleMedicationArray objectAtIndex:dairrr]title:@"Medication"];
//                
//           
//                        NSString*temp4=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr44,[timesArray objectAtIndex:dairyrrr]];
//                        NSDate *now4 =[dateFormat dateFromString:temp4];
//                typetitle=@"Medication";
//                        [self resetClock:now4 timeNAme:[self.titleMedicationArray objectAtIndex:dairrr]title:@"Medication"];
//            
//                        NSString*temp5=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr55,[timesArray objectAtIndex:dairyrrr]];
//                        NSDate *now5 =[dateFormat dateFromString:temp5];
//                typetitle=@"Medication";
//                        [self resetClock:now5 timeNAme:[self.titleMedicationArray objectAtIndex:dairrr]title:@"Medication"];
//                
//            
//                        NSString*temp6=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr66,[timesArray objectAtIndex:dairyrrr]];
//                        NSDate *now6 =[dateFormat dateFromString:temp6];
//                typetitle=@"Medication";
//                        [self resetClock:now6 timeNAme:[self.titleMedicationArray objectAtIndex:dairrr]title:@"Medication"];
//                
//            
//                        NSString*temp7=[[NSString alloc]initWithFormat:@"%@ %@:01",currentDateStr77,[timesArray objectAtIndex:dairyrrr]];
//                        NSDate *now7 =[dateFormat dateFromString:temp7];
//                typetitle=@"Medication";
//                        [self resetClock:now7 timeNAme:[self.titleMedicationArray objectAtIndex:dairrr]title:@"Medication"];
//                
//                    
//                
    
            }
            
            
            
            
        }
        //NSLog(@"________________________________________________");
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *loadfromFGTC_Key=[defaults objectForKey:@"Frist Go to Calendar Key"];
    if ([loadfromFGTC_Key isEqualToString:@"Y"])
    {
        
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
    }
    
    [self TextFonts];
    
    

   
}
-(void)TextFonts
{
    [mHealthHandTextFOnt setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    mHealthHandTextFOnt.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [msehsHandTextFont setText:[Utility getStringByKey:@"Events Summary"]];
    msehsHandTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    [addReminderTextFont setTitle:[Utility getStringByKey:@"Add Event"] forState:UIControlStateNormal];
    addReminderTextFont.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _tableView=[[UITableView alloc] initWithFrame:_table.bounds style: UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled=YES;
    _tableView.bounces=YES;
    
    [_table addSubview:_tableView];
    //NSLog(@"%@==-===--",self.dateDateStr);
    
    
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
    
    
    [self getHistoryRecord];
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSLog(@"Self.StartTimeOther=%@  self.Otherdate=%@",self.startTimesArray,self.adDateDate);
    startTime24=[[NSMutableArray alloc]init];
     startTime2=[[NSMutableArray alloc]init];
     startTime15=[[NSMutableArray alloc]init];
    
    for (int dairyrrr=0; dairyrrr<self.startTimesArray.count; dairyrrr++)
    {

    NSString*temp=[[NSString alloc]initWithFormat:@"%@ %@:01",[self.adDateDate objectAtIndex:dairyrrr],[self.startTimesArray objectAtIndex:dairyrrr]];
    NSDate *now =[dateFormat dateFromString:temp];
    
    ////NSLog(@"YES______________________");
    NSTimeInterval yestheday24 = -(24*60*60);
    NSDate *yestaday24 = [now dateByAddingTimeInterval:yestheday24];
    NSString *dateString=[dateFormat stringFromDate:yestaday24];
    ////NSLog(@"闹钟时间等于  ＝＝＝%@,,,yestaday24%@,,,%@",now,dateString,temp);
    ////NSLog(@"yestaday24===========%@",yestaday24);
    
        [startTime24 addObject:dateString];
        
    NSTimeInterval yestheday2 = -(2*60*60);
    NSDate *yestaday2 = [now dateByAddingTimeInterval:yestheday2];
    NSString *dateString2=[dateFormat stringFromDate:yestaday2];
    ////NSLog(@"闹钟时间等于  ＝＝＝%@,,,yestaday2%@,,,%@",now,dateString2,temp);
    //  NSString * titleAD1=[[NSString alloc]initWithFormat:@"  %@",[self.titleAdhocArray objectAtIndex:dairyrrr]];
    ////NSLog(@"yestaday2===========%@",yestaday2);
        [startTime2 addObject:dateString2];
    
    NSTimeInterval yestheday15 = -(15*60);
    NSDate *yestaday15 = [now dateByAddingTimeInterval:yestheday15];
    NSString *dateString15=[dateFormat stringFromDate:yestaday15];
    ////NSLog(@"闹钟时间等于  ＝＝＝%@,,,yestaday15%@,,,%@",now,dateString15,temp);
    
    //   NSString * titleAD2=[[NSString alloc]initWithFormat:@"  %@",[self.titleAdhocArray objectAtIndex:dairyrrr]];
    ////NSLog(@"yestaday15===========%@",yestaday15);
    
        [startTime15 addObject:dateString15];
    
    
    
    }
    

    
    ////NSLog(@"self.BPcount====%lu,self.ECGcount===%lu,self.BGcount===%lu",(unsigned long)self.timeBloodMutableArray.count,(unsigned long)self.timeECGMutableArray.count,(unsigned long)self.timeGlucoseMutableArray.count);
     self.isCalendar=[DBHelper isSave];
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadInMainMethod) object:nil];
    [myThread start];
 
   // [self threadInMainMethod];
    
   
    
 
    
}
-(void)threadInMainMethod
{
    
    self.isCalendar=[DBHelper isSave];
    
    if (self.isCalendar==1) {
        
        int isgengxinle=[DBHelper gengxinguoma];
        if (isgengxinle==1) {
            
            [self deleteEvent];
            ////NSLog(@"OK++++++++++ I'm OK Yes");
            [self beginSaveTheArray];
            isgengxinle=0;
            [DBHelper zhendeyouma:0];
            
            
        }
        else
        {
            
        }
        
        
        
    }
    else
    {
        [self deleteEvent];
        ////NSLog(@"Sorry+++++++ I'm Not OK");
        
    }
    ////NSLog(@"YEAR YEAR YEAR WOW WOW OH OH OH AHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAH");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
    NSString *loadfromFGTC_Key=[defaults objectForKey:@"Frist Go to Calendar Key"];
    ////NSLog(@"LoadFromKey==%@",loadfromFGTC_Key);
    if ([loadfromFGTC_Key isEqualToString:@"Y"])
    {
        
         [self takeTheTimes];
        
        [defaults setObject:@"N" forKey:@"Frist Go to Calendar Key"];
        
          [defaults synchronize];
          ////NSLog(@"LoadFromKey==%@",loadfromFGTC_Key);
    }
    else
    {
        
    }

    
    
    
    
   
    
}


-(void)delayAddReminderThread{
    // [self saveEvent];
    AddReminderViewController *homeView = [[AddReminderViewController alloc]initWithNibName:@"AddReminderViewController" bundle:nil];
    if (self.dateDateStr) {
        homeView.dateDateStr=self.dateDateStr;
        ////NSLog(@"++++++++++++++++%@+++++++++++++++++++++",self.dateDateStr);
        
    }
    else
    {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        self.dateDateStr=currentDateStr;
        homeView.dateDateStr=self.dateDateStr;
        
    }
    homeView.timeGlucoseMutableArray=[[NSMutableArray alloc]init];
    homeView.timeECGMutableArray=[[NSMutableArray alloc]init];
    homeView.timeBloodMutableArray=[[NSMutableArray alloc]init];
    homeView.timeWalkMutableArray=[[NSMutableArray alloc]init];
    
    homeView.timeBloodMutableArray  =self.timeBloodMutableArray ;
    homeView.timeECGMutableArray=  self.timeECGMutableArray ;
    homeView.timeGlucoseMutableArray =self.timeGlucoseMutableArray;
    
    homeView.timeWalkMutableArray=self.timeWalkMustableArray;
    homeView.mediationidCOnt=self.medID.count;
    
    
    [self.navigationController pushViewController:homeView animated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[self presentViewController:homeView animated:YES completion:nil];

    
    [addReminderTextFont setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p3.png"] forState:UIControlStateNormal];
}


-(IBAction)AddReminder:(id)sender
{
    
    [addReminderTextFont setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    [self performSelector:@selector(delayAddReminderThread) withObject:nil afterDelay:0.1];
    
    
    
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
             //       ////NSLog(@"-----=-=-============-====o=-==========self.timeMedicationArray=%@",self.timesMedicationArray);
                    UIImageView *imageViewphotoLittle;
                    if ([[self.imageStrMedicationArray objectAtIndex:indexPath.row] length]>30) {
                        NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:[self.imageStrMedicationArray objectAtIndex:indexPath.row] options:NO];
                        UIImage *image=[[UIImage alloc]initWithData:datetmp];
                        imageViewphotoLittle =[[UIImageView alloc]initWithImage:image];
                        imageViewphotoLittle.frame=CGRectMake(10, 0, 45, 30);
                        [cell.contentView addSubview:imageViewphotoLittle];

                    }
                  
       
                    UILabel *titleText=[[UILabel alloc] init];
                    if ([[self.imageStrMedicationArray objectAtIndex:indexPath.row] length]>30)
                    {
                        titleText.frame=CGRectMake(45+10,10 , 70, 40);
                    }
                    else
                    {
                        titleText.frame=CGRectMake(10,10 , 70, 40);
                    }
                    titleText.text=[self.titleMedicationArray objectAtIndex:indexPath.row];
                 
                    titleText.numberOfLines=10;
                    titleText.textColor=[UIColor colorWithRed:41/255.0 green:133/255.0 blue:173/255.0 alpha:1];
                    titleText.backgroundColor=[UIColor clearColor];
                          titleText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:15];
                    [titleText sizeToFit];
                    if ([[self.imageStrMedicationArray objectAtIndex:indexPath.row] length]>30)
                    {
                    titleText.frame=CGRectMake(10+45+10, 0, 70, titleText.frame.size.height+5);
                    }
                    else
                    {
                    titleText.frame=CGRectMake(10, 0, 70, titleText.frame.size.height+5);
                    }
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
                    ////NSLog(@"<<<%@-%@-%@>>>",timeStrRain111,allTheDay,timeStrRain222);
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
                    
                    //                UILabel * endTimeText=[[UILabel alloc]initWithFrame:CGRectMake(160+70,30 , 80, 20)];
                    //
                    //                endTimeText.text=[self.endTimesArray objectAtIndex:indexPath.row];
                    //                endTimeText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:14];
                    //                endTimeText.backgroundColor=[UIColor clearColor];
                    //                [endTimeText sizeToFit];
                    //                endTimeText.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
                    //                [cell.contentView addSubview:endTimeText];
                    
                    
                    
                    
                    
                    
                    
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

-(void)getHistoryRecord
{
    NSMutableArray*arrau=[DBHelper getCalendarBPRecode];
    ////NSLog(@"CALENDAR___BP===%@------>%lu",arrau,(unsigned long)arrau.count);
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
    ////NSLog(@"CALENDAR___ECG===%@------>%lu",arrau1,(unsigned long)arrau1.count);
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
    ////NSLog(@"CALENDAR___BG===%@------>%lu",arrau2,(unsigned long)arrau2.count);
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
    ////NSLog(@"CALENDAR___OTHERS===%@------>%lu",arrau3,(unsigned long)arrau3.count);
    
    
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
    ////NSLog(@"CALENDAR___WALKING===%@------>%lu",arrau4,(unsigned long)arrau4.count);
    
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
//    ////NSLog(@"CALENDAR___MEDICATION===%@------>%lu",arrau5,(unsigned long)arrau5.count);
    
    NSMutableArray * medidArray=[NSMutableArray new];
    NSMutableArray *titleArrayMedication=[NSMutableArray new];
    NSMutableArray *dosageArray=[NSMutableArray new];
    NSMutableArray *reminderArrayMedication=[NSMutableArray new];
    NSMutableArray *mealArray=[NSMutableArray new];
    NSMutableArray *reminderidArray=[NSMutableArray new];
    NSMutableArray *takenArray=[NSMutableArray new];
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
       // NSString *imageStr=[dicTion objectForKey:@"reminder_image_string"];
      NSString *imageStr=[dicTion objectForKey:@"reminder_image_string"];
       // ////NSLog(@"mealMedicationStr=%@",mealMedicationStr);
        [medidArray addObject:meidStr];
        [titleArrayMedication addObject:titleMedicationStr];
        [reminderArrayMedication addObject:timesMEdicationStr];
        [dosageArray addObject:dosageMedicationStr];
        [mealArray addObject:mealMedicationStr];
        [reminderidArray addObject:reminderIDSTR];
        [takenArray addObject:takenstr];
        [imageArray addObject:imageStr];
        
        
    }
 //   ////NSLog(@"imageArray==%@",imageArray);
    self.titleMedicationArray=[[NSMutableArray alloc]initWithArray:titleArrayMedication];
    self.timesMedicationArray=[[NSMutableArray alloc]initWithArray:reminderArrayMedication];
    self.medID=[[NSMutableArray alloc]initWithArray:medidArray];
    self.dosageMedicationArray=[[NSMutableArray alloc]initWithArray:dosageArray];
    self.mealMedicationArray=[[NSMutableArray alloc]initWithArray:mealArray];
    self.reminderIDMedicationArray=[[NSMutableArray alloc]initWithArray:reminderidArray];
    self.metickenArray=[[NSMutableArray alloc]initWithArray:takenArray];
    self.imageStrMedicationArray=[[NSMutableArray alloc]initWithArray:imageArray];
    
    
    
    
      NSMutableArray*arrau6=[DBHelper getCalendarMedicationRecode_Notes];
    

    NSMutableArray *note_medicationNote=[NSMutableArray new];
    
    for (int i=0; i<arrau6.count; i++)
    {
        
        NSDictionary * dicTion=[arrau6 objectAtIndex:i];

        NSString *note=[dicTion objectForKey:@"note"];
 
        [note_medicationNote addObject:note];
        
        
        
    }
    self.noteMedicationArray=[[NSMutableArray alloc]initWithArray:note_medicationNote];
    
    
    
    
}


-(void)addButtonYes
{
    [self backToHome];
   
}




//表头的代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   // ////NSLog(@"self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count=%lu",self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count);
    ////NSLog(@"self.titleMedicationArray.count=%lu",(unsigned long)self.titleMedicationArray.count);
    ////NSLog(@"self.titleAdhocArray=%lu",(unsigned long)self.titleAdhocArray.count);
    ////NSLog(@"self.timeWalkMustableArray.count>0=%d",self.timeWalkMustableArray.count>0);
    
    NSString *numberONE=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"Daily Measurement"]];
     NSString *numberTWO=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"Daily Medication"]];
    NSString *numberThree=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"Others"]];
    
    ////NSLog(@"%@,%@,%@",numberONE,numberTWO,numberThree);
    
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
                    ////NSLog(@"self.TimeWalkKustableArray.count=%lu,,,self.timeWalk=%@  ....str=%@",(unsigned long)self.timeWalkMustableArray.count,[self.timeWalkMustableArray objectAtIndex:obj],sstr);
                    
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
-(IBAction)BACKBACK:(id)sender
{
    DiaryViewController *dai=[[DiaryViewController alloc]initWithNibName:@"DiaryViewController" bundle:nil];
    
    [self.navigationController pushViewController:dai animated:YES ];
    
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
    
    
    
    InformaitionViewController *_information=[[InformaitionViewController alloc]initWithNibName:@"InformaitionViewController" bundle:nil];
    
    
    NSString *str=[[NSString alloc]init];
    for (int o=0; o<self.timeWalkMustableArray.count; o++)
    {
        str=[str stringByAppendingString:[self.timeWalkMustableArray objectAtIndex:o]];
        str=[str stringByAppendingString:@" "];
        
    }
    
    
    switch (indexPath.section) {
        case 0:
            //
            _information.str1=[Utility getStringByKey:@"Daily Measurement"];
            _information.str2 =[_measurementArray objectAtIndex:indexPath.row];
            
            if ([_information.str2 isEqualToString:[Utility getStringByKey:@"Blood Pressure"]]) {
                //
                _information._allArray=self.timeBloodMutableArray;
            }
            else if ([_information.str2 isEqualToString:[Utility getStringByKey:@"ECG"]])
            {
                _information._allArray=self.timeECGMutableArray;
                
            }
            else
            {
                _information._allArray=self.timeGlucoseMutableArray;
            }
            break;
        case 1:
            _information.str1=[Utility getStringByKey:@"Daily Medication"];
            //
            _information._array=self.titleMedicationArray;
            _information._allArray=self.timesMedicationArray;
            _information.docAgeArray=self.dosageMedicationArray;
            _information.medientID=self.medID ;
            _information.str2=[self.titleMedicationArray objectAtIndex:indexPath.row];
            _information.str3=[self.timesMedicationArray objectAtIndex:indexPath.row];
            _information.str4=[self.dosageMedicationArray objectAtIndex:indexPath.row];
            _information.imageStr=[self.imageStrMedicationArray objectAtIndex:indexPath.row];
            _information.strNote=[self.noteMedicationArray objectAtIndex:indexPath.row];
            
            ////NSLog(@"imagestr.length==%lu",(unsigned long)[_information.imageStr length]);
            _information.medWitchID=indexPath.row;
            
            _information.turntitleMedicationArray=[[NSMutableArray alloc]initWithArray:self.titleMedicationArray];
            _information.turntimesMedicationArray=[[NSMutableArray alloc]initWithArray:self.timesMedicationArray];
            _information.turnmedID=[[NSMutableArray alloc]initWithArray: self.medID];
            _information.turndosageMedicationArray=[[NSMutableArray alloc]initWithArray:self.dosageMedicationArray];
            _information.turnImageStrMedicationArray=[[NSMutableArray alloc]initWithArray:self.imageStrMedicationArray];
            _information.turnMealMedicationArray=[[NSMutableArray alloc]initWithArray:self.mealMedicationArray];
            
            _information.turnNoteMedicationArray=[[NSMutableArray alloc]initWithArray:self.noteMedicationArray];
            
            
            
            break;
        case 2:
            //
            
            _information.str1=[Utility getStringByKey:@"Others"];
            _information.str2=[self.titleAdhocArray objectAtIndex:indexPath.row];
            _information.str3=[self.adHoNote objectAtIndex:indexPath.row];
            _information.str4=[self.adDateDate objectAtIndex:indexPath.row];
            _information._timeStart=[self.startTimesArray objectAtIndex:indexPath.row];
            _information._timeEnd=[self.endTimesArray objectAtIndex:indexPath.row];
            
            _information.otherID=[self.adHocID objectAtIndex:indexPath.row];
            
            
            
            break;
        case 3:
            _information.str1=[Utility getStringByKey:@"Exercise"];
            _information.turnWalkingArray=[[NSMutableArray alloc]initWithArray:self.timeWalkMustableArray];
            _information.str2=str;
            if ([self.walkStartDate length]>5) {
                 _information.dateDateStr=self.walkStartDate;
            }
       
            
            
            break;
            
        default:
            break;
    }
    
    
    
    [self.navigationController pushViewController:_information animated:YES];
    
    
    
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
                UILabel * titleText=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 40)];
                
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                    event.title     = title;
                  
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
                    event2.title     = title;
                    
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
                    event3.title     = title;
                    
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
    
    [self cancelAnd_userCalendar];
    
    
}
-(void)cancelAnd_userCalendar
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
    
    
    
    ////NSLog(@"eventsArray=%@",events);
    for (int i=0; i<[events count]; i++) {
        
        NSString * eventSTEMP=[[NSString alloc] initWithFormat:@"%@",[[events objectAtIndex:i] title]];
        
        if ([eventSTEMP length]>12) {
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
 //   NSDate *date9 =[dateFormat1 dateFromString:self.walkStartDate];
    
    NSDateFormatter* sssdateFormat19 = [[NSDateFormatter alloc] init];
    [sssdateFormat19 setDateFormat:@"yyyy-MM-dd"];
  //  NSTimeInterval secondsPerDay19 = +(24*60*60);
  //  NSDate *tomorrow19 = [date9 dateByAddingTimeInterval:secondsPerDay19];
  //  NSString *currentDateStr1119=[sssdateFormat19 stringFromDate:tomorrow19];
    ////NSLog(@"%@",currentDateStr1119);
    
    
  //  NSTimeInterval secondsPerDay219 = (24*60*60)*2;
 //   NSDate *tomorrow219 = [date9 dateByAddingTimeInterval:secondsPerDay219];
 //   NSString *currentDateStr2219=[sssdateFormat19 stringFromDate:tomorrow219];
    ////NSLog(@"%@",currentDateStr2219);
  //
 //   NSTimeInterval secondsPerDay319 = (24*60*60)*3;
 //   NSDate *tomorrow319 = [date9 dateByAddingTimeInterval:secondsPerDay319];
 //   NSString *currentDateStr3319=[sssdateFormat19 stringFromDate:tomorrow319];
    ////NSLog(@"%@",currentDateStr3319);
//    NSTimeInterval secondsPerDay419 = (24*60*60)*4;
//    NSDate *tomorrow419 = [date9 dateByAddingTimeInterval:secondsPerDay419];
//    NSString *currentDateStr4419=[sssdateFormat19 stringFromDate:tomorrow419];
//    ////NSLog(@"%@",currentDateStr4419);
//    NSTimeInterval secondsPerDay519 = (24*60*60)*5;
//    NSDate *tomorrow519 = [date9 dateByAddingTimeInterval:secondsPerDay519];
//    NSString *currentDateStr5519=[sssdateFormat19 stringFromDate:tomorrow519];
//    ////NSLog(@"%@",currentDateStr5519);
//    NSTimeInterval secondsPerDay619 = (24*60*60)*6;
//    NSDate *tomorrow619 = [date9 dateByAddingTimeInterval:secondsPerDay619];
//    NSString *currentDateStr6619=[sssdateFormat19 stringFromDate:tomorrow619];
//    ////NSLog(@"%@",currentDateStr6619);
    
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
    
    if (subRain>current)
    {
        
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
