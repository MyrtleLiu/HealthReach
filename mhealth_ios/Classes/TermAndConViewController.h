//
//  TermAndConViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-9-12.
//
//

#import "BaseViewController.h"
#import "RTLabel.h"
#import "HomeViewControllerFirst.h"


@interface TermAndConViewController : BaseViewController<RTLabelDelegate>





@property (strong, nonatomic) IBOutlet UILabel *topText;

@property (strong, nonatomic) IBOutlet RTLabel *tx1;
@property (strong, nonatomic) IBOutlet RTLabel *tx2;
@property (strong, nonatomic) IBOutlet RTLabel *tx3;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;

@property (strong, nonatomic) IBOutlet UIImageView *toplogo;

@end
