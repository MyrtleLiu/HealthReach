//
//  MessagesBoxViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-10-8.
//
//

#import "BaseViewController.h"

@interface MessagesBoxViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UIView *managerMsgView;
@property (nonatomic, weak) IBOutlet UIButton *managerMsg_btn;

@property (nonatomic, weak) IBOutlet UIView *editMsgListView;
@property (nonatomic, weak) IBOutlet UIButton *delMsg_btn;
@property (nonatomic, weak) IBOutlet UIButton *forwardMsg_btn;

@property (nonatomic, weak) IBOutlet UILabel *actionbarTitle;

@property (retain, nonatomic) NSMutableArray *message_list;


- (IBAction)managerMsg:(id)sender;
- (IBAction)delMsg:(id)sender;
- (IBAction)forwardMsg:(id)sender;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *act;


@end
