//
//  webViewLinkViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-9-1.
//
//

#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>


@interface webViewLinkViewController : UIViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate>{
    IBOutlet UIWebView *linkView;
    IBOutlet UIView *loadView;
//    NSString *link;
}

@property (nonatomic) NSString *link;

@property (nonatomic) NSString *messageid;


@property (nonatomic) NSString *isSetupCloud;
@property (nonatomic) NSString *isLoginT;



@end
