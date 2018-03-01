//
//  WeightWeekHistoryCustomCell.h
//  mHealth
//
//  Created by evan_li on 10/9/14.
//
//

#import <UIKit/UIKit.h>

@interface WeightWeekHistoryCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeknoLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekDetailLabel;

@property (copy, nonatomic) NSString *lbsString;
@property (copy, nonatomic) NSString *bmiString;
@property (copy, nonatomic) NSString *weeknoString;
@property (copy, nonatomic) NSString *weekDetailString;

@property (copy,nonatomic) NSString *lbsNameString;
@property (weak, nonatomic) IBOutlet UILabel *lbsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiNameLabel;

@end
