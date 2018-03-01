//
//  HistoryTitleCustomCell.h
//  mHealth
//
//  Created by gz dev team on 14年1月30日.
//
//

#import <UIKit/UIKit.h>

@interface HistoryTitleCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *SYSLabel;
@property (weak, nonatomic) IBOutlet UILabel *DIALabel;
@property (weak, nonatomic) IBOutlet UILabel *PULLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (copy, nonatomic) NSString *SYSString;
@property (copy, nonatomic) NSString *DIAString;
@property (copy, nonatomic) NSString *PULString;
@property (copy, nonatomic) NSString *dateString;
@property (copy, nonatomic) NSString *timeString;

//set slashString=@"" will set all label nil in this cell
@property (copy, nonatomic) NSString *slashString;
@property (weak, nonatomic) IBOutlet UILabel *slashLabel;
@property (weak, nonatomic) IBOutlet UILabel *mmHgLabel;
@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;

@end