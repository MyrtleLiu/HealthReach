//
//  BGTitleCustomCell.m
//  mHealth
//
//  Created by sngz on 14-3-28.
//
//

#import "BGTitleCustomCell.h"
#import "GlobalVariables.h"

@interface  BGTitleCustomCell()

@property (strong, nonatomic) NSMutableDictionary* alertLevelDict;

@end

@implementation BGTitleCustomCell

@synthesize dateLabel;
@synthesize dateString;
@synthesize timeLabel;
@synthesize timeString;
@synthesize BGValueLabel;
@synthesize BGValueString;
@synthesize typeLabel;
@synthesize typeString;

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.BGValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    [self.mmolLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.typeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
}

-(void)setMmolString:(NSString *)mmolStr{
    if ([mmolStr isEqualToString:@""]){
        self.mmolLabel.text = @"";
        self.dateLabel.text = @"";
        self.timeLabel.text = @"";
        self.BGValueLabel.text = @"";
        self.typeLabel.text = @"";
    }
}

-(void)setBGValueString:(NSString *)BGValue{
    if (![BGValue isEqualToString:BGValueString]){
        BGValueString = [BGValue copy];
        self.BGValueLabel.text = BGValueString;
    }
    [self.BGValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
    [self.mmolLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
}

-(void)setDateString:(NSString *)date{
    if (![date isEqualToString:dateString]){
        dateString = [date copy];
        self.dateLabel.text = dateString;
    }
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
}

-(void)setTimeString:(NSString *)time{
    if (![time isEqualToString:timeString]){
        timeString = [time copy];
        self.timeLabel.text = timeString;
    }
    [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
}

-(void)setTypeString:(NSString *)type{
    if (![type isEqualToString:typeString]){
        typeString = [type copy];
        self.typeLabel.text = typeString;
    }
    [self.typeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:12]];
}
@end
