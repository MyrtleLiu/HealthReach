//
//  NotiInForMationViewController.h
//  mHealth
//
//  Created by gz dev team on 14年11月24日.
//
//

#import <UIKit/UIKit.h>

@interface NotiInForMationViewController : UIViewController
{
    IBOutlet UILabel*_label1;
    IBOutlet UILabel*_label2;
    IBOutlet UIView *aView;
    UILabel*_label3;
    UILabel*_label4;
    IBOutlet UILabel *hendLabelFont;
    IBOutlet UIButton *btn_edit;
   
    
   IBOutlet UILabel * reminder_backguand;
   IBOutlet UILabel * other_backguand;
    IBOutlet UIButton * thatisOKbuttonText;
    IBOutlet UIView *backGuangView;
    IBOutlet UIView *_littleBackguandView;
    IBOutlet UIImageView *helthIcon;
    IBOutlet UIView *imageBackGuandView;
    
    
    UIView *appForceView;
    UIImageView *imagehandImageView;
    UIImageView*healthReachImageView;
    
    
}

@property(nonatomic,strong) NSMutableArray *medientID;
@property(nonatomic,strong) NSString *otherID;

@property(nonatomic,strong) NSString *str1;
@property(nonatomic,strong) NSString *str2;
@property(nonatomic,strong) NSString *str3;
@property(nonatomic,strong) NSString *str4;

@property(nonatomic,strong)NSDictionary*medicationDic;
@property(nonatomic,strong)NSString *alaicBody;

@property(nonatomic,strong) NSMutableArray *_turnArray;

@property(nonatomic,strong)NSMutableArray * docAgeArray;


@property(nonatomic,strong)NSString *dateDateStr;
@property(nonatomic,assign) int intemp;
@property(nonatomic,strong) NSMutableArray *_array;
@property(nonatomic,strong) NSMutableArray * _allArray;

@property(nonatomic,strong) NSString *_timeStart;
@property(nonatomic,strong) NSString *_timeEnd;

@property (nonatomic,strong)NSMutableArray * turntitleMedicationArray;
@property (nonatomic,strong)NSMutableArray * turntimesMedicationArray;
@property (nonatomic,strong)NSMutableArray * turnmedID;
@property (nonatomic,strong)NSMutableArray * turndosageMedicationArray;
@property (nonatomic,strong)NSMutableArray * turnMealMedicationArray;

@property (nonatomic,strong)NSMutableArray * turnWalkingArray;

@property (nonatomic,assign)int medWitchID;
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




-(IBAction)GoHome:(id)sender;
//-(IBAction)back:(id)sender;
-(IBAction)thatisOK:(id)sender;






@end


