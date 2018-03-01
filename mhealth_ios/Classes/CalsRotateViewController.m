//
//  CalsRotateViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-9-4.
//
//

#import "CalsRotateViewController.h"
#import "DBHelper.h"
#import "Utility.h"
#import "mHealth_iPhoneAppDelegate.h"
@interface CalsRotateViewController ()

@end

@implementation CalsRotateViewController

@synthesize calsChart;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (!iPad) {
        
        self = [super initWithNibName:@"CalsRotateViewController" bundle:nibBundleOrNil];
    }
    else
    {
        
        self = [super initWithNibName:@"CalsRotateViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
    }
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
    
    
    [self setupCalsChart:7];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    if (iPad) {
    
        [UIView
         animateWithDuration:0.0f
         
         animations:^{
             
             [self.view setTransform: CGAffineTransformMakeRotation(M_PI / 2)];
             
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
    
    [_weekBtn setTitle:[Utility getStringByKey:@"7d"] forState: normal];
    [_weeksBtn setTitle:[Utility getStringByKey:@"14d"] forState: normal];
    [_monthBtn setTitle:[Utility getStringByKey:@"1m"] forState: normal];
    [_monthsBtn setTitle:[Utility getStringByKey:@"3m"] forState: normal];
    
    
    [_calsLabel setText:[Utility getStringByKey:@"cals_intake"]];
    [_calsburnLabel setText:[Utility getStringByKey:@"cals_burned"]];
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
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:70.0f/255.0f green:100.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        
        
        
        [self.weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupCalsChart:7];
        
        
        
        
    }else if (btn.tag==14){
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:70.0f/255.0f green:100.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        
        
        [self.weeksBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupCalsChart:14];
        
        
        
    }else if (btn.tag==30){
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:70.0f/255.0f green:100.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        
        
        [self.monthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [self setupCalsChart:30];
        
        
        
    }else if (btn.tag==90){
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:70.0f/255.0f green:100.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:40.0f/255.0f green:70.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
        
        
        
        [self.monthsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:160.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [self setupCalsChart:90];
        
        
        
    }
    
    
}


-(void) setupCalsChart:(int)period{
    

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
    
    NSMutableArray *calsResultList=[DBHelper getCaloriesRecordsByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970]];

    NSArray *trainList;
    
    if (period==7||period==14) {
        
        trainList=[DBHelper getCWRecordDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] type:-2];
    }else{
        
        
        trainList=[DBHelper getTrainAverageChartRecordDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] type:period];
        
    }
    
    
    
    NSArray *cwList;
    
    if (period==7||period==14) {
        
        cwList=[DBHelper getCWRecordDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] type:-1];
    }else{
        
        cwList=[DBHelper getCWAverageChartRecordDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] type:period];
    }
    

    
    NSMutableArray *calsTimeData=[[NSMutableArray alloc] init];
   
    NSMutableArray *calsburnData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger x=0; x<period; x++) {
        
        NSDate *theDate=[recordEnd dateByAddingTimeInterval:(x*(24*60*60))];
        
        long theTime=[theDate timeIntervalSince1970];

        NSInteger theCals=0;
        
        for (NSInteger j=[trainList count]-1; j>-1; j--) {
            
            WalkingRecord *walking=[trainList objectAtIndex:j];
            
            long time=[walking getRecordtime];
            
            NSDate *wDate=[[NSDate alloc] initWithTimeIntervalSince1970:time];
            
            // NSLog(@"%@.........the train date",wDate);
            
            if ([Utility isSameDayDate:theDate theDate:wDate]) {

                NSInteger cals=[walking.calsburnt integerValue];

                theCals=theCals+cals;
                
                
                
                
            }
            
            
        }
        
        for (NSInteger j=[cwList count]-1; j>-1; j--) {
            
            WalkingRecord *walking=[cwList objectAtIndex:j];
            
            long time=[walking getRecordtime];
            
            NSDate *wDate=[[NSDate alloc] initWithTimeIntervalSince1970:time];
            
            // NSLog(@"%@.........the cw date",wDate);
            
            if ([Utility isSameDayDate:theDate theDate:wDate]) {

                NSInteger cals=[walking.calsburnt integerValue];

                theCals=theCals+cals;
                
                
                
                
            }
            
            
        }

        
        if (theCals>0) {
            
            [calsTimeData addObject:@(theTime)];
            
            [calsburnData addObject:@(theCals)];
        }
        
        
        
    }
    

    
    
    NSMutableArray *timeData=[[NSMutableArray alloc] init];
    
    NSMutableArray *calsData=[[NSMutableArray alloc] init];
    
   
    for (NSInteger j=[calsResultList count]-1; j>-1; j--) {
        
        NSDictionary *cals=[calsResultList objectAtIndex:j];
        
        // NSLog(@"!!item..............:%@",cals);
        
        NSString *time=[cals objectForKey:@"recordtime"];
        
        [timeData addObject:@([time longLongValue])];
                
        NSString *calsValue=[cals objectForKey:@"total_cals"];

        
        [calsData addObject:@([calsValue longLongValue])];
        
        
        //NSLog(@"%@..........1........%@",calsValue,time);
        
        
        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1];
        d1x.itemCount = [calsData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [calsData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:-1];
        };
    }
    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1];
        d3x.itemCount = [calsburnData count];
        
        
        [calsTimeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [calsTimeData[item] floatValue];
            float y = [calsburnData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:1];
        };
    }
    
    calsChart.yMin = 500;
    calsChart.yMax = 2000;
    calsChart.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    calsChart.data = @[d1x,d3x];
    
    
    NSNumber *max_food=[calsData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_food=[calsData valueForKeyPath:@"@min.self"];
    
    NSNumber *max_cals=[calsburnData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_cals=[calsburnData valueForKeyPath:@"@min.self"];
    
    
    
    int max_cals_value=max_food.floatValue>max_cals.floatValue?max_food.intValue:max_cals.intValue;
    
    int min_cals_value=min_food.floatValue<min_cals.floatValue?min_food.intValue:min_cals.intValue;
    
    
   // NSLog(@"%d.....hr test.....%d",max_cals_value,min_cals_value);
    
    if (max_cals_value>2000) {
        
        
        calsChart.yMax = max_cals_value+10;
        
    }
    
    if (min_cals_value<500&&min_cals_value>=0) {
        
        
        calsChart.yMin = min_cals_value-10<0?0:min_cals_value-10;
        
    }
    

       
    
    //calsChart.yMin = 0;
    //calsChart.yMax = 2000;
    
    calsChart.xMin = [recordEnd timeIntervalSince1970];
    calsChart.xMax = [recordStart timeIntervalSince1970];
    
    calsChart.ySteps = @[@"100",@"120",@"140",@"160",@"180",@"200"];
    calsChart.data = @[d1x,d3x];
    
    
    calsChart.drawsDataPoints = YES;
    
    calsChart.drawsDataLines = YES;
    
    calsChart.drawsBG=YES;
    
    calsChart.enableTouch=NO;
    
    calsChart.isRotate=YES;
    
    calsChart.xLabelCount=period;
    
    [calsChart setNeedsDisplay];
    
    
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
