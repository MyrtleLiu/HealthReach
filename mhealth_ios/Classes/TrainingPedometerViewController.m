//
//  TrainingPedometerViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-8-28.
//
//

#import "TrainingPedometerViewController.h"
#import "RoutePlannerViewController.h"
#import "HomeViewController.h"
#import "WalkingResultViewController.h"
#import "WalkingRecord.h"
#import "Utility.h"
#import "TrainingResultViewController.h"
#import "SyncGame.h"
#import "GameObject.h"
#import <AVFoundation/AVFoundation.h>
#import "mHealth_iPhoneAppDelegate.h"


@interface TrainingPedometerViewController (){
    BOOL isReturnRoute;
    
    BOOL firstLocationUpdate;
    
    BOOL isRunning;
    
    //step detect
    
    float mLimit;
    float mLastValues[3*2];
    float mScale[2];
    float mYOffset;
    float mLastDirections[3*2];
    float mLastExtremes[3*2][3*2];
    float mLastDiff[3*2];
    int mLastMatch;
    
    BOOL isCirculateRoute;
    float totalDistance;
    NSInteger circulateCount;
    
    int checkLongPressSound;
    BOOL heightSound;
}

@end

@implementation TrainingPedometerViewController

bool isPauseed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (iPad) {
        
        
        self = [super initWithNibName:@"TrainingPedometerViewController_iPhone4iOS7" bundle:nibBundleOrNil];
        
    }
    else{
        self =  [super initWithNibName:@"TrainingPedometerViewController" bundle:nibBundleOrNil];
    }

    
    
    if (self) {
        // Custom initialization
        
        
        
        isReturnRoute=false;
        
        self.polyline = [[GMSPolyline alloc] init];
        self.path = [GMSMutablePath path];
        
        self.plannedRoutePoints = [[NSMutableArray alloc] init];
        
        self.trackPoints = [[NSMutableArray alloc] init];
        
        self.stepCounter = [[CMPedometer alloc] init];
        
        self.motionManager = [[CMMotionManager alloc]init];
        
        self.motionManager.accelerometerUpdateInterval=0.2;
        
        self.mapView.settings.myLocationButton = YES;
        
        self.mapView.delegate=self;
        
        // Listen to the myLocation property of GMSMapView.
        [self.mapView addObserver:self
                       forKeyPath:@"myLocation"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    mLimit=10;
    mLastMatch=-1;
    
    mYOffset=480*0.5f;
    mScale[0]=-(480*0.5f*(1.0f/(9.80665*2)));
    mScale[1]=-(480*0.5f*(1.0f/60));
    
    for (int i=0; i<6; i++) {
        
        mLastValues[i]=0;
        mLastDirections[i]=0;
        mLastDiff[i]=0;
        
        for (int j=0; j<6; j++) {
            
            mLastExtremes[i][j]=0;
            
        }
        
    }
    
//       self.speedLabelUnit.frame=CGRectMake(262, 10, 38, 44);
//     self.speedLabelUnit.textAlignment=NSTextAlignmentNatural;
    
    if ([[Utility getLanguageCode] isEqualToString:@"en"])
    {
        
    }
    else{
        NSString *bstr1=[[NSBundle mainBundle]pathForResource:@"music_c" ofType:@"png" ];
        NSString *bstr2=[[NSBundle mainBundle]pathForResource:@"step_c" ofType:@"png" ];
        NSString *bstr3=[[NSBundle mainBundle]pathForResource:@"mero_c" ofType:@"png" ];
        
        UIImage * _image1=[[UIImage alloc]initWithContentsOfFile:bstr1];
        UIImage * _image2=[[UIImage alloc]initWithContentsOfFile:bstr2];
        UIImage * _image3=[[UIImage alloc]initWithContentsOfFile:bstr3];
        
        
        
        [_musicBtn setImage:_image1 forState:UIControlStateNormal];
        [_paceBtn setImage:_image2 forState:UIControlStateNormal];
        [_soundBtn setImage:_image3 forState:UIControlStateNormal];
        
    }
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.myLocationEnabled = NO;
    });
    
    @try {
        
        [self.mapView removeObserver:self
                          forKeyPath:@"myLocation"
                             context:NULL];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@.....exception",[exception description]);
    }
    @finally {
        
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    
    
    
    self.mapView.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [self.mapView addObserver:self
                   forKeyPath:@"myLocation"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];

    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.myLocationEnabled = YES;
    });
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *saveDate=[userDefaults objectForKey:@"PlannedRoute"];
    
    
    if (saveDate!=Nil) {
        
        [self.plannedRoutePoints removeAllObjects];
        
        [self.plannedRoutePoints addObjectsFromArray:saveDate];
        
        NSString *returnRoute=[userDefaults objectForKey:@"isReturnRoute"];
        
        if ([returnRoute isEqualToString:@"1"]) {
            
            isReturnRoute=true;
        }else{
            
            isReturnRoute=false;
        }
        isCirculateRoute=[userDefaults boolForKey:@"checkCirculateRoute"];
        circulateCount=[userDefaults integerForKey:@"checkCirculateCount"];
        if(circulateCount==0)
            isCirculateRoute=false;
       // NSLog(@"[userDefaults objectForKey:@checkCirculateRoute] : %hhd",[userDefaults boolForKey:@"checkCirculateRoute"]);
        NSLog(@"[userDefaults objectForKey:@checkCirculateCount] : %ld",(long)[userDefaults integerForKey :@"checkCirculateCount"]);
        
        [self updateRoute];
    }
    
    
     [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] checkLocationService];
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSInteger level=_level;
    if (level==1) {
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_bronze_title"]];
        [self.levelText setText:[Utility getStringByKey:@"b_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_bronze"];
    }else if(level==2){
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_silver_title"]];
        [self.levelText setText:[Utility getStringByKey:@"s_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_silver"];
        
    }else if(level==3){
        [self.levelTitle setText:[Utility getStringByKey:@"w_gold_title"]];
        [self.levelText setText:[Utility getStringByKey:@"g_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_gold"];
        
    }else if(level==4){
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_diamond_title"]];
        [self.levelText setText:[Utility getStringByKey:@"d_text"]];
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_diamond"];
        
    }

    
    
    
    
    
    
    [super viewWillAppear:animated];
    
    [self setupText];
    [self.actionTitle setText:[Utility getStringByKey:@"w_train_title"]];
    
    
    
    
    
    [_distanceTextLabel setText:[Utility getStringByKey:@"distance_label"]];
    [_stepsTextLabel setText:[Utility getStringByKey:@"step_label"]];
    [_paceTextLabel setText:[Utility getStringByKey:@"pace_label"]];
    [_calsTextLabel setText:[Utility getStringByKey:@"cal_label"]];
    
    [_distanceUnitLabel setText:[Utility getStringByKey:@"km_unit"]];
    [_stepsUnitLabel setText:[Utility getStringByKey:@"step_unit"]];
    [_paceUnitLabel setText:[Utility getStringByKey:@"pace_unit"]];
    [_calsUnitLabel setText:[Utility getStringByKey:@"cal_unit"]];
    
    [_speedLabelUnit setText:[Utility getStringByKey:@"km"]];
    [_speedLabelUnit2 setText:[Utility getStringByKey:@"/hour"]];
    [_speedLabelText setText:[Utility getStringByKey:@"speed"]];

    
    [_plan_route_Btn setTitle:[Utility getStringByKey:@"plan_route"] forState: normal];
    [_start_Btn setTitle:[Utility getStringByKey:@"start_btn"] forState: normal];
    [_stop_Btn setTitle:[Utility getStringByKey:@"stop_btn"] forState: normal];
    [_pause_resume_Btn setTitle:[Utility getStringByKey:@"pause_btn"] forState: normal];
    
    
    
    if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
        
        [_bottomTabView setImage:[UIImage imageNamed:@"07_wa_bottom_menu_zh.png"]];
                [_track_route_Btn setImage:[UIImage imageNamed:@"07_wa_btn_map_zh.png"] forState:UIControlStateNormal];
    }else{
        
        [_bottomTabView setImage:[UIImage imageNamed:@"07_wa_bottom_menu.png"]];
                [_track_route_Btn setImage:[UIImage imageNamed:@"07_wa_btn_map.png"] forState:UIControlStateNormal];
    }
    
    
     [_paceSetTex setText:[Utility getStringByKey:@"steps_every_min"]];
    
#define degressToRadian(x) (M_PI * (x)/180.0)
    CGAffineTransform rotation = CGAffineTransformMakeRotation(degressToRadian(270));
    _switchSound.transform = rotation;

    
    
    
    checkLongPressSound=0;
    heightSound=true;
//    [_switchSound addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    
    UIImage *minImage = [UIImage imageNamed:@"slider_yellow.png"];
    UIImage *maxImage = [UIImage imageNamed:@"maxSlider.png"];
    minImage=[minImage stretchableImageWithLeftCapWidth:30.0 topCapHeight:0.0];
    maxImage=[maxImage stretchableImageWithLeftCapWidth:30.0 topCapHeight:0.0];
    
    
    
    
    [_slider setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    _sliderView.transform = rotation;

}


-(IBAction)LongPressSound:(id)sender{
    if(_startView.hidden==true){   //判斷是否已開始
        checkLongPressSound++;
        if(checkLongPressSound%2==1){
            if(_sliderView.hidden==true)
                //                _switchSound.hidden=false;
                _sliderView.hidden=false;
            else
                //                _switchSound.hidden=true;
                _sliderView.hidden=true;
        }
    }
}

-(IBAction)checkSliderValue:(id)sender{
    if(_slider.value>0.66)
        _slider.value=1;
    else if(_slider.value<0.33)
        _slider.value=0;
    else
        _slider.value=0.5;
    [self switchAction];
}




-(void) switchAction
{
    //    UISwitch * switch = （UISwitch *）sender;
    if(_slider.value==1){
        heightSound=true;
        //        if([_checkPlaying isEqualToString:@"Y"]){
        _checkPlaying=@"Y";
        [self checkTheMP3Path];
        [_audioPlayer play];
        //        }
    }
    else if(_slider.value==0){
        if([_checkPlaying isEqualToString:@"Y"]){
            _checkPlaying=@"N";
            [_audioPlayer stop];
        }
    }
    else{
        heightSound=false;
        //        if([_checkPlaying isEqualToString:@"Y"]){
        _checkPlaying=@"Y";
        [self checkTheMP3Path];
        [_audioPlayer play];
        //        }
    }
    
}








-(IBAction)BackHome:(id)sender{
    
     if(_startView.hidden==false){
         [_audioPlayer stop];
         @try {
             
             [self.mapView removeObserver:self
                               forKeyPath:@"myLocation"
                                  context:NULL];
         }
         @catch (NSException *exception) {
             
             NSLog(@"%@.....exception",[exception description]);
         }
         @finally {
             
             
         }
         
         [self backToHome];

         
     }
    
    
}

-(IBAction)toBack:(id)sender{
    
    if(_startView.hidden==false){
        [_audioPlayer stop];
        @try {
            
            [self.mapView removeObserver:self
                              forKeyPath:@"myLocation"
                                 context:NULL];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@.....exception",[exception description]);
        }
        @finally {
            
            
        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (IBAction)toRoutePlanner:(id)sender
{
    
    @try {
        
        [self.mapView removeObserver:self
                          forKeyPath:@"myLocation"
                             context:NULL];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@.....exception",[exception description]);
    }
    @finally {
        
        
    }

    
    RoutePlannerViewController *rpView = [[RoutePlannerViewController alloc] initWithNibName:@"RoutePlannerViewController" bundle:nil];
    
    [rpView setIsFromPedometer:true];
    
    [self.navigationController pushViewController:rpView animated:YES ];
    
}


-(IBAction)startWalking:(id)sender{
    _counterView.hidden=false;
    
    NSTimer *timer2;
    timer2= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCounter2) userInfo:nil repeats:NO];
    NSTimer *timer1;
    timer1= [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateCounter1) userInfo:nil repeats:NO];
    
    NSTimer *timer;  //timer对象
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateCounterEnd) userInfo:nil repeats:NO];

    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setIsRunning:true];
    
}

