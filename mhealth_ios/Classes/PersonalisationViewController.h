//
//  PersonalisationViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-8-29.
//
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
@interface PersonalisationViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIButton *personalinfo;
@property (weak, nonatomic) IBOutlet UIButton *loginmethod;
@property (weak, nonatomic) IBOutlet UIButton *presetlevel;
@property (weak, nonatomic) IBOutlet UIButton *language;

@property (weak, nonatomic) IBOutlet UILabel *actionbar;



@end
