//
//  InTheTreeViewController.h
//  mHealth
//
//  Created by admin on 11/2/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface InTheTreeViewController : BaseViewController
{
    IBOutlet UILabel *heardTextFont;
    IBOutlet UIButton *ok_btn;
    IBOutlet UILabel *theLittleLAbelTextFont;
    IBOutlet UILabel *gamerulesTextFont;
    NSString *strTempTemp;
    IBOutlet UIView * backbackBroundVIew;
    
}
@property(nonatomic,assign)int theviewINT;
@property(nonatomic,assign)int hendviewINT;
-(IBAction)isOK:(id)sender;
@end
