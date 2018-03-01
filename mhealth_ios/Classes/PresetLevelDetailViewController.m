//
//  PresetLevelDetailViewController.m
//  mHealth
//
//  Created by Mocona on 9/2/14.
//
//

#import "PresetLevelDetailViewController.h"
#import "TKAlertCenter.h"
#import "Utility.h"

@interface PresetLevelDetailViewController ()

@end

#define  containerPaddingLeft  12.5f // white container padding left
#define  bannerHeight 22.5f

#define  buttonWidth  118.0f
#define  buttonHeight 35.0f

#define  labelPadding  10.0f    // Set your in-app alert level & References
#define  labelPaddingBig 16.0f  // if your padding left
#define  labelSubPadding 5.0f

#define  textFieldHeight  36.0f
#define  textFieldWidth  72.0f
#define  textFieldDivPadding 15.0f //30px

#define divPaddingBig 17.5f
#define divPaddingMid 12.5f

#define banberFontSize 13.0f   //Set your in-app alert level & References
#define ColorFontSizeSmall 16.0f    // Systolic
#define ColorFontSizeBig 21.0f      // > 140
#define normalFontSize 16.0f   // If your & source:....
#define buttonFontSize 17.0f


@implementation PresetLevelDetailViewController
@synthesize title_label,scroll_view;
@synthesize viewType;
@synthesize viewTapGestureRecognizer;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    //self = [super initWithNibName:@"PresetLevelDetailViewController" bundle:nibBundleOrNil];
    
    if (!iPad) {
        self = [super initWithNibName:@"PresetLevelDetailViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"PresetLevelDetailViewController_ipad" bundle:nibBundleOrNil];
    }
    
    viewType = nibNameOrNil;
    NSLog(@"viewType = %@",viewType);
    if (self) {
        // Custom initialization
        self->viewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [viewTapGestureRecognizer setCancelsTouchesInView:FALSE];
    [viewTapGestureRecognizer setDelegate:self];
    [scroll_view addGestureRecognizer:viewTapGestureRecognizer];
    
    alertLevelDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
    
      scroll_view.delaysContentTouches=NO;
    
    if ([viewType isEqualToString:@"BP"]) {
        [self initBPView];
    }else if([viewType isEqualToString:@"BG"]){
        [self initBGView];
    }
    else if ([viewType isEqualToString:@"HR"])
    {
        [self initHRView];
    }
    else
    {
        [self initBMIView];
    }

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

#pragma action
-(IBAction)resetValue:(id)sender{
    if ([viewType isEqualToString:@"BP"]) {
        UITextField *sys = [Utility findTextField:TextFieldViewTag_BP_SYSTOLIC_TAG view:scroll_view];
        UITextField *dia = [Utility findTextField:TextFieldViewTag_BP_DIASTOLIC_TAG view:scroll_view];
        sys.text = @"";
        dia.text = @"";
    }else if([viewType isEqualToString:@"BG"]){
        UITextField *fasting = [Utility findTextField:TextFieldViewTag_BG_FASTING_TAG view:scroll_view];
        UITextField *beforeMeal = [Utility findTextField:TextFieldViewTag_BG_BEFORE_MEAL_TAG view:scroll_view];
        UITextField *afterMeal = [Utility findTextField:TextFieldViewTag_BG_AFTER_MEAL_TAG view:scroll_view];
        fasting.text = @"";
        beforeMeal.text = @"";
        afterMeal.text = @"";
    }
    else if ([viewType isEqualToString:@"HR"])
    {
        UITextField *hrText=[Utility findTextField:TextFieldViewTag_HR____________TAG view:scroll_view];
        hrText.text=@"";
    }
    else if ([viewType isEqualToString:@"BMI"])
    {
        UITextField *bmiText=[Utility findTextField:TextFieldViewTag_BMI___________TAG view:scroll_view];
        bmiText.text=@"";
    }
}

-(IBAction)okValue:(id)sender{
    
    AlertLevel *alertLevelObj = [[AlertLevel alloc] initFromDicionary:alertLevelDic];
    if ([viewType isEqualToString:@"BP"]) {
        UITextField *sys = [Utility findTextField:TextFieldViewTag_BP_SYSTOLIC_TAG view:scroll_view];
        UITextField *dia = [Utility findTextField:TextFieldViewTag_BP_DIASTOLIC_TAG view:scroll_view];
        [alertLevelObj setLsystolic:sys.text];
        [alertLevelObj setHsystolic:sys.text];
        [alertLevelObj setLdiastolic:dia.text];
        [alertLevelObj setHdiastolic:dia.text];
//        NSLog(@"12312312321232132321");1
        
        BOOL check1 = [sys.text isEqualToString:@""]
        && ![dia.text isEqualToString:@""];
        BOOL check2 = ![sys.text isEqualToString:@""]
        && [dia.text isEqualToString:@""];
        if (check1 || check2) {
            NSString *temStr=[Utility getStringByKey:@"alert_input_message"];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:temStr];
            return;
        }
        else{
            if ((![sys.text isEqualToString:@""])
                || (![dia.text isEqualToString:@""])) {
                int check_range1 = [sys.text intValue];
                int check_range2 = [dia.text intValue];
                if (check_range1 < 20 || check_range1 > 500) {
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"alert_systolic_message"]];
                    return;
                }
                else if (check_range2 < 20 || check_range2 > 300) {
                   [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"alert_diastolic_message"]];
                   return;
                }
                
            }
        }
        [syncAlertLevel sendResult:alertLevelObj setUpdateType:viewType];
    }else if([viewType isEqualToString:@"BG"]){
        UITextField *fasting = [Utility findTextField:TextFieldViewTag_BG_FASTING_TAG view:scroll_view];
        UITextField *beforeMeal = [Utility findTextField:TextFieldViewTag_BG_BEFORE_MEAL_TAG view:scroll_view];
        UITextField *afterMeal = [Utility findTextField:TextFieldViewTag_BG_AFTER_MEAL_TAG view:scroll_view];
        [alertLevelObj setLbg:fasting.text];
        [alertLevelObj setHbg:fasting.text];
        [alertLevelObj setLbg_b:beforeMeal.text];
        [alertLevelObj setHbg_b:beforeMeal.text];
        [alertLevelObj setLbg_a:afterMeal.text];
        [alertLevelObj setHbg_a:afterMeal.text];
        
        
        
  
        
        int check_range1 = [fasting.text floatValue];
        int check_range2 = [beforeMeal.text floatValue];
        int check_range3 = [afterMeal.text floatValue];
        if(![fasting.text isEqualToString:@""]){
            if (check_range1 < 3.9 || check_range1 > 30) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"alert_bg_message"]];
                return;
            }

        }
        if(![beforeMeal.text isEqualToString:@""]){
            if (check_range2 < 3.9 || check_range2 > 30) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"alert_bg_message"]];
                return;
            }
        }
                
        if(![afterMeal.text isEqualToString:@""]){
            if (check_range3 < 3.9 || check_range3 > 30) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"alert_bg_message"]];
                return;
            }
        }
        

        
        
        
        
        
        
        [syncAlertLevel sendResult:alertLevelObj setUpdateType:viewType];
    }
    else if ([viewType isEqualToString:@"HR"])
    {
        UITextField *hrStr = [Utility findTextField:TextFieldViewTag_HR____________TAG view:scroll_view];
        [alertLevelObj setBp_hheartrate:hrStr.text];
        [alertLevelObj setBp_lheartrate:hrStr.text];
        [alertLevelObj setEcg_hheartrate:hrStr.text];
        [alertLevelObj setEcg_lheartrate:hrStr.text];
        
        
        
        
        
        if(![hrStr.text isEqualToString:@""]){
            int check_range1 = [hrStr.text intValue];
            if (check_range1 < 20 || check_range1 > 300) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"alert_heartrate_message"]];
                return;
            }
        }
        
        
        
        
        
        [syncAlertLevel sendResult:alertLevelObj setUpdateType:viewType];
    }
    else if ([viewType isEqualToString:@"BMI"])
    {
        NSLog(@"_________________________");
        UITextField *hrStr = [Utility findTextField:TextFieldViewTag_BMI___________TAG view:scroll_view];
        [alertLevelObj setHbmi:hrStr.text];
        
        
        if(![hrStr.text isEqualToString:@""]){
            float check_range1 = [hrStr.text floatValue];
            if (check_range1 < 5 || check_range1 > 70) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"alert_weight_message"]];
                return;
            }
        }

        
        
        
        [syncAlertLevel sendResult:alertLevelObj setUpdateType:viewType];
    }
    [super back];
    
}

