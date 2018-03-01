//
//  CalsHistoryCustomCell.m
//  mHealth
//
//  Created by smartone_sn3 on 8/29/14.
//
//

#import "CalsHistoryCustomCell.h"
#import "NSNotificationCenter+MainThread.h"
#import "Utility.h"

@interface CalsHistoryCustomCell()

@end

@implementation CalsHistoryCustomCell

@synthesize calsLabelString;
@synthesize dateLabelString;
@synthesize timeLabelString;
@synthesize foodIdNumber;

- (void)setFoodIdNumber:(NSNumber *)foodIdNumber_new {
    foodIdNumber = foodIdNumber_new;
    self.foodId = foodIdNumber;
}

- (NSNumber *)getFoodIdNumber {
    return self.foodId;
}

- (void)setCalsLabelString:(NSString *)calsLabelString_new {
    if ([calsLabelString_new isEqualToString:@""]) {
        self.calsLabel.text = @"";
        self.calsUnitLabel.text = @"";
        self.dateLabel.text = @"";
        self.timeLabel.text = @"";
        self.detailButton.hidden = YES;
        
    } else {
        
        if (![calsLabelString_new isEqualToString:calsLabelString]){
            calsLabelString = calsLabelString_new;
            self.calsLabel.text = calsLabelString;
        }
        [self.calsLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18]];
        [self.calsUnitLabel setText:[Utility getStringByKey:@"total_calories_cal"]];
        [self.calsUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    }
}

- (void)setTimeLabelString:(NSString *)timeLabelString_new {
    if (![timeLabelString_new isEqualToString:timeLabelString]) {
        timeLabelString = timeLabelString_new;
        self.timeLabel.text = timeLabelString;
    }
    [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
}

- (void)setDateLabelString:(NSString *)dateLabelString_new {
    if (![dateLabelString_new isEqualToString:dateLabelString]) {
        dateLabelString = dateLabelString_new;
        self.dateLabel.text = dateLabelString;
    }
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
}

- (IBAction)showDetailButtonDown:(id)sender {
    NSNumber *jumping_foodId = [NSNumber numberWithInt:[[self getFoodIdNumber]intValue]+1];
    [[NSNotificationCenter defaultCenter]postMainThreadNotificationWithName:@"JumpToHistoryDetail" object:jumping_foodId];
}

@end
