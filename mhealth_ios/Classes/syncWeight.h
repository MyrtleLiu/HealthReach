//
//  syncWeight.h
//  mHealth
//
//  Created by sngz on 14-3-19.
//
//

#import <Foundation/Foundation.h>
#import "Weight.h"

@interface syncWeight : NSObject

+(void)syncAllWeightData:(NSString *)newestWeightDate_Server;

//+(NSString *)getNewestWeightDate_Server;

+ (void)syncWeightMonthAndWeekData;

+(NSData *)getWeightRecord:(NSInteger)dayBetween;

+(void)uploadData;
+(void)sendResult:(Weight *)weightRecord;

+(void)parserWeightData:(NSData*)xmlData groupType:(NSString *)groupType;
+(void)parserWeightData;

@end
