//
//  AddReminderViewController.m
//  mHealth
//
//  Created by gz dev team on 14年3月18日.
//
//

#import "AddReminderViewController.h"
#import "MR_ListViewController.h"
#import "HomeViewController.h"
#import "DiaryViewController.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "Utility.h"
#import "DBHelper.h"
#import "NSString+URLEncoding.h"
#import "syncUtility.h"
#import "DiaryViewController.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "ImageEditorViewController.h"




@interface AddReminderViewController ()

@end

@implementation AddReminderViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        //NSLog(@"not ipad");
        self = [super initWithNibName:@"AddReminderViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"AddReminderViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [self textFonttext];

    
    
}
-(void)textFonttext
{
    [hendTextFont setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    hendTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [addHendTextFont setText:[Utility getStringByKey:@"Add Event"]];
    addHendTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    NSString *strMeasurement=[[NSString alloc]initWithFormat:@" %@",[Utility getStringByKey:@"Daily Measurement"]];
    [_clickLabel setText:strMeasurement];
    _clickLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20];
    
    [TypeTextFont setText:[Utility getStringByKey:@"Type"]];
    TypeTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [bpTextFont setText:[Utility getStringByKey:@"Blood Pressure"]];
    bpTextFont.textAlignment= NSTextAlignmentCenter;
    bpTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [ecgTextFont setText:[Utility getStringByKey:@"ECG"]];
    ecgTextFont.textAlignment= NSTextAlignmentCenter;
    ecgTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [bgTextFont setText:[Utility getStringByKey:@"Blood Glucose"]];
    bgTextFont.textAlignment=  NSTextAlignmentCenter;
    bgTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [frequencyTextFont setText:[Utility getStringByKey:@"Frequency"]];
    frequencyTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:20];
    [perDayTextFont setText:[Utility getStringByKey:@"per day"]];
    perDayTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    
    
    [time1TextFont setText:[Utility getStringByKey:@"Time1"]];
    time1TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time2TextFont setText:[Utility getStringByKey:@"Time2"]];
    time2TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time3TextFont setText:[Utility getStringByKey:@"Time3"]];
    time3TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time4TextFont setText:[Utility getStringByKey:@"Time4"]];
    time4TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time5TextFont setText:[Utility getStringByKey:@"Time5"]];
    time5TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time6TextFont setText:[Utility getStringByKey:@"Time6"]];
    time6TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    
    numberLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:30];
    _timeLabel1.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel3.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel4.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel5.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel6.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    
    [titleOtherTextFont setText:[Utility getStringByKey:@"Calendar Title"]];
    titleOtherTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [dataOtherTextFont setText:[Utility getStringByKey:@"Calendar Date"]];
    dataOtherTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [startOtherTextFont setText:[Utility getStringByKey:@"Calendar Start"]];
    startOtherTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [endOtherTextFont setText:[Utility getStringByKey:@"Calendar End"]];
    endOtherTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [noteOtherTextFont setText:[Utility getStringByKey:@"Calendar Note"]];
    noteOtherTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    _textField.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _dateLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _labelStart.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _labelEnd.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _textView.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    
    _buttonOne.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:23];
    [medicineTextFont setText:[Utility getStringByKey:@"Medicine"]];
    medicineTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [dosageTextFont setText:[Utility getStringByKey:@"Dosage"]];
    dosageTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    _dostextView.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _agetextView.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [beforeMealTextFont setText:[Utility getStringByKey:@"Before meal"]];
    beforeMealTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [afterMealTextFont setText:[Utility getStringByKey:@"After meal"]];
    afterMealTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [nAAtextFont setText:[Utility getStringByKey:@"N/A"]];
    nAAtextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [frequencyTextFontText setText:[Utility getStringByKey:@"Frequency"]];
    frequencyTextFontText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [perdayTextFontText setText:[Utility getStringByKey:@"per day"]];
    perdayTextFontText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [time111TextFont setText:[Utility getStringByKey:@"Time1"]];
    time111TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time222TextFont setText:[Utility getStringByKey:@"Time2"]];
    time222TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time333TextFont setText:[Utility getStringByKey:@"Time3"]];
    time333TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time444TextFont setText:[Utility getStringByKey:@"Time4"]];
    time444TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time555TextFont setText:[Utility getStringByKey:@"Time5"]];
    time555TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time666TextFont setText:[Utility getStringByKey:@"Time6"]];
    time666TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    _dateLabel111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:30];
    _timeLabel111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel222.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel333.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel444.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel555.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel666.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    [celeleButtonTextFont setTitle:[Utility getStringByKey:@"Cancel"] forState:UIControlStateNormal];
    celeleButtonTextFont.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [doneButtonFontText setTitle:[Utility getStringByKey:@"Done"] forState:UIControlStateNormal];
    doneButtonFontText.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    [frequencyTextFontText1111 setText:[Utility getStringByKey:@"Frequency"]];
    frequencyTextFontText1111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:20];
    [perdayTextFontText1111 setText:[Utility getStringByKey:@"per day"]];
    perdayTextFontText1111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [time1111TextFont setText:[Utility getStringByKey:@"Time1"]];
    time1111TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time2222TextFont setText:[Utility getStringByKey:@"Time2"]];
    time2222TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time3333TextFont setText:[Utility getStringByKey:@"Time3"]];
    time3333TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time4444TextFont setText:[Utility getStringByKey:@"Time4"]];
    time4444TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time5555TextFont setText:[Utility getStringByKey:@"Time5"]];
    time5555TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time6666TextFont setText:[Utility getStringByKey:@"Time6"]];
    time6666TextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    
    walkTime.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:30];
    timeLabel1111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    timeLabel2222.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    timeLabel3333.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    timeLabel4444.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    timeLabel5555.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    timeLabel6666.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    
    NSString *tempHand=[Utility getStringByKey:@"HealthReach Calendar"];
    if ([tempHand isEqualToString:@"HealthReach Calendar"]) {
        [medicinePictureTextFont setText:@"Medicine picture:"];
    }
    else
    {
        [medicinePictureTextFont setText:@"藥物圖片:"];
    }
    medicinePictureTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    photoView.hidden=YES;
    imageBase64Str=@"";
    self.banMEAL=@"N";
    NSString * timeStrRain111=[self.dateDateStr substringWithRange:NSMakeRange(8,2)];
    
    NSString * timeStrRain222=[self.dateDateStr substringWithRange:NSMakeRange(0,4)];
    NSString *timeStrRain333=[self.dateDateStr substringWithRange:NSMakeRange(5, 2)];
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
    
    
    _dateLabel.text=sumDay;
    
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
    
    
    
    NSString *mediationidCOnStr=[[NSString alloc]initWithFormat:@"%ld",(long)self.mediationidCOnt+1 ];
    _buttonOne.text=mediationidCOnStr;

    self.banMEAL=@"N";
    
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *dates=[dateFormat dateFromString:self.dateDateStr];
    NSTimeInterval secondsPerDay = +(24*60*60)*6;
    NSDate *tomorrow = [dates dateByAddingTimeInterval:secondsPerDay];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr=[dateFormatter stringFromDate:tomorrow];
    self.sevenDateStr=currentDateStr;
    NSLog(@"tomorrow= %@  currentDateStr=%@ ",tomorrow,currentDateStr);
    
    NSLog(@"%@-==",_dateLabel.text);
 //   _measurementView.layer.cornerRadius=12;
    imageimageBack.layer.cornerRadius=15;
    UIToolbar*toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [toolBar setBarStyle:UIBarStyleBlack];
    toolBar.translucent=YES;
    toolBar.tintColor=[UIColor grayColor];
    UIBarButtonItem*barButton1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(leaveEditMode)];
    UIBarButtonItem*barButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(leaveEditMode)];
    NSArray *array=[[NSArray alloc] initWithObjects:barButton1,barButton, nil];
    toolBar.items=array;
    _textView.delegate=self;
    _agetextView.delegate=self;
    _dostextView.delegate=self;
    _textField.delegate=self;
    
    [_textView setInputAccessoryView:toolBar];
    [_dostextView setInputAccessoryView:toolBar];
    [_agetextView setInputAccessoryView:toolBar];
    [_textField setInputAccessoryView:toolBar];
    _textView.scrollEnabled = NO;
    
   self.medication_Note_TextView=[[UITextView alloc]initWithFrame:CGRectMake(25, 240, 260, 90)];

     self. medication_Note_TextView.textColor=[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
       self. medication_Note_TextView.font = [UIFont fontWithName:@"Arial" size:15.0];
     self. medication_Note_TextView.delegate=self;
    
     self. medication_Note_TextView.backgroundColor=[UIColor whiteColor];
    self.  medication_Note_TextView.scrollEnabled=NO;
   // medicationSecondView.userInteractionEnabled=YES;
    
    //[medicationSecondView insertSubview:self.medication_Note_TextView aboveSubview:_secondTable];
    
    [medicationSecondView insertSubview:self.medication_Note_TextView belowSubview:_secondTable];
     //  [medicationSecondView addSubview: self.medication_Note_TextView];
//medication_Note_TextView.text=@"111";
     self. medication_Note_TextView.delegate=self;
    
//    self.medication_Note_TextView.hidden=true;
    
    labelText_NOte=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 256, 30)];
    labelText_NOte.backgroundColor=[UIColor clearColor];
    labelText_NOte.textColor=[UIColor grayColor];
    labelText_NOte.font = [UIFont fontWithName:@"Arial" size:15.0];
    NSString *tempHand=[Utility getStringByKey:@"HealthReach Calendar"];
    if ([tempHand isEqualToString:@"HealthReach Calendar"]) {
        
        labelText_NOte.text=@"Enter your remarks here (optional)";
    }
    else
    {
        labelText_NOte.text=@"按此輸入備註（可選）";
    }
    
    [self.medication_Note_TextView addSubview:labelText_NOte];
    
    
    labelText_NOte.hidden=NO;
    
    
   // [medicationSecondView bringSubviewToFront: self. medication_Note_TextView];
    [ self. medication_Note_TextView setInputAccessoryView:toolBar];


 

    k=1;
    y=1;
    i=1;
    NSString *measurement=[[NSString alloc]initWithFormat:@" %@",[Utility getStringByKey:@"Daily Measurement"]];
    NSString *medication=[[NSString alloc]initWithFormat:@" %@",[Utility getStringByKey:@"Daily Medication"]];
    NSString *others=[[NSString alloc]initWithFormat:@" %@",[Utility getStringByKey:@"Others"]];
    NSString *exercise=[[NSString alloc]initWithFormat:@" %@",[Utility getStringByKey:@"Exercise"]];
    
    _array=[[NSMutableArray alloc]initWithObjects:measurement,medication,others,exercise, nil];
    
    _array2=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",nil];
    
    NSString*bstrBPOn=[[NSBundle mainBundle]pathForResource:@"02_diary_add_measurement_btn_bp_1_on" ofType:@"png"];
    NSString*bstrBPOff=[[NSBundle mainBundle]pathForResource:@"02_diary_add_measurement_btn_bp_1_off" ofType:@"png"];
    NSString*bstrECGOn=[[NSBundle mainBundle]pathForResource:@"02_diary_add_measurement_btn_ecg_1_on" ofType:@"png"];
    NSString*bstrECGOff=[[NSBundle mainBundle]pathForResource:@"02_diary_add_measurement_btn_ecg_1_off" ofType:@"png"];
    NSString*bstrBGOn=[[NSBundle mainBundle]pathForResource:@"02_diary_add_measurement_btn_bg_1_on" ofType:@"png"];
    NSString*bstrBGOff=[[NSBundle mainBundle]pathForResource:@"02_diary_add_measurement_btn_bg_1_off" ofType:@"png"];
    
    
    
    _imageBPOn=[[UIImage alloc]initWithContentsOfFile:bstrBPOn];
    _imageBPOff=[[UIImage alloc]initWithContentsOfFile:bstrBPOff];
    _imageECGOn=[[UIImage alloc]initWithContentsOfFile:bstrECGOn];
    _imageECGOff=[[UIImage alloc]initWithContentsOfFile:bstrECGOff];
    _imageBGOn=[[UIImage alloc]initWithContentsOfFile:bstrBGOn];
    _imageBGOff=[[UIImage alloc]initWithContentsOfFile:bstrBGOff];
    
    

    
    
    
    
    
    
    
    
    
    
    NSString*ridaoOnStr=[[NSBundle mainBundle] pathForResource:@"hr_btn_radio_1_on" ofType:@"png"];
    NSString*ridaoOffStr=[[NSBundle mainBundle] pathForResource:@"hr_btn_radio_1_off" ofType:@"png"];
    ridaoOn=[[UIImage alloc]initWithContentsOfFile:ridaoOnStr];
    ridaoOff=[[UIImage alloc]initWithContentsOfFile:ridaoOffStr];
    
    
    
    NSString *bstr1=[[NSBundle mainBundle]pathForResource:@"hr_btn_wa_green_2" ofType:@"png" ];
    NSString *bstr2=[[NSBundle mainBundle]pathForResource:@"hr_btn_wa_red_1" ofType:@"png"];
    UIImage * _image1=[[UIImage alloc]initWithContentsOfFile:bstr1];
    UIImage *_image2=[[UIImage alloc]initWithContentsOfFile:bstr2];
    
     strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];
    

    __scrollView.backgroundColor=[UIColor clearColor];
   // __scrollView.pagingEnabled=YES;
   // __scrollView.bounces=YES;
   // __scrollView.showsHorizontalScrollIndicator=NO;
   // __scrollView.showsVerticalScrollIndicator=YES;
    __scrollView.bounces=NO;
    __scrollView.contentSize=CGSizeMake(320, 121+200+10+50+30);//设置总画布的大小
    
    
    
    
    
    __scrollView.delegate=self;//实现代理
    
    
    
    
    
    _backguandView.backgroundColor=[UIColor clearColor];
 //   _backguandView.pagingEnabled=YES;
    //_backguandView.bounces=YES;
  //  _backguandView.showsHorizontalScrollIndicator=NO;
  //  _backguandView.showsVerticalScrollIndicator=YES;
  _backguandView.bounces=NO;
    _backguandView.contentSize=CGSizeMake(320, 340+10+50+40+90);
    _backguandView.delegate=self;
    
    if (!iPad) {
        __scrollView.frame=CGRectMake(0, 0, 320, 358);
        
        
    }
    else
    {
        __scrollView.frame=CGRectMake(0, 0, 320, 275);
        _backguandView.frame=CGRectMake(0, 0, 320, 275);
    }
    
    
    UILabel *labelll=[[UILabel alloc]initWithFrame:CGRectMake(60, 121+200+10, 230, 60)];
    labelll.backgroundColor=[UIColor clearColor];
    labelll.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12];
    labelll.numberOfLines=4;
    labelll.textColor=[UIColor blackColor];
    if ([strTempTemp isEqualToString:@"HealthReach Calendar"])
    {
    labelll.text=@"First reminder and second reminder are given 24 hours and 2 hours before the scheduled time,while a final reminder is give 15 minutes before the event.";

    }
    else
    {
        labelll.text=@"第一及第二次提示將分别於活動開始前24小時及2小時發出,最終提示則會於活動開始前15分鐘發出.";
    }
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20];
    CGSize size = CGSizeMake(320,2000);

    
    CGRect labelsize = [[Utility getStringByKey:@"Frequency"]
                        boundingRectWithSize:size
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{NSFontAttributeName:font}
                        context:nil];
    UIFont *font222 = [UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20];
    CGSize size222 = CGSizeMake(320,2000);
    
    
    CGRect labelsize222 = [[Utility getStringByKey:@"Medicine picture:"]
                        boundingRectWithSize:size222
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{NSFontAttributeName:font222}
                        context:nil];
    //CGSize labelsize = [[Utility getStringByKey:@"Frequency"] sizeWithFont:font constrainedToSize:size lineBreakMode:nil];
    medicinePictureTextFont.frame=CGRectMake(0, 0, 0, 0);
    [medicinePictureTextFont setNumberOfLines:0];
    medicinePictureTextFont.frame=CGRectMake(25, 135, labelsize222.size.width, labelsize222.size.height+5);
    medicinePictureChickButton.frame=CGRectMake(27+medicinePictureTextFont.frame.size.width,126, 45, 35);
    
    frequencyTextFont.frame=CGRectMake(0, 0, 0, 0);
     [frequencyTextFont setNumberOfLines:0];
    frequencyTextFont.frame=CGRectMake(25, 90,  labelsize.size.width,labelsize.size.height+5);
    _timechickImabe1.frame=CGRectMake(frequencyTextFont.frame.size.width+28, 83, 45, 31);
    numberLabel.frame=CGRectMake(frequencyTextFont.frame.size.width+28, 87, 45, 31);

    _tableView2.frame=CGRectMake(frequencyTextFont.frame.size.width+28, 114, 75, 131);
    frequencyTextFontText1111.frame=CGRectMake(25, 25,  labelsize.size.width,31);
    _timechickButtonWhite1.frame=CGRectMake(frequencyTextFont.frame.size.width+28+45, 83, 30, 31);
    perDayTextFont.frame=CGRectMake(frequencyTextFont.frame.size.width+28+45+30+2, 90, 84, labelsize.size.height+5);
    
   // [frequencyTextFontText1111 sizeToFit];
    frequencyTextFontText1111.frame=CGRectMake(0, 0, 0, 0);
    [frequencyTextFontText1111 setNumberOfLines:0];
    frequencyTextFontText1111.frame=CGRectMake(25, 25,  labelsize.size.width,31);
    _timechickImabe111.frame=CGRectMake(frequencyTextFontText1111.frame.size.width+25+3, 20, 45, 31);
    _timechickButtonWhite111.frame=CGRectMake(frequencyTextFontText1111.frame.size.width+25+3+45, 20, 30, 31);
    threeTable.frame=CGRectMake(frequencyTextFontText1111.frame.size.width+25+3, 50, 75, 188);
    walkTime.frame=CGRectMake(frequencyTextFontText1111.frame.size.width+28, 23, 45, 31);
    frequencyTextFontText.frame=CGRectMake(25, 193, labelsize.size.width,labelsize.size.height);
    perdayTextFontText1111.frame=CGRectMake(frequencyTextFontText1111.frame.size.width+28+45+30+2, 25, 78, 31);
    
    
  //  [frequencyTextFontText sizeToFit];
    frequencyTextFontText.frame=CGRectMake(0, 0, 0, 0);
    [frequencyTextFontText setNumberOfLines:0];
    frequencyTextFontText.frame=CGRectMake(25,60, labelsize.size.width,labelsize.size.height);
    _timechickImabe11.frame=CGRectMake(frequencyTextFontText.frame.size.width+28, 54, 45, 31);
    _secondTable.frame=CGRectMake(frequencyTextFontText.frame.size.width+28, 85, 75, 124);
    _dateLabel111.frame=CGRectMake(frequencyTextFontText.frame.size.width+28, 55, 45, 38);
    _timechickButtonWhite11.frame=CGRectMake(frequencyTextFontText.frame.size.width+28+45, 54, 30, 31);
    perdayTextFontText.frame=CGRectMake(frequencyTextFontText.frame.size.width+28+45+30+2, 60, 91, 23);
    
    
    [__scrollView addSubview:labelll];
    
    _tableView =[[UITableView alloc] initWithFrame:chickView.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [chickView addSubview:_tableView];
    backgoundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    backgoundView.backgroundColor=[UIColor whiteColor];
    backgoundView.alpha=0.8;
    [self.view addSubview:backgoundView];
    backgoundView.hidden =YES;
    
    datePickerView=[[UIView alloc]initWithFrame:CGRectMake(10 ,180, 300 , 280)];
    datePickerView.layer.cornerRadius = 12;//设置那个圆角的有多圆
    datePickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:datePickerView];
    UIDatePicker * datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 280)];
    datePicker.date=[NSDate date];
    datePicker.tag=100;
    datePicker.datePickerMode=UIDatePickerModeTime;
    datePicker.backgroundColor=[UIColor whiteColor];
    
    [datePickerView addSubview:datePicker];
   // [self.view bringSubviewToFront:datePickerView];
    
    
    
    dateDateCHickView=[[UIView alloc]initWithFrame:CGRectMake(10, 180, 300, 280)];
    dateDateCHickView.layer.cornerRadius = 12;//设置那个圆角的有多圆
    dateDateCHickView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateDateCHickView];
    dateDateCHickView.hidden=YES;
    
    UIDatePicker* datePickerDDDD=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 280)];
    datePickerDDDD.date=[NSDate date];
    datePickerDDDD.tag=1000;
    datePickerDDDD.datePickerMode=UIDatePickerModeDate;
    datePickerDDDD.backgroundColor=[UIColor whiteColor];
    [dateDateCHickView addSubview:datePickerDDDD];
    
    NSString * ismHEalth=[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];
    NSLocale *locale ;
    if ([ismHEalth isEqualToString:@"HealthReach Calendar"]) {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];//设置为英文显示2
    }
    else
    {
         locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示3
    }
   
  
    datePicker.locale = locale;
    datePickerDDDD.locale=locale;
    
    UIButton * _buttonYes=[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonYes setImage:_image1 forState:UIControlStateNormal];
    [_buttonYes addTarget:self action:@selector(buttonYES) forControlEvents:UIControlEventTouchUpInside];
    _buttonYes.frame=CGRectMake(160, 240, 100, 40);
    [datePickerView addSubview:_buttonYes];
    UIButton * _buttonNo=[UIButton buttonWithType:UIButtonTypeCustom];
    _buttonNo.frame=CGRectMake(40, 240, 100, 40);
    [_buttonNo setImage:_image2 forState:UIControlStateNormal];
    [_buttonNo addTarget:self action:@selector(buttonNO) forControlEvents:UIControlEventTouchUpInside];
    [datePickerView addSubview:_buttonNo];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label1.text=[Utility getStringByKey:@"Done"];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.backgroundColor=[UIColor clearColor];
    label1.textColor=[UIColor whiteColor];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label2.text=[Utility getStringByKey:@"Cancel"];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor =[UIColor whiteColor];
    label2.backgroundColor=[UIColor clearColor];
    [_buttonYes addSubview:label1];
    [_buttonNo addSubview:label2];
    datePickerView.hidden=YES;
    
    
    
    
    
    
    
    UIButton * _buttonYesDDD=[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonYesDDD setImage:_image1 forState:UIControlStateNormal];
    [_buttonYesDDD addTarget:self action:@selector(buttonYESDDD) forControlEvents:UIControlEventTouchUpInside];
    _buttonYesDDD.frame=CGRectMake(160, 240, 100, 40);
    [dateDateCHickView addSubview:_buttonYesDDD];
    UIButton * _buttonNoDDD=[UIButton buttonWithType:UIButtonTypeCustom];
    _buttonNoDDD.frame=CGRectMake(40, 240, 100, 40);
    [_buttonNoDDD setImage:_image2 forState:UIControlStateNormal];
    [_buttonNoDDD addTarget:self action:@selector(buttonNODDD) forControlEvents:UIControlEventTouchUpInside];
    [dateDateCHickView addSubview:_buttonNoDDD];
    
    UILabel *label1DDD=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label1DDD.text=[Utility getStringByKey:@"Done"];
    label1DDD.textAlignment=NSTextAlignmentCenter;
    label1DDD.backgroundColor=[UIColor clearColor];
    label1DDD.textColor=[UIColor whiteColor];
    UILabel *label2DDD=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label2DDD.text=[Utility getStringByKey:@"Cancel"];
    label2DDD.textColor =[UIColor whiteColor];
    label2DDD.textAlignment=NSTextAlignmentCenter;
    label2DDD.backgroundColor=[UIColor clearColor];
    [_buttonYesDDD addSubview:label1DDD];
    [_buttonNoDDD addSubview:label2DDD];
    
    
    adHocView.hidden=YES;
    _measurementView.hidden=NO;
    medicationView.hidden=YES;
    walkView.hidden=YES;
    
    beforeMealButton.image=ridaoOff ;
    afterMealButton .image=ridaoOff;
    naButton.image=ridaoOn;
    
    
    _time111.hidden =YES;
    _time222.hidden =YES;
    _time333.hidden =YES;
    _time444.hidden =YES;
    _time555.hidden =YES;
    _time666.hidden =YES;
    
    _timeLabel222.text=nil;
    _timeLabel333.text=nil;
    _timeLabel444.text=nil;
    _timeLabel555.text=nil;
    _timeLabel666.text=nil;
    
    NSLog(@"self.timeBloodMutableArray.count=%@",self.timeBloodMutableArray);
    NSLog(@"self.timeECGMutableArray.count=%@",self.timeECGMutableArray);
    NSLog(@"self.timeGloodMutableArray.count=%@",self.timeGlucoseMutableArray);
    
    switch (self.timeBloodMutableArray.count) {
        case 0:
        numberLabel.text=@"";
            _time1.hidden =YES;
            _time2.hidden =YES;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=nil;
            _timeLabel2.text=nil;
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 1:
                   numberLabel.text=@"1";
            _time1.hidden =NO;
            _time2.hidden =YES;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=nil;
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 2:
                   numberLabel.text=@"2";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 3:
                   numberLabel.text=@"3";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeBloodMutableArray objectAtIndex:2];
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 4:
        numberLabel.text=@"4";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeBloodMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeBloodMutableArray objectAtIndex:3];
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 5:
                   numberLabel.text=@"5";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =NO;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeBloodMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeBloodMutableArray objectAtIndex:3];
            _timeLabel5.text=[self.timeBloodMutableArray objectAtIndex:4];
            _timeLabel6.text=nil;
            break;
        case 6:
                   numberLabel.text=@"6";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =NO;
            _time6.hidden =NO;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeBloodMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeBloodMutableArray objectAtIndex:3];
            _timeLabel5.text=[self.timeBloodMutableArray objectAtIndex:4];
            _timeLabel6.text=[self.timeBloodMutableArray objectAtIndex:5];
            break;
        default:
            
            break;
    }
    switch (self.timeWalkMutableArray.count) {
        case 0:
               walkTime.text=@"";
            _time1111.hidden =YES;
            _time2222.hidden =YES;
            _time3333.hidden =YES;
            _time4444.hidden =YES;
            _time5555.hidden =YES;
            _time6666.hidden =YES;
            timeLabel1111.text=nil;
            timeLabel2222.text=nil;
            timeLabel3333.text=nil;
            timeLabel4444.text=nil;
            timeLabel5555.text=nil;
            timeLabel6666.text=nil;
            break;
        case 1:
             walkTime.text=@"1";
            _time1111.hidden =NO;
            _time2222.hidden =YES;
            _time3333.hidden =YES;
            _time4444.hidden =YES;
            _time5555.hidden =YES;
            _time6666.hidden =YES;
            timeLabel1111.text=[self.timeWalkMutableArray objectAtIndex:0];
            timeLabel2222.text=nil;
            timeLabel3333.text=nil;
            timeLabel4444.text=nil;
            timeLabel5555.text=nil;
            timeLabel6666.text=nil;
            break;
        case 2:
             walkTime.text=@"2";
            _time1111.hidden =NO;
            _time2222.hidden =NO;
            _time3333.hidden =YES;
            _time4444.hidden =YES;
            _time5555.hidden =YES;
            _time6666.hidden =YES;
            timeLabel1111.text=[self.timeWalkMutableArray objectAtIndex:0];
            timeLabel2222.text=[self.timeWalkMutableArray objectAtIndex:1];
            timeLabel3333.text=nil;
            timeLabel4444.text=nil;
            timeLabel5555.text=nil;
            timeLabel6666.text=nil;
            break;
        case 3:
             walkTime.text=@"3";
            _time1111.hidden =NO;
            _time2222.hidden =NO;
            _time3333.hidden =NO;
            _time4444.hidden =YES;
            _time5555.hidden =YES;
            _time6666.hidden =YES;
            timeLabel1111.text=[self.timeWalkMutableArray objectAtIndex:0];
            timeLabel2222.text=[self.timeWalkMutableArray objectAtIndex:1];
            timeLabel3333.text=[self.timeWalkMutableArray objectAtIndex:2];
            timeLabel4444.text=nil;
            timeLabel5555.text=nil;
            timeLabel6666.text=nil;
            break;
        case 4:
             walkTime.text=@"4";
            _time1111.hidden =NO;
            _time2222.hidden =NO;
            _time3333.hidden =NO;
            _time4444.hidden =NO;
            _time5555.hidden =YES;
            _time6666.hidden =YES;
            timeLabel1111.text=[self.timeWalkMutableArray objectAtIndex:0];
            timeLabel2222.text=[self.timeWalkMutableArray objectAtIndex:1];
            timeLabel3333.text=[self.timeWalkMutableArray objectAtIndex:2];
            timeLabel4444.text=[self.timeWalkMutableArray objectAtIndex:3];
            timeLabel5555.text=nil;
            timeLabel6666.text=nil;
            break;
        case 5:
             walkTime.text=@"5";
            _time1111.hidden =NO;
            _time2222.hidden =NO;
            _time3333.hidden =NO;
            _time4444.hidden =NO;
            _time5555.hidden =NO;
            _time6666.hidden =YES;
            timeLabel1111.text=[self.timeWalkMutableArray objectAtIndex:0];
            timeLabel2222.text=[self.timeWalkMutableArray objectAtIndex:1];
            timeLabel3333.text=[self.timeWalkMutableArray objectAtIndex:2];
            timeLabel4444.text=[self.timeWalkMutableArray objectAtIndex:3];
            timeLabel5555.text=[self.timeWalkMutableArray objectAtIndex:4];
            timeLabel6666.text=nil;
            break;
        case 6:
             walkTime.text=@"6";
            _time1111.hidden =NO;
            _time2222.hidden =NO;
            _time3333.hidden =NO;
            _time4444.hidden =NO;
            _time5555.hidden =NO;
            _time6666.hidden =NO;
            timeLabel1111.text=[self.timeWalkMutableArray objectAtIndex:0];
            timeLabel2222.text=[self.timeWalkMutableArray objectAtIndex:1];
            timeLabel3333.text=[self.timeWalkMutableArray objectAtIndex:2];
            timeLabel4444.text=[self.timeWalkMutableArray objectAtIndex:3];
            timeLabel5555.text=[self.timeWalkMutableArray objectAtIndex:4];
            timeLabel6666.text=[self.timeWalkMutableArray objectAtIndex:5];
            break;
        default:
            
            break;
    }

    
    
    thebackTitlelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 400, 280, 50)];
    thebackTitlelabel.textColor=[UIColor whiteColor];
    thebackTitlelabel.backgroundColor=[UIColor blackColor];
    thebackTitlelabel.numberOfLines=2;
    thebackTitlelabel.textAlignment=NSTextAlignmentCenter;
    thebackTitlelabel.layer.cornerRadius=15;
    [self.view addSubview:thebackTitlelabel];
    thebackTitlelabel.hidden=YES;

 
    // Do any additional setup after loading the view from its nib.
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    else
    {
        cell.textLabel.text=nil;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str=[NSString new];;
    
    if (tableView==_tableView)
    {
        str =[_array objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    }
    else
    {
        str =[_array2 objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:30];
    }
    
    cell.textLabel.text=str;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return [_array count];
    }
    else
        return [_array2 count];
    
}
#pragma mark - 触发cell的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==_tableView) {
        NSString *str=[NSString stringWithFormat:@" %@",[_array objectAtIndex:indexPath.row]];
        if (!iPad) {
            __scrollView.frame=CGRectMake(0, 0, 320, 358);
        }
        else
        {
             __scrollView.frame=CGRectMake(0, 0, 320, 275);
            _backguandView.frame=CGRectMake(0, 0, 320, 275);
        }
        _clickLabel.text=str;
        chickView.hidden=YES;
        switch (indexPath.row) {
            case 0:
                //
             
                [_textView resignFirstResponder];
                [self.medication_Note_TextView resignFirstResponder];
                [_dostextView resignFirstResponder];
                [_agetextView resignFirstResponder];
                [_textField resignFirstResponder];
                _measurementView.hidden=NO;
                medicationView.hidden=YES;
                adHocView.hidden=YES;
                walkView.hidden=YES;
                k=1;
                break;
            case 1:
                //
         
                [_textView resignFirstResponder];
                [_dostextView resignFirstResponder];
                [_agetextView resignFirstResponder];
                 [self.medication_Note_TextView resignFirstResponder];
                [_textField resignFirstResponder];
                _measurementView.hidden=YES;
                medicationView.hidden=NO;
                adHocView.hidden=YES;
                walkView.hidden=YES;
                
                k=2;
                break;
            case 2:
                //
        
                [_textView resignFirstResponder];
                [_dostextView resignFirstResponder];
                [_agetextView resignFirstResponder];
                [_textField resignFirstResponder];
                 [self.medication_Note_TextView resignFirstResponder];
                _measurementView.hidden=YES;
                adHocView.hidden=NO;
                medicationView.hidden=YES;
                walkView.hidden=YES;
                k=3;
                break;
                case 3:

                [_textView resignFirstResponder];
                [_dostextView resignFirstResponder];
                [_agetextView resignFirstResponder];
                 [self.medication_Note_TextView resignFirstResponder];
                [_textField resignFirstResponder];
                _measurementView.hidden=YES;
                adHocView.hidden=YES;
                medicationView.hidden=YES;
                walkView.hidden=NO;
                k=4;
                
                break;
            default:
                break;
        }
        
        
        
        
        
        
    }
    
    if (tableView==_secondTable) {
        _dateLabel111.text=[_array2 objectAtIndex:indexPath.row];
        _secondTable.hidden=YES;
        switch (indexPath.row) {
            case 0:
                //
                _time111.hidden =NO;
                _time222.hidden =YES;
                _time333.hidden =YES;
                _time444.hidden =YES;
                _time555.hidden =YES;
                _time666.hidden =YES;
                _timeLabel222.text=nil;
                _timeLabel333.text=nil;
                _timeLabel444.text=nil;
                _timeLabel555.text=nil;
                _timeLabel666.text=nil;
                
                break;
            case 1:
                //
                _time111.hidden =NO;
                _time222.hidden =NO;
                _time333.hidden =YES;
                _time444.hidden =YES;
                _time555.hidden =YES;
                _time666.hidden =YES;
                
                _timeLabel333.text=nil;
                _timeLabel444.text=nil;
                _timeLabel555.text=nil;
                _timeLabel666.text=nil;
                break;
            case 2:
                //
                _time111.hidden =NO;
                _time222.hidden =NO;
                _time333.hidden =NO;
                _time444.hidden =YES;
                _time555.hidden =YES;
                _time666.hidden =YES;
                
                _timeLabel444.text=nil;
                _timeLabel555.text=nil;
                _timeLabel666.text=nil;
                break;
            case 3:
                //
                _time111.hidden =NO;
                _time222.hidden =NO;
                _time333.hidden =NO;
                _time444.hidden =NO;
                _time555.hidden =YES;
                _time666.hidden =YES;
                
                _timeLabel555.text=nil;
                _timeLabel666.text=nil;
                break;
            case 4:
                //
                _time111.hidden =NO;
                _time222.hidden =NO;
                _time333.hidden =NO;
                _time444.hidden =NO;
                _time555.hidden =NO;
                _time666.hidden =YES;
                
                _timeLabel666.text=nil;
                break;
            case 5:
                //
                _time111.hidden =NO;
                _time222.hidden =NO;
                _time333.hidden =NO;
                _time444.hidden =NO;
                _time555.hidden =NO;
                _time666.hidden =NO;
                break;
                
            default:
                _time111.hidden =YES;
                _time222.hidden =YES;
                _time333.hidden =YES;
                _time444.hidden =YES;
                _time555.hidden =YES;
                _time666.hidden =YES;
                break;
        }
        
        
    }
    if (tableView==_tableView2) {
        numberLabel.text=[_array2 objectAtIndex:indexPath.row];
        _tableView2.hidden=YES;
        
        switch (indexPath.row) {
            case 0:
                //
                _time1.hidden =NO;
                _time2.hidden =YES;
                _time3.hidden =YES;
                _time4.hidden =YES;
                _time5.hidden =YES;
                _time6.hidden =YES;
                _timeLabel2.text=nil;
                _timeLabel3.text=nil;
                _timeLabel4.text=nil;
                _timeLabel5.text=nil;
                _timeLabel6.text=nil;
                
                break;
            case 1:
                //
                _time1.hidden =NO;
                _time2.hidden =NO;
                _time3.hidden =YES;
                _time4.hidden =YES;
                _time5.hidden =YES;
                _time6.hidden =YES;
                
                _timeLabel3.text=nil;
                _timeLabel4.text=nil;
                _timeLabel5.text=nil;
                _timeLabel6.text=nil;
                break;
            case 2:
                //
                _time1.hidden =NO;
                _time2.hidden =NO;
                _time3.hidden =NO;
                _time4.hidden =YES;
                _time5.hidden =YES;
                _time6.hidden =YES;
                
                _timeLabel4.text=nil;
                _timeLabel5.text=nil;
                _timeLabel6.text=nil;
                break;
            case 3:
                //
                _time1.hidden =NO;
                _time2.hidden =NO;
                _time3.hidden =NO;
                _time4.hidden =NO;
                _time5.hidden =YES;
                _time6.hidden =YES;
                
                _timeLabel5.text=nil;
                _timeLabel6.text=nil;
                break;
            case 4:
                //
                _time1.hidden =NO;
                _time2.hidden =NO;
                _time3.hidden =NO;
                _time4.hidden =NO;
                _time5.hidden =NO;
                _time6.hidden =YES;
                
                _timeLabel6.text=nil;
                break;
            case 5:
                //
                _time1.hidden =NO;
                _time2.hidden =NO;
                _time3.hidden =NO;
                _time4.hidden =NO;
                _time5.hidden =NO;
                _time6.hidden =NO;
                break;
                
            default:
                break;
        }
    }
    if (tableView==threeTable) {
        walkTime.text=[_array2 objectAtIndex:indexPath.row];
       threeTable.hidden=YES;
        switch (indexPath.row) {
            case 0:
                //
                _time1111.hidden =NO;
               _time2222.hidden =YES;
                _time3333.hidden =YES;
                _time4444.hidden =YES;
                _time5555.hidden =YES;
                _time6666.hidden =YES;
                timeLabel2222.text=nil;
                timeLabel3333.text=nil;
                timeLabel4444.text=nil;
                timeLabel5555.text=nil;
                timeLabel6666.text=nil;
                
                break;
            case 1:
                //
                _time1111.hidden =NO;
                _time2222.hidden =NO;
                _time3333.hidden =YES;
                _time4444.hidden =YES;
                _time5555.hidden =YES;
                _time6666.hidden =YES;
                
                timeLabel3333.text=nil;
                timeLabel4444.text=nil;
                timeLabel5555.text=nil;
                timeLabel6666.text=nil;
                break;
            case 2:
                //
                _time1111.hidden =NO;
                _time2222.hidden =NO;
                _time3333.hidden =NO;
                _time4444.hidden =YES;
                _time5555.hidden =YES;
                _time6666.hidden =YES;
                
                timeLabel4444.text=nil;
                timeLabel5555.text=nil;
                timeLabel6666.text=nil;
                break;
            case 3:
                //
                _time1111.hidden =NO;
                _time2222.hidden =NO;
                _time3333.hidden =NO;
                _time4444.hidden =NO;
                _time5555.hidden =YES;
                _time6666.hidden =YES;
                
                timeLabel5555.text=nil;
                timeLabel6666.text=nil;
                break;
            case 4:
                //
                _time1111.hidden =NO;
                _time2222.hidden =NO;
                _time3333.hidden =NO;
                _time4444.hidden =NO;
                _time5555.hidden =NO;
                _time6666.hidden =YES;
                
                timeLabel6666.text=nil;
                break;
            case 5:
                //
                _time1111.hidden =NO;
                _time2222.hidden =NO;
                _time3333.hidden =NO;
                _time4444.hidden =NO;
                _time5555.hidden =NO;
                _time6666.hidden =NO;
                break;
                
            default:
                _time1111.hidden =YES;
                _time2222.hidden =YES;
                _time3333.hidden =YES;
                _time4444.hidden =YES;
                _time5555.hidden =YES;
                _time6666.hidden =YES;
                break;
        }
        

    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        return 30;
    }
    else
    {
        return 40;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Click:(id)sender
{
    _textView.frame=CGRectMake(59, 121, 228, 200);
    if ( chickView.hidden==NO) {
        chickView.hidden=YES;
    }
    else
        chickView.hidden=NO;
}

-(IBAction)buttonBP:(id)sender
{
        _tableView2.hidden=YES;
    [_buttonBP setImage:_imageBPOn forState:UIControlStateNormal];
    [_buttonECG setImage:_imageECGOff forState:UIControlStateNormal];
    [_buttonBG setImage:_imageBGOff forState:UIControlStateNormal];
    
    y=1;
    switch (self.timeBloodMutableArray.count) {
        case 0:
            numberLabel.text=@"";
            _time1.hidden =YES;
            _time2.hidden =YES;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=nil;
            _timeLabel2.text=nil;
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 1:
              numberLabel.text=@"1";
            _time1.hidden =NO;
            _time2.hidden =YES;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=nil;
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 2:
              numberLabel.text=@"2";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 3:
              numberLabel.text=@"3";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeBloodMutableArray objectAtIndex:2];
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 4:
              numberLabel.text=@"4";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeBloodMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeBloodMutableArray objectAtIndex:3];
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 5:
              numberLabel.text=@"5";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =NO;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeBloodMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeBloodMutableArray objectAtIndex:3];
            _timeLabel5.text=[self.timeBloodMutableArray objectAtIndex:4];
            _timeLabel6.text=nil;
            break;
        case 6:
              numberLabel.text=@"6";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =NO;
            _time6.hidden =NO;
            _timeLabel1.text=[self.timeBloodMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeBloodMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeBloodMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeBloodMutableArray objectAtIndex:3];
            _timeLabel5.text=[self.timeBloodMutableArray objectAtIndex:4];
            _timeLabel6.text=[self.timeBloodMutableArray objectAtIndex:5];
            break;
        default:
            
            break;
    }
}
-(IBAction)buttonECG:(id)sender
{
    NSLog(@" haven't ECG  ");
//    _tableView2.hidden=YES;
//    [_buttonBP setImage:_imageBPOff forState:UIControlStateNormal];
//    [_buttonECG setImage:_imageECGOn forState:UIControlStateNormal];
//    [_buttonBG setImage:_imageBGOff forState:UIControlStateNormal];
//    y=2;
//    switch (self.timeECGMutableArray.count) {
//        case 0:
//              numberLabel.text=@"";
//            _time1.hidden =YES;
//            _time2.hidden =YES;
//            _time3.hidden =YES;
//            _time4.hidden =YES;
//            _time5.hidden =YES;
//            _time6.hidden =YES;
//            _timeLabel1.text=nil;
//            _timeLabel2.text=nil;
//            _timeLabel3.text=nil;
//            _timeLabel4.text=nil;
//            _timeLabel5.text=nil;
//            _timeLabel6.text=nil;
//            break;
//        case 1:
//              numberLabel.text=@"1";
//            _time1.hidden =NO;
//            _time2.hidden =YES;
//            _time3.hidden =YES;
//            _time4.hidden =YES;
//            _time5.hidden =YES;
//            _time6.hidden =YES;
//            _timeLabel1.text=[self.timeECGMutableArray objectAtIndex:0];
//            _timeLabel2.text=nil;
//            _timeLabel3.text=nil;
//            _timeLabel4.text=nil;
//            _timeLabel5.text=nil;
//            _timeLabel6.text=nil;
//            break;
//        case 2:
//              numberLabel.text=@"2";
//            _time1.hidden =NO;
//            _time2.hidden =NO;
//            _time3.hidden =YES;
//            _time4.hidden =YES;
//            _time5.hidden =YES;
//            _time6.hidden =YES;
//            _timeLabel1.text=[self.timeECGMutableArray objectAtIndex:0];
//            _timeLabel2.text=[self.timeECGMutableArray objectAtIndex:1];
//            _timeLabel3.text=nil;
//            _timeLabel4.text=nil;
//            _timeLabel5.text=nil;
//            _timeLabel6.text=nil;
//            break;
//        case 3:
//              numberLabel.text=@"3";
//            _time1.hidden =NO;
//            _time2.hidden =NO;
//            _time3.hidden =NO;
//            _time4.hidden =YES;
//            _time5.hidden =YES;
//            _time6.hidden =YES;
//            _timeLabel1.text=[self.timeECGMutableArray objectAtIndex:0];
//            _timeLabel2.text=[self.timeECGMutableArray objectAtIndex:1];
//            _timeLabel3.text=[self.timeECGMutableArray objectAtIndex:2];
//            _timeLabel4.text=nil;
//            _timeLabel5.text=nil;
//            _timeLabel6.text=nil;
//            break;
//        case 4:
//              numberLabel.text=@"4";
//            _time1.hidden =NO;
//            _time2.hidden =NO;
//            _time3.hidden =NO;
//            _time4.hidden =NO;
//            _time5.hidden =YES;
//            _time6.hidden =YES;
//            _timeLabel1.text=[self.timeECGMutableArray objectAtIndex:0];
//            _timeLabel2.text=[self.timeECGMutableArray objectAtIndex:1];
//            _timeLabel3.text=[self.timeECGMutableArray objectAtIndex:2];
//            _timeLabel4.text=[self.timeECGMutableArray objectAtIndex:3];
//            _timeLabel5.text=nil;
//            _timeLabel6.text=nil;
//            break;
//        case 5:
//              numberLabel.text=@"5";
//            _time1.hidden =NO;
//            _time2.hidden =NO;
//            _time3.hidden =NO;
//            _time4.hidden =NO;
//            _time5.hidden =NO;
//            _time6.hidden =YES;
//            _timeLabel1.text=[self.timeECGMutableArray objectAtIndex:0];
//            _timeLabel2.text=[self.timeECGMutableArray objectAtIndex:1];
//            _timeLabel3.text=[self.timeECGMutableArray objectAtIndex:2];
//            _timeLabel4.text=[self.timeECGMutableArray objectAtIndex:3];
//            _timeLabel5.text=[self.timeECGMutableArray objectAtIndex:4];
//            _timeLabel6.text=nil;
//            break;
//        case 6:
//              numberLabel.text=@"6";
//            _time1.hidden =NO;
//            _time2.hidden =NO;
//            _time3.hidden =NO;
//            _time4.hidden =NO;
//            _time5.hidden =NO;
//            _time6.hidden =NO;
//            _timeLabel1.text=[self.timeECGMutableArray objectAtIndex:0];
//            _timeLabel2.text=[self.timeECGMutableArray objectAtIndex:1];
//            _timeLabel3.text=[self.timeECGMutableArray objectAtIndex:2];
//            _timeLabel4.text=[self.timeECGMutableArray objectAtIndex:3];
//            _timeLabel5.text=[self.timeECGMutableArray objectAtIndex:4];
//            _timeLabel6.text=[self.timeECGMutableArray objectAtIndex:5];
//            break;
//        default:
//            
//            break;
//    }
}
-(IBAction)buttonBG:(id)sender
{
    _tableView2.hidden=YES;
    [_buttonBP setImage:_imageBPOff forState:UIControlStateNormal];
    [_buttonECG setImage:_imageECGOff forState:UIControlStateNormal];
    [_buttonBG setImage:_imageBGOn forState:UIControlStateNormal];
    y=3;
    switch (self.timeGlucoseMutableArray.count) {
        case 0:
              numberLabel.text=@"";
            _time1.hidden =YES;
            _time2.hidden =YES;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=nil;
            _timeLabel2.text=nil;
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 1:
              numberLabel.text=@"1";
            _time1.hidden =NO;
            _time2.hidden =YES;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeGlucoseMutableArray objectAtIndex:0];
            _timeLabel2.text=nil;
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 2:
              numberLabel.text=@"2";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =YES;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeGlucoseMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeGlucoseMutableArray objectAtIndex:1];
            _timeLabel3.text=nil;
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 3:
              numberLabel.text=@"3";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =YES;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeGlucoseMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeGlucoseMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeGlucoseMutableArray objectAtIndex:2];
            _timeLabel4.text=nil;
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 4:
              numberLabel.text=@"4";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =YES;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeGlucoseMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeGlucoseMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeGlucoseMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeGlucoseMutableArray objectAtIndex:3];
            _timeLabel5.text=nil;
            _timeLabel6.text=nil;
            break;
        case 5:
              numberLabel.text=@"5";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =NO;
            _time6.hidden =YES;
            _timeLabel1.text=[self.timeGlucoseMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeGlucoseMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeGlucoseMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeGlucoseMutableArray objectAtIndex:3];
            _timeLabel5.text=[self.timeGlucoseMutableArray objectAtIndex:4];
            _timeLabel6.text=nil;
            break;
        case 6:
              numberLabel.text=@"6";
            _time1.hidden =NO;
            _time2.hidden =NO;
            _time3.hidden =NO;
            _time4.hidden =NO;
            _time5.hidden =NO;
            _time6.hidden =NO;
            _timeLabel1.text=[self.timeGlucoseMutableArray objectAtIndex:0];
            _timeLabel2.text=[self.timeGlucoseMutableArray objectAtIndex:1];
            _timeLabel3.text=[self.timeGlucoseMutableArray objectAtIndex:2];
            _timeLabel4.text=[self.timeGlucoseMutableArray objectAtIndex:3];
            _timeLabel5.text=[self.timeGlucoseMutableArray objectAtIndex:4];
            _timeLabel6.text=[self.timeGlucoseMutableArray objectAtIndex:5];
            break;
        default:
            
            break;
    }
}


