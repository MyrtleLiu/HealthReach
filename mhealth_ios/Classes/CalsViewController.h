//
//  CalsViewController.h
//  mHealth
//
//  Created by evanli on 16/7/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HJObjManager.h"

@interface CalsViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource> {
    HJObjManager *imgMan;
}

@property (strong, nonatomic) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UITableView *caloriesTable;

@property (weak, nonatomic) IBOutlet UILabel *calsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCaloriesLabel1;
@property (weak, nonatomic) IBOutlet UILabel *totalCaloriesLabel2;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *indicationLabel;

@property (weak, nonatomic) IBOutlet UIButton *festiveButton;
@property (weak, nonatomic) IBOutlet UIButton *breakfastButton;
@property (weak, nonatomic) IBOutlet UIButton *lunchButton;
@property (weak, nonatomic) IBOutlet UIButton *dinnerButton;
@property (weak, nonatomic) IBOutlet UIButton *teaButton;

@property (retain, nonatomic) HJObjManager *imgMan;

@property (weak, nonatomic) IBOutlet UIView *caloriesBurnerView;
@property (weak, nonatomic) IBOutlet UILabel *toBurnLabel;
@property (weak, nonatomic) IBOutlet UILabel *calLabel;
@property (weak, nonatomic) IBOutlet UILabel *youCanWalkLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalCalories_CaloriesBurner;
@property (weak, nonatomic) IBOutlet UILabel *paceLabel_CaloriesBurner;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel_CaloriesBurner;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel_CaloriesBurner;
@property (weak, nonatomic) IBOutlet UILabel *caloriesBurnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *kmLabel;
@property (weak, nonatomic) IBOutlet UIButton *toPlanrouteButton;
@property (weak, nonatomic) IBOutlet UIButton *toStartWalkingButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton_CaloriesBurner;

@property (weak, nonatomic) IBOutlet UIView *planningRouteView;
@property (weak, nonatomic) IBOutlet UILabel *planningRouteLabel;
@property (weak, nonatomic) IBOutlet UIButton *useCurrentLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *inputLocationButoon;
@property (weak, nonatomic) IBOutlet UIButton *backButton_PlanningRoute;

@property (weak, nonatomic) IBOutlet UIView *searchLocationView;
@property (weak, nonatomic) IBOutlet UITableView *searchResultTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorBackGround;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
