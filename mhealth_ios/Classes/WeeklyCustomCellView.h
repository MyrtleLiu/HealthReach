//
//  WeeklyCustomCellView.h
//  mHealth
//
//  Created by evan_li on 9/26/14.
//
//

#import <UIKit/UIKit.h>

@interface WeeklyCustomCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *SYSLabel;
@property (weak, nonatomic) IBOutlet UILabel *DIALabel;
@property (weak, nonatomic) IBOutlet UILabel *PULLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeknoLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekDetailLabel;

@property (copy, nonatomic) NSDictionary *dataDictionary;
@property (copy, nonatomic) NSString *SYSString;
@property (copy, nonatomic) NSString *DIAString;
@property (copy, nonatomic) NSString *PULString;
@property (copy, nonatomic) NSString *weeknoString;
@property (copy, nonatomic) NSString *weekDetailString;

//set slashString=@"" will set all label=@"" in this cell
@property (copy, nonatomic) NSString *slashString;
@property (weak, nonatomic) IBOutlet UILabel *slashLabel;
@property (weak, nonatomic) IBOutlet UILabel *mmHgLabel;
@property (weak, nonatomic) IBOutlet UILabel *bpmLabel;



@end