-(IBAction)stopWalking:(id)sender{
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setIsRunning:false];
    
    _startView.hidden=false;
    _stopView.hidden=true;
    [_audioPlayer stop];
    
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    double elapsedTime = currentTime - self.startTime+self.timePre;
    
    unsigned long milliSecs = (unsigned long)(elapsedTime * 1000);
    
    
    long duration=milliSecs/1000;
    
    NSDate *date=[NSDate date];
    
    long time=[date timeIntervalSince1970];
    
    long distance=[self.distanceLabel.text doubleValue]*1000;
//    
//    duration=3700;
//    distance=70000;
//    self.stepsLabel.text=@"14888";
//    self.paceLabel.text=@"150";
//    self.calsLabel.text=@"7658";
    
    WalkingRecord *result=[[WalkingRecord alloc] initWithSteps:self.stepsLabel.text distance:[NSString stringWithFormat:@"%ld",distance] calsburnt:self.calsLabel.text pace:self.paceLabel.text trainid:_trainid gps:@"" route:@"" recordid:@"" result:@"" target:@"" foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text] time:time type:1 persistime:duration];
    

    
//    NSLog(@"resultresultresultRes==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@",result,result.distance,result.steps,result.pace,result.calsburnt);

    
    result.trackPoints=[NSArray arrayWithArray:self.trackPoints];
    result.plannedRoutePoints=[NSArray arrayWithArray:self.plannedRoutePoints];
    
    result.gps=[result getTrackPointsString];
    result.route=[result getPlanedPointsString];
    
    _timeHourLabel.text=@"00";
    _timeMinuteLabel.text=@"00";
    _timeSecondLabel.text=@"00";
    
    
    self.startTime = 0;
    
    [self stopRecordWalking];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:nil forKey:@"PlannedRoute"];
    
    [userDefaults synchronize];
    
    
    [userDefaults setBool:false forKey:@"checkCirculateRoute"];
    [userDefaults setInteger:0 forKey:@"checkCirculateCount"];

    
    @try {
        
        [self.mapView removeObserver:self
                          forKeyPath:@"myLocation"
                             context:NULL];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@.....exception",[exception description]);
    }
    @finally {
        
        
    }
    
    //DB
  GameObject *oldDBTP=  [DBHelper getTrophyProgress];
    NSString *oldprogress=[oldDBTP progress];
    int oldprogressINT=[oldprogress intValue];
    
    

    
    
    NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(updateTrainRecord) object:nil];

     WalkingRecord *temObject=[[WalkingRecord alloc] initWithSteps:result.steps distance:result.distance calsburnt:result.calsburnt pace:result.pace trainid:_trainid gps:result.gps route:result.route recordid:@"" result:@"" target:@"" foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text] time:time type:1 persistime:duration];
 
  
    NSMutableArray * fb_keyArray=[SyncWalking addWalkingRcord:result];
    NSLog(@"Vaycent test fb_keyArray:%@",fb_keyArray);
    
    [syncThread start];
    
    
    
   GameObject *newDBTP= [SyncGame getTrophyProgress];
    NSString *newprogress=[newDBTP progress];
    int newprogressINT=[newprogress intValue];
  
    



    
    TrainingResultViewController *resultView = [[TrainingResultViewController alloc] initWithNibName:@"TrainingResultViewController" bundle:nil];
    
    resultView.record=temObject;

    resultView.theShareRoad=[fb_keyArray objectAtIndex:1];
    
    
    
    
    
    
    if (newprogressINT>oldprogressINT)
    {

        resultView.isUPDateNOW=newprogress;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"false" forKey:[NSString stringWithFormat:@"award_load_from_db_%@",[GlobalVariables shareInstance].login_id]];
        [defaults synchronize];
    }
    else
    {
        resultView.isUPDateNOW=@"no";
    }
