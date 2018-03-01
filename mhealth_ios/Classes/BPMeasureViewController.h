//
//  BPMeasureViewController.h
//  mHealth
//
//  Created by gz dev team on 14年1月9日.
//
//

#import <UIKit/UIKit.h>
#import "BPViewController.h"
#import "BaseViewController.h"

@interface BPMeasureViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{

    NSString *showDIct;
    NSMutableArray*_array1 ;
    IBOutlet UIButton *TroubleShooting;
    
    IBOutlet UIScrollView*_errorScrollLayout;
}
@property (weak, nonatomic) IBOutlet UIView *wholeScrollView;
@property (weak, nonatomic) IBOutlet UIView *lightIntroView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *dontShowAgainView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImageView;
@property (retain, nonatomic) NSMutableArray *images;
@property (weak, nonatomic) IBOutlet UILabel *dontShowAgainLabel;

@property (weak, nonatomic) IBOutlet UILabel *startMeasurementNowLabel;
@property (weak, nonatomic) IBOutlet UIButton *showDetailStepsButton;

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *SYSTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *SYSLabel;
@property (weak, nonatomic) IBOutlet UILabel *SYSUnitNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *DIATitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *DIALabel;
@property (weak, nonatomic) IBOutlet UILabel *DIAUnitNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *rateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateUnitNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;

// out of date
@property (weak, nonatomic) IBOutlet UITableView *ResultTableView;
@property (strong, nonatomic) NSArray *dataList;
@property (strong,nonatomic) NSString *titleString;
@property (strong,nonatomic) NSString *valueString;
@property (strong,nonatomic) NSString *unitString;

@property (strong,nonatomic) IBOutlet UIView *meaningAndsolutionVIew;
@property (strong,nonatomic) IBOutlet UIButton *btn_OK;
@property (strong,nonatomic) IBOutlet UILabel*meaning;
@property (strong,nonatomic) IBOutlet UILabel*solution;
@property (strong,nonatomic) IBOutlet UILabel*type;
@property (strong,nonatomic) IBOutlet UILabel* chickType;
@property (strong,nonatomic) IBOutlet UILabel*meaningText;
@property (strong,nonatomic) IBOutlet UILabel*solutionText;
@property (strong,nonatomic) IBOutlet UITableView *tableViewErrerType;
@property (strong,nonatomic) IBOutlet UILabel*error_text_title;
-(IBAction)chickType:(id)sender;
-(IBAction)okokok:(id)sender;
-(IBAction)Trouble_Shooting:(id)sender;
@property (nonatomic) BOOL checkTime;
@property (nonatomic) NSDate *timData;





@end