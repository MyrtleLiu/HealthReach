//
//  CalsHistoryDetailViewController.h
//  mHealth
//
//  Created by smartone_sn3 on 9/2/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HJObjManager.h"

@interface CalsHistoryDetailViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>{
    HJObjManager *imgMan;
}

@property (strong, nonatomic) NSArray *sectionList;

@property (weak, nonatomic) IBOutlet UILabel *calsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCaloriesUnitLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (retain, nonatomic) HJObjManager *imgMan;
@property (strong, nonatomic) NSDictionary *dataDict;


@end
