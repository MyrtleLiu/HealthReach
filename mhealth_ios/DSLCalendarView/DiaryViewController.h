//
//  DiaryViewController.h
//  mHealth
//
//  Created by gz dev team on 14年4月2日.
//
// s

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <EventKit/EventKit.h>

@interface DiaryViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

{
    NSString *todyAdhocTime;
    int objectCalendarid;
    NSMutableArray*objectCakendarAtTekinTime;
    NSMutableArray* timesArray;
    NSMutableArray*  tikenArray;
    
    NSMutableArray *theAllTimeMadicon;
    NSMutableArray *theAllTakenMadicon;
    
    //UIAlertController*remindAlert;//用来贴活动指示器
    UIActivityIndicatorView*act;//活动指示器
    NSString *strTempTemp;//判斷中英文
    IBOutlet  UITableView* _tableDayView;
    NSString * dateDate;
    UITableView *_tableMonthView;
    NSMutableArray *_timeArray;
    UIView *_theView;
    IBOutlet UILabel *labelDay;
    
    UIButton * everyDayButton;
    
    
    IBOutlet UIScrollView*scoloorView;
    
    IBOutlet UILabel * mHealthHendTextFont;
    IBOutlet UILabel * monthTextFont;
    IBOutlet UILabel * dayTextFont;
    IBOutlet UIButton * addBUtton;
    IBOutlet UIButton * saveCalendarButton;
    
    IBOutlet UIButton *addEvent;
    IBOutlet UILabel * monthHendText;
    UIView * _whiteBackGuang;
    
    IBOutlet UIView * monthViewHEnd;
    IBOutlet UIView * buttonMonthDayVIew;
    IBOutlet UIButton *__buttonMonth;
    IBOutlet UIButton *__buttonDay;
    
    IBOutlet UIView *dayView;
    int myArrayCount;
    int _timeArrayCount;
    int _poiuyt;
    IBOutlet UILabel * monday;
    IBOutlet UILabel * tuesday;
    IBOutlet UILabel * wendseday;
    IBOutlet UILabel * thrsday;
    IBOutlet UILabel * firday;
    IBOutlet UILabel * saterday;
    IBOutlet UILabel * sunday;
    
    int theTableViewMonthHEight;
    NSNotificationCenter*notiCenter;
    NSMutableArray*mutableArray;
    NSMutableDictionary*dic;
    NSInteger addHeiger;
    NSMutableArray*myArray;
    UIImage * __monthImageON;
    UIImage * __dayImageON;
    UIImage * __monthImageOff;
    UIImage * __dayImageOff;
    NSMutableArray * timeBloodArray;
    NSMutableArray *timeECGArray;
    NSMutableArray *timeGloodArray;
    NSMutableArray *timeStartTime;
    NSMutableArray *timeMationArray;
    NSMutableArray *timeWalkingArray;
    UIView * _cellView00;
    UIView * _cellView01;
    UIView * _cellView02;
    UIView * _cellView03;
    UIView * _cellView04;
    UIView * _cellView05;
    UIView * _cellView06;
    UIView * _cellView07;
    UIView * _cellView08;
    UIView * _cellView09;
    UIView * _cellView10;
    
    UIView * _cellView11;
    UIView * _cellView12;
    UIView * _cellView13;
    UIView * _cellView14;
    UIView * _cellView15;
    UIView * _cellView16;
    UIView * _cellView17;
    UIView * _cellView18;
    UIView * _cellView19;
    UIView * _cellView20;
    UIView * _cellView21;
    UIView * _cellView22;
    UIView * _cellView23;
    int buttonHeiger00;
    int buttonHeiger01;
    int buttonHeiger02;
    int buttonHeiger03;
    int buttonHeiger04;
    int buttonHeiger05;
    int buttonHeiger06;
    int buttonHeiger07;
    int buttonHeiger08;
    int buttonHeiger09;
    int buttonHeiger10;
    
    int buttonHeiger11;
    int buttonHeiger12;
    int buttonHeiger13;
    int buttonHeiger14;
    int buttonHeiger15;
    int buttonHeiger16;
    int buttonHeiger17;
    int buttonHeiger18;
    int buttonHeiger19;
    int buttonHeiger20;
    
    int buttonHeiger21;
    int buttonHeiger22;
    int buttonHeiger23;
    
    
    NSString *timeStrRaindateDateSum111;
    NSString *timeStrRainStratDateSum111;
    NSString *timeStrRainENDDateSum111;
    NSString *currentDateStr11100;
    
    UIImageView*imageView;
    EKEventStore *eventStore ;
}

@property (nonatomic,strong)UIView*addView;


@property(nonatomic,strong)NSString *dateDateStr;


@property(nonatomic,strong)NSString *theTime;
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
@property(nonatomic,strong)NSMutableArray * tikenMedicationArray;
@property(nonatomic,strong)NSMutableArray * serverTimeMedicationArray;
@property(nonatomic,strong)NSMutableArray * everyONEmedicationTimeArray;
@property(nonatomic,strong)NSMutableArray * imageMedicationArray;

@property(nonatomic,strong)NSMutableArray * titleAdhocArray;
@property(nonatomic,strong)NSMutableArray * startTimesArray;
@property(nonatomic,strong)NSMutableArray * endTimesArray;
@property(nonatomic,strong)NSMutableArray * adHocID;
@property(nonatomic,strong)NSMutableArray * adHoNote;
@property(nonatomic,strong)NSMutableArray * adDateDate;
@property(nonatomic,retain)UIButton *oldButton;


@property(nonatomic,strong)NSString * walkStartDate;
@property(nonatomic,strong)NSString * walkEndDate;
@property(nonatomic,strong)NSMutableArray * timeWalkMustableArray;
@property(nonatomic,strong)NSMutableArray * idWalkinfMustableArray;



@property(nonatomic,strong)NSMutableArray *noteMedicationArray;


@property(nonatomic,assign)int isCalendar;

-(IBAction)ReminderList:(id)sender;
-(IBAction)AddReminder:(id)sender;
-(IBAction)saveCalendar:(id)sender;

-(void)getHistoryRecord;

-(IBAction)buttonDay:(id)sender;
-(IBAction)buttonMonth:(id)sender;
-(IBAction)turnleftday:(id)sender;
-(IBAction)turnrightday:(id)sender;
-(IBAction)turnleftMONTH:(id)sender;
-(IBAction)turnrightMONTH:(id)sender;

+(void)cancelAnd_userCalendar;

@end
