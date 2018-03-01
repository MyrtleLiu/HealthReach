//
//  WeightResultViewController.h
//  mHealth
//
//  Created by sngz on 14-3-6.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WeightResultViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *WeightTitle;
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *LBSLabel;
@property (weak, nonatomic) IBOutlet UILabel *BMILabel;

@end
