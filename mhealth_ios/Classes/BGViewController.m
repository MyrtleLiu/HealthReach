//
//  BGViewController.m
//  mHealth
//
//  Created by sngz on 14-3-27.
//
//

#import "BGViewController.h"
#import "BGHistoryViewController.h"
#import "BGMeasureViewController.h"
#import "Utility.h"
#import "LearnMoreFirstViewController.h"
#import "GlobalVariables.h"
#import "measurementDemoViewController.h"

@interface BGViewController ()

@end

@implementation BGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"BGViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"BGViewController_iphone4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadViewText];
}

- (void)reloadViewText
{
    [_bgTitleLabel setText:[Utility getStringByKey:@"bloodglucose"]];
    [_bgTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [_measureLabel setText:[Utility getStringByKey:@"prepare_measure"]];
    [_measureLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];
    
    [_historyLabel setText:[Utility getStringByKey:@"history_data"]];
    [_historyLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];
}

- (IBAction)toBGMeasure:(id)sender
{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
        [historyView setType:@"bg"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        BGMeasureViewController *bgMeasureVIew = [[BGMeasureViewController alloc]initWithNibName:@"BGMeasureViewController" bundle:nil];
        [self.navigationController pushViewController:bgMeasureVIew animated:YES];
    }
   
}

- (IBAction)toBGHistory:(id)sender
{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        measurementDemoViewController *historyView = [[measurementDemoViewController alloc] initWithNibName:@"measurementDemoViewController" bundle:nil];
        [historyView setType:@"bg"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        BGHistoryViewController *bgHistoryView = [[BGHistoryViewController alloc]initWithNibName:@"BGHistoryViewController" bundle:nil];
        [self.navigationController pushViewController:bgHistoryView animated:YES];
    }
    
}

@end