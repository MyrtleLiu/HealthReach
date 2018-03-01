//
//  syncAlertLevel.h
//  mHealth
//
//  Created by admin on 9/3/14.
//
//

#import <Foundation/Foundation.h>
#import "AlertLevel.h"

@interface syncAlertLevel : NSObject

+(void)syncAlertLevelData;

+ (NSData *)getHistoryRecord;

+ (void)sendResult:(AlertLevel *)alertLevelRecord setUpdateType:(NSString *)updateType;

@end
