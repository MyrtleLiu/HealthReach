//
//  CalsViewController.m
//  mHealth
//
//  Created by evanli on 16/7/14.
//
//

#import "CalsViewController.h"
#import "CaloriesCustomCell.h"
#import "GlobalVariables.h"
#import "NSNotificationCenter+MainThread.h"
#import "DBHelper.h"
#import "Utility.h"
#import "syncCalories.h"
#import "CalsHomeViewController.h"
#import "RoutePlannerViewController.h"
#import "PedometerViewController.h"
#import "TKAlertCenter.h"
#import "WalkForHealthViewController.h"
#import "SearchLocationCustomCellView.h"
#import "LearnMoreFirstViewController.h"

#import "NSString+URLEncoding.h"

#define FOOD_IMG_SHORT @"_hr_cal_btn_food_" 
#define IMAGEURL @"http://www.healthreach.hk/foodlist/image/" 

#define AUTO_COMPLETE_BASEURL @"https://maps.googleapis.com/maps/api/place/autocomplete/xml?key=AIzaSyCGzVBRG27cCkkLOkYMOKXrijMkRzyxUCI&sensor=false&components=country:hk"
#define PLACE_DETAIL_BASEURL @"https://maps.googleapis.com/maps/api/place/details/xml?key=AIzaSyCGzVBRG27cCkkLOkYMOKXrijMkRzyxUCI"
#define PLACE_SEARCH_BASEURL @"https://maps.googleapis.com/maps/api/place/textsearch/xml?key=AIzaSyCGzVBRG27cCkkLOkYMOKXrijMkRzyxUCI"

#import "HJMOFileCache.h"

@interface CalsViewController ()

@property (strong, nonatomic) NSString *breakfastImageOn;
@property (strong, nonatomic) NSString *lunchImageOn;
@property (strong, nonatomic) NSString *dinnerImageOn;
@property (strong, nonatomic) NSString *teaImageOn;
@property (strong, nonatomic) NSString *seasonalImageOn;
@property (strong, nonatomic) NSString *breakfastImageOff;
@property (strong, nonatomic) NSString *lunchImageOff;
@property (strong, nonatomic) NSString *dinnerImageOff;
@property (strong, nonatomic) NSString *teaImageOff;
@property (strong, nonatomic) NSString *seasonalImageOff;

@property (strong, nonatomic) NSString *currentCategory;
@property (strong, nonatomic) NSArray *searchResultList;
@end

@implementation CalsViewController

@synthesize dataList;
@synthesize totalCaloriesLabel;
@synthesize imgMan;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"CalsViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"CalsViewController_iphone4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.caloriesTable setTag:0];
    [self.searchResultTable setTag:1];
    
    [self setFoodCategoryImageFilename];
    [self reloadViewText];
    self.dataList = [DBHelper getAllFoodRecord:@"Seasonal"];
    self.currentCategory = @"Seasonal";
    // (ONLY)Will have an effect on jumpping from EXPORT function from food record detail page
    [self reloadTotalCaloiresLabel];
    
    // Listener for changing the food quantity.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRefreshCaloriesTotal:) name:@"refreshCaloriesTotal" object:nil];
    
    
    
    //no loginid and sessionid
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nologinid:) name:@"nologinid" object:nil];
    
    
    
    // Initiate async picture download
    self.imgMan = [[HJObjManager alloc]init];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/foodImages/"] ;
	HJMOFileCache* fileCache = [[HJMOFileCache alloc] initWithRootPath:cacheDirectory];
	self.imgMan.fileCache = fileCache;
    
    // hide two subviews(Calories Burner/Planning Route)
    self.caloriesBurnerView.hidden = YES;
    self.planningRouteView.hidden = YES;
    self.searchLocationView.hidden = YES;

    [self.activityIndicator startAnimating];
    [self.indicatorView setHidden:YES];
}

// Always clean all the data when leaving this page(despite of which way the user leaves).
// The saving opertaion is in "- (IBAction)nextButtonDown:(id)sender" method
-(void)viewWillDisappear:(BOOL)animated
{
    [GlobalVariables shareInstance].caloriesTotal = @"";
    [DBHelper resetFoodListTable];
    NSThread *uploadThread = [[NSThread alloc]initWithTarget:self selector:@selector(uploadUnloadData) object:nil];
    [uploadThread start];

}

