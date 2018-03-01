//
//  LoginViewController.h
//  mHealth
//
//  Created by sngz on 13-12-24.
//
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIWebViewDelegate>{
    
    IBOutlet UIWebView *loginView;
    IBOutlet UIView *loadView;
    
    NSString *oldLogin;
    NSString *nowLogin;
    UIView *appForceView;
    UIImageView *imagehandImageView;
    UIImageView*healthReachImageView;
    
}



@end
