//
//  BGHistoryViewController.h
//  mHealth
//
//  Created by sngz on 14-3-27.
//
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>

@interface BGHistoryViewController : BaseViewController<UIScrollViewDelegate>




@property (weak, nonatomic) IBOutlet UILabel *bloodGlucoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftPlate;
@property (weak, nonatomic) IBOutlet UIImageView *rightPlate;
@property (weak, nonatomic) IBOutlet UILabel *dailyRecordLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *dailyRecordLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *weeklyAverageLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *weeklyAverageLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *monthlyAverageLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *monthlyAverageLabel_2;

@property (weak, nonatomic) IBOutlet UILabel *BGValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (strong, nonatomic) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (weak, nonatomic) IBOutlet UITableView *weeklyTableView;
@property (weak, nonatomic) IBOutlet UITableView *monthlyTableView;
@property (weak, nonatomic) IBOutlet UIView *dailyView;
@property (weak, nonatomic) IBOutlet UIView *weeklyView;
@property (weak, nonatomic) IBOutlet UIView *monthlyView;
@property (weak, nonatomic) IBOutlet UIView *WaitingView;

@end
