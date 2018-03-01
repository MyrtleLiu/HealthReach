//
//  WeightMonthHistoryCustomCell.m
//  mHealth
//
//  Created by evan_li on 10/9/14.
//
//

#import "WeightMonthHistoryCustomCell.h"
#import "Utility.h"

@interface WeightMonthHistoryCustomCell ()

@end

@implementation WeightMonthHistoryCustomCell

@synthesize bmiString;
@synthesize lbsString;
@synthesize monthString;

-(void)setLbsNameString:(NSString *)lbsNameStr{
    
}

-(void)setLbsString:(NSString *)LBS{
    if ([LBS isEqualToString:@""]){
        self.lbsNameLabel.text = @"";
        self.bmiNameLabel.text = @"";
        self.lbsLabel.text = @"";
        self.bmiLabel.text = @"";
        self.monthLabel.text = @"";
    } else {
        LBS = [Utility getRoundFloatNSString:LBS maximumFractionDigits:0];
        
        if (([LBS isEqualToString:@"0"])||([LBS isEqualToString:@"0.0"]))
            LBS = @"--";
        
        if (![LBS isEqual:lbsString]){
            lbsString = [LBS copy];
            self.lbsLabel.text = lbsString;
        }
    }
    
}

-(void)setBmiString:(NSString *)BMI{
    BMI = [Utility getRoundFloatNSString:BMI maximumFractionDigits:1];
    
    if (([BMI isEqualToString:@"0"])||([BMI isEqualToString:@"0.0"]))
        BMI = @"--";

    if (![BMI isEqual:bmiString]) {
        bmiString = [BMI copy];
        self.bmiLabel.text = bmiString;
    }
    
}

-(BOOL)bmiWarning:(NSString *)bmi{
    float bmiValue = [bmi floatValue];
    if ((bmiValue>=18.5)&&(bmiValue<=22.9)){
        return FALSE;
    }
    return TRUE;
}

- (void)setMonthString:(NSString *)monthString_new
{
    if (![monthString isEqualToString:monthString_new]){
        monthString = [monthString_new copy];
        self.monthLabel.text = monthString;
    }
}

@end
