//
//  MedicationAlapk.h
//  mHealth
//
//  Created by gz dev team on 14年9月17日.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MedicationAlapk : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    IBOutlet UILabel*_label1;
    IBOutlet UILabel*_label2;
    IBOutlet UIView *aView;
    UILabel*_label3;
    UILabel*_label4;
    IBOutlet UILabel *hendLabelFont;
    IBOutlet UIButton *btn_done;
    IBOutlet UIButton *goToCalendar;
    NSMutableArray*timesArray ;
    UIButton *button;
    IBOutlet UIButton *gohomeBUtton;
    int jokei;
      int theNUMBERTiken;
       NSMutableArray * tikenArray;
    NSString*theTimeNOW;
    
    
    
    IBOutlet UILabel * msehsHandTextFont;
    
    IBOutlet UIView * aaaView;
       IBOutlet UIView *_table;
    
    
    int objectCalendarid;
    NSMutableArray*objectCakendarAtTekinTime;
    
    
    UITableView *_tableView;
    NSMutableArray *_headarray ;
    
    NSArray * mr_ListArray;
    NSArray * _measurementArray;
    
    NSString * _theTimeOutBegin;//鬧鐘提醒
    NSMutableArray *timesssArray;
    
    UIImageView*imageView;
    UIView *appForceView;
    UIImageView *imagehandImageView;
    UIImageView*healthReachImageView;
    IBOutlet UIImageView *medicadionImagePhotoVIew;
    IBOutlet UILabel * reminder_backguand;
    IBOutlet UILabel * other_backguand;
    IBOutlet UIButton * thatisOKbuttonText;

    IBOutlet UIView *backGuangView;
    IBOutlet UIView *_littleBackguandView;
    IBOutlet UIImageView *helthIcon;
    
    IBOutlet UIView *imageBackGuandView;
    NSString *sessionidStrStr;
    NSString *loinIdStrStr;
    IBOutlet UIButton * addEventButton;
}

@property(nonatomic,strong)NSDictionary*medicationDic;
@property(nonatomic,strong) NSString *str1;
 @property(nonatomic,strong) NSString * ididid;



@property (nonatomic,strong)UIView*addView;


@property(nonatomic,strong)NSString *dateDateStr;

@property(nonatomic,strong)NSMutableArray * timeBloodMutableArray;
@property(nonatomic,strong)NSMutableArray * timeECGMutableArray;
@property(nonatomic,strong)NSMutableArray * timeGlucoseMutableArray;
@property(nonatomic,strong)NSMutableArray * idBloodMutableArray;
@property(nonatomic,strong)NSMutableArray * idECGMutableArray;
@property(nonatomic,strong)NSMutableArray * idGlucoseMutableArray;

@property(nonatomic,strong)NSMutableArray * titleMedicationArray;
@property(nonatomic,strong)NSMutableArray * timesMedicationArray;
@property(nonatomic,strong)NSMutableArray * dosageMedicationArray;
@property(nonatomic,strong)NSMutableArray * medID;
@property(nonatomic,strong)NSMutableArray * mealMedicationArray;
@property(nonatomic,strong)NSMutableArray * reminderIDMedicationArray;


@property(nonatomic,strong)NSMutableArray * titleAdhocArray;
@property(nonatomic,strong)NSMutableArray * startTimesArray;
@property(nonatomic,strong)NSMutableArray * endTimesArray;
@property(nonatomic,strong)NSMutableArray * adHocID;
@property(nonatomic,strong)NSMutableArray * adHoNote;
@property(nonatomic,strong)NSMutableArray * adDateDate;


@property(nonatomic,strong)NSString * walkStartDate;
@property(nonatomic,strong)NSString * walkEndDate;
@property(nonatomic,strong)NSMutableArray * timeWalkMustableArray;
@property(nonatomic,strong)NSMutableArray * idWalkinfMustableArray;



@property(nonatomic,assign)float madionHeight;
@property(nonatomic,assign)float otherHeight;







-(IBAction)GoHome:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)gotoCalendar:(id)sender;
-(IBAction)addEvent:(id)sender;



-(IBAction)thisOk:(id)sender;
@end
