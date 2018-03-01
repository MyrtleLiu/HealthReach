//
//  WeightHistoryViewController.h
//  mHealth
//
//  Created by sngz on 14-3-13.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WeightHistoryViewController : BaseViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *weightTitle;
@property (weak, nonatomic) IBOutlet UILabel *historyTitle;



@property (weak, nonatomic) IBOutlet UILabel *LBSLabel;
@property (weak, nonatomic) IBOutlet UILabel *lbsUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *BMILabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiUnitLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong,nonatomic) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (weak, nonatomic) IBOutlet UITableView *weeklyTableView;
@property (weak, nonatomic) IBOutlet UITableView *monthlyTableView;

@property (weak, nonatomic) IBOutlet UIImageView *leftPlate;
@property (weak, nonatomic) IBOutlet UIImageView *rightPlate;

@property (weak, nonatomic) IBOutlet UIView *measurementRecordView;
@property (weak, nonatomic) IBOutlet UILabel *measurementRecordLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *measurementRecordLabel_2;

@property (weak, nonatomic) IBOutlet UIView *monthlyAverageView;
@property (weak, nonatomic) IBOutlet UILabel *monthlyAverageLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *monthlyAverageLabel_2;

@property (weak, nonatomic) IBOutlet UIView *weeklyAverageView;
@property (weak, nonatomic) IBOutlet UILabel *weeklyAverageLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *weeklyAverageLabel_2;

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel_3;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel_4;
@property (weak, nonatomic) IBOutlet UIButton *warningButton;
@property (weak, nonatomic) IBOutlet UIButton *bmiInfoButton;

@property (weak, nonatomic) IBOutlet UIView *waitingView;

@end