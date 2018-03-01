//
//  DateWidgetViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-23.
//
//

#import "DateWidgetViewController.h"
#import "reminderLIstViewController.h"
#import "Utility.h"

@interface DateWidgetViewController ()

@end

@implementation DateWidgetViewController

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
     [_btnClick setTitle:[Utility getStringByKey:@"Events Summary"] forState:UIControlStateNormal];
    
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"]){
        [_demonpic setImage: [UIImage imageNamed:@"slide6_2.PNG"]];
    }
    else{
        [_demonpic setImage:[UIImage imageNamed:@"slide6_2zh.PNG"]];
    }
    
    if (iPad) {
        _demonpic.frame=CGRectMake(0, 45, 320, 435);
        _btnClick.frame=CGRectMake(70, 435, 180, 40);
        _barView.frame=CGRectMake(0, 0, 320, 45);

    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnClick:(id)sender{
    reminderLIstViewController *_allchar=[[reminderLIstViewController alloc]initWithNibName:@"reminderLIstViewController" bundle:nil];
    [self.navigationController pushViewController:_allchar animated:YES];

    
}

@end