-(IBAction)hideKeyboard:(id)sender{
    [Utility findAndResignFirstResponder:scroll_view];
}


#pragma custom view here
-(void) initBPView{
    
    NSLog(@"------start to initBPView-------");
    //set bar title
    [title_label setText:[Utility getStringByKey:@"Blood Pressure"]];
    
    for (UIView *subView in [scroll_view subviews]) {
        [subView removeFromSuperview];
    }
    
    CGFloat totalHeight = 0.0f;
    CGFloat containerWidth = scroll_view.frame.size.width - 2*containerPaddingLeft;
    
    //init container view
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor]; // set background color white
    
    // Set in-app level label here
    UIColor *bannerColor = [self BPBannerColor];
    UIView *bannerTop = [self setUpBannerView:[Utility getStringByKey:@"label_set_in_app_level"] setBannerColor:bannerColor setWidth:containerWidth setPaddingTop:totalHeight];
   
    
    totalHeight += (bannerHeight + divPaddingBig);
    
    // Set systolic textfield here
    UIView *textFieldView1 = [self setUpTextFieldView:[Utility getStringByKey:@"label_systolic_equal"] setUnitText:[Utility getStringByKey:@"label_mmhg"] setLabelColor:bannerColor setWidth:containerWidth setPaddingTop:totalHeight setTextFieldTag:TextFieldViewTag_BP_SYSTOLIC_TAG];
    
    totalHeight += (textFieldHeight + textFieldDivPadding);
    
    // Set diastolic textfield here
    UIView *textFieldView2 = [self setUpTextFieldView:[Utility getStringByKey:@"label_diastolic_equal"] setUnitText:[Utility getStringByKey:@"label_mmhg"] setLabelColor:bannerColor setWidth:containerWidth setPaddingTop:totalHeight setTextFieldTag:TextFieldViewTag_BP_DIASTOLIC_TAG];
    
    
    totalHeight += ( textFieldHeight+ divPaddingBig + divPaddingMid);
    
    //set buttons here
    UIView *buttonsView = [self setUpButtons:totalHeight setWidth:containerWidth];
    
    
    totalHeight += ( buttonHeight+ divPaddingBig + divPaddingMid);
    
    //Set Advisory(References) here
    UIView *bannerAdvisory = [self setUpBannerView:[Utility getStringByKey:@"label_advisory"] setBannerColor:bannerColor setWidth:containerWidth setPaddingTop:totalHeight];
    totalHeight += bannerHeight;
    
    UIView *referenceLow = [self setUpReferencesByType:@"low" setWidth:containerWidth setPaddingTop:totalHeight];
    totalHeight += referenceLow.frame.size.height;
    
    UIView *divLineView = [self DivLineView:totalHeight setWidth:containerWidth];
    totalHeight += divLineView.frame.size.height;
    
    UIView *referenceHigh = [self setUpReferencesByType:@"high" setWidth:containerWidth setPaddingTop:totalHeight];
    totalHeight += referenceHigh.frame.size.height;
    
    
    CGFloat scrollViewHegiht = divPaddingBig;
    // add all views to container
    [containerView setFrame: CGRectMake(containerPaddingLeft, scrollViewHegiht, containerWidth, totalHeight)];
    [containerView addSubview:bannerTop];
    [containerView addSubview:textFieldView1];
    [containerView addSubview:textFieldView2];
    [containerView addSubview:buttonsView];
    [containerView addSubview:bannerAdvisory];
    [containerView addSubview:referenceLow];
    [containerView addSubview:divLineView];
    [containerView addSubview:referenceHigh];
    
    [scroll_view addSubview:containerView];
    
    scrollViewHegiht += (totalHeight + divPaddingBig);
    
    UIView *sourceView = [self SourceView:scrollViewHegiht setWidth:containerWidth];
    
    [scroll_view addSubview:sourceView];
    
    scrollViewHegiht += sourceView.frame.size.height + 2*divPaddingBig;
    
    scroll_view.contentSize = CGSizeMake(self.view.bounds.size.width, scrollViewHegiht);
 
}


