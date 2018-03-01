//
//  measurementDemoViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-10-23.
//
//

#import "BaseViewController.h"

@interface measurementDemoViewController : BaseViewController

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) IBOutlet UILabel *actionbar;
@property (strong, nonatomic) IBOutlet UIImageView *titlebar;
@property (strong, nonatomic) IBOutlet UIImageView *demonpic;
@property (strong, nonatomic) IBOutlet UIView *barView;
@property (strong, nonatomic) IBOutlet UIButton *calBtn;



@end
