//
//  TermAndConViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-9-12.
//
//

#import "TermAndConViewController.h"
#import "Utility.h"
#import "webViewLinkViewController.h"
#import "LoginViewController.h"
#import "HomeViewControllerFirst.h"

@interface TermAndConViewController ()

@end

@implementation TermAndConViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (!iPad) {
        self = [super initWithNibName:@"TermAndConViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"TermAndConViewController_iphone4" bundle:nibBundleOrNil];
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
    
    [_topText setText:[Utility getStringByKey:@"term_and_con"]];
    
    self.tx1=[self.tx1 initWithFrame:self.tx1.frame];
    self.tx1.delegate=self;
    [self.tx1 setParagraphReplacement:@""];
    
    
    self.tx2=[self.tx2 initWithFrame:self.tx2.frame];
    self.tx2.delegate=self;
    [self.tx2 setParagraphReplacement:@""];
    
    self.tx3=[self.tx3 initWithFrame:self.tx3.frame];
    self.tx3.delegate=self;
    [self.tx3 setParagraphReplacement:@""];
    
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"]){
        self.tx1.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=tnc'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>General Terms and Conditions</font></a>";
        self.tx2.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=tnc'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>Terms and Conditions for HealthReach</font></a>";
        
        self.tx3.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=privacy'><font face='HelveticaNeueLTPro-Md' size=12 color=#003ca0>Privacy Policy</font></a>";
        
    
            [_toplogo setImage:[UIImage imageNamed:@"01_index_logo.png"]];
        
  
        

        
        
    }
    else{
        self.tx1.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=zh&page=tnc'><font face='HelveticaNeueLTPro-Md' size=13 color=#003ca0>一般條款及細則</font></a>";
        self.tx2.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=tnc'><font face='HelveticaNeueLTPro-Md' size=13 color=#003ca0>健易達服務的條款及細則</font></a>";
        
        self.tx3.text=@"<a href='http://202.140.96.74/wmc/jsp/mhealth/app_login_page.jsp?lang=en&page=privacy'><font face='HelveticaNeueLTPro-Md' size=13 color=#003ca0>私隱政策聲明</font></a>";
        
        
        [_toplogo setImage:[UIImage imageNamed:@"00_logo.png"]];
        
    }

    
    [_okBtn setTitle:[Utility getStringByKey:@"ok"] forState: normal];
    _okBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_cancelBtn setTitle:[Utility getStringByKey:@"cancel"] forState: normal];
    _cancelBtn.titleLabel.textAlignment=NSTextAlignmentCenter;

   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
    NSString * link=[url absoluteString];
    
    NSLog(@"did select link %@", link);
    
           webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
        [intent setLink:link];
        [self.navigationController pushViewController:intent animated:YES ];
        
    
    
}
-(IBAction)okBtnClick:(id)sender{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool: helpCheck forKey: @"checkFirstTimeSlide"];
    
//    LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    [self.navigationController pushViewController:loginView animated:YES ];
    
    HomeViewControllerFirst *loginView = [[HomeViewControllerFirst alloc] initWithNibName:@"HomeViewControllerFirst" bundle:nil];
    [self.navigationController pushViewController:loginView animated:YES ];

    
//    NSMutableArray *tmp=[[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
//    
//    [tmp removeObjectAtIndex:1];
//    [tmp removeObject:<#(id)#>];
//    
//    self.navigationController.viewControllers=[[NSArray alloc] initWithArray:tmp];
    
    
}

-(IBAction)cancelBtnClick:(id)sender{
    exit(0);
}


@end
