//
//  WeightRotateViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-9-4.
//
//

#import "WeightRotateViewController.h"
#import "DBHelper.h"
#import "Utility.h"
#import "mHealth_iPhoneAppDelegate.h"

@interface WeightRotateViewController ()

@end

@implementation WeightRotateViewController

@synthesize weightChart;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (!iPad) {
        
        self = [super initWithNibName:@"WeightRotateViewController" bundle:nibBundleOrNil];
    }
    else
    {
        
        self = [super initWithNibName:@"WeightRotateViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    
    if (self) {
        // Custom initialization
    }
    
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setRotateWeightView:self];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIDevice *device = [UIDevice currentDevice];
	[device beginGeneratingDeviceOrientationNotifications];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
    
    
    [self setupWeightChart:7];
}

//-(void)viewDidAppear:(BOOL)animated{
//    
//    if (!iPhone5) {
//        
//        [UIView
//         animateWithDuration:0.0f
//         
//         animations:^{
//             
//              [self.view setTransform: CGAffineTransformMakeRotation(M_PI / 2)];
//             
//              //self.view.frame= CGRectMake(0, 0, 480, 320);
//             
//             
//             
//         }];
//    }
//    
//}

-(void)viewWillAppear:(BOOL)animated{
    
    
//    if (iPad) {
    
        [UIView
         animateWithDuration:0.0f
         
         animations:^{
             
             [self.view setTransform: CGAffineTransformMakeRotation(M_PI / 2)];
             
             //self.view.frame= CGRectMake(0, 0, 480, 320);
             
             if (!iPad) {
                 
                 self.view.frame= CGRectMake(0, 0, 568, 320);
             }
             
             
         }];
//    }
    
    
    if (!iPad) {
        // NSLog(@"hide status bar....");
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self prefersStatusBarHidden];
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }

    
    [_weightLabel setText:[Utility getStringByKey:@"weight_len"]];
    [_bmiLabel setText:[Utility getStringByKey:@"bmi_len"]];
    [_bmiLevelLabel setText:[Utility getStringByKey:@"bmi_len_pl"]];
    
    
    [_weekBtn setTitle:[Utility getStringByKey:@"7d"] forState: normal];
    [_weeksBtn setTitle:[Utility getStringByKey:@"14d"] forState: normal];
    [_monthBtn setTitle:[Utility getStringByKey:@"1m"] forState: normal];
    [_monthsBtn setTitle:[Utility getStringByKey:@"3m"] forState: normal];
    
    
    [_weightUnitLabel setText:[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"]];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)orientationChanged:(NSNotification *)note  {
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
	switch (o) {
		case UIDeviceOrientationPortrait:
            
//            if (!iPad) {
//                
//                [self dismissViewControllerAnimated:YES completion:nil];
//                
//            }else{
            
                 [[UIApplication sharedApplication] setStatusBarHidden:NO];
                
                [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] hideRotateView];
                
//            }

            
            break;
            
		default:
			break;
	}
}

- (void)viewWillDisappear:(BOOL)animated
{
    
//    NSLog(@"hide bp rotate.............");
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait) {
//        
//        NSLog(@"UIInterfaceOrientationPortrait.........eee.....bp rotate");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeLeft.....eee.........bp rotate");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeRight....eeee..........bp rotate");
//    }
    
    
    [[UIApplication sharedApplication] setStatusBarOrientation:1 animated:NO];
    

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[UIDevice  currentDevice] endGeneratingDeviceOrientationNotifications ];
    
    
}

