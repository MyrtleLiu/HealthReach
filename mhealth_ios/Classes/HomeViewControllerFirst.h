//
//  HomeViewController.h
//  mHealth
//
//  Created by sngz on 13-12-30.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomAlertView.h"

@interface HomeViewControllerFirst : BaseViewController<CustomAlertViewDelegate>{
//    UIButton *BPUIButton;
}

@property (nonatomic,retain) UIButton *BPUIButton;

@property(nonatomic, retain) IBOutlet UILabel *home_title_Dairy;
@property(nonatomic, retain) IBOutlet UILabel *home_title_BloodPressure;
@property(nonatomic, retain) IBOutlet UILabel *home_title_ECG;
@property(nonatomic, retain) IBOutlet UILabel *home_title_BloodGlucose;
@property(nonatomic, retain) IBOutlet UILabel *home_title_Weight;
@property(nonatomic, retain) IBOutlet UILabel *home_title_Walk;
@property(nonatomic, retain) IBOutlet UILabel *home_title_forHealth;
@property(nonatomic, retain) IBOutlet UILabel *home_title_Route;
@property(nonatomic, retain) IBOutlet UILabel *home_title_Planner;
@property(nonatomic, retain) IBOutlet UILabel *home_title_CaloriesReckoner;

@property(nonatomic, retain) IBOutlet UIImageView *bg_1;
@property(nonatomic, retain) IBOutlet UIImageView *bg_2;
@property(nonatomic, retain) IBOutlet UIImageView *bg_3;
@property(nonatomic, retain) IBOutlet UIImageView *bg_4;

@property(nonatomic, retain) IBOutlet UIImageView *login_logo;


-(IBAction)BPJump:(id)sender;
-(IBAction)toRoutePlanner:(id)sender;
-(IBAction)toWalkForHealth:(id)sender;
-(IBAction)toWeight:(id)sender;
-(IBAction)toDiary:(id)sender;
-(IBAction)toAllChar:(id)sender;
-(IBAction)toECG:(id)sender;

@property(nonatomic, retain) IBOutlet UIView *readViewAll;
@property(nonatomic, retain) IBOutlet UIView *readView1;
@property(nonatomic, retain) IBOutlet UIView *readView2;
@property(nonatomic, retain) IBOutlet UIView *readView3;
@property(nonatomic, retain) IBOutlet UILabel *readLabel1;
@property(nonatomic, retain) IBOutlet UILabel *readLabel2;
@property(nonatomic, retain) IBOutlet UILabel *readLabel3;






@end
