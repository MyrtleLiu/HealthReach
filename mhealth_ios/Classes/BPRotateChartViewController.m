//
//  BPRotateChartViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-9-3.
//
//

#import "BPRotateChartViewController.h"
#import "DBHelper.h"
#import "Utility.h"

#import "mHealth_iPhoneAppDelegate.h"

@interface BPRotateChartViewController ()

@end

@implementation BPRotateChartViewController

@synthesize bpChart;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (!iPad) {
        
        self = [super initWithNibName:@"BPRotateChartViewController" bundle:nibBundleOrNil];
    }
    else
    {
        
        self = [super initWithNibName:@"BPRotateChartViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
    }
    
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setRotateBPView:self];

    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
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
    
    //[[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeLeft animated:NO];
    
    
    [self setupBPChart:7];
    
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}



- (void)viewWillAppear:(BOOL)animated{
    
    //if (iPad) {
        
        [UIView
         animateWithDuration:0.0f
         
         animations:^{
             
             [self.view setTransform: CGAffineTransformMakeRotation(M_PI / 2)];
             
             
             if (!iPad) {
                 
                 self.view.frame= CGRectMake(0, 0, 568, 320);
             }
             
             
             
             
         }];
    //}
    
    
    if (!iPad) {
        NSLog(@"hide status bar....");
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self prefersStatusBarHidden];
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [_sysLabel setText:[Utility getStringByKey:@"sys_len"]];
    [_diaLabel setText:[Utility getStringByKey:@"dia_len"]];
    [_hrLabel setText:[Utility getStringByKey:@"hr_len"]];
    [_sysLevelLabel setText:[Utility getStringByKey:@"sys_len_pl"]];
    [_diaLevelLabel setText:[Utility getStringByKey:@"dia_len_pl"]];
    [_hrLevelLabel setText:[Utility getStringByKey:@"hr_len_pl"]];
    [_bpUnitLabel setText:[Utility getStringByKey:@"bp_graph_leftlen"]];
    [_hrUnitLabel setText:[Utility getStringByKey:@"hr_graph_leftlen"]];
    
    [_weekBtn setTitle:[Utility getStringByKey:@"7d"] forState: normal];
    [_weeksBtn setTitle:[Utility getStringByKey:@"14d"] forState: normal];
    [_monthBtn setTitle:[Utility getStringByKey:@"1m"] forState: normal];
    [_threeMonthsBtn setTitle:[Utility getStringByKey:@"3m"] forState: normal];

    



    
}



- (void)orientationChanged:(NSNotification *)note  {
    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait) {
//        
//        NSLog(@"UIInterfaceOrientationPortrait..............bp rotate");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeLeft..............bp rotate");
//    }
//    
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeRight..............bp rotate");
//    }
    
//    UIDevice * device = note.object;
    
//    if ([device orientation]==UIInterfaceOrientationPortrait) {
//        
//        NSLog(@"UIInterfaceOrientationPortrait.............222.bp rotate");
//    }
//    
//    if ([device orientation]==UIInterfaceOrientationLandscapeLeft) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeLeft........222......bp rotate");
//    }
//    
//    if ([device orientation]==UIInterfaceOrientationLandscapeRight) {
//        
//        NSLog(@"UIInterfaceOrientationLandscapeRight.........2222.....bp rotate");
//    }
    
    UIDeviceOrientation o = [[UIDevice currentDevice] orientation];
	switch (o) {
		case UIDeviceOrientationPortrait:
            //if (iPad) {
            
            
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            
                [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] hideRotateView];
                
                
                
//            }else{
//                
//                
//                [self dismissViewControllerAnimated:YES completion:nil];
//                
//                
//            }
            break;
            
		default:
			break;
	}
}

-(IBAction)changePeriod:(id)sender{
    
    
    UIButton *btn=sender;
    
    NSLog(@"click ......%ld",(long)btn.tag);
    
    if (btn.tag==7) {
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:170.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
        
        self.threeMonthsBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
        
        
        
        
        [self.weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.threeMonthsBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupBPChart:7];

        
        
        
    }
    else if (btn.tag==14){
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:170.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
        
        self.threeMonthsBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
        
        
        
        [self.weeksBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.threeMonthsBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupBPChart:14];

        
        
    }
    else if (btn.tag==30){
        
        
        BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenDashBoard];
        NSLog(@"checkLoadView:%d",checkLoadView);
        if(checkLoadView){
            _WaitingView.hidden=true;
            
            
            
            self.monthBtn.backgroundColor=[UIColor colorWithRed:170.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1.0f];
            
            self.weeksBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
            
            self.weekBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
            
            self.threeMonthsBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
            
            
            
            [self.monthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.weekBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.weeksBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.threeMonthsBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            [self setupBPChart:30];
            

  
        }
        else{
            
            _WaitingView.hidden=false;
            
        }

        
        
        
        
        
        
        
        
    }
    else if (btn.tag==90){
        
        
        BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenDashBoard];
        NSLog(@"checkLoadView:%d",checkLoadView);
        if(checkLoadView){
            _WaitingView.hidden=true;
            
            
            self.threeMonthsBtn.backgroundColor=[UIColor colorWithRed:170.0f/255.0f green:70.0f/255.0f blue:70.0f/255.0f alpha:1.0f];
            
            self.weeksBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
            
            self.weekBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
            
            self.monthBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
            
            
            
            [self.threeMonthsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.weekBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.weeksBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.monthBtn setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            [self setupBPChart:90];
            

            
        }
        else{
            
            _WaitingView.hidden=false;
            
        }

        
        
        
        
    }
    
    
}


