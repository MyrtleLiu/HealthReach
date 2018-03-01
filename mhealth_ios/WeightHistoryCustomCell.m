//
//  WeightHistoryCustomCell.m
//  mHealth
//
//  Created by sngz on 14-3-13.
//
//

#import "WeightHistoryCustomCell.h"
#import "Utility.h"

@interface WeightHistoryCustomCell()

@end

@implementation WeightHistoryCustomCell

@synthesize bmiString;
@synthesize lbsString;
@synthesize dateString;
@synthesize timeString;
@synthesize backGroundImage;
@synthesize warningButton;

-(void)setLbsNameString:(NSString *)lbsNameStr{
    
}

-(void)setBackGroundImage:(UIImage *)backGround{
    if (![backGround isEqual:backGroundImage]){
        backGroundImage = [backGround copy];
        self.backGroundImageView.image = backGroundImage;
    }
}

-(void)setLbsString:(NSString *)LBS{
    if ([LBS isEqualToString:@""]){
        self.lbsNameLabel.text = @"";
        self.bmiNameLabel.text = @"";
        self.lbsLabel.text = @"";
        self.bmiLabel.text = @"";
        self.warningButton.hidden = TRUE;
        self.timeLabel.text = @"";
        self.dateLabel.text = @"";
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
        if (![self bmiWarning:BMI]) {
            self.warningButton.hidden = TRUE;
//            self.bmiLabel.textColor = [UIColor blackColor];
        }
        else {
//            self.bmiLabel.textColor = [UIColor redColor];
            self.warningButton.hidden = FALSE;
        }
    }
    
}

-(BOOL)bmiWarning:(NSString *)bmi{
    float bmiValue = [bmi floatValue];
    if ((bmiValue>=18.5)&&(bmiValue<=22.9)){
        return FALSE;
    }
    return TRUE;
}


-(void)setDateString:(NSString *)date{
    if (![date isEqual:dateString]){
        dateString = [date copy];
        self.dateLabel.text = dateString;
    }
}

-(void)setTimeString:(NSString *)time{
    if (![time isEqual:timeString]){
        timeString = [time copy];
        self.timeLabel.text = timeString;
    }
}

@end
