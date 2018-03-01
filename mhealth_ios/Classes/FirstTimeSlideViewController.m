//
//  FirstTimeSlideViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-9-9.
//
//

#import "FirstTimeSlideViewController.h"
#import "LoginViewController.h"
#import "Utility.h"
#import "TermAndConViewController.h"
#import "syncUtility.h"
#import "Constants.h"

@interface FirstTimeSlideViewController (){
    BOOL helpCheck;
    int scrollViewLastPosition;
}

@end



@implementation FirstTimeSlideViewController
    

@synthesize scrollView;
@synthesize message;
@synthesize pageController;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (iPad) {
       
        self = [super initWithNibName:@"FirstTimeSlideViewController_iPhone4iOS7" bundle:nibBundleOrNil];

    }
    else{
       
        self =  [super initWithNibName:@"FirstTimeSlideViewController" bundle:nibBundleOrNil];

    }

    
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             NSString *strWarn=[defaults objectForKey:@"strWarn"];
    
    if ([strWarn isEqualToString:@""]||[strWarn isEqualToString:@"(null)"]||strWarn==nil||strWarn==NULL)
    {
        strWarn=@"normal";
        
    }
         // strWarn=@"Remind_476";
            if ([strWarn isEqualToString:@"normal"]) {
                // normal
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"" forKey:@"update_HealthReach_Day"];
                [defaults synchronize];
                
                
                
            }
            else if([strWarn isEqualToString:@"force"])
            {
                //force
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"" forKey:@"update_HealthReach_Day"];
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
                NSString *tempHenderText=[Utility getStringByKey:@"HealthReach Calendar"];
                if ([tempHenderText isEqualToString:@"HealthReach Calendar"]) {
                    label1.text=@"Quit";
                    
                }
                else
                {
                    label1.text=@"離開";
                    
                }
                
                

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
                if ([tempHenderText isEqualToString:@"HealthReach Calendar"]) {
                    label2.text=@"Update";
                    
                }
                else
                {
                    label2.text=@"更新";
                    
                }
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
                    NSString *tempHenderText=[Utility getStringByKey:@"HealthReach Calendar"];
                    if ([tempHenderText isEqualToString:@"HealthReach Calendar"]) {
                        label1.text=@"Remind me later";
                        
                    }
                    else
                    {
                        label1.text=@"稍後更新";
                        
                    }
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
                    
                    
                if ([tempHenderText isEqualToString:@"HealthReach Calendar"]) {
                          label2.text=@"Update now";
                    }
                    else
                    {
                          label2.text=@"立即跟新";
                    }
                 
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
            }
            
            


    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
    helpCheck=false;
    [self slideshowInit];
    
   
    
    
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
}
-(void)upDateNow:(id)sender
{
    NSLog(@"Update now");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id910396784"]];
}


- (void) viewWillAppear:(BOOL)animated{
    
    
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"]){
        [_nextBtn setTitle:@"Next" forState:normal ];
    }
    else{
        [_nextBtn setTitle:@"下一步" forState:normal ];
    }
    
//    NSString *strtem=[Utility getStringByKey:@"next_btn" ];
//    [_nextBtn.titleLabel setText:strtem];
   

    [_textBtn setText:[Utility getStringByKey:@"fisttimeSlideDont" ]];
    
    
    self.tx1=[self.tx1 initWithFrame:self.tx1.frame];
    self.tx1.delegate=self;
    [self.tx1 setParagraphReplacement:@""];
    if([lanuage isEqualToString: @"en"]){
        self.tx1.text=@"<font face='HelveticaNeueLTPro-Roman' size=19 color=#4d4d4d>For full services, visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=19 color=#648c14>authorised dealers</font></a> for subscription and purchase of connected health devices.</font>";
    }
    else{
           self.tx1.text=@"<font face='HelveticaNeueLTPro-Roman' size=19 color=#4d4d4d>如果你有興趣享用全部功能，請前往我們的<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=19 color=#648c14>特許代理</font></a>登記服務及購買無線健康量度儀器</font>";
    }
    [self.tx1 setTextAlignment:RTTextAlignmentCenter];
    
    
}




- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
    NSString * link=[url absoluteString];
    
    
    NSLog(@"did select link %@", link);
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
    
    
    
}







