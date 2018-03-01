//
//  LoginSettingViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-8-29.
//
//

#import "BaseViewController.h"

@interface LoginSettingViewController  : BaseViewController<UIWebViewDelegate>{
    
    IBOutlet UIWebView *loginView;
    IBOutlet UIView *loadView;
}

@end
