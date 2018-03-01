//
//  MeasureTitleCustomCell.h
//  mHealth
//
//  Created by gz dev team on 14年1月26日.
//
//

// Outdated
#import <UIKit/UIKit.h>

@interface MeasureTitleCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@property (copy, nonatomic) NSString *titleString;
@property (copy, nonatomic) NSString *valueString;
@property (copy, nonatomic) NSString *unitString;

@end
