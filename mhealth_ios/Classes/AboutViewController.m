//
//  AboutViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-9-1.
//
//

#import "AboutViewController.h"
#import "Utility.h"
#import "webViewLinkViewController.h"

#import "syncMessage.h"


@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (iPad) {
        
        
        self = [super initWithNibName:@"AboutViewController_iPhone4iOS7" bundle:nibBundleOrNil];
        
    }
    else{
        self =  [super initWithNibName:@"AboutViewController" bundle:nibBundleOrNil];
    }

    
    
    
    
    
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
    [super viewWillAppear:animated];
    _actionbar.font=[UIFont fontWithName:font65 size:18];
    _topText.font=[UIFont fontWithName:font65 size:15];
//    _topText.font=[UIFont fontWithName:font65 size:22];

    _bottomText.font=[UIFont fontWithName:font65 size:15];
    
    _btn1.titleLabel.font=[UIFont fontWithName:font65 size:13];
    _btn2.titleLabel.font=[UIFont fontWithName:font65 size:13];
    _btn3.titleLabel.font=[UIFont fontWithName:font65 size:13];
    _btn4.titleLabel.font=[UIFont fontWithName:font65 size:13];
    _btn5.titleLabel.font=[UIFont fontWithName:font65 size:13];
    _btn6.titleLabel.font=[UIFont fontWithName:font65 size:13];
    
    [_topText setText:[Utility getStringByKey:@"about_page_toptext" ]];
    [_btn1.titleLabel setText:[Utility getStringByKey:@"general" ]];
    //[_btn2.titleLabel setText:[Utility getStringByKey:@"terms" ]];
    [_btn3.titleLabel setText:[Utility getStringByKey:@"privacy_po" ]];
    [_btn4.titleLabel setText:[Utility getStringByKey:@"frequently" ]];
    [_btn5.titleLabel setText:[Utility getStringByKey:@"authorised_de" ]];
    

    [_btn2 setTitle:[Utility getStringByKey:@"terms" ] forState:UIControlStateNormal];

    [_bottomText setText:[Utility getStringByKey:@"enqueir"]];
    
    
    [_actionbar setText:[Utility getStringByKey:@"about_healthreach"]];
    
    
    self.tx1=[self.tx1 initWithFrame:self.tx1.frame];
    self.tx1.delegate=self;
    [self.tx1 setParagraphReplacement:@""];

    
    self.tx2=[self.tx2 initWithFrame:self.tx2.frame];
    self.tx2.delegate=self;
    [self.tx2 setParagraphReplacement:@""];
    
    self.tx3=[self.tx3 initWithFrame:self.tx3.frame];
    self.tx3.delegate=self;
    [self.tx3 setParagraphReplacement:@""];
    
    self.tx4=[self.tx4 initWithFrame:self.tx4.frame];
    self.tx4.delegate=self;
    [self.tx4 setParagraphReplacement:@""];
    
    self.tx5=[self.tx5 initWithFrame:self.tx5.frame];
    self.tx5.delegate=self;
    [self.tx5 setParagraphReplacement:@""];
    
    self.tx6=[self.tx6 initWithFrame:self.tx6.frame];
    self.tx6.delegate=self;
    [self.tx6 setParagraphReplacement:@""];
    
    //self.test.text=@"<b>bold</b> and <i>italic</i> style";
    //self.test.text=@"<font face='HelveticaNeue-CondensedBold' size=20><u color=blue>underlined</u> <uu color=red>text</uu></font>";
   
    
    
    
      NSString *lanuage = [Utility getLanguageCode];
      if([lanuage isEqualToString: @"en"]){
        self.tx1.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=general_tnc'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>General Terms and Conditions</font></a>";
          self.tx2.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=tnc'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>Terms and Conditions for HealthReach</font></a>";

          self.tx3.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=privacy'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>Privacy Policy</font></a>";

          self.tx4.text=@"<a href='http://www.healthreach.com.hk/HealthReach/english/faq.jsp'><font face='HelveticaNeueLTPro-Md' size=13 color=#003ca0>Frequently Asked Questions</font></a>";

          self.tx5.text=@"<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>Authorised dealers</font></a>";
          
          self.tx6.text=@"<a href='mailto://enquiries@healthreach.com.hk'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>enquiries@healthreach.com.hk</font></a>";

    }
    else{
         self.tx1.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=general_tnc'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>一般條款及細則</font></a>";
        self.tx2.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=tnc'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>健易達服務的條款及細則</font></a>";
        
        self.tx3.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=privacy'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>私隱政策聲明</font></a>";
        
        self.tx4.text=@"<a href='http://www.healthreach.com.hk/HealthReach/tchinese/faq.jsp'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>常見問題</font></a>";
        
        self.tx5.text=@"<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/tchinese/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>特許代理</font></a>";
        
        self.tx6.text=@"<a href='mailto://enquiries@healthreach.com.hk'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>enquiries@healthreach.com.hk</font></a>";

    }


    
    
    
   // self.test.text=@"<font face='HelveticaNeue-CondensedBold' size=20 color='#CCFF00'>Text with</font> <font face=AmericanTypewriter size=16 color=purple>different colours</font> <font face=Futura size=32 color='#dd1100'>and sizes</font>";
    
   // self.test.text=@"<font face='HelveticaNeue-CondensedBold' size=14><p align=justify><font color=red>JUSTIFY</font> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim </p> <p align=left><font color=red>LEFT ALIGNED</font> veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p><br><p align=right><font color=red>RIGHT ALIGNED</font> Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p><br><p align=center><font color=red>CENTER ALIGNED</font> Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p></font> ";
    
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    
    [_verno setText:[NSString stringWithFormat:@"v%@",build]];
    
}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickVedio:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/service_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/service_iphone_zh.3gp";
//    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
//    webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
//    [intent setLink:link];
//    [self.navigationController pushViewController:intent animated:YES ];
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
    
    
    
}






