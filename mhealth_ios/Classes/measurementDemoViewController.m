//
//  measurementDemoViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-23.
//
//

#import "measurementDemoViewController.h"
#import "Utility.h"
#import "BPRotateChartViewController.h"
#import "demonGraphViewController.h"
#import "FoodDetailViewController.h"


@interface measurementDemoViewController ()

@end

@implementation measurementDemoViewController

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
    if([_type isEqualToString:@"bp"]){
        [_actionbar setText:[Utility getStringByKey:@"bloodpressure"]];
        [_titlebar setImage:[UIImage imageNamed:@"03_bp_header_p1.png"]];
        NSString *lanuage = [Utility getLanguageCode];
        if([lanuage isEqualToString: @"cn"]){
            [_demonpic setImage:[UIImage imageNamed:@"slide4_4zh.PNG"]];
        }
        else{
            [_demonpic setImage:[UIImage imageNamed:@"slide4_4.PNG"]];

        }
    }
    else if([_type isEqualToString:@"bg"]){
        [_actionbar setText:[Utility getStringByKey:@"bloodglucose"]];
        [_titlebar setImage:[UIImage imageNamed:@"04_bg_header_p1.png"]];
        NSString *lanuage = [Utility getLanguageCode];
        if([lanuage isEqualToString: @"cn"]){
            [_demonpic setImage:[UIImage imageNamed:@"slide4_8zh.PNG"]];
        }
        else{
            [_demonpic setImage:[UIImage imageNamed:@"slide4_8.PNG"]];

        }


    }
    else if([_type isEqualToString:@"weight"]){
        [_actionbar setText:[Utility getStringByKey:@"home_title_Weight"]];
        [_titlebar setImage:[UIImage imageNamed:@"06_we_header_p1.png"]];
        NSString *lanuage = [Utility getLanguageCode];
        if([lanuage isEqualToString: @"cn"]){
            [_demonpic setImage:[UIImage imageNamed:@"slide5_4zh.PNG"]];
        }
        else{
            [_demonpic setImage:[UIImage imageNamed:@"slide5_4.PNG"]];

        }


    }
    else if([_type isEqualToString:@"food"]){
        [_actionbar setText:[Utility getStringByKey:@"home_title_cals"]];
        [_titlebar setImage:[UIImage imageNamed:@"08_cal_header_p1.png"]];
        NSString *lanuage = [Utility getLanguageCode];
        if([lanuage isEqualToString: @"cn"]){
            [_demonpic setImage:[UIImage imageNamed:@"IMG_0358zh.PNG"]];
        }
        else{
            [_demonpic setImage:[UIImage imageNamed:@"slide6_9.PNG"]];

        }
        
    }
    
    
    
    if (iPad) {
        _demonpic.frame=CGRectMake(0, 45, 320, 435);
        _barView.frame=CGRectMake(0, 0, 320, 45);
    }
    
    
    



}


-(void)viewWillAppear:(BOOL)animated{
    if([_type isEqualToString:@"food"]){
        _calBtn.hidden=false;
    }
    UIDevice *device = [UIDevice currentDevice];
	[device beginGeneratingDeviceOrientationNotifications];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];

    
}

-(IBAction)calBtnClick:(id)sender{

    
    FoodDetailViewController *bpView = [[FoodDetailViewController alloc] initWithNibName:@"FoodDetailViewController" bundle:nil];
    [self.navigationController pushViewController:bpView animated:YES ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark jump to ChartView when rotate

- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
	switch (o) {
		case UIDeviceOrientationLandscapeLeft:
            [self rotateView];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self rotateView];
            break;
            
		default:
			break;
	}
}

- (void)rotateView {
    
//    if(self.weeklyTableView.hidden&&self.monthlyTableView.hidden){
    
        demonGraphViewController *rotateView = [[demonGraphViewController alloc]initWithNibName:@"demonGraphViewController" bundle:nil];
        [rotateView setType:_type];
        [self.navigationController presentViewController:rotateView animated:YES completion:nil];
    
//    }
    
    
}

-(BOOL)shouldAutorotate {
    
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations{
#else
    - (UIInterfaceOrientationMask)supportedInterfaceOrientations{
#endif
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    
}










@end
