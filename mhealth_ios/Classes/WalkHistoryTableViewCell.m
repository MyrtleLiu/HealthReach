//
//  WalkHistoryTableViewCell.m
//  mHealth
//
//  Created by smartone_sn2 on 14-8-27.
//
//

#import "WalkHistoryTableViewCell.h"
#import "Utility.h"

@implementation WalkHistoryTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [self.date setFont:[UIFont fontWithName:font65 size:15]];
    [self.distance setFont:[UIFont fontWithName:font67 size:18]];
    [self.duration setFont:[UIFont fontWithName:font67 size:18]];
    [self.cals setFont:[UIFont fontWithName:font67 size:18]];
    
    [self.km_unit setFont:[UIFont fontWithName:font67 size:12]];
    [self.cals_unit setFont:[UIFont fontWithName:font67 size:12]];

    [_km_unit setText:[Utility getStringByKey:@"km_unit"]];
    [_cals_unit setText:[Utility getStringByKey:@"cal_unit"]];
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