- (void)uploadUnloadData
{
    NSMutableArray *uploadFoodNotUploadArray = [DBHelper getFoodNotUpload];
    [syncCalories uploadFoodNotUpload:uploadFoodNotUploadArray];
}

#pragma mark -
#pragma mark View basic set up

// the food category image filename MUST be :
// {language_code}_hr_cal_btn_food_{category}_{on/off}.png
// Example : cn_hr_cal_btn_food_1_off.png || cn_hr_cal_btn_food_4_off.png
- (void)setFoodCategoryImageFilename
{
    self.breakfastImageOn = [NSString stringWithFormat:@"%@%@1_on.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.breakfastImageOff = [NSString stringWithFormat:@"%@%@1_off.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.lunchImageOn = [NSString stringWithFormat:@"%@%@2_on.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.lunchImageOff = [NSString stringWithFormat:@"%@%@2_off.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.dinnerImageOn = [NSString stringWithFormat:@"%@%@3_on.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.dinnerImageOff = [NSString stringWithFormat:@"%@%@3_off.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.teaImageOn = [NSString stringWithFormat:@"%@%@4_on.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.teaImageOff = [NSString stringWithFormat:@"%@%@4_off.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.seasonalImageOn = [NSString stringWithFormat:@"%@%@5_on.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
    self.seasonalImageOff = [NSString stringWithFormat:@"%@%@5_off.png",[Utility getLanguageCode],FOOD_IMG_SHORT];
}

- (void)reloadViewText
{
    [self.breakfastButton setBackgroundImage:[UIImage imageNamed:self.breakfastImageOff] forState:UIControlStateNormal];
    [self.lunchButton setBackgroundImage:[UIImage imageNamed:self.lunchImageOff] forState:UIControlStateNormal];
    [self.teaButton setBackgroundImage:[UIImage imageNamed:self.teaImageOff] forState:UIControlStateNormal];
    [self.dinnerButton setBackgroundImage:[UIImage imageNamed:self.dinnerImageOff] forState:UIControlStateNormal];
    [self.festiveButton setBackgroundImage:[UIImage imageNamed:self.seasonalImageOn] forState:UIControlStateNormal];
    
    [_calsLabel setText:[Utility getStringByKey:@"home_title_cals"]];
    [_calsLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [_totalCaloriesLabel1 setText:[Utility getStringByKey:@"total_calories"]];
    [_totalCaloriesLabel1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:17]];

    [_totalCaloriesLabel2 setText:[Utility getStringByKey:@"cal_unit"]];
    [_totalCaloriesLabel2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:12]];
    
    [self.totalCaloriesLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:23]];
    
    [_nextButton.titleLabel setText:[Utility getStringByKey:@"save"]];
    [_nextButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:17]];
    
    [_indicationLabel setText:[Utility getStringByKey:@"indication_only"]];
    [_indicationLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:13]];
    
    [_useCurrentLocationButton.titleLabel setText:[Utility getStringByKey:@"use_current_location"]];
    [_useCurrentLocationButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_inputLocationButoon.titleLabel setText:[Utility getStringByKey:@"input_location"]];
    [_inputLocationButoon.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_backButton_PlanningRoute.titleLabel setText:[Utility getStringByKey:@"back"]];
    [_backButton_PlanningRoute.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_planningRouteLabel setText:[Utility getStringByKey:@"planning_route"]];
    
    [_useCurrentLocationButton setTitle:[Utility getStringByKey:@"use_current_location"] forState:UIControlStateNormal];
    [_inputLocationButoon setTitle:[Utility getStringByKey:@"input_location"] forState:UIControlStateNormal];
    [_inputLocationButoon setTitle:[Utility getStringByKey:@"input_location"] forState:0];
    
    [_backButton_PlanningRoute setTitle:[Utility getStringByKey:@"back"] forState:UIControlStateNormal];
    
    [_caloriesBurnerLabel setText:[Utility getStringByKey:@"calorie_burner"]];
    
    [_toBurnLabel setText:[Utility getStringByKey:@"to_burn"]];
    
    [_calLabel setText:[Utility getStringByKey:@"total_calories_cal"]];
    
    [_youCanWalkLabel setText:[Utility getStringByKey:@"you_can_walk"]];
    
    [_stepsLabel setText:[Utility getStringByKey:@"steps"]];
    
    [_minLabel setText:[Utility getStringByKey:@"min"]];
    
    [_kmLabel setText:[Utility getStringByKey:@"km"]];
    
    
    [_toPlanrouteButton setTitle:[Utility getStringByKey:@"plan_route"] forState:UIControlStateNormal];
    [_toPlanrouteButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_toStartWalkingButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_toStartWalkingButton setTitle:[Utility getStringByKey:@"start_walking"] forState:UIControlStateNormal];

    [_backButton_CaloriesBurner setTitle:[Utility getStringByKey:@"back"] forState:UIControlStateNormal];
    [_backButton_CaloriesBurner.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_nextButton setTitle:[Utility getStringByKey:@"save"] forState:UIControlStateNormal];
}

// The category image should be refreshed everytime when the user change the category.
- (IBAction)breakfastButtonDown:(id)sender {
    self.dataList = [DBHelper getAllFoodRecord:@"Breakfast"];
    self.currentCategory = @"Breakfast";
    [self.caloriesTable reloadData];
    [self.breakfastButton setBackgroundImage:[UIImage imageNamed:self.breakfastImageOn] forState:UIControlStateNormal];
    [self.lunchButton setBackgroundImage:[UIImage imageNamed:self.lunchImageOff] forState:UIControlStateNormal];
    [self.teaButton setBackgroundImage:[UIImage imageNamed:self.teaImageOff] forState:UIControlStateNormal];
    [self.dinnerButton setBackgroundImage:[UIImage imageNamed:self.dinnerImageOff] forState:UIControlStateNormal];
    [self.festiveButton setBackgroundImage:[UIImage imageNamed:self.seasonalImageOff] forState:UIControlStateNormal];
}

- (IBAction)lunchButtonDown:(id)sender {
    self.dataList = [DBHelper getAllFoodRecord:@"Lunch"];
    self.currentCategory = @"Lunch";
    [self.caloriesTable reloadData];
    [self.breakfastButton setBackgroundImage:[UIImage imageNamed:self.breakfastImageOff] forState:UIControlStateNormal];
    [self.lunchButton setBackgroundImage:[UIImage imageNamed:self.lunchImageOn] forState:UIControlStateNormal];
    [self.teaButton setBackgroundImage:[UIImage imageNamed:self.teaImageOff] forState:UIControlStateNormal];
    [self.dinnerButton setBackgroundImage:[UIImage imageNamed:self.dinnerImageOff] forState:UIControlStateNormal];
    [self.festiveButton setBackgroundImage:[UIImage imageNamed:self.seasonalImageOff] forState:UIControlStateNormal];
}

- (IBAction)teaButtonDown:(id)sender {
    self.dataList = [DBHelper getAllFoodRecord:@"Dinner"];
    self.currentCategory = @"Dinner";
    [self.caloriesTable reloadData];
    [self.breakfastButton setBackgroundImage:[UIImage imageNamed:self.breakfastImageOff] forState:UIControlStateNormal];
    [self.lunchButton setBackgroundImage:[UIImage imageNamed:self.lunchImageOff] forState:UIControlStateNormal];
    [self.teaButton setBackgroundImage:[UIImage imageNamed:self.teaImageOn] forState:UIControlStateNormal];
    [self.dinnerButton setBackgroundImage:[UIImage imageNamed:self.dinnerImageOff] forState:UIControlStateNormal];
    [self.festiveButton setBackgroundImage:[UIImage imageNamed:self.seasonalImageOff] forState:UIControlStateNormal];
}

- (IBAction)dinnerButtonDown:(id)sender {
    self.dataList = [DBHelper getAllFoodRecord:@"Afternoon tea/ Snack"];
    self.currentCategory = @"Afternoon tea/ Snack";
    [self.caloriesTable reloadData];
    [self.breakfastButton setBackgroundImage:[UIImage imageNamed:self.breakfastImageOff] forState:UIControlStateNormal];
    [self.lunchButton setBackgroundImage:[UIImage imageNamed:self.lunchImageOff] forState:UIControlStateNormal];
    [self.teaButton setBackgroundImage:[UIImage imageNamed:self.teaImageOff] forState:UIControlStateNormal];
    [self.dinnerButton setBackgroundImage:[UIImage imageNamed:self.dinnerImageOn] forState:UIControlStateNormal];
    [self.festiveButton setBackgroundImage:[UIImage imageNamed:self.seasonalImageOff] forState:UIControlStateNormal];
}

- (IBAction)festiveButtonDown:(id)sender {
    self.dataList = [DBHelper getAllFoodRecord:@"Seasonal"];
    self.currentCategory = @"Seasonal";
    [self.caloriesTable reloadData];
    [self.breakfastButton setBackgroundImage:[UIImage imageNamed:self.breakfastImageOff] forState:UIControlStateNormal];
    [self.lunchButton setBackgroundImage:[UIImage imageNamed:self.lunchImageOff] forState:UIControlStateNormal];
    [self.teaButton setBackgroundImage:[UIImage imageNamed:self.teaImageOff] forState:UIControlStateNormal];
    [self.dinnerButton setBackgroundImage:[UIImage imageNamed:self.dinnerImageOff] forState:UIControlStateNormal];
    [self.festiveButton setBackgroundImage:[UIImage imageNamed:self.seasonalImageOn] forState:UIControlStateNormal];
}

- (IBAction)backButtonDown:(id)sender {
    CalsHomeViewController *calsHomeView = [[CalsHomeViewController alloc]initWithNibName:@"CalsHomeViewController" bundle:nil];
    [self.navigationController pushViewController:calsHomeView animated:YES];
}

#pragma mark -
#pragma mark Refresh total calories

// Refresh total calories label when received food quantity change , two situation triggers it
// 1. food quantity changed.
// 2. jumpping from food detail view
-(void)notificationRefreshCaloriesTotal:(NSNotification *)notification
{
    
    NSLog(@"notificationRefreshCaloriesTotal");
    self.dataList = [DBHelper getAllFoodRecord:self.currentCategory];
    [self.caloriesTable reloadData];
    [self reloadTotalCaloiresLabel];
}



-(void)nologinid:(NSNotification *)notification{
    LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
    [historyView setType:@"food"];
    [self.navigationController pushViewController:historyView animated:YES ];
}





-(void)reloadTotalCaloiresLabel {
    self.totalCaloriesLabel.text = [NSString stringWithFormat:@"%d",[[GlobalVariables shareInstance].caloriesTotal intValue]];
}

#pragma mark -
#pragma mark All food table set up

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = 0;
    switch (tableView.tag) {
        case 0:
            count = [self.dataList count];
            break;
            
        case 1:
            count = [self.searchResultList count];
            break;
        default:
            break;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 0:
            return 71.0f;
            break;
            
        case 1:
            return 44.0f;
        default:
            break;
    }
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 0: {
            UINib *nib = [UINib nibWithNibName:@"CaloriesCustomCell" bundle:nil];
            static NSString *calsCustomCellIdentifier = @"CalsCustomCellIdentifier";
            [tableView registerNib:nib forCellReuseIdentifier:calsCustomCellIdentifier];
            
            CaloriesCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:calsCustomCellIdentifier];
            
            NSUInteger row = [indexPath row];
            if (row < [self.dataList count])
            {
                FoodEntry *rowData = [self.dataList objectAtIndex:row];
                
                if ([[Utility getLanguageCode]isEqualToString:@"en"]){
                    cell.foodNameString = [rowData getName_en];
                    cell.foodUnitString = [rowData getQuantityUnit_en];
                } else {
                    cell.foodNameString = [rowData getName_zh];
                    cell.foodUnitString = [rowData getQuantityUnit_zh];
                }
                
                cell.foodIdNumber = [rowData getNumber];
                cell.foodQuantityString = [NSString stringWithFormat:@"%d",[[rowData getQuantity]intValue]];
                cell.foodCaloriesString = [NSString stringWithFormat:@"%d",[[rowData getFoodCalories]intValue]];
                
                cell.foodImageView.image = [UIImage imageNamed:@""];
                // Easy way to use HJCache asyncing the food images.
                cell.foodImageView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[rowData getFoodImageFileName]]];
                [self.imgMan manage:cell.foodImageView];
            }
            
            return cell;
        }
        case 1:{
            static NSString *customCellIdentifier = @"SearchLocationCustomCellViewIdentifier";
            
            UINib *nib = [UINib nibWithNibName:@"SearchLocationCustomCellView" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:customCellIdentifier];
            
            SearchLocationCustomCellView *cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
            NSUInteger row = [indexPath row];
            if (row<[self.searchResultList count]) {
                NSDictionary *eachEntry = [self.searchResultList objectAtIndex:row];
                cell.contentString = [eachEntry objectForKey:@"description"];
                cell.referenceString = [eachEntry objectForKey:@"reference"];
            }
            return cell;
        }
        default:
            break;
    }

    return nil;
}

