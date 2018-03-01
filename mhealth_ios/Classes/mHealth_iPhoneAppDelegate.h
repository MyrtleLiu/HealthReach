

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "FMDatabaseQueue.h"
#import "BaseNavigationController.h"

#import "PKRevealController.h"
#import <CoreLocation/CoreLocation.h>
#import "WalkForHealthViewController.h"
#import "DashBoardViewController.h"
#import "BPHistoryViewController.h"
#import "BGHistoryViewController.h"
#import "WeightHistoryViewController.h"

#import "BPRotateChartViewController.h"
#import "BGRotateChartViewController.h" 

#import "WeightRotateViewController.h"
#import <CoreMotion/CoreMotion.h>




@interface mHealth_iPhoneAppDelegate : NSObject<UIApplicationDelegate, UITabBarControllerDelegate,PKRevealing,UIAlertViewDelegate> {
    UIWindow *window;
    BaseNavigationController *navController;
    
    NSString *session_id;
    NSString *login_id;
    FMDatabaseQueue *dbQueue;
    
    PKRevealController *revealController;
    
    BOOL isShowNotification;
    
    BOOL isrunning;
    BOOL isHiddenWalkLoad;
    
    BOOL isHiddenDashBoardLoad;
    BOOL   isHiddenAverageBPLoad;
    BOOL isHiddenAverageBGLoad;
    BOOL isHiddenAverageWeightLoad;
    UIView *appForceView;
    UIImageView *imagehandImageView;
    UIImageView*healthReachImageView;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet BaseNavigationController *navController;
@property (nonatomic, retain) NSString *session_id;
@property (nonatomic, retain) NSString *login_id;
@property (strong, nonatomic) FMDatabaseQueue *dbQueue;

@property (nonatomic, strong, readwrite) PKRevealController *revealController;


@property(nonatomic,strong)NSMutableArray * timeBloodMutableArray;
@property(nonatomic,strong)NSMutableArray * timeECGMutableArray;
@property(nonatomic,strong)NSMutableArray * timeGlucoseMutableArray;
@property(nonatomic,strong)NSMutableArray * idBloodMutableArray;
@property(nonatomic,strong)NSMutableArray * idECGMutableArray;
@property(nonatomic,strong)NSMutableArray * idGlucoseMutableArray;

@property(nonatomic,strong)NSMutableArray * titleMedicationArray;
@property(nonatomic,strong)NSMutableArray * timesMedicationArray;
@property(nonatomic,strong)NSMutableArray * dosageMedicationArray;
@property(nonatomic,strong)NSMutableArray * medID;
@property(nonatomic,strong)NSMutableArray * mealMedicationArray;
@property(nonatomic,strong)NSMutableArray * reminderIDMedicationArray;

@property(nonatomic,strong)NSString *turnstrWarn;
@property(nonatomic,strong)NSMutableArray * titleAdhocArray;
@property(nonatomic,strong)NSMutableArray * startTimesArray;
@property(nonatomic,strong)NSMutableArray * endTimesArray;
@property(nonatomic,strong)NSMutableArray * adHocID;
@property(nonatomic,strong)NSMutableArray * adHoNote;
@property(nonatomic,strong)NSMutableArray * adDateDate;


@property(nonatomic,strong)NSString * walkStartDate;
@property(nonatomic,strong)NSString * walkEndDate;
@property(nonatomic,strong)NSMutableArray * timeWalkMustableArray;
@property(nonatomic,strong)NSMutableArray * idWalkinfMustableArray;


@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic,strong)WalkForHealthViewController *walkForHealthController;
@property(nonatomic,strong)DashBoardViewController *dashBoardController;
@property(nonatomic,strong)BPHistoryViewController *bpHistoryView;

@property(nonatomic,strong)BGHistoryViewController *bgHistoryView;




@property(nonatomic,strong)WeightHistoryViewController *weightHistoryView;


@property(nonatomic,strong)BPRotateChartViewController *bpRotateView;

@property(nonatomic,strong)BGRotateChartViewController *bgRotateView;

@property(nonatomic,strong)WeightRotateViewController *weightRotateView;







@property(nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) CMPedometer *stepCounter;
@property (nonatomic, assign) NSInteger beforeStepsCount;


























- (void)showHideMenu;
- (void)backToLogin;
- (void)backToHome;
- (BOOL)initDatabase:(NSString *)dbname;
- (void)setShowNotification:(BOOL)showNotification;
- (void)clearNotificationSetup;
- (void)hideRotateView;
- (void)showRotateView:(UIViewController *)theView;
- (BOOL)isLoginView;
- (void)setIsRunning:(BOOL)running;
- (BOOL)getIsRunning;



- (void)checkLocationService;


- (BOOL)getIsHiddenWalkLoad;
- (BOOL)getIsHiddenDashBoard;
-(BOOL)getIsHiddenAverageBPLoad;
-(BOOL)getIsHiddenAverageBGLoad;
-(BOOL)getIsHiddenAverageWeightLoad;


-(void)setIsHiddenWalkLoad;
-(void)setIsHiddenDashBoard;
-(void)setIsHiddenAverageBPLoad;
-(void)setIsHiddenAverageBGLoad;
-(void)setIsHiddenAverageWeightLoad;





- (void)setWalkForHealth:(WalkForHealthViewController*)walkForHealth;
- (WalkForHealthViewController*)getWalkForHealth;



- (void)setDashBoardView:(DashBoardViewController*)dashBoardView;
- (DashBoardViewController*)getDashBoardView;

- (void)setAverageBPView:(BPHistoryViewController*)bpHistoryView;
- (BPHistoryViewController*)getAverageBPView;




-(void)setAverageBGView:(BGHistoryViewController *)bgHistoryView;
-(BGHistoryViewController*)getAverageBGView;


- (void)setAverageWeightView:(WeightHistoryViewController*)weightHistoryView;
- (WeightHistoryViewController*)getAverageWeightView;





- (void)setRotateBPView:(BPRotateChartViewController*)bpRotateView;
- (BPRotateChartViewController*)getRotateBPView;



- (void)setRotateBGView:(BGRotateChartViewController*)bgRotateView;
- (BGRotateChartViewController*)getRotateBGView;



- (void)setRotateWeightView:(WeightRotateViewController*)weightRotateView;
- (WeightRotateViewController *)getRotateWeightView;




@end
