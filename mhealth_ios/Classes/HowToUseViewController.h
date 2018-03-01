//
//  HowToUseViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-9-1.
//
//

#import "BaseViewController.h"

@interface HowToUseViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *bptx;
@property (strong, nonatomic) IBOutlet UILabel *bgtx;
@property (strong, nonatomic) IBOutlet UILabel *ecgtx;
@property (strong, nonatomic) IBOutlet UILabel *weighttx;
@property (strong, nonatomic) IBOutlet UILabel *calendartx;
@property (strong, nonatomic) IBOutlet UILabel *walktx;
@property (strong, nonatomic) IBOutlet UILabel *caltx;

@property (strong, nonatomic) IBOutlet UILabel *actionbar;




@property (strong, nonatomic) IBOutlet UIButton *vedioBP;
@property (strong, nonatomic) IBOutlet UIButton *vedioBG;
@property (strong, nonatomic) IBOutlet UIButton *vedioWEIGHT;
@property (strong, nonatomic) IBOutlet UIButton *vedioCALENDAR;

@property (strong, nonatomic) IBOutlet UIButton *vedioWALK;
@property (strong, nonatomic) IBOutlet UIButton *vedioFOOD;





@end
