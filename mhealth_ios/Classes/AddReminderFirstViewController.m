//
//  AddReminderFirstViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-23.
//
//

#import "AddReminderFirstViewController.h"
#import "Utility.h"
#import "LearnMoreFirstViewController.h"

@interface AddReminderFirstViewController ()

@end

@implementation AddReminderFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_actionbar setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    [_btnCancel setTitle:[Utility getStringByKey:@"cancel"] forState:UIControlStateNormal];
    [_btnDone setTitle:[Utility getStringByKey:@"done"] forState:UIControlStateNormal];
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"]){
        [_demonpic setImage:[UIImage imageNamed:@"slide6_4.PNG"]];
    }
    else{
        [_demonpic setImage:[UIImage imageNamed:@"slide6_4zh.PNG"]];
        
    }

    
    
    if (iPad) {
        _demonpic.frame=CGRectMake(0, 45, 320, 435);
        _btnCancel.frame=CGRectMake(36, 435, 120, 40);
        _btnDone.frame=CGRectMake(163, 435, 120, 40);
        _barView.frame=CGRectMake(0, 0, 320, 45);
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnDoneClick:(id)sender{
    LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
    [historyView setType:@"calendar"];
    [self.navigationController pushViewController:historyView animated:YES ];
}


@end
