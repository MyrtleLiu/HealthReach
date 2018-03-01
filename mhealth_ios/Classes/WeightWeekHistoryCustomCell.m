//
//  WeightWeekHistoryCustomCell.m
//  mHealth
//
//  Created by evan_li on 10/9/14.
//
//

#import "WeightWeekHistoryCustomCell.h"
#import "Utility.h"

@interface WeightWeekHistoryCustomCell ()

@end

@implementation WeightWeekHistoryCustomCell

@synthesize bmiString;
@synthesize lbsString;
@synthesize weeknoString;
@synthesize weekDetailString;

-(void)setLbsNameString:(NSString *)lbsNameStr{
    
}

-(void)setLbsString:(NSString *)LBS{
    
    if ([LBS isEqualToString:@""]){
        self.lbsNameLabel.text = @"";
        self.bmiNameLabel.text = @"";
        self.lbsLabel.text = @"";
        self.bmiLabel.text = @"";
        self.weeknoLabel.text = @"";
        self.weekDetailLabel.text=@"";
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

- (void)setWeeknoString:(NSString *)weeknoString_new
{
    if (![weeknoString isEqualToString:weeknoString_new]) {
        weeknoString = [weeknoString_new copy];
        self.weeknoLabel.text = weeknoString;
    }
}

- (void)setWeekDetailString:(NSString *)weekDetailString_new
{
    if (![weekDetailString isEqualToString:weekDetailString_new]) {
        weekDetailString = [weekDetailString_new copy];
        self.weekDetailLabel.text = weekDetailString;
    }
}

@end
