//
//  InformaitionViewController.m
//  mHealth
//
//  Created by gz dev team on 14年3月25日.
//
//

#import "InformaitionViewController.h"
#import "HomeViewController.h"
#import "AddReminderViewController.h"
#import "MR_ListViewController.h"
#import "ModifyDiaryViewController.h"
#import "Utility.h"
#import <EventKit/EventKit.h>
@interface InformaitionViewController ()

@end

@implementation InformaitionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"InformaitionViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"InformaitionViewController3.5" bundle:nibBundleOrNil];
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
    [btn_edit setTitle:[Utility getStringByKey:@"Edit"] forState:UIControlStateNormal];
    btn_edit.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _label1.text=self.str1;
    
           if ([_label1.text isEqualToString:[Utility getStringByKey:@"Daily Measurement"]])
        {
               _label2.text=self.str2;
            if ([_label2.text isEqualToString:[Utility getStringByKey:@"Blood Pressure"]]) {
                _label2.textColor =[UIColor redColor];
            }
            if ([_label2.text isEqualToString:[Utility getStringByKey:@"ECG"]]) {
                _label2.textColor=[UIColor orangeColor];
            }
            if ([_label2.text isEqualToString:[Utility getStringByKey:@"Blood Glucose"]]) {
                _label2.textColor=[UIColor purpleColor];
            }
            _label2.frame=CGRectMake(25, 48, 200, 200);
           
            _label2.numberOfLines=10;
            _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20];
            [_label2 sizeToFit];
            
            _label2.frame=CGRectMake(25, 48, 250, _label2.frame.size.height+5);
            
            _label3=[[UILabel alloc] initWithFrame:CGRectMake(25, _label2.frame.size.height+40+30, 250, 100)];
            
            NSString *str1=[NSString new];
            for (int i=0; i<[self._allArray count]; i++) {
                NSString *tempStr=[[NSString alloc]initWithFormat:@"%@  ",[self._allArray objectAtIndex:i]];
                str1=[str1 stringByAppendingString:tempStr];
            }
            _label3.text=str1;
            _label3.numberOfLines=2;
            _label3.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
           
            _label3.backgroundColor=[UIColor clearColor];
             _label3.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:26];
             [_label3 sizeToFit];
            _label3.frame=CGRectMake(25, _label2.frame.size.height+48+10, 250, _label3.frame.size.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       height+5);
            _label3.frame=CGRectMake(25,  _label2.frame.size.height+40+10, 250, _label3.frame.size.height+5);
            [aView addSubview:_label3];
            
           
            
      
            
            _label4=[[UILabel alloc] initWithFrame:CGRectMake(25, _label2.frame.size.height+10+20+_label3.frame.size.height, 300, 200)];
            _label4.text=@"   ";
            
            _label4.backgroundColor=[UIColor clearColor];
            
            _label4.numberOfLines=10;
            [_label4 sizeToFit];
            [aView addSubview:_label4];
            
        }
        
        
        if ([_label1.text isEqualToString:[Utility getStringByKey:@"Daily Medication"]]) {

             NSString *tempLabel3Text=[[NSString alloc]initWithFormat:@"%@ ( %@ )",self.str2,self.str4];
               _label2.frame=CGRectMake(25, 48, 200, 200);
            _label2.text=tempLabel3Text;
            _label2.textColor=[UIColor colorWithRed:41/255.0 green:137/255.0 blue:173/255.0 alpha:1];
      
            _label2.numberOfLines = 30;
                _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
            [_label2 sizeToFit];
            _label2.frame=CGRectMake(25, 48, 250, _label2.frame.size.height+5);
    
//            _label3=[[UILabel alloc] initWithFrame:CGRectMake(_label2.frame.size.width+30,45, 200, 100)];
//            NSString*tempLabel3Text=[[NSString alloc]initWithFormat:@"%@ ( %@ )",self.str4];
//            _label3.text=tempLabel3Text;
//            _label3.textColor=[UIColor colorWithRed:41/255.0 green:137/255.0 blue:173/255.0 alpha:1];
//            _label3.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
//              _label3.numberOfLines = 30;
//            
//            [_label3 sizeToFit];
//                  [aView addSubview:_label3];
        
            _label4=[[UILabel alloc]initWithFrame:CGRectMake(25,_label2.frame.size.height+48+10, 250, 100)];
            _label4.text=self.str3;
            
            _label4.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
          
            _label4.numberOfLines=2;
                  _label4.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:26];
            [_label4 sizeToFit];
        
            _label4.frame=CGRectMake(25, _label2.frame.size.height+48+10, 250, _label4.frame.size.height+5);
         //   _label3.backgroundColor=[UIColor clearColor];
            _label4.backgroundColor=[UIColor clearColor];
                  [aView addSubview:_label4];
        //    NSLog(@"%d__________________%@",self._allArray.count,self._allArray);
            
            
           // NSLog(@"++++++++________________%d",self.turntitleMedicationArray.count);
      NSLog(@"se.imageStr=%@",self.imageStr);
            
            //NSURL *urltemp=[NSURL URLWithString:self.imageStr];
             NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:self.imageStr options:NO];
            UIImage *image=[[UIImage alloc]initWithData:datetmp];
      NSLog(@"image==%@",image);
            //NSLog(@"urltemp=%@",urltemp);
          ;
                      
            UIImageView * imageVIew=[[UIImageView alloc]initWithFrame:CGRectMake(40,  _label2.frame.size.height+48+10+_label4.frame.size.height+15, 180, 120)];
            imageVIew.image=image;
            imageVIew.backgroundColor=[UIColor clearColor];
            [aView addSubview:imageVIew];
            
            int haveImage=0;
            
            if ([self.imageStr length]>50) {
                haveImage=130;
            }
            
            UILabel *labelNote=[[UILabel alloc]initWithFrame:CGRectMake(25,  _label2.frame.size.height+48+10+_label4.frame.size.height+15+haveImage+10, 270, 60)];
            
          
            labelNote.text=self.strNote;
            labelNote.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        
            [labelNote sizeToFit];
              labelNote.textAlignment=NSTextAlignmentCenter;

            [aView addSubview:labelNote];
            
        }
        
    
        if ([_label1.text isEqualToString:[Utility getStringByKey:@"Others"]]) {
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
            
        }
    
    if ([_label1.text isEqualToString:[Utility getStringByKey:@"Exercise"]]) {
        _label2.text=self.str2;
        
           _label2.frame=CGRectMake(25, 48, 260, 200);
        _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:26];
        _label2.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        _label2.numberOfLines=10;
        [_label2 sizeToFit];

    }

    
    

   
    


    



    // Do any additional setup after loading the view from its nib.
}
-(IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)GoHome:(id)sender
{
//    HomeViewController *homeView=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//    [self.navigationController pushViewController:homeView animated:YES];
    [self backToHome];
}



