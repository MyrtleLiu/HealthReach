//
//  LearnMoreFirstViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-10-21.
//
//

#import "BaseViewController.h"
#import "RTLabel.h"


@interface LearnMoreFirstViewController : BaseViewController<UIScrollViewDelegate,RTLabelDelegate>

@property (strong, nonatomic) IBOutlet UILabel *actionbar;
@property (strong, nonatomic) IBOutlet UIImageView *titlebar;

@property (strong, nonatomic) IBOutlet UILabel *text1;
@property (strong, nonatomic) IBOutlet RTLabel *text2;


@property (strong, nonatomic) IBOutlet UIButton *vedioBtn;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;


@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) IBOutlet UIView *barView;

@end
