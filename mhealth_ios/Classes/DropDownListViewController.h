//
//  DropDownListViewController.h
//  mHealth
//
//  Created by sngz on 14-2-28.
//
//

#import <UIKit/UIKit.h>

@interface DropDownListViewController : UIViewController

- (IBAction)showDropDownList:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *TextButton;

@property (copy, nonatomic) NSString *buttonText;

@end
