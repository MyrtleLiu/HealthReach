//
//  menuLearnMoreViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-10-22.
//
//

#import "BaseViewController.h"
#import "RTLabel.h"

@interface menuLearnMoreViewController : BaseViewController<UIScrollViewDelegate,RTLabelDelegate>

@property (strong, nonatomic) IBOutlet RTLabel *text;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIImageView *login_logo;
@property (strong, nonatomic) IBOutlet UIView *barView;


@end
