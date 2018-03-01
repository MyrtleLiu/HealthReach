//
//  WalkHistoryTableViewCell.h
//  mHealth
//
//  Created by smartone_sn2 on 14-8-27.
//
//

#import <UIKit/UIKit.h>

@interface WalkHistoryTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) IBOutlet UILabel *duration;
@property (strong, nonatomic) IBOutlet UILabel *cals;

@property (strong, nonatomic) IBOutlet UILabel *km_unit;
@property (strong, nonatomic) IBOutlet UILabel *cals_unit;

@end
