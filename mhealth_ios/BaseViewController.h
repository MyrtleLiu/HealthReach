//
//  BaseViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-2-18.
//
//

#import <UIKit/UIKit.h>


typedef void (^RevealBlock)();

@interface BaseViewController : UIViewController{
    

}



-(void) backToHome;

-(void) back;

-(void) showhideMenu;

-(IBAction)toShowMenu:(id)sender;

-(IBAction)BackHome:(id)sender;

-(IBAction)Back:(id)sender;

-(IBAction)toUserInfo:(id)sender;

- (IBAction)backTheHome:(id)sender;

//-(void) showHideUserInfo;

@end
