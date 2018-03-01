//
//  WeeklyCustomCellView.m
//  mHealth
//
//  Created by evan_li on 9/26/14.
//
//

#import "WeeklyCustomCellView.h"
#import "GlobalVariables.h"
#import "Utility.h"

@interface WeeklyCustomCellView ()

@property (strong, nonatomic) NSMutableDictionary* alertLevelDict;

@end

@implementation WeeklyCustomCellView

@synthesize SYSString;
@synthesize DIAString;
@synthesize PULString;
@synthesize weeknoString;
@synthesize weekDetailString;

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
    [self.weeknoLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    [self.weekDetailLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];
    
}

- (void)setAllEmpty
{
    [self.SYSLabel setText:@""];
    [self.DIALabel setText:@""];
    [self.PULLabel setText:@""];
    [self.slashLabel setText:@""];
    [self.bpmLabel setText:@""];
    [self.weeknoLabel setText:@""];
    [self.weekDetailLabel setText:@""];
    [self.mmHgLabel setText:@""];
}

-(void)setSYSString:(NSString *)SYS
{
    if ([SYS isEqualToString:@"0"]) {
        SYS = @"--";
    }

    if (![SYS isEqual:SYSString]) {
        SYSString = [SYS copy];
        self.SYSLabel.text = SYSString;
    }
    
    if ([SYS intValue] < 0) {
        [self setAllEmpty];
    }
}

-(void)setDIAString:(NSString *)DIA
{
    if ([DIA isEqualToString:@"0"]) {
        DIA = @"--";
    }
    
    if (![DIA isEqual:DIAString]) {
        DIAString = [DIA copy];
        self.DIALabel.text = DIAString;
    }
}

-(void)setPULString:(NSString *)PUL
{
    if ([PUL isEqualToString:@"0"]) {
        PUL = @"--";
        [self.PULLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
    }

    if (![PUL isEqual:PULString]) {
        PULString = [PUL copy];
        self.PULLabel .text = PULString;
    }
}

-(void)setWeeknoString:(NSString *)weeknoString_new
{
    if (![weeknoString_new isEqual:weeknoString]){
        weeknoString = [weeknoString_new copy];
        self.weeknoLabel.text = weeknoString;
    }
}

-(void)setWeekDetailString:(NSString *)weekDetailString_new
{
    if (![weekDetailString_new isEqual:weekDetailString]){
        weekDetailString = [weekDetailString_new copy];
        self.weekDetailLabel.text = weekDetailString;
    }
}

@end
