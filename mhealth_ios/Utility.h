//
//  Utility.h
//  mHealth
//
//  Created by smartone_sn on 14-2-20.
//
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject


+(NSString *)getLanguageCode;
+(NSString *)getStringByKey:(NSString*)key;
+(void)setLanguage:(NSString*)key;
+(int)isSucc:(NSData *)xmlData;
+(NSString *)getNewestHeight;
+(NSString *)extractDateString:(NSString *)timeStr oldDateFormatter:(NSString *)oldDateFormatter;
+(NSString *)extractTimeString:(NSString *)timeStr oldDateFormatter:(NSString *)oldDateFormatter;
+(NSString *)getBGTypeString:(NSString *)typeCode;

+(NSString *)inURLFormat:(NSString *)dateStr;

+(NSString *)getRoundFloatNSString:(NSString *)originalFloatNSString maximumFractionDigits:(int)maximunDigits;

+ (UIImage *)imageWithColor:(UIColor *)color;


+(NSString *)getBirth;
+(NSString *)getGender;
+(NSString *)getWeight;
+(NSString *)getWeightdisplay;
+(NSString *)getHeight;
+(NSString *)getHeightdisplay;
+(NSString *)getCircumference;
+(NSString *)getCircumferencedisplay;

+(BOOL)isFirstTimeLogin;

+(void)updateFirstTimeLogin;

+(CGFloat)calculateHeightForString:(NSString *)text usingWidth:(CGFloat)_width usingFont:(UIFont *)_font;
+(CGFloat)calculateWidthForString:(NSString *)text usingFont:(UIFont *)_font;

+ (BOOL)findAndResignFirstResponder:(UIView*)view;
+ (UIView*)findView:(int)tag view:(UIView*)view;
+ (UITextField*)findTextField:(int)tag view:(UIView*)view;
+ (UILabel*)findLabel:(int)tag view:(UIView*)view;


+(BOOL)isSameMonthDate:(NSDate*)date1 theDate:(NSDate*)date2;
+(BOOL)isSameDayDate:(NSDate*)date1 theDate:(NSDate*)date2;

+ (void)saveBPSort:(NSString*)sort;
+ (void)saveHRSort:(NSString*)sort;
+ (void)saveBGSort:(NSString*)sort;
+ (void)saveWeightSort:(NSString*)sort;
+ (void)saveBMISort:(NSString*)sort;
+ (void)saveWalkDurationSort:(NSString*)sort;
+ (void)saveCalsSort:(NSString*)sort;


+ (NSString*)getBPSort;
+ (NSString*)getHRSort;
+ (NSString*)getBGSort;
+ (NSString*)getWeightSort;
+ (NSString*)getBMISort;
+ (NSString*)getWalkDurationSort;
+ (NSString*)getCalsSort;

+ (NSString*)deviceModelName;
+ (NSDictionary *)generateWeekDatesFromDate:(NSDate *)date;

+ (NSString *)transeferWeightValue:(NSString *)lbWeightValueImport precision:(int)precision;

+(NSString *)getCloudStatus;
+(NSString *)getCloudUrl;

+(NSString *)getUUID;
+(NSString *)getNetworkCode;

@end
