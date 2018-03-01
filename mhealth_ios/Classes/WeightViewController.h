//
//  WeightViewController.h
//  mHealth
//
//  Created by sngz on 14-2-24.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WeightViewController : BaseViewController

@property(nonatomic, retain) IBOutlet UILabel *weight_title;
@property(nonatomic, retain) IBOutlet UILabel *history_data;
@property(nonatomic, retain) IBOutlet UILabel *preparemeasure;

@end