//    [resultView setRecord:result];
    
    NSLog(@"resultresultresultRes==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@",result,result.distance,result.steps,result.pace,result.calsburnt);

    [resultView setLevel: self.level];
    [resultView setLastActivity:@"Pedometer"];
    
    
    
    
    
    
    
    
    
    [self.navigationController pushViewController:resultView animated:YES ];
    
    
}

- (void)updateTrainRecord
{
    
    [GlobalVariables shareInstance].trainRT_API_running=true;
    
    [SyncWalking getTrainRecord:_trainid];
   
   // [SyncWalking getAllWalkingRecord];

}

- (void)goToBackground  {
    @try {
        
        [self.mapView removeObserver:self
                          forKeyPath:@"myLocation"
                             context:NULL];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@.....exception",[exception description]);
    }
    @finally {
        
        
    }
    
    
    
    
    
    self.pause_resume_Btn.tag=1;
    
    [self.pause_resume_Btn setBackgroundImage:[UIImage imageNamed:@"hr_btn_wa_green_2.png"] forState:UIControlStateNormal];
    
    [self.pause_resume_Btn setTitle:@"Resume" forState:UIControlStateNormal];
    
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    self.timePre=currentTime - self.startTime+self.timePre;
    
    [self stopRecordWalking];
    
    [_pause_resume_Btn setTitle:[Utility getStringByKey:@"resume_btn"] forState: normal];
    
    
    [_audioPlayer stop];



    
}


