//
//  TrainingHistoryCell.h
//  mHealth
//
//  Created by smartone_sn on 14-8-18.
//
//

#import <UIKit/UIKit.h>

@interface TrainingHistoryCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *levelImg;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *endDate;
@property (strong, nonatomic) IBOutlet UILabel *status;

@end
