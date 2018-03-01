//
//  syncBG.h
//  mHealth
//
//  Created by sngz on 14-3-28.
//
//

#import <Foundation/Foundation.h>
#import "BloodGlucose.h"

@interface syncBG : NSObject

+ (void)syncAllBGData:(NSString *)newestBGDate_Server;

//+ (NSString *)getNewestBGDate_Server;

+ (void) syncBGMonthAndWeekData;

+ (NSData *)getHistoryRecord:(NSInteger)dayBetween groupType:(NSString *)groupType;

+ (void)uploadBGNotUpload:(NSMutableArray *)uploadBGNotUploadArray;

+ (void)sendResult:(BloodGlucose *)bgRecord;

+(void)parserBGData;
+(void)parserBGData:(NSData*)xmlData groupType:(NSString *)groupType;

@end