-(IBAction)pauseResumeWalking:(id)sender{
    
    if (self.pause_resume_Btn.tag==0) {  //pause
        
        
//        @try {
//            
//            [self.mapView removeObserver:self
//                              forKeyPath:@"myLocation"
//                                 context:NULL];
//        }
//        @catch (NSException *exception) {
//            
//            NSLog(@"%@.....exception",[exception description]);
//        }
//        @finally {
//            
//            
//        }
//
//        
        
        
        
        self.pause_resume_Btn.tag=1;
        
        [self.pause_resume_Btn setBackgroundImage:[UIImage imageNamed:@"hr_btn_wa_green_2.png"] forState:UIControlStateNormal];
        
        [self.pause_resume_Btn setTitle:@"Resume" forState:UIControlStateNormal];
        
        double currentTime = CFAbsoluteTimeGetCurrent();
        
        self.timePre=currentTime - self.startTime+self.timePre;
        
        [self stopRecordWalking];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mapView.myLocationEnabled = YES;
        });
        
        [_pause_resume_Btn setTitle:[Utility getStringByKey:@"resume_btn"] forState: normal];
        
        
        [_audioPlayer stop];
        
    }else{
        
        
//        [self.mapView addObserver:self
//                       forKeyPath:@"myLocation"
//                          options:NSKeyValueObservingOptionNew
//                          context:NULL];
//        
//        self.mapView.myLocationEnabled = YES;
        
        self.pause_resume_Btn.tag=0;
        
        [self.pause_resume_Btn setBackgroundImage:[UIImage imageNamed:@"hr_btn_wa_blue_2.png"] forState:UIControlStateNormal];
        
        [self.pause_resume_Btn setTitle:@"Pause" forState:UIControlStateNormal];
        
        [self startRecordWalking];
        
        [_pause_resume_Btn setTitle:[Utility getStringByKey:@"pause_btn"] forState: normal];

        
        if([_checkPlaying isEqualToString:@"Y"]){
            [_audioPlayer play];
        }
    }
}

-(IBAction)showMapView:(id)sender{
    
    
    self.showMapView.hidden=true;
    
    _mapView.hidden=false;
    _statusView.hidden=true;
    
}

-(IBAction)showStatusView:(id)sender{
    
    self.showMapView.hidden=false;
    _mapView.hidden=true;
    _statusView.hidden=false;
    
    
}


- (void)stopRecordWalking {
    
    isRunning=false;
    
    if (self.clockTimer) {
        
        [self.clockTimer invalidate];
        self.clockTimer = nil;
        
    }
    
    if ([CMPedometer isStepCountingAvailable]) {
        
        [self.stepCounter stopPedometerUpdates];
        
    }else{
        
        if (self.stepTimer) {
            [self.stepTimer invalidate];
            self.stepTimer = nil;
            [self.motionManager stopAccelerometerUpdates];
        }
    }
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.myLocationEnabled = NO;
    });
    
    
}

-(IBAction)openMusicApp:(id)sender{
    
    NSString *stringURL = @"music:";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)setupText {
    
    self.actionTitle.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
        
    [self.actionTitle setText:[Utility getStringByKey:@"w_walk_title"]];
    
    _distanceLabel.font=[UIFont fontWithName:font57 size:35];
    _stepsLabel.font=[UIFont fontWithName:font57 size:35];
    _calsLabel.font=[UIFont fontWithName:font57 size:35];
    _paceLabel.font=[UIFont fontWithName:font57 size:35];
    _speedLabel.font=[UIFont fontWithName:font57 size:35];
    
    _distanceTextLabel.font=[UIFont fontWithName:font67 size:20];
    _stepsTextLabel.font=[UIFont fontWithName:font67 size:20];
    _calsTextLabel.font=[UIFont fontWithName:font67 size:20];
    _paceTextLabel.font=[UIFont fontWithName:font67 size:20];
    _speedLabelText.font=[UIFont fontWithName:font67 size:20];
    
    _distanceUnitLabel.font=[UIFont fontWithName:font77 size:12];
    _stepsUnitLabel.font=[UIFont fontWithName:font77 size:12];
    _calsUnitLabel.font=[UIFont fontWithName:font77 size:12];
    _paceUnitLabel.font=[UIFont fontWithName:font77 size:12];
    _speedLabelUnit.font=[UIFont fontWithName:font77 size:12];
    
     _speedLabelUnit2.font=[UIFont fontWithName:font77 size:12];
    _timeHourLabel.font=[UIFont fontWithName:font57 size:53];
    _timeMinuteLabel.font=[UIFont fontWithName:font57 size:53];
    _timeSecondLabel.font=[UIFont fontWithName:font57 size:53];
    _timeSplit1Label.font=[UIFont fontWithName:font57 size:53];
    _timeSplit2Label.font=[UIFont fontWithName:font57 size:53];
    if (iPad){
        _timeHourLabel.font=[UIFont fontWithName:font57 size:45];
        _timeMinuteLabel.font=[UIFont fontWithName:font57 size:45];
        _timeSecondLabel.font=[UIFont fontWithName:font57 size:45];
        _timeSplit1Label.font=[UIFont fontWithName:font57 size:45];
        _timeSplit2Label.font=[UIFont fontWithName:font57 size:45];
        
    }

    
    
    _pause_resume_Btn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    _plan_route_Btn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    _start_Btn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    _stop_Btn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    
    
    //    @property (strong, nonatomic) IBOutlet UIButton *pause_resume_Btn;
    //
    //    @property (strong, nonatomic) IBOutlet UIButton *plan_route_Btn;
    //    @property (strong, nonatomic) IBOutlet UIButton *start_Btn;
    //    @property (strong, nonatomic) IBOutlet UIButton *stop_Btn;
    
    
}