#pragma mark -
#pragma mark Calorie burner subview

- (IBAction)nextButtonDown:(id)sender {
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
        [historyView setType:@"food"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        NSArray *foodRecordsArray = [DBHelper getFoodRecordsModified];
        if ([foodRecordsArray count]>0){
            // Saving food table to DB
            [syncCalories saveCaloriesData:foodRecordsArray];
            
            // popup Calorie Burner subview
            self.caloriesBurnerView.hidden = NO;
            self.totalCalories_CaloriesBurner.text = [GlobalVariables shareInstance].caloriesTotal;
            [self calculatorCals:[[GlobalVariables shareInstance].caloriesTotal intValue] pace:90];
            self.paceLabel_CaloriesBurner.text = @"90";
        } else {
            // pop an alert when no food is chosen
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"please_choose_food"]];
        }

    }
    
    
    
    
}

// Calculate & refresh the time/distance column in Calroie Burner subview
- (void)calculatorCals:(float)chosedFoodCals pace:(int)paceValue
{
    
    
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
    
    
    float weight=[[Utility getWeight] floatValue]/2.2f;//get weight,unit is kg;
    float height=[[Utility getHeight] floatValue];//get height,unit is cm;
    float age=year-[[Utility getBirth] integerValue];//get age;
    //float duration=milliSecs/1000/60;
    // float speed=mDistanceValue/duration;
    
    BOOL isMale=[[Utility getGender] isEqualToString:@"M"];
    
    float bmr=0;
    
    if(isMale){
        
        bmr=(float) (((13.75*weight)+(5*height)-(6.76*age)+66)/24);
        
    }else{
        
        bmr=(float) (((9.56*weight)+(1.85*height)-(4.68*age)+655)/24);
    }
    
    //float step_len=height*(isMale?0.413:0.415);
    
    
    float speed=(float) (paceValue*0.414*height/100);
    float vo2=(float) (0.1*speed+3.5);
    float met=(float) (vo2/3.5);
    
    double time=(chosedFoodCals/bmr/met)*60;
    
    int totalTime=(int) (time*60);
    int min=totalTime/60;
    int sec=totalTime-60*min;
    
    double distance=time*speed/1000;
    
    //set up time value
    NSString *timeString = @"";
    if (min > 0) {
        timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%d'",min]];
    }
    if (sec > 0) {
        timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%d\"",sec]];
    }
    
    //set up distance value
    NSString *distanceString = [NSString stringWithFormat:@"%.2f",distance];
    
    self.timeLabel_CaloriesBurner.text = timeString;
    self.distanceLabel_CaloriesBurner.text = distanceString;
}

