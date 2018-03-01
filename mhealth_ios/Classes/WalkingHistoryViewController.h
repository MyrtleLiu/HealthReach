//
//  WalkingHistoryViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-8-18.
//
//

#import "BaseViewController.h"
#import "TrainingHistoryCell.h"
#import "CasualWalkCell.h"
#import "DBHelper.h"
#import "NSString+Utils.h"
#import "Utility.h"
#import "WalkingResultViewController.h"
#import "TrainingRecord.h"

@interface WalkingHistoryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{

    int currentViewIndex;  //0.training 1.casualwalk
    IBOutlet UIButton* fristTimepictureofTP;
    
}

@property (strong, nonatomic) IBOutlet UITableView *historyListView;

@property (strong, nonatomic) IBOutlet UIButton *trainBtn;
@property (strong, nonatomic) IBOutlet UIButton *cwBtn;
@property (strong, nonatomic) IBOutlet UIView *line1Btn;
@property (strong, nonatomic) IBOutlet UIView *line2Btn;

@property (strong, nonatomic) IBOutlet UILabel *histroyTitle;
@property (strong, nonatomic) IBOutlet UILabel *actionTitle;

@property (strong, nonatomic) NSMutableArray *trainingHistory;
@property (strong, nonatomic) NSMutableArray *cwHistory;


-(IBAction)viewTraining:(id)sender;

-(IBAction)viewCasualWalk:(id)sender;
-(IBAction)fristTimeofTPClick:(id)sender;
@end
