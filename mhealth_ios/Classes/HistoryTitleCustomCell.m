//
//  HistoryTitleCustomCell.m
//  mHealth
//
//  Created by gz dev team on 14年1月30日.
//
//

#import "GlobalVariables.h"
#import "HistoryTitleCustomCell.h"

@interface HistoryTitleCustomCell ()

@property (strong, nonatomic) NSMutableDictionary* alertLevelDict;

@end

@implementation HistoryTitleCustomCell

@synthesize SYSString;
@synthesize DIAString;
@synthesize PULString;
@synthesize dateString;
@synthesize timeString;

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self.slashLabel setText:@"/"];
    [self.bpmLabel setText:@"bpm"];
    [self.mmHgLabel setText:@"mmhg"];
    
    [self.SYSLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18]];
    [self.DIALabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18]];
    [self.PULLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18]];
    [self.slashLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18]];
    [self.mmHgLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.bpmLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];

}
- (void)setAllEmpty
{
    [self.SYSLabel setText:@""];
    [self.DIALabel setText:@""];
    [self.PULLabel setText:@""];
    [self.slashLabel setText:@""];
    [self.bpmLabel setText:@""];
    [self.mmHgLabel setText:@""];
    [self.dateLabel setText:@""];
    [self.timeLabel setText:@""];
}


-(void)setSlashString:(NSString *)slashStr
{
    if ([slashStr isEqualToString:@""]){
        [self setAllEmpty];
    }
}

-(void)setSYSString:(NSString *)SYS
{
    if (![SYS isEqual:SYSString]){
        SYSString = [SYS copy];
        self.SYSLabel.text = SYSString;
    }
    
    if ([SYS isEqualToString:@"0"])
        [self setAllEmpty];
}

-(void)setDIAString:(NSString *)DIA
{
    if (![DIA isEqual:DIAString]){
        DIAString = [DIA copy];
        self.DIALabel.text = DIAString;
    }
    
    if ([DIA isEqualToString:@"0"])
        [self setAllEmpty];
}

-(void)setPULString:(NSString *)PUL
{
    if (![PUL isEqual:PULString]){
        PULString = [PUL copy];
        self.PULLabel .text = PULString;
    }
 
    if ([PUL isEqualToString:@"0"])
        [self setAllEmpty];
}

-(void)setDateString:(NSString *)date
{
    if (![date isEqual:dateString]){
        dateString = [date copy];
        self.dateLabel.text = dateString;
    }
}

-(void)setTimeString:(NSString *)time
{
    if (![time isEqual:timeString]){
        timeString = [time copy];
        self.timeLabel.text = timeString;
    }
}

@end