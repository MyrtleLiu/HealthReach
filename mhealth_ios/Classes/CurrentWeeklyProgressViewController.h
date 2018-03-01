//
//  CurrentWeeklyProgressViewController.h
//  mHealth
//
//  Created by gz dev team on 14年2月27日.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PNBarChart.h"
#import "TrainingRecord.h"
#import "DBHelper.h"
#import "Utility.h"
#import "TrainingHistoryTableViewCell.h"
#import "NSString+Utils.h"
#import "SyncWalking.h"
#import "WalkForHealthViewController.h"

@interface CurrentWeeklyProgressViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{

    
    NSInteger currentDayIndex;

}

@property (strong, nonatomic) IBOutlet UIView* bView;

@property (strong, nonatomic) IBOutlet UILabel *actionTitle;

@property (strong, nonatomic) IBOutlet UITableView *historyListView;

@property (strong, nonatomic) IBOutlet PNBarChart *barChart;

@property (strong, nonatomic) IBOutlet UILabel *levelTitle;
@property (strong, nonatomic) IBOutlet UIImageView *levelImg;
@property (strong, nonatomic) IBOutlet UIImageView *levelBGImg;
@property (strong, nonatomic) IBOutlet UILabel *levelText;

@property (strong, nonatomic) IBOutlet UILabel *currentTitle;

@property (strong, nonatomic) IBOutlet UIButton *stopBtn;
@property (strong, nonatomic) IBOutlet UIButton *continueBtn;

@property (strong, nonatomic) NSMutableArray *historyDateLabels;
@property (strong, nonatomic) NSMutableArray *historyDurationLabels;
@property (strong, nonatomic) NSMutableArray *historyDistanceLabels;
@property (strong, nonatomic) NSMutableArray *historyCalsLabels;
@property (strong, nonatomic) NSMutableArray *historyResultLabels;
@property (strong, nonatomic) TrainingRecord *record;
@property (weak, nonatomic) IBOutlet UIView *WaitingView;
@property(nonatomic, retain) IBOutlet UILabel *dataLoading;

-(IBAction)stopTraining:(id)sender;
-(IBAction)toContinue:(id)sender;



@property ( nonatomic) int checkFromHistory;




@end
