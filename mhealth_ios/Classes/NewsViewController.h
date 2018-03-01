//
//  MessagesBoxViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-10-8.
//
//

#import "BaseViewController.h"

@interface NewsViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) IBOutlet UITableView *tableView;


@property (nonatomic, weak) IBOutlet UILabel *actionbarTitle;

@property (retain, nonatomic) NSMutableArray *message_list;






@end
