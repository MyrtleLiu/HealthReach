//
//  UserInfoViewController.h
//  mHealth
//
//  Created by sngz on 14-2-28.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NIDropDown.h"
#import "AFPickerView.h"

@interface UserInfoViewController : BaseViewController<NIDropDownDelegate,AFPickerViewDataSource, AFPickerViewDelegate>{
    
    
    NSString *oldHeightStr;
    NSString *oldWeightStr;
    
    NIDropDown *genderDropDown;
    
    NIDropDown *weightDropDown;
    NIDropDown *heightDropDown;
    NIDropDown *circumferenceDropDown;
    
    NSMutableArray *yearsData;
    
    NSString *yearValue;
    NSString *yearTmpValue;
    
    NSString *genderValue;
    NSString *weightValue;
    NSString *weightDisplayValue;
    NSString *heightValue;
    NSString *heightDisplayValue;
    NSString *circumferenceValue;
    NSString *circumferenceDisplayValue;

    
    
}

@property (strong, nonatomic) IBOutlet UIView *chooseBirthView;
@property (strong, nonatomic) IBOutlet UIView *chooseBirthContentView;
@property (strong, nonatomic) AFPickerView *birthPicker;

@property (strong, nonatomic) IBOutlet UITextField *weightTextField;
@property (strong, nonatomic) IBOutlet UITextField *heightTextField;
@property (strong, nonatomic) IBOutlet UITextField *circumferenceTextField;

@property (strong, nonatomic) IBOutlet UILabel *birthValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightdisplayValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightdisplayValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *circumferencedisplayValueLabel;

@property (strong, nonatomic) NSString *from;

- (IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)cancelButtonDown:(id)sender;

- (IBAction)chooseGender:(id)sender;
- (IBAction)chooseWeightdisplay:(id)sender;
- (IBAction)chooseHeightdisplay:(id)sender;
- (IBAction)chooseCircumferencedisplay:(id)sender;

- (IBAction)hideChooseBirth:(id)sender;
- (IBAction)showChooseBirth:(id)sender;
- (IBAction)saveBirth:(id)sender;


@property (strong,nonatomic) IBOutlet UILabel *actionbar;
@property (strong,nonatomic) IBOutlet UILabel *topTitleText;
@property (strong,nonatomic) IBOutlet UILabel *birthTtile;
@property (strong,nonatomic) IBOutlet UILabel *genderTitle;
@property (strong,nonatomic) IBOutlet UILabel *weightTitle;
@property (strong,nonatomic) IBOutlet UILabel *heightTtile;
@property (strong,nonatomic) IBOutlet UILabel *circumTtile;

@property (strong,nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong,nonatomic) IBOutlet UIButton *okBtn;

@property (strong,nonatomic) IBOutlet UIView *feet_in_view;
@property (strong,nonatomic) IBOutlet UITextField *feet_textFile;
@property (strong,nonatomic) IBOutlet UITextField *inch_textFile;




@property (nonatomic) float CircuTemValue;
@property (nonatomic) float WeightTemValue;
@property (nonatomic) float HeightTemValue;


@end






//        <phone>63213405</phone>
//        <email></email>
//        <gender>M</gender>
//        <weight>44.00</weight>
//        <weightdisplay>lb</weightdisplay>
//        <height>175.00</height>
//        <heightdisplay>cm</heightdisplay>
//        <circumference>85.00</circumference>
//        <circumferencedisplay>cm</circumferencedisplay>
//        <ethnicity></ethnicity>
//        <lang>en</lang>
//        <webuser></webuser>
//        <webpasswd></webpasswd>
//        <birth>1980</birth>