- (IBAction)paceMinusButtonDown:(id)sender {
    int paceValue = [[self.paceLabel_CaloriesBurner text]intValue];
    if (paceValue > 60) {
        
        paceValue = paceValue - 10;
        self.paceLabel_CaloriesBurner.text = [NSString stringWithFormat:@"%d",paceValue];
        
        [self calculatorCals:[[GlobalVariables shareInstance].caloriesTotal intValue] pace:paceValue];
    }
}

- (IBAction)pacePlusButtonDown:(id)sender {
    int paceValue = [[self.paceLabel_CaloriesBurner text]intValue];
    if (paceValue < 150){
        paceValue = paceValue+10;
        self.paceLabel_CaloriesBurner.text = [NSString stringWithFormat:@"%d",paceValue];
        
        [self calculatorCals:[[GlobalVariables shareInstance].caloriesTotal intValue] pace:paceValue];
    }
}

// popup plan route subview
- (IBAction)PlanRouteButton_CaloriesBurner:(id)sender {
    self.caloriesBurnerView.hidden = YES;
    self.planningRouteView.hidden = NO;
}

- (IBAction)BackButton_CaloriesBurner:(id)sender {
    CalsHomeViewController *calsHomeView = [[CalsHomeViewController alloc]initWithNibName:@"CalsHomeViewController" bundle:nil];
    [self.navigationController pushViewController:calsHomeView animated:YES];
}

