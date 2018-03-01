//
//  AwardsViewController.h
//  mHealth
//
//  Created by admin on 22/1/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AwardsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *headLabelTextFont;
    IBOutlet UIButton *buttonTP;
    IBOutlet UILabel *buttonTPLabelTextFont;
    IBOutlet UILabel *buttonCWLabelTextFont;
    
    IBOutlet UIButton *buttonCW;
    //TPVIEW
    IBOutlet UIView *viewOfTP;
    IBOutlet UILabel *theLongLabelTextFont1;
    IBOutlet UILabel *theLongLabelTextFont2;
    IBOutlet UILabel *cashCouponTextFont;
    IBOutlet UIButton *detailsofTP;
    IBOutlet UILabel *trophyTextFont;
    IBOutlet UILabel *diamondTextFont;
    IBOutlet UILabel *goldTextFont;
    IBOutlet UILabel *silverTextFont;
    IBOutlet UILabel *bronzeTextFont;
    IBOutlet UILabel *trophyNumber;
    IBOutlet UILabel *diamondNumber;
    IBOutlet UILabel *goldNumber;
    IBOutlet UILabel *silverNumber;
    IBOutlet UILabel *bronzeNumber;
    IBOutlet UILabel *_gantanhao;
    
    IBOutlet UILabel *dataOnlyTP;


    
    
    //CWVIEW
    int howmanyTomatoTree;
    int howmanyLemonTree;
    int howmanyAppleTree;
    int howmanyOrangeTree;
    IBOutlet UIView *viewOfCW;
    IBOutlet UILabel *theCWlongLabelTextFont;
    IBOutlet UIButton *detailsofCW;
    IBOutlet UITableView *tableViewWithCW;
    
    UIImage *tomatoBlackImage;
    UIImage *lemonBlackImage;
    UIImage *orangeBlackImage;
    UIImage *rightarrow;
    
    UIImage *tpButtonImage;
    UIImage *cwButtonImage;
     IBOutlet UIImageView *imageViewx0;
    IBOutlet  UIImageView *imageViewx1;
   IBOutlet   UIImageView *imageViewx2;
   IBOutlet   UIImageView *imageViewx3;
    IBOutlet  UIImageView *imageViewx4;
    NSString *strTempTemp;
    
    
    IBOutlet UILabel *dataOnlyCW;

    
}
@property (nonatomic,strong) NSMutableArray * plantArrayCW;
@property (nonatomic,strong) NSMutableArray * plantArrayTP;
@property (nonatomic,strong) NSMutableArray * plantArrayT_D;
@property (nonatomic,strong) NSMutableArray * plantArrayT_G;
@property (nonatomic,strong) NSMutableArray * plantArrayT_S;
@property (nonatomic,strong) NSMutableArray * plantArrayT_B;


@property (nonatomic) int checkTab;


-(IBAction)toTPVIew:(id)sender;
-(IBAction)toCWVIew:(id)sender;


-(IBAction)detailsTP:(id)sender;
-(IBAction)detailsCW:(id)sender;

-(IBAction)toTrophyButton:(id)sender;
-(IBAction)toDiamondButton:(id)sender;
-(IBAction)toGoldButton:(id)sender;
-(IBAction)toSilverButton:(id)sender;
-(IBAction)toBronzeButton:(id)sender;






@end
