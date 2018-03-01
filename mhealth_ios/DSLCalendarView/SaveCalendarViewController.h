//
//  SaveCalendarViewController.h
//  mHealth
//
//  Created by gz dev team on 14年11月6日.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SaveCalendarViewController : BaseViewController
{
    IBOutlet UIView *textBackGoundView;
    IBOutlet UIButton * onButton;
    IBOutlet UIButton * offButton;
    IBOutlet UILabel *mHealthHendTextFont;
    IBOutlet UIImageView* _imageView;
    IBOutlet UIImageView* _BTNONONON;
    IBOutlet UIImageView* _BTOFFOFFOFF;
    

    
}
@property(nonatomic,assign)int isCalendar;


-(IBAction)back:(id)sender;
-(IBAction)goHome:(id)sender;
-(IBAction)ONtheCalendar:(id)sender;
-(IBAction)OFFtheCalendar:(id)sender;
@end
