//
//  CalsHomeViewController.m
//  mHealth
//
//  Created by smartone_sn3 on 8/29/14.
//
//

#import "CalsHomeViewController.h"

#import "CalsViewController.h"
#import "CalsHistoryViewController.h"
#import "Utility.h"
#import "LearnMoreFirstViewController.h"
#import "GlobalVariables.h"
#import "measurementDemoViewController.h"

@interface CalsHomeViewController ()

@end

@implementation CalsHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"CalsHomeViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"CalsHomeViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadViewText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadViewText
{
    [_calsLabel setText:[Utility getStringByKey:@"home_title_cals"]];
    [_calsLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [_historyLabel setText:[Utility getStringByKey:@"history_data"]];
    [_historyLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];
    
    [_selectLabel1 setText:[Utility getStringByKey:@"select_food"]];
    [_selectLabel1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];

    [_selectLabel2 setText:[Utility getStringByKey:@"items"]];
    [_selectLabel2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];

}

- (IBAction)toSelectView:(id)sender {
    
        CalsViewController *calsView = [[CalsViewController alloc]initWithNibName:@"CalsViewController" bundle:nil];
        [self.navigationController pushViewController:calsView animated:YES];

    
    
}

- (IBAction)toHistoryView:(id)sender {
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        measurementDemoViewController *historyView = [[measurementDemoViewController alloc] initWithNibName:@"measurementDemoViewController" bundle:nil];
        [historyView setType:@"food"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        CalsHistoryViewController *calsHistoryView = [[CalsHistoryViewController alloc]initWithNibName:@"CalsHistoryViewController" bundle:nil];
        [self.navigationController pushViewController:calsHistoryView animated:YES];

    }
    
    
}

@end
