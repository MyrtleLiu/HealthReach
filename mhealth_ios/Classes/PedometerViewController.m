//
//  PedometerViewController.m
//  mHealth
//
//  Created by sngz on 14-1-27.
//
//

#import "PedometerViewController.h"
#import "RoutePlannerViewController.h"
#import "HomeViewController.h"
#import "WalkingResultViewController.h"
#import "WalkingRecord.h"
#import "GlobalVariables.h"
#import "AFPickerView.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "SyncGame.h"
#import <AVFoundation/AVFoundation.h>
#import "GameObject.h"


@interface PedometerViewController (){
    
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

@implementation PedometerViewController


@synthesize  paceSetValue;
@synthesize  targetSetValue;

bool isPauseed=false;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (iPad) {
        
        
        self = [super initWithNibName:@"PedometerViewController_iPhone4iOS7" bundle:nibBundleOrNil];
        
    }
    else{
        self =  [super initWithNibName:@"PedometerViewController" bundle:nibBundleOrNil];
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
    
    
//    self.speedLabelUnit.frame=CGRectMake(235, 10, 38, 44);
//     self.speedLabelUnit.textAlignment=NSTextAlignmentCenter;
    
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

//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.mapView.myLocationEnabled = NO;
//    });
    
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
    
    self.mapView.delegate=self;
    
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
        //NSLog(@"[userDefaults objectForKey:@checkCirculateRoute] : %hhd",[userDefaults boolForKey:@"checkCirculateRoute"]);
       // NSLog(@"[userDefaults objectForKey:@checkCirculateCount] : %d",[userDefaults integerForKey :@"checkCirculateCount"]);

        
        
        [self updateRoute];
    }
    
    NSLog(@"PACE TESST : %D",paceSetValue);
    NSLog(@"target TESST : %@",targetSetValue);
    if(targetSetValue!=nil){
        _divideTarget.hidden=false;
        _targetValue.hidden=false;
        _targetValue.text=targetSetValue;
        [self.targetSetBtn setBackgroundImage:[UIImage imageNamed:@"new_ca_btn_target_edit.png"] forState:UIControlStateNormal];
        
    
        _paceTempValue=[NSString stringWithFormat:@"%d",paceSetValue];
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    
    [self setupText];
    
    [_distanceTextLabel setText:[Utility getStringByKey:@"distance_label"]];
    [_stepsTextLabel setText:[Utility getStringByKey:@"step_label"]];
    [_paceTextLabel setText:[Utility getStringByKey:@"pace_label"]];
    [_calsTextLabel setText:[Utility getStringByKey:@"cal_label"]];

    [_distanceUnitLabel setText:[Utility getStringByKey:@"km_unit"]];
    [_stepsUnitLabel setText:[Utility getStringByKey:@"step_unit"]];
    [_paceUnitLabel setText:[Utility getStringByKey:@"step_unit"]];
    [__min setText:[Utility getStringByKey:@"min"]];
    [_calsUnitLabel setText:[Utility getStringByKey:@"cal_unit"]];

    [_speedLabelUnit setText:[Utility getStringByKey:@"km"]];
    [_speedLabelUnit2 setText:[Utility getStringByKey:@"/hour"]];
    [_speedLabelText setText:[Utility getStringByKey:@"speed"]];
    [_calTargetTitle setText:[Utility getStringByKey:@"cal_target"]];
    
    
    [_cancelBtn setTitle:[Utility getStringByKey:@"cancel"] forState: normal];
    [_doneBtn setTitle:[Utility getStringByKey:@"Done"] forState: normal];
    
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
//    _switchSound.transform = rotation;
    
    
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

    
//    [self checkRunning];
    
     [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] checkLocationService];
}

