//
//  BGRotateChartViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-9-3.
//
//

#import "BaseViewController.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"

@interface BGRotateChartViewController : BaseViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet LineChartView *bgChart;

@property (strong, nonatomic) IBOutlet UIButton *weekBtn;
@property (strong, nonatomic) IBOutlet UIButton *weeksBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthsBtn;

@property (strong, nonatomic) IBOutlet UILabel *beforeLabel;
@property (strong, nonatomic) IBOutlet UILabel *beforeLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *afterLabel;
@property (strong, nonatomic) IBOutlet UILabel *afterLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *fastLabel;
@property (strong, nonatomic) IBOutlet UILabel *fastLevelLabel;
@property (strong, nonatomic) IBOutlet UILabel *unspecialLabel;
@property (strong, nonatomic) IBOutlet UILabel *unspecialLevelLabel;

@property (strong, nonatomic) IBOutlet UILabel *bgUnitLabel;

-(IBAction)changePeriod:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *WaitingView;



@end
