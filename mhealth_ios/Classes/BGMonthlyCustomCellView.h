//
//  BGMonthlyCustomCellView.h
//  mHealth
//
//  Created by evan_li on 9/30/14.
//
//

#import <UIKit/UIKit.h>

@interface BGMonthlyCustomCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *BGFastingValueLabel;
@property (copy, nonatomic) NSString *BGFastingValueString;
@property (weak, nonatomic) IBOutlet UILabel *BGBeforeValueLabel;
@property (copy, nonatomic) NSString *BGBeforeValueString;
@property (weak, nonatomic) IBOutlet UILabel *BGAfterValueLabel;
@property (copy, nonatomic) NSString *BGAfterValueString;
@property (weak, nonatomic) IBOutlet UILabel *BGNotSpecifiedValueLabel;
@property (copy, nonatomic) NSString *BGNotSpecifiedValueString;

@property (weak, nonatomic) IBOutlet UILabel *fastingLabel;
@property (copy, nonatomic) NSString *fastingString;
@property (weak, nonatomic) IBOutlet UILabel *beforeMealLabel;
@property (copy, nonatomic) NSString *beforeMealString;
@property (weak, nonatomic) IBOutlet UILabel *afterMealLabel;
@property (copy, nonatomic) NSString *afterMealString;
@property (weak, nonatomic) IBOutlet UILabel *notSpecifiedLabel;
@property (weak, nonatomic) NSString *notSpecifiedString;

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (copy, nonatomic) NSString *monthString;

//set mmolString=@"" will set all label=@"" in this cell
@property (copy, nonatomic) NSString *mmolString;

@end