- (void)startRecordWalking {
    
    isRunning=true;
    
    self.startTime = CFAbsoluteTimeGetCurrent();
    
    self.clockTimer = [NSTimer timerWithTimeInterval:1
                                              target:self
                                            selector:@selector(clockDidTick:)
                                            userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.clockTimer forMode:NSRunLoopCommonModes];
    
    if ([CMPedometer isStepCountingAvailable]) {
        
        [self.stepCounter startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
                        NSLog(@"%s %ld %@ ", __PRETTY_FUNCTION__, (long)pedometerData.numberOfSteps, error);
                            NSInteger  numberOfSteps = [pedometerData.numberOfSteps integerValue];
                                                  //self.stepsLabel.text = [@(numberOfSteps) stringValue];
                                                  
                                                  if (self.stepsCount>0&&numberOfSteps==0) {
                                                      
                                                      isPauseed=true;
                                                      
                                                      self.beforeStepsCount=self.stepsCount;
                                                      
                                                  }
                                                  
                                                  if (isPauseed) {
                                                      
                                                      
                                                      
                                                      self.stepsCount=self.beforeStepsCount+numberOfSteps;
                                                  }
                                                  else{
                                                      
                                                      self.stepsCount=numberOfSteps;
                                                  }

                                                  
                                                  [self performSelectorOnMainThread:@selector(updateStep) withObject:Nil waitUntilDone:NO];
                                                  
                                                  
                                              }];
        
    }else{
        
        [self.motionManager startAccelerometerUpdates];
        
        
        [self.motionManager
         startAccelerometerUpdatesToQueue:self.operationQueue
         withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             
             /*
              int length = sqrt(self.motionManager.accelerometerData.acceleration.x * self.motionManager.accelerometerData.acceleration.x + self.motionManager.accelerometerData.acceleration.y * self.motionManager.accelerometerData.acceleration.y + self.motionManager.accelerometerData.acceleration.z * self.motionManager.accelerometerData.acceleration.z);
              
              if(length>=2){
              
              self.stepsCount+=1;
              
              NSLog(@"%d......step",self.stepsCount);
              
              [self performSelectorOnMainThread:@selector(updateStep) withObject:Nil waitUntilDone:NO];
              }*/
             
             const float violence = 1.2;
             static BOOL beenhere;
             BOOL shake = FALSE;
             if (beenhere) return;
             beenhere = TRUE;
             if (accelerometerData.acceleration.x > violence || accelerometerData.acceleration.x < (-1* violence))
                 shake = TRUE;
             if (accelerometerData.acceleration.y > violence || accelerometerData.acceleration.y < (-1* violence))
                 shake = TRUE;
             if (accelerometerData.acceleration.z > violence || accelerometerData.acceleration.z < (-1* violence))
                 shake = TRUE;
             if (shake&&self.pause_resume_Btn.tag!=1) {
                 self.stepsCount+=1;
             }
             beenhere = false;
         }];
        
        //self.stepTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(stepDetect:) userInfo:nil repeats:YES];
        //[[NSRunLoop currentRunLoop] addTimer:self.stepTimer forMode:NSRunLoopCommonModes];
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.myLocationEnabled = YES;
    });
}


- (NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil)
    {
        _operationQueue = [NSOperationQueue new];
    }
    return _operationQueue;
}

-(double)getDistance:(CLLocation*)sPoint endPoint:(CLLocation*)ePoint{
    
    double PI=3.14159265358979323;
    double R=6371229;
    
    double x,y,distance;
    
    x=(ePoint.coordinate.longitude-sPoint.coordinate.longitude)*PI*R*cos(((sPoint.coordinate.latitude+ePoint.coordinate.latitude)/2)*PI/180)/180;
    
    y=(ePoint.coordinate.latitude-sPoint.coordinate.latitude)*PI*R/180;
    
    distance=hypot(x, y);
    
    
    
    return distance;
    
}

- (void)stepDetect:(NSTimer *)timer {
    
    
    // NSLog(@"%f,%f,%f",self.motionManager.accelerometerData.acceleration.x,self.motionManager.accelerometerData.acceleration.y,self.motionManager.accelerometerData.acceleration.z);
    
    
    const float violence = 1.2;
    static BOOL beenhere;
    BOOL shake = FALSE;
    if (beenhere) return;
    beenhere = TRUE;
    if (self.motionManager.accelerometerData.acceleration.x > violence || self.motionManager.accelerometerData.acceleration.x < (-1* violence))
        shake = TRUE;
    if (self.motionManager.accelerometerData.acceleration.y > violence || self.motionManager.accelerometerData.acceleration.y < (-1* violence))
        shake = TRUE;
    if (self.motionManager.accelerometerData.acceleration.z > violence || self.motionManager.accelerometerData.acceleration.z < (-1* violence))
        shake = TRUE;
    if (shake) {
        self.stepsCount+=1;
    }
    beenhere = false;
    /*
     int length = sqrt(self.motionManager.accelerometerData.acceleration.x * self.motionManager.accelerometerData.acceleration.x + self.motionManager.accelerometerData.acceleration.y * self.motionManager.accelerometerData.acceleration.y + self.motionManager.accelerometerData.acceleration.z * self.motionManager.accelerometerData.acceleration.z);
     
     if(length>=2){
     
     self.stepsCount+=1;
     
     NSLog(@"%d......step",self.stepsCount);
     
     [self performSelectorOnMainThread:@selector(updateStep) withObject:Nil waitUntilDone:NO];
     }
     */
    
    /*
     float vSum=0;
     
     vSum+=mYOffset+self.motionManager.accelerometerData.acceleration.x*mScale[1];
     vSum+=mYOffset+self.motionManager.accelerometerData.acceleration.y*mScale[1];
     vSum+=mYOffset+self.motionManager.accelerometerData.acceleration.z*mScale[1];
     
     int k=0;
     
     float v=vSum/3;
     
     float direction=(v>mLastValues[k]?1:(v<mLastValues[k]?-1:0));
     
     if (direction==-mLastDirections[k]) {
     
     int extType=(direction>0?0:1);
     
     mLastExtremes[extType][k]=mLastValues[k];
     
     float diff=abs(mLastExtremes[extType][k]-mLastExtremes[1-extType][k]);
     
     if (diff>mLimit) {
     
     BOOL isAlmostAsLargeAsPrevious=diff>(mLastDiff[k]*2/3);
     BOOL isPreviousLargeEnough=mLastDiff[k]>(diff/3);
     BOOL isNotContra=(mLastMatch!=1-extType);
     
     if (isAlmostAsLargeAsPrevious&&isPreviousLargeEnough&&isNotContra) {
     
     self.stepsCount+=1;
     
     NSLog(@"%d......step",self.stepsCount);
     
     mLastMatch=extType;
     
     [self performSelectorOnMainThread:@selector(updateStep) withObject:Nil waitUntilDone:NO];
     
     }else{
     
     mLastMatch=-1;
     }
     
     }
     
     mLastDiff[k]=diff;
     }
     
     mLastDirections[k]=direction;
     mLastValues[k]=v;
     */
    
}

- (void)clockDidTick:(NSTimer *)timer {
    
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    double elapsedTime = currentTime - self.startTime+self.timePre;
    
    // Convert the double to milliseconds
    unsigned long milliSecs = (unsigned long)(elapsedTime * 1000);
    
    NSString *time=[self formatTheTime:milliSecs];
    
    //NSLog(@"%@.....time",time);
    
    NSArray *timeSplit = [time componentsSeparatedByString:@":"];
    
    
    [self performSelectorOnMainThread:@selector(updateTime:) withObject:timeSplit waitUntilDone:NO];
    
    
}