-(void) initBGView{
    NSLog(@"------start to initBGView-------");
    //set bar title
    [title_label setText:[Utility getStringByKey:@"Blood Glucose"]];
    
    for (UIView *subView in [scroll_view subviews]) {
        [subView removeFromSuperview];
    }
    
    CGFloat totalHeight = 0.0f;
    CGFloat containerWidth = scroll_view.frame.size.width - 2*containerPaddingLeft;
    
    //init container view
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    
    
    
        
    // Set in-app level label here
    UIColor *bannerColor = [self BGBannerColor];
    UIView *bannerTop = [self setUpBannerView:[Utility getStringByKey:@"label_set_in_app_level"] setBannerColor:bannerColor setWidth:containerWidth  setPaddingTop:totalHeight];
    
    
    totalHeight += (bannerHeight + divPaddingBig);
    
    // Set fasting textfield here
    UIView *textFieldView1 = [self setUpTextFieldView:[Utility getStringByKey:@"label_fasting"] setUnitText:[Utility getStringByKey:@"label_mmol"] setLabelColor:bannerColor setWidth:containerWidth  setPaddingTop:totalHeight setTextFieldTag:TextFieldViewTag_BG_FASTING_TAG];
    
    totalHeight += (textFieldHeight + textFieldDivPadding);
    
    // Set before meal textfield here
    UIView *textFieldView2 = [self setUpTextFieldView:[Utility getStringByKey:@"label_before_meal"] setUnitText:[Utility getStringByKey:@"label_mmol"] setLabelColor:bannerColor setWidth:containerWidth  setPaddingTop:totalHeight setTextFieldTag:TextFieldViewTag_BG_BEFORE_MEAL_TAG];
    
    totalHeight += (textFieldHeight + textFieldDivPadding);
    
    // Set before meal textfield here
    UIView *textFieldView3 = [self setUpTextFieldView:[Utility getStringByKey:@"label_after_meal"] setUnitText:[Utility getStringByKey:@"label_mmol"] setLabelColor:bannerColor setWidth:containerWidth  setPaddingTop:totalHeight setTextFieldTag:TextFieldViewTag_BG_AFTER_MEAL_TAG];
    
    
    totalHeight += ( textFieldHeight+ divPaddingBig + divPaddingMid);
    
    //set buttons here
    UIView *buttonsView = [self setUpButtons:totalHeight setWidth:containerWidth ];
    
    
    totalHeight += ( buttonHeight+ divPaddingBig + divPaddingMid);
    
    //Set Advisory(References) here
    UIView *bannerAdvisory = [self setUpBannerView:[Utility getStringByKey:@"label_advisory"] setBannerColor:bannerColor setWidth:containerWidth  setPaddingTop:totalHeight];
    totalHeight += bannerHeight;
    
    UIView *referenceLow = [self setUpReferencesByType:@"low" setWidth:containerWidth setPaddingTop:totalHeight];
    totalHeight += referenceLow.frame.size.height;
    
    
    CGFloat scrollViewHegiht = divPaddingBig;
    // add all views to container
    [containerView setFrame: CGRectMake(containerPaddingLeft, scrollViewHegiht, containerWidth, totalHeight)];
    [containerView addSubview:bannerTop];
    [containerView addSubview:textFieldView1];
    [containerView addSubview:textFieldView2];
    [containerView addSubview:textFieldView3];
    [containerView addSubview:buttonsView];
    [containerView addSubview:bannerAdvisory];
    [containerView addSubview:referenceLow];
    
    [scroll_view addSubview:containerView];
    
    scrollViewHegiht += (totalHeight + divPaddingBig);
    
    UIView *sourceView = [self SourceView:scrollViewHegiht setWidth:containerWidth];
    
    [scroll_view addSubview:sourceView];
    
    scrollViewHegiht += sourceView.frame.size.height + 2*divPaddingBig;
    
    scroll_view.contentSize = CGSizeMake(self.view.bounds.size.width, scrollViewHegiht);

}
-(void)initHRView
{
    NSLog(@"---Start to initHRView-----");
    [title_label setText:[Utility getStringByKey:@"heart_rate"]];
    for (UIView *subView in [scroll_view subviews]) {
        [subView removeFromSuperview];
    }
    
    

    
    //init container view
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    UIColor*bannerColor=[self HRBannerColor];
    
    UIView*bannerTop=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320-25, 45/2)];
    bannerTop.backgroundColor=bannerColor;
    
    UILabel * _bannerLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 320-25, 45/2)];
    _bannerLabel.backgroundColor=[UIColor clearColor];
    _bannerLabel.textAlignment=NSTextAlignmentLeft;
    _bannerLabel.text=[Utility getStringByKey:@"Set your in-app alert level"];
    _bannerLabel.font=[UIFont fontWithName:font65 size:13];
    _bannerLabel.textColor=[UIColor whiteColor];
    [bannerTop addSubview:_bannerLabel];
    
    [containerView addSubview:bannerTop];
    
    UILabel *_maxTIT=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35)/2, 25, textFieldHeight)];
    _maxTIT.text=@">";
    _maxTIT.textColor=bannerColor;
    _maxTIT.textAlignment=NSTextAlignmentLeft;
    _maxTIT.font=[UIFont fontWithName:font65 size:21];
    _maxTIT.backgroundColor=[UIColor clearColor];
    [containerView addSubview:_maxTIT];
    
    
    UITextField*_textFeild=[[UITextField alloc]initWithFrame:CGRectMake(25/2+25, (45+35)/2, textFieldWidth, textFieldHeight)];
    _textFeild.font=[UIFont fontWithName:font65 size:21];
    _textFeild.borderStyle = UITextBorderStyleLine;
    _textFeild.layer.borderColor = [UIColor grayColor].CGColor;
    _textFeild.layer.borderWidth = 0.5f;
    _textFeild.textColor=bannerColor;
    _textFeild.tag=TextFieldViewTag_HR____________TAG;
    _textFeild.keyboardType = UIKeyboardTypeNumberPad;
    _textFeild.text = [alertLevelDic objectForKey:@"bp_lheartrate"];
    [containerView addSubview:_textFeild];

    UILabel *timesPer=[[UILabel alloc]initWithFrame:CGRectMake(25/2+25+10+textFieldWidth, (45+35)/2,150 , textFieldHeight)];
    timesPer.textColor=bannerColor;
    timesPer.backgroundColor=[UIColor clearColor];
  
  
        timesPer.text=[Utility getStringByKey:@"times per minute"];
   
    timesPer.textAlignment=NSTextAlignmentLeft;
    timesPer.font=[UIFont fontWithName:font65 size:16];
    [containerView addSubview:timesPer];
    
    //button
    UIButton *resetButton=[UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame=CGRectMake(20, (45+35+65)/2+textFieldHeight,  buttonWidth, buttonHeight);
    [resetButton setBackgroundImage:[UIImage imageNamed:@"00_btn_red_p1"] forState:UIControlStateNormal];
    UILabel *restLabel = [UILabel new];
    restLabel.frame = CGRectMake(0, 2, buttonWidth, buttonHeight);
    restLabel.backgroundColor = [UIColor clearColor];
    restLabel.font = [UIFont fontWithName:font65 size:18];
    restLabel.textColor = [UIColor whiteColor];
    restLabel.textAlignment = NSTextAlignmentCenter;
    restLabel.text = [Utility getStringByKey:@"btn_reset"];
    [resetButton addSubview:restLabel];
    [resetButton addTarget:self action:@selector(resetValue:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:resetButton];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = CGRectMake(20+buttonWidth+20,(45+35+65)/2+textFieldHeight, buttonWidth, buttonHeight);
    
    [okButton setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p1"] forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okValue:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *doneLabel = [UILabel new];
    doneLabel.frame = CGRectMake(0, 2, buttonWidth, buttonHeight);
    doneLabel.backgroundColor = [UIColor clearColor];
    doneLabel.textColor = [UIColor whiteColor];
    doneLabel.textAlignment = NSTextAlignmentCenter;
    doneLabel.font =[UIFont fontWithName:font65 size:18];
    doneLabel.text = [Utility getStringByKey:@"Done"];
    [okButton addSubview:doneLabel];
    [containerView addSubview:okButton];
    
   //AdvisoryView
    UIColor * _4cColor=[self ReferencesLabelColor];
    UIView *_advisary=[[UIView alloc]initWithFrame:CGRectMake(0,(45+35+65+65)/2+textFieldHeight+buttonHeight, 320-25, 45/2)];
    _advisary.backgroundColor=bannerColor;
    UILabel *_advisorLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 280, 45/2)];
    _advisorLabel.backgroundColor=[UIColor clearColor];
    _advisorLabel.textAlignment=NSTextAlignmentLeft;
    _advisorLabel.textColor=[UIColor whiteColor];
    [_advisorLabel setText:[Utility getStringByKey:@"Advisory"]];
    _advisorLabel.font=[UIFont fontWithName:font65 size:13];
    
    [_advisary addSubview:_advisorLabel];
    [containerView addSubview:_advisary];
    
    UILabel *_ifyourHeartLabel=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight, 320-25-25, 25)];
    _ifyourHeartLabel.backgroundColor=[UIColor clearColor];
    _ifyourHeartLabel.textColor=_4cColor;
    _ifyourHeartLabel.textAlignment=NSTextAlignmentLeft;
    _ifyourHeartLabel.font=[UIFont fontWithName:font55 size:16];

    
        _ifyourHeartLabel.text=[Utility getStringByKey:@"If your heart rate is"];
    
    [containerView addSubview:_ifyourHeartLabel];
    
    UILabel*_min60Label=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight+30, 60, 25)];
    _min60Label.text=@"<  60";
    _min60Label.textAlignment=NSTextAlignmentLeft;
    _min60Label.textColor=bannerColor;
    _min60Label.font=[UIFont fontWithName:font65 size:21];
    _min60Label.backgroundColor=[UIColor clearColor];
    [containerView addSubview:_min60Label];
    
    UILabel *orLabel=[[UILabel alloc]initWithFrame:CGRectMake(25/2+60,  (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight+30, 100, 25)];
    orLabel.backgroundColor=[UIColor clearColor];
    orLabel.textColor=bannerColor;
    orLabel.textAlignment=NSTextAlignmentLeft;
    orLabel.font=[UIFont fontWithName:font65 size:16];

    
        orLabel.text=[Utility getStringByKey:@"or"];
    
    [containerView addSubview:orLabel];
    
    
    
    
    
    
    
    
    UILabel*_max100Label=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight+30+30, 60, 25)];
    _max100Label.text=@"> 100";
    _max100Label.textAlignment=NSTextAlignmentLeft;
    _max100Label.textColor=bannerColor;
    _max100Label.font=[UIFont fontWithName:font65 size:21];
    _max100Label.backgroundColor=[UIColor clearColor];
    [containerView addSubview:_max100Label];
    
    
    UILabel *tPMLabel=[[UILabel alloc]initWithFrame:CGRectMake(25/2+60, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight+30+30,200, 25)];
    tPMLabel.backgroundColor=[UIColor clearColor];
    tPMLabel.textColor=bannerColor;
    tPMLabel.textAlignment=NSTextAlignmentLeft;
    tPMLabel.font=[UIFont fontWithName:font65 size:16];

    
        tPMLabel.text=[Utility getStringByKey:@"times per minute"];
    
    [containerView addSubview:tPMLabel];
    
    UILabel *ySCSAD=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35+65+65+45+25+35)/2+textFieldHeight+buttonHeight+30+30+10,320-35, 50)];
    ySCSAD.backgroundColor=[UIColor clearColor];
    ySCSAD.textColor=_4cColor;
    ySCSAD.textAlignment=NSTextAlignmentLeft;
    ySCSAD.font=[UIFont fontWithName:font65 size:16];
    

    
        ySCSAD.text=[Utility getStringByKey:@"You should consider seeing a clinician."];
    ySCSAD.numberOfLines=2;
    
    [containerView addSubview:ySCSAD];
    
    containerView.frame=CGRectMake(25/2, 30/2, 320-25,  (45+35+65+65+45+25+35+35)/2+textFieldHeight+buttonHeight+30+30+50);
    [scroll_view addSubview:containerView];
    
    UILabel * sourceLabel=[[UILabel alloc]initWithFrame:CGRectMake(25/2, 30/2+ (45+35+65+65+45+25+35+35)/2+textFieldHeight+buttonHeight+30+30+50+20, 320-25, 25)];
    sourceLabel.backgroundColor=[UIColor clearColor];
    sourceLabel.textAlignment=NSTextAlignmentLeft;
    sourceLabel.textColor=[self SourceLabelColor];
    sourceLabel.font=[UIFont fontWithName:font55 size:16];

    
        sourceLabel.text=[Utility getStringByKey:@"Source:"];
    
    [scroll_view addSubview:sourceLabel];
    
    
    UILabel * hongKong=[[UILabel alloc]initWithFrame:CGRectMake(25/2, 30/2+ (45+35+65+65+45+25+35+35)/2+textFieldHeight+buttonHeight+30+30+50+20+15, 320-25, 100)];
    hongKong.backgroundColor=[UIColor clearColor];
    hongKong.textAlignment=NSTextAlignmentLeft;
    hongKong.textColor=[self SourceLabelColor];
    hongKong.font=[UIFont fontWithName:font55 size:16];

    
        hongKong.text=[Utility getStringByKey:@"Hong Kong Hospital Authority"];
    
    [scroll_view addSubview:hongKong];
      scroll_view.contentSize=CGSizeMake(320, 600);//设置总画布的大小
}
-(void)initBMIView
{
    NSLog(@"----Start to Body Mass Index------");
    [title_label setText:[Utility getStringByKey:@"body_mass"]];
    for (UIView *subView in [scroll_view subviews]) {
        [subView removeFromSuperview];
    }
    
    NSString*theTitlelabelStr=title_label.text;
    
    //init container view
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    UIColor*bannerColor=[self BMIBannerColor];
    
    UIView*bannerTop=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320-25, 45/2)];
    bannerTop.backgroundColor=bannerColor;
    
    UILabel * _bannerLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 320-25, 45/2)];
    _bannerLabel.backgroundColor=[UIColor clearColor];
    _bannerLabel.textAlignment=NSTextAlignmentLeft;
    _bannerLabel.text=[Utility getStringByKey:@"Set your in-app alert level"];
    _bannerLabel.font=[UIFont fontWithName:font65 size:13];
    _bannerLabel.textColor=[UIColor whiteColor];
    [bannerTop addSubview:_bannerLabel];
    
    [containerView addSubview:bannerTop];
    
    
    UILabel *_bmiName=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35)/2, 50, textFieldHeight)];

    
           _bmiName.text=@"BMI =";
    
    
    _bmiName.textColor=bannerColor;
    _bmiName.textAlignment=NSTextAlignmentLeft;
    _bmiName.font=[UIFont fontWithName:font65 size:16];
    _bmiName.backgroundColor=[UIColor clearColor];
    [containerView addSubview:_bmiName];
    
    
    UITextField*_textFeild=[[UITextField alloc]initWithFrame:CGRectMake(25/2+50, (45+35)/2, textFieldWidth, textFieldHeight)];
    _textFeild.font=[UIFont fontWithName:font65 size:21];
    _textFeild.borderStyle = UITextBorderStyleLine;
    _textFeild.layer.borderColor = [UIColor grayColor].CGColor;
    _textFeild.layer.borderWidth = 0.5f;
    _textFeild.textColor=bannerColor;
    _textFeild.tag=TextFieldViewTag_BMI___________TAG;
    _textFeild.keyboardType = UIKeyboardTypeDecimalPad;

    _textFeild.text = [alertLevelDic objectForKey:@"hbmi"];
    [containerView addSubview:_textFeild];
    
    
    //button
    UIButton *resetButton=[UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame=CGRectMake(20, (45+35+65)/2+textFieldHeight,  buttonWidth, buttonHeight);
    [resetButton setBackgroundImage:[UIImage imageNamed:@"00_btn_red_p1"] forState:UIControlStateNormal];
    UILabel *restLabel = [UILabel new];
    restLabel.frame = CGRectMake(0, 2, buttonWidth, buttonHeight);
    restLabel.backgroundColor = [UIColor clearColor];
    restLabel.font = [UIFont fontWithName:font65 size:18];
    restLabel.textColor = [UIColor whiteColor];
    restLabel.textAlignment = NSTextAlignmentCenter;
    restLabel.text = [Utility getStringByKey:@"btn_reset"];
    [resetButton addSubview:restLabel];
    [resetButton addTarget:self action:@selector(resetValue:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:resetButton];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = CGRectMake(20+buttonWidth+20,(45+35+65)/2+textFieldHeight, buttonWidth, buttonHeight);
    
    [okButton setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p1"] forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okValue:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *doneLabel = [UILabel new];
    doneLabel.frame = CGRectMake(0, 2, buttonWidth, buttonHeight);
    doneLabel.backgroundColor = [UIColor clearColor];
    doneLabel.textColor = [UIColor whiteColor];
    doneLabel.textAlignment = NSTextAlignmentCenter;
    doneLabel.font =[UIFont fontWithName:font65 size:18];
    doneLabel.text = [Utility getStringByKey:@"Done"];
    [okButton addSubview:doneLabel];
    [containerView addSubview:okButton];
    
    //AdvisoryView
    UIColor * _4cColor=[self ReferencesLabelColor];
    UIView *_advisary=[[UIView alloc]initWithFrame:CGRectMake(0,(45+35+65+65)/2+textFieldHeight+buttonHeight, 320-25, 45/2)];
    _advisary.backgroundColor=bannerColor;
    UILabel *_advisorLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 280, 45/2)];
    _advisorLabel.backgroundColor=[UIColor clearColor];
    _advisorLabel.textAlignment=NSTextAlignmentLeft;
    _advisorLabel.textColor=[UIColor whiteColor];
    [_advisorLabel setText:[Utility getStringByKey:@"Advisory"]];
    _advisorLabel.font=[UIFont fontWithName:font65 size:13];
    
    [_advisary addSubview:_advisorLabel];
    [containerView addSubview:_advisary];
    
    UILabel *forAsianLabel=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight, (320-25-25)/2, 25)];
    forAsianLabel.backgroundColor=[UIColor clearColor];
    forAsianLabel.textColor=_4cColor;
    forAsianLabel.textAlignment=NSTextAlignmentLeft;
    forAsianLabel.font=[UIFont fontWithName:font55 size:16];

    {
        forAsianLabel.text=[Utility getStringByKey:@"For Asian"];
    }
    [containerView addSubview:forAsianLabel];
    
    UILabel *forNON=[[UILabel alloc]initWithFrame:CGRectMake((320-25-25)/2, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight, (320-25-25)/2, 25)];
    forNON.backgroundColor=[UIColor clearColor];
    forNON.textColor=_4cColor;
    forNON.textAlignment=NSTextAlignmentLeft;
    forNON.font=[UIFont fontWithName:font55 size:16];

    {
        forNON.text=[Utility getStringByKey:@"For non-Asian"];
    }
    [containerView addSubview:forNON];
    
    
    
    UILabel*_min60Label=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight+30,(320-25-25)/2, 25)];
    _min60Label.text=@"< 22.9";
    _min60Label.textAlignment=NSTextAlignmentLeft;
    _min60Label.textColor=bannerColor;
    _min60Label.font=[UIFont fontWithName:font65 size:21];
    _min60Label.backgroundColor=[UIColor clearColor];
    [containerView addSubview:_min60Label];
    
    UILabel *orLabel=[[UILabel alloc]initWithFrame:CGRectMake(25/2+60,  (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight+30,(320-25-25)/2-25/2-40, 25)];
    orLabel.backgroundColor=[UIColor clearColor];
    orLabel.textColor=bannerColor;
    orLabel.textAlignment=NSTextAlignmentLeft;
    orLabel.font=[UIFont fontWithName:font65 size:16];

    
        orLabel.text=@"kg/m2";
    
    [containerView addSubview:orLabel];
    
    
    
    
    
    
    
    
    UILabel*_max100Label=[[UILabel alloc]initWithFrame:CGRectMake((320-25-25)/2, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight+30,(320-25-25)/2, 25)];
    _max100Label.text=@"< 24.9";
    _max100Label.textAlignment=NSTextAlignmentLeft;
    _max100Label.textColor=bannerColor;
    _max100Label.font=[UIFont fontWithName:font65 size:21];
    _max100Label.backgroundColor=[UIColor clearColor];
    [containerView addSubview:_max100Label];
    
    
    UILabel *tPMLabel=[[UILabel alloc]initWithFrame:CGRectMake((320-25-25)/2+60, (45+35+65+65+45+25)/2+textFieldHeight+buttonHeight+30,(320-25-25)/2-60, 25)];
    tPMLabel.backgroundColor=[UIColor clearColor];

   tPMLabel.textColor=bannerColor;
    tPMLabel.textAlignment=NSTextAlignmentLeft;
    tPMLabel.font=[UIFont fontWithName:font65 size:16];
    tPMLabel.text=@"kg/m2";
    
    {
    //    tPMLabel.text=@"kg/㎡";
    }
    [containerView addSubview:tPMLabel];
    
    UILabel *ySCSAD=[[UILabel alloc]initWithFrame:CGRectMake(25/2, (45+35+65+65+45+25+35)/2+textFieldHeight+buttonHeight+50,320-25-25, 100)];
    ySCSAD.backgroundColor=[UIColor clearColor];
    ySCSAD.textColor=_4cColor;
    ySCSAD.textAlignment=NSTextAlignmentLeft;
    ySCSAD.font=[UIFont fontWithName:font65 size:16];
    

   
        ySCSAD.text=[Utility getStringByKey:@"If you have exceeded the normal Body Mass Index,Please consider seeing a dietitian or doctor for inquines"];
         ySCSAD.numberOfLines=4;
    
    [containerView addSubview:ySCSAD];
    
    containerView.frame=CGRectMake(25/2, 30/2, 320-25,  (45+35+65+65+45+25+35+35+35)/2+textFieldHeight+buttonHeight+120);
    [scroll_view addSubview:containerView];
    
    UILabel * sourceLabel=[[UILabel alloc]initWithFrame:CGRectMake(25/2, 30/2+ (45+35+65+65+45+25+35+35)/2+textFieldHeight+buttonHeight+120+40, 320-25, 25)];
    sourceLabel.backgroundColor=[UIColor clearColor];
    sourceLabel.textAlignment=NSTextAlignmentLeft;
    sourceLabel.textColor=[self SourceLabelColor];
    sourceLabel.font=[UIFont fontWithName:font55 size:16];

    {
        sourceLabel.text=[Utility getStringByKey:@"Source:"];
    }
    [scroll_view addSubview:sourceLabel];
    
    
    UILabel * hongKong=[[UILabel alloc]initWithFrame:CGRectMake(25/2, 30/2+ (45+35+65+65+45+25+35+35)/2+textFieldHeight+buttonHeight+120+40+20, 320-25, 100)];
    hongKong.backgroundColor=[UIColor clearColor];
    hongKong.textAlignment=NSTextAlignmentLeft;
    hongKong.textColor=[self SourceLabelColor];
    hongKong.font=[UIFont fontWithName:font55 size:16];
    if ([theTitlelabelStr isEqualToString:@"Body Mass Index(BMI)"]) {
        hongKong.text=@"Hong Kong Hospital Authority, American Heart Association,American Diabetes Association,World Health Organization and Dr.Albert Leung";
        hongKong.numberOfLines=5;
    }
    else
    {
        hongKong.text=@"香港醫院管理局及美國心臟協會";
    }
    [scroll_view addSubview:hongKong];
    scroll_view.contentSize=CGSizeMake(320, 600);//设置总画布的大小


    
}


