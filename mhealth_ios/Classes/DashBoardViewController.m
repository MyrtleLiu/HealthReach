//
//  DashBoardViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-9-1.
//
//

#import "DashBoardViewController.h"
#import "DBHelper.h"
#import "BloodPressure.h"
#import "DashBoardSettingViewController.h"
#import "GlobalVariables.h"

#import "mHealth_iPhoneAppDelegate.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

@synthesize bpChart,hrChart,bgChart,walkingChart,weightChart,bmiChart,calsChart;


UIColor *bg_color;

NSInteger period=7;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (!iPad) {
        self = [super initWithNibName:@"DashBoardViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"DashBoardViewController_ipad" bundle:nibBundleOrNil];

        
        
        NSLog(@"iphone4...........1");
    }
    
    if (self) {
        // Custom initialization
        
        bg_color=[UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1];
    }
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setDashBoardView:self];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *loaddata=[defaults objectForKey:@"loaddata"];
    
    
    
    
    
    
    
    return self;
}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self setupText];
    
    bpChart.chartType=-1;
    hrChart.chartType=-1;
    bgChart.chartType=-1;
    weightChart.chartType=-1;
    bmiChart.chartType=-1;
    walkingChart.chartType=-1;
    calsChart.chartType=-1;
    
    
    [self.editDashboardBtn setTitle:[Utility getStringByKey:@"Edit"] forState:UIControlStateNormal];
    
    
    if([Utility getBPSort]==nil){
        
        [_bpTitel setText:[Utility getStringByKey:@"preset_bp" ]];
        
    }else{
        
        NSInteger sort=[[Utility getBPSort] integerValue];
        
        if(sort==0){
            
            [_bpTitel setText:[Utility getStringByKey:@"preset_bp" ]];
            
        }else if (sort==1){
            [_ecgTitel setText:[Utility getStringByKey:@"preset_bp" ]];
            
        }else if (sort==2){
            
            [_bgTitel setText:[Utility getStringByKey:@"preset_bp" ]];
            
        }else if (sort==3){
            
            [_weightTitel setText:[Utility getStringByKey:@"preset_bp" ]];
            
        }else if (sort==4){
            
            [_bmiTitel setText:[Utility getStringByKey:@"preset_bp" ]];
            
        }else if (sort==5){
            
            [_walkTitel setText:[Utility getStringByKey:@"preset_bp" ]];
            
        }else if (sort==6){
            
            [_calTitel setText:[Utility getStringByKey:@"preset_bp" ]];
        }
        
    }
    
    
    if([Utility getHRSort]==nil){
        
        [_ecgTitel setText:[Utility getStringByKey:@"heart_rate" ]];
        
    }else{
        
        NSInteger sort=[[Utility getHRSort] integerValue];
        
        if(sort==0){
            
            [_bpTitel setText:[Utility getStringByKey:@"heart_rate" ]];
            
        }else if (sort==1){
            [_ecgTitel setText:[Utility getStringByKey:@"heart_rate" ]];
            
        }else if (sort==2){
            
            [_bgTitel setText:[Utility getStringByKey:@"heart_rate" ]];
            
        }else if (sort==3){
            
            [_weightTitel setText:[Utility getStringByKey:@"heart_rate" ]];
            
        }else if (sort==4){
            
            [_bmiTitel setText:[Utility getStringByKey:@"heart_rate" ]];
            
        }else if (sort==5){
            
            [_walkTitel setText:[Utility getStringByKey:@"heart_rate" ]];
            
        }else if (sort==6){
            
            [_calTitel setText:[Utility getStringByKey:@"heart_rate" ]];
        }
        
    }
    
    
    if([Utility getBGSort]==nil){
        
        [_bgTitel setText:[Utility getStringByKey:@"preset_bg" ]];
        
    }else{
        
        NSInteger sort=[[Utility getBGSort] integerValue];
        
        if(sort==0){
            
            [_bpTitel setText:[Utility getStringByKey:@"preset_bg" ]];
            
        }else if (sort==1){
            [_ecgTitel setText:[Utility getStringByKey:@"preset_bg" ]];
            
        }else if (sort==2){
            
            [_bgTitel setText:[Utility getStringByKey:@"preset_bg" ]];
            
        }else if (sort==3){
            
            [_weightTitel setText:[Utility getStringByKey:@"preset_bg" ]];
            
        }else if (sort==4){
            
            [_bmiTitel setText:[Utility getStringByKey:@"preset_bg" ]];
            
        }else if (sort==5){
            
            [_walkTitel setText:[Utility getStringByKey:@"preset_bg" ]];
            
        }else if (sort==6){
            
            [_calTitel setText:[Utility getStringByKey:@"preset_bg" ]];
        }
        
    }

    
    if([Utility getWeightSort]==nil){
        
        [_weightTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
        
    }else{
        
        NSInteger sort=[[Utility getWeightSort] integerValue];
        
        if(sort==0){
            
            [_bpTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
            
        }else if (sort==1){
            [_ecgTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
            
        }else if (sort==2){
            
            [_bgTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
            
        }else if (sort==3){
            
            [_weightTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
            
        }else if (sort==4){
            
            [_bmiTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
            
        }else if (sort==5){
            
            [_walkTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
            
        }else if (sort==6){
            
            [_calTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
        }
        
    }
    
    
    if([Utility getBMISort]==nil){
        
        [_bmiTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
        
    }else{
        
        NSInteger sort=[[Utility getBMISort] integerValue];
        
        if(sort==0){
            
            [_bpTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
            
        }else if (sort==1){
            [_ecgTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
            
        }else if (sort==2){
            
            [_bgTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
            
        }else if (sort==3){
            
            [_weightTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
            
        }else if (sort==4){
            
            [_bmiTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
            
        }else if (sort==5){
            
            [_walkTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
            
        }else if (sort==6){
            
            [_calTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
        }
        
    }

    
    if([Utility getWalkDurationSort]==nil){
        
        [_walkTitel setText:[Utility getStringByKey:@"composite_walk" ]];
        
    }else{
        
        NSInteger sort=[[Utility getWalkDurationSort] integerValue];
        
        if(sort==0){
            
            [_bpTitel setText:[Utility getStringByKey:@"composite_walk" ]];
            
        }else if (sort==1){
            [_ecgTitel setText:[Utility getStringByKey:@"composite_walk" ]];
            
        }else if (sort==2){
            
            [_bgTitel setText:[Utility getStringByKey:@"composite_walk" ]];
            
        }else if (sort==3){
            
            [_weightTitel setText:[Utility getStringByKey:@"composite_walk" ]];
            
        }else if (sort==4){
            
            [_bmiTitel setText:[Utility getStringByKey:@"composite_walk" ]];
            
        }else if (sort==5){
            
            [_walkTitel setText:[Utility getStringByKey:@"composite_walk" ]];
            
        }else if (sort==6){
            
            [_calTitel setText:[Utility getStringByKey:@"composite_walk" ]];
        }
        
    }
    
    
    if([Utility getCalsSort]==nil){
        
        [_calTitel setText:[Utility getStringByKey:@"composite_cal" ]];
        
    }else{
        
        NSInteger sort=[[Utility getCalsSort] integerValue];
        
        if(sort==0){
            
            [_bpTitel setText:[Utility getStringByKey:@"composite_cal" ]];
            
        }else if (sort==1){
            [_ecgTitel setText:[Utility getStringByKey:@"composite_cal" ]];
            
        }else if (sort==2){
            
            [_bgTitel setText:[Utility getStringByKey:@"composite_cal" ]];
            
        }else if (sort==3){
            
            [_weightTitel setText:[Utility getStringByKey:@"composite_cal" ]];
            
        }else if (sort==4){
            
            [_bmiTitel setText:[Utility getStringByKey:@"composite_cal" ]];
            
        }else if (sort==5){
            
            [_walkTitel setText:[Utility getStringByKey:@"composite_cal" ]];
            
        }else if (sort==6){
            
            [_calTitel setText:[Utility getStringByKey:@"composite_cal" ]];
        }
        
    }

    



//    
//    [_bpTitel setText:[Utility getStringByKey:@"preset_bp" ]];
//    [_ecgTitel setText:[Utility getStringByKey:@"heart_rate" ]];
//    [_bgTitel setText:[Utility getStringByKey:@"preset_bg" ]];
//    [_weightTitel setText:[Utility getStringByKey:@"personalinfo_weighttitle" ]];
//    [_bmiTitel setText:[Utility getStringByKey:@"composite_bmi" ]];
//    [_walkTitel setText:[Utility getStringByKey:@"composite_walk" ]];
//    [_calTitel setText:[Utility getStringByKey:@"composite_cal" ]];
    [_actionbar setText:[Utility getStringByKey:@"dashboard" ]];
    

    [_weekBtn setTitle:[Utility getStringByKey:@"chartTime1"] forState: normal];
    _weekBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_weeksBtn setTitle:[Utility getStringByKey:@"chartTime2"] forState: normal];
    _weeksBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_monthBtn setTitle:[Utility getStringByKey:@"chartTime3"] forState: normal];
    _monthBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_monthsBtn setTitle:[Utility getStringByKey:@"chartTime4"] forState: normal];
    _monthsBtn.titleLabel.textAlignment=NSTextAlignmentCenter;

    
    [self changePeriod:nil];
    
    
    
//    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenDashBoard];
//    NSLog(@"checkLoadView:%d",checkLoadView);
//    if(checkLoadView){
//        _WaitingView.hidden=true;
//    }
//    else{
//        
//        _WaitingView.hidden=false;
//    }

    
}

-(void) showLoadView{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *updateDateStr = [defaults objectForKey:[NSString stringWithFormat:@"update_date_averagechart_%@",[GlobalVariables shareInstance].login_id]];
    
    NSDate *today=[NSDate date];
    
    if (updateDateStr==nil) {
        
        _loadview.hidden=false;
        
        [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(dismissLoadView) userInfo:nil repeats:NO];
        
    }
    else{
        
        NSDate *update=[dateFormatter dateFromString:updateDateStr];
        
        
        BOOL result=[Utility isSameDayDate:today theDate:update];
        
        
        if (!result) {
            
            _loadview.hidden=false;
            [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(dismissLoadView) userInfo:nil repeats:NO];
            
        }else{
            
            _loadview.hidden=true;
            [self updateChart];
        }
    }
    
}

- (void)dismissLoadView
{
    
    _loadview.hidden=true;
    
    [self updateChart];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    if (!iPad) {
        
        self.contentView.contentSize = CGSizeMake(self.view.bounds.size.width, 977);
        
    }else{
        
         self.contentView.contentSize = CGSizeMake(self.view.bounds.size.width, 1064);
    }
    
    
   alertLevelDic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
    
}


-(IBAction)changePeriod:(id)sender{
    
    
    
    
    if (sender==nil) {
        
        period=7;
        
    }else{
        
        UIButton *btn=sender;
        
        period=btn.tag;
    }
    
    
    if(period==30||period==90){
        BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenDashBoard];
        NSLog(@"checkLoadView:%d",checkLoadView);
        if(checkLoadView){
            _WaitingView.hidden=true;
            
            [self showLoadView];
        }
        else{
            
            _WaitingView.hidden=false;
            
            period=7;
        }

    }else{
        
        [self updateChart];
    }
    
    
    
    

    
    
}

- (void)setupText {
    
    //self.actionTitle.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    //[self.actionTitle setText:[Utility getStringByKey:@"w_walk_title"]];
    
     [self.dataLoading setText:[Utility getStringByKey:@"data_loading" ]];
    
    
    self.weekBtn.titleLabel.font=[UIFont fontWithName:font65 size:13];
    self.weeksBtn.titleLabel.font=[UIFont fontWithName:font65 size:13];
    self.monthBtn.titleLabel.font=[UIFont fontWithName:font65 size:13];
    self.monthsBtn.titleLabel.font=[UIFont fontWithName:font65 size:13];
    
    

    
}

-(void) updateChart{
    
    
    if (period==7) {
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:42.0f/255.0f green:109.0f/255.0f blue:101.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        
        
        
        [self.weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupBPChart:7];
        
        [self setupBGChart:7];
        
        [self setupWeightChart:7];
        
        [self setupWalkingChart:7];
        
        
        
    }
    else if (period==14){
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:42.0f/255.0f green:109.0f/255.0f blue:101.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        
        
        [self.weeksBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        
        [self setupBPChart:14];
        
        [self setupBGChart:14];
        
        [self setupWeightChart:14];
        
        [self setupWalkingChart:14];
        
        
    }
    else if (period==30){
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:42.0f/255.0f green:109.0f/255.0f blue:101.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        
        
        [self.monthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthsBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [self setupBPChart:30];
        
        [self setupBGChart:30];
        
        [self setupWeightChart:30];
        
        [self setupWalkingChart:30];
        
        
    }
    else if (period==90){
        
        self.monthsBtn.backgroundColor=[UIColor colorWithRed:42.0f/255.0f green:109.0f/255.0f blue:101.0f/255.0f alpha:1.0f];
        
        self.weeksBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        self.weekBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        self.monthBtn.backgroundColor=[UIColor colorWithRed:22.0f/255.0f green:66.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        
        
        
        [self.monthsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.weekBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.weeksBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [self.monthBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:188.0f/255.0f blue:186.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
        [self setupBPChart:90];
        
        [self setupBGChart:90];
        
        [self setupWeightChart:90];
        
        [self setupWalkingChart:90];
        
        
    }
}

-(void) setupBPChart:(NSInteger)period{
    
    LineChartView *HRChartView;
    
    LineChartView *BPChartView;
    
    
    NSString *hr_sort=[Utility getHRSort];
    
    
    if (hr_sort==nil) {
        
        HRChartView=hrChart;
        
    }else{
        
        NSInteger sor_hr=[hr_sort integerValue];
        
        if(sor_hr==0){
            
            HRChartView=bpChart;
            
        }else if (sor_hr==1){
            
            HRChartView=hrChart;
            
        }else if (sor_hr==2){
            
            HRChartView=bgChart;
            
        }else if (sor_hr==3){
            
            HRChartView=weightChart;
            
        }else if (sor_hr==4){
            
            HRChartView=bmiChart;
            
        }else if (sor_hr==5){
            
            HRChartView=walkingChart;
            
        }else if (sor_hr==6){
            
            HRChartView=calsChart;
        }
        
    }
    
    
    NSString *bp_sort=[Utility getBPSort];
    
    
    if (bp_sort==nil) {
        
        BPChartView=bpChart;
        
    }else{
        
        NSInteger sort_bp=[bp_sort integerValue];
        
        if(sort_bp==0){
            
            BPChartView=bpChart;
            
        }else if (sort_bp==1){
            
            BPChartView=hrChart;
            
        }else if (sort_bp==2){
            
            BPChartView=bgChart;
            
        }else if (sort_bp==3){
            
            BPChartView=weightChart;
            
        }else if (sort_bp==4){
            
            BPChartView=bmiChart;
            
        }else if (sort_bp==5){
            
            BPChartView=walkingChart;
            
        }else if (sort_bp==6){
            
            BPChartView=calsChart;
        }
        
    }


    
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
    
    BloodPressureList *bpList;
    
    if (period==7||period==14) {
        
        bpList=[DBHelper getBPByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:0];
        
    }else{
        
        bpList=[DBHelper getBPAverageChartByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:period];
    }
    
    
    
    
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

            
            [hrData addObject:@(hr)];
            
            //NSLog(@"%d.......%d.......%d......%@",sys,dia,hr,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
            
            [sysData addObject:@(sys)];
            
            [diaData addObject:@(dia)];

            
        }

    
    
    
    LineChartData *d1x = [LineChartData new];
    {

        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:255.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1];
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
    
    
    BPChartView.startColor=bg_color;//[UIColor colorWithRed:210.0f/255.0f green:90.0f/255.0f blue:90.0f/255.0f alpha:1];
    
    //NSLog(@"color....%@",bpChart.startColor);
    
    BPChartView.endColor=bg_color;//[UIColor colorWithRed:100.0f/255.0f green:30.0f/255.0f blue:30.0f/255.0f alpha:1];
    
    //bpChart = [[LineChartView alloc] initWithFrame:bpChart.frame];
    BPChartView.yMin = 80;
    BPChartView.yMax = 160;
    BPChartView.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    BPChartView.data = @[d1x,d2x];

    NSNumber *max_dia=[diaData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_dia=[diaData valueForKeyPath:@"@min.self"];
    
    NSNumber *max_sys=[sysData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_sys=[sysData valueForKeyPath:@"@min.self"];
    
    //NSLog(@"%@.....hr test.....%@",max_hr,min_hr);
    
    int max_value=max_dia.floatValue>max_sys.floatValue?max_dia.intValue:max_sys.intValue;
    
    int min_value=min_dia.floatValue<min_sys.floatValue?min_dia.intValue:min_sys.intValue;
    
    NSString *sysValueStr=[alertLevelDic objectForKey:@"hsystolic"];
    NSString *diaValueStr=[alertLevelDic objectForKey:@"hdiastolic"];
    
    float sysline=[sysValueStr floatValue];
    float dialine=[diaValueStr floatValue];
    
    //NSLog(@"line value....%f,,,,%f",sysline,dialine);
    //
    //NSLog(@"line value..111..%d,,,,%d",max_value,min_value);  
    
    if (sysline>BPChartView.yMax) {
        
        max_value=sysline;
    }
    
    if (dialine>BPChartView.yMax) {
        
        max_value=dialine;
    }
    
    
    if (sysline<BPChartView.yMin) {
        
        min_value=sysline;
    }
    
    if (dialine<BPChartView.yMin) {
        
        min_value=dialine;
    }
    
    if (max_value>160) {
        
        
        BPChartView.yMax = max_value+10;
        
    }
    
    if (min_value<80&&min_value>0) {
        
        
        BPChartView.yMin = min_value-10<0?0:min_value-10;
        
    }

    NSLog(@"line value..22222..%d,,,,%d",max_value,min_value);
    
    BPChartView.drawsDataPoints = YES; // Uncomment to turn off circles at data points.
    
    BPChartView.drawsDataLines = YES; // Uncomment to turn off lines connecting data points.
    
    BPChartView.drawsBG=NO;
    
    BPChartView.enableTouch=NO;
    
    BPChartView.xMin = [recordEnd timeIntervalSince1970];
    BPChartView.xMax = [recordStart timeIntervalSince1970];

    
    BPChartView.isRotate=NO;
    
    BPChartView.xLabelCount=period;
    
    BPChartView.chartType=TYPE_BP;
    
    [BPChartView setNeedsDisplay];

    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:0.0f/255.0f alpha:1];
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
    
    
    
    HRChartView.startColor=bg_color;//[UIColor colorWithRed:244.0f/255.0f green:151.0f/255.0f blue:31.0f/255.0f alpha:1];

    HRChartView.endColor=bg_color;//[UIColor colorWithRed:134.0f/255.0f green:67.0f/255.0f blue:30.0f/255.0f alpha:1];
    
    
    HRChartView.yMin = 50;
    HRChartView.yMax = 130;
    HRChartView.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    HRChartView.data = @[d3x];
    
    NSNumber *max_hr=[hrData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_hr=[hrData valueForKeyPath:@"@min.self"];
    
    //NSLog(@"%@.....hr test.....%@",max_hr,min_hr);
    
    if (max_hr.floatValue>130) {
        
        
        HRChartView.yMax = max_hr.intValue+10;
        
    }
    
    if (min_hr.floatValue<50&&min_hr.floatValue>0) {
        
        
        HRChartView.yMin = min_hr.intValue-10<0?0:min_hr.intValue-10;
        
    }
    
    
    HRChartView.drawsDataPoints = YES; // Uncomment to turn off circles at data points.
    
    HRChartView.drawsDataLines = YES; // Uncomment to turn off lines connecting data points.
    
    HRChartView.drawsBG=NO;
    
    HRChartView.enableTouch=NO;
    
    HRChartView.xLabelCount=period;
    
    HRChartView.xMin = [recordEnd timeIntervalSince1970];
    HRChartView.xMax = [recordStart timeIntervalSince1970];
    
    
    HRChartView.isRotate=NO;
    
    HRChartView.chartType=TYPE_HR;
    
    [HRChartView setNeedsDisplay];

    
}


-(void) setupBGChart:(NSInteger)period{

    
    LineChartView *BGChartView;
    
    
    NSString *bg_sort=[Utility getBGSort];
    
    
    if (bg_sort==nil) {
        
        BGChartView=bgChart;
        
    }else{
        
        NSInteger sort_bg=[bg_sort integerValue];
        
        if(sort_bg==0){
            
            BGChartView=bpChart;
            
        }else if (sort_bg==1){
            
            BGChartView=hrChart;
            
        }else if (sort_bg==2){
            
            BGChartView=bgChart;
            
        }else if (sort_bg==3){
            
            BGChartView=weightChart;
            
        }else if (sort_bg==4){
            
            BGChartView=bmiChart;
            
        }else if (sort_bg==5){
            
            BGChartView=walkingChart;
            
        }else if (sort_bg==6){
            
            BGChartView=calsChart;
        }
        
    }
    

    
    NSDate *tmp=[NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
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
    
    
    //NSLog(@"%@........bg.....%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
    
    BloodGlucoseList *bgResultList;
    
    if (period==7||period==14) {
        
        bgResultList=[DBHelper getBGByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:0];
        
    }else{
        
        bgResultList=[DBHelper getBGAverageChartByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970] status:period];
    }
    
    

    
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
        
        //[timeData addObject:@(time)];
        
         int miss=[bg getMissprevious];
        
        
        //NSLog(@"bg miss......%d",miss);
        
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

        
        
        
       // NSLog(@"%f....................%@",bgValue,[[NSDate alloc] initWithTimeIntervalSince1970:time]);

        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1];
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
        d2x.color = [UIColor colorWithRed:220.0f/255.0f green:80.0f/255.0f blue:220.0f/255.0f alpha:1];
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
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:0.0f/255.0f alpha:1];
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
    
    
    BGChartView.startColor=bg_color;//[UIColor colorWithRed:170.0f/255.0f green:90.0f/255.0f blue:180.0f/255.0f alpha:1];
    
    //NSLog(@"color....%@",bgChart.startColor);
    
    BGChartView.endColor=bg_color;//[UIColor colorWithRed:80.0f/255.0f green:40.0f/255.0f blue:80.0f/255.0f alpha:1];
    
    //bpChart = [[LineChartView alloc] initWithFrame:bpChart.frame];
    BGChartView.yMin = 5;
    BGChartView.yMax = 13;
    BGChartView.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    BGChartView.data = @[d1x,d2x,d3x,d4x];
    
    
    NSNumber *max_befor=[beforData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_befor=[beforData valueForKeyPath:@"@min.self"];
    
    NSNumber *max_after=[afterData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_after=[afterData valueForKeyPath:@"@min.self"];
    
    NSNumber *max_empty=[emptyData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_empty=[emptyData valueForKeyPath:@"@min.self"];
    
    NSNumber *max_undefine=[undefineData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_undefine=[undefineData valueForKeyPath:@"@min.self"];
    
    
    int max_tmpvalue=max_befor.floatValue>max_after.floatValue?max_befor.intValue:max_after.intValue;
    
    int max_value=max_tmpvalue>max_empty.floatValue?max_tmpvalue:max_empty.intValue;
    
    max_value=max_value>max_undefine.floatValue?max_value:max_undefine.intValue;
    
    int min_tmpvalue=min_befor.floatValue<min_after.floatValue?min_befor.intValue:min_after.intValue;
    
    int min_value=min_tmpvalue<min_empty.floatValue?min_tmpvalue:min_empty.intValue;
    
    min_value=min_value<min_undefine.floatValue?min_value:min_undefine.intValue;
    
    if (max_value>13) {
        
        
        BGChartView.yMax = max_value+10;
        
    }
    
    if (min_value<5) {
        
        
        BGChartView.yMin = min_value-10<0?0:min_value-10;
        
    }

    
    BGChartView.drawsDataPoints = YES; // Uncomment to turn off circles at data points.
    
    BGChartView.drawsDataLines = YES; // Uncomment to turn off lines connecting data points.
    
    BGChartView.drawsBG=NO;
    
    BGChartView.xLabelCount=period;
    
    BGChartView.xMin = [recordEnd timeIntervalSince1970];
    BGChartView.xMax = [recordStart timeIntervalSince1970];
    
    
    BGChartView.isRotate=NO;
    
    BGChartView.enableTouch=NO;
    
    BGChartView.chartType=TYPE_BG;
    
    [BGChartView setNeedsDisplay];
    
}

-(void) setupWeightChart:(NSInteger)period{
    
    
    LineChartView *WeightChartView;
    
    LineChartView *BMIChartView;
    
    
    NSString *weight_sort=[Utility getWeightSort];
    
    
    if (weight_sort==nil) {
        
        WeightChartView=weightChart;
        
    }else{
        
        NSInteger sort_weight=[weight_sort integerValue];
        
        if(sort_weight==0){
            
            WeightChartView=bpChart;
            
        }else if (sort_weight==1){
            
            WeightChartView=hrChart;
            
        }else if (sort_weight==2){
            
            WeightChartView=bgChart;
            
        }else if (sort_weight==3){
            
            WeightChartView=weightChart;
            
        }else if (sort_weight==4){
            
            WeightChartView=bmiChart;
            
        }else if (sort_weight==5){
            
            WeightChartView=walkingChart;
            
        }else if (sort_weight==6){
            
            WeightChartView=calsChart;
        }
        
    }
    
    
    NSString *bmi_sort=[Utility getBMISort];
    
    
    if (bmi_sort==nil) {
        
        BMIChartView=bmiChart;
        
    }else{
        
        NSInteger sort_bmi=[bmi_sort integerValue];
        
        if(sort_bmi==0){
            
            BMIChartView=bpChart;
            
        }else if (sort_bmi==1){
            
            BMIChartView=hrChart;
            
        }else if (sort_bmi==2){
            
            BMIChartView=bgChart;
            
        }else if (sort_bmi==3){
            
            BMIChartView=weightChart;
            
        }else if (sort_bmi==4){
            
            BMIChartView=bmiChart;
            
        }else if (sort_bmi==5){
            
            BMIChartView=walkingChart;
            
        }else if (sort_bmi==6){
            
            BMIChartView=calsChart;
        }
        
    }
    

    
    
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
        
        int miss=[weight getMissprevious];
        
        [missData addObject:@(miss)];
        
        NSInteger weightValue=[weight.weight integerValue];
        
        
        NSInteger bmiValue=[weight.bmi integerValue];
        
        [weightData addObject:@(weightValue)];
        
        [bmiData addObject:@(bmiValue)];
        
        //NSLog(@"%ld.......%ld......WEIGHT.......%@",(long)weightValue,(long)bmiValue,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
        

        
    }
    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1];
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
    

    
    WeightChartView.startColor=bg_color;//[UIColor colorWithRed:22.0f/255.0f green:144.0f/255.0f blue:210.0f/255.0f alpha:1];
    
    //NSLog(@"color....%@",weightChart.startColor);
    
    WeightChartView.endColor=bg_color;//[UIColor colorWithRed:6.0f/255.0f green:87.0f/255.0f blue:138.0f/255.0f alpha:1];
    
    //bpChart = [[LineChartView alloc] initWithFrame:bpChart.frame];
    WeightChartView.yMin = 100;
    WeightChartView.yMax = 180;
    WeightChartView.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    WeightChartView.data = @[d1x];
    
    NSNumber *max_weight=[weightData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_weight=[weightData valueForKeyPath:@"@min.self"];
    
    NSLog(@"%@.....WEIGHT.....%@",max_weight,min_weight);
    
    if (max_weight.floatValue>180) {
        
        
        WeightChartView.yMax = max_weight.intValue+10;
        
    }
    
    if (min_weight.floatValue<100&&min_weight.floatValue>0) {
        
        
    
        WeightChartView.yMin = min_weight.intValue-10>0?min_weight.intValue-10:0;
    
    }
    
    WeightChartView.drawsDataPoints = YES; // Uncomment to turn off circles at data points.
    
    WeightChartView.drawsDataLines = YES; // Uncomment to turn off lines connecting data points.
    
    WeightChartView.drawsBG=NO;
    
    WeightChartView.enableTouch=NO;
    
    WeightChartView.xLabelCount=period;
    
    WeightChartView.xMin = [recordEnd timeIntervalSince1970];
    WeightChartView.xMax = [recordStart timeIntervalSince1970];
    
    WeightChartView.chartType=TYPE_WEIGHT_DB;
    
    WeightChartView.isRotate=NO;
    
    [WeightChartView setNeedsDisplay];
    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:0.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1];
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
    
    
    
    BMIChartView.startColor=bg_color;//[UIColor colorWithRed:2.0f/255.0f green:143.0f/255.0f blue:164.0f/255.0f alpha:1];
    
    //NSLog(@"color....%@",hrChart.startColor);
    
    BMIChartView.endColor=bg_color;//[UIColor colorWithRed:2.0f/255.0f green:86.0f/255.0f blue:115.0f/255.0f alpha:1];
    
    
    BMIChartView.yMin = 16;
    BMIChartView.yMax = 24;
    BMIChartView.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    BMIChartView.data = @[d3x];
    
    NSNumber *max_bmi=[bmiData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_bmi=[bmiData valueForKeyPath:@"@min.self"];
    
    //NSLog(@"%@.....hr test.....%@",max_hr,min_hr);
    
    if (max_bmi.floatValue>24) {
        
        
        BMIChartView.yMax = max_bmi.intValue+10;
        
    }
    
    if (min_bmi.floatValue<16&&min_bmi.floatValue>0) {
        
        
        BMIChartView.yMin = min_bmi.intValue-10<0?0:min_bmi.intValue-10;
        
    }

    
    BMIChartView.drawsDataPoints = YES; // Uncomment to turn off circles at data points.
    
    BMIChartView.drawsDataLines = YES; // Uncomment to turn off lines connecting data points.
    
    BMIChartView.drawsBG=NO;
    
    BMIChartView.enableTouch=NO;
    
    BMIChartView.chartType=TYPE_BMI;
    
    BMIChartView.xLabelCount=period;
    
    BMIChartView.xMin = [recordEnd timeIntervalSince1970];
    BMIChartView.xMax = [recordStart timeIntervalSince1970];

    BMIChartView.isRotate=NO;
    
    [BMIChartView setNeedsDisplay];
    
    
}

-(void) setupWalkingChart:(NSInteger)period{
    
    
    LineChartView *WalkChartView;
    
    LineChartView *CalsChartView;
    
    
    NSString *walk_sort=[Utility getWalkDurationSort];
    
    
    if (walk_sort==nil) {
        
        WalkChartView=walkingChart;
        
    }else{
        
        NSInteger sort_walk=[walk_sort integerValue];
        
        if(sort_walk==0){
            
            WalkChartView=bpChart;
            
        }else if (sort_walk==1){
            
            WalkChartView=hrChart;
            
        }else if (sort_walk==2){
            
            WalkChartView=bgChart;
            
        }else if (sort_walk==3){
            
            WalkChartView=weightChart;
            
        }else if (sort_walk==4){
            
            WalkChartView=bmiChart;
            
        }else if (sort_walk==5){
            
            WalkChartView=walkingChart;
            
        }else if (sort_walk==6){
            
            WalkChartView=calsChart;
        }
        
    }
    
    
    NSString *cals_sort=[Utility getCalsSort];
    
    
    if (cals_sort==nil) {
        
        CalsChartView=calsChart;
        
    }else{
        
        NSInteger sort_cals=[cals_sort integerValue];
        
        if(sort_cals==0){
            
            CalsChartView=bpChart;
            
        }else if (sort_cals==1){
            
            CalsChartView=hrChart;
            
        }else if (sort_cals==2){
            
            CalsChartView=bgChart;
            
        }else if (sort_cals==3){
            
            CalsChartView=weightChart;
            
        }else if (sort_cals==4){
            
            CalsChartView=bmiChart;
            
        }else if (sort_cals==5){
            
            CalsChartView=walkingChart;
            
        }else if (sort_cals==6){
            
            CalsChartView=calsChart;
        }
        
    }
    
    
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
    
    
   // NSLog(@"%@.............%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
    
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
    
    
    
    //NSLog(@"count....%lu......%lu",(unsigned long)[trainList count],(unsigned long)[cwList count]);
    
    NSMutableArray *cwTimeData=[[NSMutableArray alloc] init];
    NSMutableArray *trainTimeData=[[NSMutableArray alloc] init];
    NSMutableArray *calsTimeData=[[NSMutableArray alloc] init];
    NSMutableArray *cwDurationData=[[NSMutableArray alloc] init];
    NSMutableArray *trainDurationData=[[NSMutableArray alloc] init];
    NSMutableArray *calsData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger x=0; x<period; x++) {
        
        NSDate *theDate=[recordEnd dateByAddingTimeInterval:(x*(24*60*60))];
        
        long theTime=[theDate timeIntervalSince1970];
        
       // NSLog(@"%@.........the date",theDate);
        
        NSInteger theDuration=0;
        NSInteger theCals=0;
        
        for (NSInteger j=[trainList count]-1; j>-1; j--) {
            
            WalkingRecord *walking=[trainList objectAtIndex:j];
            
            long time=[walking getRecordtime];
            
            NSDate *wDate=[[NSDate alloc] initWithTimeIntervalSince1970:time];
            
            // NSLog(@"%@.........the train date",wDate);
            
            if ([Utility isSameDayDate:theDate theDate:wDate]) {
                
                
                
                float duration=[walking getPersistime]/60.0f;
                
                NSInteger cals=[walking.calsburnt integerValue];
                
                //NSLog(@"result...1..%ld...%ld",(long)duration,(long)cals);
                
                theDuration=theDuration+duration;
                
                theCals=theCals+cals;
                
                
                
                
            }

            
        }
        
        for (NSInteger j=[cwList count]-1; j>-1; j--) {
            
            WalkingRecord *walking=[cwList objectAtIndex:j];
            
            long time=[walking getRecordtime];
            
            NSDate *wDate=[[NSDate alloc] initWithTimeIntervalSince1970:time];
            
            // NSLog(@"%@.........the cw date",wDate);
            
            if ([Utility isSameDayDate:theDate theDate:wDate]) {
                
                
                
                float duration=[walking getPersistime]/60.0f;
                
                NSInteger cals=[walking.calsburnt integerValue];
                
                //NSLog(@"result...2..%ld...%ld",(long)duration,(long)cals);
                
                theDuration=theDuration+duration;
                
                theCals=theCals+cals;
                
                
                
                
            }
            
            
        }
        
        //NSLog(@"walk....result.....%ld...%ld.....%@",(long)theDuration,(long)theCals,theDate);
        
        if (theDuration>0) {
            
            [trainTimeData addObject:@(theTime)];
            
            [trainDurationData addObject:@(theDuration)];
            
        }
        
        if (theCals>0) {
            
            [calsTimeData addObject:@(theTime)];
            
            [calsData addObject:@(theCals)];
        }
        

        
    }
    
    
//    for (NSInteger j=[trainList count]-1; j>-1; j--) {
//        
//        WalkingRecord *walking=[trainList objectAtIndex:j];
//        
//        long time=[walking getRecordtime];
//        
//        [trainTimeData addObject:@(time)];
//        [calsTimeData addObject:@(time)];
//        
//        float duration=[walking getPersistime]/60.0f;
//        
//        NSInteger cals=[walking.calsburnt integerValue];
//
//        [calsData addObject:@(cals)];
//        [trainDurationData addObject:@(duration)];
//        
//      //  NSLog(@"%f.....walk reconrd......%d.........%@",duration,cals,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
//
//        
//    }
//    
//    
//    
//    
//    for (NSInteger j=[cwList count]-1; j>-1; j--) {
//        
//        WalkingRecord *walking=[cwList objectAtIndex:j];
//        
//        long time=[walking getRecordtime];
//        
//        //[cwTimeData addObject:@(time)];
//        [trainTimeData addObject:@(time)];
//        [calsTimeData addObject:@(time)];
//        
//        NSInteger duration=[walking getPersistime]/60;
//        
//        NSInteger cals=[walking.calsburnt integerValue];
//        
//        [calsData addObject:@(cals)];
//        //[cwDurationData addObject:@(duration)];
//        [trainDurationData addObject:@(duration)];
//        
//       // NSLog(@"%d.....walk reconrd......%d.........%@",duration,cals,[[NSDate alloc] initWithTimeIntervalSince1970:time]);
//        
//        
//    }
//    
    
    
    
    LineChartData *d1x = [LineChartData new];
    {
        
        d1x.xMin = [recordEnd timeIntervalSince1970];
        d1x.xMax = [recordStart timeIntervalSince1970];
        d1x.title = @" ";
        d1x.color = [UIColor colorWithRed:90.0f/255.0f green:180.0f/255.0f blue:200.0f/255.0f alpha:1];
        d1x.itemCount = [trainDurationData count];
        
        
        [trainTimeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d1x.getData = ^(NSUInteger item) {
            float x = [trainTimeData[item] floatValue];
            float y = [trainDurationData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:1];
        };
    }
    
    LineChartData *d2x = [LineChartData new];
    {
        
        d2x.xMin = [recordEnd timeIntervalSince1970];
        d2x.xMax = [recordStart timeIntervalSince1970];
        d2x.title = @" ";
        d2x.color = [UIColor colorWithRed:70.0f/255.0f green:200.0f/255.0f blue:70.0f/255.0f alpha:1];
        d2x.itemCount = [cwDurationData count];
        
        
        [cwTimeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        d2x.getData = ^(NSUInteger item) {
            float x = [cwTimeData[item] floatValue];
            float y = [cwDurationData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            
            //NSLog(@"%@..   label   ...%@",label1,label2);
            
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:1];
        };
    }
    
    
    WalkChartView.startColor=bg_color;//[UIColor colorWithRed:141.0f/255.0f green:161.0f/255.0f blue:33.0f/255.0f alpha:1];
    
    
    WalkChartView.endColor=bg_color;//[UIColor colorWithRed:68.0f/255.0f green:88.0f/255.0f blue:7.0f/255.0f alpha:1];
    
    
    WalkChartView.yMin = 0;
    WalkChartView.yMax = 120;
    WalkChartView.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    WalkChartView.data = @[d1x];
    
    
    NSNumber *max_t=[trainDurationData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_t=[trainDurationData valueForKeyPath:@"@min.self"];
    
    NSNumber *max_cw=[cwDurationData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_cw=[cwDurationData valueForKeyPath:@"@min.self"];
    
    
    
    int max_value=max_t.floatValue>max_cw.floatValue?max_t.intValue:max_cw.intValue;
    
    int min_value=min_t.floatValue<min_cw.floatValue?min_t.intValue:min_cw.intValue;
    
    if (max_value>120) {
        
        
        WalkChartView.yMax = max_value+10;
        
    }
    
    if (min_value<0) {
        
        
        WalkChartView.yMin = min_value-10<0?0:min_value-10;
        
    }
    
    NSLog(@"%f.....walking maxmin.....%f",WalkChartView.yMax,WalkChartView.yMin);

    
    WalkChartView.drawsDataPoints = YES; // Uncomment to turn off circles at data points.
    
    WalkChartView.drawsDataLines = YES; // Uncomment to turn off lines connecting data points.
    
    WalkChartView.drawsBG=NO;
    
    WalkChartView.enableTouch=NO;
    
    WalkChartView.xLabelCount=period;
    
    WalkChartView.xMin = [recordEnd timeIntervalSince1970];
    WalkChartView.xMax = [recordStart timeIntervalSince1970];
    
    
    WalkChartView.chartType=TYPE_WALKING;
    
    WalkChartView.isRotate=NO;
    
    [WalkChartView setNeedsDisplay];
    
    
    LineChartData *d3x = [LineChartData new];
    {
        
        d3x.xMin = [recordEnd timeIntervalSince1970];
        d3x.xMax = [recordStart timeIntervalSince1970];
        d3x.title = @" ";
        d3x.color = [UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:0.0f/255.0f alpha:1];
        d3x.itemCount = [calsData count];
        
        
        [calsTimeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d3x.getData = ^(NSUInteger item) {
            float x = [calsTimeData[item] floatValue];
            float y = [calsData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:1];
        };
    }
    
    NSMutableArray *calsResultList=[DBHelper getCaloriesRecordsByDate:[recordEnd timeIntervalSince1970] enddate:[recordStart timeIntervalSince1970]];
    
    
    NSMutableArray *timeData=[[NSMutableArray alloc] init];
    
    NSMutableArray *foodData=[[NSMutableArray alloc] init];
    
    
    for (NSInteger j=[calsResultList count]-1; j>-1; j--) {
        
        NSDictionary *cals=[calsResultList objectAtIndex:j];
        
       // NSLog(@"!!item..............:%@",cals);
        
        NSString *time=[cals objectForKey:@"recordtime"];
        
        [timeData addObject:@([time longLongValue])];
        
        NSString *calsValue=[cals objectForKey:@"total_cals"];
        
        
        [foodData addObject:@([calsValue longLongValue])];
        
        
        //NSLog(@"%@..........1........%@",calsValue,time);
        
        
        
    }
    
    
    
    
    LineChartData *d4x = [LineChartData new];
    {
        
        d4x.xMin = [recordEnd timeIntervalSince1970];
        d4x.xMax = [recordStart timeIntervalSince1970];
        d4x.title = @" ";
        d4x.color = [UIColor colorWithRed:110.0f/255.0f green:150.0f/255.0f blue:255.0f/255.0f alpha:1];
        d4x.itemCount = [foodData count];
        
        
        [timeData sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2];
        }];
        
        
        d4x.getData = ^(NSUInteger item) {
            float x = [timeData[item] floatValue];
            float y = [foodData[item] floatValue];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *label1 = [formatter stringFromDate:[recordEnd dateByAddingTimeInterval:x]];
            NSString *label2 = [NSString stringWithFormat:@"%f", y];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 missPrePoint:-1];
        };
    }
    

    
    CalsChartView.startColor=bg_color;//[UIColor colorWithRed:94.0f/255.0f green:124.0f/255.0f blue:200.0f/255.0f alpha:1];
   
    CalsChartView.endColor=bg_color;//[UIColor colorWithRed:37.0f/255.0f green:66.0f/255.0f blue:127.0f/255.0f alpha:1];
    
    
    CalsChartView.yMin = 500;
    CalsChartView.yMax = 2000;
    CalsChartView.ySteps = @[@" ",@" ",@" ",@" ",@" ",@" "];
    CalsChartView.data = @[d3x,d4x];
    
    
    NSNumber *max_food=[foodData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_food=[foodData valueForKeyPath:@"@min.self"];
    
    NSNumber *max_cals=[calsData valueForKeyPath:@"@max.self"];
    
    NSNumber *min_cals=[calsData valueForKeyPath:@"@min.self"];
    
   
    
    int max_cals_value=max_food.floatValue>max_cals.floatValue?max_food.intValue:max_cals.intValue;
    
    int min_cals_value=min_food.floatValue<min_cals.floatValue?min_food.intValue:min_cals.intValue;
    
    
     NSLog(@"%d.....hr test.....%d",max_cals_value,min_cals_value);
    
    if (max_cals_value>2000) {
        
        
        CalsChartView.yMax = max_cals_value+10;
        
    }
    
    if (min_cals_value<500&&min_cals_value>=0) {
        
        
        CalsChartView.yMin = min_cals_value-10<0?0:min_cals_value-10;
        
    }
    

    
    
    CalsChartView.drawsDataPoints = YES; // Uncomment to turn off circles at data points.
    
    CalsChartView.drawsDataLines = YES; // Uncomment to turn off lines connecting data points.
    
    CalsChartView.drawsBG=NO;
    
    CalsChartView.enableTouch=NO;
    
     CalsChartView.chartType=TYPE_CALS;
    
    CalsChartView.xLabelCount=period;
    
    CalsChartView.xMin = [recordEnd timeIntervalSince1970];
    CalsChartView.xMax = [recordStart timeIntervalSince1970];
    
    CalsChartView.isRotate=NO;
    
    [CalsChartView setNeedsDisplay];
    
    
}

-(IBAction)dbsetup:(id)sender{
    
    
    DashBoardSettingViewController *setup=[[DashBoardSettingViewController alloc] initWithNibName:@"DashBoardSettingViewController" bundle:nil];

    [self.navigationController pushViewController:setup animated:YES ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
