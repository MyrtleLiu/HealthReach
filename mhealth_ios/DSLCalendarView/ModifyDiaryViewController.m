//
//  ModifyDiaryViewController.m
//  mHealth
//
//  Created by gz dev team on 14年3月27日.
//
//

#import "ModifyDiaryViewController.h"
#import "HomeViewController.h"
#import "MR_ListViewController.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "NSString+URLEncoding.h"
#import "Utility.h"
#import "DBHelper.h"
#import "syncUtility.h"
#import "ImageEditorViewController.h"

@interface ModifyDiaryViewController ()

@end

@implementation ModifyDiaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"ModifyDiaryViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"ModifyDiaryViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}

-(void) backToHome{
    
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: 1] animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
            [self TextFonts];
}
-(void)TextFonts
{
    
    [healrhReachTextFont setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    healrhReachTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [doneBUTTON setTitle:[Utility getStringByKey:@"Done"] forState:UIControlStateNormal];
    doneBUTTON.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [deleteBUTTON setTitle:[Utility getStringByKey:@"Delete"] forState:UIControlStateNormal];
    deleteBUTTON.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [deleteMedicineTextFont setTitle:[Utility getStringByKey:@"Delete Medicine"] forState:UIControlStateNormal];
    deleteMedicineTextFont.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    _hendLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    _numberLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:23];
    _dostextView.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _agetextView.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    _timeClickLabel2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:30];
    
      timeLabel111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
      timeLabel222.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
      timeLabel333.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
      timeLabel444.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
      timeLabel555.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
      timeLabel666.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    
    [medicine setText:[Utility getStringByKey:@"Medicine"]];
    medicine.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [dosAgeTextFont setText:[Utility getStringByKey:@"Dosage"]];
    dosAgeTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [beforeMealTextFont setText:[Utility getStringByKey:@"Before meal"]];
    beforeMealTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [afterMealTextFont setText:[Utility getStringByKey:@"After meal"]];
    afterMealTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [naTextFont setText:[Utility getStringByKey:@"N/A"]];
    naTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    [frequencyTextFontText setText:[Utility getStringByKey:@"Frequency"]];
    frequencyTextFontText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [perDayTextFontText setText:[Utility getStringByKey:@"per day"]];
    perDayTextFontText.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [time111LabelTextFont setText:[Utility getStringByKey:@"Time1"]];
    time111LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time222LabelTextFont setText:[Utility getStringByKey:@"Time2"]];
    time222LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time333LabelTextFont setText:[Utility getStringByKey:@"Time3"]];
    time333LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time444LabelTextFont setText:[Utility getStringByKey:@"Time4"]];
    time444LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time555LabelTextFont setText:[Utility getStringByKey:@"Time5"]];
    time555LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time666LabelTextFont setText:[Utility getStringByKey:@"Time6"]];
    time666LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    
    
    clickLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:30];
    bPECGBG.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    _timeLabel1.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel2.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel3.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel4.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel5.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel6.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    [frequencyTextFont setText:[Utility getStringByKey:@"Frequency"]];
    frequencyTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:20];
    [perDayTextFont setText:[Utility getStringByKey:@"per day"]];
    perDayTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [time1LabelTextFont setText:[Utility getStringByKey:@"Time1"]];
    time1LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time2LabelTextFont setText:[Utility getStringByKey:@"Time2"]];
    time2LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time3LabelTextFont setText:[Utility getStringByKey:@"Time3"]];
    time3LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time4LabelTextFont setText:[Utility getStringByKey:@"Time4"]];
    time4LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time5LabelTextFont setText:[Utility getStringByKey:@"Time5"]];
    time5LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time6LabelTextFont setText:[Utility getStringByKey:@"Time6"]];
    time6LabelTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [titleOthersTextFont setText:[Utility getStringByKey:@"Calendar Title"]];
    titleOthersTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [dateOthersTextFont setText:[Utility getStringByKey:@"Calendar Date"]];
    dateOthersTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [startOthersTextFont setText:[Utility getStringByKey:@"Calendar Start"]];
    startOthersTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [endOthersTextFont setText:[Utility getStringByKey:@"Calendar End"]];
    endOthersTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [noteOthersTextFont setText:[Utility getStringByKey:@"Calendar Note"]];
    noteOthersTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    
    _textViewTitle.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _dateLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _labelStar.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _labelEnd.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    _textViewNote.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16];
    
    
    
    clickLabel1111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:30];

    _timeLabel1111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel2222.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel3333.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel4444.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel5555.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    _timeLabel6666.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    [frequencyTextFont1111 setText:[Utility getStringByKey:@"Frequency"]];
    frequencyTextFont1111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:20];
    [perDayTextFont1111 setText:[Utility getStringByKey:@"per day"]];
    perDayTextFont1111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18];
    [time1LabelTextFont1111 setText:[Utility getStringByKey:@"Time1"]];
    time1LabelTextFont1111.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time2LabelTextFont2222 setText:[Utility getStringByKey:@"Time2"]];
    time2LabelTextFont2222.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time3LabelTextFont3333 setText:[Utility getStringByKey:@"Time3"]];
    time3LabelTextFont3333.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time4LabelTextFont4444 setText:[Utility getStringByKey:@"Time4"]];
    time4LabelTextFont4444.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time5LabelTextFont5555 setText:[Utility getStringByKey:@"Time5"]];
    time5LabelTextFont5555.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    [time6LabelTextFont6666 setText:[Utility getStringByKey:@"Time6"]];
    time6LabelTextFont6666.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
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
-(IBAction)GOHOME:(id)sender
{
    [self backToHome];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    
   array=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    NSLog(@"%@",self.hendStr);
    _hendLabel.text=self.hendStr;
    NSString *bpColor=[[NSBundle mainBundle]pathForResource:@"hr_sub_sub_header_ca_1_long_on" ofType:@"png"];
     NSString *ecgColor=[[NSBundle mainBundle]pathForResource:@"hr_sub_sub_header_ca_2_long_on" ofType:@"png"];
     NSString *bgColor=[[NSBundle mainBundle]pathForResource:@"hr_sub_sub_header_ca_3_long_on" ofType:@"png"];
    NSString *bstr1=[[NSBundle mainBundle]pathForResource:@"hr_btn_wa_green_2" ofType:@"png" ];
    NSString *bstr2=[[NSBundle mainBundle]pathForResource:@"hr_btn_wa_red_1" ofType:@"png"];
    UIImage * _image1=[[UIImage alloc]initWithContentsOfFile:bstr1];
    UIImage *_image2=[[UIImage alloc]initWithContentsOfFile:bstr2];
    NSString*ridaoOnStr=[[NSBundle mainBundle] pathForResource:@"hr_btn_radio_1_on" ofType:@"png"];
    NSString*ridaoOffStr=[[NSBundle mainBundle] pathForResource:@"hr_btn_radio_1_off" ofType:@"png"];
    ridaoOn=[[UIImage alloc]initWithContentsOfFile:ridaoOnStr];
    ridaoOff=[[UIImage alloc]initWithContentsOfFile:ridaoOffStr];
    if (!self.dataStr) {
       
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        self.dataStr=currentDateStr;

    }
    imageBase64Str=@"";
    NSLog(@"HIENIOA   %@",strTempTemp);
    NSLog(@"self.turnmedIDText====%@",self.turnmedIDText);
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *dates=[dateFormat dateFromString:self.dataStr];
    NSTimeInterval secondsPerDay = +(24*60*60)*6;
    NSDate *tomorrow = [dates dateByAddingTimeInterval:secondsPerDay];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr=[dateFormatter stringFromDate:tomorrow];
    self.sevenDateStr=currentDateStr;
    
    backgoundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    backgoundView.backgroundColor=[UIColor whiteColor]; 
    backgoundView.alpha=0.8;
    [self.view addSubview:backgoundView];
    backgoundView.hidden =YES;
    datePickerView=[[UIView alloc]initWithFrame:CGRectMake(10 ,180, 300 , 280)];
    datePickerView.layer.cornerRadius = 15;//设置那个圆角的有多圆
    datePickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:datePickerView];
    UIDatePicker * datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 280)];
    datePicker.date=[NSDate date];
    datePicker.tag=100;
    datePicker.datePickerMode=UIDatePickerModeTime;
    datePicker.backgroundColor=[UIColor whiteColor];
    [datePickerView addSubview:datePicker];
    //[self.view bringSubviewToFront:datePickerView];
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

    
    dateDateCHickView=[[UIView alloc]initWithFrame:CGRectMake(10, 180, 300, 280)];
    dateDateCHickView=[[UIView alloc]initWithFrame:CGRectMake(10 ,180, 300 , 280)];
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
    label2DDD.textAlignment=NSTextAlignmentCenter;
    label2DDD.textColor =[UIColor whiteColor];
    label2DDD.backgroundColor=[UIColor clearColor];
    [_buttonYesDDD addSubview:label1DDD];
    [_buttonNoDDD addSubview:label2DDD];

    
    
    
    
    
    
    UIToolbar*toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [toolBar setBarStyle:UIBarStyleBlack];
    toolBar.translucent=YES;
    toolBar.tintColor=[UIColor grayColor];
    UIBarButtonItem*barButton1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(leaveEditMode)];
    UIBarButtonItem*barButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(leaveEditMode)];
    NSArray *array2=[[NSArray alloc] initWithObjects:barButton1,barButton, nil];
    toolBar.items=array2;
    _textViewNote.delegate=self;
    _dostextView.delegate=self;
    _agetextView.delegate=self;
    _textViewTitle.delegate=self;

    [_textViewNote setInputAccessoryView:toolBar];
    [_dostextView setInputAccessoryView:toolBar];
    [_agetextView setInputAccessoryView:toolBar];
    [_textViewTitle setInputAccessoryView:toolBar];
    
    _textViewNote.scrollEnabled = NO;
    self. medication_Note_TextView=[[UITextView alloc]initWithFrame:CGRectMake(25, 210, 260, 90)];
    self. medication_Note_TextView.textColor=[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    self. medication_Note_TextView.font = [UIFont fontWithName:@"Arial" size:15.0];
    self. medication_Note_TextView.delegate=self;
    
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
    
    
    if ([self.turnNoteMedicationText isEqualToString:@" "]||[self.turnNoteMedicationText isEqualToString:@""]||self.turnNoteMedicationText==nil||self.turnNoteMedicationText==NULL)
    {
        labelText_NOte.hidden=NO;
    }
    else
    {
        labelText_NOte.hidden=YES;
    }
    
    
    
    
    self.medication_Note_TextView.text=self.turnNoteMedicationText;
    self. medication_Note_TextView.backgroundColor=[UIColor whiteColor];
    
    
    
    
    
    self.  medication_Note_TextView.scrollEnabled=NO;
    medicationSecondView.userInteractionEnabled=YES;
    [medicationSecondView addSubview: self. medication_Note_TextView];
    //medication_Note_TextView.text=@"111";
    self. medication_Note_TextView.delegate=self;
    [medicationSecondView bringSubviewToFront: self. medication_Note_TextView];
    [ self. medication_Note_TextView setInputAccessoryView:toolBar];
    
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label1.text=[Utility getStringByKey:@"Done"];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor=[UIColor whiteColor];
    label1.backgroundColor=[UIColor clearColor];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label2.text=[Utility getStringByKey:@"Cancel"];
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor =[UIColor whiteColor];
    label2.backgroundColor=[UIColor clearColor];
    [_buttonYes addSubview:label1];
    [_buttonNo addSubview:label2];
    datePickerView.hidden=YES;
         strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];
    __scrollView.backgroundColor=[UIColor clearColor];
  //  __scrollView.pagingEnabled=YES;
  //  __scrollView.bounces=YES;
 //   __scrollView.showsHorizontalScrollIndicator=NO;
  //  __scrollView.showsVerticalScrollIndicator=YES;
    __scrollView.bounces=NO;
    __scrollView.contentSize=CGSizeMake(320, 340+10+50+30);//设置总画布的大小
    
    __scrollView.delegate=self;//实现代理
    

    
    _backguandView.backgroundColor=[UIColor clearColor];
   // _backguandView.pagingEnabled=YES;
  //  _backguandView.bounces=YES;
  //  _backguandView.showsHorizontalScrollIndicator=NO;
 //   _backguandView.showsVerticalScrollIndicator=YES;
    _backguandView.bounces=NO;
   
    NSLog(@"self.imageStr=%@",self.imageStr);
    if ([self.imageStr isEqualToString:@""]||self.imageStr ==nil||self.imageStr==NULL) {
        NSLog(@"111");
        photoView.hidden=YES;
        photoImageVIew.image=nil;
        _backguandView.contentSize=CGSizeMake(320, 180+262+100);
        medicationSecondView.frame=CGRectMake(0, 180, 320, 252+90);
        
    }
    else
    {
         NSLog(@"222");
        photoView.hidden=NO;
        imageBase64Str=self.imageStr;
        NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:self.imageStr options:NO];
        UIImage *image=[[UIImage alloc]initWithData:datetmp];
        NSLog(@"image==%@",image);
        photoImageVIew.image=image;
        _backguandView.contentSize=CGSizeMake(320, 180+262+140+100);
        medicationSecondView.frame=CGRectMake(0, 180+140, 320, 252+90);
        
    }
         _backguandView.delegate=self;
    UILabel *labelll=[[UILabel alloc]initWithFrame:CGRectMake(60, 340+10, 230, 60)];
    labelll.backgroundColor=[UIColor clearColor];
    labelll.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12];
    labelll.numberOfLines=4;
    labelll.textColor=[UIColor blackColor];
    if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
        labelll.text=@"First reminder and second reminder are given 24 hours and 2 hours before the scheduled time,while a final reminder is give 15 minutes before the event.";
        
        
    }
    else
    {
        labelll.text=@"第一及第二次提示將分别於活動開始前24小時及2小時發出,最終提示則會於活動開始前15分鐘發出.";
    }
    UIFont *font = [UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20];
    CGSize size = CGSizeMake(320,2000);
    
    //CGSize labelsize = [[Utility getStringByKey:@"Frequency"] sizeWithFont:font constrainedToSize:size lineBreakMode:nil];
    
    
    CGRect labelsize = [[Utility getStringByKey:@"Frequency"]
                        boundingRectWithSize:size
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{NSFontAttributeName:font}
                        context:nil];
    
    //CGSize labelsize = [[Utility getStringByKey:@"Frequency"] sizeWithFont:font constrainedToSize:size lineBreakMode:nil];

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
    medicinePictureTextFont.frame=CGRectMake(25, 145, labelsize222.size.width, labelsize222.size.height+5);
    medicinePictureChickButton.frame=CGRectMake(27+medicinePictureTextFont.frame.size.width,136, 45, 35);
    

    frequencyTextFont.frame=CGRectMake(15,62, labelsize.size.width,31);
    _timechickImabe1.frame=CGRectMake(frequencyTextFont.frame.size.width+28, 60, 45, 31);
    _timeTableView.frame=CGRectMake(frequencyTextFont.frame.size.width+28, 90, 75, 178);
    
    clickLabel.frame=CGRectMake(frequencyTextFont.frame.size.width+28, 60, 45, 37);
    _timechickButtonWhite1.frame=CGRectMake(frequencyTextFont.frame.size.width+28+45, 60, 30, 31);
    perDayTextFont.frame=CGRectMake(frequencyTextFont.frame.size.width+28+45+30+2,62, 84, 21);
    frequencyTextFont1111.frame=CGRectMake(0, 0, 0, 0);
    frequencyTextFont1111.numberOfLines=0;
    //[frequencyTextFont1111 sizeToFit];
    frequencyTextFont1111.frame=CGRectMake(25,35,labelsize.size.width,31);
    _timechickImabe111.frame=CGRectMake(frequencyTextFont1111.frame.size.width+25+3,35, 45, 31);
    walkTableChilk.frame=CGRectMake(frequencyTextFont1111.frame.size.width+25+3, 65, 75, 200);
    clickLabel1111.frame=CGRectMake(frequencyTextFont1111.frame.size.width+28, 38, 45, 31);
    _timechickButtonWhite111.frame=CGRectMake(frequencyTextFont1111.frame.size.width+28+45, 35, 30, 31);
    perDayTextFont1111.frame=CGRectMake(frequencyTextFont1111.frame.size.width+28+45+30+2, 35, 78, 31);
    
    frequencyTextFontText.frame=CGRectMake(0, 0, 0, 0);
    frequencyTextFontText.numberOfLines=0;
    
  //  [frequencyTextFontText sizeToFit];
    frequencyTextFontText.frame=CGRectMake(25, 52,labelsize.size.width ,labelsize.size.height);
    _timechickImabe11.frame=CGRectMake(frequencyTextFontText.frame.size.width+28, 50, 45, 31);
    _secondTable.frame=CGRectMake(frequencyTextFontText.frame.size.width+28, 221-140, 75, 125);
    _timeClickLabel2.frame=CGRectMake(frequencyTextFontText.frame.size.width+28, 192-140, 45, 38);
    _timechickButtonWhite11.frame=CGRectMake(frequencyTextFontText.frame.size.width+28+45, 190-140, 30, 31);
    perDayTextFontText.frame=CGRectMake(frequencyTextFontText.frame.size.width+28+45+30+2, 192-140, 91, 23);
    

    [__scrollView addSubview:labelll];

    
    UIImage*bpImage=[[UIImage alloc]initWithContentsOfFile:bpColor];
    UIImage*ecgImage=[[UIImage alloc]initWithContentsOfFile:ecgColor];
    UIImage*bgImage=[[UIImage alloc]initWithContentsOfFile:bgColor];
    
    if ([_hendLabel.text isEqualToString:[Utility getStringByKey:@"Daily Measurement"]]) {

        _viewMeasurement.hidden=NO;
        _viewMeation.hidden=YES;
        _viewOther.hidden=YES;
        _viewWalking.hidden=YES;
        _littleMeasurementView.layer.cornerRadius=12;
        
        bPECGBG.text=self.bpBgECG;
        if ([bPECGBG.text isEqualToString:[Utility getStringByKey:@"Blood Pressure"]]) {
            //
            bPECGBGImageView.image=bpImage;
            self.bECPText=@"B";
            NSLog(@"-----------------");
        }
        if ([bPECGBG.text isEqualToString:[Utility getStringByKey:@"ECG"]]) {
            //
            bPECGBGImageView.image=ecgImage;
            self.bECPText=@"E";
            NSLog(@"-----------------");
        }
        if ([bPECGBG.text isEqualToString:[Utility getStringByKey:@"Blood Glucose"]]) {
            //
            bPECGBGImageView.image=bgImage;
            self.bECPText=@"G";
            NSLog(@"-------");
        }
        
        switch ([self._turnArray count]) {
            case 0:
      
                _timeLabel1.text=@" ";
                _timeLabel2.text=@" ";
                _timeLabel3.text=@" ";
                _timeLabel4.text=@" ";
                _timeLabel5.text=@" ";
                _timeLabel6.text=@" ";
                
                break;
            case 1:
                _timeLabel1.text=[self._turnArray objectAtIndex:0];
                _timeLabel2.text=@" ";
                _timeLabel3.text=@" ";
                _timeLabel4.text=@" ";
                _timeLabel5.text=@" ";
                _timeLabel6.text=@" ";

                break;
            case 2:
                _timeLabel1.text=[self._turnArray objectAtIndex:0];
                _timeLabel2.text=[self._turnArray objectAtIndex:1];
          
                _timeLabel3.text=@" ";
                _timeLabel4.text=@" ";
                _timeLabel5.text=@" ";
                _timeLabel6.text=@" ";
                
                break;
            case 3:
                _timeLabel1.text=[self._turnArray objectAtIndex:0];
                _timeLabel2.text=[self._turnArray objectAtIndex:1];
                _timeLabel3.text=[self._turnArray objectAtIndex:2];
        
                _timeLabel4.text=@" ";
                _timeLabel5.text=@" ";
                _timeLabel6.text=@" ";
                
                break;
            case 4:
                _timeLabel1.text=[self._turnArray objectAtIndex:0];
                _timeLabel2.text=[self._turnArray objectAtIndex:1];
                _timeLabel3.text=[self._turnArray objectAtIndex:2];
                _timeLabel4.text=[self._turnArray objectAtIndex:3];
         
                _timeLabel5.text=@" ";
                _timeLabel6.text=@" ";
                
                break;
            case 5:
                _timeLabel1.text=[self._turnArray objectAtIndex:0];
                _timeLabel2.text=[self._turnArray objectAtIndex:1];
                _timeLabel3.text=[self._turnArray objectAtIndex:2];
                _timeLabel4.text=[self._turnArray objectAtIndex:3];
                _timeLabel5.text=[self._turnArray objectAtIndex:4];
                _timeLabel6.text=@" ";
                
                break;
            case 6:
                _timeLabel1.text=[self._turnArray objectAtIndex:0];
                _timeLabel2.text=[self._turnArray objectAtIndex:1];
                _timeLabel3.text=[self._turnArray objectAtIndex:2];
                _timeLabel4.text=[self._turnArray objectAtIndex:3];
                _timeLabel5.text=[self._turnArray objectAtIndex:4];
                _timeLabel6.text=[self._turnArray objectAtIndex:5];
                
                break;
            default:
                _timeLabel1.text=[self._turnArray objectAtIndex:0];
                _timeLabel2.text=[self._turnArray objectAtIndex:1];
                _timeLabel3.text=[self._turnArray objectAtIndex:2];
                _timeLabel4.text=[self._turnArray objectAtIndex:3];
                _timeLabel5.text=[self._turnArray objectAtIndex:4];
                _timeLabel6.text=[self._turnArray objectAtIndex:5];
                break;
        }

        if ([_timeLabel1.text isEqualToString:@" "]||[_timeLabel1.text isEqualToString:@""]) {
            clickLabel.text=@"0";
            timeView1.hidden=YES;
            timeView2.hidden=YES;
            timeView3.hidden=YES;
            timeView4.hidden=YES;
            timeView5.hidden=YES;
            timeView6.hidden=YES;
            _timeLabel1.text=nil;
            _timeLabel2.text=nil;
            _timeLabel3.text=Nil;
            _timeLabel4.text=Nil;
            _timeLabel5.text=Nil;
            _timeLabel6.text=Nil;
        }
        else if ([_timeLabel2.text isEqualToString:@" "]||[_timeLabel2.text isEqualToString:@""]) {
            clickLabel.text=@"1";
            timeView1.hidden=NO;
            timeView2.hidden=YES;
            timeView3.hidden=YES;
            timeView4.hidden=YES;
            timeView5.hidden=YES;
            timeView6.hidden=YES;
            
            _timeLabel2.text=Nil;
            _timeLabel3.text=Nil;
            _timeLabel4.text=Nil;
            _timeLabel5.text=Nil;
            _timeLabel6.text=Nil;
        }
        else if ([_timeLabel3.text isEqualToString:@" "]||[_timeLabel3.text isEqualToString:@""]) {
            clickLabel.text=@"2";
            timeView1.hidden=NO;
            timeView2.hidden=NO;
            timeView3.hidden=YES;
            timeView4.hidden=YES;
            timeView5.hidden=YES;
            timeView6.hidden=YES;
        
            _timeLabel3.text=Nil;
            _timeLabel4.text=Nil;
            _timeLabel5.text=Nil;
            _timeLabel6.text=Nil;
        }
        else if ([_timeLabel4.text isEqualToString:@" "]||[_timeLabel4.text isEqualToString:@""]) {
            clickLabel.text=@"3";
            timeView1.hidden=NO;
            timeView2.hidden=NO;
            timeView3.hidden=NO;
            timeView4.hidden=YES;
            timeView5.hidden=YES;
            timeView6.hidden=YES;
     
            _timeLabel4.text=Nil;
            _timeLabel5.text=Nil;
            _timeLabel6.text=Nil;
        }
        else if ([_timeLabel5.text isEqualToString:@" "]||[_timeLabel5.text isEqualToString:@""]) {
            clickLabel.text=@"4";
            timeView1.hidden=NO;
            timeView2.hidden=NO;
            timeView3.hidden=NO;
            timeView4.hidden=NO;
            timeView5.hidden=YES;
            timeView6.hidden=YES;
        
            _timeLabel5.text=Nil;
            _timeLabel6.text=Nil;
        }
        else if ([_timeLabel6.text isEqualToString:@" "]||[_timeLabel6.text isEqualToString:@""]) {
            clickLabel.text=@"5";
            timeView1.hidden=NO;
            timeView2.hidden=NO;
            timeView3.hidden=NO;
            timeView4.hidden=NO;
            timeView5.hidden=NO;
            timeView6.hidden=YES;
            
            _timeLabel6.text=Nil;
        }
    else
        {
            clickLabel.text=@"6";
            timeView1.hidden=NO;
            timeView2.hidden=NO;
            timeView3.hidden=NO;
            timeView4.hidden=NO;
            timeView5.hidden=NO;
            timeView6.hidden=NO;
        }
        
        
        

    }
    
    if ([_hendLabel.text isEqualToString:[Utility getStringByKey:@"Daily Medication"]])
    {
        
      


        self.bECPText=@"M";
        _viewMeasurement.hidden=YES;
        _viewMeation.hidden=NO;
        _viewOther.hidden=YES;
        deleteBUTTON.hidden=YES;
        _viewWalking.hidden=YES;
        if (!iPad) {
            doneBUTTON.frame=CGRectMake(110, 513, 100, 40);
        }
        else
        {
            doneBUTTON.frame=CGRectMake(110, 430, 100, 40);
            
        }
        
        UIScrollView*_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        _scrollView.backgroundColor=[UIColor clearColor];
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=YES;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=YES;
        _scrollView.contentSize=CGSizeMake(self.turntitleMedicationArray.count*50, 50);//设置总画布的大小
        _scrollView.delegate=self;//实现代理
   
        _imageViewTriangle.frame=CGRectMake(34+(self.medWitchID *(35+6)), 40, 10, 10);
        _numberLabel.frame=CGRectMake(25+(self.medWitchID *(35+6)), 9, 31, 31);
        long number=self.medWitchID+1;
        NSString * numberStr=[[NSString alloc]initWithFormat:@"%ld",number];
        NSLog(@"self.meWithID====%ld",(long)self.medWitchID);
        _numberLabel.text=numberStr;
        NSLog(@"++++++++++++++++++++++++++++++++__________________++++%lu   %lu",(unsigned long)self.turntitleMedicationArray.count,(unsigned long)self.turndosageMedicationArray.count);
        if (self.turntitleMedicationArray.count>0) {
            _dostextView.text=self.turntitleMedicationText;
            _agetextView.text=self.turndosageMedicationText;
            float ff=[self.turntimesMedicationText lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
            NSLog(@"+++++++%f",ff);
            
                if ([self.turnMealMedicationText isEqualToString:@"B"]) {
                    //
                    beforeMealButton.image=ridaoOn ;
                    afterMealButton .image=ridaoOff;
                    naButton.image=ridaoOff;
                    
                    self.banMEAL=@"B";
                    
                    
                    
                }
                if ([self.turnMealMedicationText isEqualToString:@"A"]) {
                    //
                    beforeMealButton.image=ridaoOff ;
                    afterMealButton .image=ridaoOn;
                    naButton.image=ridaoOff;
                    self.banMEAL=@"A";
                }
                if ([self.turnMealMedicationText isEqualToString:@"N"]) {
                    //
                    beforeMealButton.image=ridaoOff ;
                    afterMealButton .image=ridaoOff;
                    naButton.image=ridaoOn;
                    self.banMEAL=@"N";
                }
                
            
            timesArray =[[NSMutableArray alloc]init];
            
            if (ff>1&&ff<7) {
                //
                NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0,5)];
                [timesArray addObject:string];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
            }
            else if (ff>=7.0&&ff<=13)
            {
                for (int temmm=0; temmm<2; temmm++) {
                    NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [timesArray addObject:string];
           
                }
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
            
            }
            else if (ff>=13.0&&ff<=19)
            {
                for (int temmm=0; temmm<3; temmm++)
                {
                    NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [timesArray addObject:string];
                 
                }
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
            }
            else if (ff>=19.0&&ff<=25)
            {
                for (int temmm=0; temmm<4; temmm++) {
                    NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [timesArray addObject:string];
          
                }
                
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
            }
            else if (ff>=25.0&&ff<=31)
            {
                for (int temmm=0; temmm<5; temmm++) {
                    NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    [timesArray addObject:string];
           
              
                }
                
                [timesArray addObject:@" "];
            }
            else if (ff>=31.0)
            {
                for (int temmm=0; temmm<6; temmm++)
                {
                    NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                    NSLog(@"__%@--",string);
                    [timesArray addObject:string];
                }
            }
            else
            {
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
                [timesArray addObject:@" "];
            }
        
            
            for (int k=0; k<[self.turntitleMedicationArray count]; k++)
            {
                _numberButton=[UIButton buttonWithType:UIButtonTypeCustom];
                _numberButton.backgroundColor=[UIColor whiteColor];
                
                [ _numberButton setTitleEdgeInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
                [_numberButton.layer setBorderWidth:1.0];
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 70/255.0, 170/255.0, 170/255.0, 1 });
                [_numberButton.layer setBorderColor:colorref];

                
                NSString * numberText=[[NSString alloc]initWithFormat:@"%d",k+1];
                _numberButton.tag=k;
        
           
                [_numberButton setTitle:numberText forState:UIControlStateNormal];
              
                [_numberButton setTitleColor:[UIColor colorWithRed:70/255.0 green:170/255.0 blue:170/255.0 alpha:1] forState:UIControlStateNormal];
                        _numberButton.titleLabel.textAlignment=NSTextAlignmentCenter;
          
              
                
                [_numberButton addTarget:self action:@selector(numberDID:) forControlEvents:UIControlEventTouchUpInside];
                       _numberButton.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:23];
                _numberButton.frame=CGRectMake(25+(k*(35+6)), 9, 31, 31);
                
                
                [_scrollView addSubview:_numberButton];
                
                
            }
            [___scrlowLAbel addSubview:_scrollView];
            [_scrollView addSubview:_numberLabel];
            [_scrollView addSubview:_imageViewTriangle];
        //   [___scrlowLAbel bringSubviewToFront:_numberLabel];
            
        }
        
        timeLabel111.text=[timesArray objectAtIndex:0];
        timeLabel222.text=[timesArray objectAtIndex:1];
        timeLabel333.text=[timesArray objectAtIndex:2];
        timeLabel444.text=[timesArray objectAtIndex:3];
        timeLabel555.text=[timesArray objectAtIndex:4];
        timeLabel666.text=[timesArray objectAtIndex:5];
        
        
        
        
        
        
        
        
        if ([timeLabel111.text isEqualToString:@" "]||[timeLabel111.text isEqualToString:@""]) {
           _timeClickLabel2.text=@"0";
            timeView111.hidden=YES;
            timeView222.hidden=YES;
            timeView333.hidden=YES;
            timeView444.hidden=YES;
            timeView555.hidden=YES;
            timeView666.hidden=YES;
            timeLabel111.text=nil;
            timeLabel222.text=nil;
            timeLabel333.text=Nil;
            timeLabel444.text=Nil;
            timeLabel555.text=Nil;
            timeLabel666.text=Nil;
        }
        else if ([timeLabel222.text isEqualToString:@" "]||[timeLabel222.text isEqualToString:@""]) {
          _timeClickLabel2.text=@"1";
            timeView111.hidden=NO;
            timeView222.hidden=YES;
            timeView333.hidden=YES;
            timeView444.hidden=YES;
            timeView555.hidden=YES;
            timeView666.hidden=YES;
            
            timeLabel222.text=Nil;
            timeLabel333.text=Nil;
            timeLabel444.text=Nil;
            timeLabel555.text=Nil;
            timeLabel666.text=Nil;
        }
        else if ([timeLabel333.text isEqualToString:@" "]||[timeLabel333.text isEqualToString:@""]) {
           _timeClickLabel2.text=@"2";
            timeView111.hidden=NO;
            timeView222.hidden=NO;
            timeView333.hidden=YES;
            timeView444.hidden=YES;
            timeView555.hidden=YES;
            timeView666.hidden=YES;
            
            timeLabel333.text=Nil;
            timeLabel444.text=Nil;
            timeLabel555.text=Nil;
            timeLabel666.text=Nil;
        }
        else if ([timeLabel444.text isEqualToString:@" "]||[timeLabel444.text isEqualToString:@""]) {
            _timeClickLabel2.text=@"3";
            timeView111.hidden=NO;
            timeView222.hidden=NO;
            timeView333.hidden=NO;
            timeView444.hidden=YES;
            timeView555.hidden=YES;
            timeView666.hidden=YES;
            
            timeLabel444.text=Nil;
            timeLabel555.text=Nil;
            timeLabel666.text=Nil;
        }
        else if ([timeLabel555.text isEqualToString:@" "]||[timeLabel555.text isEqualToString:@""]) {
           _timeClickLabel2.text=@"4";
            timeView111.hidden=NO;
            timeView222.hidden=NO;
            timeView333.hidden=NO;
            timeView444.hidden=NO;
            timeView555.hidden=YES;
            timeView666.hidden=YES;
            
            timeLabel555.text=Nil;
            timeLabel666.text=Nil;
        }
        else if ([timeLabel666.text isEqualToString:@" "]||[timeLabel666.text isEqualToString:@""]) {
            _timeClickLabel2.text=@"5";
            timeView111.hidden=NO;
            timeView222.hidden=NO;
            timeView333.hidden=NO;
            timeView444.hidden=NO;
            timeView555.hidden=NO;
            timeView666.hidden=YES;
            timeLabel666.text=Nil;
        }
        else
        {
          _timeClickLabel2.text=@"6";
            timeView111.hidden=NO;
            timeView222.hidden=NO;
            timeView333.hidden=NO;
            timeView444.hidden=NO;
            timeView555.hidden=NO;
            timeView666.hidden=NO;
            
        }
        
        
    }
    if ([_hendLabel.text isEqualToString:[Utility getStringByKey:@"Others"]]) {
        
        self.bECPText=@"A";
        _viewMeasurement.hidden=YES;
        _viewMeation.hidden=YES;
        _viewOther.hidden=NO;
        _viewWalking.hidden=YES;

        
        _textViewTitle.text=self.turnOtherTitle;
       
        NSString * timeStrRain111=[self.turnOtherDateDate substringWithRange:NSMakeRange(8,2)];
        
        NSString * timeStrRain222=[self.turnOtherDateDate substringWithRange:NSMakeRange(0,4)];
        NSString *timeStrRain333=[self.turnOtherDateDate substringWithRange:NSMakeRange(5, 2)];
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
        
        
        _labelStar.text=self.turnOtherStartTime;
        _labelEnd.text=self.turnOtherEndTime;
        _textViewNote.text=self.turnOtherNote;
    }
    
    if ([_hendLabel.text isEqualToString:[Utility getStringByKey:@"Exercise"]]) {
            self.bECPText=@"K";
        _viewMeasurement.hidden=YES;
        _viewMeation.hidden=YES;
        _viewOther.hidden=YES;
        _viewWalking.hidden=NO;

        switch ([self.turnWalkingArray count]) {
            case 0:
                _timeLabel1111.text=@" ";
                _timeLabel2222.text=@" ";
                _timeLabel3333.text=@" ";
                _timeLabel4444.text=@" ";
                _timeLabel5555.text=@" ";
                _timeLabel6666.text=@" ";
                
                break;
            case 1:
                _timeLabel1111.text=[self.turnWalkingArray objectAtIndex:0];
                _timeLabel2222.text=@" ";
                _timeLabel3333.text=@" ";
                _timeLabel4444.text=@" ";
                _timeLabel5555.text=@" ";
                _timeLabel6666.text=@" ";
                
                break;
            case 2:
                _timeLabel1111.text=[self.turnWalkingArray objectAtIndex:0];
                _timeLabel2222.text=[self.turnWalkingArray objectAtIndex:1];
                
                _timeLabel3333.text=@" ";
                _timeLabel4444.text=@" ";
                _timeLabel5555.text=@" ";
                _timeLabel6666.text=@" ";
                
                break;
            case 3:
                _timeLabel1111.text=[self.turnWalkingArray objectAtIndex:0];
                _timeLabel2222.text=[self.turnWalkingArray objectAtIndex:1];
                _timeLabel3333.text=[self.turnWalkingArray objectAtIndex:2];
                
                _timeLabel4444.text=@" ";
                _timeLabel5555.text=@" ";
                _timeLabel6666.text=@" ";
                
                break;
            case 4:
                _timeLabel1111.text=[self.turnWalkingArray objectAtIndex:0];
                _timeLabel2222.text=[self.turnWalkingArray objectAtIndex:1];
                _timeLabel3333.text=[self.turnWalkingArray objectAtIndex:2];
                _timeLabel4444.text=[self.turnWalkingArray objectAtIndex:3];
                
                _timeLabel5555.text=@" ";
                _timeLabel6666.text=@" ";
                
                break;
            case 5:
                _timeLabel1111.text=[self.turnWalkingArray objectAtIndex:0];
                _timeLabel2222.text=[self.turnWalkingArray objectAtIndex:1];
                _timeLabel3333.text=[self.turnWalkingArray objectAtIndex:2];
                _timeLabel4444.text=[self.turnWalkingArray objectAtIndex:3];
                _timeLabel5555.text=[self.turnWalkingArray objectAtIndex:4];
                _timeLabel6666.text=@" ";
                
                break;
            case 6:
                _timeLabel1111.text=[self.turnWalkingArray objectAtIndex:0];
                _timeLabel2222.text=[self.turnWalkingArray objectAtIndex:1];
                _timeLabel3333.text=[self.turnWalkingArray objectAtIndex:2];
                _timeLabel4444.text=[self.turnWalkingArray objectAtIndex:3];
                _timeLabel5555.text=[self.turnWalkingArray objectAtIndex:4];
                _timeLabel6666.text=[self.turnWalkingArray objectAtIndex:5];
                
                break;
            default:
                _timeLabel1111.text=[self.turnWalkingArray objectAtIndex:0];
                _timeLabel2222.text=[self.turnWalkingArray objectAtIndex:1];
                _timeLabel3333.text=[self.turnWalkingArray objectAtIndex:2];
                _timeLabel4444.text=[self.turnWalkingArray objectAtIndex:3];
                _timeLabel5555.text=[self.turnWalkingArray objectAtIndex:4];
                _timeLabel6666.text=[self.turnWalkingArray objectAtIndex:5];
                break;
        }
        
        if ([_timeLabel1111.text isEqualToString:@" "]||[_timeLabel1111.text isEqualToString:@""]) {
            clickLabel1111.text=@"0";
            timeView1111.hidden=YES;
            timeView2222.hidden=YES;
            timeView3333.hidden=YES;
            timeView4444.hidden=YES;
            timeView5555.hidden=YES;
            timeView6666.hidden=YES;
            _timeLabel1111.text=nil;
            _timeLabel2222.text=nil;
            _timeLabel3333.text=Nil;
            _timeLabel4444.text=Nil;
            _timeLabel5555.text=Nil;
            _timeLabel6666.text=Nil;
        }
        else if ([_timeLabel2222.text isEqualToString:@" "]||[_timeLabel2222.text isEqualToString:@""]) {
            clickLabel1111.text=@"1";
            timeView1111.hidden=NO;
            timeView2222.hidden=YES;
            timeView3333.hidden=YES;
            timeView4444.hidden=YES;
            timeView5555.hidden=YES;
            timeView6666.hidden=YES;
            
            _timeLabel2222.text=Nil;
            _timeLabel3333.text=Nil;
            _timeLabel4444.text=Nil;
            _timeLabel5555.text=Nil;
            _timeLabel6666.text=Nil;
        }
        else if ([_timeLabel3333.text isEqualToString:@" "]||[_timeLabel3333.text isEqualToString:@""]) {
            clickLabel1111.text=@"2";
            timeView1111.hidden=NO;
            timeView2222.hidden=NO;
            timeView3333.hidden=YES;
            timeView4444.hidden=YES;
            timeView5555.hidden=YES;
            timeView6666.hidden=YES;
            
            _timeLabel3333.text=Nil;
            _timeLabel4444.text=Nil;
            _timeLabel5555.text=Nil;
            _timeLabel6666.text=Nil;
        }
        else if ([_timeLabel4444.text isEqualToString:@" "]||[_timeLabel4444.text isEqualToString:@""]) {
            clickLabel1111.text=@"3";
            timeView1111.hidden=NO;
            timeView2222.hidden=NO;
            timeView3333.hidden=NO;
            timeView4444.hidden=YES;
            timeView5555.hidden=YES;
            timeView6666.hidden=YES;
            
            _timeLabel4444.text=Nil;
            _timeLabel5555.text=Nil;
            _timeLabel6666.text=Nil;
        }
        else if ([_timeLabel5555.text isEqualToString:@" "]||[_timeLabel5555.text isEqualToString:@""]) {
            clickLabel1111.text=@"4";
            timeView1111.hidden=NO;
            timeView2222.hidden=NO;
            timeView3333.hidden=NO;
            timeView4444.hidden=NO;
            timeView5555.hidden=YES;
            timeView6666.hidden=YES;
            
            _timeLabel5555.text=Nil;
            _timeLabel6666.text=Nil;
        }
        else if ([_timeLabel6666.text isEqualToString:@" "]||[_timeLabel6666.text isEqualToString:@""]) {
            clickLabel1111.text=@"5";
            timeView1111.hidden=NO;
            timeView2222.hidden=NO;
            timeView3333.hidden=NO;
            timeView4444.hidden=NO;
            timeView5555.hidden=NO;
            timeView6666.hidden=YES;
            
            _timeLabel6666.text=Nil;
        }
        else
        {
            clickLabel1111.text=@"6";
            timeView1111.hidden=NO;
            timeView2222.hidden=NO;
            timeView3333.hidden=NO;
            timeView4444.hidden=NO;
            timeView5555.hidden=NO;
            timeView6666.hidden=NO;
        }
        
        
        
        
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
    
    
    
    _backguandView.canCancelContentTouches=false;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    else
    {
        cell.textLabel.text=nil;
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *str=[NSString new];;
        str =[array objectAtIndex:indexPath.row];
    cell.textLabel.text=str;
    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:25];
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
-(IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_timeTableView) {
        
        clickLabel.text=[array objectAtIndex:indexPath.row];
        _timeTableView.hidden=YES;
        switch (indexPath.row) {
            case 0:
                timeView1.hidden=NO;
                timeView2.hidden=YES;
                timeView3.hidden=YES;
                timeView4.hidden=YES;
                timeView5.hidden=YES;
                timeView6.hidden=YES;
                _timeLabel2.text=Nil;
                _timeLabel3.text=Nil;
                _timeLabel4.text=Nil;
                _timeLabel5.text=Nil;
                _timeLabel6.text=Nil;
                break;
            case 1:
                timeView1.hidden=NO;
                timeView2.hidden=NO;
                timeView3.hidden=YES;
                timeView4.hidden=YES;
                timeView5.hidden=YES;
                timeView6.hidden=YES;
                _timeLabel3.text=Nil;
                _timeLabel4.text=Nil;
                _timeLabel5.text=Nil;
                _timeLabel6.text=Nil;
                break;
            case 2:
                timeView1.hidden=NO;
                timeView2.hidden=NO;
                timeView3.hidden=NO;
                timeView4.hidden=YES;
                timeView5.hidden=YES;
                timeView6.hidden=YES;
                _timeLabel4.text=Nil;
                _timeLabel5.text=Nil;
                _timeLabel6.text=Nil;
                break;
            case 3:
                timeView1.hidden=NO;
                timeView2.hidden=NO;
                timeView3.hidden=NO;
                timeView4.hidden=NO;
                timeView5.hidden=YES;
                timeView6.hidden=YES;
                _timeLabel5.text=Nil;
                _timeLabel6.text=Nil;
                break;
            case 4:
                timeView1.hidden=NO;
                timeView2.hidden=NO;
                timeView3.hidden=NO;
                timeView4.hidden=NO;
                timeView5.hidden=NO;
                timeView6.hidden=YES;
                _timeLabel6.text=Nil;
                break;
            case 5:
                timeView1.hidden=NO;
                timeView2.hidden=NO;
                timeView3.hidden=NO;
                timeView4.hidden=NO;
                timeView5.hidden=NO;
                timeView6.hidden=NO;
        
                break;
                
                
                
            default:

                break;
        }
    }
    if (tableView==_secondTable) {
        _timeClickLabel2.text=[array objectAtIndex:indexPath.row];
        _secondTable.hidden=YES;
        switch (indexPath.row) {
            case 0:
                //
                timeView111.hidden =NO;
                timeView222.hidden =YES;
                timeView333.hidden =YES;
                timeView444.hidden =YES;
                timeView555.hidden =YES;
                timeView666.hidden =YES;
                timeLabel222.text=nil;
                timeLabel333.text=nil;
                timeLabel444.text=nil;
                timeLabel555.text=nil;
                timeLabel666.text=nil;
                
                break;
            case 1:
                //
                timeView111.hidden =NO;
                timeView222.hidden =NO;
                timeView333.hidden =YES;
                timeView444.hidden =YES;
                timeView555.hidden =YES;
                timeView666.hidden =YES;
                
                timeLabel333.text=nil;
                timeLabel444.text=nil;
                timeLabel555.text=nil;
                timeLabel666.text=nil;
                break;
            case 2:
                //
                timeView111.hidden =NO;
                timeView222.hidden =NO;
                timeView333.hidden =NO;
                timeView444.hidden =YES;
                timeView555.hidden =YES;
                timeView666.hidden =YES;
                
                timeLabel444.text=nil;
                timeLabel555.text=nil;
                timeLabel666.text=nil;
                break;
            case 3:
                //
                timeView111.hidden =NO;
                timeView222.hidden =NO;
                timeView333.hidden =NO;
                timeView444.hidden =NO;
                timeView555.hidden =YES;
                timeView666.hidden =YES;
                
                timeLabel555.text=nil;
                timeLabel666.text=nil;
                break;
            case 4:
                //
                timeView111.hidden =NO;
                timeView222.hidden =NO;
                timeView333.hidden =NO;
                timeView444.hidden =NO;
                timeView555.hidden =NO;
                timeView666.hidden =YES;
                
                timeLabel666.text=nil;
                break;
            case 5:
                //
                timeView111.hidden =NO;
                timeView222.hidden =NO;
                timeView333.hidden =NO;
                timeView444.hidden =NO;
                timeView555.hidden =NO;
                timeView666.hidden =NO;
                break;
                
            default:
                break;
        }
        
        
    }
    if (tableView==walkTableChilk) {
        clickLabel1111.text=[array objectAtIndex:indexPath.row];
        walkTableChilk.hidden=YES;
        switch (indexPath.row) {
            case 0:
                timeView1111.hidden=NO;
                timeView2222.hidden=YES;
                timeView3333.hidden=YES;
                timeView4444.hidden=YES;
                timeView5555.hidden=YES;
                timeView6666.hidden=YES;
                _timeLabel2222.text=Nil;
                _timeLabel3333.text=Nil;
                _timeLabel4444.text=Nil;
                _timeLabel5555.text=Nil;
                _timeLabel6666.text=Nil;
                break;
            case 1:
                timeView1111.hidden=NO;
                timeView2222.hidden=NO;
                timeView3333.hidden=YES;
                timeView4444.hidden=YES;
                timeView5555.hidden=YES;
                timeView6666.hidden=YES;
                _timeLabel3333.text=Nil;
                _timeLabel4444.text=Nil;
                _timeLabel5555.text=Nil;
                _timeLabel6666.text=Nil;
                break;
            case 2:
                timeView1111.hidden=NO;
                timeView2222.hidden=NO;
                timeView3333.hidden=NO;
                timeView4444.hidden=YES;
                timeView5555.hidden=YES;
                timeView6666.hidden=YES;
                _timeLabel4444.text=Nil;
                _timeLabel5555.text=Nil;
                _timeLabel6666.text=Nil;
                break;
            case 3:
                timeView1111.hidden=NO;
                timeView2222.hidden=NO;
                timeView3333.hidden=NO;
                timeView4444.hidden=NO;
                timeView5555.hidden=YES;
                timeView6666.hidden=YES;
                _timeLabel5555.text=Nil;
                _timeLabel6666.text=Nil;
                break;
            case 4:
                timeView1111.hidden=NO;
                timeView2222.hidden=NO;
                timeView3333.hidden=NO;
                timeView4444.hidden=NO;
                timeView5555.hidden=NO;
                timeView6666.hidden=YES;
                _timeLabel6666.text=Nil;
                break;
            case 5:
                timeView1111.hidden=NO;
                timeView2222.hidden=NO;
                timeView3333.hidden=NO;
                timeView4444.hidden=NO;
                timeView5555.hidden=NO;
                timeView6666.hidden=NO;
                
                break;
                
                
                
            default:
                
                break;
        }
    }

}