-(IBAction)changePeriod:(id)sender{
    
    
    UIButton *btn=sender;
    
    if (btn.tag==7) {
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:120.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        
        
        
        [self.weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupWeightChart:7];
        
        
        
        
    }else if (btn.tag==14){
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:120.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        
        
        [self.weeksBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupWeightChart:14];
        
        
        
    }else if (btn.tag==30){
        BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenDashBoard];
        NSLog(@"checkLoadView:%d",checkLoadView);
        if(checkLoadView){
            _WaitingView.hidden=true;
            
            self.monthBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:120.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            
            self.weeksBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
            
            self.weekBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
            
            self.monthsBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
            
            
            
            [self.monthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.weekBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.weeksBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.monthsBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            [self setupWeightChart:30];


        }else{
            _WaitingView.hidden=false;
        }
        
        
        
        
    }else if (btn.tag==90){
        
        BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenDashBoard];
        NSLog(@"checkLoadView:%d",checkLoadView);
        if(checkLoadView){
            _WaitingView.hidden=true;
            
            self.monthsBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:120.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            
            self.weeksBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
            
            self.weekBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
            
            self.monthBtn.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:80.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
            
            
            
            [self.monthsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.weekBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.weeksBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.monthBtn setTitleColor:[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            [self setupWeightChart:90];

            
        }else{
            _WaitingView.hidden=false;

        }
        
        
        
        
    }
    
    
}


-(void) setupWeightChart:(int)period{
    
    
    NSDate *tmp=[NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
    
    
    //        NSLog(@"year: %i", dateComponent.year);
    //
    //        	NSLog(@"month:%i", dateComponent.month);
    //        	NSLog(@"day:%i", dateComponent.day);
    //        	NSLog(@"hour:%i", dateComponent.hour);
    //        	NSLog(@"minute:%i", dateComponent.minute);
    //        	NSLog(@"second:%i", dateComponent.second);
    
    NSInteger year=dateComponent.year;
    NSInteger month=dateComponent.month;
    NSInteger day=dateComponent.day;
    
    // NSLog(@"%d.....%d.....%d",year,month,day);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
    
    dateComponent.day=dateComponent.day-period+1;
    
    
    NSDate *dateFromDateComponentsForDate = [calendar dateFromComponents:dateComponent];
    
    dateComponent = [calendar components:unitFlags fromDate:dateFromDateComponentsForDate];
    
    year=dateComponent.year;
    month=dateComponent.month;
    day=dateComponent.day;
    
    
    NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
    
    
    NSLog(@"%@.............%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
    
    WeightList *weightResultList;
    
    
    if (period==7||period==14) {
        
        weightResultList=[DBHelper getWeightByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:0];
        
    }else{
        
        
        weightResultList=[DBHelper getWeightAverageChartByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:period];
        
    }
    
    
    
    
    NSMutableArray *timeData=[[NSMutableArray alloc] init];
    
    NSMutableArray *weightData=[[NSMutableArray alloc] init];
    
    NSMutableArray *bmiData=[[NSMutableArray alloc] init];
    
    NSMutableArray *missData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger j=[weightResultList.weightList count]-1; j>-1; j--) {
        
        Weight *weight=[weightResultList.weightList objectAtIndex:j];
        
        long time=[weight getRecordtime];
        
        [timeData addObject:@(time)];
        
        NSInteger miss=[weight getMissprevious];
        
        [missData addObject:@(miss)];
        
        NSInteger weightValue=[weight.weight integerValue];
        
        
        NSInteger bmiValue=[weight.bmi integerValue];
        
        [weightData addObject:@(weightValue)];
        
        [bmiData addObject:@(bmiValue+WEIGHT_MOVE_POS)];
        
        NSLog(@"%ld.......%ld.............%@",(long)weightValue,(long)bmiValue,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
        
        
        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1];
        d1x.itemCount = [weightData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [weightData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }

    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
        d3x.itemCount = [bmiData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [bmiData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }

    
    
    weightChart.yMin = 10;
    weightChart.yMax = 300;
    
    weightChart.xMin = [recordEnd timeIntervalSince1970];
    weightChart.xMax = [recordStart timeIntervalSince1970];
    
    weightChart.ySteps = @[@"100",@"120",@"140",@"160",@"180",@"200"];
    weightChart.data = @[d1x,d3x];
    
    
    weightChart.drawsDataPoints = YES;
    
    weightChart.drawsDataLines = YES;
    
    weightChart.drawsBG=YES;
    
    weightChart.enableTouch=NO;
    
    weightChart.isRotate=YES;
    
    weightChart.xLabelCount=period;
    
    weightChart.chartType=TYPE_WEIGHT;
    
    [weightChart setNeedsDisplay];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    
    return NO;
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
    
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    
}


@end
