//
//  FoodDetailViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-10-23.
//
//

#import "BaseViewController.h"

@interface FoodDetailViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIImageView *demonpic;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UIButton *btnExport;
@property (strong, nonatomic) IBOutlet UIView *barView;
@property (strong, nonatomic) IBOutlet UILabel *actionbar;
@end
