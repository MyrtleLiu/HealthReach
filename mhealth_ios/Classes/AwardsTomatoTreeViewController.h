//
//  AwardsTomatoTreeViewController.h
//  mHealth
//
//  Created by admin on 2/2/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AwardsTomatoTreeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UILabel *headLabelTextFont;
    IBOutlet UILabel *treeTextFont;
    IBOutlet UILabel *forCasualWalkTextFont;
    IBOutlet UIImageView * treeImageView;
    IBOutlet UILabel *plantnameTextFont;
    IBOutlet UILabel *obtainingdateTextFont;
    IBOutlet UITableView *treetableView;
    IBOutlet UIButton * ok_btn;
    NSString * strTempTemp;
    UIImage * sureImage;
    NSMutableArray * plantArrayTreeLast;
    NSMutableArray*cellHeard;
    
    
    NSMutableArray* newPlantArrayList;

}
@property(nonatomic,strong)NSString* indaxROW;
@property(nonatomic,strong)NSMutableArray *plantArrayCW;
-(IBAction)thisOK:(id)sender;
@end
