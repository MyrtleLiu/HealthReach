//
//  FirstWalkResultViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-10-21.
//
//

#import "BaseViewController.h"
#import "RTLabel.h"

@interface FirstWalkResultViewController : BaseViewController<UIScrollViewDelegate,RTLabelDelegate>


@property (strong, nonatomic) IBOutlet UILabel *actionbar;
@property (strong, nonatomic) IBOutlet RTLabel *text;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIView *barView;

@end
