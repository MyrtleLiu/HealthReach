//
//  DBHelper.h
//  mHealth
//
//  Created by sngz on 14-2-12.
//
//

#import <Foundation/Foundation.h>
#import "BloodPressure.h"
#import "Weight.h"
#import "BloodPressureList.h"
#import "BloodGlucose.h"
#import "WalkingRecord.h"
#import "TrainingRecord.h"
#import "Alarm.h"
#import "FoodEntry.h"
#import "BloodGlucoseList.h"
#import "WeightList.h"
#import "MessageObject.h"
#import "GameObject.h"

@interface DBHelper : NSObject

{
    NSMutableArray*timeBloodArray;
    NSMutableArray *timeECGArray;
    NSMutableArray *timeGloodArray;
    NSMutableArray *timeStartTime;
    NSMutableArray *timeMationArray;
    NSMutableArray *timeWalkingArray;
    NSString*dateDate;
}

+ (BOOL) initDB;

+ (BOOL) addBPRecord:(BloodPressure *) bp;
+ (BOOL) addBPMonthRecord:(BloodPressure *)bp month:(NSString *)month;
+ (BOOL) addBPWeekRecord:(BloodPressure *)bp weekno:(NSString *)weekno weekstart:(NSString *)weekstart weekend:(NSString *)weekend;
+ (NSArray *)getAllBPMonthRecord;
+ (void) generateBPBlankMonthRecords;
+ (NSArray *)getAllBPWeekRecord;
+ (void) generateBPBlankWeekRecords;


+ (BOOL) addWeightRecord:(Weight *) weight;
+ (BOOL) addWeightMonthRecord:(Weight *)weight month:(NSString *)month;
+ (BOOL) addWeightWeekRecord:(Weight *)weight weekno:(NSString *)weekno weekstart:(NSString *)weekstart weekend:(NSString *)weekend;
+ (NSArray *)getAllWeightMonthRecord;
+ (NSArray *)getAllWeightWeekRecord;
+ (void)generateWeightBlankMonthRecords;
+ (void)generateWeightBlankWeekRecords;

+ (BOOL) addBGRecord:(BloodGlucose *) bg;
+ (NSArray *)getAllBGMonthRecord;
+ (NSArray *)getAllBGWeekRecord;
+ (BOOL) addBGMonthRecord:(BloodGlucose *)bg month:(NSString *)month;
+ (BOOL) addBGWeekRecord:(BloodGlucose *)bg weekno:(NSString *)weekno weekstart:(NSString *)weekstart weekend:(NSString *)weekend;
+ (void) generateBGBlankMonthRecords;
+ (void) generateBGBlankWeekRecords;

+ (BloodPressureList *) getBPByDate:(long)start enddate:(long)end status:(NSInteger)thestatus; // if start and end ==0 will return all records.

+ (BloodGlucoseList *) getBGByDate:(long)start enddate:(long)end status:(NSInteger)thestatus; // if start and end ==0 will return all records.

+ (WeightList *) getWeightByDate:(long)start enddate:(long)end status:(NSInteger)thestatus; // if start and end ==0 will return all records.

+ (Weight *) getNewestWeightRecord;
+ (BloodPressure *)getNewestBPRecord;
+ (BloodGlucose *)getNewestBGRecord;
+ (NSMutableDictionary *)getNewestFoodRecords;

+ (NSMutableArray *) getWeightHistoryRecord;
+ (NSMutableArray *) getBPHistoryRecord;
+ (NSMutableArray *)getBGHistoryRecord;


+ (NSString *)getNewestBPDate_DB;
+ (NSString *)getNewestWeightDate_DB;
+ (NSString *)getNewestBGDate_DB;

+ (NSMutableArray *)getBPNotUpload;
+ (NSMutableArray *)getBGNotUpload;
+ (NSMutableArray *)getWeightNotUpload;

+ (NSArray *)getRecordNotUploaded:(NSString *)fromDatabase;



+ (BOOL) addWalkingRecord:(WalkingRecord *) walking;
+ (NSMutableArray *)getCWRecord;
+ (WalkingRecord *)getCWRecordById:(NSString*)recordid;
+ (NSMutableArray *)getCWRecordDate:(long)start enddate:(long)end type:(NSInteger)thetype;//type 0 cw; type 1 tr; type 3 wati for upload;
+ (BOOL) addTrainRecord:(TrainingRecord *) train;
+ (NSMutableArray *)getTrainRecord;
+ (TrainingRecord *)getLatestTrainRecord;
+ (void)delTrainRecord:(NSString *) trainid;
+ (void)deleteTrainRecordById:(NSString *) trainid;



+ (void)delNoIdRecord;

+(BOOL)addCalendarRoadECG:(Alarm*)DiaryAll;
+(NSMutableArray *)getCalendarBPRecode;
+(void)getTheCalendarBPRecodeFor_id;
+(BOOL)deleteCalendarBPList;

+(BOOL)addCalendarRoadBG:(Alarm*)DiaryAll;
+(NSMutableArray *)getCalendarBGRecode;
+(void)getTheCalendarBGRecodeFor_id;
+(BOOL)deleteCalendarBGList;

+(BOOL)addCalendarRoadBP:(Alarm*)DiaryAll;
+(NSMutableArray *)getCalendarECGRecode;
+(void)getTheCalendarECGRecodeFor_id;
+(BOOL)deleteCalendarECGList;

+(BOOL)addCalendarRoadOthers:(Alarm*)DiaryAll;
+(NSMutableArray *)getCalendarOthersRecode;
+(void)getTheCalendarOthersRecodeFor_id;
+(BOOL)deleteCalendarOthersList:(NSString*)DiaryAll;

