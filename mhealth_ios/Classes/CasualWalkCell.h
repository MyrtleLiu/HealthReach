//
//  CasualWalkCell.h
//  mHealth
//
//  Created by smartone_sn on 14-8-18.
//
//

#import <UIKit/UIKit.h>

@interface CasualWalkCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) IBOutlet UILabel *duration;
@property (strong, nonatomic) IBOutlet UILabel *cals;

@property (strong, nonatomic) IBOutlet UIImageView *arrow_info;


@property (strong, nonatomic) IBOutlet UILabel *km_unit;
@property (strong, nonatomic) IBOutlet UILabel *cals_unit;

@end