-(IBAction)chilkTimeButton:(id)sender
{
    clickLabel.text=@"";
    if (_timeTableView.hidden==YES) {
        _timeTableView.hidden=NO;
    }
    else
    {
        _timeTableView.hidden=YES;
    }
}
-(IBAction)timeButton1:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=1;
}
-(IBAction)timeButton2:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
     i=2;
}
-(IBAction)timeButton3:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
     i=3;
}
-(IBAction)timeButton4:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=4;
}
-(IBAction)timeButton5:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=5;
}
-(IBAction)timeButton6:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=6;
}
-(IBAction)timeButtonStart:(id)sender
{
      [self.medication_Note_TextView resignFirstResponder];
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    [_dostextView resignFirstResponder];
    [_agetextView resignFirstResponder];
    [_textViewTitle resignFirstResponder];
    i=11;
}
-(IBAction)timeButtonEnd:(id)sende
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
      [self.medication_Note_TextView resignFirstResponder];
    [_dostextView resignFirstResponder];
    [_agetextView resignFirstResponder];
    [_textViewTitle resignFirstResponder];
    i=12;
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
            break;
        case 2:
            //
            _timeLabel2.text=tempNum;
            break;
        case 3:
            //
            _timeLabel3.text=tempNum;
            break;
        case 4:
            //
            _timeLabel4.text=tempNum;
            break;
        case 5:
            //
            _timeLabel5.text=tempNum;
            break;
        case 6:
            //
            _timeLabel6.text=tempNum;
            break;
            
        case 11:
            //
            _labelStar.text=tempNum;
            break;
        case 12:
            //
            _labelEnd.text=tempNum;
            break;
        case 111:
            //
          timeLabel111.text=tempNum;
            break;
        case 222:
            //
           timeLabel222.text=tempNum;
            break;
        case 333:
            //
            timeLabel333.text=tempNum;
            break;
        case 444:
            //
            timeLabel444.text=tempNum;
            break;
        case 555:
            //
          timeLabel555.text=tempNum;
            break;
        case 666:
            //
           timeLabel666.text=tempNum;
            break;
        case 1111:
            //
            _timeLabel1111.text=tempNum;
            break;
        case 2222:
            //
            _timeLabel2222.text=tempNum;
            break;
        case 3333:
            //
            _timeLabel3333.text=tempNum;
            break;
        case 4444:
            //
            _timeLabel4444.text=tempNum;
            break;
        case 5555:
            //
            _timeLabel5555.text=tempNum;
            break;
        case 6666:
            //
            _timeLabel6666.text=tempNum;
            break;
            

        default:
            break;
    }
}
-(IBAction)timeClick:(id)sender
{
    _timeClickLabel2.text=@"";
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
}
-(IBAction)timeBUtton222:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=222;
}

