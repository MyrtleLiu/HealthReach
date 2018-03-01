//
//  AwardsGoldViewController.h
//  mHealth
//
//  Created by admin on 15/1/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AwardsGoldViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel * headLabelTextFont;
    IBOutlet UILabel * goldMedaisTextFont;
    IBOutlet UIImageView *awardsImageView;
    IBOutlet UILabel * programmePeriodTextFont;
    IBOutlet UILabel * dateTextFont;
    IBOutlet UITableView * awardsTableView;
    IBOutlet UITableView *trophyTableView;
    IBOutlet UIButton * ok_btn;
    IBOutlet UILabel * forTrainingTrpgrammeTextFont;
    UIImage * shareImage;
 
    NSString *strTempTemp;
    NSMutableArray *newPlantArrayList;
    
}
@property(nonatomic,strong)NSString * plantStr;
@property(nonatomic,strong)NSMutableArray *plantArrayTP;
-(IBAction)thisOK:(id)sender;
@end
