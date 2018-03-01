//
//  PresetLevelViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-8-29.
//
//

#import "PresetLevelViewController.h"
#import "HomeViewController.h"
#import "PresetLevelDetailViewController.h"


@interface PresetLevelViewController ()

@end

@implementation PresetLevelViewController


#define labelWidth 280.0f
#define labelSubPadding 5.0f
#define labelDivPadding 10.0f

#define buttonDivPadding 10.0f
#define buttonWidth 265.0f
#define buttonHeight 50.0f

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (!iPad) {
        self = [super initWithNibName:@"PresetLevelViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"PresetLevelViewController_ipad" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma ---- action functions ---

- (IBAction)newBackToHome:(id)sender
{
    HomeViewController *intent = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:intent animated:YES ];
}


-(IBAction)toBloodPressure:(id)sender{

    PresetLevelDetailViewController *intent = [[PresetLevelDetailViewController alloc] initWithNibName:@"BP" bundle:nil];
    [self.navigationController pushViewController:intent animated:YES ];

}

-(IBAction)toBloodGlucose:(id)sender{
    
    PresetLevelDetailViewController *intent = [[PresetLevelDetailViewController alloc] initWithNibName:@"BG" bundle:nil];
    [self.navigationController pushViewController:intent animated:YES ];
    
}
-(IBAction)toHeartRate:(id)sender
{
    PresetLevelDetailViewController *intent = [[PresetLevelDetailViewController alloc] initWithNibName:@"HR" bundle:nil];
    [self.navigationController pushViewController:intent animated:YES ];
}
-(IBAction)toBMI:(id)sender
{
    PresetLevelDetailViewController *intent = [[PresetLevelDetailViewController alloc] initWithNibName:@"BMI" bundle:nil];
    [self.navigationController pushViewController:intent animated:YES ];
}


#pragma ---- setup view here ----
#pragma do it in viewdidload

-(void)setUpView{

    [_actionbar setText:[Utility getStringByKey:@"presetlevel" ]];
    _actionbar.font=[UIFont fontWithName:font65 size:18];
    
    float paddingLeft = (self.view.bounds.size.width - labelWidth )/2;
    float paddingTop = 20.0f;
    float totalHeight = paddingTop;
    
    NSString *stringTxt1 = [Utility getStringByKey:@"perset_level_tx1" ];
    _tx1 = [self setUpLabelByString:stringTxt1];
    float _txtHeight1 = [Utility calculateHeightForString:stringTxt1 usingWidth:labelWidth usingFont:[self pLabelFont]]+labelSubPadding;
    [_tx1 setFrame:CGRectMake(paddingLeft, totalHeight, labelWidth, _txtHeight1)];
    
    totalHeight += (_txtHeight1 + labelDivPadding);
    
    
    NSString *stringTxt2 = [Utility getStringByKey:@"perset_level_tx2" ];
    _tx2 = [self setUpLabelByString:stringTxt2];
    float _txtHeight2 = [Utility calculateHeightForString:stringTxt2 usingWidth:labelWidth usingFont:[self pLabelFont]]+labelSubPadding;
    [_tx2 setFrame:CGRectMake(paddingLeft, totalHeight, labelWidth, _txtHeight2)];
    
    totalHeight += (_txtHeight2 + labelDivPadding);
    
    
    NSString *stringTxt3 = [Utility getStringByKey:@"perset_level_tx3" ];
    //_tx3 = [self setUpLabelByString:stringTxt3];
    
    _tx3=[[RTLabel alloc] initWithFrame:CGRectMake(paddingLeft, totalHeight, labelWidth, 40.0F)];
    
    _tx3.textColor = [self pLabelColor];
    //_tx3.text = _labelString;
    //_tx3.numberOfLines = 0;
    _tx3.font = [self pLabelFont];
    _tx3.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    _tx3.delegate=self;
    [_tx3 setParagraphReplacement:@""];
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"]){
        _tx3.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>Setting up or a amending the preset levels for caregiver alerts requires you, together with the registered Healthreach customer, to do at <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#003CA0>authorised dealers.</font></a></font>";
    }
    else{
        _tx3.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>設定及更改警示功能的數據指標，需要登記人與健易達用戶一同親臨<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#003CA0>特許代理</font></a>辦理。</font>";
    }
    
    float _txtHeight3 = [Utility calculateHeightForString:stringTxt3 usingWidth:labelWidth usingFont:[self pLabelFont]]+labelSubPadding;
    [_tx3 setFrame:CGRectMake(paddingLeft, totalHeight, labelWidth, _txtHeight3)];
    
    totalHeight += (_txtHeight3 + paddingTop);
    
    
    
    float buttonPaddingLeft = (self.view.bounds.size.width - buttonWidth)/2;
    _bpBtn = [self setUpButtonByString:[Utility getStringByKey:@"preset_bp"]];
    _bpBtn.frame = CGRectMake(buttonPaddingLeft, totalHeight, buttonWidth, buttonHeight);
    [_bpBtn addTarget:self action:@selector(toBloodPressure:) forControlEvents:UIControlEventTouchUpInside];
    totalHeight += (buttonHeight + buttonDivPadding);
    
    
    _ecgBtn = [self setUpButtonByString:[Utility getStringByKey:@"heart_rate"]];
    _ecgBtn.frame = CGRectMake(buttonPaddingLeft, totalHeight, buttonWidth, buttonHeight);
    [_ecgBtn addTarget:self action:@selector(toHeartRate:) forControlEvents:UIControlEventTouchUpInside];
    totalHeight += (buttonHeight + buttonDivPadding);
    
    
    _bgBtn = [self setUpButtonByString:[Utility getStringByKey:@"preset_bg"]];
    _bgBtn.frame = CGRectMake(buttonPaddingLeft, totalHeight, buttonWidth, buttonHeight);
    [_bgBtn addTarget:self action:@selector(toBloodGlucose:) forControlEvents:UIControlEventTouchUpInside];
    totalHeight += (buttonHeight + buttonDivPadding);
    
    
    _weightBtn = [self setUpButtonByString:[Utility getStringByKey:@"body_mass"]];
    _weightBtn.frame = CGRectMake(buttonPaddingLeft, totalHeight, buttonWidth, buttonHeight);
    [_weightBtn addTarget:self action:@selector(toBMI:) forControlEvents:UIControlEventTouchUpInside];
    totalHeight += (buttonHeight + 2*paddingTop);
    
    [_presetScrollView addSubview:_tx1];
    [_presetScrollView addSubview:_tx2];
    [_presetScrollView addSubview:_tx3];
    
    [_presetScrollView addSubview:_bpBtn];
    [_presetScrollView addSubview:_ecgBtn];
    [_presetScrollView addSubview:_bgBtn];
    [_presetScrollView addSubview:_weightBtn];
      _presetScrollView.delaysContentTouches=NO;
    [_presetScrollView setContentSize:CGSizeMake(self.view.bounds.size.width, totalHeight)];

}



