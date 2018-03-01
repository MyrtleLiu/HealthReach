//
//  CalsHistoryViewController.h
//  mHealth
//
//  Created by smartone_sn3 on 8/29/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CalsHistoryViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *datalist;
@property (weak, nonatomic) IBOutlet UITableView *caloriesHistoryTable;

@property (weak, nonatomic) IBOutlet UILabel *calsLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UILabel *newestCalsValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *newestCalsUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *waitingView;

@end
