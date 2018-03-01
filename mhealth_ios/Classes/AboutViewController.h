//
//  AboutViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-9-1.
//
//

#import "BaseViewController.h"
#import "RTLabel.h"

@interface AboutViewController : BaseViewController<RTLabelDelegate>

@property (strong, nonatomic) IBOutlet UILabel *actionbar;

@property (strong, nonatomic) IBOutlet UILabel *topText;
@property (strong, nonatomic) IBOutlet UILabel *bottomText;

@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;


@property (strong, nonatomic) IBOutlet RTLabel *tx1;
@property (strong, nonatomic) IBOutlet RTLabel *tx2;
@property (strong, nonatomic) IBOutlet RTLabel *tx3;
@property (strong, nonatomic) IBOutlet RTLabel *tx4;
@property (strong, nonatomic) IBOutlet RTLabel *tx5;
@property (strong, nonatomic) IBOutlet RTLabel *tx6;


@property (strong, nonatomic) IBOutlet UILabel *verno;


@end