- (void)slideshowInit {
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    pageController.numberOfPages = 8;
    pageController.currentPage = 0;
    
    NSString *lanuage = [Utility getLanguageCode];
    
    
    
    
    
    if (iPad) {
        if([lanuage isEqualToString:@"cn"]||[lanuage isEqualToString:@"zh"]){
            self.images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"firtst_time_slidezh01not5.jpg"], [UIImage imageNamed:@"firtst_time_slidezh02not5.jpg"], [UIImage imageNamed:@"firtst_time_slidezh03not5.jpg"],[UIImage imageNamed:@"firtst_time_slidezh04not5.jpg"],[UIImage imageNamed:@"firtst_time_slidezh05not5.jpg"],[UIImage imageNamed:@"firtst_time_slidezh06not5.jpg"],[UIImage imageNamed:@"firtst_time_slidezh07not5.jpg"],[UIImage imageNamed:@"firtst_time_slidezh08not5.jpg"],nil];
            
        }
        else{
            self.images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"firtst_time_slide01not5.jpg"], [UIImage imageNamed:@"firtst_time_slide02not5.jpg"], [UIImage imageNamed:@"firtst_time_slide03not5.jpg"],[UIImage imageNamed:@"firtst_time_slide04not5.jpg"],[UIImage imageNamed:@"firtst_time_slide05not5.jpg"],[UIImage imageNamed:@"firtst_time_slide06not5.jpg"],[UIImage imageNamed:@"firtst_time_slide07not5.jpg"],[UIImage imageNamed:@"firtst_time_slide08not5.jpg"],nil];
        }

        
    }
    else{
        
        if([lanuage isEqualToString:@"cn"]||[lanuage isEqualToString:@"zh"]){
            self.images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"first_time_slide01_zh.jpg"], [UIImage imageNamed:@"first_time_slide02_zh.jpg"], [UIImage imageNamed:@"first_time_slide03_zh.jpg"],[UIImage imageNamed:@"first_time_slide04_zh.jpg"],[UIImage imageNamed:@"first_time_slide05_zh.jpg"],[UIImage imageNamed:@"06_zh.jpg"],[UIImage imageNamed:@"first_time_slide07_zh.jpg"],[UIImage imageNamed:@"first_time_slide08_zh.jpg"],nil];
            
        }
        else{
            self.images = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"first_time_slide01.jpg"], [UIImage imageNamed:@"first_time_slide02.jpg"], [UIImage imageNamed:@"first_time_slide03.jpg"],[UIImage imageNamed:@"first_time_slide04.jpg"],[UIImage imageNamed:@"first_time_slide05.jpg"],[UIImage imageNamed:@"06_en.jpg"],[UIImage imageNamed:@"first_time_slide07.jpg"],[UIImage imageNamed:@"first_time_slide08.jpg"],nil];
        }
        
    }

    
    
        [self setupPage:nil];
    
//    self.dontShowAgainView.hidden = YES;
//    if ([self isLightIntro]){
//        self.lightIntroView.hidden = NO;
//        self.wholeScrollView.hidden = YES;
//    } else {
//        self.lightIntroView.hidden = YES;
//        self.wholeScrollView.hidden = NO;
//    }
    
    
    
    
    
    
    
    
}

//- (BOOL)isLightIntro{
//    if ([DBHelper isLightIntro:@"BP"]==1)
//        return YES;
//    else
//        return NO;
//}
- (IBAction)changeLightIntroButtonDown:(id)sender {
//    [DBHelper changeLightIntro:@"BP" status:0];
//    self.lightIntroView.hidden = YES;
//    self.wholeScrollView.hidden = NO;
}

- (IBAction)dontShowAgainTouchDown:(id)sender {
//    if ([DBHelper isLightIntro:@"BP"])
//    {
//        self.checkBoxImageView.image = [UIImage imageNamed:@"00_checkbox_50_off.png"];
//        [DBHelper changeLightIntro:@"BP" status:0];
//    } else {
//        self.checkBoxImageView.image = [UIImage imageNamed:@"00_checkbox_50_on.png"];
//        [DBHelper changeLightIntro:@"BP" status:1];
//    }
}