- (UIView *) setUpBannerView:(NSString*)_labelText setBannerColor:(UIColor *)_bgColor setWidth:(CGFloat)_bannerWidth setPaddingTop:(CGFloat)_paddingTop
{

    UIView *banner = [UIView new];
    banner.frame = CGRectMake(0, _paddingTop, _bannerWidth, bannerHeight);
    banner.backgroundColor = _bgColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(labelPadding, 2, _bannerWidth - 2*labelPadding, bannerHeight)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = _labelText;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:font65 size:banberFontSize];
    [banner addSubview:label];
    return banner;

}



- (UIView *) setUpTextFieldView:(NSString*)_labelText setUnitText:(NSString *)_unitText setLabelColor:(UIColor *)_lColor setWidth:(CGFloat)_bannerWidth setPaddingTop:(CGFloat)_paddingTop setTextFieldTag:(int)_tag{
    
    UIView *subView =  [UIView new];
    subView.frame = CGRectMake(0, _paddingTop, _bannerWidth, textFieldHeight);
    subView.backgroundColor = [UIColor clearColor];


    CGFloat subLabelPadding = labelPaddingBig;
    CGFloat labelWidth = _bannerWidth - 2*subLabelPadding;
    UIFont  *labelFont = [UIFont fontWithName:font65 size:ColorFontSizeSmall];
    UIFont  *textFieldFont = [UIFont fontWithName:font65 size:ColorFontSizeBig];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(subLabelPadding, 0, labelWidth, textFieldHeight);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = _lColor;
    label.text = _labelText;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = labelFont;
    [subView addSubview:label];
    subLabelPadding = labelWidth/2;
    
    UITextField *inputTextField = [UITextField new];
    inputTextField.frame = CGRectMake(subLabelPadding, 0, textFieldWidth, textFieldHeight);
    inputTextField.borderStyle = UITextBorderStyleLine;
    inputTextField.layer.borderColor = [UIColor grayColor].CGColor;
    inputTextField.layer.borderWidth = 0.5f;
    inputTextField.font = textFieldFont;
    inputTextField.tag = _tag;
    inputTextField.textColor = _lColor;
    
    switch (_tag) {
        case TextFieldViewTag_BP_SYSTOLIC_TAG:
            inputTextField.keyboardType = UIKeyboardTypeNumberPad;
            inputTextField.text = [alertLevelDic objectForKey:@"hsystolic"];
            break;
        case TextFieldViewTag_BP_DIASTOLIC_TAG:
            inputTextField.keyboardType = UIKeyboardTypeNumberPad;
            inputTextField.text = [alertLevelDic objectForKey:@"hdiastolic"];
            break;
        case TextFieldViewTag_BG_FASTING_TAG:
            inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
            inputTextField.text = [alertLevelDic objectForKey:@"hbg"];
            break;
        case TextFieldViewTag_BG_BEFORE_MEAL_TAG:
            inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
            inputTextField.text = [alertLevelDic objectForKey:@"hbg_b"];
            break;
        case TextFieldViewTag_BG_AFTER_MEAL_TAG:
            inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
            inputTextField.text = [alertLevelDic objectForKey:@"hbg_a"];
            break;
        default:
            break;
    }
    
    inputTextField.delegate = self;
    [subView addSubview:inputTextField];

    
    subLabelPadding += textFieldWidth;
    
    UILabel *unitLabel = [UILabel new];
    unitLabel.frame = CGRectMake(subLabelPadding, 0, _bannerWidth - subLabelPadding - labelPaddingBig, textFieldHeight);
    unitLabel.backgroundColor = [UIColor clearColor];
    unitLabel.textColor = _lColor;
    unitLabel.text = _unitText;
    unitLabel.textAlignment = NSTextAlignmentLeft;
    unitLabel.font = labelFont;
    [subView addSubview:unitLabel];
    
    return subView;
    
}

