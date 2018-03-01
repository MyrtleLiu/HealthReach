//
//  CalsRotateViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-9-4.
//
//

#import "BaseViewController.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"

@interface CalsRotateViewController : BaseViewController


@property (strong, nonatomic) IBOutlet LineChartView *calsChart;


@property (strong, nonatomic) IBOutlet UIButton *weekBtn;
@property (strong, nonatomic) IBOutlet UIButton *weeksBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthsBtn;

@property (strong, nonatomic) IBOutlet UILabel *calsLabel;
@property (strong, nonatomic) IBOutlet UILabel *calsburnLabel;

@property (strong, nonatomic) IBOutlet UILabel *calsUnitLabel;


-(IBAction)changePeriod:(id)sender;

@end
