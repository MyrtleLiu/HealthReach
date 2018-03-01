//
//  RoutePlannerViewController.h
//  mHealth
//
//  Created by sngz on 14-1-22.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "BaseViewController.h"

@interface RoutePlannerViewController : BaseViewController<GMSMapViewDelegate>


@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *calsLabel;

@property (strong, nonatomic) IBOutlet UIButton *returnRouteBtn;
@property (strong, nonatomic) IBOutlet UIButton *circulateRouteBtn;

@property (strong, nonatomic) IBOutlet UILabel *circulateLabel;
@property (strong, nonatomic) IBOutlet UIView *circulateView;
@property (strong, nonatomic) IBOutlet UIButton *circulateCloseBtn;
//@property (strong, nonatomic) IBOutlet UITableView *circulateList;

@property(nonatomic, strong) NSMutableArray *points;
@property(nonatomic, strong) NSArray *circulateItems;

-(IBAction)BackHome:(id)sender;
-(IBAction)toBack:(id)sender;
-(IBAction)undoRoute:(id)sender;
-(IBAction)saveRoute:(id)sender;
-(IBAction)returnRoute:(id)sender;
-(IBAction)circulateRoute:(id)sender;

- (void)setIsFromPedometer:(BOOL)theresult;

@property (strong, nonatomic) IBOutlet UILabel *actionbar;
@property (strong, nonatomic) IBOutlet UILabel *durationText;
@property (strong, nonatomic) IBOutlet UILabel *distanceText;
@property (strong, nonatomic) IBOutlet UILabel *km_unit;
@property (strong, nonatomic) IBOutlet UILabel *calText;
@property (strong, nonatomic) IBOutlet UILabel *cal_unit;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@property (strong, nonatomic) IBOutlet UILabel *tx1;


@property (strong, nonatomic) IBOutlet NSString *targetCal;
@property (strong, nonatomic) IBOutlet UILabel *foodText;
@property (strong, nonatomic) IBOutlet UILabel *foodburn;
@property (strong, nonatomic) IBOutlet UILabel *foodcal1;
@property (strong, nonatomic) IBOutlet UILabel *foodtarget;
@property (strong, nonatomic) IBOutlet UILabel *foodcal2;


@property (strong, nonatomic) IBOutlet UIView *plannerView;
@property (strong, nonatomic) IBOutlet UIView *foodView;

@property (nonatomic) int paceValueFromfood;

@property (nonatomic) float lat;
@property (nonatomic) float lon;


@property (strong, nonatomic) IBOutlet UIView *iphone4View;
@property (strong, nonatomic) IBOutlet UIImageView *iphone4ViewBg;



@end
