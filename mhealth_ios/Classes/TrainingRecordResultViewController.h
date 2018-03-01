//
//  TrainingRecordResultViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-8-27.
//
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
#import "TrainingRecord.h"

@interface TrainingRecordResultViewController : BaseViewController


@property (strong, nonatomic) IBOutlet UITableView *historyListView;

@property (strong, nonatomic) IBOutlet UILabel *dateTitle;
@property (strong, nonatomic) IBOutlet UIImageView *levelImage;
@property (strong, nonatomic) IBOutlet NSString *dateStr;
@property (nonatomic) NSInteger level;
@property (nonatomic) long startTime;

@property (strong, nonatomic) IBOutlet NSString *recordId;
@property (strong, nonatomic) TrainingRecord *record;


@property (strong, nonatomic) NSMutableArray *cwResultArray;

@property (strong, nonatomic) IBOutlet UILabel *actionbar;

@property ( nonatomic) NSInteger indexMark;
@property ( nonatomic) NSInteger checkFromHistory;


@end
