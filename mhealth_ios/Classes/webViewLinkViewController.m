//
//  webViewLinkViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-9-1.
//
//

#import "webViewLinkViewController.h"
#import "GlobalVariables.h"
#import "Utility.h"
#import "Constants.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "syncUtility.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import <MessageUI/MessageUI.h>
#import "TKAlertCenter.h"
#import "syncMessage.h"
#import "NoNetWorkViewController.h"
#import "UserInfoViewController.h"



@interface webViewLinkViewController (){
    
}

@end

@implementation webViewLinkViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (!iPad) {
        self = [super initWithNibName:@"webViewLinkViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"webViewLinkViewController_ipad" bundle:nibBundleOrNil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    if (iPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        self.view.frame=CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
        
        self->linkView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
    }
    
    loadView.hidden=false;
    
    NSString * login_url=_link;
    
    NSLog(@"go to  web url..........%@",login_url);
    
    [linkView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:login_url]]];
    
    linkView.delegate=self;
    
    float sysVer =[[[UIDevice currentDevice]systemVersion]floatValue];
    if(sysVer>=7.0){
        if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
            self.automaticallyAdjustsScrollViewInsets=NO;
        }
    }
//    if (!iPhone5) {
//        linkView.frame=CGRectMake(0,0,320,480);//CGRectMake(20,160,280,120);
//    }
    
    
}




- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *target=[[request URL] absoluteString];
    

    
    
    if ([target rangeOfString:@"type=BackToApp"].location != NSNotFound) {
        
        
        if (_isSetupCloud!=nil&&[_isSetupCloud isEqualToString:@"Y"]) {
            
            if ([Utility isFirstTimeLogin]) {
                
                
                UserInfoViewController *userInfo=[[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController_iphone5" bundle:nil];
                
                userInfo.from=@"login";
                
                [self.navigationController pushViewController:userInfo animated:NO ];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setBool: true forKey: @"checkFirstTimeSlide"];
                
            }else{
                
                
                
                HomeViewController *homeView=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
                
                
                if (_isLoginT!=nil) {
                    
                    if ([_isLoginT isEqualToString:@"0"]) {
                        
                        homeView.isloginT=0;
                    }
                    
                    if ([_isLoginT isEqualToString:@"1"]) {
                        
                        homeView.isloginT=1;
                    }
                    
                    
                }
                
                [self.navigationController pushViewController:homeView animated:NO ];
                
                
            }
            
        }else{
            
            if ([target rangeOfString:@"type=BackToAppHome"].location != NSNotFound)
            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToHome];
            else
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        
    }
    else if([target rangeOfString:@"type=LaunchBrowser"].location != NSNotFound) {
        NSInteger index=[target rangeOfString:@"url="].location;
        NSString *temLink=[target substringFromIndex:index+17];  //17為url=http%3A%2F%2F長度
        //        temLink= [self UrlValueEncode:temLink];
        temLink=[NSString stringWithFormat:@"http://%@",temLink];

        
        [linkView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:temLink]]];
        
        
    }
    else if([target rangeOfString:@"type=ForwardMessage"].location != NSNotFound) {
        

        
        NSThread *threadFE = [[NSThread alloc]initWithTarget:self selector:@selector(actionFE) object:nil];
        [threadFE start];
        return NO;
    }
    else if([target rangeOfString:@"delete=Y"].location != NSNotFound) {
        [syncMessage deleteMessageRecord :_messageid];
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }else if ([_link isEqualToString:@""]){
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:target]];
        
        return NO;
        
    }
    
    
    
    
    
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    

}








- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	

    
	loadView.hidden=true;
    
    _link=@"";
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
    
    
    
    //    NoNetWorkViewController *loginView2=[[NoNetWorkViewController alloc] initWithNibName:@"NoNetWorkViewController" bundle:nil];
    //    [loginView2 setLink:@"fromWebView"];
    //    [self.navigationController pushViewController:loginView2 animated:YES];
    
    
    
}





