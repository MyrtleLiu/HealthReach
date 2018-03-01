//
//  SyncWalking.h
//  mHealth
//
//  Created by smartone_sn on 14-8-12.
//
//

#import <Foundation/Foundation.h>
#import "WalkingRecord.h"
#import "TrainingRecord.h"


#import "DBHelper.h"
#import "Utility.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "GlobalVariables.h"
#import "Constants.h"

@interface SyncWalking : NSObject

+(void)syncAllWalkingData;
+ (TrainingRecord *)getAllWalkingRecord;
+ (WalkingRecord *)getWalkingRecordDetail:(NSString *)recordid;
+ (NSMutableArray *)addWalkingRcord:(WalkingRecord *)record;
+ (TrainingRecord *)getTrainRecord:(NSString *)recordid;


+ (void)addTrainRcord:(TrainingRecord *)record;
+ (void)delTrainRcord:(NSString *)trainid;

@end
