//
//  Alarm.m
//  mHealth
//
//  Created by smartone_sn on 14-4-14.
//
//

#import "Alarm.h"

@implementation Alarm

@synthesize bpTime,bpCreateTime,bpID,bpRepeat,bpServerTime,bpType,ecgCreateTime,ecgID,ecgRepeat,ecgServerTime,ecgTime,ecgType,bgCreateTime,bgID,bgRepeat,bgServerTime,bgTime,bgType,otherCreateTime,othersDate,othersEndTime,otherServerTime,othersID,othersNote,othersStarTime,othersTitle,otherType,walkingCreateTime,walkingEndDate,walkingID,walkingRepeat,walkingServerTime,walkingStartDate,walkingTime,walkingType,medicationDosage,medicationMeal,medicationMedID,medicationServerTime,medicationTitle,medicationReminderCreateTime,medicationReminderid,medicationReminderRepeat,medicationReminderServerTime,medicationReminderTicken,medicationReminderTime,medicationReminderType,medicationReminderImageString,medicationNote;


-(id)initWithBPId:(NSString *)ID bpRepeat:(NSString *)repeat bptime:(NSString *)time bptype:(NSString *)type  bpcreatetime:(NSString*)createtime bpservertime:(NSString*)servertime
{
    if(self = [super init])
    {
        self.bpID=ID;
        self.bgType=type;
        self.bpTime=time;
        self.bpRepeat=repeat;
        self.bpCreateTime=createtime;
        self.bpServerTime=servertime;
    }
    return self;
}
-(id)initWithECGId:(NSString *)ID ecgRepeat:(NSString *)repeat ecgtime:(NSString *)time ecgtype:(NSString *)type  ecgcreatetime:(NSString*)createtime ecgservertime:(NSString*)servertime
{
    if(self = [super init])
    {
        self.ecgID=ID;
        self.ecgType=type;
        self.ecgTime=time;
        self.ecgRepeat=repeat;
        self.ecgCreateTime=createtime;
        self.ecgServerTime=servertime;
    }
    return self;
}
-(id)initWithBGId:(NSString *)ID bgRepeat:(NSString *)repeat bgtime:(NSString *)time bgtype:(NSString *)type  bgcreatetime:(NSString*)createtime bgservertime:(NSString*)servertime
{
    if(self = [super init])
    {
        self.bgID=ID;
        self.bgType=type;
        self.bgTime=time;
        self.bgRepeat=repeat;
        self.bgCreateTime=createtime;
        self.bgServerTime=servertime;
    }
    return self;
}
-(id)initWithOthersId:(NSString*)otherid Title:(NSString *)title StartTime:(NSString*)starttime EndTime:(NSString*)endTime Note:(NSString *)note Date:(NSString*)date Type:(NSString*)type Createtime:(NSString*)createtime Servertime:(NSString*)servertime
{
    if(self = [super init])
    {
        self.othersID=otherid;
        self.othersTitle=title;
        self.othersStarTime=starttime;
        self.othersEndTime=endTime;
        self.othersNote=note;
        self.othersDate=date;
        self.otherType=type;
        self.otherCreateTime=createtime;
        self.otherServerTime=servertime;
        
        
    }
    return self;
}
-(id)initWithWalkingId:(NSString *)walkingid StartDate:(NSString *)startdate EndDate:(NSString*)enddate Type:(NSString*)type Time:(NSString*)time Repeat:(NSString*)repeat CreateTime:(NSString*)createtime Servertime:(NSString*)servertime
{
    if(self = [super init])
    {
        self.walkingID=walkingid;
        self.walkingStartDate=startdate;
        self.walkingEndDate=enddate;
        self.walkingType=type;
        self.walkingTime=time;
        self.walkingRepeat=repeat;
        self.walkingCreateTime=createtime;
        self.walkingServerTime=servertime;
        
    }
    return self;
}

-(id)initWithMedicationId:(NSString *)medicationid Title:(NSString*)title Meal:(NSString*)meal DosAge:(NSString *)dosage Servertime:(NSString*)servertime ReminderTime:(NSString*)remindertimes ReminderID:(NSString*)reminderid ReminderType:(NSString*)remindertype ReminderRepeat:(NSString*)reminderrepeat ReminderTicken:(NSString*)reminderticken ReminderCreateTime:(NSString*)remindercreatetime ReminderserverTime:(NSString*)remindersevertime ReminderImageString:(NSString *)reminderimagestring Note:(NSString *)note
{
    if(self = [super init])
    {
        self.medicationMedID=medicationid;
        self.medicationTitle=title;
        self.medicationDosage=dosage;
        self.medicationMeal=meal;
        self.medicationServerTime=servertime;
        self.medicationReminderid=reminderid;
        self.medicationReminderRepeat=reminderrepeat;
        self.medicationReminderTime=remindertimes;
        self.medicationReminderType=remindertype;
        self.medicationReminderTicken=reminderticken;
        self.medicationReminderCreateTime=remindercreatetime;
        self.medicationReminderServerTime=servertime;
        self.medicationReminderImageString=reminderimagestring;
        self.medicationNote=note;
        
    }
    return self;
}


-(long)getRecordtime
{
        return recordtime;
}

@end
