//
//  CalsHistoryCustomCell.h
//  mHealth
//
//  Created by smartone_sn3 on 8/29/14.
//
//

#import <UIKit/UIKit.h>

@interface CalsHistoryCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *calsLabel;
@property (weak, nonatomic) IBOutlet UILabel *calsUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) NSNumber *foodId;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@property (copy, nonatomic) NSString *calsLabelString;
@property (copy, nonatomic) NSString *dateLabelString;
@property (copy, nonatomic) NSString *timeLabelString;
@property (copy, nonatomic) NSNumber *foodIdNumber;

@end
