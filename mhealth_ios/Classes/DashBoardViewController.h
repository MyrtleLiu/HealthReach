//
//  DashBoardViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-9-1.
//
//

#import "BaseViewController.h"


#import "LineChartView.h"
#import "NSDate+Additions.h"

#import "Utility.h"

@interface DashBoardViewController : BaseViewController<UIScrollViewDelegate>{
    
    NSMutableDictionary *alertLevelDic;
}


@property (strong, nonatomic) IBOutlet UIScrollView *contentView;

@property (strong, nonatomic) IBOutlet LineChartView *bpChart;
@property (strong, nonatomic) IBOutlet LineChartView *hrChart;
@property (strong, nonatomic) IBOutlet LineChartView *bgChart;
@property (strong, nonatomic) IBOutlet LineChartView *weightChart;
@property (strong, nonatomic) IBOutlet LineChartView *bmiChart;
@property (strong, nonatomic) IBOutlet LineChartView *walkingChart;
@property (strong, nonatomic) IBOutlet LineChartView *calsChart;

@property (strong, nonatomic) IBOutlet UIButton *weekBtn;
@property (strong, nonatomic) IBOutlet UIButton *weeksBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthsBtn;

@property (strong, nonatomic) IBOutlet UILabel *bpTitel;
@property (strong, nonatomic) IBOutlet UILabel *ecgTitel;
@property (strong, nonatomic) IBOutlet UILabel *bgTitel;
@property (strong, nonatomic) IBOutlet UILabel *weightTitel;
@property (strong, nonatomic) IBOutlet UILabel *bmiTitel;
@property (strong, nonatomic) IBOutlet UILabel *walkTitel;
@property (strong, nonatomic) IBOutlet UILabel *calTitel;

@property (strong, nonatomic) IBOutlet UILabel *actionbar;

@property (strong, nonatomic) IBOutlet UIButton *editDashboardBtn;

@property (strong, nonatomic) IBOutlet UIView *loadview;


-(IBAction)changePeriod:(id)sender;

-(IBAction)dbsetup:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *WaitingView;

@property(nonatomic, retain) IBOutlet UILabel *dataLoading;


@end
