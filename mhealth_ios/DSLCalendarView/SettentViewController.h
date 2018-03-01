//
//  SettentViewController.h
//  mHealth
//
//  Created by gz dev team on 14年11月7日.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SettentViewController : BaseViewController
{
    IBOutlet UILabel *hendLabelFont;
    IBOutlet UIButton *isOK;
}

@property(nonatomic,assign)int isCalendar;
-(IBAction)back:(id)sender;
-(IBAction)goHome:(id)sender;
-(IBAction)isOK:(id)sender;
@end
