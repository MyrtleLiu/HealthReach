//
//  RoutePlannerViewController.m
//  mHealth
//
//  Created by sngz on 14-1-22.
//
//

#import "RoutePlannerViewController.h"
#import "WalkForHealthViewController.h"
#import "HomeViewController.h"
#import "mHealth_iPhoneAppDelegate.h"

@interface RoutePlannerViewController (){
    
    BOOL firstLocationUpdate;
    
    float totalDistance;
    
    BOOL isReturnRoute;
    
    BOOL isCirculateRoute;
    
    NSInteger circulateCount;
    
    BOOL isFromPedometer;
}

@end

@implementation RoutePlannerViewController

@synthesize targetCal;

@synthesize mapView,points,distanceLabel,timeLabel,calsLabel,circulateLabel,returnRouteBtn,circulateRouteBtn,circulateView,circulateCloseBtn;
@synthesize circulateItems;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (iPad) {
        self = [super initWithNibName:@"RoutePlannerViewController_ipad" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"RoutePlannerViewController" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
        
        isFromPedometer=false;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    isReturnRoute=false;
    circulateCount=0;
    self.circulateItems = [[NSArray alloc] initWithObjects:@"- -",@"x 1",@"x 2",@"x 3",@"x 4",@"x 5",@"x 6", nil];
    self.points = [[NSMutableArray alloc] init];

    self.mapView.settings.myLocationButton = YES;
    
    self.mapView.delegate=self;
    
    self.circulateView.backgroundColor = [UIColor clearColor];
    self.circulateView.hidden = true;
    self.circulateLabel.hidden = true;
    // Listen to the myLocation property of GMSMapView.
    [self.mapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

    totalDistance=0;
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.myLocationEnabled = YES;
    });
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *saveDate=[userDefaults objectForKey:@"PlannedRoute"];

    
    if (saveDate!=Nil) {

        [self.points addObjectsFromArray:saveDate];

        NSString *returnRoute=[userDefaults objectForKey:@"isReturnRoute"];
        
        if ([returnRoute isEqualToString:@"1"]) {
            
            isReturnRoute=true;
        }else{
            
            isReturnRoute=false;
        }
        
        if (isReturnRoute) {
            NSString *lanuage = [Utility getLanguageCode];
            if([lanuage isEqualToString: @"en"])
                [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on.png"] forState:UIControlStateNormal];
            else{
                [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on_cn.png"] forState:UIControlStateNormal];
            }
        }else{
            NSString *lanuage = [Utility getLanguageCode];
            if([lanuage isEqualToString: @"en"])
                [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on.png"] forState:UIControlStateNormal];
            else{
                [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on_cn.png"] forState:UIControlStateNormal];
                
            }
            
           
            
        }
        
        
        isCirculateRoute=[userDefaults boolForKey:@"checkCirculateRoute"];
        circulateCount=[userDefaults integerForKey:@"checkCirculateCount"];
        if(circulateCount==0)
            isCirculateRoute=false;
        //NSLog(@"[userDefaults objectForKey:@checkCirculateRoute] : %hhd",[userDefaults boolForKey:@"checkCirculateRoute"]);
        //NSLog(@"[userDefaults objectForKey:@checkCirculateCount] : %d",[userDefaults integerForKey :@"checkCirculateCount"]);
        
        
        
        
    }
    [self updateRoute];
    NSLog(@"1212312321 : %@",targetCal);
    if(targetCal!=nil){
        _plannerView.hidden=true;
        _foodView.hidden=false;
        [_foodtarget setText:targetCal];
    }

    
     [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] checkLocationService];
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
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


-(void)viewWillAppear:(BOOL)animated{
    _durationText.font=[UIFont fontWithName:font55 size:10];
    _distanceText.font=[UIFont fontWithName:font55 size:10];
    _km_unit.font=[UIFont fontWithName:font55 size:10];
    _calText.font=[UIFont fontWithName:font55 size:10];
    _cal_unit.font=[UIFont fontWithName:font55 size:10];

    timeLabel.font=[UIFont fontWithName:font55 size:16];
    distanceLabel.font=[UIFont fontWithName:font55 size:16];
    calsLabel.font=[UIFont fontWithName:font55 size:16];

    [_durationText setText:[Utility getStringByKey:@"planroute_duration"]];
    [_distanceText setText:[Utility getStringByKey:@"planroute_distance"]];
    [_km_unit setText:[Utility getStringByKey:@"km_unit"]];
    [_calText setText:[Utility getStringByKey:@"planroute_calories"]];
    [_cal_unit setText:[Utility getStringByKey:@"cal_unit"]];
   
    [_actionbar setText:[Utility getStringByKey:@"planroute_action"]];
    [_okBtn setTitle:[Utility getStringByKey:@"save"] forState: normal];
    _okBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_cancelBtn setTitle:[Utility getStringByKey:@"cancel"] forState: normal];
    _cancelBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    
    
    [_tx1 setText:[Utility getStringByKey:@"planroute_circu_tx1"]];
    
    
    
    [_foodText setText:[Utility getStringByKey:@"food_planner_tx"]];
    [_foodcal1 setText:[Utility getStringByKey:@"food_planner_calunit1"]];
    [_foodcal2 setText:[Utility getStringByKey:@"cal_unit"]];
    
     _foodburn.font=[UIFont fontWithName:font55 size:16];
     _foodtarget.font=[UIFont fontWithName:font55 size:16];
    
    _foodText.font=[UIFont fontWithName:font55 size:10];
    _foodcal1.font=[UIFont fontWithName:font55 size:10];
    _foodcal2.font=[UIFont fontWithName:font55 size:10];
    

    
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on.png"] forState:UIControlStateNormal];
    else{
        [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on_cn.png"] forState:UIControlStateNormal];
        
    }

     if (iPad) {   //iphone4
         _iphone4View.frame=CGRectMake(20,85,242,50);
         _iphone4ViewBg.frame=CGRectMake(15,80,247,55);

     }
}










- (void)setIsFromPedometer:(BOOL)theresult{
    
    isFromPedometer=theresult;
}


-(IBAction)BackButtonClick:(id)sender{
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
    

    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
  
        
        [self backToHome];
    }

}


-(IBAction)BackHome:(id)sender{

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

-(IBAction)toBack:(id)sender{
    
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

-(IBAction)saveRoute:(id)sender{

    
    @try {
        
        [self.mapView removeObserver:self
                          forKeyPath:@"myLocation"
                             context:NULL];
    }
    @catch (NSException *exception) {
        
       // NSLog(@"%@.....exception",[exception description]);
    }
    @finally {
        
        
    }
    
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.points forKey:@"PlannedRoute"];
    
    [userDefaults setObject:isReturnRoute?@"1":@"0" forKey:@"isReturnRoute"];
    
    
    
    NSLog(@"check count : %ld",(long)circulateCount);
    [userDefaults setBool:isCirculateRoute forKey:@"checkCirculateRoute"];
    [userDefaults setInteger:circulateCount forKey:@"checkCirculateCount"];
    
    
    [userDefaults synchronize];
    
    if (isFromPedometer) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        if(_foodtarget.text!=NULL&&![_foodtarget.text isEqualToString:@""]){
            NSLog(@"come to here : %@",_foodtarget.text);
            int temPaceValue;
            if(_paceValueFromfood>0){
                temPaceValue=_paceValueFromfood;
            }
            else{
                temPaceValue=90;
            }
            WalkForHealthViewController *wfhView = [[WalkForHealthViewController alloc] initWithNibName:@"WalkForHealthViewController" bundle:nil];
            [wfhView setPaceSetValue:temPaceValue];
            [wfhView setTargetSetValue:[GlobalVariables shareInstance].caloriesTotal];
            [self.navigationController pushViewController:wfhView animated:YES ];

        }
        else{
            WalkForHealthViewController *wfhView = [[WalkForHealthViewController alloc] initWithNibName:@"WalkForHealthViewController" bundle:nil];
            
            [self.navigationController pushViewController:wfhView animated:YES ];
        }
       
        
        
       
    }
    

}

-(IBAction)returnRoute:(id)sender{
    
    isReturnRoute=!isReturnRoute;
    
    
    if (isReturnRoute) {
        NSString *lanuage = [Utility getLanguageCode];
        if([lanuage isEqualToString: @"en"])
            [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on.png"] forState:UIControlStateNormal];
        else{
            [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on_cn.png"] forState:UIControlStateNormal];
        }
    }else{
        NSString *lanuage = [Utility getLanguageCode];
        if([lanuage isEqualToString: @"en"])
            [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on.png"] forState:UIControlStateNormal];
        else{
            [returnRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_undo_on_cn.png"] forState:UIControlStateNormal];
            
        }
        
        
        
    }
    [self updateRoute];
}

-(IBAction)circulateRoute:(id)sender{
    if([self.points count]>=3){
        self.circulateView.hidden = false;
    }
}

-(IBAction)closeCirculateView:(id)sender{
    self.circulateView.hidden = true;
}
-(IBAction)undoRoute:(id)sender{
    
    if ([self.points count]>0) {
        
        [self.points removeLastObject];
    }
    if([self.points count]<3){
        isCirculateRoute = false;
        self.circulateLabel.text = @"";
        self.circulateLabel.hidden = true;
    }
    
    [self updateRoute];
    
    //CLLocation *last=[self.points lastObject];
    
    if ([self.points count]>0) {
        
        
        CLLocation* last = [NSKeyedUnarchiver unarchiveObjectWithData:[self.points lastObject]];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:last.coordinate.latitude
                                                                longitude:last.coordinate.longitude
                                                                     zoom:16];
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.5];
        
        [self.mapView animateToCameraPosition:camera];
        [CATransaction commit];
    }

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







-(void)updateRoute{
    
    [self.mapView clear];
    self.circulateView.hidden = true;
//    if (isReturnRoute) {
//        
//        
//        GMSPolyline *polyline = [[GMSPolyline alloc] init];
//        GMSMutablePath *path = [GMSMutablePath path];
//        
//        totalDistance=0;
//        
//        for (int i=0; i<[self.points count]; i++) {
//            
//            //CLLocation *location = [self.points objectAtIndex:i];
//            
//            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.points objectAtIndex:i]];
//            
//            if ([self.points count]>1&&i>0) {
//                
//                //CLLocation *beforLocation=[self.points objectAtIndex:i-1];
//                CLLocation* beforLocation = [NSKeyedUnarchiver unarchiveObjectWithData:[self.points objectAtIndex:i-1]];
//                float pointDistance=[self getDistance:beforLocation endPoint:location];
//                
//                totalDistance=totalDistance+pointDistance;
//                
//                NSLog(@"%f...........distance",totalDistance);
//                
//            }
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
//            australiaMarker.map = mapView;
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
//        int cout=(int)[self.points count]-1;
//        
//        for (int i=cout; i>-1; i--) {
//            
//            //CLLocation *location = [self.points objectAtIndex:i];
//            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.points objectAtIndex:i]];
//            if ([self.points count]>1&&i>0) {
//                
//                //CLLocation *beforLocation=[self.points objectAtIndex:i-1];
//                CLLocation* beforLocation = [NSKeyedUnarchiver unarchiveObjectWithData:[self.points objectAtIndex:i-1]];
//                float pointDistance=[self getDistance:beforLocation endPoint:location];
//                
//                totalDistance=totalDistance+pointDistance;
//                
//                NSLog(@"%f...........distance",totalDistance);
//                
//            }
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
//            australiaMarker.map = mapView;
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
        NSMutableArray *tempPoints = [[NSMutableArray alloc] initWithArray:points];
        [tempPoints addObject:[self.points firstObject]];
        
        if([self.points count] >= 3){
            [circulateRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_path_on.png"] forState:UIControlStateNormal];
        }else{
            isCirculateRoute = false;
            [circulateRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_path_off.png"] forState:UIControlStateNormal];
        }
        
        
        
        
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
                australiaMarker.map = mapView;
                
                
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
        NSLog(@"22222222");

        GMSPolyline *polyline = [[GMSPolyline alloc] init];
        GMSMutablePath *path = [GMSMutablePath path];
        
        totalDistance=0;
        if([self.points count] >= 3){
            [circulateRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_path_on.png"] forState:UIControlStateNormal];
        }else{
            isCirculateRoute = false;
            [circulateRouteBtn setImage:[UIImage imageNamed:@"09_route_icon_path_off.png"] forState:UIControlStateNormal];

        }
        for (int i=0; i<[self.points count]; i++) {
            
            //CLLocation *location = [self.points objectAtIndex:i];
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.points objectAtIndex:i]];
            if ([self.points count]>1&&i>0) {
                
                //CLLocation *beforLocation=[self.points objectAtIndex:i-1];
                
                CLLocation* beforLocation = [NSKeyedUnarchiver unarchiveObjectWithData:[self.points objectAtIndex:i-1]];
                
                float pointDistance=[self getDistance:beforLocation endPoint:location];
                
                totalDistance=totalDistance+pointDistance;
                
                NSLog(@"%f...........distance",totalDistance);
                
            }
            
            
            [path addCoordinate:location.coordinate];
            
            GMSMarker *australiaMarker = [[GMSMarker alloc] init];
            //australiaMarker.title = @"title";
            australiaMarker.position = location.coordinate;
            australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
            
            
            australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt2"];
            
            if (i==0) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
            }
            
            if ([self.points count]>1&&i==[self.points count]-1) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_end"];
            }
            
            australiaMarker.map = mapView;
            
            
        }
        
        polyline.path = path;
        polyline.strokeColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0/255.0 alpha:100];
        polyline.geodesic = YES;
        polyline.strokeWidth = 10;
        polyline.map = self.mapView;
        
    }
    
    NSLog(@"33333333");

    //common
    float show_distance=totalDistance/1000;
    
    distanceLabel.text=[NSString stringWithFormat:@"%.2f",show_distance];
    
    float countTime=totalDistance/1.3;
    
    int minutes=0;
    int seconds=0;
    
    if (countTime>60) {
        
        minutes=(countTime/60);
        
        countTime-=minutes*60;
    }
    
    seconds=countTime;
    
    timeLabel.text=[NSString stringWithFormat:@"%d'%d''",minutes,seconds];

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
    
    float weight=50;//kg
    
    float height=170;//cm
    
    float age=year-1980;
    
    float duration=totalDistance/1.3/60;
    
    int cal=(((13.75*weight)+(5*height)-(6.76*age)+66)/24)*3.5*(duration/60);
    
    calsLabel.text=[NSString stringWithFormat:@"%d",cal];
    _foodburn.text=[NSString stringWithFormat:@"%d",cal];
    
}


#pragma mark - google map

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    
    [self.points addObject:[NSKeyedArchiver archivedDataWithRootObject:location]];
    
    
    [self updateRoute];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate = YES;
        
        
//        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
//        self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
//                                                         zoom:16];
       
        
      
        
      
        if(_lat!=0&&_lon!=0){
            self.mapView.camera =[GMSCameraPosition cameraWithLatitude:_lat longitude:_lon zoom:16];
        }
        else{
            CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
                    self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                                    zoom:16];
        }
        
      
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.circulateItems count];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Step 1: Check to see if we can reuse a cell from a row that has just rolled off the screen
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // Step 2: If there are no cells to reuse, create a new one
    if(cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    // Step 3: Set the cell text
    cell.textLabel.text = [self.circulateItems objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    // Step 4: Return the cell
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 24.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return;
    }
    else if(indexPath.section==0)
    {
        self.circulateLabel.hidden = false;
        switch (indexPath.row)
        {
            case 0:
                self.circulateLabel.text = @"--";
//                circulateCount=0;
                break;
            case 1:
                self.circulateLabel.text = @"x1";
                circulateCount=1;
                break;
            case 2:
                self.circulateLabel.text = @"x2";
                circulateCount=2;
                break;
            case 3:
                self.circulateLabel.text = @"x3";
                circulateCount=3;
                break;
            case 4:
                self.circulateLabel.text = @"x4";
                circulateCount=4;
                break;
            case 5:
                self.circulateLabel.text = @"x5";
                circulateCount=5;
                break;
            case 6:
                self.circulateLabel.text = @"x6";
                circulateCount=6;
                break;
        }
        if(indexPath.row!=0)
            isCirculateRoute = true;
        else
            isCirculateRoute = false;
        self.circulateView.hidden = true;
        [self updateRoute];
    }
    else
    {
        return ;
    }
    
}

@end
