//
//  BGMonthlyCustomCellView.m
//  mHealth
//
//  Created by evan_li on 9/30/14.
//
//

#import "BGMonthlyCustomCellView.h"
#import "GlobalVariables.h"
#import "Utility.h"

@interface BGMonthlyCustomCellView ()

@property (strong, nonatomic) NSMutableDictionary* alertLevelDict;

@end

@implementation BGMonthlyCustomCellView

@synthesize BGFastingValueString;
@synthesize BGBeforeValueString;
@synthesize BGAfterValueString;
@synthesize BGNotSpecifiedValueString;
@synthesize fastingString;
@synthesize beforeMealString;
@synthesize afterMealString;
@synthesize notSpecifiedString;
@synthesize monthString;

@synthesize mmolString;

- (void)prepareForReuse
{
    [super prepareForReuse];
    NSLog(@"!!prepareForReuse Month!!");
    [self.BGFastingValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    [self.BGBeforeValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    [self.BGAfterValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    [self.BGNotSpecifiedValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];

    [self.monthLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.fastingLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
    [self.beforeMealLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
    [self.afterMealLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
    [self.notSpecifiedLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
    [self.fastingLabel setText:[Utility getStringByKey:@"fasting"]];
    [self.notSpecifiedLabel setText:[Utility getStringByKey:@"not_specified"]];
    [self.beforeMealLabel setText:[Utility getStringByKey:@"before_meal"]];
    [self.afterMealLabel setText:[Utility getStringByKey:@"after_meal"]];
}

- (void)setBGFastingValueString:(NSString *)BGFastingValueString_new
{
    if ([BGFastingValueString_new isEqualToString:@"0"]||(BGFastingValueString_new==nil))
        BGFastingValueString_new = @"--";
    
    if (![BGFastingValueString_new isEqualToString:BGFastingValueString]) {
        BGFastingValueString = [BGFastingValueString_new copy];
        [self.BGFastingValueLabel setText:BGFastingValueString];
    }
        
}

- (void)setBGBeforeValueString:(NSString *)BGBeforeValueString_new
{
    if ([BGBeforeValueString_new isEqualToString:@"0"]||(BGBeforeValueString_new==nil))
        BGBeforeValueString_new = @"--";
    
    if (![BGBeforeValueString_new isEqualToString:BGBeforeValueString]) {
        BGBeforeValueString = [BGBeforeValueString_new copy];
        [self.BGBeforeValueLabel setText:BGBeforeValueString];
    }
    
}

- (void)setBGAfterValueString:(NSString *)BGAfterValueString_new
{
    if ([BGAfterValueString_new isEqualToString:@"0"]||(BGAfterValueString_new==nil))
        BGAfterValueString_new = @"--";
    
    if (![BGAfterValueString_new isEqualToString:BGAfterValueString]) {
        BGAfterValueString = [BGAfterValueString_new copy];
        [self.BGAfterValueLabel setText:BGAfterValueString];
    }
    
}

- (void)setMonthString:(NSString *)monthString_new
{
    if (![monthString_new isEqualToString:monthString]) {
        monthString = [monthString_new copy];
        [self.monthLabel setText:monthString];
    }
}

- (void)setBGNotSpecifiedValueString:(NSString *)notSpecifiedString_new
{
    if ([notSpecifiedString_new isEqualToString:@"0"]||(notSpecifiedString_new==nil))
        notSpecifiedString_new = @"--";
    
    if (![notSpecifiedString_new isEqualToString:BGNotSpecifiedValueString]) {
        BGNotSpecifiedValueString = [notSpecifiedString_new copy];
        [self.BGNotSpecifiedValueLabel setText:BGNotSpecifiedValueString];
    }
}

@end