-(void)updateStep{
    
    
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    double elapsedTime = currentTime - self.startTime+self.timePre;
    
    float min=round(elapsedTime/60.0f*100.0f)/100.0f;
    
    //NSLog(@"%f........%d",min,self.stepsCount);
    
    
    int pace=self.stepsCount/min;
    
    
    self.stepsLabel.text=[NSString stringWithFormat:@"%ld",(long)self.stepsCount];
    
    self.paceLabel.text=[NSString stringWithFormat:@"%d",pace];
    
    
    [self performSelectorOnMainThread:@selector(updateDistance) withObject:Nil waitUntilDone:NO];
    
    
}

-(void)updateDistance{
    

    float dis=(0.414*([[Utility getHeight] floatValue]/100)*self.stepsCount)/1000;
    
    
   // NSLog(@"distance......%f",dis);
    
    //float show_distance=round(self.stepsDistance/1000.0f*1000)/1000;
    
    self.distanceLabel.text=[NSString stringWithFormat:@"%.03f",dis];
    
}

-(void)updateTime:(NSArray*)timeSplit{
    
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    double elapsedTime = currentTime - self.startTime+self.timePre;
    
    unsigned long milliSecs = (unsigned long)(elapsedTime * 1000);
    double disTancel=[self.distanceLabel.text doubleValue];
    double speedDouble=disTancel/(elapsedTime/60/60.0);
    NSLog(@"elapseTime=%lf",elapsedTime);
    NSLog(@"disTancel=%fspeedDouble=%f",disTancel,speedDouble);
    if (elapsedTime>60) {

        if (speedDouble>0)
        {
            NSString * speed=[[NSString alloc]initWithFormat:@"%.03f",speedDouble];
            self.speedLabel.text=speed;
        }
        else
        {
            self.speedLabel.text=@"0";
        }
        
        
        
    }
    else
    {
        if (speedDouble>0)
        {
            NSString * speed=[[NSString alloc]initWithFormat:@"%.03f",speedDouble];
            self.speedLabel.text=speed;
        }
        else
        {
            self.speedLabel.text=@"0";
        }
        
    }
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth|
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];
    
    int year=(int)[comps year];
    
//    float weight=50;//kg
//    
//    float height=170;//cm
//    
//    float age=year-1980;
//    
//    float duration=milliSecs/1000/60;
    
//    int cal=(((13.75*weight)+(5*height)-(6.76*age)+66)/24)*3.5*(duration/60);
    
    
    float weight=[[Utility getWeight] floatValue]/2.2f;//get weight,unit is kg;
    float height=[[Utility getHeight] floatValue];//get height,unit is cm;
    float age=year-[[Utility getBirth] integerValue];//get age;
    float duration=milliSecs/1000/60;
    // float speed=mDistanceValue/duration;
    
    BOOL isMale=[[Utility getGender] isEqualToString:@"M"];
    
    float bmr=0;
    
    if(isMale){
        
        bmr=(float) (((13.75*weight)+(5*height)-(6.76*age)+66)/24);
        
    }else{
        
        bmr=(float) (((9.56*weight)+(1.85*height)-(4.68*age)+655)/24);
    }

    float pace_value=self.stepsCount/duration;
    
    float speed=(float) (pace_value*0.414*height/100);
    float vo2=(float) (0.1*speed+3.5);
    float met=(float) (vo2/3.5);
    
    //cals=(int)(duration*bmr*met/60)+"";
    int cal=(int) (duration*bmr*met/60);
    
    self.timeHourLabel.text=[timeSplit objectAtIndex:0];
    self.timeMinuteLabel.text=[timeSplit objectAtIndex:1];
    self.timeSecondLabel.text=[timeSplit objectAtIndex:2];
    
    self.calsLabel.text=[NSString stringWithFormat:@"%d",cal];
    
    [self updateStep];
}

-(void)updateTrack{
    
    
    [self.path removeAllCoordinates];
    
    float tmp_distance=0;
    
    for (int i=0; i<[self.trackPoints count]; i++) {
        
        
        CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.trackPoints objectAtIndex:i]];
        
        
        if ([self.trackPoints count]>1&&i>0) {
            
            //CLLocation *beforLocation=[self.points objectAtIndex:i-1];
            CLLocation* beforLocation = [NSKeyedUnarchiver unarchiveObjectWithData:[self.trackPoints objectAtIndex:i-1]];
            float pointDistance=[self getDistance:beforLocation endPoint:location];
            
            tmp_distance=tmp_distance+pointDistance;
            
            
        }
        
        [self.path addCoordinate:location.coordinate];
        
        
        
    }
    
    self.stepsDistance=tmp_distance;
    
    
    self.polyline.path = self.path;
    
    self.polyline.strokeColor = [UIColor redColor];
    
    self.polyline.geodesic = YES;
    
    self.polyline.strokeWidth = 10;
    
    self.polyline.map = self.mapView;
    
    [self performSelectorOnMainThread:@selector(updateDistance) withObject:Nil waitUntilDone:NO];
    
}