-(IBAction)LongPressSound:(id)sender{
    if(_startView.hidden==true){   //判斷是否已開始
        checkLongPressSound++;
        NSLog(@"----------%d",checkLongPressSound);
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
        
        [GlobalVariables shareInstance].distanceGlo = _distanceLabel.text;
        [GlobalVariables shareInstance].stepseGlo =_stepsLabel.text;
        [GlobalVariables shareInstance].paceGlo = _paceLabel.text;
        [GlobalVariables shareInstance].caleGlo = _calsLabel.text;
        [GlobalVariables shareInstance].targetGlo = _targetValue.text;
        
        if(_startView.hidden==true)
            [GlobalVariables shareInstance].running = @"pedometer";
        else
            [GlobalVariables shareInstance].running = @"";
        
        
        //    [GlobalVariables shareInstance].timeeGlo =
        
        
        
        [self backToHome];

    }
    
//    [GlobalVariables shareInstance].distanceGlo = _distanceLabel.text;
//    [GlobalVariables shareInstance].stepseGlo =_stepsLabel.text;
//    [GlobalVariables shareInstance].paceGlo = _paceLabel.text;
//    [GlobalVariables shareInstance].caleGlo = _calsLabel.text;
//    [GlobalVariables shareInstance].targetGlo = _targetValue.text;
//    
//    if(_startView.hidden==true)
//        [GlobalVariables shareInstance].running = @"pedometer";
//    else
//        [GlobalVariables shareInstance].running = @"";
//
//    
//    
//
//    
//    [self backToHome];
    
    
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
    
        WalkingResultViewController *resultView = [[WalkingResultViewController alloc] initWithNibName:@"WalkingResultViewController" bundle:nil];
    resultView.chickTheCal=self.chickTheCal;
    
    _startView.hidden=false;
    _stopView.hidden=true;
    [_audioPlayer stop];
    
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    double elapsedTime = currentTime - self.startTime+self.timePre;
    
    unsigned long milliSecs = (unsigned long)(elapsedTime * 1000);
    
    
    long duration=milliSecs/1000;
    _gobalduration=duration;
    
    NSDate *date=[NSDate date];
    
    long time=[date timeIntervalSince1970];
        NSLog(@"Time  time == %ld",time);
    long distance=[self.distanceLabel.text doubleValue]*1000;
/*--------------------------------------------------------------------------------------------------*/

//    duration=3200;
//    distance=40000;
//    _gobalduration=duration;
//    self.stepsLabel.text=@"8888";
//    self.paceLabel.text=@"100";
//    self.calsLabel.text=@"999999";
//    NSLog(@"Time  time == %ld",time);
/*--------------------------------------------------------------------------------------------------*/
    
        
    
   
        WalkingRecord *result=[[WalkingRecord alloc] initWithSteps:self.stepsLabel.text distance:[NSString stringWithFormat:@"%ld",distance] calsburnt:self.calsLabel.text pace:self.paceLabel.text trainid:@"" gps:@"" route:@"" recordid:@"" result:@"" target:_targetValue.text foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text] time:time type:0 persistime:duration];
    
    
    
    
    
    
    
    
        result.trackPoints=[NSArray arrayWithArray:self.trackPoints];
        result.plannedRoutePoints=[NSArray arrayWithArray:self.plannedRoutePoints];
        
        result.gps=[result getTrackPointsString];
        result.route=[result getPlanedPointsString];
    
    
    
     _gobalWalkingRecord=[[WalkingRecord alloc] initWithSteps:self.stepsLabel.text distance:[NSString stringWithFormat:@"%ld",distance] calsburnt:self.calsLabel.text pace:self.paceLabel.text trainid:@"" gps:[result getTrackPointsString] route:[result getPlanedPointsString] recordid:@"" result:@"" target:_targetValue.text foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text] time:time type:0 persistime:duration];
    
    
    
    
    
    NSLog(@"---------------%@-----------,",result);
        _timeHourLabel.text=@"00";
        _timeMinuteLabel.text=@"00";
        _timeSecondLabel.text=@"00";
    
    
         NSLog(@"resultresultresultPed------==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@",result,result.distance,result.steps,result.pace,result.calsburnt);
        
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
    
    [GlobalVariables shareInstance].running = @"";
    
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    BOOL chickC;
    
    if(session_id==NULL||login_id==NULL){
        NSLog(@"I'm frist time");
        
        
        
        resultView.isCOK=@"0";
        NSLog(@"-------------------111-------------------------------+++++++++++");
        
        WalkingRecord* temObj=[[WalkingRecord alloc] initWithSteps:result.steps distance:result.distance calsburnt:result.calsburnt pace:result.pace trainid:@"" gps:@"" route:@"" recordid:@"" result:@"" target:result.target foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text]   time:time type:0 persistime:_gobalduration];
        NSLog(@"_gobalduration = %ld",_gobalduration);
         NSLog(@"----------------------222----------------------------+++++++++++");
        resultView.result=temObj;
        
        
        
        //        [SyncWalking addWalkingRcord:result];
        
        //     [resultView setResult:result];
        
        
        //
        //        record.steps=[DBHelper encryptionString:record.steps];
        //        record.distance=[DBHelper encryptionString:record.distance];
        //        record.calsburnt=[DBHelper encryptionString:record.calsburnt];
        //        record.persistimeStr=[DBHelper encryptionString:record.persistimeStr];
        //
        
        
        int paceCheck= [resultView.result.pace intValue];
        float timeCheck= [resultView.result getPersistime]/60.0f ;
        NSLog(@"resultView.result getPersistime==%ld",[resultView.result getPersistime]);
        NSLog(@"paceCheck:%d",paceCheck);
        NSLog(@"timeCheck:%f",timeCheck);
        

        
        NSString *durationAPI=[NSString stringWithFormat:@"%ld",[resultView.result getPersistime]];
        [SyncGame trialCheckPlantProgress:durationAPI steps:resultView.result.steps];
        
        
        
        NSDate *startDate=[[NSDate alloc] initWithTimeIntervalSince1970:time];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:startDate];
        
        NSInteger year=dateComponent.year;
        NSInteger month=dateComponent.month;
        NSInteger day=dateComponent.day;
        
        
        
        NSString *str1=[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day];
        NSString *str2=[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day];
        NSLog(@"str1:%@",str1);
        NSLog(@"str2:%@",str2);
        NSDateFormatter * dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dateStart=[dateFormat dateFromString:str1];
        NSDate *dateEnd=[dateFormat dateFromString:str2];
        
        
        
        
        //        NSString *timeSp1 = [NSString stringWithFormat:@"%ld", (long)[timeStart timeIntervalSince1970]];
        //        NSLog(@"timeStart:%@",timeSp1); //时间戳的值
        //
        //        NSString *timeSp2 = [NSString stringWithFormat:@"%ld", (long)[timeEnd timeIntervalSince1970]];
        //        NSLog(@"timeEnd:%@",timeSp2); //时间戳的值
        
        //        NSLog(@"year:%ld",(long)year );
        //        NSLog(@"month:%ld",(long)month );
        //         NSLog(@"day:%ld",(long)day );
        
        
        
        
        
        //
        //
        //
        BOOL isRunInToday=false;
        
        GameObject *gameObjCheck=[DBHelper getPlantProgress];
        GameObject *result=[[GameObject alloc] init];
        
        if(paceCheck>=80&&timeCheck>=30)
//        if(timeCheck>=0.01)

