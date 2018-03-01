//
//  PedometerViewController.h
//  mHealth
//
//  Created by sngz on 14-1-27.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreMotion/CoreMotion.h>
#import "BaseViewController.h"
#import "Utility.h"
#import "SyncWalking.h"
#import "AFPickerView.h"
#import "NIDropDown.h"

#import <AVFoundation/AVFoundation.h>


@interface PedometerViewController : BaseViewController<AFPickerViewDataSource, AFPickerViewDelegate, GMSMapViewDelegate,AVAudioPlayerDelegate>




@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *statusView;


@property (strong, nonatomic) IBOutlet UIView *startView;
@property (strong, nonatomic) IBOutlet UIView *stopView;

@property (strong, nonatomic) IBOutlet UIView *showMapView;


@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceUnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepsTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepsUnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *calsLabel;
@property (strong, nonatomic) IBOutlet UILabel *calsTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *calsUnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *paceLabel;
@property (strong, nonatomic) IBOutlet UILabel *paceTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *paceUnitLabel;


@property (strong, nonatomic) IBOutlet UILabel *timeHourLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeMinuteLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeSecondLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeSplit1Label;
@property (strong, nonatomic) IBOutlet UILabel *timeSplit2Label;

@property (strong, nonatomic) IBOutlet UIButton *pause_resume_Btn;

@property (strong, nonatomic) IBOutlet UIButton *plan_route_Btn;
@property (strong, nonatomic) IBOutlet UIButton *start_Btn;
@property (strong, nonatomic) IBOutlet UIButton *stop_Btn;
@property (strong, nonatomic) IBOutlet UILabel *_min;

@property (strong, nonatomic) IBOutlet UILabel *actionTitle;

@property(nonatomic, strong) NSMutableArray *plannedRoutePoints;

@property (strong, nonatomic) NSTimer *clockTimer;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) double timePre;

@property(nonatomic, strong) CMMotionManager *motionManager;
@property (strong, nonatomic) NSTimer *stepTimer;
@property (nonatomic, assign) NSInteger stepsCount;
@property (nonatomic, assign) NSInteger beforeStepsCount;

@property (nonatomic, strong) CMPedometer *stepCounter;

@property(nonatomic, strong) NSMutableArray *trackPoints;
@property(nonatomic, strong) GMSPolyline *polyline;
@property(nonatomic, strong) GMSMutablePath *path;
@property (nonatomic, assign) float stepsDistance;
@property (nonatomic,strong)NSString * theADDRoadStr;
@property(nonatomic, strong) NSOperationQueue *operationQueue;

-(IBAction)openMusicApp:(id)sender;

-(IBAction)BackHome:(id)sender;

-(IBAction)toBack:(id)sender;

-(IBAction)toRoutePlanner:(id)sender;

-(IBAction)startWalking:(id)sender;

-(IBAction)stopWalking:(id)sender;

-(IBAction)pauseResumeWalking:(id)sender;

-(IBAction)showMapView:(id)sender;

-(IBAction)showStatusView:(id)sender;





@property (strong, nonatomic) IBOutlet UIView *chooseBirthView;
@property (strong, nonatomic) IBOutlet UIView *chooseBirthContentView;
@property (strong, nonatomic) AFPickerView *targetPicker;

@property (strong, nonatomic)  NSMutableArray *targetData;


@property (strong, nonatomic) NSString *targetTmpValue;





@property (strong, nonatomic) IBOutlet UILabel *divideTarget;
@property (strong, nonatomic) IBOutlet UILabel *targetValue;

@property (strong, nonatomic) IBOutlet UIButton *targetSetBtn;



- (void)goToBackground;

@property (strong, nonatomic) IBOutlet UILabel *speedLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelText;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelUnit2;

@property (strong, nonatomic) NSMutableArray *PaceData;
@property (strong, nonatomic) AFPickerView *pacePicker;
@property (strong, nonatomic) IBOutlet UIView *paceChooseView;
@property (strong, nonatomic) IBOutlet UIView *paceHoleView;

@property (strong, nonatomic) NSString *paceTempValue;
@property (strong, nonatomic) NSString *musicPath;

@property (strong, nonatomic) NSString * checkPlaying;

@property (strong, nonatomic) IBOutlet AVAudioPlayer *audioPlayer;



@property (strong, nonatomic) IBOutlet UILabel *calTargetTitle;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *doneBtn;

@property (strong, nonatomic) NSString *theLingTimeStr;

@property (strong, nonatomic) IBOutlet UIImageView *bottomTabView;


@property (nonatomic,strong) NSString * chickTheCal;
@property (nonatomic) int paceSetValue;
@property (strong, nonatomic) NSString *targetSetValue;


@property (strong, nonatomic) IBOutlet UIView *counterView;
@property (strong, nonatomic) IBOutlet UIImageView *counterImage;


@property (strong, nonatomic) IBOutlet UILabel *paceSetTex;

@property (strong, nonatomic) IBOutlet UISwitch *switchSound;

@property (strong, nonatomic) IBOutlet UIButton *soundBtn;
@property (strong, nonatomic) IBOutlet UIButton *musicBtn;
@property (strong, nonatomic) IBOutlet UIButton *paceBtn;


@property(nonatomic, retain) IBOutlet UISlider *slider;
@property(nonatomic, retain) IBOutlet UIView *sliderView;

@property(nonatomic, retain) IBOutlet UIButton *track_route_Btn;


@property(nonatomic,strong)NSString *themsg;

@property(nonatomic,strong)WalkingRecord *gobalWalkingRecord;
@property(nonatomic)BOOL gobalCheckC;
@property(nonatomic)long gobalduration;






@end
