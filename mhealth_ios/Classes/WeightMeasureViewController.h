//
//  WeightMeasureViewController.h
//  mHealth
//
//  Created by sngz on 14-2-24.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WeightMeasureViewController : BaseViewController
<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource, UIScrollViewDelegate>{
    NSArray *pickerArray;
}

@property(nonatomic, retain) IBOutlet UILabel *weight_title;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;

// over of date
@property(nonatomic, retain) IBOutlet UILabel *weight_unit;
@property(nonatomic, retain) IBOutlet UILabel *add_weight_title;
@property (weak, nonatomic) IBOutlet UIPickerView *weightPicker;
@property(nonatomic, retain) IBOutlet UILabel *ok;
@property(nonatomic, retain) IBOutlet UILabel *cancel;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;

@property (weak, nonatomic) IBOutlet UILabel *startMeasurementNowLabel;
@property (weak, nonatomic) IBOutlet UIButton *showDetailStepsButton;
@property (weak, nonatomic) IBOutlet UIView *lightIntroView;
@property (weak, nonatomic) IBOutlet UIView *stepByStepView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *dontShowAgainView;
@property (weak, nonatomic) IBOutlet UILabel *dontShowAgainLabel;
@property (retain, nonatomic) IBOutlet UIPageControl *pageController;
@property (retain, nonatomic) NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImageView;



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

@end