-(UIView *)setUpButtons:(CGFloat)_paddingTop setWidth:(CGFloat)_bannerWidth {
    UIView *buttonsView = [UIView new];
    buttonsView.frame  =  CGRectMake(0, _paddingTop, _bannerWidth, buttonHeight);
    CGFloat divPaddingForButtons = 17.5f; //35px
    UIFont *buttonFont = [UIFont fontWithName:font65 size:buttonFontSize];
    
    CGFloat subPaddingLeft = ( _bannerWidth - 2*buttonWidth - divPaddingForButtons )/2 ;
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(subPaddingLeft, 0, buttonWidth, buttonHeight);
    [resetButton setBackgroundImage:[UIImage imageNamed:@"00_btn_red_p1"] forState:UIControlStateNormal];
    UILabel *restLabel = [UILabel new];
    restLabel.frame = CGRectMake(0, 2, buttonWidth, buttonHeight);
    restLabel.backgroundColor = [UIColor clearColor];
    restLabel.font = buttonFont;
    restLabel.textColor = [UIColor whiteColor];
    restLabel.textAlignment = NSTextAlignmentCenter;
    restLabel.text = [Utility getStringByKey:@"btn_reset"];
    [resetButton addSubview:restLabel];
    //[resetButton setTitle: [Utility getStringByKey:@"btn_reset"] forState:UIControlStateNormal];
    //resetButton.titleLabel.font = buttonFont;
    [resetButton addTarget:self action:@selector(resetValue:) forControlEvents:UIControlEventTouchUpInside];
    
    
    subPaddingLeft += (divPaddingForButtons + buttonWidth);
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = CGRectMake(subPaddingLeft, 0, buttonWidth, buttonHeight);
    [okButton setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p1"] forState:UIControlStateNormal];
    //[okButton setTitle: [Utility getStringByKey:@"Done"] forState:UIControlStateNormal ];
    [okButton addTarget:self action:@selector(okValue:) forControlEvents:UIControlEventTouchUpInside];
    //okButton.titleLabel.font = buttonFont;
    UILabel *doneLabel = [UILabel new];
    doneLabel.frame = CGRectMake(0, 2, buttonWidth, buttonHeight);
    doneLabel.backgroundColor = [UIColor clearColor];
    doneLabel.textColor = [UIColor whiteColor];
    doneLabel.textAlignment = NSTextAlignmentCenter;
    doneLabel.font = buttonFont;
    doneLabel.text = [Utility getStringByKey:@"Done"];
    [okButton addSubview:doneLabel];
    
    [buttonsView addSubview:resetButton];
    [buttonsView addSubview:okButton];
    
    return buttonsView;
}


/**
    _advisoryType : low or high only
 */
-(UIView *)setUpReferencesByType:(NSString *)_advisoryType setWidth:(CGFloat)_containerWidth  setPaddingTop:(CGFloat)_paddingTop{


    NSString *labelTitleText = @"";            // set if your
    
    NSString *labelDataTextDescription1 = @""; // systolic
    NSString *labelDataText1 = @"";            // > 140
    NSString *labelDataTextUnit1 = @"";        // mmHg or
    
    NSString *labelDataTextDescription2 = @"";  // diastolic
    NSString *labelDataText2 = @"";             // > 90
    NSString *labelDataTextUnit2 = @"";         // mmHg
    
    
    NSString *labelDescriptionText1 = @"";
    NSString *labelDescriptionText2 = @"";
    UIColor *tColor = nil;
    
    if ([viewType isEqualToString:@"BP"]) {
        labelTitleText = [Utility getStringByKey:@"label_bp_if_your"];
        labelDataTextDescription1 = [Utility getStringByKey:@"label_systolic"];
        labelDataTextDescription2 = [Utility getStringByKey:@"label_diastolic"];
        labelDataText1 = [Utility getStringByKey:[NSString stringWithFormat:@"label_systolic_%@",_advisoryType]];
        labelDataText2 = [Utility getStringByKey:[NSString stringWithFormat:@"label_diastolic_%@",_advisoryType]];
        labelDataTextUnit1 = [Utility getStringByKey:@"label_bp_or"];
        labelDataTextUnit2 = [Utility getStringByKey:@"label_mmhg"];
        labelDescriptionText1 = [Utility getStringByKey:[NSString stringWithFormat:@"label_bp_desc_%@_1",_advisoryType]];
        labelDescriptionText2 = [Utility getStringByKey:[NSString stringWithFormat:@"label_bp_desc_%@_2",_advisoryType]];
        tColor = [self BPBannerColor];
    }else if([viewType isEqualToString:@"BG"]){
        labelTitleText = [Utility getStringByKey:@"label_bg_if_your"];
        //labelDataTextDescription1 = [Utility getStringByKey:@"label_systolic"];
        //labelDataTextDescription2 = [Utility getStringByKey:@"label_diastolic"];
        labelDataText1 = [Utility getStringByKey:[NSString stringWithFormat:@"label_bg_%@_1",_advisoryType]];
        labelDataText2 = [Utility getStringByKey:[NSString stringWithFormat:@"label_bg_%@_2",_advisoryType]];
        labelDataTextUnit1 = [Utility getStringByKey:[NSString stringWithFormat:@"label_bg_or_%@_1",_advisoryType]];
        labelDataTextUnit2 = [Utility getStringByKey:[NSString stringWithFormat:@"label_bg_or_%@_2",_advisoryType]];
        labelDescriptionText1 = [Utility getStringByKey:[NSString stringWithFormat:@"label_bg_desc_%@_1",_advisoryType]];
        labelDescriptionText2 = [Utility getStringByKey:[NSString stringWithFormat:@"label_bg_desc_%@_2",_advisoryType]];
        tColor = [self BGBannerColor];
    }else{
        return nil;
    }
    
    UIView *subView = [UIView new];
    CGFloat paddingTop = divPaddingMid;
    CGFloat paddingLeft = labelPaddingBig;
    CGFloat labelWidth = _containerWidth - 2 * paddingLeft;
    
    UIFont  *labelFontNormal = [UIFont fontWithName:font55 size:normalFontSize];
    UIFont  *labelFontBig = [UIFont fontWithName:font65 size:ColorFontSizeBig];
    
    UIFont  *desFontNormal = [UIFont fontWithName:font55 size:(normalFontSize-1)];
    
    
    // If your
    CGFloat totalHeight = paddingTop;
    UILabel *labelTitle = [UILabel new];
    CGFloat labelTitleHeight = [Utility calculateHeightForString:labelTitleText usingWidth:labelWidth usingFont:labelFontNormal] + labelSubPadding;
    labelTitle.textColor = [self ReferencesLabelColor];
    labelTitle.text = labelTitleText;
    labelTitle.font = labelFontNormal;
    labelTitle.frame = CGRectMake(paddingLeft, totalHeight, labelWidth,labelTitleHeight);
    [subView addSubview:labelTitle];
    totalHeight += (labelTitleHeight + divPaddingMid/2);
    
    
    // xx > xx unit
    CGFloat subItemHighHeight = [Utility calculateHeightForString:labelDataText1 usingWidth:labelWidth usingFont:labelFontBig];
    CGRect subItmeHighRect = CGRectMake(paddingLeft, totalHeight, labelWidth, subItemHighHeight);
    UIView *subItemHigh = [self ReferencesSubItemView:labelDataTextDescription1 setValue:labelDataText1 setUnit:labelDataTextUnit1 setTextColor:tColor usingFrame:subItmeHighRect];
    [subView addSubview:subItemHigh];
    totalHeight += subItemHighHeight;
    
    // xx > xx unit
    CGFloat subItemLowHeight = [Utility calculateHeightForString:labelDataText2 usingWidth:labelWidth usingFont:labelFontBig];
    CGRect subItmeLowRect = CGRectMake(paddingLeft, totalHeight, labelWidth, subItemLowHeight);
    UIView *subItemLow = [self ReferencesSubItemView:labelDataTextDescription2 setValue:labelDataText2 setUnit:labelDataTextUnit2 setTextColor:tColor usingFrame:subItmeLowRect];
    [subView addSubview:subItemLow];
    totalHeight += (subItemLowHeight +  divPaddingBig);
    
    
    // stage 1 row1
    if (labelDescriptionText1!=nil&&![labelDescriptionText1 isEqualToString:@""]) {
        UILabel *labelDecription = [UILabel new];
        CGFloat labelTitleHeight = [Utility calculateHeightForString:labelDescriptionText1 usingWidth:labelWidth usingFont:desFontNormal]+labelSubPadding;
        labelDecription.textColor = [self ReferencesLabelColor];
        labelDecription.text = labelDescriptionText1;
        labelDecription.numberOfLines = 0;
        labelDecription.font = desFontNormal;
        labelDecription.lineBreakMode = NSLineBreakByWordWrapping;
        labelDecription.frame = CGRectMake(paddingLeft, totalHeight, labelWidth,labelTitleHeight);
        [subView addSubview:labelDecription];
        totalHeight += labelTitleHeight;
    }
    
    //stage 1 row2
    if (labelDescriptionText2!=nil&&![labelDescriptionText2 isEqualToString:@""]) {
        UILabel *labelDecription = [UILabel new];
        CGFloat labelTitleHeight = [Utility calculateHeightForString:labelDescriptionText2 usingWidth:labelWidth usingFont:desFontNormal];
        labelDecription.textColor = [self ReferencesLabelColor];
        labelDecription.text = labelDescriptionText2;
        labelDecription.numberOfLines = 0;
        labelDecription.font = desFontNormal;
        labelDecription.lineBreakMode = NSLineBreakByWordWrapping;
        labelDecription.frame = CGRectMake(paddingLeft, totalHeight, labelWidth,labelTitleHeight);
        [subView addSubview:labelDecription];
        totalHeight += labelTitleHeight;
    }
    totalHeight += divPaddingBig;
    
    subView.frame = CGRectMake(0, _paddingTop, _containerWidth, totalHeight);
    return subView;
}



-(UIView *)ReferencesSubItemView:(NSString *)_label setValue:(NSString *)_value setUnit:(NSString *)_unit  setTextColor:(UIColor *)_tColor usingFrame:(CGRect)_frame{
    
    UIView *subItemView =  [UIView new];
    subItemView.frame = _frame;
    CGFloat subItemHeight = _frame.size.height;
    UIFont  *labelFontNormal = [UIFont fontWithName:font65 size:ColorFontSizeSmall];
    UIFont  *labelFontBig = [UIFont fontWithName:font65 size:ColorFontSizeBig];
    
    CGFloat subPaddingLeft = 0;
    if (_label!=nil && ![_label isEqualToString:@""]) {
        UILabel *dataLabel = [UILabel new];
        CGFloat dataLabelWidth = [Utility calculateWidthForString:_label usingFont:labelFontNormal];
        dataLabel.text = _label;
        dataLabel.textColor = _tColor;
        dataLabel.font = labelFontNormal;
        dataLabel.frame = CGRectMake(subPaddingLeft, 0, dataLabelWidth, subItemHeight);
        subPaddingLeft += dataLabelWidth;
        [subItemView addSubview:dataLabel];
    }
    
    UILabel *dataValueLabel = [UILabel new];
    CGFloat dataValueLabelWidth = [Utility calculateWidthForString:_value usingFont:labelFontBig];
    dataValueLabel.text = _value;
    dataValueLabel.textColor = _tColor;
    dataValueLabel.font = labelFontBig;
    dataValueLabel.frame = CGRectMake(subPaddingLeft, 0, dataValueLabelWidth, subItemHeight);
    subPaddingLeft += dataValueLabelWidth;
    [subItemView addSubview:dataValueLabel];
    
    UILabel *dataUnitLabel = [UILabel new];
    CGFloat dataUnitLabelWidth = [Utility calculateWidthForString:_unit usingFont:labelFontNormal];
    dataUnitLabel.text = _unit;
    dataUnitLabel.textColor = _tColor;
    dataUnitLabel.font = labelFontNormal;
    dataUnitLabel.frame = CGRectMake(subPaddingLeft, 0, dataUnitLabelWidth, subItemHeight);
    subPaddingLeft += dataUnitLabelWidth;
    [subItemView addSubview:dataUnitLabel];

    return subItemView;

}


-(UIView *)DivLineView:(CGFloat)_paddingTop setWidth:(CGFloat)_containerWidth{
    UIView *divLineView = [UIView new];
    divLineView.frame = CGRectMake(0, _paddingTop, _containerWidth, 1.0f);
    divLineView.backgroundColor = [self DivLineColor];
    return divLineView;

}

-(UIView *)SourceView:(CGFloat)_paddingTop setWidth:(CGFloat)_containerWidth{
    UIView *sourceView = [UIView new];
    sourceView.backgroundColor = [UIColor clearColor];
    
    CGFloat totalHeight = 0.0f;
    UIFont *labelFont = [UIFont fontWithName:font55 size:normalFontSize];
    NSString *sourceTitle = [Utility getStringByKey:@"label_source"];
    NSString *sourceDetail = [Utility getStringByKey:[NSString stringWithFormat:@"label_%@_source",[viewType lowercaseString]]];
    
    UILabel *titleLabel = [UILabel new];
    CGFloat titleHeight = [Utility calculateHeightForString:sourceTitle usingWidth:_containerWidth usingFont:labelFont]+labelSubPadding;
    titleLabel.frame = CGRectMake(0, totalHeight, _containerWidth, titleHeight);
    titleLabel.textColor = [self SourceLabelColor];
    titleLabel.text = sourceTitle;
    titleLabel.numberOfLines = 0;
    titleLabel.font = labelFont;
    totalHeight += titleHeight;
    
    UILabel *detailLabel = [UILabel new];
    CGFloat detailLabelHeight = [Utility calculateHeightForString:sourceDetail usingWidth:_containerWidth usingFont:labelFont]+labelSubPadding;
    detailLabel.frame = CGRectMake(0, totalHeight, _containerWidth, detailLabelHeight);
    detailLabel.textColor = [self SourceLabelColor];
    detailLabel.numberOfLines = 0;
    detailLabel.text = sourceDetail;
    detailLabel.font = labelFont;
    totalHeight += detailLabelHeight;
    
    sourceView.frame = CGRectMake(containerPaddingLeft, _paddingTop, _containerWidth, totalHeight);
    [sourceView addSubview:titleLabel];
    [sourceView addSubview:detailLabel];
    
    return sourceView;
}


#define NUMBERS @"0123456789\n"
#define NUMBERS_AND_RPOINT @"0123456789.\n"


typedef enum _TextFieldViewTag {
    TextFieldViewTag_BP_SYSTOLIC_TAG = 20001,
    TextFieldViewTag_BP_DIASTOLIC_TAG = 20002,
    TextFieldViewTag_BG_FASTING_TAG = 30001,
    TextFieldViewTag_BG_BEFORE_MEAL_TAG = 30002,
    TextFieldViewTag_BG_AFTER_MEAL_TAG = 30003,
    TextFieldViewTag_HR____________TAG = 40001,
    TextFieldViewTag_BMI___________TAG = 50001
    
} TextFieldViewTag;



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if(textField.tag == TextFieldViewTag_BP_SYSTOLIC_TAG || textField.tag == TextFieldViewTag_BP_DIASTOLIC_TAG ){
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
            return NO;

    }else if(textField.tag == TextFieldViewTag_BG_FASTING_TAG || textField.tag == TextFieldViewTag_BG_BEFORE_MEAL_TAG || textField.tag == TextFieldViewTag_BG_AFTER_MEAL_TAG){
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_AND_RPOINT] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
            return NO;
    }
    return YES;
}



