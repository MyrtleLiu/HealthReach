//
//  SearchLocationCustomCellView.h
//  mHealth
//
//  Created by evan_li on 10/21/14.
//
//

#import <UIKit/UIKit.h>

@interface SearchLocationCustomCellView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (copy, nonatomic) NSString *contentString;
@property (copy, nonatomic) NSString *referenceString;

@end
