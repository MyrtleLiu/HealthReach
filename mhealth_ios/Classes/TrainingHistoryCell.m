//
//  TrainingHistoryCell.m
//  mHealth
//
//  Created by smartone_sn on 14-8-18.
//
//

#import "TrainingHistoryCell.h"

@implementation TrainingHistoryCell

- (void)awakeFromNib
{
    // Initialization code
    
    [self.startDate setFont:[UIFont fontWithName:font65 size:15]];
    [self.endDate setFont:[UIFont fontWithName:font65 size:15]];
    [self.status setFont:[UIFont fontWithName:font65 size:18]];
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