-(UIColor *)BPBannerColor{
    return  [UIColor colorWithRed:180.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1]; //#B44646 RGB(180,70,70)
}

-(UIColor *)BGBannerColor{
    return  [UIColor colorWithRed:166.0f/255.0f green:81.0f/255.0f blue:185.0f/255.0f alpha:1]; //#a651b9 RGB(166,81,185)
}
-(UIColor *)HRBannerColor{
    return  [UIColor colorWithRed:200.0f/255.0f green:100.0f/255.0f blue:0.0f/255.0f alpha:1]; //#c86400 RGB(200,100,0)
}
-(UIColor *)BMIBannerColor{
    return  [UIColor colorWithRed:43.0f/255.0f green:109.0f/255.0f blue:162.0f/255.0f alpha:1]; //#2b6da2 RGB(43,109,162)
}
-(UIColor *)ReferencesLabelColor{
    return  [UIColor colorWithRed:76.0f/255.0f green:76.0f/255.0f blue:76.0f/255.0f alpha:1]; //#4c4c4c RGB(76,76,76)
}

-(UIColor *)DivLineColor{
    return  [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1]; //#D7D7D7 RGB(215,215,215)
}

-(UIColor *)SourceLabelColor{
    return  [UIColor colorWithRed:50.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1]; //#326464 RGB(50,100,100)
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkBParrange:(UITextField *)sysTem :(UITextField *)diaTem {
    
    
    
//    bool check1 = ed_sys.getText().toString().equals("")
//    && !ed_dia.getText().toString().equals("");
//    bool check2 = !ed_sys.getText().toString().equals("")
//    && ed_dia.getText().toString().equals("");
    
    
    return true;
}

@end
