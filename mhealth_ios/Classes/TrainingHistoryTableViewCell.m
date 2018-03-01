//
//  TrainingHistoryTableViewCell.m
//  mHealth
//
//  Created by smartone_sn on 14-8-14.
//
//

#import "TrainingHistoryTableViewCell.h"
#import "Utility.h"

@implementation TrainingHistoryTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
     [self.duration setFont:[UIFont fontWithName:font77 size:15]];
     [self.distance setFont:[UIFont fontWithName:font77 size:15]];
     [self.cals setFont:[UIFont fontWithName:font77 size:15]];
     [self.date setFont:[UIFont fontWithName:font77 size:14]];
    
    [self.km_unit setFont:[UIFont fontWithName:font77 size:10]];
    [self.cals_unit setFont:[UIFont fontWithName:font77 size:10]];
    
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