-(IBAction)clickGeneral:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=general_tnc";
    else
        link= @"http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=general_tnc";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
//    webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
//    [intent setLink:link];
//    [self.navigationController pushViewController:intent animated:YES ];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];

}

-(IBAction)clickTerms:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=tnc";
    else
        link= @"http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=tnc";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
//    webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
//    [intent setLink:link];
//    [self.navigationController pushViewController:intent animated:YES ];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];

}






-(IBAction)clickPrivacy:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=privacy";
    else
        link= @"http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=privacy";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
//    webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
//    [intent setLink:link];
//    [self.navigationController pushViewController:intent animated:YES ];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];

}


-(IBAction)clickFrequently:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/HealthReach/english/faq.jsp";
    else
        link= @"http://www.healthreach.com.hk/HealthReach/tchinese/faq.jsp";
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];

}

-(IBAction)clickAuthorised:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2";
    else
        link= @"http://www.smartone.com/jsp/privileges_and_support/contact_us/tchinese/store_location_m.jsp?tt=2";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
//    webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
//    [intent setLink:link];
//    [self.navigationController pushViewController:intent animated:YES ];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];

}



-(IBAction)clickMailTo:(id)sender{
    NSString *link;
        link=@"mailto://enquiries@healthreach.com.hk";
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
    
}






- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
	   
    NSString * link=[url absoluteString];
    
     NSLog(@"did select link %@", link);
    
    if ([link rangeOfString:@"mailto"].location != NSNotFound) {
        link=@"mailto://enquiries@healthreach.com.hk";
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
    }else if ([link isEqualToString:@"http://www.healthreach.com.hk/HealthReach/tchinese/faq.jsp"]||
              [link isEqualToString:@"http://www.healthreach.com.hk/HealthReach/english/faq.jsp"]||
              [link isEqualToString:@"http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2"]||
              [link isEqualToString:@"http://www.smartone.com/jsp/privileges_and_support/contact_us/tchinese/store_location_m.jsp?tt=2"]){
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
        
    }
    else{
        webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
        [intent setLink:link];
        [self.navigationController pushViewController:intent animated:YES ];

    }
    
    
    
}










@end