-(void)updateRoute{
    
    [self.mapView clear];
    
//    if (isReturnRoute) {
//        
//        
//        GMSPolyline *polyline = [[GMSPolyline alloc] init];
//        GMSMutablePath *path = [GMSMutablePath path];
//        
//        
//        for (int i=0; i<[self.plannedRoutePoints count]; i++) {
//            
//            //CLLocation *location = [self.points objectAtIndex:i];
//            
//            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.plannedRoutePoints objectAtIndex:i]];
//            
//            
//            
//            [path addCoordinate:location.coordinate];
//            
//            GMSMarker *australiaMarker = [[GMSMarker alloc] init];
//            //australiaMarker.title = @"title";
//            australiaMarker.position = location.coordinate;
//            australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
//            
//            
//            australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt3"];
//            
//            if (i==0) {
//                
//                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
//            }
//            
//            
//            australiaMarker.map = _mapView;
//            
//            
//        }
//        
//        polyline.path = path;
//        //polyline.strokeColor = [UIColor colorWithRed:12/255.0 green:169/255.0 blue:97/255.0 alpha:1];
//        polyline.strokeColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0/255.0 alpha:100];
//        polyline.geodesic = YES;
//        polyline.strokeWidth = 10;
//        polyline.map = self.mapView;
//        
//        
//        GMSPolyline *polyline_return = [[GMSPolyline alloc] init];
//        GMSMutablePath *path_return = [GMSMutablePath path];
//        
//        
//        for (int i=(int)[self.plannedRoutePoints count]-1; i>-1; i--) {
//            
//            //CLLocation *location = [self.points objectAtIndex:i];
//            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.plannedRoutePoints objectAtIndex:i]];
//            
//            
//            
//            [path_return addCoordinate:location.coordinate];
//            
//            GMSMarker *australiaMarker = [[GMSMarker alloc] init];
//            //australiaMarker.title = @"title";
//            australiaMarker.position = location.coordinate;
//            australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
//            
//            
//            australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt3"];
//            
//            if (i==0) {
//                
//                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
//            }
//            
//            
//            australiaMarker.map = _mapView;
//            
//            
//        }
//        
//        polyline_return.path = path;
//        polyline_return.strokeColor = [UIColor colorWithRed:12/255.0 green:169/255.0 blue:97/255.0 alpha:1];
//        
//        polyline_return.geodesic = YES;
//        polyline_return.strokeWidth = 3;
//        polyline_return.map = self.mapView;
//        
//        
//        
//        
//        
//    }
    if (isCirculateRoute) {
        NSLog(@"111111");
        
        GMSPolyline *polyline = [[GMSPolyline alloc] init];
        GMSMutablePath *path = [GMSMutablePath path];
        
        totalDistance=0;
        NSMutableArray *tempPoints = [[NSMutableArray alloc] initWithArray:self.plannedRoutePoints];
        [tempPoints addObject:[self.plannedRoutePoints firstObject]];
        
        
        for (int k=0; k<circulateCount; k++) {
            
            NSLog(@"check the circulateCount : %ld",(long)circulateCount);
            
            for (int i=0; i<[tempPoints count]; i++) {
                
                //CLLocation *location = [self.points objectAtIndex:i];
                
                CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[tempPoints objectAtIndex:i]];
                
                if ([tempPoints count]>1&&i>0) {
                    
                    //CLLocation *beforLocation=[self.points objectAtIndex:i-1];
                    CLLocation* beforLocation = [NSKeyedUnarchiver unarchiveObjectWithData:[tempPoints objectAtIndex:i-1]];
                    float pointDistance=[self getDistance:beforLocation endPoint:location];
                    
                    totalDistance=totalDistance+pointDistance;
                    
                    NSLog(@"%f...........distance",totalDistance);
                    
                }
                
                [path addCoordinate:location.coordinate];
                
                GMSMarker *australiaMarker = [[GMSMarker alloc] init];
                //australiaMarker.title = @"title";
                australiaMarker.position = location.coordinate;
                australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
                
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt3"];
                
                if (i==0 || i==[tempPoints count]-1) {
                    
                    australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
                }
                australiaMarker.map = _mapView;
                
                
            }
            polyline.path = path;
            //polyline.strokeColor = [UIColor colorWithRed:12/255.0 green:169/255.0 blue:97/255.0 alpha:1];
            polyline.strokeColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0/255.0 alpha:100];
            polyline.geodesic = YES;
            polyline.strokeWidth = 5;
            polyline.map = self.mapView;
        }
        
    }

    else{
    
        GMSPolyline *polyline = [[GMSPolyline alloc] init];
        GMSMutablePath *path = [GMSMutablePath path];
        
        for (int i=0; i<[self.plannedRoutePoints count]; i++) {
            
            //CLLocation *location = [self.points objectAtIndex:i];
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.plannedRoutePoints objectAtIndex:i]];
            
            
            
            [path addCoordinate:location.coordinate];
            
            GMSMarker *australiaMarker = [[GMSMarker alloc] init];
            //australiaMarker.title = @"title";
            australiaMarker.position = location.coordinate;
            australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
            
            
            australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt2"];
            
            if (i==0) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
            }
            
            if ([self.plannedRoutePoints count]>1&&i==[self.plannedRoutePoints count]-1) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_end"];
            }
            
            australiaMarker.map = _mapView;
            
            
        }
        
        polyline.path = path;
        polyline.strokeColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0/255.0 alpha:100];
        polyline.geodesic = YES;
        polyline.strokeWidth = 10;
        polyline.map = self.mapView;
        
    }
    
    
    NSLog(@"update route.....");
}


-(NSString*)formatTheTime:(long)time{
    
    long elapsedSeconds=time/1000;
    long hours=0;
    long minutes=0;
    long seconds=0;
    
    if (elapsedSeconds>=3600) {
        
        hours=elapsedSeconds/3600;
        elapsedSeconds-=hours*3600;
    }
    
    if (elapsedSeconds>=60) {
        
        minutes=elapsedSeconds/60;
        
        elapsedSeconds-=minutes*60;
    }
    
    seconds=elapsedSeconds;
    
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours,minutes,seconds];
    
}