#pragma ---common view -----

-(UILabel *)setUpLabelByString:(NSString *)_labelString{
    UILabel *labelDecription = [UILabel new];
    labelDecription.textColor = [self pLabelColor];
    labelDecription.text = _labelString;
    labelDecription.numberOfLines = 0;
    labelDecription.font = [self pLabelFont];
    labelDecription.lineBreakMode = NSLineBreakByWordWrapping;
    return labelDecription;
}

-(UIButton *)setUpButtonByString:(NSString *)_buttonString{
   UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
   tempButton.titleLabel.font = [self pButtonFont];
   [tempButton setTitle:_buttonString forState:UIControlStateNormal];
   [tempButton setTitleColor:[self pLabelColor] forState:UIControlStateNormal];
   [tempButton setBackgroundImage:[UIImage imageNamed:@"set_btn_1"] forState:UIControlStateNormal];
   tempButton.titleLabel.textAlignment=NSTextAlignmentCenter;
   return tempButton;
}


-(UIFont *)pLabelFont{
    return [UIFont systemFontOfSize:15];

}

-(UIColor *)pLabelColor{
    return [UIColor colorWithRed:50.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
}

-(UIFont *)pButtonFont{
    return [UIFont boldSystemFontOfSize:15];
    
}


- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
    NSString * link=[url absoluteString];
    
    
    NSLog(@"did select link %@", link);
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
    
    
    
}



@end