//is Pass
        {   //大於30分鐘，每分鐘80步
            
            NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
            for (UILocalNotification *notification in notifications )
            {
                
                @try {
                    
                    if([[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw1"] ||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw2"])
                    {
                        NSLog(@"_______Delete");
                        [[UIApplication sharedApplication] cancelLocalNotification:notification];
                        
                        
                    }
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
                
            }
            
            
            
            chickC=YES;
            NSMutableArray *cwResultArray = [DBHelper getCWRecordDate:[dateStart timeIntervalSince1970] enddate:[dateEnd timeIntervalSince1970] type:-1];
            NSLog(@"cwResultArray.size:%lu",(unsigned long)cwResultArray.count);
            for(int i=0;i<cwResultArray.count;i++){
                WalkingRecord *cwResult = [cwResultArray objectAtIndex:i];
                float timeCheck=[cwResult getPersistime]/60.0f;
                if([cwResult.pace intValue]>=80&&timeCheck>=30)  //大於30分鐘，每分鐘80步
                    isRunInToday=true;
            }
            
            
            if(!isRunInToday)
            {
//今天第一次成功
                NSLog(@"gameObjCheck.plantName:%@",gameObjCheck.plantName);
                
                if(gameObjCheck.plantName!=nil&&![gameObjCheck.plantName isEqualToString:@""])
                {
//已经种左花
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSString *olddistanceStr=[defaults objectForKey:@"__distance"];
                    NSString *oldstepsStr=[defaults objectForKey:@"__steps"];
                    NSString *oldcalsStr=[defaults objectForKey:@"__cals"];
                    int newStepsInt=[self.stepsLabel.text intValue]+[oldstepsStr intValue];
                    NSLog(@"newStepsInt=%d",newStepsInt);
                    int newCalsInt=[self.calsLabel.text intValue]+[oldcalsStr intValue];
                    NSLog(@"newCalsInt=%d",newCalsInt);
                    long newDistanceInt=distance+[olddistanceStr intValue];
                    NSLog(@"newDistanceInt=%ld",newDistanceInt);
                    
                    
                    
                    NSString * newDistance=[[NSString alloc] initWithFormat:@"%ld",newDistanceInt];
                    NSString * newSteps=[[NSString alloc] initWithFormat:@"%ld",newDistanceInt];
                    NSString * newCals=[[NSString alloc] initWithFormat:@"%ld",newDistanceInt];
                    [defaults setObject:newDistance  forKey:@"__distance"];
                    [defaults setObject:newSteps forKey:@"__steps"];
                    [defaults setObject:newCals forKey:@"__cals"];
                    
                    [defaults synchronize];
                    
                 
                    
                    
                    
                    long long chickEndDate=[gameObjCheck getEndDate];
                    NSLog(@"ChickEndDate==%lld",chickEndDate);
                    
                    if([gameObjCheck.progress intValue]>5)
                    {
                        
                    }
                    else
                    {
                        NSString *progressStr=[[NSString alloc]initWithFormat:@"%d",[gameObjCheck.progress intValue]+1];
                        result.progress=progressStr;
                        result.plantName=gameObjCheck.plantName;
                        result.plantType=gameObjCheck.plantType;
                        result.gameType=@"WalkPlanyt";
                        result.status=@"0";
                        [result setEndDate:time];
                        [DBHelper addPlant:result];
                        NSString * thrRpadStr=[[NSString alloc]initWithFormat:@"plant_%@_%@_I",result.plantType,result.progress];
                        
                      self.theADDRoadStr=thrRpadStr;
                        self.theLingTimeStr=result.progress;
                         [resultView setTheADDRoadStr:thrRpadStr];
                        
                    }
                    
                    
                    WalkingRecord* temObj2=[[WalkingRecord alloc] initWithSteps:temObj.steps distance:temObj.distance calsburnt:temObj.calsburnt pace:temObj.pace trainid:@"" gps:@"" route:@"" recordid:@"" result:@"" target:temObj.target foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text]   time:time type:0 persistime:_gobalduration];
                    temObj2.steps=[DBHelper encryptionString:temObj2.steps];
                    temObj2.distance=[DBHelper encryptionString:temObj2.distance];
                    temObj2.calsburnt=[DBHelper encryptionString:temObj2.calsburnt];
                    temObj2.persistimeStr=[DBHelper encryptionString:temObj2.persistimeStr];

                    
                    
                      [DBHelper addWalkingRecord:temObj2];
                    
                    
                }
                else
                {
//未种花
                     resultView.isCOK=@"1";
                       self.theLingTimeStr=@"1";
                    NSString * strintDistance=[[NSString alloc] initWithFormat:@"%ld",distance];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:strintDistance  forKey:@"__distance"];
                    [defaults setObject:self.stepsLabel.text forKey:@"__steps"];
                    [defaults setObject:self.calsLabel.text forKey:@"__cals"];
                    
                    [defaults synchronize];
                    
                }
                
                
            }
            else
            {
// 今天已经跑达标了 已经系第二次
                long long chickEndDate=[gameObjCheck getEndDate];
                NSLog(@"ChickEndDate==%lld",chickEndDate);
                
                
  
                
                
                
                if([gameObjCheck.progress intValue]>5)
                {
                    
                }
                else
                {
//                    NSString *progressStr=[[NSString alloc]initWithFormat:@"%d",[gameObjCheck.progress intValue]];
//                    result.progress=progressStr;
//                    result.plantName=gameObjCheck.plantName;
//                    result.plantType=gameObjCheck.plantType;
//                    result.gameType=@"WalkPlanyt";
//                    result.status=@"0";
//                    [result setEndDate:time];
//                    [DBHelper addPlant:result];
                    NSString * thrRpadStr=[[NSString alloc]initWithFormat:@"plant_%@_%@_N",gameObjCheck.plantType,gameObjCheck.progress];
                    
//                    resultView.theADDRoadStr=thrRpadStr;
                       self.theADDRoadStr=thrRpadStr;
                       self.theLingTimeStr=result.progress;
                    [resultView setTheADDRoadStr:thrRpadStr];
                    
                }
                WalkingRecord* temObj2=[[WalkingRecord alloc] initWithSteps:temObj.steps distance:temObj.distance calsburnt:temObj.calsburnt pace:temObj.pace trainid:@"" gps:@"" route:@"" recordid:@"" result:@"" target:temObj.target foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text]   time:time type:0 persistime:_gobalduration];
                temObj2.steps=[DBHelper encryptionString:temObj2.steps];
                temObj2.distance=[DBHelper encryptionString:temObj2.distance];
                temObj2.calsburnt=[DBHelper encryptionString:temObj2.calsburnt];
                temObj2.persistimeStr=[DBHelper encryptionString:temObj2.persistimeStr];
                              [DBHelper addWalkingRecord:temObj2];
           
            }
            
            NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(takeTheTime) object:nil];
            [myThread start];
        }
        else
        {
            
                    chickC=NO;
              resultView.isCOK=@"0";
            
//未成功跑完
            if (gameObjCheck.plantName!=nil)
            {
                NSString * thrRpadStr=[[NSString alloc]initWithFormat:@"plant_%@_%@_F",gameObjCheck.plantType,gameObjCheck.progress];
                
              self.theADDRoadStr=thrRpadStr;
                 [resultView setTheADDRoadStr:thrRpadStr];
                
                
            }
            else
            {
                
            }
            WalkingRecord* temObj2=[[WalkingRecord alloc] initWithSteps:temObj.steps distance:temObj.distance calsburnt:temObj.calsburnt pace:temObj.pace trainid:@"" gps:@"" route:@"" recordid:@"" result:@"" target:temObj.target foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text]   time:time type:0 persistime:_gobalduration];
            temObj2.steps=[DBHelper encryptionString:temObj2.steps];
            temObj2.distance=[DBHelper encryptionString:temObj2.distance];
            temObj2.calsburnt=[DBHelper encryptionString:temObj2.calsburnt];
            temObj2.persistimeStr=[DBHelper encryptionString:temObj2.persistimeStr];
            
            
            [DBHelper addWalkingRecord:temObj2];
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        NSLog(@"---------------------------333-----------------------+++++++++++");
//        NSLog(@"resultView.theADDRoadStr=%@",resultView.theADDRoadStr);
//        NSLog(@"resultresultresultTurn==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@", resultView.result, resultView.result.distance, resultView.result.steps, resultView.result.pace, resultView.result.calsburnt);
        //    [resultView setTargetValue:_targetValue.text];
        [resultView setLastActivity:@"Pedometer"];
        [self.navigationController pushViewController:resultView animated:YES ];
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
// id !=null
    else
    {
        GameObject *cwGameObject=[DBHelper getPlantProgress];
        
        NSString *cwProgress=[cwGameObject progress];
        int cwProgressINT=[cwProgress intValue];
        NSString *strType=[cwGameObject plantType];
    
        
        
         if (cwProgressINT>0)//old RP.progress>0
        {
            NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
            for (UILocalNotification *notification in notifications )
            {
                @try {
                    
                    if([[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw1"] ||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw2"])
                    {
                        [[UIApplication sharedApplication] cancelLocalNotification:notification];
                        
                        
                    }
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
            }
            
            GameObject *cwGameObject=[DBHelper getPlantProgress];
            
            NSString *cwProgress=[cwGameObject progress];
            int cwProgressINT=[cwProgress intValue];
            NSLog(@"cwProgressINT=cwProgressINT=cwProgressINT=cwProgressINT=cwProgressINT=cwProgressINT=%d",cwProgressINT);
            
           chickC=YES;
            
              NSLog(@"_gobalWalkingRecord1:%@,%@",_gobalWalkingRecord.distance,_gobalWalkingRecord.steps);
           

            _gobalCheckC=chickC;
            NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(callAPIbefore_switchpage) object:nil];
            [thread start];
         
//            NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(takeTheTime) object:nil];
//            [myThread start];
            
        }
        else if(cwProgressINT==0 &&( strType==nil ||[strType isEqualToString:@""]))
        {
            //Chick C
            
            
            
            NSString *durationStr=[[NSString alloc]initWithFormat:@"%ld",duration];
            chickC=[SyncGame checkPlantProgress:durationStr steps:self.stepsLabel.text];
            
            NSLog(@"CCC===%d,",chickC);
            if (chickC==YES)
            {
                NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
                for (UILocalNotification *notification in notifications )
                {
                    
                    @try {
                        
                        if([[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw1"] ||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw2"])
                        {
                            [[UIApplication sharedApplication] cancelLocalNotification:notification];
                            
                            
                        }
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                    
                    
                }
                
                //C ok
                  self.theLingTimeStr=@"1";
                NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(takeTheTime) object:nil];
                [myThread start];
                resultView.isCOK=@"1";
           //     [resultView setResult:result];
                resultView.result=result;
                
                NSLog(@"resultresultresultTurn==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@", resultView.result, resultView.result.distance, resultView.result.steps, resultView.result.pace, resultView.result.calsburnt);
                
                //    [resultView setTargetValue:_targetValue.text];
                [resultView setLastActivity:@"Pedometer"];
               [self.navigationController pushViewController:resultView animated:YES ];
                
                
                
            }
            else
            {
                //C not
                resultView.isCOK=@"0";
                NSLog(@"--------------------------------------------------+++++++++++");
                
                WalkingRecord* temObj=[[WalkingRecord alloc] initWithSteps:result.steps distance:result.distance calsburnt:result.calsburnt pace:result.pace trainid:@"" gps:@"" route:@"" recordid:@"" result:@"" target:result.target foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text]   time:time type:0 persistime:_gobalduration];

                
                resultView.result=temObj;

                
                
                [SyncWalking addWalkingRcord:result];
           //     [resultView setResult:result];
                
                
                
                
                   NSLog(@"resultresultresultTurn==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@", resultView.result, resultView.result.distance, resultView.result.steps, resultView.result.pace, resultView.result.calsburnt);
                //    [resultView setTargetValue:_targetValue.text];
                [resultView setLastActivity:@"Pedometer"];
                [self.navigationController pushViewController:resultView animated:YES ];
                
                
                
                
                
                
            }
            
            
            
        }
        else
        {
            
            
            GameObject *cwGameObject=[DBHelper getPlantProgress];
            
            NSString *cwProgress=[cwGameObject progress];
            int cwProgressINT=[cwProgress intValue];
            NSLog(@"I am Zero=%d",cwProgressINT);
            
            chickC=YES;
            
            
            _gobalWalkingRecord = [[WalkingRecord alloc]init];
            _gobalWalkingRecord=result;
            _gobalCheckC=chickC;
            NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(callAPIbefore_switchpage) object:nil];
            [thread start];
            //            NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(takeTheTime) object:nil];
            //            [myThread start];
            
             // [self.navigationController pushViewController:resultView animated:YES ];
            
        }
        
        
        
    }
    
    
    
    
    
    
    
}