-(IBAction)number:(id)sender
{
    numberLabel.text=@"";
    if (_tableView2.hidden==NO)
    {
        _tableView2.hidden=YES;
    }
    else
        _tableView2.hidden=NO;
    
}
-(IBAction)timeBUtton1:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=1;
    theTImeQuent=0;
}
-(IBAction)timeBUtton2:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=2;
    theTImeQuent=0;
}
-(IBAction)timeBUtton3:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=3;
    theTImeQuent=0;
}
-(IBAction)timeBUtton4:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=4;
    theTImeQuent=0;
}
-(IBAction)timeBUtton5:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=5;
    theTImeQuent=0;
}
-(IBAction)timeBUtton6:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=6;
    theTImeQuent=0;
}
-(IBAction)ButtonStart:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    [_dostextView resignFirstResponder];
    [_agetextView resignFirstResponder];
    [_textField resignFirstResponder];
    
    i=21;
   
}
-(IBAction)ButtonEnd:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    [_dostextView resignFirstResponder];
    [_agetextView resignFirstResponder];
    [_textField resignFirstResponder];
    i=22;
}
-(void)buttonYES
{
    backgoundView.hidden=YES;
    datePickerView.hidden=YES;
    UIDatePicker *picker=(UIDatePicker*)[self.view viewWithTag:100];
    NSDateFormatter *fomatter=[[NSDateFormatter alloc]init];
    fomatter.dateFormat=@"HH:mm";
    NSLog(@"%@",[fomatter stringFromDate:picker.date]);
    NSString *tempNum=[fomatter stringFromDate:picker.date];
    NSLog(@"%@====",tempNum);
    switch (i) {
        case 1:
            //
            _timeLabel1.text=tempNum;
            theTImeQuent=0;
            break;
        case 2:
            //
            _timeLabel2.text=tempNum;
             theTImeQuent=0;
            break;
        case 3:
            //
            _timeLabel3.text=tempNum;
             theTImeQuent=0;
            break;
        case 4:
            //
            _timeLabel4.text=tempNum;
             theTImeQuent=0;
            break;
        case 5:
            //
            _timeLabel5.text=tempNum;
             theTImeQuent=0;
            break;
        case 6:
            //
            _timeLabel6.text=tempNum;
            break;
            
        case 21:
            //
            _labelStart.text=tempNum;
             theTImeQuent=0;
            break;
        case 22:
            //
            _labelEnd.text=tempNum;
             theTImeQuent=0;
            break;
        case 111:
            //
            _timeLabel111.text=tempNum;
            break;
        case 222:
            //
            _timeLabel222.text=tempNum;
             theTImeQuent=0;
            break;
        case 333:
            //
            _timeLabel333.text=tempNum;
             theTImeQuent=0;
            break;
        case 444:
            //
            _timeLabel444.text=tempNum;
             theTImeQuent=0;
            break;
        case 555:
            //
            _timeLabel555.text=tempNum;
             theTImeQuent=0;
            break;
        case 666:
            //
            _timeLabel666.text=tempNum;
             theTImeQuent=0;
            break;
        case 1111:
            //
            timeLabel1111.text=tempNum;
             theTImeQuent=0;
            break;
        case 2222:
            //
            timeLabel2222.text=tempNum;
             theTImeQuent=0;
            break;
        case 3333:
            //
            timeLabel3333.text=tempNum;
             theTImeQuent=0;
            break;
        case 4444:
            //
            timeLabel4444.text=tempNum;
             theTImeQuent=0;
            break;
        case 5555:
            //
            timeLabel5555.text=tempNum;
             theTImeQuent=0;
            break;
        case 6666:
            //
            timeLabel6666.text=tempNum;
             theTImeQuent=0;
            break;
        default:
            break;
    }
}
-(void)buttonNO
{
    backgoundView.hidden=YES;
    datePickerView.hidden=YES;
}
-(void)buttonYESDDD
{
    backgoundView.hidden=YES;
    dateDateCHickView.hidden=YES;
    UIDatePicker *picker=(UIDatePicker*)[self.view viewWithTag:1000];
    NSDateFormatter *fomatter=[[NSDateFormatter alloc]init];
    fomatter.dateFormat=@"YYYY-MM-dd";
    NSLog(@"%@",[fomatter stringFromDate:picker.date]);
    NSString *tempNum=[fomatter stringFromDate:picker.date];
    NSLog(@"%@====",tempNum);
    
    self.dateDateStr=tempNum;
    NSString * timeStrRain111=[tempNum substringWithRange:NSMakeRange(8,2)];
    
    NSString * timeStrRain222=[tempNum substringWithRange:NSMakeRange(0,4)];
    NSString *timeStrRain333=[tempNum substringWithRange:NSMakeRange(5, 2)];
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
    
    
    _dateLabel.text=sumDay;
    
    
}
-(void)buttonNODDD
{
      backgoundView.hidden=YES;
    dateDateCHickView.hidden=YES;
}

