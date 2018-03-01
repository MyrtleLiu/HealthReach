//
//  BPRotateChartViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-9-3.
//
//

#import "BaseViewController.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"

@interface BPRotateChartViewController : BaseViewController<UIScrollViewDelegate>


@property (strong, nonatomic) IBOutlet LineChartView *bpChart;


@property (strong, nonatomic) IBOutlet UIButton *weekBtn;
@property (strong, nonatomic) IBOutlet UIButton *weeksBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeMonthsBtn;

@property (strong, nonatomic) IBOutlet UILabel *sysLabel;
@property (strong, nonatomic) IBOutlet UILabel *sysLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *diaLabel;
@property (strong, nonatomic) IBOutlet UILabel *diaLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *hrLabel;
@property (strong, nonatomic) IBOutlet UILabel *hrLevelLabel;

@property (strong, nonatomic) IBOutlet UILabel *bpUnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *hrUnitLabel;

-(IBAction)changePeriod:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *WaitingView;



@end
