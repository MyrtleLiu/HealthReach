//
//  Alarm.h
//  mHealth
//
//  Created by smartone_sn on 14-4-14.
//
//

#import <Foundation/Foundation.h>

@interface Alarm : NSObject{
    NSString *bpID;
    NSString *bpType;
    NSString *bpTime;
    NSString *bpRepeat;
    NSString *bpCreateTime;
    NSString *bpServerTime;
    
    NSString *ecgID;
    NSString *ecgType;
    NSString *ecgTime;
    NSString *ecgRepeat;
    NSString *ecgCreateTime;
    NSString *ecgServerTime;
    
    NSString *bgID;
    NSString *bgType;
    NSString *bgTime;
    NSString *bgRepeat;
    NSString *bgCreateTime;
    NSString *bgServerTime;
    
    NSString *othersTitle;
    NSString *otherType;
    NSString *othersID;
    NSString *othersStarTime;
    NSString *othersEndTime;
    NSString *othersDate;
    NSString *othersNote;
    NSString *otherCreateTime;
    NSString *otherServerTime;
    
    NSString *walkingID;
    NSString *walkingType;
    NSString *walkingStartDate;
    NSString *walkingEndDate;
    NSString *walkingTime;
    NSString *walkingRepeat;
    NSString *walkingCreateTime;
    NSString *walkingServerTime;
    
    NSString *medicationMedID;
    NSString *medicationTitle;
    NSString *medicationDosage;
    NSString *medicationMeal;
    NSString *medicationServerTime;
    NSString *medicationReminderid;
    NSString *medicationReminderType;
    NSString *medicationReminderTime;
    NSString *medicationReminderRepeat;
    NSString *medicationReminderTicken;
    NSString *medicationReminderCreateTime;
    NSString *medicationReminderServerTime;
    NSString *medicationNote;
    
    NSString *medicationReminderImageString;
    
        long recordtime;
    
    
    
    

    
    
}



@property (strong, nonatomic) NSString *bpID;
@property (strong, nonatomic) NSString *bpType;
@property (strong, nonatomic) NSString *bpTime;
@property (strong, nonatomic) NSString *bpRepeat;
@property (strong, nonatomic) NSString *bpCreateTime;
@property (strong, nonatomic) NSString *bpServerTime;

@property (strong, nonatomic) NSString *ecgID;
@property (strong, nonatomic) NSString *ecgType;
@property (strong, nonatomic) NSString *ecgTime;
@property (strong, nonatomic) NSString *ecgRepeat;
@property (strong, nonatomic) NSString *ecgCreateTime;
@property (strong, nonatomic) NSString *ecgServerTime;

@property (strong, nonatomic) NSString *bgID;
@property (strong, nonatomic) NSString *bgType;
@property (strong, nonatomic) NSString *bgTime;
@property (strong, nonatomic) NSString *bgRepeat;
@property (strong, nonatomic) NSString *bgCreateTime;
@property (strong, nonatomic) NSString *bgServerTime;

@property (strong, nonatomic) NSString *othersTitle;
@property (strong, nonatomic) NSString *otherType;
@property (strong, nonatomic) NSString *othersID;
@property (strong, nonatomic) NSString *othersStarTime;
@property (strong, nonatomic) NSString *othersEndTime;
@property (strong, nonatomic) NSString *othersDate;
@property (strong, nonatomic) NSString *othersNote;
@property (strong, nonatomic) NSString *otherCreateTime;
@property (strong, nonatomic) NSString *otherServerTime;

@property (strong, nonatomic) NSString *walkingID;
@property (strong, nonatomic) NSString *walkingType;
@property (strong, nonatomic) NSString *walkingStartDate;
@property (strong, nonatomic) NSString *walkingEndDate;
@property (strong, nonatomic) NSString *walkingTime;
@property (strong, nonatomic) NSString *walkingRepeat;
@property (strong, nonatomic) NSString *walkingCreateTime;
@property (strong, nonatomic) NSString *walkingServerTime;

@property (strong, nonatomic) NSString *medicationMedID;
@property (strong, nonatomic) NSString *medicationTitle;
@property (strong, nonatomic) NSString *medicationDosage;
@property (strong, nonatomic) NSString *medicationMeal;
@property (strong, nonatomic) NSString *medicationServerTime;
@property (strong, nonatomic) NSString *medicationReminderid;
@property (strong, nonatomic) NSString *medicationReminderType;
@property (strong, nonatomic) NSString *medicationReminderTime;
@property (strong, nonatomic) NSString *medicationReminderRepeat;
@property (strong, nonatomic) NSString *medicationReminderTicken;
@property (strong, nonatomic) NSString *medicationReminderCreateTime;
@property (strong, nonatomic) NSString *medicationReminderServerTime;
@property (strong, nonatomic) NSString *medicationReminderImageString;
@property (strong, nonatomic) NSString *medicationNote;



-(id)initWithBPId:(NSString *)bpID bpRepeat:(NSString *)repeat bptime:(NSString *)time bptype:(NSString *)type  bpcreatetime:(NSString*)createtime bpservertime:(NSString*)servertime;

-(id)initWithECGId:(NSString *)ecgID ecgRepeat:(NSString *)repeat ecgtime:(NSString *)time ecgtype:(NSString *)type  ecgcreatetime:(NSString*)createtime ecgservertime:(NSString*)servertime;

-(id)initWithBGId:(NSString *)bgID bgRepeat:(NSString *)repeat bgtime:(NSString *)time bgtype:(NSString *)type  bgcreatetime:(NSString*)createtime bgservertime:(NSString*)servertime;

-(id)initWithOthersId:(NSString*)otherid Title:(NSString *)title StartTime:(NSString*)starttime EndTime:(NSString*)endTime Note:(NSString *)note Date:(NSString*)date Type:(NSString*)type Createtime:(NSString*)createtime Servertime:(NSString*)servertime;

-(id)initWithWalkingId:(NSString *)walkingid StartDate:(NSString *)startdate EndDate:(NSString*)enddate Type:(NSString*)type Time:(NSString*)time Repeat:(NSString*)repeat CreateTime:(NSString*)createtime Servertime:(NSString*)servertime;

-(id)initWithMedicationId:(NSString *)medicationid Title:(NSString*)title Meal:(NSString*)meal DosAge:(NSString *)dosage Servertime:(NSString*)servertime ReminderTime:(NSString*)remindertimes ReminderID:(NSString*)reminderid ReminderType:(NSString*)remindertype ReminderRepeat:(NSString*)reminderrepeat ReminderTicken:(NSString*)reminderticken ReminderCreateTime:(NSString*)remindercreatetime ReminderserverTime:(NSString*)remindersevertime ReminderImageString:(NSString*)reminderimagestring Note:(NSString *)note;


-(long)getRecordtime;

@end
