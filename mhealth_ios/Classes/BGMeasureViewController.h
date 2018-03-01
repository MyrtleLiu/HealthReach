//
//  BGMeasureViewController.h
//  mHealth
//
//  Created by sngz on 14-3-27.
//
//

#import <UIKit/UIKit.h>
#import "BGViewController.h"
#import "BaseViewController.h"

@interface BGMeasureViewController : BaseViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *BGValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *bgTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIImageView *uploadFinishImageView;

@property (weak, nonatomic) IBOutlet UILabel *startMeasureMentNowLabel;
@property (weak, nonatomic) IBOutlet UIButton *showStepByStepButton;
@property (weak, nonatomic) IBOutlet UIView *lightIntroView;
@property (weak, nonatomic) IBOutlet UIView *stepByStepView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;



@property (weak, nonatomic) IBOutlet UIView *dontShowAgainView;
@property (weak, nonatomic) IBOutlet UILabel *dontShowAgainLabel;
@property (retain, nonatomic) IBOutlet UIPageControl *pageController;
@property (retain, nonatomic) NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImageView;

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIButton *fastingCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *beforeMealCheckBox;
@property (weak, nonatomic) IBOutlet UIButton *afterMealCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *fastingLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforeMealLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterMealLabel;
@property (weak, nonatomic) IBOutlet UIButton *notSpecifiedCheckBox;
@property (weak, nonatomic) IBOutlet UILabel *notSpecifiedLabel;

//error part
@property (weak, nonatomic) IBOutlet UIButton *troubleShoot;
@property (weak, nonatomic) IBOutlet UIView *errorLayout;
@property (weak, nonatomic) IBOutlet UIButton *errorOkBtn;
@property (weak, nonatomic) IBOutlet UILabel *errorType;
@property (weak, nonatomic) IBOutlet UILabel *errorTitle;

@property (weak, nonatomic) IBOutlet UILabel *meanTitle;
@property (weak, nonatomic) IBOutlet UILabel *meanText;
@property (weak, nonatomic) IBOutlet UILabel *solutionTitle;
@property (weak, nonatomic) IBOutlet UILabel *solutionText;

@property (weak, nonatomic) IBOutlet UILabel *errorArrayText;


@property (weak, nonatomic) IBOutlet UITableView *errorSelectLayout;

@property (weak, nonatomic) IBOutlet UIScrollView *errorScrollLayout;






-(void)startScan;

@end