-(void)delayaddReminderThread{
    ModifyDiaryViewController*modify=[[ModifyDiaryViewController alloc]initWithNibName:@"ModifyDiaryViewController" bundle:nil];
    modify.hendStr=_label1.text;
    if ([modify.hendStr isEqualToString:[Utility getStringByKey:@"Daily Measurement"]]) {
        //
        modify.bpBgECG=self.str2;
        modify._turnArray=self._allArray;
        modify.imageStr=@"";
        
        
    }
    if ([modify.hendStr isEqualToString:[Utility getStringByKey:@"Daily Medication"]]) {
        modify.turntitleMedicationText=self.str2;
        modify.turntimesMedicationText=self.str3;
        modify.turnmedIDText=[self.medientID objectAtIndex:self.medWitchID];
        modify.turndosageMedicationText=self.str4;
        modify.medWitchID =self.medWitchID;
        modify.turnMealMedicationText=[self.turnMealMedicationArray objectAtIndex:self.medWitchID];
        
        modify.turntimesMedicationArray=[[NSMutableArray alloc]initWithArray:self.turntimesMedicationArray];
        
        modify.turntitleMedicationArray=[[NSMutableArray alloc]initWithArray:self.turntitleMedicationArray];
        modify.turnmedID=[[NSMutableArray alloc]initWithArray:self.turnmedID];
        modify.turndosageMedicationArray=[[NSMutableArray alloc]initWithArray:self.turndosageMedicationArray];
        modify.turnMealMedicationArray=[[NSMutableArray alloc]initWithArray:self.turnMealMedicationArray];
        
        modify.imageStr=self.imageStr;
        
        modify.turnImageStrMedicationArray=[[NSMutableArray alloc]initWithArray:self.turnImageStrMedicationArray];
        
        
        modify.turnNoteMedicationArray =[[NSMutableArray alloc]initWithArray:self.turnNoteMedicationArray];
        modify.turnNoteMedicationText=self.strNote;
        
    }
    if ([modify.hendStr isEqualToString:[Utility getStringByKey:@"Others"]]) {
        modify.turnOtherTitle=self.str2;
        modify.turnOtherNote=self.str3;
        modify.turnOtherStartTime=self._timeStart;
        modify.turnOtherEndTime=self._timeEnd;
        modify.turnOtherID=self.otherID;
        modify.turnOtherDateDate=self.str4;
        modify.imageStr=@"";
        
    }
    if ([modify.hendStr isEqualToString:[Utility getStringByKey:@"Exercise"]])
    {
        modify.imageStr=@"";
    }
    
    modify.dataStr= self.dateDateStr;
    modify.turnWalkingArray=[[NSMutableArray alloc]initWithArray:self.turnWalkingArray];
    [self.navigationController pushViewController:modify animated:YES];
    
    
    [btn_edit setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p1.png"] forState:UIControlStateNormal];
}

-(IBAction)addReminder:(id)sender
{
    
    [btn_edit setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    
    [self performSelector:@selector(delayaddReminderThread) withObject:nil afterDelay:0.1];

    
    
    //
    
 
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)saveEvent:(id)sender {
    
    
    
    //事件市场
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
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
                    event.title     = @"哈哈哈，我是日历事件啊";
                    event.location = @"我在杭州西湖区留和路";
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = [[NSDate alloc]init ];
                    event.endDate   = [[NSDate alloc]init ];
                    event.allDay = YES;
                    
                    //添加提醒
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"Event Created"
                                          message:@"Yay!?"
                                          delegate:nil
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
                    [alert show];
                    
                    NSLog(@"保存成功");
                    
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
        event.title     = @"哈哈哈，我是日历事件啊";
        event.location = @"我在杭州西湖区留和路";
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
        [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        
        event.startDate = [[NSDate alloc]init ];
        event.endDate   = [[NSDate alloc]init ];
        event.allDay = YES;
        
        
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Event Created"
                              message:@"Yay!?"
                              delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"保存成功");
        
    }
}
@end
