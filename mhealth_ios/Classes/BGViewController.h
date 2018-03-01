//
//  BGViewController.h
//  mHealth
//
//  Created by sngz on 14-3-27.
//
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>

@interface BGViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *bgTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *measureLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;

@end
