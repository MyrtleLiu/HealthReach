//
//  syncUtility.h
//  mHealth
//
//  Created by Apple on 23/5/14.
//
//

#import <Foundation/Foundation.h>

@interface syncUtility : NSObject

+ (BOOL)XMLHasError:(NSData *)xmlData;
+ (NSDictionary *)getAllNewestDate_server;
//+ (void)syncProcessor;
+ (NSString *)getAddWalkingRecordMsg:(NSData *)xmlData;
+(void)getMessageCount;
+(void)getNewsCount;
+ (void)getPersonInfo;
+ (void)updatePersonInfo:(NSDictionary *)userInfo;
+ (void)updatePersonalInfo:(NSString *)weightValueString;

+ (int)getHeadYear;
+ (int)getHeadMonth;

+ (void)saveXMLData:(NSString *)filename xml:(NSData *)data;
+ (void)parserAverageBP;
+ (void)parserAverageBG;
+ (void)parserAverageWeight;
+ (void)parserAverageCW;
+ (void)parserAverageTP;
+ (NSString *)getAppVerrsioningCheckKey:(NSData *)xmlData;
+(void)parserBGData:(NSData*)xmlData status:(int)thestatus;
+ (NSString *)getAddWalkingRecordShareKey:(NSData *)xmlData;


+(void)UpdateNews:(NSString*)messageNotReadCount;
@end
