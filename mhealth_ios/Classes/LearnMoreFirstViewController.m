//
//  LearnMoreFirstViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-21.
//
//

#import "LearnMoreFirstViewController.h"
#import "Utility.h"
#import "GlobalVariables.h"

@interface LearnMoreFirstViewController ()

@end

@implementation LearnMoreFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"type is :%@",_type);
    
    if (iPad) {
        
        _barView.frame=CGRectMake(0, 0, 320, 45);
    }
    
    _text1.font=[UIFont fontWithName:font55 size:15];
    NSString *lanuage = [Utility getLanguageCode];
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)
    {
        
        if([lanuage isEqualToString: @"en"]){
            [_homeBtn setTitle:@"Home" forState: UIControlStateNormal];
            _homeBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
        }
        else{
            [_homeBtn setTitle:@"首頁" forState: UIControlStateNormal];
            _homeBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
        }
    }
    else
    {
        if([lanuage isEqualToString: @"en"]){
            [_homeBtn setTitle:@"Back" forState: UIControlStateNormal];
            _homeBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
        }
        else{
            [_homeBtn setTitle:@"返回" forState: UIControlStateNormal];
            _homeBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
            
        }
    }
    
    if([_type isEqualToString:@"walk"]){
        [_actionbar setText:[Utility getStringByKey:@"walkforhealth"]];
        [_titlebar setImage:[UIImage imageNamed:@"07_wa_header_p1.png"]];
        
        _text2=[_text2 initWithFrame:_text2.frame];
        _text2.delegate=self;
        [_text2 setParagraphReplacement:@""];
        
        if([lanuage isEqualToString: @"en"]){
            [_vedioBtn setImage:[UIImage imageNamed:@"vedioWALK_en.png"] forState:UIControlStateNormal];
            [_text1 setText:@"Walk for Health demonstration video:"];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>To enjoy all the features of HealthReach, please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> for subscription and purchase the compatible connected devices.</font>";
            
        }
        else{
            [_vedioBtn setImage:[UIImage imageNamed:@"vedioWALK_zh.png"] forState:UIControlStateNormal];
            [_text1 setText:@"要更詳細了解健康步行，請觀看以下短片。"];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>如果你有興趣享用健易達全部功能，請即前往<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>登記服務及購買指定量度儀器</font>";
        }
    }
    
    
    //------bp
    if([_type isEqualToString:@"bp"]){
        [_actionbar setText:[Utility getStringByKey:@"bloodpressure"]];
        [_titlebar setImage:[UIImage imageNamed:@"03_bp_header_p1.png"]];
      [_vedioBtn setImage:[UIImage imageNamed:@"vedioBP_en.png"] forState:UIControlStateNormal];
        _text2=[_text2 initWithFrame:_text2.frame];
        _text2.delegate=self;
        [_text2 setParagraphReplacement:@""];
        
        if([lanuage isEqualToString: @"en"]){
            [_text1 setText:@"Wireless Blood Pressure monitor for automatic recording of measurements:"];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>To enjoy all the features of HealthReach, please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> for subscription and purchase the compatible connected devices.</font>";
            
        }
        else{
            [_text1 setText:@"無線自動化血壓量度:"];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>如果你有興趣享用健易達全部功能，請即前往<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>登記服務及購買指定量度儀器</font>";
        }
    }
    //bg
    if([_type isEqualToString:@"bg"]){
        [_actionbar setText:[Utility getStringByKey:@"bloodglucose"]];
        [_titlebar setImage:[UIImage imageNamed:@"04_bg_header_p1.png"]];
       [_vedioBtn setImage:[UIImage imageNamed:@"vedioBG_en.png"] forState:UIControlStateNormal];
        _text2=[_text2 initWithFrame:_text2.frame];
        _text2.delegate=self;
        [_text2 setParagraphReplacement:@""];
        
        if([lanuage isEqualToString: @"en"]){
            [_text1 setText:@"Wireless Blood Glucose meter for automatic recording of measurements:"];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>To enjoy all the features of HealthReach, please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> for subscription and purchase the compatible connected devices.</font>";
            
        }
        else{
            [_text1 setText:@"無線自動化血糖量度："];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>如果你有興趣享用健易達全部功能，請即前往<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>登記服務及購買指定量度儀器</font>";
        }
    }

    //weight
    if([_type isEqualToString:@"weight"]){
        [_actionbar setText:[Utility getStringByKey:@"home_title_Weight"]];
        [_titlebar setImage:[UIImage imageNamed:@"06_we_header_p1.png"]];
       [_vedioBtn setImage:[UIImage imageNamed:@"vedioWEIGHT_en.png"] forState:UIControlStateNormal];
        _text2=[_text2 initWithFrame:_text2.frame];
        _text2.delegate=self;
        [_text2 setParagraphReplacement:@""];
        
        if([lanuage isEqualToString: @"en"]){
            [_text1 setText:@"Wireless Weight monitor for automatic recording of measurements:"];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>To enjoy all the features of HealthReach, please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> for subscription and purchase the compatible connected devices.</font>";
            
        }
        else{
            [_text1 setText:@"無線自動化體重量度："];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>如果你有興趣享用健易達全部功能，請即前往<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>登記服務及購買指定量度儀器</font>";
        }
    }
    
    
    //ecg
    if([_type isEqualToString:@"ecg"]){
        [_actionbar setText:[Utility getStringByKey:@"ECG"]];
        [_titlebar setImage:[UIImage imageNamed:@"05_ecg_header_p1.png"]];
//        [_vedioBtn setImage:[UIImage imageNamed:@"learnmore_bodyscale.png"] forState:UIControlStateNormal];
        _text2=[_text2 initWithFrame:_text2.frame];
        _text2.delegate=self;
        [_text2 setParagraphReplacement:@""];
        
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)
        {
            if([lanuage isEqualToString: @"en"])
            {
                [_text1 setText:@""];
              //  _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>ECG recorder is currently not supported. To learn more,please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> </font>";
                _text2.text=@"  ECG recorder is currently not supported.";
                _text2.textColor=[UIColor colorWithRed:50/255.0 green:100/255.0 blue:100/255.0 alpha:1];
                if (iOS9) {
                    
                    _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>  ECG recorder is currently not supported</font>";
                }
                
                
            }
            else{
                [_text1 setText:@""];
              //  _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>心電圖機暫不支援。請親臨<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>了解詳情</font>";
                _text2.text=@"                    心電圖機暫不支援。";
                _text2.textColor=[UIColor colorWithRed:50/255.0 green:100/255.0 blue:100/255.0 alpha:1];
            }
        }
        
        else
        {
            
            if([lanuage isEqualToString: @"en"])
            {
                [_text1 setText:@""];
            //    _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>ECG recorder is currently not supported. To learn more,please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> </font>";
                
                _text2.text=@"  ECG recorder is currently not supported.";
                _text2.textColor=[UIColor colorWithRed:50/255.0 green:100/255.0 blue:100/255.0 alpha:1];
                
                if (iOS9) {
                    
                    _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>  ECG recorder is currently not supported</font>";
                }
                
            }
            else{
                [_text1 setText:@""];
            //    _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>心電圖機暫不支援。請親臨<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>了解詳情</font>";
                  _text2.text=@"                    心電圖機暫不支援。";
                 _text2.textColor=[UIColor colorWithRed:50/255.0 green:100/255.0 blue:100/255.0 alpha:1];
            }

            
            
            
            
        }
    }
    
    
    

    //food
    if([_type isEqualToString:@"food"]){
        [_actionbar setText:[Utility getStringByKey:@"home_title_CaloriesReckoner"]];
        [_titlebar setImage:[UIImage imageNamed:@"08_cal_header_p1.png"]];
//        [_vedioBtn setImage:[UIImage imageNamed:@"learnmore_food.png"] forState:UIControlStateNormal];
        _text2=[_text2 initWithFrame:_text2.frame];
        _text2.delegate=self;
        [_text2 setParagraphReplacement:@""];
        
        if([lanuage isEqualToString: @"en"]){
            [_vedioBtn setImage:[UIImage imageNamed:@"vedioFOOD_en.png"] forState:UIControlStateNormal];
            [_text1 setText:@"Calorie Reckoner demonstration video:"];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>To enjoy all the features of HealthReach, please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> for subscription and purchase the compatible connected devices.</font>";
            
        }
        else{
            [_vedioBtn setImage:[UIImage imageNamed:@"vedioFOOD_zh.png"] forState:UIControlStateNormal];
            [_text1 setText:@"卡路里計算機示範短片："];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>如果你有興趣享用健易達全部功能，請即前往<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>登記服務及購買指定量度儀器</font>";
        }
    }

    
    
    //calendar
    if([_type isEqualToString:@"calendar"]){
        [_actionbar setText:[Utility getStringByKey:@"HealthReach Calendar"]];
        [_titlebar setImage:[UIImage imageNamed:@"02_diary_header_p1b.png"]];
//        [_vedioBtn setImage:[UIImage imageNamed:@"learnmore_calendar.png"] forState:UIControlStateNormal];
        _text2=[_text2 initWithFrame:_text2.frame];
        _text2.delegate=self;
        [_text2 setParagraphReplacement:@""];
        
        if([lanuage isEqualToString: @"en"])
        {
            [_vedioBtn setImage:[UIImage imageNamed:@"vedioCALENDAR_en.png"] forState:UIControlStateNormal];
            [_text1 setText:@"HealthReach Calendar demonstration video:"];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>To enjoy all the features of HealthReach, please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> for subscription and purchase the compatible connected devices.</font>";
            
        }
        else{
            [_vedioBtn setImage:[UIImage imageNamed:@"vedioCALENDAR_zh.png"] forState:UIControlStateNormal];
            [_text1 setText:@"健易達行事曆示範短片："];
            _text2.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>如果你有興趣享用健易達全部功能，請即前往<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>登記服務及購買指定量度儀器</font>";
        }
    }

    
    
    
    
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
    NSString * link=[url absoluteString];
    
    
    NSLog(@"did select link %@", link);
    
    
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:link];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)howToUseBP{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/bp_iphone_en.3gp";

    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/bp_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:link];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

-(void)howToUseBG{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/bg_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/bg_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:link];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

-(void)howToUseECG{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/ecg_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/ecg_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:link];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

-(void)howToUseWEIGHT{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/weight_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/weight_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:link];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}


-(void)howToUseWALK{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/walkforhealth_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/walkforhealth_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:link];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

-(void)howToUseCAL{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/caloriereckoner_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/caloriereckoner_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:link];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}





-(void)howToUseCALENDER{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/calendar_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/calendar_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:link];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
 
    
}

-(IBAction)ClickBtn:(id)sender{
    if([_type isEqualToString:@"walk"]){
        [self howToUseWALK];
    }
    else if([_type isEqualToString:@"bp"]){
        [self howToUseBP];
    }
    else if([_type isEqualToString:@"bg"]){
        [self howToUseBG];
    }
    else if([_type isEqualToString:@"weight"]){
        [self howToUseWEIGHT];
    }
    else if([_type isEqualToString:@"food"]){
        [self howToUseCAL];
    }
    else if([_type isEqualToString:@"calendar"]){
        [self howToUseCALENDER];
    }
    
}



@end