- (void)goToBackground  {
    
//    @try {
//        
//        [self.mapView removeObserver:self
//                          forKeyPath:@"myLocation"
//                             context:NULL];
//    }
//    @catch (NSException *exception) {
//        
//        NSLog(@"%@.....exception",[exception description]);
//    }
//    @finally {
//        
//        
//    }
//    
//    NSLog(@"55555555555555");
//    
//    
//    
//    self.pause_resume_Btn.tag=1;
//    
//    [self.pause_resume_Btn setBackgroundImage:[UIImage imageNamed:@"hr_btn_wa_green_2.png"] forState:UIControlStateNormal];
//    
//    [self.pause_resume_Btn setTitle:@"Resume" forState:UIControlStateNormal];
//    
//    double currentTime = CFAbsoluteTimeGetCurrent();
//    
//    self.timePre=currentTime - self.startTime+self.timePre;
//    
//    [self stopRecordWalking];
//    
//    
//    [_pause_resume_Btn setTitle:[Utility getStringByKey:@"resume_btn"] forState: normal];
//    
//    
//    
//    [_audioPlayer stop];

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
//        
//        self.mapView.myLocationEnabled = YES;
//
//        
        
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
    __min.font=[UIFont fontWithName:font77 size:12];
    _speedLabelUnit.font=[UIFont fontWithName:font77 size:12];
      _speedLabelUnit2.font=[UIFont fontWithName:font77 size:12];
    _timeHourLabel.font=[UIFont fontWithName:font57 size:53];
    _timeMinuteLabel.font=[UIFont fontWithName:font57 size:53];
    _timeSecondLabel.font=[UIFont fontWithName:font57 size:53];
    _timeSplit1Label.font=[UIFont fontWithName:font57 size:53];
    _timeSplit2Label.font=[UIFont fontWithName:font57 size:53];
    if (iPad){
        _timeHourLabel.font=[UIFont fontWithName:font57 size:30];
        _timeMinuteLabel.font=[UIFont fontWithName:font57 size:30];
        _timeSecondLabel.font=[UIFont fontWithName:font57 size:30];
        _timeSplit1Label.font=[UIFont fontWithName:font57 size:30];
        _timeSplit2Label.font=[UIFont fontWithName:font57 size:30];

    }
    
    
    
    
    _pause_resume_Btn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    _plan_route_Btn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    _start_Btn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    _stop_Btn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    
    _divideTarget.font=[UIFont fontWithName:font67 size:15];
    _targetValue.font=[UIFont fontWithName:font67 size:15];
    
    
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
        
        
//        [self.stepCounter queryStepCountStartingFrom:[NSDate date] to:[NSDate date] toQueue:self.operationQueue withHandler:^(NSInteger numberOfSteps,NSError *error){
        
        
        
        
   [self.stepCounter startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
                                                  
            NSInteger numberOfSteps = [pedometerData.numberOfSteps integerValue];
                                                  
                                                  
                                                  //NSLog(@"%s %ld %@ %@", __PRETTY_FUNCTION__, (long)numberOfSteps, timestamp, error);
                                                  //self.stepsLabel.text = [@(numberOfSteps) stringValue];
                                                  
                                                   //NSLog(@"%ld------------step count------%ld",(long)self.stepsCount,(long)numberOfSteps);
                                                  
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
    
    
    //NSLog(@"distance......%f",dis);
    
    //float show_distance=round(self.stepsDistance/1000.0f*1000)/1000;
    
    self.distanceLabel.text=[NSString stringWithFormat:@"%.03f",dis];
    
    
}

-(void)updateTime:(NSArray*)timeSplit{
    
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    double elapsedTime = currentTime - self.startTime+self.timePre;
    
    
    NSLog(@"disTancel:%f",[self.distanceLabel.text doubleValue]);
    NSLog(@"elapsedTime:%f",elapsedTime);
    
    
    
    
    if (elapsedTime>60) {
        double disTancel=[self.distanceLabel.text doubleValue];
        double speedDouble=disTancel/(elapsedTime/60/60);
        NSLog(@"elapseTime=%lf",elapsedTime);
        NSLog(@"disTancel=%fspeedDouble=%f",disTancel,speedDouble);
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
        double disTancel=[self.distanceLabel.text doubleValue];
        double speedDouble=disTancel/(elapsedTime/60/60);
        NSLog(@"disTancel=%fspeedDouble=%f",disTancel,speedDouble);
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
    unsigned long milliSecs = (unsigned long)(elapsedTime * 1000);
    
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
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
//    
//    int cal=(((13.75*weight)+(5*height)-(6.76*age)+66)/24)*3.5*(duration/60);
    
    
    float weight=[[Utility getWeight] floatValue]/2.2f;//get weight,unit is kg;
    float height=[[Utility getHeight] floatValue];//get height,unit is cm;
    float age=year-[[Utility getBirth] integerValue];//get age;
    
    
    
    
    
    float duration=milliSecs/1000/60;
    // float speed=mDistanceValue/duration;
    
    BOOL isMale=[[Utility getGender] isEqualToString:@"M"];
    
    NSString *session_ids = [GlobalVariables shareInstance].session_id;
    NSString *login_ids = [GlobalVariables shareInstance].login_id;
    if(session_ids==NULL||login_ids==NULL){
        weight=70;
        height=170;
        age=25;
        isMale=true;
    }

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
    NSLog(@"duration:%f",duration);
    NSLog(@"bmr:%f",bmr);
    NSLog(@"met:%f",met);

    int cal=(int) (duration*bmr*met/60);
    
    self.timeHourLabel.text=[timeSplit objectAtIndex:0];
    self.timeMinuteLabel.text=[timeSplit objectAtIndex:1];
    self.timeSecondLabel.text=[timeSplit objectAtIndex:2];
    
    self.calsLabel.text=[NSString stringWithFormat:@"%d",cal];

    [self updateStep];
}







-(void)initYearPicker{
    
    self.targetPicker= [[AFPickerView alloc] initWithFrame:CGRectMake(70, 50, 147, 172)];

    _targetData=[[NSMutableArray alloc] init];
    

    for(int i=0;i<60;i++)
    {
        if(i==0)
        {
            [_targetData addObject:@"- -"];

        }
        else{
            
            int temp_int=(100+(i-1)*50);
            [_targetData addObject:[NSString stringWithFormat:@"%d",temp_int]];

        }
        
    }
    
    
    //NSLog(@"%d......",[_targetData count]);
    
    self.targetPicker.dataSource = self;
    self.targetPicker.delegate = self;
    [self.targetPicker reloadData];
    //[self.targetPicker setSelectedRow:[_targetData count]-1];
    [self.chooseBirthContentView addSubview:self.targetPicker];
    
    _targetTmpValue=@"";
    
    
    
    if([_targetValue.text integerValue]>0){
        [self.targetPicker setSelectedRow:[_targetValue.text integerValue]/50-1];
    }
    
}

#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row
{
    
    
    if (self.pacePicker==pickerView) {
        _paceTempValue=[_PaceData objectAtIndex:row];
       
    
        if(_startView.hidden==true){
            [self checkTheMP3Path];
            if([_pause_resume_Btn.titleLabel.text isEqualToString:[Utility getStringByKey:@"pause_btn"]]){  //判斷是否有暫停
                if([_checkPlaying isEqualToString:@"Y"]) {
                    [_audioPlayer play];
                }
                else {
//                    _checkPlaying=@"Y";
//                    [_audioPlayer play];
                    //edit by vaycent
                }

            }
            
           
        }
    }
    else{
        _targetTmpValue=[_targetData objectAtIndex:row];

    }
       NSLog(@"%@......check targevalue",_targetTmpValue);
}


- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{

//    NSLog(@"%@....",[_targetData objectAtIndex:row]);
    if (self.pacePicker==pickerView) {
        return [_PaceData objectAtIndex:row];
    }
    else{
        return [_targetData objectAtIndex:row];
        
    }

    
    
    
    
    
    
    
}
#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
    if (self.pacePicker==pickerView) {
        return [_PaceData count];
    }
    else{
         return [_targetData count];
        
    }

    
   
    
}


-(IBAction)settargetClick:(id)sender{
    _chooseBirthContentView.hidden=false;
    _chooseBirthView.hidden=false;
    [self initYearPicker];
    self.chickTheCal=@"Yes";
}




-(IBAction)chooseScrollCancel:(id)sender{
  _chooseBirthContentView.hidden=true;
    _chooseBirthView.hidden=true;
}

-(IBAction)chooseScrollOk:(id)sender{
    if([_targetTmpValue isEqualToString:@""]||[_targetTmpValue isEqualToString:@"- -"]){
        _divideTarget.hidden=true;
        _targetValue.hidden=true;
        _targetValue.text=@"0";
       
        
         [self.targetSetBtn setBackgroundImage:[UIImage imageNamed:@"07_ca_btn_target.png"] forState:UIControlStateNormal];
    }
    else{
         _divideTarget.hidden=false;
         _targetValue.hidden=false;
         _targetValue.text=_targetTmpValue;
        [self.targetSetBtn setBackgroundImage:[UIImage imageNamed:@"new_ca_btn_target_edit.png"] forState:UIControlStateNormal];
    }
    _chooseBirthContentView.hidden=true;
    _chooseBirthView.hidden=true;

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
        
   // [self performSelectorOnMainThread:@selector(updateDistance) withObject:Nil waitUntilDone:NO];
    
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
            
           // NSLog(@"check the circulateCount : %d",circulateCount);
            
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
    
//     NSLog(@"check it coming : %hhd",firstLocationUpdate);
    if (!firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        NSLog(@"check it coming");
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
    //NSLog(@"%d......",[_PaceData count]);
    
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
//        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
        
        _audioPlayer = [[AVAudioPlayer alloc]  initWithContentsOfURL:musicURL  error:nil];
        [_audioPlayer setDelegate:self];
        
//        [_audioPlayer prepareToPlay];
        _audioPlayer.numberOfLoops = -1;
    }



}









-(IBAction)soundPlayClick:(id)sender{
//    _switchSound.hidden=true;
    _sliderView.hidden=true;
   
    
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



-(void)checkRunning{
    if([[GlobalVariables shareInstance].running isEqualToString:@"pedometer"]){
        isRunning=true;
        _startView.hidden=true;
        _distanceLabel.text=[GlobalVariables shareInstance].distanceGlo;
        _stepsLabel.text=[GlobalVariables shareInstance].stepseGlo;
        _paceLabel.text=[GlobalVariables shareInstance].paceGlo ;
        _calsLabel.text=[GlobalVariables shareInstance].caleGlo ;
        _targetValue.text=[GlobalVariables shareInstance].targetGlo ;
        
        
        self.mapView.myLocationEnabled = YES;
        
        
        
        self.pause_resume_Btn.tag=0;
        
        [self.pause_resume_Btn setBackgroundImage:[UIImage imageNamed:@"hr_btn_wa_blue_2.png"] forState:UIControlStateNormal];
        
        [self.pause_resume_Btn setTitle:@"Pause" forState:UIControlStateNormal];
        
        [self startRecordWalking];
        
        [_pause_resume_Btn setTitle:[Utility getStringByKey:@"pause_btn"] forState: normal];
        
        if([_checkPlaying isEqualToString:@"Y"]){
            [_audioPlayer play];
        }

       //
        
    }
}


-(void)callAPIbefore_switchpage{
      WalkingResultViewController *resultView = [[WalkingResultViewController alloc] initWithNibName:@"WalkingResultViewController" bundle:nil];
    
    NSDate *date=[NSDate date];
    
    long time=[date timeIntervalSince1970];
    
    
    WalkingRecord* temObj=[[WalkingRecord alloc] initWithSteps:_gobalWalkingRecord.steps distance:_gobalWalkingRecord.distance calsburnt:_gobalWalkingRecord.calsburnt pace:_gobalWalkingRecord.pace trainid:@"" gps:_gobalWalkingRecord.gps route:_gobalWalkingRecord.route recordid:@"" result:@"" target:_gobalWalkingRecord.target foodlist:@""persistimeStr:[NSString stringWithFormat:@"%@:%@:%@",_timeHourLabel.text,_timeMinuteLabel.text,_timeSecondLabel.text]   time:time type:0 persistime:_gobalduration];

    NSLog(@"_gobalWalkingRecord6666:%@,%@",temObj.distance,temObj.steps);

    
    
//   WalkingRecord* temObj=_gobalWalkingRecord;
//    NSString *strtem=_gobalWalkingRecord.steps;
//    temObj.steps=strtem;
//    strtem=_gobalWalkingRecord.distance;
//    temObj.distance=strtem;
//    strtem=_gobalWalkingRecord.calsburnt;
//    temObj.calsburnt=strtem;
//    strtem=_gobalWalkingRecord.persistimeStr;
//    temObj.persistimeStr=strtem;
    
    resultView.result=temObj;


    
    
    
    
    NSMutableArray *array=[SyncWalking addWalkingRcord:_gobalWalkingRecord];


    
    NSString *message=[array objectAtIndex:0];
    NSString *shareage=[array objectAtIndex:1];
      NSLog(@"message:%@",message);
    if(shareage!=nil&&![shareage isEqualToString:@""])
    {
        
        resultView.theShareStrRoad=shareage;
        
    }
    if(message!=nil&&![message isEqualToString:@""])
    {
        GameObject *newDBTP= [SyncGame getPlantProgress];
        
        NSString *newprogress=[newDBTP progress];
        NSString *newName=[newDBTP plantName];
        NSString *newtype=[newDBTP plantType];
        NSLog(@"name===%@",newName);
        NSLog(@"type===%@",newtype);
        NSLog(@"progress=%@",newprogress);
        //   int newprogressINT=[newprogress intValue];
        
        
        if (_gobalCheckC==1)
        {
            //OK
            self.theADDRoadStr=message;
            resultView.theADDRoadStr=self.theADDRoadStr;
            NSString *number=[self.theADDRoadStr substringWithRange:NSMakeRange(8, 1)];
            self.theLingTimeStr=number;
            //    [SyncGame getPlantProgress];
         //   [resultView setResult:_gobalWalkingRecord];
            [self takeTheTime];
            NSLog(@"_gobalWalkingRecord3:%@,%@",_gobalWalkingRecord.distance,_gobalWalkingRecord.steps);
            //    [resultView setTargetValue:_targetValue.text];
            [resultView setLastActivity:@"Pedometer"];
            [self.navigationController pushViewController:resultView animated:YES ];
            
            
            
        }
        else
        {
            //not
            self.theADDRoadStr=message;
          
            resultView.theADDRoadStr=self.theADDRoadStr;
       //     [resultView setResult:_gobalWalkingRecord];
            
            
               NSLog(@"resultresultresultTurn==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@", resultView.result, resultView.result.distance, resultView.result.steps, resultView.result.pace, resultView.result.calsburnt);
            //    [resultView setTargetValue:_targetValue.text];
            [resultView setLastActivity:@"Pedometer"];
            [self.navigationController pushViewController:resultView animated:YES ];
            
            
        }

    }
}
-(void)takeTheTime
{
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"notificationssssssssssssss==%@",notifications);
    NSLog(@"notificationSSSSSS.count=%lu",(unsigned long)notifications.count);
    for (int i=0;i<notifications.count;i++)
    {
        UILocalNotification *notification=[notifications objectAtIndex:i];
        NSLog(@"notification==%@",notification);
        
        @try {
            
            if([[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw1"] ||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"cw2"])
            {
                NSLog(@"_______Delete");
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@", strDate);
    
    NSString *strTemp=[[NSString alloc]initWithFormat:@"%@ 09:00:00",strDate];
    
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [dateFormatter2 dateFromString:strTemp];
    NSLog(@"%@", date2);
    
    
    
    NSTimeInterval secondsPerDay5 = (24*60*60)*5;
    NSDate *tomorrow5 = [date2 dateByAddingTimeInterval:secondsPerDay5];
    NSDictionary *dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw1",@"title", nil];
    NSString *name1;
    if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
        name1=@"你嘅植物顯得好無⽣氣,請喺2日內再次步⾏以提供養分,不然植物就會退化⾄之前嘅成長階段。";
    }
    else
    {
        name1=@"Your plant is getting unhealthy, please walk within the next 2 days, or else it will regress to the previous stage.";
    }
    [self resetClock:tomorrow5 timeNAme:name1 userInfo:dic1];
    
    
    
    NSLog(@"Self TheAddRoadStr=%@",self.theADDRoadStr);
    
    
    
    
    
    if ([self.theLingTimeStr intValue]==5)
    {
        for (int i=8; i<29; i+=7)
        {
            NSTimeInterval secondsPerDay7 = (24*60*60)*i;
            NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
            NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw1",@"title", nil];
            NSString *name01;
            
            if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                
                name01=@"你已經有段時間沒有以步行為植物提供養分,以致植物顯得好無生氣。請重新步行。";
            }
            else
            {
                name01=@"You haven’t been walking to provide nutrients to your plant and it is unhealthy. Please resume walking.";
            }
            [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
        }
        for (int i=29; i<36; i+=7)
        {
            NSTimeInterval secondsPerDay7 = (24*60*60)*i;
            NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
            NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw1",@"title", nil];
            NSString *name01;
            if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                
                name01=@"你嘅植物已頻臨枯萎。請重新步行,令你同你嘅植物更健康。";
            }
            else
            {
                name01=@"Your plant is very unhealthy! Please resume walking, so that you and your plant can be healthier.";
            }
            [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
        }
        
        NSTimeInterval secondsPerDay7 = (24*60*60)*(36);
        NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
        NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw2",@"title", nil];
        NSString *name2;
        if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
            
            name2=@"你嘅植物已經枯萎。立即再次開始步行,給予新一棵植物⽣命。";
        }
        else
        {
            name2=@"Your plant is withered! Please start walking again and give life to a new plant.";
        }
        [self resetClock:tomorrow7 timeNAme:name2 userInfo:dic2];
        
        
    }
    else  if ([self.theLingTimeStr intValue]==4)
    {
        for (int i=1+7; i<22; i+=7)
        {
            NSTimeInterval secondsPerDay7 = (24*60*60)*i;
            NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
            NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw1",@"title", nil];
            NSString *name01;
            
            if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                
                name01=@"你已經有段時間沒有以步行為植物提供養分,以致植物顯得好無生氣。請重新步行。";
            }
            else
            {
                name01=@"You haven’t been walking to provide nutrients to your plant and it is unhealthy. Please resume walking.";
            }
            [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
        }
        for (int i=22; i<29; i+=7)
        {
            NSTimeInterval secondsPerDay7 = (24*60*60)*i;
            NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
            NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw1",@"title", nil];
            NSString *name01;
            if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                
                name01=@"你嘅植物已頻臨枯萎。請重新步行,令你同你嘅植物更健康。";
            }
            else
            {
                name01=@"Your plant is very unhealthy! Please resume walking, so that you and your plant can be healthier.";
            }
            [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
        }
        
        NSTimeInterval secondsPerDay7 = (24*60*60)*(29);
        NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
        NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw2",@"title", nil];
        NSString *name2;
        if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
            
            name2=@"你嘅植物已經枯萎。立即再次開始步行,給予新一棵植物⽣命。";
        }
        else
        {
            name2=@"Your plant is withered! Please start walking again and give life to a new plant.";
        }
        [self resetClock:tomorrow7 timeNAme:name2 userInfo:dic2];
        
        
    }
    else if ([self.theLingTimeStr intValue]==3)
    {
        for (int i=1+7; i<15; i+=7)
        {
            NSTimeInterval secondsPerDay7 = (24*60*60)*i;
            NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
            NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw1",@"title", nil];
            NSString *name01;
            
            if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                
                name01=@"你已經有段時間沒有以步行為植物提供養分,以致植物顯得好無生氣。請重新步行。";
            }
            else
            {
                name01=@"You haven’t been walking to provide nutrients to your plant and it is unhealthy. Please resume walking.";
            }
            [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
        }
        for (int i=15; i<22; i+=7)
        {
            NSTimeInterval secondsPerDay7 = (24*60*60)*i;
            NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
            NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw1",@"title", nil];
            NSString *name01;
            if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                
                name01=@"你嘅植物已頻臨枯萎。請重新步行,令你同你嘅植物更健康。";
            }
            else
            {
                name01=@"Your plant is very unhealthy! Please resume walking, so that you and your plant can be healthier.";
            }
            [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
        }
        
        NSTimeInterval secondsPerDay7 = (24*60*60)*(22);
        NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
        NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw2",@"title", nil];
        NSString *name2;
        if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
            
            name2=@"你嘅植物已經枯萎。立即再次開始步行,給予新一棵植物⽣命。";
        }
        else
        {
            name2=@"Your plant is withered! Please start walking again and give life to a new plant.";
        }
        [self resetClock:tomorrow7 timeNAme:name2 userInfo:dic2];
        
        
        
    }
    else  if ([self.theLingTimeStr intValue]==2)
    {
        
        for (int i=8; i<15; i+=7)
        {
            NSTimeInterval secondsPerDay7 = (24*60*60)*i;
            NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
            NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw1",@"title", nil];
            NSString *name01;
            if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                
                name01=@"你嘅植物已頻臨枯萎。請重新步行,令你同你嘅植物更健康。";
            }
            else
            {
                name01=@"Your plant is very unhealthy! Please resume walking, so that you and your plant can be healthier.";
            }
            [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
        }
        
        NSTimeInterval secondsPerDay7 = (24*60*60)*(15);
        NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
        NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw2",@"title", nil];
        NSString *name2;
        if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
            
            name2=@"你嘅植物已經枯萎。立即再次開始步行,給予新一棵植物⽣命。";
        }
        else
        {
            name2=@"Your plant is withered! Please start walking again and give life to a new plant.";
        }
        [self resetClock:tomorrow7 timeNAme:name2 userInfo:dic2];
        
        
    }
    else if ([self.theLingTimeStr intValue]==1)
    {
        
        
        NSTimeInterval secondsPerDay7 = (24*60*60)*8;
        NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
        NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw2",@"title", nil];
        NSString *name2;
        if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
            
            name2=@"你嘅植物已經枯萎。立即再次開始步行,給予新一棵植物⽣命。";
        }
        else
        {
            name2=@"Your plant is withered! Please start walking again and give life to a new plant.";
        }
        [self resetClock:tomorrow7 timeNAme:name2 userInfo:dic2];
        
        
        
    }
    else if ([self.theLingTimeStr intValue]==0)
    {
        NSTimeInterval secondsPerDay7 = (24*60*60)*8;
        NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
        NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"cw2",@"title", nil];
        NSString *name2;
        if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
            
            name2=@"你嘅植物已經枯萎。立即再次開始步行,給予新一棵植物⽣命。";
        }
        else
        {
            name2=@"Your plant is withered! Please start walking again and give life to a new plant.";
        }
        [self resetClock:tomorrow7 timeNAme:name2 userInfo:dic2];
    }
    
    



}


