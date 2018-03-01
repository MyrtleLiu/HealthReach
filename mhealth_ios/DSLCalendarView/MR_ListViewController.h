//
//  MR_ListViewController.h
//  mHealth
//
//  Created by gz dev team on 14年3月18日.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <EventKit/EventKit.h>

@interface MR_ListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    int objectCalendarid;
    NSMutableArray*objectCakendarAtTekinTime;

    NSString *typetitle;

    IBOutlet UIView *_table;
    UITableView *_tableView;
    NSMutableArray *_headarray ;
    
    NSMutableArray *startTime24;
    NSMutableArray *startTime2;
    NSMutableArray *startTime15;
    
    
    NSArray * mr_ListArray;
    NSArray * _measurementArray;
    
    NSString * _theTimeOutBegin;//鬧鐘提醒
    NSMutableArray *timesArray;
    
    IBOutlet UILabel * mHealthHandTextFOnt;
    IBOutlet UILabel * msehsHandTextFont;
    IBOutlet UIButton *addReminderTextFont;
    
    NSDictionary*medicationDic;
    UIImageView*imageView;
    
    
        EKEventStore *eventStore ;
    
}

@property (nonatomic,strong)UIView*addView;


@property(nonatomic,assign)int isCalendar;





-(IBAction)AddReminder:(id)sender;
-(IBAction)BACKBACK:(id)sender;


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
@property(nonatomic,strong)NSMutableArray * imageStrMedicationArray;
@property(nonatomic,strong)NSMutableArray * noteMedicationArray;

@property(nonatomic,strong)NSMutableArray * titleAdhocArray;
@property(nonatomic,strong)NSMutableArray * startTimesArray;
@property(nonatomic,strong)NSMutableArray * endTimesArray;
@property(nonatomic,strong)NSMutableArray * adHocID;
@property(nonatomic,strong)NSMutableArray * adHoNote;
@property(nonatomic,strong)NSMutableArray * adDateDate;
@property(nonatomic,strong)NSMutableArray *metickenArray;

@property(nonatomic,strong)NSString * walkStartDate;
@property(nonatomic,strong)NSString * walkEndDate;
@property(nonatomic,strong)NSMutableArray * timeWalkMustableArray;
@property(nonatomic,strong)NSMutableArray * idWalkinfMustableArray;



@property(nonatomic,assign)float madionHeight;
@property(nonatomic,assign)float otherHeight;


@end
