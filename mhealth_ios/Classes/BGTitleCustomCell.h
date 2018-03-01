//
//  BGTitleCustomCell.h
//  mHealth
//
//  Created by sngz on 14-3-28.
//
//

#import <UIKit/UIKit.h>

@interface BGTitleCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *BGValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (copy, nonatomic) NSString *BGValueString;
@property (copy, nonatomic) NSString *dateString;
@property (copy, nonatomic) NSString *timeString;
@property (copy, nonatomic) NSString *typeString;

//set mmolString=@"" will set all label=@"" in this cell
@property (copy, nonatomic) NSString *mmolString;
@property (weak, nonatomic) IBOutlet UILabel *mmolLabel;

@end
