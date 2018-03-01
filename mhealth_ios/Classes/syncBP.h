//
//  syncBP.h
//  mHealth
//
//  Created by sngz on 14-3-18.
//
//

#import <Foundation/Foundation.h>
#import "BloodPressure.h"

@interface syncBP : NSObject

+ (void)syncAllBPData:(NSString *)newestBPDate_Server;

//+ (NSString *)getNewestBPDate_Server;

+ (void)syncBPMonthAndWeekData;

+ (NSData *)getHistoryRecord:(NSInteger)dayBetween groupType:(NSString *)groupType;

+ (void)uploadBPNotUpload:(NSMutableArray *)uploadBPNotUploadArray;

+ (void)sendResult:(BloodPressure *)bpRecord;

+ (NSArray *) getAllBPMonthRecord;

+(void)parserBPData:(NSData*)xmlData groupType:(NSString *)groupType;
+(void)parserBPData;

@end
