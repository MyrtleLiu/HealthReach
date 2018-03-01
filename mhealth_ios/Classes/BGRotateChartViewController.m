//
//  BGRotateChartViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-9-3.
//
//

#import "BGRotateChartViewController.h"
#import "DBHelper.h"
#import "Utility.h"
#import "mHealth_iPhoneAppDelegate.h"

@interface BGRotateChartViewController ()

@end

@implementation BGRotateChartViewController

@synthesize bgChart;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (!iPad) {
        
        self = [super initWithNibName:@"BGRotateChartViewController" bundle:nibBundleOrNil];
    }
    else
    {
        
        self = [super initWithNibName:@"BGRotateChartViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
    }
    
     [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setRotateBGView:self];
    
        
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
    [self setupBGChart:7];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];
    
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
       // NSLog(@"hide status bar....");
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [self.navigationController setNavigationBarHidden:YES];
        
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self prefersStatusBarHidden];
            [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    
    [_beforeLabel setText:[Utility getStringByKey:@"before_len"]];
    [_afterLabel setText:[Utility getStringByKey:@"after_len"]];
    [_fastLabel setText:[Utility getStringByKey:@"fasting_len"]];
    [_beforeLevelLabel setText:[Utility getStringByKey:@"before_len_pl"]];
    [_afterLevelLabel setText:[Utility getStringByKey:@"after_len_pl"]];
    [_fastLevelLabel setText:[Utility getStringByKey:@"fasting_len_pl"]];
    [_bgUnitLabel setText:[Utility getStringByKey:@"label_mmol"]];
    
    
    [_unspecialLevelLabel setText:[Utility getStringByKey:@"unspecified_chart_level_text"]];
    [_unspecialLevelLabel setHidden:true];
   [_unspecialLabel setText:[Utility getStringByKey:@"unspecified_chart_text"]];
    

    
    [_weekBtn setTitle:[Utility getStringByKey:@"7d"] forState: normal];
    [_weeksBtn setTitle:[Utility getStringByKey:@"14d"] forState: normal];
    [_monthBtn setTitle:[Utility getStringByKey:@"1m"] forState: normal];
    [_monthsBtn setTitle:[Utility getStringByKey:@"3m"] forState: normal];
    
    
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
    
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    

    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[UIDevice  currentDevice] endGeneratingDeviceOrientationNotifications ];
    
    
}

