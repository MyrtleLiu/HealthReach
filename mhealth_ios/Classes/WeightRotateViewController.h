//
//  WeightRotateViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-9-4.
//
//

#import "BaseViewController.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"

@interface WeightRotateViewController : BaseViewController<UIScrollViewDelegate>


@property (strong, nonatomic) IBOutlet LineChartView *weightChart;


@property (strong, nonatomic) IBOutlet UIButton *weekBtn;
@property (strong, nonatomic) IBOutlet UIButton *weeksBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthsBtn;

@property (strong, nonatomic) IBOutlet UILabel *weightLabel;

@property (strong, nonatomic) IBOutlet UILabel *bmiLabel;
@property (strong, nonatomic) IBOutlet UILabel *bmiLevelLabel;

@property (strong, nonatomic) IBOutlet UILabel *weightUnitLabel;


-(IBAction)changePeriod:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *WaitingView;



@end
