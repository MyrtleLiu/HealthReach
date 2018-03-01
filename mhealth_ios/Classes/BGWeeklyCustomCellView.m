//
//  BGWeeklyCustomCellView.m
//  mHealth
//
//  Created by evan_li on 9/30/14.
//
//

#import "BGWeeklyCustomCellView.h"
#import "GlobalVariables.h"
#import "Utility.h"

@interface BGWeeklyCustomCellView ()

@property (strong, nonatomic) NSMutableDictionary* alertLevelDict;

@end

@implementation BGWeeklyCustomCellView

@synthesize BGFastingValueString;
@synthesize BGBeforeValueString;
@synthesize BGAfterValueString;
@synthesize BGNotSpecifiedValueString;

@synthesize fastingString;
@synthesize beforeMealString;
@synthesize afterMealString;
@synthesize notSpecifiedString;

@synthesize weeknoString;
@synthesize weekDetailString;

@synthesize mmolString;

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.BGFastingValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    [self.BGBeforeValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    [self.BGAfterValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    [self.BGNotSpecifiedValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    
    [self.weeknoLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.weekDetailLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.fastingLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
    [self.beforeMealLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
    [self.afterMealLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
    [self.notSpecifiedLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];

    
    [self.fastingLabel setText:[Utility getStringByKey:@"fasting"]];
    [self.beforeMealLabel setText:[Utility getStringByKey:@"before_meal"]];
    [self.afterMealLabel setText:[Utility getStringByKey:@"after_meal"]];
    [self.notSpecifiedLabel setText:[Utility getStringByKey:@"not_specified"]];
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

- (void)setBGNotSpecifiedValueString:(NSString *)BGNotSpecifiedValueString_new
{
    NSLog(@"!!BGNotSpecified:%@",BGNotSpecifiedValueString_new);
    if ([BGNotSpecifiedValueString_new isEqualToString:@"0"]||(BGNotSpecifiedValueString_new==nil))
        BGNotSpecifiedValueString_new = @"--";
    
    if (![BGNotSpecifiedValueString_new isEqualToString:BGNotSpecifiedValueString]) {
        BGNotSpecifiedValueString = [BGNotSpecifiedValueString_new copy];
        [self.BGNotSpecifiedValueLabel setText:BGNotSpecifiedValueString];
    }
}

- (void)setWeekDetailString:(NSString *)weekDetailString_new
{
    if (![weekDetailString_new isEqualToString:weekDetailString]) {
        weekDetailString = [weekDetailString_new copy];
        [self.weekDetailLabel setText:weekDetailString];
    }
}

- (void)setWeeknoString:(NSString *)weeknoString_new
{
    if (![weeknoString_new isEqualToString:weeknoString]) {
        weeknoString = [weeknoString_new copy];
        [self.weeknoLabel setText:weeknoString];
    }
}

@end
