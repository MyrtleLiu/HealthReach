//
//  MonthlyCustomCellView.m
//  mHealth
//
//  Created by evan_li on 9/26/14.
//
//

#import "MonthlyCustomCellView.h"
#import "GlobalVariables.h"

@interface MonthlyCustomCellView ()

@property (strong, nonatomic) NSMutableDictionary* alertLevelDict;

@end

@implementation MonthlyCustomCellView

@synthesize SYSString;
@synthesize DIAString;
@synthesize PULString;
@synthesize monthString;

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
    [self.monthLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:10]];

}

- (void)setAllEmpty
{
    [self.SYSLabel setText:@""];
    [self.DIALabel setText:@""];
    [self.PULLabel setText:@""];
    [self.slashLabel setText:@""];
    [self.bpmLabel setText:@""];
    [self.monthLabel setText:@""];
    [self.mmHgLabel setText:@""];
}

-(void)setSYSString:(NSString *)SYS
{
    if ([SYS isEqualToString:@"0"])
        SYS = @"--";
    
    if (![SYS isEqual:SYSString]){
        SYSString = [SYS copy];
        self.SYSLabel.text = SYSString;
        if ([SYS intValue] >= [[self.alertLevelDict objectForKey:@"lsystolic"] intValue])
            [self.SYSLabel setTextColor:[UIColor redColor]];
        else
            [self.SYSLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0f]];
    }
    
    if ([SYS intValue] < 0) {
        [self setAllEmpty];
    }
}

-(void)setDIAString:(NSString *)DIA
{
    if ([DIA isEqualToString:@"0"])
        DIA = @"--";
    
    if (![DIA isEqual:DIAString]){
        DIAString = [DIA copy];
        self.DIALabel.text = DIAString;
    }
}

-(void)setPULString:(NSString *)PUL
{
    if ([PUL isEqualToString:@"0"])
        PUL = @"--";
    
    if (![PUL isEqual:PULString]){
        PULString = [PUL copy];
        self.PULLabel .text = PULString;
    }
}

- (void)setMonthString:(NSString *)monthString_new
{
    if (![monthString_new isEqual:monthString]){
        monthString = [monthString_new copy];
        self.monthLabel.text = monthString;
    }
}


@end