- (void)setupPage:(id)sender
{
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.canCancelContentTouches = NO;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.directionalLockEnabled = NO;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    NSUInteger pages = 0;
    int originX = 0;
    for (UIImage *image in self.images){
        
        
        UIImageView *pImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 548)];
        
        
        
        pImageView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        [pImageView setImage:image];
        CGRect rect = self.scrollView.frame;
        rect.origin.x = originX;
        rect.origin.y = -20;
//        rect.size.width = self.scrollView.frame.size.width;
//        rect.size.width = 320;

//        rect.size.height = self.scrollView.frame.size.height;
//        rect.size.height = 548;

        
        
        NSLog(@"width : %f",rect.size.width);
        NSLog(@"height : %f",rect.size.height);

        
        pImageView.frame = rect;
        pImageView.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView addSubview:pImageView];
//        originX += self.scrollView.frame.size.width;
        originX += pImageView.frame.size.width;
        
        pages++;
    }
    [self.pageController addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageController.numberOfPages = pages;
    self.pageController.currentPage = 0;
    self.pageController.tag = 110;
    //[self.scrollView setContentSize:CGSizeMake(originX, self.scrollView.bounds.size.height)];
    
    [self.scrollView scrollsToTop];
    
    NSLog(@"scroll width : %f",self.scrollView.frame.size.width);
    NSLog(@"scroll height : %f",self.scrollView.contentSize.height);
    
    
    
    
}

- (void)changePage:(id)sender
{
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.pageController.currentPage * self.scrollView.frame.size.width;
    rect.origin.y = 0;
    [self.scrollView scrollRectToVisible:rect animated:YES];
    
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    self.pageController.currentPage = page;
    
    if(page==0){
        self.vedioBtn.hidden=false;
        self.tx1.hidden=true;
        self.nextBtn.hidden = TRUE;
        self.checkView.hidden=true;

    }
    else if (page == 7){
   
        self.tx1.hidden=false;
        self.nextBtn.hidden = FALSE;
        self.checkView.hidden=false;
        self.vedioBtn.hidden=true;
    }
    else{
        self.tx1.hidden=true;
        self.nextBtn.hidden = TRUE;
        self.checkView.hidden=true;
        self.vedioBtn.hidden=true;
    }
}

-(IBAction)swithToHomePage:(id)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool: helpCheck forKey: @"checkFirstTimeSlide"];
    [defaults synchronize];
    //NSLog(@"helpCheck is %hhd when click",helpCheck);
    TermAndConViewController *intent = [[TermAndConViewController alloc] initWithNibName:@"TermAndConViewController" bundle:nil];
    [self.navigationController pushViewController:intent animated:YES ];
}

-(IBAction)checkShow:(id)sender{
    if(!helpCheck){
        [_checkBtn setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_on.png"] forState:UIControlStateNormal];
        helpCheck=true;
    }
    else{
         [_checkBtn setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
        helpCheck=false;
    }

}

-(IBAction)vedioBtnClick:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/service_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/service_iphone_zh.3gp";

    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];

    
    
    
    
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    CGFloat pageWith = self.scrollView.frame.size.width;
//    int page = floor((self.scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
//    self.pageController.currentPage = page;
//    
//
//    NSLog(@"now is the pae : %d",page);
//    
//        self.tx1.hidden=true;
//        self.nextBtn.hidden = TRUE;
//        self.checkView.hidden=true;
//        self.vedioBtn.hidden=true;
//}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int currentPosition = self.scrollView.contentOffset.x;
    NSInteger totalPages = self.images.count;
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    self.pageController.currentPage = page;
    
    int scrollViewEnddingLocation = pageWidth * totalPages;
    
    if (scrollViewLastPosition - currentPosition > 25 ) {
        scrollViewLastPosition = currentPosition;
        if (page == totalPages - 1){
            self.tx1.hidden=true;
                    self.nextBtn.hidden = TRUE;
                    self.checkView.hidden=true;
                    self.vedioBtn.hidden=true;
        }
        
    } else if (currentPosition - scrollViewLastPosition > 25) {
        scrollViewLastPosition = currentPosition;
    } else {
        if (page == totalPages - 1)
            if (currentPosition == scrollViewEnddingLocation)
            {
                self.nextBtn.hidden = false;
                self.checkView.hidden=false;
                self.vedioBtn.hidden=false;
            }
    }
}






@end
