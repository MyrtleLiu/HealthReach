//
//  BPHistoryViewController.h
//  mHealth
//
//  Created by gz dev team on 14年1月17日.
//
//

#import "BPViewController.h"
#import "HistoryTitleCustomCell.h"
#import <UIKit/UIKit.h>

@interface BPHistoryViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property(nonatomic, retain) IBOutlet UILabel *bloodpressureLabel;
@property(nonatomic, retain) IBOutlet UILabel *historyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *rightPlate;
@property (weak, nonatomic) IBOutlet UIImageView *leftPlate;
@property (weak, nonatomic) IBOutlet UILabel *dailyRecordLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *dailyRecordLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *weeklyAverageLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *weeklyAverageLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *monthlyAverageLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *monthlyAverageLabel_2;

@property (weak, nonatomic) IBOutlet UILabel *sysLabel;
@property (weak, nonatomic) IBOutlet UILabel *diaLabel;
@property (weak, nonatomic) IBOutlet UILabel *bpUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *pulValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *pulUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *slashLabel;

@property (strong, nonatomic) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UITableView *HistoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *weeklyTableView;
@property (weak, nonatomic) IBOutlet UITableView *monthlyTableView;
@property (weak, nonatomic) IBOutlet UIView *monthlyView;
@property (weak, nonatomic) IBOutlet UIView *weeklyView;
@property (weak, nonatomic) IBOutlet UIView *dailyView;

@property (weak, nonatomic) IBOutlet UIView *WaitingView;


//-(void)refreshWeeklyData;

@end