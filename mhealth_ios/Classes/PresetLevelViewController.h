//
//  PresetLevelViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-8-29.
//
//

#import "BaseViewController.h"
#import "RTLabel.h"

@interface PresetLevelViewController : BaseViewController <RTLabelDelegate>

@property (strong, nonatomic) IBOutlet UILabel *actionbar;
@property (strong, nonatomic) IBOutlet UIScrollView *presetScrollView;

@property (strong, nonatomic) IBOutlet UILabel *tx1;
@property (strong, nonatomic) IBOutlet UILabel *tx2;
@property (strong, nonatomic) IBOutlet RTLabel *tx3;

@property (strong, nonatomic) IBOutlet RTLabel *tx4;


@property (strong, nonatomic) IBOutlet UIButton *bpBtn;
@property (strong, nonatomic) IBOutlet UIButton *bgBtn;
@property (strong, nonatomic) IBOutlet UIButton *ecgBtn;
@property (strong, nonatomic) IBOutlet UIButton *weightBtn;





@end
