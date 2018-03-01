//
//  WeightViewController.m
//  mHealth
//
//  Created by sngz on 14-2-24.
//
//

#import "WeightHistoryViewController.h"
#import "WeightViewController.h"
#import "HomeViewController.h"
#import "WeightMeasureViewController.h"
#import "LearnMoreFirstViewController.h"
#import "Utility.h"
#import "GlobalVariables.h"
#import "measurementDemoViewController.h"

@interface WeightViewController ()

@end

@implementation WeightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"WeightViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"WeightViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadViewText];
}

-(void)reloadViewText{
    [_weight_title setText:[Utility getStringByKey:@"home_title_Weight"]];
    [_weight_title setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [_history_data setText:[Utility getStringByKey:@"history_data"]];
    [_history_data setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];
    
    [_preparemeasure setText:[Utility getStringByKey:@"prepare_measure"]];
    [_preparemeasure setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toHome:(id)sender {
    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeView animated:YES];
}

- (IBAction)toWeightMeasure:(id)sender {
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
        [historyView setType:@"weight"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        WeightMeasureViewController *weightMeasureView = [[WeightMeasureViewController alloc]initWithNibName:@"WeightMeasureViewController" bundle:nil];
        [self.navigationController pushViewController:weightMeasureView animated:YES];

    }
   }

- (IBAction)toWeightHistory:(id)sender {
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        measurementDemoViewController *historyView = [[measurementDemoViewController alloc] initWithNibName:@"measurementDemoViewController" bundle:nil];
        [historyView setType:@"weight"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        WeightHistoryViewController *weightHistoryViewController = [[WeightHistoryViewController alloc]initWithNibName:@"WeightHistoryViewController" bundle:nil];
        [self.navigationController pushViewController:weightHistoryViewController animated:YES];
    }
   
    
}

@end