-(IBAction)timeClick:(id)sender
{
    NSLog(@"_________");
    _dateLabel111.text=@"";
    if (_secondTable.hidden==YES) {
        _secondTable.hidden=NO;
    }
    else
        _secondTable.hidden=YES;
}
-(IBAction)timeBUtton111:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=111;
    theTImeQuent=0;
}
-(IBAction)timeBUtton222:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=222;
    theTImeQuent=0;
}

-(IBAction)timeBUtton333:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=333;
    theTImeQuent=0;
}
-(IBAction)timeBUtton444:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=444;
    theTImeQuent=0;
}
-(IBAction)timeBUtton555:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=555;
    theTImeQuent=0;
}
-(IBAction)timeBUtton666:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=666;
    theTImeQuent=0;
}

-(IBAction)WalkTimeClick:(id)sender
{
    walkTime.text=@"";
    if (threeTable.hidden==YES) {
        threeTable.hidden=NO;
    }
    else
    {
        threeTable.hidden=YES;
    }
}
-(IBAction)timeBUtton1111:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=1111;
    theTImeQuent=0;
}
-(IBAction)timeBUtton2222:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=2222;
    theTImeQuent=0;
}
-(IBAction)timeBUtton3333:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=3333;
    theTImeQuent=0;
}
-(IBAction)timeBUtton4444:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=4444;
    theTImeQuent=0;
}
-(IBAction)timeBUtton5555:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=5555;
    theTImeQuent=0;
}
-(IBAction)timeBUtton6666:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=6666;
    theTImeQuent=0;
}

