//
//  BaseViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-2-18.
//
//

#import "BaseViewController.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "UserInfoViewController.h"
#import "GlobalVariables.h"
#import "HomeViewControllerFirst.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) backToHome{
    
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToHome];
    
//    int homeIndex=1;
//    
//    
//    
//    for (int i=0; i<[self.navigationController.viewControllers count]; i++) {
//        
//        UIViewController *view=[self.navigationController.viewControllers objectAtIndex:i];
//        
//        NSString *session_id = [GlobalVariables shareInstance].session_id;
//        NSString *login_id = [GlobalVariables shareInstance].login_id;
//        if(session_id==NULL||login_id==NULL){
//            if ([view isMemberOfClass:[HomeViewControllerFirst class]]) {
//                
//                homeIndex=i;
//                
//            }
//           
//
//        }
//        else{
//            if ([view isMemberOfClass:[HomeViewController class]]) {
//                
//                homeIndex=i;
//                
//                NSLog(@"find home index......%d",homeIndex);
//                
//            }
//        }
//
//        [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: homeIndex] animated:YES];
//        
//    }
//    
    
   
    

}

-(void) back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) showhideMenu{
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] showHideMenu];
}

-(IBAction)toShowMenu:(id)sender{
    
    [self showhideMenu];
}

-(IBAction)Back:(id)sender{
    
    [self back];
}

-(IBAction)BackHome:(id)sender{
    
    
    [self backToHome];
    
}

-(IBAction)toUserInfo:(id)sender{
    UserInfoViewController *userInfoView = [[UserInfoViewController alloc]initWithNibName:@"UserInfoViewController" bundle:nil];
    [self.navigationController pushViewController:userInfoView animated:YES];

}

- (IBAction)backTheHome:(id)sender{
    
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToHome];
    
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations{
#else
    - (UIInterfaceOrientationMask)supportedInterfaceOrientations{
#endif
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    
    
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    
}





- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    long currentDate = [[NSDate date] timeIntervalSince1970];
    [GlobalVariables shareInstance].touchTime = currentDate;
    
    NSLog(@"touch time is %ld",currentDate);

}

//手指刚刚触摸屏幕的时候触发的事件

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}

//手指在屏幕上移动是会不断触发这个事件

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

//手指离开后触发的事件

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)viewWillAppear:(BOOL)animated{
    long checkTimeOut = [[NSDate date] timeIntervalSince1970];
//    NSLog(@"touch time is %ld",[GlobalVariables shareInstance].touchTime);
//    NSLog(@"timeOut time is %ld",checkTimeOut);
    if(checkTimeOut-[GlobalVariables shareInstance].touchTime>10&&[GlobalVariables shareInstance].touchTime>0){
        
//        LoginViewController *intent = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//        [self.navigationController pushViewController:intent animated:YES ];
        
        
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        [self.revealController setFrontViewController:self.navigationController];
//        [self.revealController showViewController:self.revealController.frontViewController];
       

    
        
//        
//        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(myThreadMethod) object:nil];
//        [thread start];
       
    }
}

- (void)myThreadMethod{
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
     NSLog(@"time out");
}


@end
