//
//  CalsHistoryDetailCustomCell.h
//  mHealth
//
//  Created by smartone_sn3 on 9/2/14.
//
//

#import "HJManagedImageV.h"
#import <UIKit/UIKit.h>

@interface CalsHistoryDetailCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HJManagedImageV *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantityNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantityUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodCaloriesNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodCaloriesUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *timesLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantityBigNumberLabel;
@property (weak, nonatomic) NSNumber *foodId;

@property (copy, nonatomic) NSNumber *foodIdNumber;
@property (copy, nonatomic) NSString *foodNameString;
@property (copy, nonatomic) NSString *foodQuantityString;
@property (copy, nonatomic) NSString *foodCaloriesString;
@property (copy, nonatomic) NSString *foodUnitString;

@end
