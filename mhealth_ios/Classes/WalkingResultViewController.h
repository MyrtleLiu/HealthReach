//
//  WalkingResultViewController.h
//  mHealth
//
//  Created by sngz on 14-1-29.
//
//

#import <GoogleMaps/GoogleMaps.h>
#import <UIKit/UIKit.h>
#import "WalkingRecord.h"
#import "BaseViewController.h"
#import "SyncWalking.h"
@interface WalkingResultViewController : BaseViewController<UIScrollViewDelegate,UITextFieldDelegate>{
    
    WalkingRecord *result;
    UIImage *theBigTreeImage;
    IBOutlet UIButton *shareButton;
  IBOutlet  UIScrollView * scrollView;
    IBOutlet UIImageView * _imageview;
  IBOutlet UIView *  congratulationsView;
    IBOutlet UIView * chickTreeView;
    IBOutlet UITextField *plantNametextField;
    IBOutlet UILabel *whatTheTree;
    IBOutlet UIImageView* smarttreeImageView;
    IBOutlet UILabel *littleTextTextFont;
    
    IBOutlet UIImageView *bigTreeImageView;
    IBOutlet UILabel *thePlantName;
    IBOutlet UILabel *congratulationsLabelTextFont;
    IBOutlet UILabel *congratulationsLittleTextFont;
    IBOutlet UIButton *visit;
    NSString *lemonTreeImageStr0;
    NSString *treeImageStr;
    NSString *lemonTreeImageStr1;
    NSString *lemonTreeImageStr2;
    NSString *lemonTreeImageStr3;
    NSString *lemonTreeImageStr4;
    NSString *lemonTreeImageStr5;
    NSString *lemonTreeImageStr6;
    NSString *lemonTreeImageStr7;
    NSString *orangeTreeImageStr0;
    NSString *orangeTreeImageStr1;
    NSString *orangeTreeImageStr2;
    NSString *orangeTreeImageStr3;
    NSString *orangeTreeImageStr4;
    NSString *orangeTreeImageStr5;
    NSString *orangeTreeImageStr6;
    NSString *orangeTreeImageStr7;
    NSString *tomatoTreeImageStr0;
    NSString *tomatoTreeImageStr1;
    NSString *tomatoTreeImageStr2;
    NSString *tomatoTreeImageStr3;
    NSString *tomatoTreeImageStr4;
    NSString *tomatoTreeImageStr5;
    NSString *tomatoTreeImageStr6;
    NSString *tomatoTreeImageStr7;
    
    
    NSString *strTempTemp;
   IBOutlet UIView *isCCCView;
    IBOutlet UILabel * cas;
    
    
    
}
@property(nonatomic,strong)NSString *theADDRoadStr;
@property(nonatomic,strong)NSString *theShareStrRoad;

@property (nonatomic,strong) NSString *isCOK;
@property (strong, nonatomic) WalkingRecord *result;

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property (strong, nonatomic) IBOutlet UIView *trackBtnView;
@property (strong, nonatomic) IBOutlet UIView *statusView;
@property (strong, nonatomic) IBOutlet UIView *theMapView;


@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabel;
@property (strong, nonatomic) IBOutlet UILabel *calsLabel;
@property (strong, nonatomic) IBOutlet UILabel *paceLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;


@property (strong, nonatomic) IBOutlet UILabel *distanceLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *calsLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *paceLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelUnit;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelUnit2;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabelText;
@property (strong, nonatomic) IBOutlet UILabel *stepsLabelText;
@property (strong, nonatomic) IBOutlet UILabel *calsLabelText;
@property (strong, nonatomic) IBOutlet UILabel *paceLabelText;
@property (strong, nonatomic) IBOutlet UILabel *durationLabelText;
@property (strong, nonatomic) IBOutlet UILabel *speedLabelText;

@property (strong, nonatomic) IBOutlet UIButton *okBtn;

@property (strong, nonatomic) IBOutlet UILabel *titleText;

@property(nonatomic,strong)NSDictionary * dicCW;

@property(nonatomic,strong)NSDictionary * dicTP;

@property(nonatomic, strong) GMSPolyline *polyline;
@property(nonatomic, strong) GMSMutablePath *path;



-(IBAction)toBack:(id)sender;
-(IBAction)shuoming:(id)sender;
-(IBAction)toshareFaceBook:(id)sender;
-(IBAction)showMapView:(id)sender;

-(IBAction)showStatusView:(id)sender;

-(IBAction)tryleftTree:(id)sender;
-(IBAction)tryRightTree:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *calItemLayout;

@property (strong, nonatomic) IBOutlet UIView *targetViewLayout;
@property (strong, nonatomic) IBOutlet UIView *targetViewLayout_zh;

@property (strong, nonatomic) IBOutlet UILabel *targetCalValue;
@property (strong, nonatomic) IBOutlet UILabel *burnCalValue;
@property (strong, nonatomic) IBOutlet UILabel *targetCalValue_zh;
@property (strong, nonatomic) IBOutlet UILabel *burnCalValue_zh;


@property(nonatomic, strong) NSString *lastActivity;

@property(nonatomic) BOOL toastPopOnce;


@property (strong, nonatomic) IBOutlet UILabel *upload_succ;

@property(nonatomic, retain) IBOutlet UIButton *track_route_Btn;
@property(nonatomic,strong)NSString *chickTheCal;
@property (strong, nonatomic) IBOutlet UILabel *select_type_tx;


@end
