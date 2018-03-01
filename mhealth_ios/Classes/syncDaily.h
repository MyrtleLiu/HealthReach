//
//  syncDaily.h
//  mHealth
//
//  Created by gz dev team on 14年8月12日.
//
//

#import <Foundation/Foundation.h>
#import "CalendarData.h"
#import "DBHelper.h"
#import "Utility.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
@interface syncDaily : NSObject

+(void)getHistoryRecord;
+(void)parsedDataFromData:(NSData *)xmlData;




@end