- (void )mailActionFE :(NSString * )messageid{
    {
        NSString *subjects;
        NSString *contents;
        NSString *files;
        NSString *filenames;
        NSMutableArray *fileArray;
        
        fileArray=[[NSMutableArray alloc] init];
        
        NSMutableArray *filenameArray;
        
        filenameArray=[[NSMutableArray alloc] init];
        
        NSLog(@"check if it run : %@",[GlobalVariables shareInstance].session_id );
        if ([GlobalVariables shareInstance].session_id!=nil){
            //        [DBHelper delNoIdRecord];
            NSString *lang;
            if ([[Utility getLanguageCode] isEqualToString:@"en"])
            {
                lang=@"en";
            }
            else{
                lang=@"zh";
            }
            NSString *session_id = [GlobalVariables shareInstance].session_id;
            NSString *login_id = [GlobalVariables shareInstance].login_id;
            NSString *urlStr = [[NSString alloc]init];
            urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
            urlStr = [urlStr stringByAppendingString:@"healthMessage?login="];
            if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
            urlStr = [urlStr stringByAppendingString:@"&action=FE"];
            urlStr = [urlStr stringByAppendingString:@"&sessionid="];
            if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
            urlStr = [urlStr stringByAppendingString:@"&messageid="];
            if (messageid)
            urlStr = [urlStr stringByAppendingString:messageid];
            urlStr = [urlStr stringByAppendingString:@"&lang="];
            urlStr = [urlStr stringByAppendingString:lang];
            
            NSLog(@"rt url:%@",urlStr);
            
            NSURL *request_url = [NSURL URLWithString:urlStr];
            NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
            
            if (xmlData) {
                [syncUtility XMLHasError:xmlData];
                
                
                //NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
                
                //NSLog(@"+++++++++++%@===================",xmlStr);
                
                
                static NSString *messagesFlag = @"//response";
                
                static NSString *messagesFlag2 = @"//attachments";
                static NSString *messagesFlag3 = @"//attachment";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
                NSArray *MessageRecord = [doc nodesForXPath:messagesFlag error:nil];
                for (DDXMLElement *obj in MessageRecord) {
                    DDXMLElement *subject = [obj elementForName:@"subject" ];
                    DDXMLElement *content = [obj elementForName:@"content"];
                    subjects=[subject stringValue];
                    contents=[content stringValue];
                }
                NSArray *MessageRecord2 = [doc nodesForXPath:messagesFlag2 error:nil];
                for (DDXMLElement *obj in MessageRecord2) {
                    NSArray *MessageRecord3 = [obj nodesForXPath:messagesFlag3 error:nil];
                    
                    for (DDXMLElement *obj_fl in MessageRecord3) {
                        DDXMLElement *file = [obj_fl elementForName:@"file" ];
                        DDXMLElement *filename = [obj_fl elementForName:@"filename" ];

                        files=[file stringValue];
                        filenames=[filename stringValue];

                        
                        [fileArray addObject:(files)];
                        
                        [filenameArray addObject:filenames];
                        
                        NSLog(@"%@......%lu",filenames,(unsigned long)[fileArray count]);
                        
                        
                    }
                }
                
                //                NSString *link = [[NSString alloc]init];
                //                link = [link stringByAppendingString:@"mailto:"];
                //                link = [link stringByAppendingString:@"?subject="];
                //                NSString * str1=[subjects stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //                link = [link stringByAppendingString:str1];
                //                link = [link stringByAppendingString:@"&body="];
                //                NSString * str2=[contents stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //                link = [link stringByAppendingString:str2];
                //                NSLog(@"%@....test in about",link);
                //                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
                
                MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
                
                if ([MFMailComposeViewController canSendMail]) {
                    
                    mailPicker.mailComposeDelegate = self;
                    //设置主题
                    [mailPicker setSubject: subjects];
                    
                    NSData *data;
                    for(int i=0;i<fileArray.count;i++){
                        NSString *strTem= [fileArray objectAtIndex:(i)];
                        NSString *filename=[filenameArray objectAtIndex:i];
                        data= [[NSData alloc]initWithBase64EncodedString:strTem  options:NSDataBase64DecodingIgnoreUnknownCharacters];
                        //                    NSData *imageData = UIImagePNGRepresentation(data);
                        [mailPicker addAttachmentData: data mimeType: @"image/jpeg" fileName: filename];
                        
                        //NSLog(@"add attachment.....");
                    }
                    
                    
                    NSString *emailBody = contents;
                    
                    [mailPicker setMessageBody:emailBody isHTML:YES];
                    
                    [self presentViewController:mailPicker animated:YES completion:nil];
                    
                }else{
                    
                    //                    @try {
                    //
                    //
                    //                        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Please setup your email client."];
                    //
                    //
                    //
                    //                    }
                    //                    @catch (NSException *exception) {
                    //
                    //                    }
                }
                
                
                
            }
        }
        
    }
    
    
    
    
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"123456");
    [self.navigationController popViewControllerAnimated:YES];

}


-(void)actionFE{
    [self mailActionFE :_messageid];
}


//- (BOOL)shouldAutorotate
//{
//    return YES;
//}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations{
#else
    - (UIInterfaceOrientationMask)supportedInterfaceOrientations{
#endif
    return (UIInterfaceOrientationMaskPortraitUpsideDown);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    
    
    return YES;
    
}





@end
