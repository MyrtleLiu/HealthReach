//
//  MessageTableViewCell.h
//  mHealth
//
//  Created by smartone_sn on 14-10-8.
//
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
{
@private
UIImageView*	m_checkImageView;
BOOL			m_checked;
}

- (void) setChecked:(BOOL)checked;
- (void) setBgGray:(NSString *)is_read;

@property (strong, nonatomic) IBOutlet UILabel *msg_title;
@property (strong, nonatomic) IBOutlet UILabel *msg_content;
@property (strong, nonatomic) IBOutlet UILabel *msg_date;
@property (strong, nonatomic) IBOutlet UIImageView *msg_img;

@property (strong, nonatomic) IBOutlet UIView *holeView;


@end
