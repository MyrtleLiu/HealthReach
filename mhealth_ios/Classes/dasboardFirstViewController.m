//
//  dasboardFirstViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-24.
//
//

#import "dasboardFirstViewController.h"
#import "Utility.h"

@interface dasboardFirstViewController ()

@end

@implementation dasboardFirstViewController

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
    NSString *lanuage = [Utility getLanguageCode];
    [_actionbar setText:[Utility getStringByKey:@"dashboard" ]];

    if([lanuage isEqualToString: @"cn"]){
        [_demonpic setImage:[UIImage imageNamed:@"slide3_5zh.png"]];
    }
    else{
        [_demonpic setImage:[UIImage imageNamed:@"slide3_5.png"]];
    }
    
    
    if (iPad) {
        _scrollview.frame=CGRectMake(0, 45, 320, 435);
        _barView.frame=CGRectMake(0, 0, 320, 45);
        
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
