//
//  NoNetWorkViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-11-18.
//
//

#import "NoNetWorkViewController.h"
#import "Utility.h"

@interface NoNetWorkViewController ()

@end

@implementation NoNetWorkViewController

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
    [_okBtn setTitle:[Utility getStringByKey:@"ok"] forState: UIControlStateNormal];
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"]){
        [_titleImage setImage:[UIImage imageNamed:@"01_index_logo.png"]];
        [_noNetworkText setText:@"You must connect to a mobile data network or a Wi-Fi network to access HealthReach"];

    }
    else{
        [_titleImage setImage:[UIImage imageNamed:@"00_logo.png"]];
        [_noNetworkText setText:@"你必須連接至流動數據網絡或Wi-Fi網絡，方可登入健易達"];

        
    }
    
    
    if (iPad) {
        
        _noNetworkText.frame=CGRectMake(40, 70, 240, 60);
        _okBtn.frame=CGRectMake(100, 230, 120, 37);
        _barView.frame=CGRectMake(0, 0, 320, 45);
        _shadowView.frame=CGRectMake(0, 30, 320, 5);
        
    }
  

    

}




//-(IBAction)quitApp:(id)sender{
//    
//    if(![_link isEqualToString:@"login"]){
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else{
//        NSThread *threadForCalories = [[NSThread alloc]initWithTarget:self selector:@selector(syncCalories) object:nil];
//        [threadForCalories start];
//
//    }
//    
//   
//}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