#pragma mark - google map


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
    
    if (!firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate = YES;
        
        self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                             zoom:16];
    }
    
    if (isRunning&&self.pause_resume_Btn.tag!=1) {
        
        //self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:16];
        
        if ([self.trackPoints count]>0) {
            
            CLLocation* beforLocation = [NSKeyedUnarchiver unarchiveObjectWithData:[self.trackPoints objectAtIndex:[self.trackPoints count]-1]];
            float pointDistance=[self getDistance:beforLocation endPoint:location];
            
            if (pointDistance>1) {
                
                //NSLog(@"add a location......%f",pointDistance);
                
                [self.trackPoints addObject:[NSKeyedArchiver archivedDataWithRootObject:location]];
                
                [self updateTrack];
            }
            
        }else{
            
            [self.trackPoints addObject:[NSKeyedArchiver archivedDataWithRootObject:location]];
            
            [self updateTrack];
        }
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










-(void)initPaceSettingPicker{
    self.pacePicker= [[AFPickerView alloc] initWithFrame:CGRectMake(6, 11, 95, 127)];
    _PaceData=[[NSMutableArray alloc] init];
    for(int i=0;60+10*i<=150;i++)
    {
        int temp_int=(60+10*i);
        [_PaceData addObject:[NSString stringWithFormat:@"%d",temp_int]];
    }
    NSLog(@"%lu......",(unsigned long)[_PaceData count]);
    
    self.pacePicker.dataSource = self;
    self.pacePicker.delegate = self;
    [self.pacePicker reloadData];
    //[self.targetPicker setSelectedRow:[_targetData count]-1];
    [self.paceChooseView addSubview:self.pacePicker];
    
    //    _paceTempValue=@"90";
    
    if(_paceTempValue!=NULL){
        int intTemp=[_paceTempValue intValue]-60;
        intTemp=intTemp/10;
        [self.pacePicker setSelectedRow:intTemp];
        
    }
    else{
        _paceTempValue=@"90";
        int intTemp=[_paceTempValue intValue]-60;
        intTemp=intTemp/10;
        [self.pacePicker setSelectedRow:intTemp];
    }
    
    
}
#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row
{
    
    
    
        _paceTempValue=[_PaceData objectAtIndex:row];
        
        
        if(_startView.hidden==true){
            [self checkTheMP3Path];
             if([_pause_resume_Btn.titleLabel.text isEqualToString:[Utility getStringByKey:@"pause_btn"]]){  //判斷是否有暫停
                 if([_checkPlaying isEqualToString:@"Y"]) {
                     [_audioPlayer play];
                 }
                 else {
//                     _checkPlaying=@"Y";
//                     [_audioPlayer play];
                     //edit by vaycent
                 }

             }
            
        }
    
    
    
    
}


- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{
        return [_PaceData objectAtIndex:row];
}

#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
        return [_PaceData count];
}







-(IBAction)paceSettingClick:(id)sender{
    
    //    NSLog(@"%hhd........checkhidden",_paceChooseView.hidden);
    
    
    if(_paceChooseView.hidden==true){
        [self initPaceSettingPicker];
        _paceChooseView.hidden=false;
        _paceHoleView.hidden=false;
        NSLog(@"%@...test _paceTempValue1:",_paceTempValue);
    }
    else if(_paceChooseView.hidden==false){
        _paceChooseView.hidden=true;
        _paceHoleView.hidden=true;
        //        _paceTempValue=_targetTmpValue;
        NSLog(@"%@...test _paceTempValue2:",_paceTempValue);
        
    }
}










-(void)checkTheMP3Path{
    
    if(heightSound){
        switch([_paceTempValue intValue]){
            case 60:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_60"   ofType:@"mp3"];
                break;
            case 70:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_70"   ofType:@"mp3"];
                break;
            case 80:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_80"   ofType:@"mp3"];
                break;
            case 90:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_90"   ofType:@"mp3"];
                break;
            case 100:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_100"   ofType:@"mp3"];
                break;
            case 110:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_110"   ofType:@"mp3"];
                break;
            case 120:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_120"   ofType:@"mp3"];
                break;
            case 130:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_130"   ofType:@"mp3"];
                break;
            case 140:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_140"   ofType:@"mp3"];
                break;
            case 150:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_150"   ofType:@"mp3"];
                break;
            default:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_90"   ofType:@"mp3"];
                break;
        }
    }
    else{
        switch([_paceTempValue intValue]){
            case 60:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_60"   ofType:@"mp3"];
                break;
            case 70:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_70"   ofType:@"mp3"];
                break;
            case 80:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_80"   ofType:@"mp3"];
                break;
            case 90:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_90"   ofType:@"mp3"];
                break;
            case 100:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_100"   ofType:@"mp3"];
                break;
            case 110:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_110"   ofType:@"mp3"];
                break;
            case 120:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_120"   ofType:@"mp3"];
                break;
            case 130:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_130"   ofType:@"mp3"];
                break;
            case 140:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_140"   ofType:@"mp3"];
                break;
            case 150:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_150"   ofType:@"mp3"];
                break;
            default:_musicPath= [[NSBundle mainBundle]  pathForResource:@"bottle_low_90"   ofType:@"mp3"];
                break;
        }
    }

    
    
    
    if (_musicPath) {
        NSURL *musicURL = [NSURL fileURLWithPath:_musicPath];
        
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        _audioPlayer = [[AVAudioPlayer alloc]  initWithContentsOfURL:musicURL  error:nil];
        [_audioPlayer setDelegate:self];
        
        
        _audioPlayer.numberOfLoops = -1;
    }
    
    
    
}



-(IBAction)soundPlayClick:(id)sender{
    
    
    
    if(_startView.hidden==true){   //判斷是否已開始
        [self checkTheMP3Path];
        if([_pause_resume_Btn.titleLabel.text isEqualToString:[Utility getStringByKey:@"pause_btn"]]){  //判斷是否有暫停
            
            
            if([_checkPlaying isEqualToString:@"Y"]){
                _checkPlaying=@"N";
                [_audioPlayer stop];
            }
            else {
                [_audioPlayer play];
                _checkPlaying=@"Y";
            }
            
        }
    }
    
}




-(void)updateCounterEnd
{
    NSLog(@"123 321");
    //    [timer invalidate];
    _counterView.hidden=true;
    
    
    _startView.hidden=true;
    _stopView.hidden=false;
    
    self.timePre=0;
    
    self.stepsCount=0;
    
    self.stepsDistance=0;
    
    [self.trackPoints removeAllObjects];
    
    [self startRecordWalking];
}
-(void)updateCounter2
{
    NSString *bstr2=[[NSBundle mainBundle]pathForResource:@"hr_counter_no2" ofType:@"png" ];
    [_counterImage setImage:[[UIImage alloc]initWithContentsOfFile:bstr2]];
    
}

-(void)updateCounter1
{
    NSString *bstr1=[[NSBundle mainBundle]pathForResource:@"hr_counter_no1" ofType:@"png" ];
    [_counterImage setImage:[[UIImage alloc]initWithContentsOfFile:bstr1]];
}









@end
