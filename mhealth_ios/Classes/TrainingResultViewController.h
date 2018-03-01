//
//  TrainingResultViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-8-27.
//
//


#import <GoogleMaps/GoogleMaps.h>
#import <UIKit/UIKit.h>
#import "WalkingRecord.h"
#import "BaseViewController.h"
#import "SyncWalking.h"
#import "WalkingRecord.h"
#import <GoogleMaps/GoogleMaps.h>
#import "TrainingRecord.h"
@interface TrainingResultViewController : BaseViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView * scrollView;
    IBOutlet UIImageView  * imageView;
    IBOutlet UIView * congratulationsView;
    IBOutlet UILabel *congratulationsLabelTextFont;
     IBOutlet UILabel *congratulationstitleTextFont;
    IBOutlet UIImageView *trophyImageView;
    NSString *strTempTemp;
    IBOutlet UIButton *shareButton;
}
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) WalkingRecord *record;
@property (nonatomic) NSInteger level;

@property (nonatomic) NSString *lastActivity;

@property(nonatomic,strong)NSDictionary * dicCW;

@property(nonatomic,strong)NSDictionary * dicTP;
@property (strong, nonatomic) IBOutlet UILabel *levelTitle;
@property (strong, nonatomic) IBOutlet UIImageView *levelImg;
@property (strong, nonatomic) IBOutlet UIImageView *levelBGImg;
@property (strong, nonatomic) IBOutlet UILabel *levelText;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabel;
@property (strong, nonatomic) IBOutlet UILabel *calsLabel;
@property (strong, nonatomic) IBOutlet UILabel *paceLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;

@property (strong, nonatomic) IBOutlet UILabel *upload_succ;
@property (nonatomic,strong) NSString * isUPDateNOW;
@property(nonatomic, retain) IBOutlet UIButton *track_route_Btn;



@property (strong, nonatomic) IBOutlet UILabel *speedLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelText;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelUnit2;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *calsLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *paceLabelUnit;


@property (strong, nonatomic) IBOutlet UILabel *distanceLabelText;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabelText;
@property (strong, nonatomic) IBOutlet UILabel *calsLabelText;
@property (strong, nonatomic) IBOutlet UILabel *paceLabelText;
@property (strong, nonatomic) IBOutlet UILabel *durationLabelText;

@property (strong, nonatomic) IBOutlet UIButton *okBtn;

@property (strong, nonatomic) IBOutlet UILabel *titleText;

@property (nonatomic,strong) NSString * theShareRoad;



-(IBAction)toshareFaceBook:(id)sender;



@property(nonatomic, strong) GMSPolyline *polyline;
@property(nonatomic, strong) GMSMutablePath *path;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property(nonatomic, strong) TrainingRecord *recordTTTT;

-(void)takeTheTPTime;

@property (strong, nonatomic) IBOutlet UIView *trackBtnView;
@property (strong, nonatomic) IBOutlet UIView *statusView;
@property (strong, nonatomic) IBOutlet UIView *theMapView;
@property (strong, nonatomic) IBOutlet UIView *dateView;


@end