-(void) setupBPChart:(int)period{
    
    
    NSDate *tmp=[NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour| NSCalendarUnitMinute | NSCalendarUnitSecond;
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
    
    BloodPressureList *bpList;
    
    if (period==7||period==14) {
        
        bpList=[DBHelper getBPByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:-1];
        
    }else{
        
        NSLog(@"get average data...%d",period);
        
        bpList=[DBHelper getBPAverageChartByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:period];
    }
    
    
    NSLog(@"count.......%lu",(unsigned long)[bpList.bpList count]);
    
    NSMutableArray *timeData=[[NSMutableArray alloc] init];
    NSMutableArray *sysData=[[NSMutableArray alloc] init];
    NSMutableArray *diaData=[[NSMutableArray alloc] init];
    NSMutableArray *hrData=[[NSMutableArray alloc] init];
    
    NSMutableArray *missData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger j=[bpList.bpList count]-1; j>-1; j--) {
        
        BloodPressure *bp=[bpList.bpList objectAtIndex:j];
        
        long time=[bp getRecordtime];
        
        [timeData addObject:@(time)];
        
        int miss=[bp getMissprevious];
        
        [missData addObject:@(miss)];
        
        NSInteger sys=[bp.sys integerValue];
        
        
        NSInteger dia=[bp.dia integerValue];
        
        NSInteger hr=[bp.heartrate integerValue];
        
        
        [hrData addObject:@(hr+BPALL_MOVE_POS)];
        
       // NSLog(@"%d,,,,,%ld.......%ld.......%ld......%@",miss,(long)sys,(long)dia,(long)hr,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
        
        [sysData addObject:@(sys)];
        
        [diaData addObject:@(dia)];
        
        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
        d1x.itemCount = [sysData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [sysData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }
    
    LineChartData *d2x = [LineChartData new];
    {
        
        d2x.xMin = [recordEnd timeIntervalSince1970];
        d2x.xMax = [recordStart timeIntervalSince1970];
        d2x.title = @" ";
        d2x.color = [UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1];
        d2x.itemCount = [diaData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        d2x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [diaData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            
            //NSLog(@"%@..   label   ...%@",label1,label2);
            
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }

    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1];
        d3x.itemCount = [hrData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [hrData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[missData[item] integerValue]];
        };
    }

    
    
    bpChart.yMin = 50;
    bpChart.yMax = 250;
    
    bpChart.xMin = [recordEnd timeIntervalSince1970];
    bpChart.xMax = [recordStart timeIntervalSince1970];
    
    bpChart.ySteps = @[@"100",@"120",@"140",@"160",@"180",@"200"];
    bpChart.data = @[d1x,d2x,d3x];
    
    
    bpChart.drawsDataPoints = YES;
    
    bpChart.drawsDataLines = YES;
    
    bpChart.drawsBG=YES;
    
    bpChart.enableTouch=NO;
    
    bpChart.isRotate=YES;
    
    bpChart.xLabelCount=period;
    
    bpChart.chartType=TYPE_BPALL;

    
    [bpChart setNeedsDisplay];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    NSLog(@"hide bp rotate.............");
    
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait) {
        
        NSLog(@"UIInterfaceOrientationPortrait.........eee.....bp rotate");
    }
    
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft) {
        
        NSLog(@"UIInterfaceOrientationLandscapeLeft.....eee.........bp rotate");
    }
    
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        
        NSLog(@"UIInterfaceOrientationLandscapeRight....eeee..........bp rotate");
    }

    
    [[UIApplication sharedApplication] setStatusBarOrientation:1 animated:NO];
    

    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[UIDevice  currentDevice] endGeneratingDeviceOrientationNotifications ];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    return UIInterfaceOrientationIsLandscape(interfaceOrientation);

}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    
//    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
// 
//}

@end
