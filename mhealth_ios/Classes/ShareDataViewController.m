//
//  ShareDataViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-8-29.
//
//

#import "ShareDataViewController.h"
#import "HomeViewController.h"
#import "sharePhoneNum.h"
#import "TKAlertCenter.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "menuLearnMoreViewController.h"
#import "GlobalVariables.h"


@interface ShareDataViewController ()

@end

@implementation ShareDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (iPad) {
        self = [super initWithNibName:@"ShareDataViewController_iPhone4iOS7" bundle:nibBundleOrNil];
    }
    else{
        self =  [super initWithNibName:@"ShareDataViewController" bundle:nibBundleOrNil];
    }

    
    
    
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iPad) {
          self.scrollView.contentSize=CGSizeMake(320, 435);
    }
    else
    self.scrollView.contentSize=CGSizeMake(320, 503);
    
    self.scrollView.delegate=self;
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newBackToHome:(id)sender
{
    HomeViewController *intent = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:intent animated:YES ];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait) {
//        
//        NSLog(@"UIInterfaceOrientationPortrait..............1");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeLeft..............1");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeRight..............1");
//    }
    
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationPortrait animated:NO];
    


    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait) {
//        
//        NSLog(@"UIInterfaceOrientationPortrait..............");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeLeft..............");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeRight..............");
//    }
    
    _actionbar.font=[UIFont fontWithName:font65 size:18];
    [_actionbar setText:[Utility getStringByKey:@"share_health_data"]];
    
    _tx2.font=[UIFont fontWithName:font55 size:13];
    _tx3.font=[UIFont fontWithName:font55 size:13];

    _topTextEn1.font=[UIFont fontWithName:font65 size:15];
    _topTextEn_link.titleLabel.font=[UIFont fontWithName:font65 size:15];
    
    _topTextCn1.font=[UIFont fontWithName:font65 size:15];
    _topTextCn2.font=[UIFont fontWithName:font65 size:15];
    _topTextCn_link.titleLabel.font=[UIFont fontWithName:font65 size:15];
    
    
    NSString *language = [Utility getLanguageCode];

    if([language isEqualToString: @"en"])
        _topView_en.hidden=false;
    else
        _topView_cn.hidden=false;
    
    
    
    [_tx1 setText:[Utility getStringByKey:@"share_tx1"]];
    [_tx2 setText:[Utility getStringByKey:@"share_tx2"]];
    [_tx3 setText:[Utility getStringByKey:@"share_tx3"]];
    [_tx4 setText:[Utility getStringByKey:@"share_tx4"]];

    [_confirm_Btn setTitle:[Utility getStringByKey:@"confirm_btn"] forState: normal];

    _confirm_Btn.titleLabel.textAlignment=NSTextAlignmentCenter;

    
    [_resultText setText:[Utility getStringByKey:@"share_result"]];
    [_okBtn setTitle:[Utility getStringByKey:@"ok"] forState: UIControlStateNormal];
    
    _phoneNeum1.delegate=self;
    _phoneNeum2.delegate=self;
    
    
  

    
}

-(IBAction)okBtn_click:(id)sender{
     [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate]  backToHome];
}




-(IBAction)confirmBtn_click:(id)sender{
    
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        menuLearnMoreViewController *historyView = [[menuLearnMoreViewController alloc] initWithNibName:@"menuLearnMoreViewController" bundle:nil];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{

        
        BOOL temp_check=![_phoneNeum1.text isEqualToString:@""];
        if(temp_check&&[_phoneNeum1.text isEqualToString: _phoneNeum2.text]){
            NSLog(@"check result : correct");
            BOOL checkUploadStatus=[sharePhoneNum sendShare:_phoneNeum1.text];
//            NSLog(@"check the checkUploadStatus : %hhd",checkUploadStatus);
            if(checkUploadStatus){
                //            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Upload succ"];
                //            [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate]  backToHome];
                _resultView.hidden=false;
            }
            else{
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Upload fail"];
                
            }
            
        }
        else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Please input the number correctly"];
        }

    }

    
    
    
    
    
    

}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

-(IBAction)topTextCnClick:(id)sender{
    
    NSString *link ;
    link=@"http://www.healthreach.com.hk/login2";
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
}
-(IBAction)topTextEnClick:(id)sender{
 
    NSString *link;
    link =@"http://www.healthreach.com.hk/login3";
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
  }


NSInteger prewTag ;
float prewMoveY;

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    int theMoveValue=216;
    CGRect textFrame =  textField.frame;
    float textY = textFrame.origin.y+textFrame.size.height;
    float bottomY = self.view.frame.size.height-textY;
    
    //NSLog(@"%f..............y",bottomY);
    
    if(bottomY>=216+theMoveValue)
    {
        prewTag = -1;
        return;
    }
    prewTag = textField.tag;
    float moveY = 216+theMoveValue-bottomY+40+(iOS9?10:0);
    prewMoveY = moveY;
    
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y -=moveY;
    frame.size.height +=moveY;
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    
    if (_tempView) {
        
        if (iOS9) {
            
            CGRect tmp=_tempView.frame;
            
            tmp.size.height=50;
            
            _tempView.frame=tmp;
            
        }
        _tempView.hidden=false;
        
    }
    
    
}


-(void) textFieldDidEndEditing:(UITextField *)textField
{
    if(prewTag == -1)
    {
        return;
    }
    float moveY ;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    if(prewTag == textField.tag)
    {
        moveY =  prewMoveY;
        frame.origin.y +=moveY;
        frame.size. height -=moveY;
        self.view.frame = frame;
    }
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
    
    if (_tempView) {
        
        _tempView.hidden=true;
        
    }
    
    

}



@end