-(IBAction)timeBUtton333:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=333;
}
-(IBAction)timeBUtton444:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=444;
}
-(IBAction)timeBUtton555:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=555;
}
-(IBAction)timeBUtton666:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=666;
}



-(IBAction)timeClick1111:(id)sender
{
clickLabel1111.text=@"";
    if (walkTableChilk.hidden==YES) {
        walkTableChilk.hidden=NO;
    }
    else
    {
        walkTableChilk.hidden=YES;
    }
}
-(IBAction)timeBUtton1111:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=1111;
}
-(IBAction)timeBUtton2222:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=2222;
}
-(IBAction)timeBUtton3333:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=3333;
}
-(IBAction)timeBUtton4444:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=4444;
}
-(IBAction)timeBUtton5555:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=5555;
}
-(IBAction)timeBUtton6666:(id)sender
{
    backgoundView.hidden=NO;
    datePickerView.hidden=NO;
    i=6666;
}


-(void)delayDoneThread
{
    
    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"Y" forKey:@"Frist Go to Calendar Key"];
    [defaults synchronize];
    
    
    MR_ListViewController *mR_List = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
    mR_List.dateDateStr=self.dataStr;
    
    [DBHelper zhendeyouma:1];
    
    NSMutableArray *allArray1;
    NSString*tempsum1;
    NSString*tempsum2;
    NSString*tempsum4;
    
    if ([_hendLabel.text isEqualToString:[Utility getStringByKey:@"Daily Measurement"]])
    {
        tempsum1=_hendLabel.text;
        tempsum2=bPECGBG.text;
        if (_timeLabel1.text==nil) {
            theTImeQuent=3;
            if ([self.bECPText isEqualToString:@"B"])
            {
                //   [DBHelper deleteCalendarBGList];
            }
            else if ([self.bECPText isEqualToString:@"E"])
            {
                //  [DBHelper deleteCalendarECGList];
            }
            else
            {
                //   [DBHelper deleteCalendarBGList];
            }
            
            _timeLabel1.text=@" " ;
            _timeLabel2.text=@" " ;
            _timeLabel3.text=@" " ;
            _timeLabel4.text=@" " ;
            _timeLabel5.text=@" " ;
            _timeLabel6.text=@" " ;
        }
        else if (_timeLabel2.text==nil) {
            if ([_timeLabel1.text length]<2) {
                theTImeQuent=3;
            }
            
            else
            {
                theTImeQuent=0;
                
                if ([self.bECPText isEqualToString:@"B"])
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
                else if ([self.bECPText isEqualToString:@"E"])
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
        else  if (_timeLabel3.text==nil) {
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
                
                if ([self.bECPText isEqualToString:@"B"])
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
                }
                else if ([self.bECPText isEqualToString:@"E"])
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
        else  if (_timeLabel4.text==nil) {
            if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3||[_timeLabel3.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                if ([self.bECPText isEqualToString:@"B"])
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
                    
                    
                    
                    
                    NSString *strRandom3=[[NSString alloc]initWithFormat:@"%d",random];
                    Alarm * malarm3=[[Alarm alloc]initWithBPId:strRandom3 bpRepeat:@"" bptime:_timeLabel3.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                    [DBHelper addCalendarRoadBP:malarm3];
                }
                else if ([self.bECPText isEqualToString:@"E"])
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
        else   if (_timeLabel5.text==nil) {
            if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3||[_timeLabel3.text length]<3||[_timeLabel4.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                if ([self.bECPText isEqualToString:@"B"])
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
                    
                    
                    
                    
                    NSString *strRandom4=[[NSString alloc]initWithFormat:@"%d",random];
                    Alarm * malarm4=[[Alarm alloc]initWithBPId:strRandom4 bpRepeat:@"" bptime:_timeLabel4.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                    [DBHelper addCalendarRoadBP:malarm4];
                }
                else if ([self.bECPText isEqualToString:@"E"])
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
        else    if (_timeLabel6.text!=nil) {
            
            
            if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3||[_timeLabel3.text length]<3||[_timeLabel4.text length]<3||[_timeLabel5.text length]<3||[_timeLabel6.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                
                if ([self.bECPText isEqualToString:@"B"])
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
                    
                    
                    
                    
                    NSString *strRandom6=[[NSString alloc]initWithFormat:@"%d",random];
                    Alarm * malarm6=[[Alarm alloc]initWithBPId:strRandom6 bpRepeat:@"" bptime:_timeLabel6.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                    [DBHelper addCalendarRoadBP:malarm6];
                }
                else if ([self.bECPText isEqualToString:@"E"])
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
        else    if (_timeLabel6.text==nil) {
            if ([_timeLabel1.text length]<3||[_timeLabel2.text length]<3||[_timeLabel3.text length]<3||[_timeLabel4.text length]<3||[_timeLabel5.text length]<3) {
                theTImeQuent=3;
                
            }
            else
            {
                theTImeQuent=0;
                
                
                
                
                if ([self.bECPText isEqualToString:@"B"])
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
                    
                    
                    
                    
                    NSString *strRandom5=[[NSString alloc]initWithFormat:@"%d",random];
                    Alarm * malarm5=[[Alarm alloc]initWithBPId:strRandom5 bpRepeat:@"" bptime:_timeLabel5.text bptype:@"" bpcreatetime:@"" bpservertime:@""];
                    [DBHelper addCalendarRoadBP:malarm5];
                }
                else if ([self.bECPText isEqualToString:@"E"])
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
        
        
        
        allArray1=[[NSMutableArray alloc]initWithObjects:tempsum1,tempsum2,_timeLabel1.text,_timeLabel2.text,_timeLabel3.text,_timeLabel4.text,_timeLabel5.text,_timeLabel6.text, nil];
        
    }
    if ([_hendLabel.text isEqualToString:[Utility getStringByKey:@"Daily Medication"]])
    {
        
        tempsum1 = _hendLabel.text;
        tempsum2 = _dostextView.text;
        tempsum4 = _agetextView.text;
        if (timeLabel111.text==nil) {
            theTImeQuent=3;
            timeLabel111.text=@" " ;
            timeLabel222.text=@" " ;
            timeLabel333.text=@" " ;
            timeLabel444.text=@" " ;
            timeLabel555.text=@" " ;
            timeLabel666.text=@" " ;
        }
        else if (timeLabel222.text==nil) {
            if ([timeLabel111.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@",timeLabel111.text];
                tempSUMTime=[[NSString alloc]initWithFormat:@"%@",timeLabel111.text ];
                theTaken=[[NSString alloc]initWithFormat:@"N "];
                timeLabel222.text=@" " ;
                timeLabel333.text=@" " ;
                timeLabel444.text=@" " ;
                timeLabel555.text=@" " ;
                timeLabel666.text=@" " ;
            }
        }
        else  if (timeLabel333.text==nil) {
            if ([timeLabel111.text length]<3||[timeLabel222.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@",timeLabel111.text,timeLabel222.text];
                tempSUMTime=[[NSString alloc]initWithFormat:@"%@ %@",timeLabel111.text ,timeLabel222.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N "];
                timeLabel333.text=@" " ;
                timeLabel444.text=@" " ;
                timeLabel555.text=@" " ;
                timeLabel666.text=@" " ;
            }
        }
        else  if (timeLabel444.text==nil) {
            if ([timeLabel111.text length]<3||[timeLabel222.text length]<3||[timeLabel333.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@",timeLabel111.text,timeLabel222.text,timeLabel333.text];
                tempSUMTime=[[NSString alloc]initWithFormat:@"%@ %@ %@",timeLabel111.text ,timeLabel222.text,timeLabel333.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N N "];
                timeLabel444.text=@" " ;
                timeLabel555.text=@" " ;
                timeLabel666.text=@" " ;
            }
        }
        else   if (timeLabel555.text==nil) {
            if ([timeLabel111.text length]<3||[timeLabel222.text length]<3||[timeLabel333.text length]<3||[timeLabel444.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@",timeLabel111.text,timeLabel222.text,timeLabel333.text,timeLabel444.text];
                tempSUMTime=[[NSString alloc]initWithFormat:@"%@ %@ %@ %@",timeLabel111.text ,timeLabel222.text,timeLabel333.text,timeLabel444.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N N N "];
                timeLabel555.text=@" " ;
                timeLabel666.text=@" " ;
            }
        }
        else    if (timeLabel666.text!=nil) {
            if ([timeLabel111.text length]<3||[timeLabel222.text length]<3||[timeLabel333.text length]<3||[timeLabel444.text length]<3||[timeLabel555.text length]<3||[timeLabel666.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@,%@",timeLabel111.text,timeLabel222.text,timeLabel333.text,timeLabel444.text,timeLabel555.text,timeLabel666.text];
                tempSUMTime=[[NSString alloc]initWithFormat:@"%@ %@ %@ %@ %@ %@",timeLabel111.text ,timeLabel222.text,timeLabel333.text,timeLabel444.text,timeLabel555.text,timeLabel666.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N N N N N "];
            }
        }
        else    if (timeLabel666.text==nil) {
            if ([timeLabel111.text length]<3||[timeLabel222.text length]<3||[timeLabel333.text length]<3||[timeLabel444.text length]<3||[timeLabel555.text length]<3) {
                theTImeQuent=3;
            }
            else
            {
                theTImeQuent=0;
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@",timeLabel111.text,timeLabel222.text,timeLabel333.text,timeLabel444.text,timeLabel555.text];
                tempSUMTime=[[NSString alloc]initWithFormat:@"%@ %@ %@ %@ %@",timeLabel111.text ,timeLabel222.text,timeLabel333.text,timeLabel444.text,timeLabel555.text];
                theTaken=[[NSString alloc]initWithFormat:@"N N N N N "];
                timeLabel666.text=@" " ;
            }
            
        }
        
        
        allArray1=[[NSMutableArray alloc]initWithObjects:tempsum1,tempsum2,timeLabel111.text,timeLabel222.text,timeLabel333.text,timeLabel444.text,timeLabel555.text,timeLabel666.text,tempsum4,nil];
        
        
    }
    if ([_hendLabel.text isEqualToString:[Utility getStringByKey:@"Others"]])
    {
        if ([_labelStar.text length]<2||[_labelEnd.text length]<2)
        {
            theTImeQuent=3;
        }
        else if([_labelStar.text isEqualToString:_labelEnd.text])
        {
            theTImeQuent=1;
        }
        else if ([_labelStar.text length]>3||[_labelEnd.text length]>2)
        {
            
            NSString *start1TempRain=[_labelStar.text substringWithRange:NSMakeRange(0, 2)];
            NSString *start2TempRain=[_labelStar.text substringWithRange:NSMakeRange(3, 2)];
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
        
        tempsum1=_hendLabel.text;
        tempsum2=_textViewTitle.text;
        tempsum4=_textViewNote.text;
        allArray1=[[NSMutableArray alloc]initWithObjects:tempsum1,tempsum2,_labelStar.text,_labelEnd.text,self.turnOtherDateDate,tempsum4, nil];
        
    }
    
    if ([_hendLabel.text isEqualToString:[Utility getStringByKey:@"Exercise"]]) {
        
        NSLog(@"EXERCISe");
        
        if (_timeLabel1111.text==nil) {
            
            
            theTImeQuent=3;
            //    [DBHelper deleteCalendarWalkingList];
            _timeLabel1111.text=@" " ;
            _timeLabel2222.text=@" " ;
            _timeLabel3333.text=@" " ;
            _timeLabel4444.text=@" " ;
            _timeLabel5555.text=@" " ;
            _timeLabel6666.text=@" " ;
            
        }
        else if (_timeLabel2222.text==nil) {
            if ([_timeLabel1111.text length]<3) {
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
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@",_timeLabel1111.text];
                _timeLabel2222.text=@" " ;
                _timeLabel3333.text=@" " ;
                _timeLabel4444.text=@" " ;
                _timeLabel5555.text=@" " ;
                _timeLabel6666.text=@" " ;
            }
        }
        else if (_timeLabel3333.text==nil) {
            
            if ([_timeLabel1111.text length]<3||[_timeLabel2222.text length]<3) {
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
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm2];
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@",_timeLabel1111.text,_timeLabel2222.text];
                _timeLabel3333.text=@" " ;
                _timeLabel4444.text=@" " ;
                _timeLabel5555.text=@" " ;
                _timeLabel6666.text=@" " ;
            }
        }
        else if (_timeLabel4444.text==nil) {
            
            if ([_timeLabel1111.text length]<3||[_timeLabel2222.text length]<3||[_timeLabel3333.text length]<3) {
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
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm3=[[Alarm alloc]initWithWalkingId:strRAndom3 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel3333.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm3];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@",_timeLabel1111.text,_timeLabel2222.text,_timeLabel3333.text];
                _timeLabel4444.text=@" " ;
                _timeLabel5555.text=@" " ;
                _timeLabel6666.text=@" " ;
            }
        }
        else if (_timeLabel5555.text==nil) {
            
            if ([_timeLabel1111.text length]<3||[_timeLabel2222.text length]<3||[_timeLabel3333.text length]<3||[_timeLabel4444.text length]<3) {
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
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm3=[[Alarm alloc]initWithWalkingId:strRAndom3 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel3333.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm4=[[Alarm alloc]initWithWalkingId:strRAndom4 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel4444.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm4];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@",_timeLabel1111.text,_timeLabel2222.text,_timeLabel3333.text,_timeLabel4444.text];
                _timeLabel5555.text=@" " ;
                _timeLabel6666.text=@" " ;
            }
        }
        else if (_timeLabel6666.text!=nil) {
            if ([_timeLabel1111.text length]<3||[_timeLabel2222.text length]<3||[_timeLabel3333.text length]<3||[_timeLabel4444.text length]<3||[_timeLabel5555.text length]<3||[_timeLabel6666.text length]<3) {
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
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm3=[[Alarm alloc]initWithWalkingId:strRAndom3 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel3333.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm4=[[Alarm alloc]initWithWalkingId:strRAndom4 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel4444.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm5=[[Alarm alloc]initWithWalkingId:strRAndom5 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel5555.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm6=[[Alarm alloc]initWithWalkingId:strRAndom6 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel6666.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm6];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@,%@",_timeLabel1111.text,_timeLabel2222.text,_timeLabel3333.text,_timeLabel4444.text,_timeLabel5555.text,_timeLabel6666.text];
            }
        }
        
        else if (_timeLabel6666.text==nil) {
            if ([_timeLabel1111.text length]<3||[_timeLabel2222.text length]<3||[_timeLabel3333.text length]<3||[_timeLabel4444.text length]<3||[_timeLabel5555.text length]<3) {
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
                Alarm *malarm=[[Alarm alloc]initWithWalkingId:strRAndom StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel1111.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm2=[[Alarm alloc]initWithWalkingId:strRAndom2 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel2222.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm3=[[Alarm alloc]initWithWalkingId:strRAndom3 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel3333.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm4=[[Alarm alloc]initWithWalkingId:strRAndom4 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel4444.text Repeat:@"" CreateTime:@"" Servertime:@""];
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
                Alarm *malarm5=[[Alarm alloc]initWithWalkingId:strRAndom5 StartDate:self.dataStr EndDate:self.sevenDateStr Type:@"" Time:_timeLabel5555.text Repeat:@"" CreateTime:@"" Servertime:@""];
                [DBHelper addCalendarRoadWalking:malarm5];
                
                tempSum_Url =[[NSString alloc]initWithFormat:@"%@,%@,%@,%@,%@",_timeLabel1111.text,_timeLabel2222.text,_timeLabel3333.text,_timeLabel4444.text,_timeLabel5555.text];
                _timeLabel6666.text=@" " ;
            }
            NSLog(@"------------------------");
            //  tempsum3 =[[NSString alloc]initWithFormat:@"%@ %@ %@ %@ %@ %@",_timeLabel1111.text,_timeLabel2222.text,_timeLabel3333.text,_timeLabel4444.text,_timeLabel5555.text,_timeLabel6666.text];
        }
    }
    NSTimer *timer;
    
    switch (theTImeQuent) {
            
        case 0:
            [self sendResult];
            
            [self.navigationController pushViewController:mR_List animated:YES];
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
                thebackTitlelabel.text=@"The end time cannot be greater than the start time";
            }
            else
            {
                thebackTitlelabel.text=@"結束時間不能大於開始時間";
            }
            thebackTitlelabel.hidden=NO;
            [self.view bringSubviewToFront:thebackTitlelabel];
            NSLog(@"結束時間不能大於開始時間");
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
            break;
        case 3:
            
            if ([strTempTemp isEqualToString:@"HealthReach Calendar"]) {
                thebackTitlelabel.text=@"Time cannot be empty";
            }
            else
            {
                thebackTitlelabel.text=@"時間不能爲空";
            }
            thebackTitlelabel.hidden=NO;
            [self.view bringSubviewToFront:thebackTitlelabel];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
            NSLog(@"時間不能爲空");
            break;
        default:
            break;
    }
    
    
    [doneBUTTON setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p1.png"] forState:UIControlStateNormal];
    
}
    





-(IBAction)Done:(id)sender{
    [doneBUTTON setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    
    
    [self performSelector:@selector(delayDoneThread) withObject:nil afterDelay:0.1];
}

-(void)timerFired
{
    NSLog(@"+++++++++++++++++++++");
  thebackTitlelabel.hidden=YES;
}
-(void)sendResult
{
//    NSData *imageData=UIImagePNGRepresentation(photoImageVIew.image);
//    NSString *imageDate_String = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",imageDate_String);
    _theView.hidden=NO;
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    NSLog(@"selg,DateStr=%@",self.dataStr);
    NSLog(@"self.sevenDateStr=%@",self.sevenDateStr);
    NSString *url_string = [[NSString alloc]init];
    //url_string = [url_string stringByAppendingString:apiBaseURL];
    url_string = [url_string stringByAppendingString:@"login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];

    
    url_string = [url_string stringByAppendingString:@"&action=U"];
    
    url_string = [url_string stringByAppendingString:@"&type="];
    
    url_string = [url_string stringByAppendingString:self.bECPText];
    if ([self.bECPText isEqual:@"B"] ) {
        url_string = [url_string stringByAppendingString:@"&id=-1"];
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:tempSum_Url];
  
        
        
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        NSLog(@"++++++++++ %@ ++++++++++++",url_string);
    }
    if ([self.bECPText isEqual:@"E"] ) {
        url_string = [url_string stringByAppendingString:@"&id=-1"];
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:tempSum_Url];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        NSLog(@"++++++++++ %@ ++++++++++++",url_string);
    }
    if ([self.bECPText isEqual:@"G"] ) {
        url_string = [url_string stringByAppendingString:@"&id=-1"];
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:tempSum_Url];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        NSLog(@"++++++++++ %@ ++++++++++++",url_string);
    }
    
    
    
    if ([self.bECPText isEqual:@"A"] ) {
        url_string = [url_string stringByAppendingString:@"&id="];
        url_string = [url_string stringByAppendingString:self.turnOtherID];
//        NSString * str1=[_textViewTitle.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//        NSLog(@"%@",str1);
//        NSString * str2=[_textViewNote.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//        NSLog(@"%@",str2);
        url_string = [url_string stringByAppendingString:@"&startdate="];
        url_string = [url_string stringByAppendingString:self.turnOtherDateDate];
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:_labelStar.text];
        url_string = [url_string stringByAppendingString:@"&endtime="];
        url_string = [url_string stringByAppendingString:_labelEnd.text];
        url_string = [url_string stringByAppendingString:@"&title="];
        url_string = [url_string stringByAppendingString:_textViewTitle.text];
        url_string = [url_string stringByAppendingString:@"&note="];
        url_string = [url_string stringByAppendingString:_textViewNote.text];
       // url_string = [url_string stringByAppendingString:@"&on="];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        
        Alarm*  alarm =[[Alarm alloc]initWithOthersId:self.turnOtherID Title:_textViewTitle.text StartTime:_labelStar.text EndTime:_labelEnd.text Note:_textViewNote.text Date:self.turnOtherDateDate Type:@"" Createtime:currentDateStr Servertime:currentDateStr];
        [DBHelper addCalendarRoadOthers:alarm];
        
    }
    if ([self.bECPText isEqualToString:@"M"]) {
//        NSString * dostext=[_dostextView.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//        NSString * agetext=[_agetextView.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//     
        url_string = [url_string stringByAppendingString:@"&id=-1"];
      
        url_string = [url_string stringByAppendingString:@"&medid="];
        url_string = [url_string stringByAppendingString:_turnmedIDText];
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
        url_string = [url_string stringByAppendingString:@"&note="];
        url_string = [url_string stringByAppendingString:self.medication_Note_TextView.text];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
    

        
        
        Alarm* alarm=[[Alarm alloc]initWithMedicationId:self.turnmedIDText Title:_dostextView.text Meal:self.banMEAL DosAge:_agetextView.text Servertime:currentDateStr ReminderTime:tempSUMTime ReminderID:@"" ReminderType:@"" ReminderRepeat:@"" ReminderTicken:theTaken ReminderCreateTime:@"" ReminderserverTime:@"" ReminderImageString:imageBase64Str Note:self.medication_Note_TextView.text];
        
#pragma malk -- upDate
        [DBHelper addCalendarRoadMedication:alarm];
        
        [DBHelper addCalendarRoadMedication_Notes:alarm];
        
        
    }
    if ([self.bECPText isEqualToString:@"K"]) {

        url_string = [url_string stringByAppendingString:@"&id=-1"];
        url_string = [url_string stringByAppendingString:@"&startdate="];
        url_string = [url_string stringByAppendingString:self.dataStr];
       url_string = [url_string stringByAppendingString:@"&enddate="];
        url_string = [url_string stringByAppendingString:self.sevenDateStr];

        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:tempSum_Url];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        
    }
    
    
    
    NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];

    
    NSURL *request_url = [NSURL URLWithString:encodedString];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [ NSData dataWithBytes: [ [url_string encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
    
    if ((requestData == nil) || [syncUtility XMLHasError:requestData]) {
        NSLog(@"Get BP History error!");
    }
    [request setHTTPBody:requestData];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (data != nil && error == nil)
                               {
                                   //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                   // It worked, your source HTML is in sourceHTML
                                   
                                   NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
                                   NSLog(@"%@====================",xmlSTr);
                               }
                               else
                               {
                                   // There was an error, alert the user
                               }
                               
                           }];
    
   
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
  
    self.turnOtherDateDate=tempNum;
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

-(IBAction)before:(id)sender
{
    beforeMealButton.image=ridaoOn ;
    afterMealButton .image=ridaoOff;
    naButton.image=ridaoOff;
    self.banMEAL=@"B";
}
-(IBAction)after:(id)sender
{
    beforeMealButton.image=ridaoOff ;
    afterMealButton .image=ridaoOn;
    naButton.image=ridaoOff;
    self.banMEAL=@"A";
}
-(IBAction)na:(id)sender
{
    beforeMealButton.image=ridaoOff ;
    afterMealButton .image=ridaoOff;
    naButton.image=ridaoOn;
    self.banMEAL=@"N";
}
- (BOOL)textView:(UITextView *)textView1 shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //第二种取消键盘时间点（按下Return键）
    
    if ([text isEqualToString:@"\n"])
    {
        if (textView1==_textViewNote) {
            //
            return YES;
        }
                //
        else
            return NO;
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
   
    if (textView==_textViewNote) {
        __scrollView.frame=CGRectMake(0, -100, 320, 368);


        
    }
    if (textView==self.medication_Note_TextView)
    {
      labelText_NOte.hidden=YES;
       
        self.medication_Note_TextView.tag=111;
        //_backguandView.frame=CGRectMake(0, -200, 320, 405);
        
        CGSize scrollViewContenSize=_backguandView.contentSize;
        
        scrollViewContenSize.height=scrollViewContenSize.height+260;
        
        _backguandView.contentSize=scrollViewContenSize;
        
        CGPoint bottomOffset = CGPointMake(0, _backguandView.contentSize.height - _backguandView.bounds.size.height-20);
        
        [_backguandView setContentOffset:bottomOffset animated:YES];
        
        if (iPad) {
            _backguandView.frame=CGRectMake(0, -200, 320, 275);
        }
        
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textField==_agetextView||textField==_dostextView");
    if (textField==_agetextView||textField==_dostextView)
    {
        NSLog(@"textField==_agetextView||textField==_dostextView");
        if (!iPad) {
             _backguandView.frame=CGRectMake(0, 0, 320, 405);
        }
        else
        {
            
            _backguandView.frame=CGRectMake(0, -30, 320, 275);
            
        }
        
    }

}


-(void)delayDeleteMadicnThread{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    [defaults setObject:@"Y" forKey:@"Frist Go to Calendar Key"];
    [defaults synchronize];
    
    MR_ListViewController *mR_List = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd%20HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"%@",currentDateStr);
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthReminder?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&action=D"];
    url_string = [url_string stringByAppendingString:@"&type="];
    
    url_string = [url_string stringByAppendingString:self.bECPText];
    
    if ([self.bECPText isEqualToString:@"M"])
    {
        url_string =[url_string stringByAppendingString:@"&id=-1"];
        url_string =[url_string stringByAppendingString:@"&medid="];
        url_string =[url_string stringByAppendingString:self.turnmedIDText];
        [DBHelper deleteCalendarMedicationList:self.turnmedIDText];
        [DBHelper deleteCalendarMedicationList_Notes:self.turnmedIDText];
        
    }
    
    else
    {
        NSLog(@"!!!!!!!!!!!!!!!!!!Error");
    }
    
    
    
    
    
    NSLog(@"Weight sending url:%@",url_string);
    NSURL *request_url = [NSURL URLWithString:url_string];
    NSLog(@"request_url:%@",request_url);
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    
    if ((xmlData  == nil) || [syncUtility XMLHasError:xmlData ]) {
        NSLog(@"Get BP History error!");
    }
    [self.navigationController pushViewController:mR_List animated:YES];
    
    
    [deleteMedicineTextFont setBackgroundImage:[UIImage imageNamed:@"00_btn_red_p2.png"] forState:UIControlStateNormal];
}

-(IBAction)DeleteMadicn:(id)sender
{
    
    
    
    //
    [deleteMedicineTextFont setBackgroundImage:[UIImage imageNamed:@"btn_red_p1_effect.png"] forState:UIControlStateNormal];
    
    
    [self performSelector:@selector(delayDeleteMadicnThread) withObject:nil afterDelay:0.1];

    
    
    
    
   


}



-(void)delayDeletesThread{
    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    [defaults setObject:@"Y" forKey:@"Frist Go to Calendar Key"];
    [defaults synchronize];
    
    
    
    [DBHelper zhendeyouma:1];
    
    MR_ListViewController *mR_List = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd%20HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"%@",currentDateStr);
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthReminder?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&action=D"];
    url_string = [url_string stringByAppendingString:@"&type="];
    
    url_string = [url_string stringByAppendingString:self.bECPText];
    if ([self.bECPText isEqualToString:@"B"]) {
        //
        [DBHelper deleteCalendarBPList];
        url_string =[url_string stringByAppendingString:@"&id=-1"];
        
    }
    else if ([self.bECPText isEqualToString:@"E"])
    {
        [DBHelper deleteCalendarECGList];
        url_string =[url_string stringByAppendingString:@"&id=-1"];
    }
    else if ([self.bECPText isEqualToString:@"G"])
    {
        [DBHelper deleteCalendarBGList];
        url_string =[url_string stringByAppendingString:@"&id=-1"];
    }
    
    
    else if ([self.bECPText isEqualToString:@"A"])
    {
        url_string = [url_string stringByAppendingString:@"&id="];
        url_string = [url_string stringByAppendingString:self.turnOtherID];
        [DBHelper deleteCalendarOthersList:self.turnOtherID];
        
    }
    else if ([self.bECPText isEqualToString:@"K"])
    {
        url_string =[url_string stringByAppendingString:@"&id=-1"];
        [DBHelper deleteCalendarWalkingList];
    }
    else
    {
        NSLog(@"!!!!!!!!!!!!!!!!!!Error");
    }
    
    
    
    
    
    NSLog(@"Weight sending url:%@",url_string);
    NSURL *request_url = [NSURL URLWithString:url_string];
    NSLog(@"request_url:%@",request_url);
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    if ((xmlData  == nil) || [syncUtility XMLHasError:xmlData ]) {
        NSLog(@"Get BP History error!");
    }
    
    
    [self.navigationController pushViewController:mR_List animated:YES];
    
    
    [deleteBUTTON setBackgroundImage:[UIImage imageNamed:@"00_btn_red_p1.png"] forState:UIControlStateNormal];

}


-(IBAction)Deletes:(id)sender
{
    
    [deleteBUTTON setBackgroundImage:[UIImage imageNamed:@"btn_red_p1_effect.png"] forState:UIControlStateNormal];
    
    
    [self performSelector:@selector(delayDeletesThread) withObject:nil afterDelay:0.1];

    
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
      [self.medication_Note_TextView resignFirstResponder];
    [_textViewNote resignFirstResponder];
    [_dostextView resignFirstResponder];
    [_agetextView resignFirstResponder];
    [_textViewTitle  resignFirstResponder];
     __scrollView.frame=CGRectMake(0, 0, 320, 368);
 
    if (!iPad) {
        
        _backguandView.frame=CGRectMake(0,0, 320, 405);
        
        if (self.medication_Note_TextView.tag==111) {
            
            self.medication_Note_TextView.tag=222;
            
            if (photoImageVIew) {
                
                if (photoImageVIew.image) {
                    
                    medicationSecondView.frame=CGRectMake(0, 180+140, 320, 252+100);
                    
                    CGSize tmp=_backguandView.contentSize;
                    
                    tmp.height=tmp.height-260;
                    
                    _backguandView.contentSize=tmp;
                    
                    CGPoint bottomOffset = CGPointMake(0, _backguandView.contentSize.height - _backguandView.bounds.size.height);
                    
                    [_backguandView setContentOffset:bottomOffset animated:YES];
                    
                }else{
                    
                    medicationSecondView.frame=CGRectMake(0, 180, 320, 252);
                    
                    CGSize tmp=_backguandView.contentSize;
                    
                    tmp.height=tmp.height-260;
                    
                    _backguandView.contentSize=tmp;
                    
                    CGPoint bottomOffset = CGPointMake(0, _backguandView.contentSize.height - _backguandView.bounds.size.height);
                    
                    [_backguandView setContentOffset:bottomOffset animated:YES];
                }
            }else{
                
                medicationSecondView.frame=CGRectMake(0, 180, 320, 252);
                
                CGSize tmp=_backguandView.contentSize;
                
                tmp.height=tmp.height-260;
                
                _backguandView.contentSize=tmp;
                
                CGPoint bottomOffset = CGPointMake(0, _backguandView.contentSize.height - _backguandView.bounds.size.height);
                
                [_backguandView setContentOffset:bottomOffset animated:YES];
            }

            
        }
        
        
        
    }
    else
    {
          _backguandView.frame=CGRectMake(0,0, 320, 275);
    }
 //   _textViewNote.frame=CGRectMake(62, 121, 228, 226);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)numberDID:(UIButton*)sender
{
    [self leaveEditMode];
    _imageViewTriangle.frame=CGRectMake(34+(sender.tag *(35+6)), 40, 10, 10);
    _numberLabel.frame=CGRectMake(25+(sender.tag *(35+6)), 9, 31, 31);
    
    long tmp=sender.tag+1;
 
    
    
    
    
    
    NSString *numberStr=[[NSString alloc]initWithFormat:@"%ld",tmp];
    _numberLabel.text=numberStr;
//    [ sender setTitle:numberStr forState:UIControlStateNormal];
//    sender.titleLabel.textColor=[UIColor colorWithRed:70/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    NSLog(@"_number= %ld",(long)sender.tag);
    self.turntitleMedicationText=[self.turntitleMedicationArray objectAtIndex:sender.tag];
    self.turndosageMedicationText=[self.turndosageMedicationArray objectAtIndex:sender.tag];
    self.turntimesMedicationText=[self.turntimesMedicationArray objectAtIndex: sender.tag];
    self.turnmedIDText=[self.turnmedID objectAtIndex:sender.tag];
    self.turnMealMedicationText=[self.turnMealMedicationArray objectAtIndex:sender.tag];
    self.turnNoteMedicationText=[self.turnNoteMedicationArray objectAtIndex:sender.tag];
    
    self.imageStr=[self.turnImageStrMedicationArray objectAtIndex:sender.tag];
    if ([self.imageStr isEqualToString:@""]||self.imageStr==nil) {
        imageBase64Str=@"";
        photoView.hidden=YES;
        photoImageVIew.image=nil;
        _backguandView.contentSize=CGSizeMake(320, 180+262+100);
        medicationSecondView.frame=CGRectMake(0, 180, 320, 252+90);
    }
    else
    {
        imageBase64Str=self.imageStr;
        photoView.hidden=NO;
        NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:self.imageStr options:NO];
        UIImage *image=[[UIImage alloc]initWithData:datetmp];
        NSLog(@"image==%@",image);
        photoImageVIew.image=image;
        _backguandView.contentSize=CGSizeMake(320, 180+262+140+100);
        medicationSecondView.frame=CGRectMake(0, 180+140, 320, 252+90);
        
    }
    

    
    if (self.turntitleMedicationArray.count>0) {
        _dostextView.text=self.turntitleMedicationText;
        _agetextView.text=self.turndosageMedicationText;
        self.medication_Note_TextView.text=self.turnNoteMedicationText;
        
        
        
        if ([self.medication_Note_TextView.text isEqualToString:@" "]||[self.medication_Note_TextView.text isEqualToString:@""]||self.medication_Note_TextView.text==nil||self.medication_Note_TextView.text==NULL) {
            labelText_NOte.hidden=NO;
        }
        else
        {
            labelText_NOte.hidden=YES;
        }
        
        
        
        if ([self.turnMealMedicationText isEqualToString:@"B"]) {
            //
            beforeMealButton.image=ridaoOn ;
            afterMealButton .image=ridaoOff;
            naButton.image=ridaoOff;
            
            self.banMEAL=@"B";
            
      

        }
        if ([self.turnMealMedicationText isEqualToString:@"A"]) {
            //
            beforeMealButton.image=ridaoOff ;
            afterMealButton .image=ridaoOn;
            naButton.image=ridaoOff;
                self.banMEAL=@"A";
        }
        if ([self.turnMealMedicationText isEqualToString:@"N"]) {
            //
            beforeMealButton.image=ridaoOff ;
            afterMealButton .image=ridaoOff;
            naButton.image=ridaoOn;
                self.banMEAL=@"N";
        }
        
        
        
        
        
        
        float ff=[self.turntimesMedicationText lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
        NSLog(@"+++++++%f",ff);
        timesArray =[[NSMutableArray alloc]init];
        
        
        
        if (ff>1&&ff<7) {
            //
            NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0,5)];
            [timesArray addObject:string];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
        }
        else if (ff>=7.0&&ff<=13)
        {
            for (int temmm=0; temmm<2; temmm++) {
                NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                [timesArray addObject:string];
                
            }
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            
        }
        else if (ff>=13.0&&ff<=19)
        {
            for (int temmm=0; temmm<3; temmm++)
            {
                NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                [timesArray addObject:string];
                
            }
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
        }
        else if (ff>=19.0&&ff<=25)
        {
            for (int temmm=0; temmm<4; temmm++) {
                NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                [timesArray addObject:string];
                
            }
            
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
        }
        else if (ff>=25.0&&ff<=31)
        {
            for (int temmm=0; temmm<5; temmm++) {
                NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                [timesArray addObject:string];
                
                
            }
            
            [timesArray addObject:@" "];
        }
        else if (ff>=31.0)
        {
            for (int temmm=0; temmm<6; temmm++)
            {
                NSString *string = [self.turntimesMedicationText substringWithRange:NSMakeRange(0+(temmm*6),5)];
                NSLog(@"__%@--",string);
                [timesArray addObject:string];
            }
        }
        else
        {
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
            [timesArray addObject:@" "];
        }
        
        
        
        
    }
    
    timeLabel111.text=[timesArray objectAtIndex:0];
    timeLabel222.text=[timesArray objectAtIndex:1];
    timeLabel333.text=[timesArray objectAtIndex:2];
    timeLabel444.text=[timesArray objectAtIndex:3];
    timeLabel555.text=[timesArray objectAtIndex:4];
    timeLabel666.text=[timesArray objectAtIndex:5];
    
    
    
    
    
    
    
    
    if ([timeLabel111.text isEqualToString:@" "]||[timeLabel111.text isEqualToString:@""]) {
        _timeClickLabel2.text=@"0";
        timeView111.hidden=YES;
        timeView222.hidden=YES;
        timeView333.hidden=YES;
        timeView444.hidden=YES;
        timeView555.hidden=YES;
        timeView666.hidden=YES;
        timeLabel111.text=nil;
        timeLabel222.text=nil;
        timeLabel333.text=Nil;
        timeLabel444.text=Nil;
        timeLabel555.text=Nil;
        timeLabel666.text=Nil;
    }
    else if ([timeLabel222.text isEqualToString:@" "]||[timeLabel222.text isEqualToString:@""]) {
        _timeClickLabel2.text=@"1";
        timeView111.hidden=NO;
        timeView222.hidden=YES;
        timeView333.hidden=YES;
        timeView444.hidden=YES;
        timeView555.hidden=YES;
        timeView666.hidden=YES;
        
        timeLabel222.text=Nil;
        timeLabel333.text=Nil;
        timeLabel444.text=Nil;
        timeLabel555.text=Nil;
        timeLabel666.text=Nil;
    }
    else if ([timeLabel333.text isEqualToString:@" "]||[timeLabel333.text isEqualToString:@""]) {
        _timeClickLabel2.text=@"2";
        timeView111.hidden=NO;
        timeView222.hidden=NO;
        timeView333.hidden=YES;
        timeView444.hidden=YES;
        timeView555.hidden=YES;
        timeView666.hidden=YES;
        
        timeLabel333.text=Nil;
        timeLabel444.text=Nil;
        timeLabel555.text=Nil;
        timeLabel666.text=Nil;
    }
    else if ([timeLabel444.text isEqualToString:@" "]||[timeLabel444.text isEqualToString:@""]) {
        _timeClickLabel2.text=@"3";
        timeView111.hidden=NO;
        timeView222.hidden=NO;
        timeView333.hidden=NO;
        timeView444.hidden=YES;
        timeView555.hidden=YES;
        timeView666.hidden=YES;
        
        timeLabel444.text=Nil;
        timeLabel555.text=Nil;
        timeLabel666.text=Nil;
    }
    else if ([timeLabel555.text isEqualToString:@" "]||[timeLabel555.text isEqualToString:@""]) {
        _timeClickLabel2.text=@"4";
        timeView111.hidden=NO;
        timeView222.hidden=NO;
        timeView333.hidden=NO;
        timeView444.hidden=NO;
        timeView555.hidden=YES;
        timeView666.hidden=YES;
        
        timeLabel555.text=Nil;
        timeLabel666.text=Nil;
    }
    else if ([timeLabel666.text isEqualToString:@" "]||[timeLabel666.text isEqualToString:@""]) {
        _timeClickLabel2.text=@"5";
        timeView111.hidden=NO;
        timeView222.hidden=NO;
        timeView333.hidden=NO;
        timeView444.hidden=NO;
        timeView555.hidden=NO;
        timeView666.hidden=YES;
        timeLabel666.text=Nil;
    }
    else
    {
        _timeClickLabel2.text=@"6";
        timeView111.hidden=NO;
        timeView222.hidden=NO;
        timeView333.hidden=NO;
        timeView444.hidden=NO;
        timeView555.hidden=NO;
        timeView666.hidden=NO;
        
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
-(IBAction)chickDataDateINOthers:(id)sender
{
    backgoundView.hidden=NO;
    dateDateCHickView.hidden=NO;
}

-(IBAction)medicinePhotoClick:(id)sender
{
      [self.medication_Note_TextView resignFirstResponder];
    [_textViewNote resignFirstResponder];
    [_dostextView resignFirstResponder];
    [_agetextView resignFirstResponder];
    [_textViewTitle  resignFirstResponder];
    __scrollView.frame=CGRectMake(0, 0, 320, 368);

    if (!iPad) {
            _backguandView.frame=CGRectMake(0,0, 320, 405);
    }
    else
    {
        _backguandView.frame=CGRectMake(0,0, 320, 275);
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
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    
    
    //允许用户进行编辑
   // imagePickerController.allowsEditing = YES;
   // [imagePickerController setAllowsEditing:YES];
      // imagePickerController.showsCameraControls=YES;
    //设置使用后置摄像头，可以使用前置摄像头
   // imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    //    //设置委托对象
    imagePickerController.delegate=self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    
    
}
-(void)ChoosePhoto
{
    
    _theView.hidden=NO;
    photoChickViewBlackGuandView.hidden=YES;
    //picture
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"sorry, no camera or camera is unavailable.");
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
        NSLog(@"sorry, taking picture is not supported.");
        return;
    }
    //创建图像选取控制器
    imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    
    imagePickerController.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    //    imagePickerController.cameraViewTransform= CGAffineTransformScale(imagePickerController.cameraViewTransform, 0.5, 0.5);
    //允许用户进行编辑
    //imagePickerController.allowsEditing = YES;

  
    //    //设置委托对象
   //    imagePickerController.showsCameraControls=YES;
    imagePickerController.delegate=self;
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
    
}

-(IBAction)deletePhoto:(id)sender
{
    UIAlertView *alertView ;
    NSString * ismHEalth=[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];
    
    if ([ismHEalth isEqualToString:@"HealthReach Calendar"]) {
        alertView= [[UIAlertView alloc] initWithTitle:@"Delete Photo" message:@"This photo will be deleted." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    }
    else
    {
        alertView= [[UIAlertView alloc] initWithTitle:@"刪除照片" message:@"照片將會刪除." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"確定", nil];
    }
    
    
    [alertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        photoView.hidden=YES;
        photoImageVIew.image=nil;
        imageBase64Str=@"";
        _backguandView.contentSize=CGSizeMake(320, 340+10+50+30+10+100);
        medicationSecondView.frame=CGRectMake(0, 180, 320, 230+90);
    }
    else
    {
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
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



    //[self image:edit didFinishSavingWithError:NO contextInfo:NO];
//    UIImageWriteToSavedPhotosAlbum(edit, self,  @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
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
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf

{
    NSLog(@"saved..");
   _theView.hidden=YES;
    photoView.hidden=NO;
    //    CGSize originalSize = CGSizeMake(180.0, 120.0);
    //    CGRect originalFrame;
    //    originalFrame.size=originalSize;
    //    [image drawInRect:originalFrame];
    //大图bigImage
    //定义myImageRect，截图的区域
    
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
    _backguandView.contentSize=CGSizeMake(320, 180+262+140+100);
    medicationSecondView.frame=CGRectMake(0, 180+140, 320, 252+90);
    
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(imageBase64) object:nil];
    [myThread start];
    
    
    
}




-(void)imageBase64
{
    NSData* imageData = UIImageJPEGRepresentation(photoImageVIew.image, 0.1);
    // NSData *imageData=UIImagePNGRepresentation(photoImageVIew.image);
  //  NSLog(@"imageData=====%@",imageData);
    
    NSString *imageDate_String =[imageData base64EncodedStringWithOptions:NO];
    //   NSLog(@"imageURLSucc=%@",imageurlSucc);
    //    NSString *imageDate_String=[[imageurlSucc absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //
  //  NSLog(@"imageDate_String====%@",imageDate_String);
    imageBase64Str=imageDate_String;
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
