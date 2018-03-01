//
//  NoNetWorkViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-11-18.
//
//

#import "BaseViewController.h"

@interface NoNetWorkViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIButton *okBtn;

@property (strong, nonatomic) IBOutlet UILabel *noNetworkText;

@property (strong, nonatomic) IBOutlet UIImageView *titleImage;

@property (strong, nonatomic) IBOutlet UIView *barView;

@property (strong, nonatomic) IBOutlet UIView *shadowView;

@property (nonatomic) NSString *link;



@end
