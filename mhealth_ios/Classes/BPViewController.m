//
//  BPViewController.m
//  mHealth
//
//  Created by gz dev team on 14年1月9日.
//
//


#import "BPViewController.h"

#import "Utility.h"
#import "GlobalVariables.h"
#import "LearnMoreFirstViewController.h"
#import "measurementDemoViewController.h"

@interface BPViewController ()

@end

@implementation BPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"BPViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"BPViewController_iphone4" bundle:nibBundleOrNil];
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

- (void)reloadViewText
{
    [_measureUILabel setText:[Utility getStringByKey:@"prepare_measure"]];
    [_measureUILabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];
    
    [_historyUILabel setText:[Utility getStringByKey:@"history_data"]];
    [_historyUILabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-LT" size:32]];
    
    [_bloodpressureUILabel setText:[Utility getStringByKey:@"bloodpressure"]];
    [_bloodpressureUILabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
}

- (IBAction)HistoryUIButtonDown:(id)sender
{
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        measurementDemoViewController *historyView = [[measurementDemoViewController alloc] initWithNibName:@"measurementDemoViewController" bundle:nil];
        [historyView setType:@"bp"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        BPHistoryViewController *BPHistoryView = [[BPHistoryViewController alloc] initWithNibName:@"BPHistoryViewController" bundle:nil];
        [self.navigationController pushViewController:BPHistoryView animated:YES];
    }
    
    
    
}

- (IBAction)MeasureUIButtonDown:(id)sender
{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
        [historyView setType:@"bp"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        BPMeasureViewController *bpMeasureView = [[BPMeasureViewController alloc]initWithNibName:@"BPMeasureViewController" bundle:nil];
        [self.navigationController pushViewController:bpMeasureView animated:YES];
    }
    
    
   
}

- (IBAction)clickLeftButton:(id)sender
{
    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeView animated:YES];

}

@end


