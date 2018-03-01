//
//  MedicationAlapk.m
//  mHealth
//
//  Created by gz dev team on 14年9月17日.
//
//

#import "MedicationAlapk.h"
#import "Utility.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "NSString+URLEncoding.h"
#import "DBHelper.h"
#import "Alarm.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "TKAlertCenter.h"
#import "NotiMR_ListViewController.h"
#import "MR_ListViewController.h"
#import "syncUtility.h"

@interface MedicationAlapk ()

@end

@implementation MedicationAlapk

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"MedicationAlapk" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"MedicationAlapk3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self textFontText];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
   
    sessionidStrStr=[defaults objectForKey:@"sessionid"];
    loinIdStrStr=[defaults objectForKey:@"login"];

    
    
    
    
}
-(void)textFontText
{
    aaaView.hidden=YES;
    aView.hidden=NO;
    [hendLabelFont setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    hendLabelFont.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [_label1 setText:[Utility getStringByKey:@"Daily Medication"]];
    _label1.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
        [btn_done setTitle:[Utility getStringByKey:@"Done"] forState:UIControlStateNormal];
    btn_done.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [goToCalendar setTitle:[Utility getStringByKey:@"Done and go to Calendar"] forState:UIControlStateNormal];
    goToCalendar.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:15];
    [msehsHandTextFont setText:[Utility getStringByKey:@"Events Summary"]];
    msehsHandTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [addEventButton setTitle:[Utility getStringByKey:@"Add Event"] forState:UIControlStateNormal];
    addEventButton.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
        gohomeBUtton.hidden=NO;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSLog(@"--%@",self.medicationDic);

    
    _littleBackguandView.layer.cornerRadius = 12;//设置那个圆角的有多圆
    helthIcon.layer.cornerRadius = 12;//设置那个圆角的有多圆
    backGuangView.hidden=NO;
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

    [other_backguand setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20]];
    other_backguand.text=self.str1;

 
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    theTimeNOW=[[NSString alloc]initWithString:currentDateStr];
    NSMutableArray *titleArray=[self.medicationDic objectForKey:@"me_title"];
    
     NSMutableArray *_timesArray=[self.medicationDic objectForKey:@"times"];
    
     NSMutableArray *idArray=[self.medicationDic objectForKey:@"id"];
    
    
    NSMutableArray *dosageArray=[self.medicationDic objectForKey:@"dosage"];
    
    NSMutableArray *theTiken=[self.medicationDic objectForKey:@"ticken"];

    NSMutableArray *noteArray=[self.medicationDic objectForKey:@"me_note"];
    
    
    NSLog(@"ID===%@",idArray);
    
    
    
    NSString *tempLabel3Text;

    

    _label2.frame=CGRectMake(25, 48, 200, 200);
    
    _label2.textColor=[UIColor colorWithRed:41/255.0 green:137/255.0 blue:173/255.0 alpha:1];
    
    NSString *tempNote;
    
    for (int i=0; i<titleArray.count; i++)
    {
        if ([self.str1 isEqualToString:[titleArray objectAtIndex:i]])
        {
            self.ididid=[idArray objectAtIndex:i];
            NSString *tempAll=[_timesArray objectAtIndex:i];
            NSLog(@"tempALL=%@",tempAll);
            tempLabel3Text=[[NSString alloc]initWithFormat:@"%@ ( %@ )",self.str1,[dosageArray objectAtIndex:i]];
            _label2.text=tempLabel3Text;
            _label2.numberOfLines = 30;
            _label2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
            [_label2 sizeToFit];
            _label2.frame=CGRectMake(25, 48, 250, _label2.frame.size.height+5);
            float ff=[tempAll lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
            NSLog(@"+++++++%f",ff);
            
            
            
     
            
            
            
           tempNote=[noteArray objectAtIndex:i];
            
            NSString *tempTicken=[theTiken objectAtIndex:i];
            
            
            
            timesArray =[[NSMutableArray alloc]init];
                tikenArray =[[NSMutableArray alloc]init];
            
            if (ff>1&&ff<7) {
                //
                NSString *string = [tempAll  substringWithRange:NSMakeRange(0,5)];
                NSString *tikenStr;
                if ([tempTicken length]>0) {
                    tikenStr =[tempTicken substringWithRange:NSMakeRange(0, 1)];
                }
             else
             {
                 tikenStr =@"N";
             }
                [tikenArray addObject:tikenStr];
                [timesArray addObject:string];
                NSLog(@"__%@--",string);
            }
            else if (ff>=7.0&&ff<=13)
            {
                for (int temmm=0; temmm<2; temmm++) {
                    NSString *string = [tempAll substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    
                    NSString *tikenStr;
                    if ([tempTicken length]>2) {
                        tikenStr= [tempTicken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                    }
                    else
                    {
                        tikenStr =@"N";
                    }
                    [tikenArray addObject:tikenStr];
                    [timesArray addObject:string];
                    NSLog(@"__%@--",string);
                }
                
                
            }
            else if (ff>=13.0&&ff<=19)
            {
                for (int temmm=0; temmm<3; temmm++)
                {
                    NSString *string = [tempAll  substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    NSString *tikenStr;
                    if ([tempTicken length]>4) {
                        tikenStr= [tempTicken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                    }
                    else
                    {
                        tikenStr =@"N";
                    }
                    [tikenArray addObject:tikenStr];
                    [timesArray addObject:string];
                    NSLog(@"__%@--",string);
                }
                
            }
            else if (ff>=19.0&&ff<=25)
            {
                for (int temmm=0; temmm<4; temmm++) {
                    NSString *string = [tempAll substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    NSString *tikenStr;
                    if ([tempTicken length]>6) {
                        tikenStr= [tempTicken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                    }
                    else
                    {
                        tikenStr =@"N";
                    }
                    [tikenArray addObject:tikenStr];
                    [timesArray addObject:string];
                    NSLog(@"__%@--",string);
                }
                
            }
            else if (ff>=25.0&&ff<=31)
            {
                for (int temmm=0; temmm<5; temmm++) {
                    NSString *string = [tempAll substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    NSString *tikenStr;
                    if ([tempTicken length]>8) {
                        tikenStr= [tempTicken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                    }
                    else
                    {
                        tikenStr =@"N";
                    }
                    [tikenArray addObject:tikenStr];
                    NSLog(@"__%@--",string);
                    [timesArray addObject:string];
                    
                    
                }
                
                
            }
            else if (ff>=31.0)
            {
                for (int temmm=0; temmm<6; temmm++)
                {
                    NSString *string = [tempAll substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    NSString *tikenStr;
                    if ([tempTicken length]>10) {
                        tikenStr= [tempTicken substringWithRange:NSMakeRange(0+(temmm*2), 1)];
                    }
                    else
                    {
                        tikenStr =@"N";
                    }
                    [tikenArray addObject:tikenStr];
                    NSLog(@"__%@--",string);
                    [timesArray addObject:string];
                    
                }
            }
        }
        
        
        
    }
    _label4=[[UILabel alloc]init];
    NSString *str1=[NSString new];
    NSString *takenStr=[NSString new];
    for (int i=0; i<timesArray.count; i++)
    {
        NSString *str=[timesArray objectAtIndex:i ];
        if ([str isEqualToString:currentDateStr])
        {
            str1=[timesArray objectAtIndex:i];
              takenStr=[tikenArray objectAtIndex:i];
        }
        else
        {
            str1=currentDateStr;
        }
        
    }
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
    
    _label4.frame=CGRectMake(25, _label2.frame.size.height+48+10, _label4.frame.size.width+25, _label4.frame.size.height+5);
    //   _label3.backgroundColor=[UIColor clearColor];
    _label4.backgroundColor=[UIColor clearColor];
    [aView addSubview:_label4];
    
    
    NSString * imageStr=[self.medicationDic objectForKey:@"me_image"];
    NSLog(@"imageStr=%@",imageStr);
    NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:imageStr options:NO];
    NSLog(@"DateTmp=%@",datetmp);
    UIImage *imageM=[[UIImage alloc]initWithData:datetmp];
    NSLog(@"ImageMMMMMM=%@",imageM);
    UIImageView *imageViewM=[[UIImageView alloc] initWithImage:imageM];
    imageViewM.frame=CGRectMake(40, _label2.frame.size.height+48+10+30, 180, 120);
    
    if ([imageStr length]>20) {
        medicadionImagePhotoVIew.image=imageM;
        medicadionImagePhotoVIew.hidden=NO;
        other_backguand.frame=CGRectMake(60+60+10, 108, 100, 41);
        other_backguand.textAlignment=NSTextAlignmentLeft;
        
    }
    else
    {
        medicadionImagePhotoVIew.hidden=YES;
        other_backguand.frame=CGRectMake(28, 108, 225, 41);
        other_backguand.textAlignment=NSTextAlignmentCenter;
        
    }
    [aView addSubview:imageViewM];
    
    int haveImage=0;
    
    if ([imageStr length]>50) {
        haveImage=130;
    }
    UILabel *labelNote=[[UILabel alloc]initWithFrame:CGRectMake(25,  _label2.frame.size.height+48+10+_label4.frame.size.height+15+haveImage+10, 270, 60)];
    
    labelNote.textAlignment=NSTextAlignmentCenter;
    labelNote.text=tempNote;
    labelNote.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    //  labelNote.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:17];
    [labelNote sizeToFit];
    
    
    [aView addSubview:labelNote];
    NSString *nbout=[[NSBundle mainBundle] pathForResource:@"hr_btn_checkbox_1_off" ofType:@"png"];
    UIImage *image=[[UIImage alloc]initWithContentsOfFile:nbout];
    
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame=CGRectMake(_label4.frame.size.width+25, _label2.frame.size.height+48+0 ,30, 30);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTaken) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:button];
    
    jokei=0;
    
    
    
      
    
    
    
    
    
    
    
    
    
//    
//    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
//// self.dateDateStr= currentDateStr;
    
    
    self.titleMedicationArray=[self.medicationDic objectForKey:@"me_title"];
    self.timesMedicationArray=[self.medicationDic objectForKey:@"times"];
    self.dosageMedicationArray=[self.medicationDic objectForKey:@"dosage"];
    
    
    self.timeBloodMutableArray=[self.medicationDic objectForKey:@"bptime"];
    
    self.timeECGMutableArray=[self.medicationDic objectForKey:@"ecgtime"];
    
    self.timeGlucoseMutableArray=[self.medicationDic objectForKey:@"bgtime"];
    
    self.timeWalkMustableArray=[self.medicationDic objectForKey:@"walktime"];
    
    self.titleAdhocArray=[self.medicationDic objectForKey:@"others_title"];
    self.startTimesArray=[self.medicationDic objectForKey:@"others_starttime"];
    self.endTimesArray=[self.medicationDic objectForKey:@"others_endtime"];
    self.adHoNote=[self.medicationDic objectForKey:@"others_note"];
    self.adDateDate=[self.medicationDic objectForKey:@"others_date"];
    
    
    
    
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
    
    
    
    
    //NSLog(@"self.BPcount====%d,self.ECGcount===%d,self.BGcount===%d",self.timeBloodMutableArray.count,self.timeECGMutableArray.count,self.timeGlucoseMutableArray.count);
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    // Do any additional setup after loading the view from its nib.
}

-(void)addButtonYes
{
    NSArray *array =[NSArray arrayWithObjects:@"",@"", nil];
    NSString * str = [array objectAtIndex:3];
    NSLog(@"%@",str);
    
    
    
    
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
                NSString *sumDay=[[NSString alloc]initWithFormat:@"%@ %@",timeStrRain111,allTheDay];
                
                
                
                
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
//表头的代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   // NSLog(@"self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count=%d",self.timeBloodMutableArray.count+self.timeECGMutableArray.count+self.timeGlucoseMutableArray.count);
   // NSLog(@"self.titleMedicationArray.count=%d",self.titleMedicationArray.count);
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
                  //  NSLog(@"self.TimeWalkKustableArray.count=%d,,,self.timeWalk=%@  ....str=%@",self.timeWalkMustableArray.count,[self.timeWalkMustableArray objectAtIndex:obj],sstr);
                    
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

-(void)buttonTaken
{
    if (jokei==0) {
        for (int i=0; i<timesArray.count; i++)
        {
            NSString *str=[timesArray objectAtIndex:i];
            if ([str isEqualToString:theTimeNOW])
            {
                theNUMBERTiken=i;
                
            }
            
        }
        NSString *nbout=[[NSBundle mainBundle] pathForResource:@"hr_btn_checkbox_1_on" ofType:@"png"];
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:nbout];
        [button setImage:image forState:UIControlStateNormal];
        jokei=1;
   
        
    }
    else
    {
        NSString *nbout=[[NSBundle mainBundle] pathForResource:@"hr_btn_checkbox_1_off" ofType:@"png"];
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:nbout];
        [button setImage:image forState:UIControlStateNormal];
        jokei=0;
        
    }

    
}
-(IBAction)addEvent:(id)sender
{
    
    
    if (jokei==1) {
        
        
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
        Alarm* alarm=[[Alarm alloc]initWithMedicationId:self.ididid Title:nil Meal:nil DosAge:nil Servertime:nil ReminderTime:nil ReminderID:nil ReminderType:nil ReminderRepeat:nil ReminderTicken:sumtiken ReminderCreateTime:@"" ReminderserverTime:nil ReminderImageString:@"" Note:@""];
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
        
        NSURL *request_url = [NSURL URLWithString:encodedString];
        
        
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
                                       
                                       
                                       
                                       DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
                                       
                                       static NSString *responseFlag = @"//errorcode";
                                       NSArray *errorRecord = [doc nodesForXPath:responseFlag error:nil];
                                       
                                       NSLog(@"errorRecord:%@ count:%lu isnull:%@",errorRecord,(unsigned long)[errorRecord count],[errorRecord lastObject]);
                                       if ([errorRecord count]>0) {
                                           
                                           NSString *error=((DDXMLElement*)[errorRecord lastObject]).stringValue;
                                           if (error!=nil) {
                                               if ([error isEqualToString:@"INVALID_SESSION"]) {
                                                   
                                                   //back to login page.....
                                                   
                                                   @try {
                                                       
                                                       [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"invalid_session"]];
                                                   }
                                                   @catch (NSException *exception) {
                                                       
                                                   }
                                                   @finally {
                                                       
                                                   }
                                                   
                                                   [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
                                                   [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
                                                   
                                                   [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
                                               }
                                           }
                                       }
                                       
                                       
                                       
                                   }
                                   else
                                   {
                                       // There was an error, alert the user
                                       @try {
                                           
                                           [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"invalid_session"]];
                                       }
                                       @catch (NSException *exception) {
                                           
                                       }
                                       @finally {
                                           
                                       }
                                       
                                       
                                       
                                   }
                                   
                               }];
        
        
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
        
        
        
    }else{
        
        
        
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
        
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
        
    }

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
-(IBAction)done:(id)sender
{
    
    float  idlength=[[GlobalVariables shareInstance].session_id length];
    NSLog(@"idlenggt======================%f-------------",idlength);
    if (idlength >=8)  //
    {
        
        NSLog(@"idlenggt=====================<8=%f-------------",idlength);

        if (jokei==1) {
            
            
            NSLog(@"tikenArray=%@",tikenArray);
            NSString *sumtiken=[[NSString alloc]init];
            NSString *sumTIme=[NSString new];
            for (int i=0; i<tikenArray.count; i++)
            {
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
            Alarm* alarm=[[Alarm alloc]initWithMedicationId:self.ididid Title:nil Meal:nil DosAge:nil Servertime:nil ReminderTime:nil ReminderID:nil ReminderType:nil ReminderRepeat:nil ReminderTicken:sumtiken ReminderCreateTime:@"" ReminderserverTime:nil ReminderImageString:@"" Note:@""];
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
            
            NSURL *request_url = [NSURL URLWithString:encodedString];
            
            
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
                                           
                                           
                                           
                                           DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
                                           
                                           static NSString *responseFlag = @"//errorcode";
                                           NSArray *errorRecord = [doc nodesForXPath:responseFlag error:nil];
                                           
                                           NSLog(@"errorRecord:%@ count:%lu isnull:%@",errorRecord,(unsigned long)[errorRecord count],[errorRecord lastObject]);
                                           if ([errorRecord count]>0) {
                                               
                                               NSString *error=((DDXMLElement*)[errorRecord lastObject]).stringValue;
                                               if (error!=nil) {
                                                   if ([error isEqualToString:@"INVALID_SESSION"]) {
                                                       
                                                       //back to login page.....
                                                       
                                                       @try {
                                                           
                                                           [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"invalid_session"]];
                                                       }
                                                       @catch (NSException *exception) {
                                                           
                                                       }
                                                       @finally {
                                                           
                                                       }
                                                         [self.navigationController popViewControllerAnimated:YES];
//                                                       [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
//                                                       [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
//                                                       
//                                                       [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
                                                   }
                                               }
                                           }
                                           
                                           
                                           
                                       }
                                       else
                                       {
                                           // There was an error, alert the user
                                           @try {
                                               
                                               [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"invalid_session"]];
                                           }
                                           @catch (NSException *exception) {
                                               
                                           }
                                           @finally {
                                               
                                           }
                                           
                                           
                                           
                                       }
                                       
                                   }];
            
            
//            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
//            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
            
            
//              [self.navigationController popViewControllerAnimated:YES];
        }
//        }else{
//            
//            
//            
////            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
////            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
////            
////            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        [self.navigationController popViewControllerAnimated:YES];
        
        NSArray * array=[[NSArray alloc]initWithObjects:@"",@"", nil];
        NSString *rir=[array objectAtIndex:3];
        NSLog(@"%@",rir);
        
    }
    else
    {
        NSLog(@"idlenggt==========>8============%f-------------",idlength);

        if (jokei==1)
        {
            
            
            NSLog(@"tikenArray=%@",tikenArray);
            NSString *sumtiken=[[NSString alloc]init];
            NSString *sumTIme=[NSString new];
            for (int i=0; i<tikenArray.count; i++)
            {
                NSString *temp;
                
                if (i==theNUMBERTiken)
                {
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
        
            
              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSMutableArray *arrayMedicationTikenID=[[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"Medication tiken id Array"]];
            [arrayMedicationTikenID addObject:self.ididid];
            
            NSMutableArray *arrayMedicationtiken=[[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"Medication tiken Array"]];
            
            [arrayMedicationtiken addObject:sumtiken];
            
            [defaults setObject:arrayMedicationTikenID forKey:@"Medication tiken id Array"];
            [defaults setObject:arrayMedicationtiken forKey:@"Medication tiken Array"];
            [defaults synchronize];
            
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
            url_string = [url_string stringByAppendingString:loinIdStrStr];
            url_string = [url_string stringByAppendingString:@"&sessionid="];
            url_string = [url_string stringByAppendingString:sessionidStrStr];
            url_string = [url_string stringByAppendingString:@"&action=AM"];
            url_string = [url_string stringByAppendingString:@"&recordtime="];
            url_string = [url_string stringByAppendingString:succAll];
            
            
            NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
            
            NSURL *request_url = [NSURL URLWithString:encodedString];
            
            
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
                                           
                                           
                                           
                                           DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
                                           
                                           static NSString *responseFlag = @"//errorcode";
                                           NSArray *errorRecord = [doc nodesForXPath:responseFlag error:nil];
                                           
                                           NSLog(@"errorRecord:%@ count:%lu isnull:%@",errorRecord,(unsigned long)[errorRecord count],[errorRecord lastObject]);
                                           
                                           NSLog(@"hhhhhh--------------");
                                           NSArray * array=[[NSArray alloc]initWithObjects:@"",@"", nil];
                                           NSString *rir=[array objectAtIndex:3];
                                           NSLog(@"%@--------------",rir);
                                           if ([errorRecord count]>0) {
                                               
                                               NSString *error=((DDXMLElement*)[errorRecord lastObject]).stringValue;
                                               if (error!=nil) {
                                                   if ([error isEqualToString:@"INVALID_SESSION"]) {
                                                       
                                                       //back to login page.....
                                                       
                                                       @try {
                                                           
                                                           [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"invalid_session"]];
                                                       }
                                                       @catch (NSException *exception) {
                                                           
                                                       }
                                                       @finally {
                                                           
                                                       }
//                                                       
//                                                       [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
//                                                       [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
//                                                       
//                                                       [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
                                               
                                                       
                                                   }
                                               }
                                           }
                                           
                                           
                                           
                                       }
                                       else
                                       {
                                           // There was an error, alert the user
                                           @try {
                                               
                                               [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"invalid_session"]];
                                           }
                                           @catch (NSException *exception) {
                                               
                                           }
                                           @finally {
                                               
                                           }
                                           
                                           
                                           
                                       }
                                       
                                   }];
            
     
            
        }
        else
        {

//            
            NSArray * array=[[NSArray alloc]initWithObjects:@"",@"", nil];
            NSString *rir=[array objectAtIndex:3];
            NSLog(@"%@",rir);
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] clearNotificationSetup];
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setShowNotification:YES];
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
    
}
-(IBAction)gotoCalendar:(id)sender
{
    float  idlength=[[GlobalVariables shareInstance].session_id length];
    NSLog(@"idlenggt======================%f-------------",idlength);
    if (idlength <8) {
        gohomeBUtton.hidden=YES;
        aaaView.hidden=NO;
        aView.hidden=YES;
    }
    else
    {
        
        if (jokei==1)
        {
            
            
            NSLog(@"tikenArray=%@",tikenArray);
            NSString *sumtiken=[[NSString alloc]init];
            NSString *sumTIme=[NSString new];
            for (int i=0; i<tikenArray.count; i++)
            {
                NSString *temp;
                
                if (i==theNUMBERTiken)
                {
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
            Alarm* alarm=[[Alarm alloc]initWithMedicationId:self.ididid Title:nil Meal:nil DosAge:nil Servertime:nil ReminderTime:nil ReminderID:nil ReminderType:nil ReminderRepeat:nil ReminderTicken:sumtiken ReminderCreateTime:@"" ReminderserverTime:nil ReminderImageString:nil Note:nil];
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
            
            NSURL *request_url = [NSURL URLWithString:encodedString];
            
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            NSData *requestData = [ NSData dataWithBytes: [ [url_string encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
            [request setHTTPBody:requestData];
            NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
            NSLog(@"%@+_+_+_",ionaSr);
            
        }
        MR_ListViewController *homeView = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        
        homeView.dateDateStr=currentDateStr;
        
        
        [self.navigationController pushViewController:homeView animated:YES];
        
    }
    
    
    NSLog(@"-------------------------------------------");
    NSLog(@"_______---------------------------------我來                  了------------------------------我真的跳             了---------------------------------------------真的要過去了-----------------------------------拜拜-----------------------------");
    
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
    
    backGuangView.hidden=YES;
}
-(void)upDateNow:(id)sender
{
    NSLog(@"Update now");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id910396784"]];
}
-(IBAction)thisOk:(id)sender
{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString * strWarn=   [defaults objectForKey:@"strWarn"];


    
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
                backGuangView.hidden=YES;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
