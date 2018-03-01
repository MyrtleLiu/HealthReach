//
//  WeightResultViewController.m
//  mHealth
//
//  Created by sngz on 14-3-6.
//
//

#import "WeightResultViewController.h"
#import "DBHelper.h"
#import "Weight.h"
#import "Utility.h"
#import "HomeViewController.h"
#import "WeightViewController.h"
#import "WeightMeasureViewController.h"

@interface WeightResultViewController ()

@end

@implementation WeightResultViewController

@synthesize BMILabel;
@synthesize LBSLabel;
@synthesize WeightTitle;
@synthesize currentDateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"WeightResultViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"WeightResultViewController_iphone4" bundle:nibBundleOrNil];
    }

    return self;
}

- (void)viewDidLoad
{
    NSLog(@"result view did load!");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Weight *newestWeight = [DBHelper getNewestWeightRecord];
    [LBSLabel setText:[newestWeight weight]];
    [BMILabel setText:[newestWeight bmi]];

    // dateLabel init
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
        [dateFormatter setDateFormat:@"dd M月 yyyy年 HH:mm"];
    } else {
        [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm"];
    }
    
    NSString *currentTimeStr = [dateFormatter stringFromDate:[NSDate date]];
    [currentDateLabel setText:currentTimeStr];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toWeightMeasureView:(id)sender {
    WeightMeasureViewController *weightMeasureView = [[WeightMeasureViewController alloc]initWithNibName:@"WeightMeasureViewController" bundle:nil];
    [self.navigationController pushViewController:weightMeasureView animated:YES];
}

@end
