//
//  DayChickViewController.m
//  mHealth
//
//  Created by gz dev team on 14年7月24日.
//
//

#import "DayChickViewController.h"
#import "Utility.h"
#import "ModifyDiaryViewController.h"
#import "GlobalVariables.h"
#import "NSString+URLEncoding.h"
#import "Constants.h"
#import "Alarm.h"
#import "DBHelper.h"
#import "DiaryViewController.h"
@interface DayChickViewController ()

@end

@implementation DayChickViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"DayChickViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"DayChickViewController3.5" bundle:nibBundleOrNil];
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
    [btn_done setTitle:[Utility getStringByKey:@"Done"] forState:UIControlStateNormal];
    btn_done.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.dateDateStr);
   
    // Do any additional setup after loading the view from its nib.
    _label1.text=self.str1;
    NSLog(@"%@",self.theTime);
    NSLog(@"_label1.text=%@",_label1.text);
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
        NSLog(@"self.AllArray=%@",self._allArray);
        
        
        for (int i=0; i<[self._allArray count]; i++) {
            if ([[self._allArray objectAtIndex:i] length]>3) {
                NSString *str=[[self._allArray objectAtIndex:i] substringWithRange:NSMakeRange(0, 2)];
                NSLog(@"STR===%@  theTIme=%@",str,self.theTime);
                if ([str isEqualToString:self.theTime])
                {
                    str1=[self._allArray objectAtIndex:i];
                    
                }
            }
        }
        NSString *sum=[[NSString alloc]initWithFormat:@"%@: %@ %@",[Utility getStringByKey:@"duration_label"],self.dateDateStr,str1];
        _label3.text=sum;
        _label3.numberOfLines=2;
        _label3.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        
        _label3.backgroundColor=[UIColor clearColor];
        _label3.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:17];
        [_label3 sizeToFit];
        _label3.frame=CGRectMake(25, _label2.frame.size.height+48+10, 250, _label3.frame.size.height+5);
        _label3.frame=CGRectMake(25,  _label2.frame.size.height+40+20, 250, _label3.frame.size.height+15);
        [aView addSubview:_label3];
        
        
        
        
        
        _label4=[[UILabel alloc] initWithFrame:CGRectMake(25, _label2.frame.size.height+10+20+_label3.frame.size.height, 300, 200)];
        _label4.text=@"   ";
        
        _label4.backgroundColor=[UIColor clearColor];
        
        _label4.numberOfLines=10;
        [_label4 sizeToFit];
        [aView addSubview:_label4];
        
    }
    
    
   else if ([_label1.text isEqualToString:[Utility getStringByKey:@"Daily Medication"]]) {
       NSLog(@"str3=====%@",self.str3);
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
       float ff=[self.str3 length];
       NSLog(@"+++++++%f",ff);
       timesArray =[[NSMutableArray alloc]init];
       tikenArray =[[NSMutableArray alloc]init];
       
       if (ff>1&&ff<8) {
           //
           NSString *string = [self.str3  substringWithRange:NSMakeRange(0,5)];
           NSString *tikenStr=[self.tiken substringWithRange:NSMakeRange(0, 1)];
           [tikenArray addObject:tikenStr];
           NSLog(@"tikenSTR====%@",tikenStr );
           [timesArray addObject:string];
           NSLog(@"__%@--",string);
       }
       else if (ff>=7.0&&ff<=13)
       {
           for (int temmm=0; temmm<2; temmm++) {
               NSString *string = [self.str3  substringWithRange:NSMakeRange(0+(temmm*6),5)];
               
               NSString *tikenStr=[self.tiken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
               [tikenArray addObject:tikenStr];
               [timesArray addObject:string];
               NSLog(@"__%@--",string);
           }
           
           
       }
       else if (ff>=13.0&&ff<=19)
       {
           for (int temmm=0; temmm<3; temmm++)
           {
               NSString *string = [self.str3  substringWithRange:NSMakeRange(0+(temmm*6),5)];
               NSString *tikenStr=[self.tiken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
               [tikenArray addObject:tikenStr];
               [timesArray addObject:string];
               NSLog(@"__%@--",string);
           }
           
       }
       else if (ff>=19.0&&ff<=25)
       {
           for (int temmm=0; temmm<4; temmm++) {
               NSString *string = [self.str3  substringWithRange:NSMakeRange(0+(temmm*6),5)];
               NSString *tikenStr=[self.tiken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
               [tikenArray addObject:tikenStr];
               [timesArray addObject:string];
               NSLog(@"__%@--",string);
           }
           
       }
       else if (ff>=25.0&&ff<=31)
       {
           for (int temmm=0; temmm<5; temmm++) {
               NSString *string = [self.str3  substringWithRange:NSMakeRange(0+(temmm*6),5)];
               NSString *tikenStr=[self.tiken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
               [tikenArray addObject:tikenStr];
               NSLog(@"__%@--",string);
               [timesArray addObject:string];
               
               
           }
           
           
       }
       else if (ff>=31.0)
       {
           for (int temmm=0; temmm<6; temmm++)
           {
               NSString *string = [self.str3  substringWithRange:NSMakeRange(0+(temmm*6),5)];
               NSString *tikenStr=[self.tiken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
               [tikenArray addObject:tikenStr];
               NSLog(@"__%@--",string);
               [timesArray addObject:string];
               
           }
       }
       NSString *str1=[NSString new];
       NSString * takenStr=[NSString new];

       NSLog(@"timeARRAy=%@",timesArray);
       
       for (int i=0; i<timesArray.count; i++)
       {
           NSString *str=[[timesArray objectAtIndex:i] substringWithRange:NSMakeRange(0, 2)];
           NSLog(@"STR++++%@,,,TIMEARRAY=%@",str,[timesArray objectAtIndex:i]);
           if ([str isEqualToString:self.theTime])
           {
               
               str1=[timesArray objectAtIndex:i];
               takenStr=[tikenArray objectAtIndex:i];
           
           }
           
       }
       NSLog(@"%@.......",tikenArray);
       NSLog(@"TakenStr===%@",takenStr);
       if ([takenStr isEqualToString:@"N"]) {
            jokei=0;
           haveTiken=0;
       }
       else
       {
           jokei=1;haveTiken=1;
       }
       NSLog(@"jokei===%d,,,,takenStr=%@",jokei,takenStr);
       NSString *tempstr=[Utility getStringByKey:@"HealthReach Calendar"];
       NSString *_thenk;
       if ([tempstr isEqualToString:@"HealthReach Calendar"]) {
           _thenk=@"Taken ?";
       }
       else
       {
           _thenk=@"已服 ?";
       }
       
       NSString *sum=[[NSString alloc]initWithFormat:@"%@ %@",str1,_thenk];
       
       _label4.text=sum;
       

       
       
        _label4.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
       
        _label4.numberOfLines=2;
        _label4.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:17];
        [_label4 sizeToFit];
       
        _label4.frame=CGRectMake(25, _label2.frame.size.height+48+10,_label4.frame.size.width+25, _label4.frame.size.height+5);
        //   _label3.backgroundColor=[UIColor clearColor];
        _label4.backgroundColor=[UIColor clearColor];
       [aView addSubview:_label4];
       NSString *nbout;
       if (jokei ==0) {
           nbout=[[NSBundle mainBundle] pathForResource:@"hr_btn_checkbox_1_off" ofType:@"png"];
       }
       else
       {
           nbout=[[NSBundle mainBundle] pathForResource:@"hr_btn_checkbox_1_on" ofType:@"png"];
       }
       UIImage *image=[[UIImage alloc]initWithContentsOfFile:nbout];
       button=[UIButton buttonWithType:UIButtonTypeCustom];
       button.frame=CGRectMake(_label4.frame.size.width+25, _label2.frame.size.height+48+0 ,30, 30);
       [button setImage:image forState:UIControlStateNormal];
       [button addTarget:self action:@selector(buttonTaken) forControlEvents:UIControlEventTouchUpInside];
       [aView addSubview:button];
       
       NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:self.imageStr options:NO];
       UIImage *imageIII=[[UIImage alloc]initWithData:datetmp];
       NSLog(@"image==%@",imageIII);
       //NSLog(@"urltemp=%@",urltemp);
       ;
       
       UIImageView * imageVIewIII=[[UIImageView alloc]initWithFrame:CGRectMake(40, _label2.frame.size.height+48+30+10, 180, 120)];
       imageVIewIII.image=imageIII;
       imageVIewIII.backgroundColor=[UIColor clearColor];
       [aView addSubview:imageVIewIII];

       
       int haveImage=0;
       
       if ([self.imageStr length]>50) {
           haveImage=130;
       }
       UILabel *labelNote=[[UILabel alloc]initWithFrame:CGRectMake(25,  _label2.frame.size.height+48+10+_label4.frame.size.height+15+haveImage+10, 270, 60)];
       
       labelNote.textAlignment=NSTextAlignmentCenter;
       labelNote.text=self.strNote;
       labelNote.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
     //  labelNote.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:17];
       [labelNote sizeToFit];
       
       
       [aView addSubview:labelNote];
        //    NSLog(@"%d__________________%@",self._allArray.count,self._allArray);
        
        
        // NSLog(@"++++++++________________%d",self.turntitleMedicationArray.count);
    }
    
    
  else  if ([_label1.text isEqualToString:[Utility getStringByKey:@"Others"]]) {
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
    
   else if ([_label1.text isEqualToString:[Utility getStringByKey:@"Exercise"]]) {
       
       
       
       NSString *str1=[NSString new];
       for (int i=0; i<[self.turnWalkingArray count]; i++) {
           
           if ([[self.turnWalkingArray objectAtIndex:i] length]>3) {
               NSString *str=[[self.turnWalkingArray objectAtIndex:i] substringWithRange:NSMakeRange(0, 2)];
               if ([str isEqualToString:self.theTime])
               {
                   str1=[self.turnWalkingArray objectAtIndex:i];
                   NSLog(@"%@",str1);
                   
               }
           }
       }
       NSString *sum=[[NSString alloc]initWithFormat:@"%@: %@ %@",[Utility getStringByKey:@"duration_label"],self.dateDateStr,str1];
  
        _label2.text=sum;
        
        _label2.frame=CGRectMake(25, 48, 250, 200);
        _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:17];
        _label2.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        _label2.numberOfLines=2;
        [_label2 sizeToFit];
       
          _label2.frame=CGRectMake(25, 48, 250, _label2.frame.size.height+10);
    }    

    
}



-(void)delaydoneThread{
    if (jokei==1&&haveTiken==0) {
        
        NSLog(@"tikenArray=%@",tikenArray);
        NSString *sumtiken=[[NSString alloc]init];
        NSString *sumTIme=[NSString new];
        for (int i=0; i<tikenArray.count; i++) {
            NSString *temp;
            if (i==theNUMBERTiken) {
                temp=[[NSString alloc]initWithFormat:@"Y "];
                sumTIme=[timesArray objectAtIndex:i];
            }
            else
            {
                temp=[[NSString alloc]initWithFormat:@"%@ ",[tikenArray objectAtIndex:i]];
            }
            sumtiken=[sumtiken stringByAppendingString:temp];
        }
        NSLog(@"sumtiken==%@",sumtiken);
        NSLog(@"self.ididid=%@",self.ididid);
        Alarm* alarm=[[Alarm alloc]initWithMedicationId:self.ididid Title:nil Meal:nil DosAge:nil Servertime:nil ReminderTime:nil ReminderID:nil ReminderType:nil ReminderRepeat:nil ReminderTicken:sumtiken ReminderCreateTime:@"" ReminderserverTime:nil ReminderImageString:nil Note:@""] ;
        [DBHelper UPDateTakenMedication:alarm];
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd "];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        NSString *succAll=[[NSString alloc]initWithFormat:@"%@%@",currentDateStr,sumTIme];
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSLog(@"session_id=%@",session_id);
        NSLog(@"login_id=%@",login_id);
        NSString *url_string = [[NSString alloc]init];
        //  url_string = [url_string stringByAppendingString:apiBaseURL];
        url_string = [url_string stringByAppendingString:@"login="];
        url_string = [url_string stringByAppendingString:login_id];
        url_string = [url_string stringByAppendingString:@"&sessionid="];
        url_string = [url_string stringByAppendingString:session_id];
        url_string = [url_string stringByAppendingString:@"&action=AM"];
        url_string = [url_string stringByAppendingString:@"&recordtime="];
        url_string = [url_string stringByAppendingString:succAll];
        
        
        NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
        NSLog(@"Weight sending url:%@",url_string);
        
        NSURL *request_url = [NSURL URLWithString:encodedString];
        
        NSLog(@"request_url:%@",encodedString);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        NSData *requestData = [ NSData dataWithBytes: [ [url_string encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
        [request setHTTPBody:requestData];
        NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
        NSLog(@"%@+_+_+_",ionaSr);
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue currentQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   
                                   if (data != nil && error == nil)
                                   {
                                       //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                       // It worked, your source HTML is in sourceHTML
                                       
                                       NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                       
                                       NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
                                       
                                   }
                                   else
                                   {
                                       // There was an error, alert the user
                                   }
                                   
                               }];
        
        
    }
    DiaryViewController *daia=[[DiaryViewController alloc]initWithNibName:@"DiaryViewController" bundle:nil];
    [self.navigationController pushViewController:daia animated:YES];

    
    [btn_done setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p1.png"] forState:UIControlStateNormal];
}


-(IBAction)done:(id)sender
{
    [btn_done setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    
    [self performSelector:@selector(delaydoneThread) withObject:nil afterDelay:0.1];

    
    
    
    
    
    
}

-(IBAction)Back:(id)sender
{

    DiaryViewController *daia=[[DiaryViewController alloc]initWithNibName:@"DiaryViewController" bundle:nil];
    [self.navigationController pushViewController:daia animated:YES];
}

-(void)delayaddReminderThread{
    NSLog(@"(((");
    ModifyDiaryViewController*modify=[[ModifyDiaryViewController alloc]initWithNibName:@"ModifyDiaryViewController" bundle:nil];
    modify.hendStr=_label1.text;
    if ([modify.hendStr isEqualToString:[Utility getStringByKey:@"Daily Measurement"]]) {
        //
        modify.bpBgECG=self.str2;
        modify._turnArray=self._allArray;
        
        
        
    }
    if ([modify.hendStr isEqualToString:[Utility getStringByKey:@"Daily Medication"]]) {
        
        
        
        
        modify.turntitleMedicationText=self.str2;
        modify.turntimesMedicationText=self.str3;
        modify.turnmedIDText=[self.medientID objectAtIndex:self.medWitchID];
        modify.turndosageMedicationText=self.str4;
        modify.medWitchID =self.medWitchID;
        modify.imageStr=self.imageStr;
        modify.turnMealMedicationText=[self.turnMealMedicationArray objectAtIndex:self.medWitchID];
        modify.turnNoteMedicationText=self.strNote;
        modify.turntimesMedicationArray=[[NSMutableArray alloc]initWithArray:self.turntimesMedicationArray];
        
        modify.turntitleMedicationArray=[[NSMutableArray alloc]initWithArray:self.turntitleMedicationArray];
        modify.turnmedID=[[NSMutableArray alloc]initWithArray:self.turnmedID];
        modify.turndosageMedicationArray=[[NSMutableArray alloc]initWithArray:self.turndosageMedicationArray];
        modify.turnMealMedicationArray=[[NSMutableArray alloc]initWithArray:self.turnMealMedicationArray];
        modify.turnImageStrMedicationArray=[[NSMutableArray alloc]initWithArray:self.turnImageMedicationArray];
        modify.turnNoteMedicationArray=[[NSMutableArray alloc]initWithArray:self.turnNoteMedicationArray];
        
    }
    if ([modify.hendStr isEqualToString:[Utility getStringByKey:@"Others"]]) {
        modify.turnOtherTitle=self.str2;
        modify.turnOtherNote=self.str3;
        modify.turnOtherStartTime=self._timeStart;
        modify.turnOtherEndTime=self._timeEnd;
        modify.turnOtherID=self.otherID;
        modify.turnOtherDateDate=self.str4;
        
        
    }
    if ([modify.hendStr isEqualToString:[Utility getStringByKey:@"Exercise"]]) {
        
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

    
   
    

}
-(void)buttonTaken
{
    if (jokei==0&&haveTiken==0) {
        for (int i=0; i<timesArray.count; i++)
        {
            NSString *str=[[timesArray objectAtIndex:i] substringWithRange:NSMakeRange(0, 2)];
            if ([str isEqualToString:self.theTime])
            {
            theNUMBERTiken=i;
                
            }
            
        }
        NSString *nbout=[[NSBundle mainBundle] pathForResource:@"hr_btn_checkbox_1_on" ofType:@"png"];
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:nbout];
        [button setImage:image forState:UIControlStateNormal];
        jokei=1;
    }
    else if(jokei==1&&haveTiken==0)
    {
        NSString *nbout=[[NSBundle mainBundle] pathForResource:@"hr_btn_checkbox_1_off" ofType:@"png"];
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:nbout];
        [button setImage:image forState:UIControlStateNormal];
        jokei=0;
    }
    else
    {
        NSLog(@"_______________已經吃藥了");
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