- (IBAction)StartWalkingButton_CaloriesBurner:(id)sender {
    //    PedometerViewController *pedometerView = [[PedometerViewController alloc]initWithNibName:@"PedometerViewController" bundle:nil];
    //    [self.navigationController pushViewController:pedometerView animated:YES];
    
    int paceValue = [[self.paceLabel_CaloriesBurner text]intValue];
    
    WalkForHealthViewController *rpView = [[WalkForHealthViewController alloc] initWithNibName:@"WalkForHealthViewController" bundle:nil];
    [rpView setPaceSetValue:paceValue];
    [rpView setTargetSetValue:[GlobalVariables shareInstance].caloriesTotal];
    [self.navigationController pushViewController:rpView animated:YES ];
    
    
    
    
}

#pragma mark -
#pragma mark Plan route subview

- (IBAction)BackButton_PlanningRoute:(id)sender {
    self.planningRouteView.hidden = YES;
    self.caloriesBurnerView.hidden = NO;
}

- (IBAction)UseCurrentLocationButton_PlanningRoute:(id)sender {
    int paceValue = [[self.paceLabel_CaloriesBurner text]intValue];
    
    RoutePlannerViewController *routePlannerView = [[RoutePlannerViewController alloc]initWithNibName:@"RoutePlannerViewController" bundle:nil];
    [routePlannerView setTargetCal:[GlobalVariables shareInstance].caloriesTotal];
    [routePlannerView setPaceValueFromfood:paceValue];
    [self.navigationController pushViewController:routePlannerView animated:YES];
}