+(BOOL)addCalendarRoadWalking:(Alarm*)DiaryAll;
+(NSMutableArray *)getCalendarWalkingRecode;
+(void)getTHeCalendarWalkingRecodeFor_id;
+(BOOL)deleteCalendarWalkingList;

+(BOOL)addCalendarRoadMedication:(Alarm*)DiaryAll;
+(NSMutableArray *)getCalendarMedicationRecode;
+(void)getCalendarMedicationRecodeFor_id;
+(BOOL)UPDateTakenMedication:(Alarm*)DiaryAll;
+(BOOL)deleteCalendarMedicationList:(NSString*)DiaryAll;

+(BOOL)addCalendarRoadMedication_Notes:(Alarm*)DiaryAll;
+(NSMutableArray *)getCalendarMedicationRecode_Notes;
+(BOOL)deleteCalendarMedicationList_Notes:(NSString*)DiaryAll;







+(BOOL)deleteCalendarBP;
+(BOOL)deleteCalendarBG;
+(BOOL)deleteCalendarECG;
+(BOOL)deleteCalendarOthers;
+(BOOL)deleteCalendarWalking;
+(BOOL)deleteCalendarMedication;

// Manipulate food list file
+ (BOOL)isFoodListFileNameNew:(NSString *)filename;
+ (BOOL)addFoodRecord:(FoodEntry *)foodEntry;
+ (NSMutableArray *)getAllFoodRecord:(NSString *)foodType;

// Save food record
+(void)changeFoodQuantityUpdateDB:(NSNumber *)food_id foodQuantity:(NSInteger)newFoodQuantity;
+ (NSMutableArray *)getFoodRecordsModified;
+ (void)resetFoodListTable;
+ (void)addFoodFinalRecord:(NSString *)recordTime foodRecordDetail:(NSString *)recordDetail totalCalories:(NSNumber *)totalCalories recordId:(NSString *)recordId status:(NSString *)status;
+ (NSMutableArray *)getAllCaloriesRecords;
+ (void)updateFoodDetail:(NSString *)recordId foodRecordDetail:(NSString *)recordDetail;

// sync food records
+ (NSString *)getNewestFoodDate_DB;
+ (NSMutableArray *)getFoodNotUpload;
+ (NSMutableArray *)getRecordIdsWithEmptyRecordDetail;
+ (void)setFoodRecordStatus:(NSInteger)status recordId:(NSString *)recordId recordTime:(NSString *)recordTime recordDetail:(NSString *)recordDetail;
+ (NSString *)deleteFoodDetail:(NSString *)recordTime;

+ (BOOL) addBPRecordAverageChart:(BloodPressure *) bp;
+ (BloodPressureList *) getBPAverageChartByDate:(long)start enddate:(long)end status:(NSInteger)thestatus;
+ (BOOL) addBGAverageChartRecord:(BloodGlucose *)bg;
+ (BloodGlucoseList *) getBGAverageChartByDate:(long)start enddate:(long)end status:(NSInteger)thestatus;
+ (BOOL) addWeightAverageChartRecord:(Weight *)weight;
+ (WeightList *) getWeightAverageChartByDate:(long)start enddate:(long)end status:(NSInteger)thestatus;
+ (BOOL) addWalkingCWAverageChartRecord:(WalkingRecord *) walking;
+ (NSMutableArray *)getCWAverageChartRecordDate:(long)start enddate:(long)end type:(NSInteger)thetype;
+ (BOOL) addWalkingTrainAverageChartRecord:(WalkingRecord *) walking;
+ (NSMutableArray *)getTrainAverageChartRecordDate:(long)start enddate:(long)end type:(NSInteger)thetype;
+ (NSMutableArray *) getCaloriesRecordsByDate:(long)start enddate:(long)end;

+ (void)delBGAverageChart;
+ (void)delWeightAverageChart;
+ (void)delBPRecordAverageChart;

// step by step slideshow
+ (BOOL)isLightIntro:(NSString *)view;
+ (void)changeLightIntro:(NSString *)view status:(NSInteger)status;

// MessageBox
+ (BOOL) addNewsRecordToDB:(MessageObject *) result;



//messageBox
+ (BOOL) addMessageRecordToDB:(MessageObject *) result;

+ (void) deleteMessageRecordFromDB:(NSString *) messageid;

+ (NSMutableArray *) loadMessageFromDB;
+ (NSMutableArray *) loadNewsFromDB;


+ (void) setMessageRead:(NSString *) messageid;
+ (void) setNewsRead:(NSString *) messageid;



+ (NSString *) encryptionString:(NSString *) strvalue;
+ (NSString *) decryptionString:(NSString *) strvalue2;

//SAVE-Calendar
+(BOOL)addSaveCalendar:(int)isSave;
+(int)isSave;

+(BOOL)zhendeyouma:(int)isSave;
+(int)gengxinguoma;


//game

+ (NSMutableArray *) getPlantList;
+ (NSMutableArray *) getTrophyList;
+ (NSMutableArray *) getDiamondList;
+ (NSMutableArray *) getGoldList;
+ (NSMutableArray *) getSilverList;
+ (NSMutableArray *) getBronzeList;
+ (GameObject *) getTrophyProgress;
+ (GameObject *) getPlantProgress;
+ (BOOL)addPlant:(GameObject *)game;
+ (BOOL)deletePlantList;
+ (BOOL)deleteTrophyList;
+ (BOOL)deletePlantProgress;


+ (GameObject *) getFristTimePlantProgress;
+ (BOOL)addFristTimePlant:(GameObject *)game;
+ (BOOL)deleteFristTimePlantList;

+ (BOOL) addFristTimeWalkingRecord:(WalkingRecord *) walking;
+ (NSMutableArray *)getFristTimeCWRecord;



//get all the measurement,medication,others and walking today
-(NSMutableArray*)todayMeasurement;



@end
