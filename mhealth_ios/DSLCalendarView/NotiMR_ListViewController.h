//
//  NotiMR_ListViewController.h
//  mHealth
//
//  Created by gz dev team on 14年11月24日.
//
//

#import <UIKit/UIKit.h>

@interface NotiMR_ListViewController:UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    int objectCalendarid;
    NSMutableArray*objectCakendarAtTekinTime;
    
    
    IBOutlet UIView *_table;
    UITableView *_tableView;
    NSMutableArray *_headarray ;
    
    NSArray * mr_ListArray;
    NSArray * _measurementArray;
    
    NSString * _theTimeOutBegin;//鬧鐘提醒
    NSMutableArray *timesArray;
   
    IBOutlet UILabel * mHealthHandTextFOnt;
    IBOutlet UILabel * msehsHandTextFont;
    IBOutlet UIButton *addReminderTextFont;
    
    IBOutlet UILabel * reminder_backguand;
    IBOutlet UILabel * other_backguand;
    IBOutlet UIButton * thatisOKbuttonText;
    IBOutlet UIButton * backDoneBull;
    IBOutlet UIView *backGuangView;
    IBOutlet UIView *_littleBackguandView;
    IBOutlet UIImageView *helthIcon;
    IBOutlet UIView * ImageBackView;
    NSDictionary*medicationDic;
    UIImageView*imageView;
    IBOutlet UIButton *addEventButton;
    
    UIView *appForceView;
    UIImageView *imagehandImageView;
    UIImageView*healthReachImageView;
}

@property (nonatomic,strong)UIView*addView;


@property(nonatomic,assign)int isCalendar;




//
//-(IBAction)AddReminder:(id)sender;


@property(nonatomic,strong)NSDictionary* diction;
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
@property (nonatomic,strong)NSString * str1;
-(IBAction)GoHome:(id)sender;
//-(IBAction)back:(id)sender;
-(IBAction)thatisOK:(id)sender;
-(IBAction)bullbug:(id)sender;
-(IBAction)addEvent:(id)sender;


@end