#pragma mark -
#pragma mark Input location subview

- (IBAction)inputLocationButtonDown:(id)sender {
    [self.searchLocationView setHidden:FALSE];
    [self.searchResultTable setHidden:TRUE];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *autoComplete_queryString = @"";
    if ([searchText length]>=4){
        autoComplete_queryString = [AUTO_COMPLETE_BASEURL stringByAppendingString:[NSString stringWithFormat:@"&input=%@",searchText]];
        autoComplete_queryString = [autoComplete_queryString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *requestURL = [[NSURL alloc]initWithString:autoComplete_queryString];
        NSMutableURLRequest *autoCompleteRequest = [NSMutableURLRequest requestWithURL:requestURL];
        [autoCompleteRequest setHTTPMethod:@"POST"];
        [autoCompleteRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        NSData *requestData = [NSData dataWithBytes:[[autoComplete_queryString encodedURLString]UTF8String]
                                             length:[[autoComplete_queryString encodedURLString]length]];
        [autoCompleteRequest setHTTPBody:requestData];
        [NSURLConnection sendAsynchronousRequest:autoCompleteRequest
                                           queue:[[NSOperationQueue alloc]init]
                               completionHandler:^(NSURLResponse *response, NSData *xmlData, NSError *error) {
                                   if (xmlData != nil && error == nil)
                                   {
                                       self.searchResultList = [self extractDescriptionName:xmlData];
                                       NSLog(@"Auto complete query result:%@",self.searchResultList);
                                       if ([self.searchResultList count]>0)
                                           [self performSelectorOnMainThread:@selector(tableReloadData) withObject:nil waitUntilDone:NO];
                                   }
                                   else
                                   {
                                       NSLog(@"Auto complete query error:%@",error);
                                   }
                                   
                               }];
//        NSURL *requestURL = [[NSURL alloc]initWithString:autoComplete_queryString];
//        NSData *xmlData = [NSData dataWithContentsOfURL:requestURL];
//        NSLog(@"requestURL:%@",requestURL);
        //        NSMutableURLRequest *autoCompleteRequest = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        //        [autoCompleteRequest setHTTPMethod:@"GET"];
        //        [autoCompleteRequest addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        //        NSHTTPURLResponse *urlResponse = nil;
        //        NSError *error = [[NSError alloc] init];
        //        NSData *xmlData = [NSURLConnection sendSynchronousRequest:autoCompleteRequest returningResponse:&urlResponse error:&error];
      
//        self.searchResultList = [self extractDescriptionName:xmlData];
        NSLog(@"!!searchResultList:%@",self.searchResultList);
        if ([self.searchResultList count]>0)
            [self performSelectorOnMainThread:@selector(tableReloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void)tableReloadData
{
    [self.searchResultTable reloadData];
    [self.searchResultTable setHidden:false];
}

- (NSArray *)extractDescriptionName:(NSData *)xmlData
{
    NSString *predictionFlag = @"//prediction";
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    NSArray *predictionArray = [doc nodesForXPath:predictionFlag error:nil];
    NSLog(@"!!predictionArray:%@",predictionArray);
    NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    for (DDXMLElement *obj in predictionArray) {
        DDXMLElement *descriptionElement = [obj elementForName:@"description"];
        DDXMLElement *referenceElement = [obj elementForName:@"reference"];
        NSDictionary *eachEntry = [[NSDictionary alloc]initWithObjectsAndKeys:
                                   [descriptionElement stringValue], @"description",
                                   [referenceElement stringValue], @"reference", nil];
        [returnArray addObject:eachEntry];
    }

    return returnArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchLocationCustomCellView *cell = (SearchLocationCustomCellView *)[tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *locationDict = [self getLocationByReference:cell.referenceString];
    if ([locationDict count]>0) {
        int paceValue = [[self.paceLabel_CaloriesBurner text]intValue];
        
        RoutePlannerViewController *routePlannerView = [[RoutePlannerViewController alloc]initWithNibName:@"RoutePlannerViewController" bundle:nil];
        [routePlannerView setTargetCal:[GlobalVariables shareInstance].caloriesTotal];
        [routePlannerView setLat:[[locationDict objectForKey:@"latitute"]floatValue]];
        [routePlannerView setLon:[[locationDict objectForKey:@"longitude"]floatValue]];
        [routePlannerView setPaceValueFromfood:paceValue];
        [self.navigationController pushViewController:routePlannerView animated:YES];
    } else
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"network_unavailable"]];
}

- (NSDictionary *)getLocationByReference:(NSString *)referenceString
{
    NSString *locationDetail_queryString = [PLACE_DETAIL_BASEURL stringByAppendingString:[NSString stringWithFormat:@"&reference=%@",referenceString]];
    
    NSURL *requestURL = [NSURL URLWithString:locationDetail_queryString];
    NSData *xmlData = [NSData dataWithContentsOfURL:requestURL];
    
    NSString *locationFlag = @"//location";
    DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    NSArray *locationArray = [doc nodesForXPath:locationFlag error:nil];
    NSLog(@"!!locationArray:%@",locationArray);
    NSDictionary *returnDict = [[NSDictionary alloc]init];

    for (DDXMLElement *obj in locationArray) {
//        if ([[[obj elementForName:@"status"]stringValue]isEqualToString:@"OK"])
//            status = 1;
//        else
//            status = 0;
        DDXMLElement *latituteElement = [obj elementForName:@"lat"];
        DDXMLElement *longitudeElement = [obj elementForName:@"lng"];
        returnDict = [[NSDictionary alloc]initWithObjectsAndKeys:[latituteElement stringValue],@"latitute",[longitudeElement stringValue],@"longitude", nil];
        NSLog(@"location returnDict:%@",returnDict);
    }


    return returnDict;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.indicatorView setHidden:FALSE];
    
    
    NSString *placeSearch_queryString = [PLACE_SEARCH_BASEURL stringByAppendingString:[NSString stringWithFormat:@"&query=%@",self.searchBar.text]];
    placeSearch_queryString = [placeSearch_queryString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *requestURL = [[NSURL alloc]initWithString:placeSearch_queryString];
    
//    NSLog(@"!!placeSearch_queryString:%@",placeSearch_queryString);
//    NSURL *requestURL = [NSURL URLWithString:placeSearch_queryString];
    NSData *xmlData = [NSData dataWithContentsOfURL:requestURL];
    
//    NSMutableURLRequest *placeSearchRequest = [NSMutableURLRequest requestWithURL:requestURL];
//    [placeSearchRequest setHTTPMethod:@"POST"];
//    [placeSearchRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    NSData *xmlData = [NSData dataWithBytes:[[placeSearch_queryString encodedURLString]UTF8String]
//                                         length:[[placeSearch_queryString encodedURLString]length]];
//    [placeSearchRequest setHTTPBody:xmlData];
//    //        NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
//    [NSURLConnection sendAsynchronousRequest:placeSearchRequest
//     //                                           queue:[NSOperationQueue currentQueue]
//                                       queue:[[NSOperationQueue alloc]init]
//                           completionHandler:^(NSURLResponse *response, NSData *xmlData, NSError *error) {
//                               if (xmlData != nil && error == nil)
//                               {
//                                   self.searchResultList = [self extractDescriptionName:xmlData];
//                                   NSLog(@"Auto complete query result:%@",self.searchResultList);
//                               }
//                               else
//                               {
//                                   NSLog(@"Auto complete query error:%@",error);
//                               }
//                               
//                           }];
//    
    NSString *placeSearchResponseFlag = @"//PlaceSearchResponse";
    NSString *resultFlag = @"//result";
    NSString *referenceString = @"";
    
    DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    NSArray *responseArray = [doc nodesForXPath:placeSearchResponseFlag error:nil];
    int status = 0;
    for (DDXMLElement *obj in responseArray){

        NSArray *resultArray = [obj nodesForXPath:resultFlag error:nil];
        if ([[[obj elementForName:@"status"]stringValue]isEqualToString:@"OK"])
            status = 1;
        else
            status = 0;

        for (DDXMLElement *eachResult in resultArray){
            DDXMLElement *referenceElement = [eachResult elementForName:@"reference"];
            referenceString = [referenceElement stringValue];
            NSLog(@"referenceString:%@",referenceString);
            if ([referenceString length]>0) break;
        }
    }
    if (status==1) {
        NSDictionary *locationDict = [self getLocationByReference:referenceString];
        NSLog(@"locationDict:%@",locationDict);
        int paceValue = [[self.paceLabel_CaloriesBurner text]intValue];
        RoutePlannerViewController *routePlannerView = [[RoutePlannerViewController alloc]initWithNibName:@"RoutePlannerViewController" bundle:nil];
        [routePlannerView setTargetCal:[GlobalVariables shareInstance].caloriesTotal];
        [routePlannerView setLat:[[locationDict objectForKey:@"latitute"]floatValue]];
        [routePlannerView setLon:[[locationDict objectForKey:@"longitude"]floatValue]];
        NSLog(@"lat:%f,lng:%f",[[locationDict objectForKey:@"latitute"]floatValue],[[locationDict objectForKey:@"longitude"]floatValue]);
        [routePlannerView setPaceValueFromfood:paceValue];
        [self.navigationController pushViewController:routePlannerView animated:YES];

    } else {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"network_unavailable"]];
        [self.indicatorView setHidden:TRUE];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.searchLocationView setHidden:TRUE];
    [self.searchBar resignFirstResponder];
}

@end