-(void)delayDoneThread{
    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"Y" forKey:@"Frist Go to Calendar Key"];
    [defaults synchronize];
    
    
    
    //    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //    for (UILocalNotification *notification in notifications )
    //    {
    //
    //        @try {
    //
    //            if( ([[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp1"] ||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp2"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp3"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp4"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw1"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw2"]))
    //            {
    //                NSLog(@"========================");
    //
    //            }
    //            else
    //            {
    //                [[UIApplication sharedApplication] cancelLocalNotification:notification];
    //                NSLog(@"========================");
    //            }
    //        }
    //        @catch (NSException *exception) {
    //
    //        }
    //        @finally {
    //
    //        }
    //
    //
    //    }
    
    
    mR_List = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
    [DBHelper zhendeyouma:1];
    // mR_List.i=k;
    mR_List.dateDateStr=self.dateDateStr;
    NSMutableArray *allArray1;
    NSLog(@"____timeLabel1==%@",_timeLabel1.text);
    NSLog(@"______thetimeQuent=%d",theTImeQuent);
    if (k==1)
    {
        NSLog(@"+++++++++++++++++++++++++++++");
        tempsum1=@"Measurement";
        if (y==1) {
            tempsum2=@"Blood Pressure";
            
            self.typeStr=@"B";
        }
        if (y==2) {
            tempsum2=@"ECG";
            self.typeStr=@"E";
        }
        if (y==3) {
            tempsum2=@"Blood Glucose";
            self.typeStr=@"G";
        }
        {
            
            if ([_timeLabel1.text length]<3) {
                NSLog(@"-----1----------%@",_timeLabel1.text);
                theTImeQuent=3;
                
                //                if ([self.typeStr isEqualToString:@"B"])
                //                {
                //
                //               //     [DBHelper deleteCalendarBPList];
                //
                //
                //
                //                }
                //                else if([self.typeStr isEqualToString:@"E"])
                //                {
                //
                //                 //   [DBHelper deleteCalendarECGList];
                //
                //                }
                //                else
                //                {
                //
                //                 //   [DBHelper deleteCalendarBGList];
                //
                //                }
                _timeLabel1.text=@" " ;
                _timeLabel2.text=@" " ;
                _timeLabel3.text=@" " ;
                _timeLabel4.text=@" " ;
                _timeLabel5.text=@" " ;
                _timeLabel6.text=@" " ;
            }
            else if ([_timeLabel2.text length]<3) {
                NSLog(@"--------2-------%@",_timeLabel1.text);
                if ([_timeLabel1.text length]<3) {
                    theTImeQuent=3;
                }
                
                else
                {
                    theTImeQuent=0;
                    
                    if ([self.typeStr isEqualToString:@"B"])
                    {
                        
                        [DBHelper deleteCalendarBPList];
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBPId:strRAndom bpRepeat:@"" bptime:_timeLabel1.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm];
                    }
                    else if([self.typeStr isEqualToString:@"E"])
                    {
                        
                        [DBHelper deleteCalendarECGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm=[[Alarm alloc]initWithECGId:strRAndom ecgRepeat:@"" ecgtime:_timeLabel1.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm];
                    }
                    else
                    {
                        
                        [DBHelper deleteCalendarBGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBGId:strRAndom bgRepeat:@"" bgtime:_timeLabel1.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm];
                    }
                    tempSum_Url =[[NSString alloc]initWithFormat:@"%@",_timeLabel1.text];
                    _timeLabel2.text=@" " ;
                    _timeLabel3.text=@" " ;
                    _timeLabel4.text=@" " ;
                    _timeLabel5.text=@" " ;
                    _timeLabel6.text=@" " ;
                }
            }
            else  if ([_timeLabel3.text length]<3) {
                NSLog(@"--------3-------%@",_timeLabel1.text);
                if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3) {
                    theTImeQuent=3;
                }
                else if ([_timeLabel1.text isEqualToString:_timeLabel2.text])
                {
                    theTImeQuent=1;
                }
                else
                {
                    theTImeQuent=0;
                    
                    if ([self.typeStr isEqualToString:@"B"])
                    {
                        
                        [DBHelper deleteCalendarBPList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBPId:strRAndom bpRepeat:@"" bptime:_timeLabel1.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithBPId:strRandom2 bpRepeat:@"" bptime:_timeLabel2.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm2];
                    }
                    else if([self.typeStr isEqualToString:@"E"])
                    {
                        
                        [DBHelper deleteCalendarECGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm=[[Alarm alloc]initWithECGId:strRAndom ecgRepeat:@"" ecgtime:_timeLabel1.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithECGId:strRAndom2 ecgRepeat:@"" ecgtime:_timeLabel2.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm2];
                        
                    }
                    else
                    {
                        
                        [DBHelper deleteCalendarBGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBGId:strRAndom bgRepeat:@"" bgtime:_timeLabel1.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm];
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm2=[[Alarm alloc]initWithBGId:strRandom2 bgRepeat:@"" bgtime:_timeLabel2.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm2];
                    }
                    
                    
                    tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@",_timeLabel1.text,_timeLabel2.text];
                    _timeLabel3.text=@" " ;
                    _timeLabel4.text=@" " ;
                    _timeLabel5.text=@" " ;
                    _timeLabel6.text=@" " ;
                }
            }
            else  if ([_timeLabel4.text length]<3) {
                NSLog(@"--------4-------%@",_timeLabel1.text);
                if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3||[_timeLabel3.text length]<3) {
                    theTImeQuent=3;
                }
                else
                {
                    theTImeQuent=0;
                    
                    
                    if ([self.typeStr isEqualToString:@"B"])
                    {
                        
                        [DBHelper deleteCalendarBPList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBPId:strRAndom bpRepeat:@"" bptime:_timeLabel1.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm];
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithBPId:strRandom2 bpRepeat:@"" bptime:_timeLabel2.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        
                        
                        NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm3=[[Alarm alloc]initWithBPId:strRandom3 bpRepeat:@"" bptime:_timeLabel3.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm3];
                    }
                    else if([self.typeStr isEqualToString:@"E"])
                    {
                        
                        [DBHelper deleteCalendarECGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm=[[Alarm alloc]initWithECGId:strRAndom ecgRepeat:@"" ecgtime:_timeLabel1.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithECGId:strRAndom2 ecgRepeat:@"" ecgtime:_timeLabel2.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm3=[[Alarm alloc]initWithECGId:strRAndom3 ecgRepeat:@"" ecgtime:_timeLabel3.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm3];
                    }
                    else
                    {
                        
                        [DBHelper deleteCalendarBGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBGId:strRAndom bgRepeat:@"" bgtime:_timeLabel1.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm2=[[Alarm alloc]initWithBGId:strRandom2 bgRepeat:@"" bgtime:_timeLabel2.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm3=[[Alarm alloc]initWithBGId:strRandom3 bgRepeat:@"" bgtime:_timeLabel3.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm3];
                    }
                    
                    
                    
                    tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@",_timeLabel1.text,_timeLabel2.text,_timeLabel3.text];
                    _timeLabel4.text=@" " ;
                    _timeLabel5.text=@" " ;
                    _timeLabel6.text=@" " ;
                }
                
            }
            else   if ([_timeLabel5.text length]<3) {
                NSLog(@"--------5-------%@",_timeLabel1.text);
                if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3||[_timeLabel3.text length]<3||[_timeLabel4.text length]<3) {
                    theTImeQuent=3;
                }
                else
                {
                    theTImeQuent=0;
                    
                    
                    if ([self.typeStr isEqualToString:@"B"])
                    {
                        
                        [DBHelper deleteCalendarBPList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBPId:strRAndom bpRepeat:@"" bptime:_timeLabel1.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        NSLog(@"%d",random);
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithBPId:strRandom2 bpRepeat:@"" bptime:_timeLabel2.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        
                        
                        
                        NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm3=[[Alarm alloc]initWithBPId:strRandom3 bpRepeat:@"" bptime:_timeLabel3.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm3];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        
                        NSString *strRandom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm4=[[Alarm alloc]initWithBPId:strRandom4 bpRepeat:@"" bptime:_timeLabel4.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm4];
                    }
                    else if([self.typeStr isEqualToString:@"E"])
                    {
                        
                        [DBHelper deleteCalendarECGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm=[[Alarm alloc]initWithECGId:strRAndom ecgRepeat:@"" ecgtime:_timeLabel1.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithECGId:strRAndom2 ecgRepeat:@"" ecgtime:_timeLabel2.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm3=[[Alarm alloc]initWithECGId:strRAndom3 ecgRepeat:@"" ecgtime:_timeLabel3.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm3];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm4=[[Alarm alloc]initWithECGId:strRAndom4 ecgRepeat:@"" ecgtime:_timeLabel4.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm4];
                    }
                    else
                    {
                        
                        [DBHelper deleteCalendarBGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBGId:strRAndom bgRepeat:@"" bgtime:_timeLabel1.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm2=[[Alarm alloc]initWithBGId:strRandom2 bgRepeat:@"" bgtime:_timeLabel2.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm3=[[Alarm alloc]initWithBGId:strRandom3 bgRepeat:@"" bgtime:_timeLabel3.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm3];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm4=[[Alarm alloc]initWithBGId:strRandom4 bgRepeat:@"" bgtime:_timeLabel4.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm4];
                        
                    }
                    
                    tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@",_timeLabel1.text,_timeLabel2.text,_timeLabel3.text,_timeLabel4.text];
                    _timeLabel5.text=@" " ;
                    _timeLabel6.text=@" " ;
                }
            }
            else   if ([_timeLabel6.text length]>3) {
                
                NSLog(@"--------6-------%@",_timeLabel1.text);
                if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3||[_timeLabel3.text length]<3||[_timeLabel4.text length]<3||[_timeLabel5.text length]<3||[_timeLabel6.text length]<3) {
                    theTImeQuent=3;
                }
                else
                {
                    theTImeQuent=0;
                    
                    if ([self.typeStr isEqualToString:@"B"])
                    {
                        
                        [DBHelper deleteCalendarBPList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBPId:strRAndom bpRepeat:@"" bptime:_timeLabel1.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        
                        
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithBPId:strRandom2 bpRepeat:@"" bptime:_timeLabel2.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        
                        NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm3=[[Alarm alloc]initWithBPId:strRandom3 bpRepeat:@"" bptime:_timeLabel3.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm3];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm4=[[Alarm alloc]initWithBPId:strRandom4 bpRepeat:@"" bptime:_timeLabel4.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm4];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        
                        
                        NSString *strRandom5=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm5=[[Alarm alloc]initWithBPId:strRandom5 bpRepeat:@"" bptime:_timeLabel5.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm5];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        NSLog(@"%d",random);
                        
                        
                        
                        NSString *strRandom6=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm6=[[Alarm alloc]initWithBPId:strRandom6 bpRepeat:@"" bptime:_timeLabel6.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm6];
                    }
                    else if([self.typeStr isEqualToString:@"E"])
                    {
                        
                        [DBHelper deleteCalendarECGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm=[[Alarm alloc]initWithECGId:strRAndom ecgRepeat:@"" ecgtime:_timeLabel1.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithECGId:strRAndom2 ecgRepeat:@"" ecgtime:_timeLabel2.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm3=[[Alarm alloc]initWithECGId:strRAndom3 ecgRepeat:@"" ecgtime:_timeLabel3.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm3];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm4=[[Alarm alloc]initWithECGId:strRAndom4 ecgRepeat:@"" ecgtime:_timeLabel4.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm4];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom5=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm5=[[Alarm alloc]initWithECGId:strRAndom5 ecgRepeat:@"" ecgtime:_timeLabel5.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm5];
                        NSString * strRAndom6=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm6=[[Alarm alloc]initWithECGId:strRAndom6 ecgRepeat:@"" ecgtime:_timeLabel6.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm6];
                    }
                    else
                    {
                        [DBHelper deleteCalendarBGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBGId:strRAndom bgRepeat:@"" bgtime:_timeLabel1.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm2=[[Alarm alloc]initWithBGId:strRandom2 bgRepeat:@"" bgtime:_timeLabel2.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm2];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm3=[[Alarm alloc]initWithBGId:strRandom3 bgRepeat:@"" bgtime:_timeLabel3.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm3];
                        
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm4=[[Alarm alloc]initWithBGId:strRandom4 bgRepeat:@"" bgtime:_timeLabel4.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm4];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom5=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm5=[[Alarm alloc]initWithBGId:strRandom5 bgRepeat:@"" bgtime:_timeLabel5.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm5];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom6=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm6=[[Alarm alloc]initWithBGId:strRandom6 bgRepeat:@"" bgtime:_timeLabel6.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm6];
                        
                    }
                    
                    
                    tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@,%@",_timeLabel1.text,_timeLabel2.text,_timeLabel3.text,_timeLabel4.text,_timeLabel5.text,_timeLabel6.text];
                }
            }
            else    if ([_timeLabel6.text length]<3) {
                NSLog(@"--------7-------%@",_timeLabel1.text);
                if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3||[_timeLabel3.text length]<3||[_timeLabel4.text length]<3||[_timeLabel5.text length]<3) {
                    theTImeQuent=3;
                    
                }
                else
                {
                    theTImeQuent=0;
                    
                    
                    if ([self.typeStr isEqualToString:@"B"])
                    {
                        
                        [DBHelper deleteCalendarBPList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBPId:strRAndom bpRepeat:@"" bptime:_timeLabel1.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        NSLog(@"%d",random);
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithBPId:strRandom2 bpRepeat:@"" bptime:_timeLabel2.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm2];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        
                        NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm3=[[Alarm alloc]initWithBPId:strRandom3 bpRepeat:@"" bptime:_timeLabel3.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm3];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm4=[[Alarm alloc]initWithBPId:strRandom4 bpRepeat:@"" bptime:_timeLabel4.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm4];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        
                        
                        NSString *strRandom5=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm5=[[Alarm alloc]initWithBPId:strRandom5 bpRepeat:@"" bptime:_timeLabel5.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                        [DBHelper addCalendarRoadBP:malarm5];
                    }
                    else if([self.typeStr isEqualToString:@"E"])
                    {
                        
                        [DBHelper deleteCalendarECGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm=[[Alarm alloc]initWithECGId:strRAndom ecgRepeat:@"" ecgtime:_timeLabel1.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm2=[[Alarm alloc]initWithECGId:strRAndom2 ecgRepeat:@"" ecgtime:_timeLabel2.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm3=[[Alarm alloc]initWithECGId:strRAndom3 ecgRepeat:@"" ecgtime:_timeLabel3.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm3];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm4=[[Alarm alloc]initWithECGId:strRAndom4 ecgRepeat:@"" ecgtime:_timeLabel4.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm4];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom5=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm * malarm5=[[Alarm alloc]initWithECGId:strRAndom5 ecgRepeat:@"" ecgtime:_timeLabel5.text ecgtype:@"" ecgcreatetime:@"" ecgservertime:@""];
                        [DBHelper addCalendarRoadECG:malarm5];
                    }
                    else
                    {
                        
                        [DBHelper deleteCalendarBGList];
                        
                        
                        int random;
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm=[[Alarm alloc]initWithBGId:strRAndom bgRepeat:@"" bgtime:_timeLabel1.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm];
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        NSLog(@"%d",random);
                        NSString *strRandom2=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm2=[[Alarm alloc]initWithBGId:strRandom2 bgRepeat:@"" bgtime:_timeLabel2.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm2];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm3=[[Alarm alloc]initWithBGId:strRandom3 bgRepeat:@"" bgtime:_timeLabel3.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm3];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom4=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm4=[[Alarm alloc]initWithBGId:strRandom4 bgRepeat:@"" bgtime:_timeLabel4.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm4];
                        
                        
                        
                        //判断是否有网，需导入SystemConfiguration.framework框架
                        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                        switch ([rea currentReachabilityStatus])
                        {
                            case NotReachable:
                                random = (arc4random() % 100)-100000;
                                NSLog(@"没有网络");
                                break;
                            case ReachableViaWiFi:
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是wifi");
                                break;
                            case ReachableViaWWAN:/*电话卡的网*/
                                random = (arc4random() % 1000)-1000;
                                NSLog(@"网络是本地连接");
                                break;
                                
                                
                            default :
                                break;
                        }
                        
                        
                        
                        
                        NSLog(@"%d",random);
                        NSString *strRandom5=[[NSString alloc]initWithFormat:@"%d",random];
                        Alarm *malarm5=[[Alarm alloc]initWithBGId:strRandom5 bgRepeat:@"" bgtime:_timeLabel5.text bgtype:@"" bgcreatetime:@"" bgservertime:@""];
                        [DBHelper addCalendarRoadBG:malarm5];
                        
                    }
                    
                    
                    tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@",_timeLabel1.text,_timeLabel2.text,_timeLabel3.text,_timeLabel4.text,_timeLabel5.text];
                    _timeLabel6.text=@" " ;
                    
                }
                
            }
            
        }
        allArray1=[[NSMutableArray alloc]initWithObjects:tempsum1,tempsum2,_timeLabel1.text,_timeLabel2.text,_timeLabel3.text,_timeLabel4.text,_timeLabel5.text,_timeLabel6.text, nil];
        
    }
    if (k==2)
    {
        tempsum1=@"Medication";
        self.typeStr=@"M";
        
        if (_dostextView.text)
        {
            tempsum2=_dostextView.text;
        }
        
        //
        if ([_timeLabel111.text length]<3) {
            theTImeQuent=3;
            
            _timeLabel111.text=@" " ;
            _timeLabel222.text=@" " ;
            _timeLabel333.text=@" " ;
            _timeLabel444.text=@" " ;
            _timeLabel555.text=@" " ;
            _timeLabel666.text=@" " ;
        }
        else if ([_timeLabel222.text length]<3) {
            if ([_timeLabel111.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@",_timeLabel111.text];
                tempsum3 =[[NSString alloc]initWithFormat:@"%@",_timeLabel111.text];
                theTaken=[[NSString alloc]initWithFormat:@"N "];
                _timeLabel222.text=@" " ;
                _timeLabel333.text=@" " ;
                _timeLabel444.text=@" " ;
                _timeLabel555.text=@" " ;
                _timeLabel666.text=@" " ;
            }
        }
        else if ([_timeLabel333.text length]<3) {
            if ([_timeLabel111.text length]<3||[_timeLabel222.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@",_timeLabel111.text,_timeLabel222.text];
                tempsum3 =[[NSString alloc]initWithFormat:@"%@ %@",_timeLabel111.text,_timeLabel222.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N "];
                _timeLabel333.text=@" " ;
                _timeLabel444.text=@" " ;
                _timeLabel555.text=@" " ;
                _timeLabel666.text=@" " ;
            }
        }
        else if (_timeLabel444.text==nil) {
            if ([_timeLabel111.text length]<3||[_timeLabel222.text length]<3||[_timeLabel333.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@",_timeLabel111.text,_timeLabel222.text,_timeLabel333.text];
                tempsum3 =[[NSString alloc]initWithFormat:@"%@ %@ %@",_timeLabel111.text,_timeLabel222.text,_timeLabel333.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N N "];
                _timeLabel444.text=@" " ;
                _timeLabel555.text=@" " ;
                _timeLabel666.text=@" " ;
            }
        }
        else if ([_timeLabel555.text length]<3) {
            if ([_timeLabel111.text length]<3||[_timeLabel222.text length]<3||[_timeLabel333.text length]<3||[_timeLabel444.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@",_timeLabel111.text,_timeLabel222.text,_timeLabel333.text,_timeLabel444.text];
                tempsum3 =[[NSString alloc]initWithFormat:@"%@ %@ %@ %@",_timeLabel111.text,_timeLabel222.text,_timeLabel333.text,_timeLabel444.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N N N "];
                _timeLabel555.text=@" " ;
                _timeLabel666.text=@" " ;
            }
        }
        else if ([_timeLabel666.text length]>3) {
            if ([_timeLabel111.text length]<3||[_timeLabel222.text length]<3||[_timeLabel333.text length]<3||[_timeLabel444.text length]<3||[_timeLabel555.text length]<3||[_timeLabel666.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@,%@",_timeLabel111.text,_timeLabel222.text,_timeLabel333.text,_timeLabel444.text,_timeLabel555.text,_timeLabel666.text];
                tempsum3 =[[NSString alloc]initWithFormat:@"%@ %@ %@ %@ %@ %@",_timeLabel111.text,_timeLabel222.text,_timeLabel333.text,_timeLabel444.text,_timeLabel555.text,_timeLabel666.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N N N N N "];
            }
        }
        
        else if ([_timeLabel666.text length]<3) {
            if ([_timeLabel111.text length]<3||[_timeLabel222.text length]<3||[_timeLabel333.text length]<3||[_timeLabel444.text length]<3||[_timeLabel555.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@",_timeLabel111.text,_timeLabel222.text,_timeLabel333.text,_timeLabel444.text,_timeLabel555.text];
                _timeLabel666.text=@" " ;
                tempsum3 =[[NSString alloc]initWithFormat:@"%@ %@ %@ %@ %@",_timeLabel111.text,_timeLabel222.text,_timeLabel333.text,_timeLabel444.text,_timeLabel555.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N N N N "];
            }
        }
        
        
        
        if (_agetextView.text) {
            tempsum4=_agetextView.text;
        }
        else
        {
            tempsum4=@"       ";
        }
        
        allArray1=[[NSMutableArray alloc]initWithObjects:tempsum1,tempsum2,_timeLabel111.text,_timeLabel222.text,_timeLabel333.text,_timeLabel444.text,_timeLabel555.text,_timeLabel666.text,tempsum4,nil];
        
        
        
    }
    if (k==3) {
        NSLog(@"_________________labelStart.text===%@",_labelStart.text);
        tempsum1=@"Other";
        self.typeStr=@"A";
        if (_textField.text) {
            tempsum2=_textField.text;
            
        }
        else
        {
            tempsum2=@"     ";
        }
        if ([_labelStart.text length]<2||[_labelEnd.text length]<2)
        {
            theTImeQuent=3;
        }
        else if([_labelStart.text isEqualToString:_labelEnd.text])
        {
            theTImeQuent=1;
        }
        else if ([_labelStart.text length]>3||[_labelEnd.text length]>2)
        {
            
            NSString *start1TempRain=[_labelStart.text substringWithRange:NSMakeRange(0, 2)];
            NSString *start2TempRain=[_labelStart.text substringWithRange:NSMakeRange(3, 2)];
            NSString *startall=[[NSString alloc]initWithFormat:@"%@%@",start1TempRain,start2TempRain];
            
            NSString *end1TempRain=[_labelEnd.text substringWithRange:NSMakeRange(0, 2)];
            NSString *end2TempRain=[_labelEnd.text substringWithRange:NSMakeRange(3, 2)];
            NSString *endall=[[NSString alloc]initWithFormat:@"%@%@",end1TempRain,end2TempRain];
            if ([startall intValue]>[endall intValue]) {
                theTImeQuent=2;
                
                
            }
            else
            {
                theTImeQuent=0;
            }
            NSLog(@"_labelStart.text intValue]===%@ [_labelEnd.text intValue]--=%@",startall,endall);
        }
        else
        {
            theTImeQuent=0;
        }
        
        tempsum3 =[[NSString alloc]initWithFormat:@"   %@   %@-%@",self.dateDateStr,_labelStart.text,_labelEnd.text];
        
        if (_textView.text) {
            tempsum4=_textView.text;
        }
        else
        {
            tempsum4=@"        ";
        }
        allArray1=[[NSMutableArray alloc]initWithObjects:tempsum1,tempsum2,_labelStart.text,_labelEnd.text,_dateLabel.text,tempsum4, nil];
    }
    
    if (k==4) {
        
        self.typeStr=@"K";
        
        if ([timeLabel1111.text length]<3) {
            theTImeQuent=3;
            //     [DBHelper deleteCalendarWalkingList];
            
            
            
            
            timeLabel1111.text=@" " ;
            timeLabel2222.text=@" " ;
            timeLabel3333.text=@" " ;
            timeLabel4444.text=@" " ;
            timeLabel5555.text=@" " ;
            timeLabel6666.text=@" " ;
        }
        else if ([timeLabel2222.text length]<3) {
            if ([timeLabel1111.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                [DBHelper deleteCalendarWalkingList];
                
                
                int random;
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                    default :
                        break;
                }
                
                
                NSLog(@"%d",random);
                NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@",timeLabel1111.text];
                timeLabel2222.text=@" " ;
                timeLabel3333.text=@" " ;
                timeLabel4444.text=@" " ;
                timeLabel5555.text=@" " ;
                timeLabel6666.text=@" " ;
            }
        }
        else if ([timeLabel3333.text length]<3) {
            if ([timeLabel1111.text length]<3||[timeLabel2222.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                [DBHelper deleteCalendarWalkingList];
                
                
                int random;
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                    default :
                        break;
                }
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm2];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@",timeLabel1111.text,timeLabel2222.text];
                timeLabel3333.text=@" " ;
                timeLabel4444.text=@" " ;
                timeLabel5555.text=@" " ;
                timeLabel6666.text=@" " ;
            }
        }
        else if ([timeLabel4444.text length]<3) {
            if ([timeLabel1111.text length]<3||[timeLabel2222.text length]<3||[timeLabel3333.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                [DBHelper deleteCalendarWalkingList];
                
                
                int random;
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                NSLog(@"%d",random);
                NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm2];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                NSLog(@"%d",random);
                NSString * strRAndom3=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm3=[[Alarm alloc]initWithWalkingId:strRAndom3 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel3333.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm3];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@",timeLabel1111.text,timeLabel2222.text,timeLabel3333.text];
                timeLabel4444.text=@" " ;
                timeLabel5555.text=@" " ;
                timeLabel6666.text=@" " ;
            }
        }
        else if ([timeLabel5555.text length]<3) {
            if ([timeLabel1111.text length]<3||[timeLabel2222.text length]<3||[timeLabel3333.text length]<3||[timeLabel4444.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                [DBHelper deleteCalendarWalkingList];
                
                
                int random;
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm2];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom3=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm3=[[Alarm alloc]initWithWalkingId:strRAndom3 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel3333.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm3];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                NSLog(@"%d",random);
                NSString * strRAndom4=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm4=[[Alarm alloc]initWithWalkingId:strRAndom4 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel4444.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm4];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@",timeLabel1111.text,timeLabel2222.text,timeLabel3333.text,timeLabel4444.text];
                timeLabel5555.text=@" " ;
                timeLabel6666.text=@" " ;
            }
        }
        else if ([timeLabel6666.text length]>3) {
            if ([timeLabel1111.text length]<3||[timeLabel2222.text length]<3||[timeLabel3333.text length]<3||[timeLabel4444.text length]<3||[timeLabel5555.text length]<3||[timeLabel6666.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                [DBHelper deleteCalendarWalkingList];
                
                
                int random;
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                NSLog(@"%d",random);
                NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                    default :
                        break;
                }
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm2];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                NSString * strRAndom3=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm3=[[Alarm alloc]initWithWalkingId:strRAndom3 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel3333.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm3];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                NSLog(@"%d",random);
                NSString * strRAndom4=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm4=[[Alarm alloc]initWithWalkingId:strRAndom4 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel4444.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm4];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom5=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm5=[[Alarm alloc]initWithWalkingId:strRAndom5 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel5555.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm5];
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                NSLog(@"%d",random);
                NSString * strRAndom6=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm6=[[Alarm alloc]initWithWalkingId:strRAndom6 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel6666.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm6];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@,%@",timeLabel1111.text,timeLabel2222.text,timeLabel3333.text,timeLabel4444.text,timeLabel5555.text,timeLabel6666.text];
            }
        }
        
        else if ([timeLabel6666.text length]<3) {
            if ([timeLabel1111.text length]<3||[timeLabel2222.text length]<3||[timeLabel3333.text length]<3||[timeLabel4444.text length]<3||[timeLabel5555.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                [DBHelper deleteCalendarWalkingList];
                
                
                int random;
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                NSLog(@"%d",random);
                NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                NSLog(@"%d",random);
                NSString * strRAndom2=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm2];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                NSLog(@"%d",random);
                NSString * strRAndom3=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm3=[[Alarm alloc]initWithWalkingId:strRAndom3 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel3333.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm3];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom4=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm4=[[Alarm alloc]initWithWalkingId:strRAndom4 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel4444.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm4];
                
                
                
                //判断是否有网，需导入SystemConfiguration.framework框架
                rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
                switch ([rea currentReachabilityStatus])
                {
                    case NotReachable:
                        random = (arc4random() % 100)-100000;
                        NSLog(@"没有网络");
                        break;
                    case ReachableViaWiFi:
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是wifi");
                        break;
                    case ReachableViaWWAN:/*电话卡的网*/
                        random = (arc4random() % 1000)-1000;
                        NSLog(@"网络是本地连接");
                        break;
                        
                        
                    default :
                        break;
                }
                
                
                
                NSLog(@"%d",random);
                NSString * strRAndom5=[[NSString alloc]initWithFormat:@"%d",random];
                Alarm *malarm5=[[Alarm alloc]initWithWalkingId:strRAndom5 StartDate:self.dateDateStr EndDate:self.sevenDateStr Type:@"" Time:timeLabel5555.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm5];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@",timeLabel1111.text,timeLabel2222.text,timeLabel3333.text,timeLabel4444.text,timeLabel5555.text];
                
                timeLabel6666.text=@" " ;
            }
            
        }
    }
    
    NSTimer *timer;
    //    if ([_timeLabel1.text length]>3||[_timeLabel111.text length]>3||[timeLabel1111.text length]>3) {
    //        
    //        theTImeQuent=0;
    //    }
    switch (theTImeQuent) {
            
        case 0:
            NSLog(@"K===%d",k);
            NSLog(@"photoView.hidden==%d",photoView.hidden);
            NSLog(@"imageBaseStr=%@",imageBase64Str);
            
            if (k==2)
            {
                if (photoView.hidden==1)
                {
                    
                    [self sendResult];
                }
                else
                {
                    if ([imageBase64Str isEqualToString:@""])
                    {
                        
                        if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
                            thebackTitlelabel.text=@"The pictures haven't finished yet.";
                        }
                        else
                        {
                            thebackTitlelabel.text=@"圖片還沒加載完畢";
                        }
                        thebackTitlelabel.hidden=NO;
                        [self.view bringSubviewToFront:thebackTitlelabel];
                        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
                        NSLog(@"圖片沒有加載完畢");
                    }
                    else
                    {
                        [self sendResult];
                    }
                    
                    
                    
                }
            }
            else
            {
                [self sendResult];
            }
            //  if (_theView.hidden==YES)
            //   {
            
            //   }
            
            break;
            
        case 1:
            if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
                thebackTitlelabel.text=@"Cannot appear in the same time";
            }
            else
            {
                thebackTitlelabel.text=@"不能出現相同時間";
            }
            thebackTitlelabel.hidden=NO;
            [self.view bringSubviewToFront:thebackTitlelabel];
            NSLog(@"不能出現相同時間");
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
            break;
        case 2:
            
            if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
                thebackTitlelabel.text=@"The end time cannot be less than the start time";
            }
            else
            {
                thebackTitlelabel.text=@"結束時間不能小於開始時間";
            }
            thebackTitlelabel.hidden=NO;
            [self.view bringSubviewToFront:thebackTitlelabel];
            NSLog(@"結束時間不能大於開始時間");
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
            
            break;
        case 3:
            
            if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
                thebackTitlelabel.text=@"Please re-determine the good times with time";
            }
            else
            {
                thebackTitlelabel.text=@"請從新確定好次數跟時間";
            }
            thebackTitlelabel.hidden=NO;
            [self.view bringSubviewToFront:thebackTitlelabel];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
            NSLog(@"時間不能爲空");
            // [self viewDidLoad];
            break;
        default:
            break;
    }
    
    
    
    
    [doneButtonFontText setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p1.png"] forState:UIControlStateNormal];
    
}




-(IBAction)Done:(id)sender{
    [doneButtonFontText setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    [self performSelector:@selector(delayDoneThread) withObject:nil afterDelay:0.1];
}

-(void)timerFired
{
    NSLog(@"+++++++++++++++++++++");
    thebackTitlelabel.hidden=YES;
}
-(void)sendResult
{
    

    _theView.hidden=NO;

    
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
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
    NSLog(@"urlString=%@",url_string);
    if (k==1) {
        if (y==1&&self.timeBloodMutableArray.count>0) {
            url_string = [url_string stringByAppendingString:@"&action=U"];
        }
        else if (y==2&&self.timeECGMutableArray.count>0)
        {
            url_string = [url_string stringByAppendingString:@"&action=U"];
        }
        else if (y==3&&self.timeGlucoseMutableArray.count>0)
        {
            url_string = [url_string stringByAppendingString:@"&action=U"];
        }
        else
        {
            url_string = [url_string stringByAppendingString:@"&action=A"];
        }
    }
    else if (k==4)
    {
        if (self.timeWalkMutableArray.count>0)
        {
            url_string = [url_string stringByAppendingString:@"&action=U"];
        }
        else
        {
            url_string = [url_string stringByAppendingString:@"&action=A"];
        }
    }
    else
    {
        url_string = [url_string stringByAppendingString:@"&action=A"];
    }
    
    url_string = [url_string stringByAppendingString:@"&type="];
    url_string = [url_string stringByAppendingString:self.typeStr];
    if ([self.typeStr isEqualToString:@"B"]||[self.typeStr isEqualToString:@"E"]||[self.typeStr isEqualToString:@"G"])
    {
        
        if (y==1&&self.timeBloodMutableArray.count>0) {
            url_string = [url_string stringByAppendingString:@"&id=-1"];
        }
        else if (y==2&&self.timeECGMutableArray.count>0)
        {
            url_string = [url_string stringByAppendingString:@"&id=-1"];
        }
        else if (y==3&&self.timeGlucoseMutableArray.count>0)
        {
            url_string = [url_string stringByAppendingString:@"&id=-1"];
        }
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:tempSum_Url];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        
        
    }
    if ([self.typeStr isEqualToString:@"A"])
    {
       
        
        url_string = [url_string stringByAppendingString:@"&startdate="];
        url_string = [url_string stringByAppendingString:self.dateDateStr];
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:_labelStart.text];
        url_string = [url_string stringByAppendingString:@"&endtime="];
        url_string = [url_string stringByAppendingString:_labelEnd.text];
        url_string = [url_string stringByAppendingString:@"&title="];
        url_string = [url_string stringByAppendingString:_textField.text];
        url_string = [url_string stringByAppendingString:@"&note="];
        url_string = [url_string stringByAppendingString:_textView.text];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        
        
//        int random;
//        
//        //判断是否有网，需导入SystemConfiguration.framework框架
//        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
//        switch ([rea currentReachabilityStatus])
//        {
//            case NotReachable:
//                random = (arc4random() % 100)-100000;
//                NSLog(@"没有网络");
//                break;
//            case ReachableViaWiFi:
//                random = (arc4random() % 1000)-1000;
//                NSLog(@"网络是wifi");
//                break;
//            case ReachableViaWWAN:/*电话卡的网*/
//                random = (arc4random() % 1000)-1000;
//                NSLog(@"网络是本地连接");
//                break;
//                
//                
//            default :
//                break;
//        }
//
//        
//        
//
//        NSLog(@"%d",random);
//  
        
    }
    if ([self.typeStr isEqualToString:@"M"]) {
//        NSString * str1=[_dostextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str1);
//        NSString * str2=[_agetextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str2);
//        NSString * str3=[imageBase64Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str3);
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:tempSum_Url];
        url_string = [url_string stringByAppendingString:@"&title="];
        url_string = [url_string stringByAppendingString:_dostextView.text];
        url_string = [url_string stringByAppendingString:@"&dosage="];
        url_string = [url_string stringByAppendingString:_agetextView.text];
        url_string = [url_string stringByAppendingString:@"&meal="];
        url_string = [url_string stringByAppendingString:self.banMEAL];
        url_string = [url_string stringByAppendingString:@"&img="];
        url_string = [url_string stringByAppendingString:imageBase64Str];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        url_string = [url_string stringByAppendingString:@"&note="];
        url_string = [url_string stringByAppendingString:self.medication_Note_TextView.text];
        
        
//        
//        int random;
//        
//        //判断是否有网，需导入SystemConfiguration.framework框架
//        rea=[Reachability reachabilityWithHostName:@"www.baidu.com"];
//        switch ([rea currentReachabilityStatus])
//        {
//            case NotReachable:
//                random = (arc4random() % 100)-100000;
//                NSLog(@"没有网络");
//                break;
//            case ReachableViaWiFi:
//                random = (arc4random() % 1000)-1000;
//                NSLog(@"网络是wifi");
//                break;
//            case ReachableViaWWAN:/*电话卡的网*/
//                random = (arc4random() % 1000)-1000;
//                NSLog(@"网络是本地连接");
//                break;
//                
//                
//            default :
//                break;
//        }
//
//        
//        
//
//        NSLog(@"%d",random);
//        NSString * strRAndom=[[NSString alloc]initWithFormat:@"%d",random];
//       Alarm* alarm=[[Alarm alloc]initWithMedicationId:strRAndom Title:_dostextView.text Meal:self.banMEAL DosAge:_agetextView.text Servertime:currentDateStr ReminderTime:tempsum3 ReminderID:@"" ReminderType:@"" ReminderRepeat:@"" ReminderTicken:theTaken ReminderCreateTime:@"" ReminderserverTime:@""];
//        [DBHelper addCalendarRoadMedication:alarm];
    }
    if ([self.typeStr isEqualToString:@"K"]) {
        if (self.timeWalkMutableArray.count>0) {
            
            url_string = [url_string stringByAppendingString:@"&id=-1"];
        }
            url_string=[url_string stringByAppendingString:@"&startdate="];
            url_string=[url_string stringByAppendingString:self.dateDateStr];
            url_string=[url_string stringByAppendingString:@"&enddate="];
            url_string=[url_string stringByAppendingString:self.sevenDateStr];
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:tempSum_Url];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
    }
    
    NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];


    NSURL *request_url = [NSURL URLWithString:encodedString];
    
    NSLog(@"request_url:%@",encodedString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [ NSData dataWithBytes: [ [url_string encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
    
    if ((requestData == nil) || [syncUtility XMLHasError:requestData]) {
        NSLog(@"Get BP History error!");
    }
    NSLog(@"requestData=%@",requestData);
    [request setHTTPBody:requestData];
    NSLog(@"request = %@",request);
//    NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@+_+_+_",ionaSr);
    
//    [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (data != nil && error == nil)
                               {
                                   //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                   // It worked, your source HTML is in sourceHTML
                                   
                                   NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
                                   NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
                                   
                                   if ([self.typeStr isEqualToString:@"M"])
                                   {
                               
                              

                                       
                                       
                                       
                                       
                                       DDXMLDocument*doc= [[DDXMLDocument alloc] initWithXMLString:xmlSTr options:0 error:nil];
                                       NSLog(@"%@=++++++++++++",doc);
                                       
                                       NSArray *allArray=[doc  children];
                                       NSLog(@" allArray= %@",allArray);
                                       
                                       
                                       NSString * str=[[NSString alloc]initWithFormat:@"%@",allArray];
                                       NSLog(@"___+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+__+_+_+_+_+_+_%lu,%@",(unsigned long)[str length],allArray);
                                       if ([str length]<100)
                                       {
                                           NSLog(@"Error Error Error");
                                       }
                                       else
                                       {
                                           
                                           
                                           for(DDXMLElement * medidObject in allArray)
                                           {
                                               DDXMLElement *medidElement=[medidObject elementForName:@"medid"];
                                               NSString *medidAdHoc=[medidElement stringValue];
                                               NSLog(@"ADHoc=%@",medidAdHoc);
                                               NSLog(@":self.banMEAL:self.banMEAL:self.banMEAL:self.banMEAL:self.banMEAL:self.banMEAL=======%@",self.banMEAL);
                                
//                                               Alarm* alarm=[[Alarm alloc]initWithMedicationId:medidAdHoc Title:_dostextView.text Meal:self.banMEAL DosAge:_agetextView.text Servertime:currentDateStr ReminderTime:tempsum3 ReminderID:@"" ReminderType:@"" ReminderRepeat:@"" ReminderTicken:theTaken ReminderCreateTime:@"" ReminderserverTime:@"" ReminderImageString:@""];
                                               
                                               Alarm *alarm=[[Alarm alloc] initWithMedicationId:medidAdHoc Title:_dostextView.text Meal:self.banMEAL DosAge:_agetextView.text Servertime:currentDateStr ReminderTime:tempsum3 ReminderID:@"" ReminderType:@"" ReminderRepeat:@"" ReminderTicken:theTaken ReminderCreateTime:@"" ReminderserverTime:@"" ReminderImageString:imageBase64Str Note:self.medication_Note_TextView.text];
#pragma mark--Base64
                                               [DBHelper addCalendarRoadMedication:alarm];
                                               [DBHelper addCalendarRoadMedication_Notes:alarm];
                                               
                                          _theView.hidden=YES;
                                                 [self.navigationController pushViewController:mR_List animated:YES];
                                           }
                                           
                                           
                                       }
                                       
                                   }
                                  else if ([self.typeStr isEqualToString:@"A"])
                                   {
                                       
                                       
                                       DDXMLDocument*doc= [[DDXMLDocument alloc] initWithXMLString:xmlSTr options:0 error:nil];
                                       NSLog(@"%@=++++++++++++",doc);
                                       
                                       NSArray *allArray=[doc  children];
                                       NSLog(@" allArray= %@",allArray);
                                       
                                       
                                       NSString * str=[[NSString alloc]initWithFormat:@"%@",allArray];
                                       NSLog(@"___+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+__+_+_+_+_+_+_%lu,%@",(unsigned long)[str length],allArray);
                                       if ([str length]<100)
                                       {
                                           NSLog(@"Error Error Error");
                                       }
                                       else
                                       {
                                           for(DDXMLElement * medidObject in allArray)
                                           {
                                               DDXMLElement *medidElement=[medidObject elementForName:@"id"];
                                               NSString *medidAdHoc=[medidElement stringValue];
                                               NSLog(@"ADHoc=%@",medidAdHoc);
                                               
                                               
                                              
                                               Alarm*  alarm =[[Alarm alloc]initWithOthersId:medidAdHoc Title:_textField.text StartTime:_labelStart.text EndTime:_labelEnd.text Note:_textView.text Date:self.dateDateStr Type:@"" Createtime:currentDateStr Servertime:currentDateStr];
                                               [DBHelper addCalendarRoadOthers:alarm];
                                                 _theView.hidden=YES;
                                                 [self.navigationController pushViewController:mR_List animated:YES];
                                           }
                                           
                                           
                                       }
                                       
                                   }
                                   else
                                   {
                                        _theView.hidden=YES;
                                         [self.navigationController pushViewController:mR_List animated:YES];
                                   }
                                   
                                   
                               }
                               else
                               {
                                   // There was an error, alert the user
                                   NSLog(@"*/*/*/******");
                               }
                               
                           }];
    
    //NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    
    //NSString *xmlSTr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@====================",xmlSTr);
    
   // NSLog(@"%lu",(unsigned long)[xmlData length]);
    //    if (xmlData){
    //        int isSucc = [Utility isSucc:xmlData];
    //        NSLog(@"is upload Weight record successfully:%d",isSucc);
    //
    //        [DBHelper addDairyRecord:DairyArray];
    //    }
    
}

//
//- (BOOL)textView:(UITextView *)textView1 shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    //第二种取消键盘时间点（按下Return键）
//    
//    if ([text isEqualToString:@"\n"])
//    {
//        if (textView1==_textView) {
//            //
//            return YES;
//        }
//        //
//        else
//            return NO;
//
//    }
//    return YES;
//}
-(IBAction)Delete:(id)sender
{
    
    
    [celeleButtonTextFont setBackgroundImage:[UIImage imageNamed:@"btn_red_p1_effect.png"] forState:UIControlStateNormal];
    
    [self performSelector:@selector(delayDeleteThread) withObject:nil afterDelay:0.1];

    
    
}
-(void)delayDeleteThread{
    [self.navigationController popViewControllerAnimated:YES];
    [celeleButtonTextFont setBackgroundImage:[UIImage imageNamed:@"00_btn_red_p1.png"] forState:UIControlStateNormal];

    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"Nlosdsadsadasd");
    if (textView==_textView)
    {
        if (!iPad) {
            __scrollView.frame=CGRectMake(0, -100, 320, 358);
            
          
            
        }
        else
        {
            __scrollView.frame=CGRectMake(0, -100, 320, 275);
        }
  
    }
    else
    {
         labelText_NOte.hidden=YES;
        if (!iPad) {
           //_backguandView.frame=CGRectMake(0, -150, 320, 358);
            
            self.medication_Note_TextView.tag=111;
            
            CGSize scrollViewContenSize=_backguandView.contentSize;

            scrollViewContenSize.height=scrollViewContenSize.height+260;
            
            _backguandView.contentSize=scrollViewContenSize;
            
            CGPoint bottomOffset = CGPointMake(0, _backguandView.contentSize.height - _backguandView.bounds.size.height-20);
            
            [_backguandView setContentOffset:bottomOffset animated:YES];
            
//            [_backguandView scrollRectToVisible:CGRectMake(0, 640, 320, 90) animated:YES];

          //  NSLog(@"adjust view for keyboard......");
            
        }
        else
        {
            _backguandView.frame=CGRectMake(0, -150, 320, 275);
        }
        
    }
  
}

-(IBAction)BacktoCalendar:(id)sender
{
    
    DiaryViewController *daia=[[DiaryViewController alloc]initWithNibName:@"DiaryViewController" bundle:nil];
    [self.navigationController pushViewController:daia animated:YES];
  
}
-(IBAction)BeforeMeal:(id)sender
{
    beforeMealButton.image=ridaoOn ;
    afterMealButton .image=ridaoOff;
    naButton.image=ridaoOff;
    NSLog(@"Before Meal");
    self.banMEAL=@"B";
}
-(IBAction)AfterMeal:(id)sender
{
    beforeMealButton.image=ridaoOff ;
    afterMealButton .image=ridaoOn;
    naButton.image=ridaoOff;
    NSLog(@"Aftef Meal");
    self.banMEAL=@"A";
    
}
-(IBAction)NA:(id)sender
{
    beforeMealButton.image=ridaoOff ;
    afterMealButton .image=ridaoOff;
    naButton.image=ridaoOn;
    self.banMEAL=@"N";
}



- (void)leaveEditMode
{
    
    
    
    if ([self.medication_Note_TextView.text isEqualToString:@" "]||[self.medication_Note_TextView.text isEqualToString:@""]||self.medication_Note_TextView.text==nil||self.medication_Note_TextView.text==NULL) {
        labelText_NOte.hidden=NO;
    }
    else
    {
        labelText_NOte.hidden=YES;
    }
    
    [_textView resignFirstResponder];
    [_dostextView resignFirstResponder];
    [_agetextView resignFirstResponder];
    [_textField resignFirstResponder];
     [self.medication_Note_TextView resignFirstResponder];
           NSLog(@"[UIDevice currentDevice].systemVersion.floatValue==%f",[UIDevice currentDevice].systemVersion.floatValue);
    if (!iPad) {
        __scrollView.frame=CGRectMake(0, 0, 320, 358);
         _backguandView.frame=CGRectMake(0, 0, 320,358);
        
        
        if (self.medication_Note_TextView.tag==111) {
            
            self.medication_Note_TextView.tag=222;
            
            if (photoImageVIew) {
                
                if (photoImageVIew.image) {
                    
                    medicationSecondView.frame=CGRectMake(0, 180+140, 320, 230+100);
                    
                    CGSize tmp=_backguandView.contentSize;
                    
                    tmp.height=tmp.height-260;
                    
                    _backguandView.contentSize=tmp;
                    
                    CGPoint bottomOffset = CGPointMake(0, _backguandView.contentSize.height - _backguandView.bounds.size.height);
                    
                    [_backguandView setContentOffset:bottomOffset animated:YES];
                    
                }else{
                    
                    CGSize tmp=_backguandView.contentSize;
                    
                    tmp.height=tmp.height-260;
                    
                    _backguandView.contentSize=tmp;
                    
                    CGPoint bottomOffset = CGPointMake(0, _backguandView.contentSize.height - _backguandView.bounds.size.height);
                    
                    [_backguandView setContentOffset:bottomOffset animated:YES];
                    
                    medicationSecondView.frame=CGRectMake(0, 170, 320, 330);
                }
                
            }else{
                
                CGSize tmp=_backguandView.contentSize;
                
                tmp.height=tmp.height-260;
                
                _backguandView.contentSize=tmp;
                
                CGPoint bottomOffset = CGPointMake(0, _backguandView.contentSize.height - _backguandView.bounds.size.height);
                
                [_backguandView setContentOffset:bottomOffset animated:YES];
                
                medicationSecondView.frame=CGRectMake(0, 170, 320, 330);
            }

            
        }
        
        

        
        
  
       
    }
    else
    {
        __scrollView.frame=CGRectMake(0, 0, 320, 275);
         _backguandView.frame=CGRectMake(0, 0, 320, 275);
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textField==_agetextView||textField==_dostextView");
    if (textField==_dostextView)
    {
        NSLog(@"textField==_agetextView||textField==_dostextView");
        if (!iPad) {
            
        }
        else
        {

               // [_backguandView    _backguandView.frame=CGRectMake(0, -60, 320, 275);e(0, 65) animated:YES];
            _backguandView.frame=CGRectMake(0, -60, 320, 275);
 
        }
        
    }
   else if (textField==_agetextView)
    {
        NSLog(@"textField==_agetextView||textField==_dostextView");
        if (!iPad) {
            
        }
        else
        {
            
            // [_backguandView    _backguandView.frame=CGRectMake(0, -60, 320, 275);e(0, 65) animated:YES];
            _backguandView.frame=CGRectMake(0, -85, 320, 275);
            
        }
        
    }

    
    
}

-(void)textViewDidChange:(UITextView *)textView {
    CGRect line = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top );
    if ( overflow > 0 ) {
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 17; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated: or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
}

-(IBAction)medicinePhotoClick:(id)sender
{
    [_textView resignFirstResponder];
    [_dostextView resignFirstResponder];
    [_agetextView resignFirstResponder];
    [_textField resignFirstResponder];
     [self.medication_Note_TextView resignFirstResponder];
    NSLog(@"[UIDevice currentDevice].systemVersion.floatValue==%f",[UIDevice currentDevice].systemVersion.floatValue);
    if (!iPad) {
        __scrollView.frame=CGRectMake(0, 0, 320, 358);
        
        
    }
    else
    {
        __scrollView.frame=CGRectMake(0, 0, 320, 275);
        _backguandView.frame=CGRectMake(0, 0, 320, 275);
    }

    photoChickViewBlackGuandView=[[UIView alloc]init];
    UIView * whiteButtonPhotoLittleBackGuandView=[[UIView alloc]init];
    whiteButtonPhotoLittleBackGuandView.backgroundColor=[UIColor whiteColor];
       [photoChickViewBlackGuandView addSubview:whiteButtonPhotoLittleBackGuandView];
    [whiteButtonPhotoLittleBackGuandView.layer setCornerRadius:5.0];
    UILabel *lineLabe=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, 300, 1)];
    lineLabe.backgroundColor= [UIColor colorWithWhite:0.8 alpha:0.5];
    [whiteButtonPhotoLittleBackGuandView addSubview:lineLabe];
    UIButton *takePhotoBUtton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    takePhotoBUtton.backgroundColor=[UIColor clearColor];
    [takePhotoBUtton setTitle:[Utility getStringByKey:@"Take Photo"] forState:UIControlStateNormal];
    [takePhotoBUtton addTarget:self action:@selector(TakePhoto) forControlEvents:UIControlEventTouchUpInside];
    takePhotoBUtton.titleLabel.font=[UIFont systemFontOfSize:18];
    [whiteButtonPhotoLittleBackGuandView addSubview:takePhotoBUtton];
    UIButton *choosePhotoBUtton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
   
    choosePhotoBUtton.backgroundColor=[UIColor clearColor];
    [choosePhotoBUtton setTitle:[Utility getStringByKey:@"Choose Photo"] forState:UIControlStateNormal];
    [choosePhotoBUtton addTarget:self action:@selector(ChoosePhoto) forControlEvents:UIControlEventTouchUpInside];
    choosePhotoBUtton.titleLabel.font=[UIFont systemFontOfSize:18];
    [whiteButtonPhotoLittleBackGuandView addSubview:choosePhotoBUtton];
    
    UIButton *cancelPhotoBUtton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelPhotoBUtton.titleLabel.font=[UIFont systemFontOfSize:18];
    cancelPhotoBUtton.backgroundColor=[UIColor whiteColor];
    [cancelPhotoBUtton setTitle:[Utility getStringByKey:@"cancel"] forState:UIControlStateNormal];
    [cancelPhotoBUtton addTarget:self action:@selector(cancelPhoto) forControlEvents:UIControlEventTouchUpInside];
    [cancelPhotoBUtton.layer setCornerRadius:5.0];
    [photoChickViewBlackGuandView addSubview:cancelPhotoBUtton];
    if (iPad) {
        photoChickViewBlackGuandView.frame=CGRectMake(0, 0, 320, 480+20);
        whiteButtonPhotoLittleBackGuandView.frame=CGRectMake(10, 480-160, 300, 80);
        takePhotoBUtton.frame=CGRectMake(0,0, 300, 40);
        choosePhotoBUtton.frame=CGRectMake(0, 40, 300, 40);
        cancelPhotoBUtton.frame=CGRectMake(10, 480-160+40+50, 300, 40);
    }
    else
    {
        photoChickViewBlackGuandView.frame=CGRectMake(0, 0, 320, 548+20);
        whiteButtonPhotoLittleBackGuandView.frame=CGRectMake(10, 548-120, 300, 80);
        takePhotoBUtton.frame=CGRectMake(0, 0, 300, 40);
        choosePhotoBUtton.frame=CGRectMake(0, 40, 300, 40);
        cancelPhotoBUtton.frame=CGRectMake(10, 548-120+40+50, 300, 40);
    }
    photoChickViewBlackGuandView.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.7];
    [self.view addSubview:photoChickViewBlackGuandView];
    
    
    photoChickViewBlackGuandView.hidden=NO;
    
    
    


}
-(void)cancelPhoto
{
       photoChickViewBlackGuandView.hidden=YES;
}
-(void)TakePhoto
{

    _theView.hidden=NO;

    
    NSLog(@"YYYYYYY");
    photoChickViewBlackGuandView.hidden=YES;
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    //获得相机模式下支持的媒体类型
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    BOOL canTakePicture = NO;
    for (NSString* mediaType in availableMediaTypes) {
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    //检查是否支持拍照
    if (!canTakePicture) {
        NSLog(@"sorry, taking picture is not supported.");
        return;
    }
    //创建图像选取控制器
    imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
       imagePickerController.delegate=self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];

    
    //允许用户进行编辑
    //imagePickerController.allowsEditing = YES;

//   imagePickerController.showsCameraControls=YES;
    
    //设置使用后置摄像头，可以使用前置摄像头
   //  imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    
   // imagePickerController.cameraViewTransform= CGAffineTransformScale(imagePickerController.cameraViewTransform, 1.2,0.8);
    //    //设置委托对象

    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    

}
-(void)ChoosePhoto
{
    
 _theView.hidden=NO;

    
    
    photoChickViewBlackGuandView.hidden=YES;
    //picture
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    //获得相机模式下支持的媒体类型
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    BOOL canTakePicture = NO;
    for (NSString* mediaType in availableMediaTypes) {
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    //检查是否支持拍照
    if (!canTakePicture) {
        //NSLog(@"sorry, taking picture is not supported.");
        return;
    }
    //创建图像选取控制器
    imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
     imagePickerController.delegate=self;
    
    imagePickerController.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    //    imagePickerController.cameraViewTransform= CGAffineTransformScale(imagePickerController.cameraViewTransform, 0.5, 0.5);
    //允许用户进行编辑
    //imagePickerController.allowsEditing = YES;

       //imagePickerController.showsCameraControls=YES;    //    //设置委托对象
   
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
    

}


    
    
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (imagePickerController.sourceType == UIImagePickerControllerSourceTypePhotoLibrary && [navigationController.viewControllers count] <=2) {
//      //  viewController.wantsFullScreenLayout = NO;
//        viewController.extendedLayoutIncludesOpaqueBars = NO;
//        viewController.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
//        navigationController.navigationBar.translucent = NO;
//    }else{
//       // viewController.wantsFullScreenLayout = YES;
//        viewController.extendedLayoutIncludesOpaqueBars = YES;
//        viewController.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
//        navigationController.navigationBar.translucent = YES;
//    }
//}
-(IBAction)deletePhoto:(id)sender
{
       NSString * ismHEalth=[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];
    
    if ([ismHEalth isEqualToString:@"HealthReach Calendar"]) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Delete Photo"
                                              message:@"This photo will be deleted."
                                              preferredStyle:UIAlertControllerStyleAlert];
  
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel");
                                       }];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       photoView.hidden=YES;
                                       photoImageVIew.image=nil;
                                       imageBase64Str=@"";
                                       medicationSecondView.frame=CGRectMake(0, 170, 320, 230+100);
                                       _backguandView.contentSize=CGSizeMake(320, 340+10+50+40+80);
                                       NSLog(@"OK");
                                   }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"刪除照片"
                                              message:@"照片將會刪除."
                                              preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"取消", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"確定", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       photoView.hidden=YES;
                                       photoImageVIew.image=nil;
                                       imageBase64Str=@"";
                                       medicationSecondView.frame=CGRectMake(0, 170, 320, 230+100);
                                       _backguandView.contentSize=CGSizeMake(320, 340+10+50+40+80);
                                       NSLog(@"OK action");
                                   }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
    }


    


  
  
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
      NSLog(@"I Can Take Photo??");
 _theView.hidden=YES;
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    selectedImage = [self rotateImage:selectedImage];
    
    ImageEditorViewController *viewController = [[ImageEditorViewController alloc] initWithOriginalImage:selectedImage cropWidth:360 cropHeight:240];
    
    
    [viewController setCompletionHandler:^(UIImage *editedImage) {
        
        
        //NSLog(@"ImageEditorViewController setCompletionHandler ");
        
        [self image:editedImage didFinishSavingWithError:nil contextInfo:nil];
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    
    
    [picker pushViewController:viewController animated:YES];
    
    
    //UIImage* edit = [info  objectForKey:UIImagePickerControllerEditedImage];

      //  UIImageWriteToSavedPhotosAlbum(edit, self,  @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    

   //[imagePickerController dismissViewControllerAnimated:YES completion:nil];
}
//取消照相机的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
     _theView.hidden=YES;
    //模态方式退出uiimagepickercontroller
     [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
}
//保存照片成功后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error     contextInfo:(void *)contextInf
{
    NSLog(@"saved..");
     _theView.hidden=YES;

    
//    
//    bbbbbbbbview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
//    bbbbbbbbview.backgroundColor=[UIColor blackColor];
//    bbbbbbbbview.hidden=NO;
//    [self.view addSubview:bbbbbbbbview];
//    
//    bigImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 30,320, 428)];
//    bigImageView.image=image;
//    [bbbbbbbbview addSubview:bigImageView];
//    
//    
//
//    smoreimageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 150, 180, 120)]; //要显示在另一视图上的位置以及区域
//    
//   // imageView.image = subIma; // 在视图上 加载图片B
//    smoreimageView.alpha=0.4;
//    smoreimageView.backgroundColor=[UIColor whiteColor];
//    
//    
//    
//    
//    [bbbbbbbbview addSubview:smoreimageView];  //显示出来
//    [self addGestureRecognizerToView:smoreimageView];
//    
//    //如果处理的是图片，别忘了
//    [smoreimageView setUserInteractionEnabled:YES];
//    [smoreimageView setMultipleTouchEnabled:YES];
//    
//    UIButton *buttonOK=[UIButton buttonWithType:UIButtonTypeCustom];
//    buttonOK.backgroundColor=[UIColor clearColor];
//    buttonOK.frame=CGRectMake(320-120-10, 480-0, 120, 40);
//    buttonOK.tintColor=[UIColor whiteColor];
//    [buttonOK setTitle:@"OK" forState:UIControlStateNormal];
//    [buttonOK addTarget:self action:@selector(okImagebutton) forControlEvents:UIControlEventTouchUpInside];
//    
//    [bbbbbbbbview addSubview:buttonOK];
//    
//    UIButton *buttonCancel=[UIButton buttonWithType:UIButtonTypeCustom];
//    buttonCancel.backgroundColor=[UIColor clearColor];
//    buttonCancel.frame=CGRectMake(10, 480-0, 120, 40);
//    buttonCancel.tintColor=[UIColor whiteColor];
//    [buttonCancel setTitle:@"Cancel" forState:UIControlStateNormal];
//    [buttonCancel addTarget:self action:@selector(cancelImagebutton) forControlEvents:UIControlEventTouchUpInside];
//    
//    [bbbbbbbbview addSubview:buttonCancel];
    
       photoView.hidden=NO;
//    CGRect myImageRect = CGRectMake(10.0, 100.0,720.0, 480.0);
//    CGImageRef imageRef = image.CGImage;
//    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
//    CGSize size;
//    size.width = image.size.width;
//    size.height = image.size.height;
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(context, myImageRect, subImageRef);
//    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
//    UIGraphicsEndImageContext();
    
    
    // UIGraphicsEndImageContext();
    
    photoImageVIew.image=image;
    _backguandView.contentSize=CGSizeMake(320, 180+262+140+90);
    medicationSecondView.frame=CGRectMake(0, 180+140, 320, 230+100);
//    self.medication_Note_TextView.hidden=false;
//    self.medication_Note_TextView.frame=CGRectMake(25, 240, 260, 90);
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(imageBase64) object:nil];
    [myThread start];
    
}
//-(void)okImagebutton
//{
//    NSLog(@"I say Yes");
//    
//      CGRect myImageRect = CGRectMake(smoreimageView.frame.origin.x, smoreimageView.frame.origin.y,smoreimageView.frame.size.width, smoreimageView.frame.size.height);
//    NSLog(@"SmoreimageView=%@",smoreimageView);
//    
//    
//        CGImageRef imageRef = bigImageView.image.CGImage;
//      NSLog(@"imageRef%@",imageRef);
//    NSLog(@"smoreimageView.frame.origin.x=%f",smoreimageView.frame.origin.x);
//    NSLog(@"smoreimageView.frame.origin.y=%f",smoreimageView.frame.origin.y);
//    NSLog(@"smoreimageView.frame.size.width=%f",smoreimageView.frame.size.width);
//    NSLog(@"smoreimageView.frame.size.height=%f",smoreimageView.frame.size.height);
//   
//    
//        CGImageRef subImageRef = CGImageCreateWithImageInRect(bigImageView.image.CGImage,myImageRect);
//    NSLog(@"subImageRef%@",subImageRef);
//    UIGraphicsBeginImageContext(myImageRect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(context, myImageRect, subImageRef);
//    
//        UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
//    UIGraphicsEndImageContext();
//        photoView.hidden=NO;
//        photoImageVIew.image=smallImage;
//        medicationSecondView.frame=CGRectMake(0, 170+140, 320, 230);
//        _backguandView.contentSize=CGSizeMake(320, 340+10+50+30+140);
//    bbbbbbbbview.hidden=YES;
//    
//        NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(imageBase64) object:nil];
//        [myThread start];
//    
//    
//}
//-(void)cancelImagebutton
//{
//     NSLog(@"I say Cancel");
//    
//    bbbbbbbbview.hidden=YES;
//   
//}
//
//// 添加所有的手势
//- (void) addGestureRecognizerToView:(UIView *)view
//{
//  
//    // 缩放手势
//    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
//    [view addGestureRecognizer:pinchGestureRecognizer];
//    
//    // 移动手势
//    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
//    [view addGestureRecognizer:panGestureRecognizer];
//    //shuangji
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapp:)];
//    [view addGestureRecognizer:singleTap];
//}
//
//
//// 处理缩放手势
//- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
//{
//    NSLog(@"SUO");
//    UIView *view = pinchGestureRecognizer.view;
//    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//        pinchGestureRecognizer.scale = 1;
//    }
//}
//
//- (void) singleTapp:(UITapGestureRecognizer *)tapGestureRecognize
//{
//    UIView *view=tapGestureRecognize.view;
//    view.frame=CGRectMake(70, 200, 180, 120);
//    
//}
//
//// 处理拖拉手势
//- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
//{
//      NSLog(@"Tuo");
//    NSLog(@"%@",smoreimageView);
//    UIView *view = panGestureRecognizer.view;
//    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
//        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
//        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
//    }
//}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void)imageBase64
{
  NSData* imageData = UIImageJPEGRepresentation(photoImageVIew.image, 0.1);
    
 //  NSData *imageData=UIImagePNGRepresentation(photoImageVIew.image);
   // NSLog(@"imageData=====%@",imageData);
    
   NSString *imageDate_String =[imageData base64EncodedStringWithOptions:NO];
    
 //   NSLog(@"imageURLSucc=%@",imageurlSucc);
//   NSString *imageDate_String=[[imageurlSucc absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//   
// NSLog(@"imageDate_String====%@",imageDate_String);
    imageBase64Str=imageDate_String;
 
}

-(IBAction)chickDataDateINOthers:(id)sender
{
//    _textView.frame=CGRectMake(59, 121, 228, 200);
    backgoundView.hidden=NO;
    dateDateCHickView.hidden=NO;
   
}


- (UIImage *)rotateImage:(UIImage *)aImage
{
    if (UIImageOrientationUp == aImage.imageOrientation) {
        return aImage;
    }
    
    CGImageRef imgRef = aImage.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    
    
    CGFloat scaleRatio = 1;
    
    
    
    CGFloat boundHeight;
    
    UIImageOrientation orient = aImage.imageOrientation;
    
    switch(orient)
    
    {
            
        case UIImageOrientationUp: //EXIF = 1
            
            transform = CGAffineTransformIdentity;
            
            break;
            
            
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            break;
            
            
            
        case UIImageOrientationDown: //EXIF = 3
            
            transform = CGAffineTransformMakeTranslation(width, height);
            
            transform = CGAffineTransformRotate(transform, M_PI);
            
            break;
            
            
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            
            transform = CGAffineTransformMakeTranslation(0.0, height);
            
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            
            break;
            
            
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, width);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI /2.0);
            
            break;
            
            
            
        case UIImageOrientationLeft: //EXIF = 6
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(0.0, width);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI /2.0);
            
            break;
            
            
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
            
            
        case UIImageOrientationRight: //EXIF = 8
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
    }
    
    
    
    UIGraphicsBeginImageContext(bounds.size);
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        
        CGContextTranslateCTM(context, -height, 0);
        
    }
    
    else {
        
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        
        CGContextTranslateCTM(context, 0, -height);
        
    }
    
    
    
    CGContextConcatCTM(context, transform);
    
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return imageCopy;
}



@end
