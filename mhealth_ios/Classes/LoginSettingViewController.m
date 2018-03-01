//
//  LoginSettingViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-8-29.
//
//

#import "LoginSettingViewController.h"
#import "Utility.h"
#import "GlobalVariables.h"
#import "HomeViewController.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "Constants.h"

@interface LoginSettingViewController ()

@end

@implementation LoginSettingViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    NSString *lanuage = [Utility getLanguageCode];
    
    NSString *login_id = [NSString stringWithFormat:@"%@",[GlobalVariables shareInstance].login_id];
    NSString *session_id = [NSString stringWithFormat:@"%@",[GlobalVariables shareInstance].session_id];

    
    
    NSString *loginAPI=[Constants getAPIBase1];
    
//    NSString * login_url=[NSString stringWithFormat:@"http://202.140.96.155/wmc/jsp/mhealth/app_login_setting.jsp?lang=en&login=%@&sessionid=%@",login_id,session_id]; // en
    
    NSString *login_url =[NSString stringWithFormat:@"%@wmc/jsp/mhealth/app_login_setting.jsp?lang=en&login=%@&sessionid=%@",loginAPI,login_id,session_id];

    
    
    if (lanuage!=nil) {
        
        if ([lanuage isEqualToString:@"cn"]) {// cn
            
//            login_url=[NSString stringWithFormat:@"http://202.140.96.155/wmc/jsp/mhealth/app_login_setting.jsp?lang=zh&login=%@&sessionid=%@",login_id,session_id];
            
            login_url =[NSString stringWithFormat:@"%@wmc/jsp/mhealth/app_login_setting.jsp?lang=zh&login=%@&sessionid=%@",loginAPI,login_id,session_id];
        }
    }
    NSLog(@"%@",login_url);
    loginView.delegate=self;
    [loginView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:login_url]]];

}






- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *target=[[request URL] absoluteString];
    
    
  
    if ([target rangeOfString:@"type=BackToApp"].location != NSNotFound) {
        if([target rangeOfString:@"type=BackToAppHome"].location != NSNotFound){
            
//            HomeViewController *intent = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//            [self.navigationController pushViewController:intent animated:YES ];
            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToHome];

    
        }
        else{
             [self.navigationController popViewControllerAnimated:YES];
        }
       
    }


    return YES;
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	
    
	loadView.hidden=true;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if([error code]==NSURLErrorCancelled||[error.localizedDescription isEqualToString:@"Frame load interrupted"]||[error.localizedDescription isEqualToString:@"帧框加载已中断"]||[error.localizedDescription isEqualToString:@"頁框載入中斷"]){
        return;
        //
    }
	loadView.hidden=true;
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
							 error.localizedDescription];
	[webView loadHTMLString:errorString baseURL:nil];
}






@end
