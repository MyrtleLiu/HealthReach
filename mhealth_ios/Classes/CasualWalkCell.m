//
//  CasualWalkCell.m
//  mHealth
//
//  Created by smartone_sn on 14-8-18.
//
//

#import "CasualWalkCell.h"
#import "Utility.h"

@implementation CasualWalkCell

- (void)awakeFromNib
{
    // Initialization code
    
    [self.date setFont:[UIFont fontWithName:font65 size:15]];
    [self.distance setFont:[UIFont fontWithName:font65 size:18]];
    [self.duration setFont:[UIFont fontWithName:font65 size:18]];
    [self.cals setFont:[UIFont fontWithName:font65 size:18]];
    
    [self.km_unit setFont:[UIFont fontWithName:font77 size:10]];
    [self.cals_unit setFont:[UIFont fontWithName:font77 size:10]];
    
 
//    [self.cals_unit setFont:[UIFont fontWithName:font77 size:10]];
    
    [self.km_unit setText:[Utility getStringByKey:@"km_unit"]];
    [self.cals_unit setText:[Utility getStringByKey:@"cal_unit"]];
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
