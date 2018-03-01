//
//  CurrentWeeklyProgressViewController.h
//  mHealth
//
//  Created by gz dev team on 14年2月27日.
//
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "CurrentWeekPCell.h"
@interface CurrentWeeklyProgressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    IBOutlet UIView* aView;
    IBOutlet UIView* bView;
#pragma mark -- 最下面那一行 日期
    IBOutlet UILabel * label1;
    IBOutlet UILabel * label2;
    IBOutlet UILabel * label3;
    IBOutlet UILabel * label4;
    IBOutlet UILabel * label5;
    IBOutlet UILabel * label6;
    IBOutlet UILabel * label7;
#pragma mark -- 黄色的统计数据图；
    IBOutlet UILabel * label_20;
    IBOutlet UILabel * label_40;
    IBOutlet UILabel * label_60;
    IBOutlet UILabel * label_80;
    IBOutlet UILabel * label_100_1;
    IBOutlet UILabel * label_100_2;
    IBOutlet UILabel * label_100_3;
    IBOutlet UILabel * label_100_4;
    IBOutlet UILabel * label_100_5;
    IBOutlet UILabel * label_100_6;
    IBOutlet UILabel * label_100_7;
    
    

    UITableView*_tableView;
    
    
    NSMutableArray*_arrayYear;

    NSArray*__array;
    
}

@property ( readwrite , retain , nonatomic ) NSMutableArray*dataForPlot;
@property (nonatomic,strong)    NSDate*nowDate;
-(IBAction)goHome:(id)sender;
@end
