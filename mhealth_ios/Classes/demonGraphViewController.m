//
//  demonGraphViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-23.
//
//

#import "demonGraphViewController.h"
#import "Utility.h"

@interface demonGraphViewController ()

@end

@implementation demonGraphViewController

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
   


    
}


-(void)viewWillAppear:(BOOL)animated{
    UIDevice *device = [UIDevice currentDevice];
	[device beginGeneratingDeviceOrientationNotifications];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
    //_demonpic.contentMode=UIViewContentModeScaleAspectFit;
    NSString *lanuage = [Utility getLanguageCode];
    if([_type isEqualToString:@"bp"]){
        if([lanuage isEqualToString: @"en"]){
            [_demonpic setImage:[UIImage imageNamed:@"slide4_5.png"]];
        }
        else{
            [_demonpic setImage:[UIImage imageNamed:@"slide4_5zh.png"]];
        }
        
    }
    else if([_type isEqualToString:@"bg"]){
        if([lanuage isEqualToString: @"en"]){
            [_demonpic setImage:[UIImage imageNamed:@"slide4_9.png"]];
        }
        else{
            [_demonpic setImage:[UIImage imageNamed:@"slide4_9zh.png"]];
        }
        
    }
    else if([_type isEqualToString:@"weight"]){
        if([lanuage isEqualToString: @"en"]){
            [_demonpic setImage:[UIImage imageNamed:@"slide6_11.png"]];
        }
        else{
            [_demonpic setImage:[UIImage imageNamed:@"slide5_5zh.png"]];
        }
        
    }
    else if([_type isEqualToString:@"food"]){
        if([lanuage isEqualToString: @"en"]){
            [_demonpic setImage:[UIImage imageNamed:@"slide5_5.png"]];
        }
        else{
            [_demonpic setImage:[UIImage imageNamed:@"slide6_11zh.png"]];
        }
        
    }
    
    
    if (iPad) {
        _demonpic.frame=CGRectMake(0, 0, 480, 320);
    }


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
	switch (o) {
		case UIDeviceOrientationPortrait:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
		default:
			break;
	}
}
-(BOOL)shouldAutorotate {
    
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations{
#else
    - (UIInterfaceOrientationMask)supportedInterfaceOrientations{
#endif
    
    return UIInterfaceOrientationMaskLandscape;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    
}


@end
