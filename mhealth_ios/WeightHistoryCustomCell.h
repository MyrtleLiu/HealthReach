//
//  WeightHistoryCustomCell.h
//  mHealth
//
//  Created by sngz on 14-3-13.
//
//

#import <UIKit/UIKit.h>

@interface WeightHistoryCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *warningButton;

@property (copy,nonatomic) NSString *lbsString;
@property (copy,nonatomic) NSString *bmiString;
@property (copy,nonatomic) NSString *dateString;
@property (copy,nonatomic) NSString *timeString;
@property (copy,nonatomic) UIImage *backGroundImage;

@property (copy,nonatomic) NSString *lbsNameString;
@property (weak, nonatomic) IBOutlet UILabel *lbsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiNameLabel;

@end