-(IBAction)changePeriod:(id)sender{
    
    
    UIButton *btn=sender;
    
    if (btn.tag==7) {
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:140.0f/255.0f green:70.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        
        
        
        
        [self.weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupBGChart:7];
        
        
        
        
    }else if (btn.tag==14){
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:140.0f/255.0f green:70.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        
        
        
        [self.weeksBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupBGChart:14];
        
        
        
    }else if (btn.tag==30){
        BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenDashBoard];
        NSLog(@"checkLoadView:%d",checkLoadView);
        if(checkLoadView){
            _WaitingView.hidden=true;
            
            
            self.monthBtn.backgroundColor=[UIColor colorWithRed:140.0f/255.0f green:70.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
            
            self.weeksBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            
            self.weekBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            
            self.monthsBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            
            
            
            [self.monthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.weekBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.weeksBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.monthsBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            [self setupBGChart:30];
            

            
            
            
        }else{
            _WaitingView.hidden=false;

        }
        
        
        
    }else if (btn.tag==90){
        
        BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenDashBoard];
        NSLog(@"checkLoadView:%d",checkLoadView);
        if(checkLoadView){
            _WaitingView.hidden=true;
            
            
            self.monthsBtn.backgroundColor=[UIColor colorWithRed:140.0f/255.0f green:70.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
            
            self.weeksBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            
            self.weekBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            
            self.monthBtn.backgroundColor=[UIColor colorWithRed:100.0f/255.0f green:50.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            
            
            
            [self.monthsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.weekBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.weeksBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [self.monthBtn setTitleColor:[UIColor colorWithRed:240.0f/255.0f green:160.0f/255.0f blue:240.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            
            [self setupBGChart:90];

            
            

        }else{
            _WaitingView.hidden=false;
        }
        
        
        
        
    }
    
    
}


-(void) setupBGChart:(int)period{
    
    
    NSDate *tmp=[NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
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
    
    BloodGlucoseList *bgResultList;
    
    if (period==7||period==14) {
        
        bgResultList=[DBHelper getBGByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:-1];
        
    }else{
        
        bgResultList=[DBHelper getBGAverageChartByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:period];
    }
    
    
    //NSLog(@"count.......%d",[bgResultList.bgList count]);
    
    NSMutableArray *timebeforData=[[NSMutableArray alloc] init];
    NSMutableArray *timeafterData=[[NSMutableArray alloc] init];
    NSMutableArray *timeemptyData=[[NSMutableArray alloc] init];
    NSMutableArray *timeundefineData=[[NSMutableArray alloc] init];
    
    
    NSMutableArray *beforData=[[NSMutableArray alloc] init];
    NSMutableArray *afterData=[[NSMutableArray alloc] init];
    NSMutableArray *emptyData=[[NSMutableArray alloc] init];
    NSMutableArray *undefineData=[[NSMutableArray alloc] init];
    
    NSMutableArray *beforMiss=[[NSMutableArray alloc] init];
    NSMutableArray *afterMiss=[[NSMutableArray alloc] init];
    NSMutableArray *emptyMiss=[[NSMutableArray alloc] init];
    NSMutableArray *undefineMiss=[[NSMutableArray alloc] init];
    
    
    for (NSInteger j=[bgResultList.bgList count]-1; j>-1; j--) {
        
        BloodGlucose *bg=[bgResultList.bgList objectAtIndex:j];
        
        long time=[bg getRecordtime];
        
        int miss=[bg getMissprevious];
        
        NSLog(@"bg miss....2..%d",miss);
        
        float bgValue=[bg.bg floatValue];
        
        
        if ([bg.type isEqualToString:@"B"]) {
            
            [beforData addObject:@(bgValue)];
            
            [timebeforData addObject:@(time)];
            
            [beforMiss addObject:@(miss)];
            
        }else if ([bg.type isEqualToString:@"A"]){
            
            [afterData addObject:@(bgValue)];
            
            [timeafterData addObject:@(time)];
            
            [afterMiss addObject:@(miss)];
            
        }else if ([bg.type isEqualToString:@"F"]){
            
            [emptyData addObject:@(bgValue)];
            
            [timeemptyData addObject:@(time)];
            
            [emptyMiss addObject:@(miss)];
            
        }else if ([bg.type isEqualToString:@"U"]){
            
            [undefineData addObject:@(bgValue)];
            
            [timeundefineData addObject:@(time)];
            
            [undefineMiss addObject:@(miss)];
            
        }
        
        
        
        
       // NSLog(@"%f..........%@..........%@",bgValue,bg.type,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
        
        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1];
        d1x.itemCount = [beforData count];
        
        
        [timebeforData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [timebeforData[item] floatValue];
            float y = [beforData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[beforMiss[item] integerValue]];
        };
    }
    
    LineChartData *d2x = [LineChartData new];
    {
        
        d2x.xMin = [recordEnd timeIntervalSince1970];
        d2x.xMax = [recordStart timeIntervalSince1970];
        d2x.title = @" ";
        d2x.color = [UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1];
        d2x.itemCount = [afterData count];
        
        
        [timeafterData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        d2x.getData = ^(NSUInteger item) {
            float x = [timeafterData[item] floatValue];
            float y = [afterData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            
            //NSLog(@"%@..   label   ...%@",label1,label2);
            
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[afterMiss[item] integerValue]];
        };
    }
    
    
    
    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
        d3x.itemCount = [emptyData count];
        
        
        [timeemptyData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [timeemptyData[item] floatValue];
            float y = [emptyData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[emptyMiss[item] integerValue]];
        };
    }

    LineChartData *d4x = [LineChartData new];
    {
        
        d4x.xMin = [recordEnd timeIntervalSince1970];
        d4x.xMax = [recordStart timeIntervalSince1970];
        d4x.title = @" ";
        d4x.color = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1];
        d4x.itemCount = [undefineData count];
        
        
        [timeundefineData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d4x.getData = ^(NSUInteger item) {
            float x = [timeundefineData[item] floatValue];
            float y = [undefineData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:[undefineMiss[item] integerValue]];
        };
    }
    
    
    bgChart.yMin = 2;
    bgChart.yMax = 20;
    
    bgChart.xMin = [recordEnd timeIntervalSince1970];
    bgChart.xMax = [recordStart timeIntervalSince1970];
    
    bgChart.ySteps = @[@"100",@"120",@"140",@"160",@"180",@"200"];
    bgChart.data = @[d1x,d2x,d3x,d4x];
    
    //bgChart.startColor=[UIColor colorWithRed:140.0f/255.0f green:70.0f/255.0f blue:140.0f/255.0f alpha:1];

    //bgChart.endColor=[UIColor colorWithRed:140.0f/255.0f green:70.0f/255.0f blue:140.0f/255.0f alpha:1];
    
    
    bgChart.drawsDataPoints = YES;
    
    bgChart.drawsDataLines = YES;
    
    bgChart.drawsBG=YES;
    
    bgChart.enableTouch=NO;
    
    bgChart.isRotate=YES;
    
    bgChart.xLabelCount=period;
    
    bgChart.chartType=TYPE_BG;
    
    [bgChart setNeedsDisplay];
    
    
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


@end
