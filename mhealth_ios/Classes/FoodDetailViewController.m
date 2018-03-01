//
//  FoodDetailViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-23.
//
//

#import "FoodDetailViewController.h"
#import "Utility.h"
#import "LearnMoreFirstViewController.h"

@interface FoodDetailViewController ()

@end

@implementation FoodDetailViewController

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
    [_actionbar setText:[Utility getStringByKey:@"home_title_cals"]];
    [_btnDelete setTitle:[Utility getStringByKey:@"delete"] forState:UIControlStateNormal];
    [_btnExport setTitle:[Utility getStringByKey:@"export"] forState:UIControlStateNormal];
    
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"cn"]){
        [_demonpic setImage:[UIImage imageNamed:@"IMG_0359zh.PNG"]];
    }
    else{
        [_demonpic setImage:[UIImage imageNamed:@"IMG_0357.PNG"]];
    }
    
    if (iPad) {
        _demonpic.frame=CGRectMake(0, 45, 320, 435);
        _btnDelete.frame=CGRectMake(35, 435, 120, 40);
        _btnExport.frame=CGRectMake(163, 435, 120, 40);
        _barView.frame=CGRectMake(0, 0, 320, 50);

    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)switchToCalLearnMore1:(id)sender{
    LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
    [historyView setType:@"food"];
    [self.navigationController pushViewController:historyView animated:YES ];

}
-(IBAction)switchToCalLearnMore2:(id)sender{
    LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
    [historyView setType:@"food"];
    [self.navigationController pushViewController:historyView animated:YES ];
    
}

@end