- (void)resetClock:(NSDate*)date timeNAme:(NSString*)name userInfo:(NSDictionary*)dic
{
   
    
    UILocalNotification *notification = [[UILocalNotification alloc] init] ;
    //设置時間
    NSLog(@"%@      %@    %@",date,[NSDate date],name);
    NSDate *pushDate = date ;
    if (notification != nil)
    {
        // 设置推送时间
        notification.fireDate = pushDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
    
        // 推送声音
        notification.soundName =@"oldphone-mono-30s.caf";
        // 推送内容
        notification.alertBody =name;
        
        
        notification.applicationIconBadgeNumber = 0;
        
        //显示在icon上的红色圈中的数子
        if ([[dic objectForKey:@"title"]isEqualToString:@"cw1"]) {
            // 设置重复间隔
            //  notification.repeatInterval = kCFCalendarUnitDay;
            notification.repeatInterval =0;
            NSLog(@"11111111111");
        }
        else
        {
            // 设置重复间隔
            //  notification.repeatInterval = kCFCalendarUnitDay;
            notification.repeatInterval = 0;
                NSLog(@"2222222222");
        }
        
        
        
        //设置userinfo 方便在之后需要撤销的时候使用
        //  NSDictionary *info = [NSDictionary dictionaryWithObject:name forKey:@"id"];
        //NSLog(@"info=%@",info);
        
        
        
        notification.userInfo = dic;
        
        //添加推送到UIApplication
       // [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        //这句真的特别特别重要。如果不加这一句，通知到时间了，发现顶部通知栏提示的地方有了，然后你通过通知栏进去，然后你发现通知栏里边还有这个提示
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
        
    }

    
    
    
}

@end
