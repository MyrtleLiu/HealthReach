//
//  Utility.m
//  mHealth
//
//  Created by smartone_sn on 14-2-20.
//
//

#import "Utility.h"
#import "Constants.h"
#import "GlobalVariables.h"
#import "DBHelper.h"
//#import "DDXMLDocument.h"
//#import "DDXMLElementAdditions.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "KeychainItemWrapper.h"
#import "GDataXMLNode.h"

@implementation Utility


+(NSString *)getLanguageCode{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *login=[defaults objectForKey:@"login"];
    
    
    //NSLog(@"check login in getLanguageCode : %@",login);
	NSString *lanuage = [defaults stringForKey:[NSString stringWithFormat:@"lang_%@",login]];
    
   // NSLog(@"check login : %@",login);
   // NSLog(@"%@............lanuage",lanuage);
    
    if (lanuage==nil) {
        
        
        NSUserDefaults* defs=[NSUserDefaults standardUserDefaults];
        
        NSArray* languages=[defs objectForKey:@"AppleLanguages"];
        
        NSString *lang=[languages objectAtIndex:0];
        
        
        
        if ([lang isEqualToString:@"zh"]||[lang rangeOfString:@"zh-"].location!=NSNotFound  ||[lang isEqualToString:@"zh-Hant"]
            ||[lang isEqualToString:@"zh-Hans"]||[lang isEqualToString:@"chi"]
            ||[lang isEqualToString:@"zho"]||[lang isEqualToString:@"zh-cn"]
            ||[lang isEqualToString:@"zh-CN"]||[lang isEqualToString:@"zh-hk"]
            ||[lang isEqualToString:@"zh-HK"]||[lang isEqualToString:@"zh-tw"]||[lang isEqualToString:@"zh-TW"]) {
            

            [self setLanguage:@"cn"];
            
            return @"cn";
            
        }else{
            
            [self setLanguage:@"en"];
            
            return @"en";
        }
        
        
    }else{
        
        if ([lanuage isEqualToString:@"zh"]) {
            
            [self setLanguage:@"cn"];
            
            return @"cn";
        }
        
    }
    
    
    return lanuage;
}
+(NSString *)getStringByKey:(NSString*)key{
    
    NSUserDefaults *lanUser = [NSUserDefaults standardUserDefaults];
    NSString *lan = [self getLanguageCode];
    if ([lanUser objectForKey:@"dic"] == nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:lan ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        if(NULL!=dictionary){
            [lanUser setObject:dictionary forKey:@"dic"];
        }
        
    }
    return [[lanUser objectForKey:@"dic"] objectForKey:key];
    
}

+(void)setLanguage:(NSString*)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *login=[defaults objectForKey:@"login"];

    [defaults setObject:key forKey:[NSString stringWithFormat:@"lang_%@",login]];
    [defaults synchronize];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:key ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    if(NULL!=dictionary){
        [defaults setObject:dictionary forKey:@"dic"];
    }
    
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
    [sharedDefaults setObject: key forKey: @"lang"];
    [sharedDefaults synchronize];
     
}

+(int)isSucc:(NSData *)xmlData{
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    GDataXMLElement *statusElement = [[rootElement elementsForName:@"status"] objectAtIndex:0];
    if([statusElement stringValue]!=nil){
        if([[statusElement stringValue] isEqualToString:@"succ"]){
            return true;
        }
    }
    return false;
}

+(NSString *)getNewestHeight{
    
    NSString *height = [[NSString alloc]init];
    NSString *urlStr = [[NSString alloc]init];
    
    // when network is available
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthUser?login="];
        urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&sessionid="];
        urlStr = [urlStr stringByAppendingString:session_id];
        NSURL *requestURL = [NSURL URLWithString:urlStr];
        NSLog(@"height request URL:%@",requestURL);
        NSData *xmlData = [NSData dataWithContentsOfURL:requestURL];
        if (!(xmlData == nil)){
            GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
            GDataXMLElement *rootElement = [doc rootElement];
            NSArray *response = [rootElement elementsForName:@"response"];
            for (GDataXMLElement *obj in response){
                GDataXMLElement *heightElement = [[obj elementsForName:@"height"]objectAtIndex:0];
                if (heightElement){
                    height = heightElement.stringValue;
                    NSLog(@"get newest height 1:%@",height);
                    if (height>0)
                        return height;
                }
            }
        }
    }
    
    // if network is unavailable, calculate height from weight&bmi in database
    Weight *newestWeight = [DBHelper getNewestWeightRecord];
    float bmi = [newestWeight.bmi floatValue];
    int weight = [newestWeight.weight intValue];
    int heightValue = round(sqrt(weight/bmi));
    height = [NSString stringWithFormat:@"%d",heightValue];
    NSLog(@"get newest height 2:%@",height);
    return height;
}

+(NSString *)extractDateString:(NSString *)timeStr oldDateFormatter:(NSString *)oldDateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:oldDateFormatter];
    NSDate *oldDate = [dateFormatter dateFromString:timeStr];
    if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
        [dateFormatter setDateFormat:@"yyyy年M月dd日"];
    } else {
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
    }
    NSString *dateString = [dateFormatter stringFromDate:oldDate];
    return dateString;
}

+(NSString *)extractTimeString:(NSString *)timeStr oldDateFormatter:(NSString *)oldDateFormatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:oldDateFormatter];
    NSDate *oldDate = [dateFormatter dateFromString:timeStr];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *timeString = [dateFormatter stringFromDate:oldDate];
    
    return timeString;
}

+(NSString *)inURLFormat:(NSString *)dateStr {
    NSString *urlDate = [dateStr copy];
    if (urlDate.length>16){
        urlDate = [urlDate substringToIndex:16];
    } else {

    }
    urlDate = [urlDate stringByReplacingOccurrencesOfString:@"-" withString:@"%2d"];
    urlDate = [urlDate stringByReplacingOccurrencesOfString:@":" withString:@"%3a"];
    urlDate = [urlDate stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    return urlDate;
}

+(NSString *)getBGTypeString:(NSString *)typeCode {
    
    if ([typeCode isEqualToString:@"F"])
        return [Utility getStringByKey:@"fasting"];
 
    if ([typeCode isEqualToString:@"B"])
        return [Utility getStringByKey:@"before_meal"];
    
    if ([typeCode isEqualToString:@"A"])
        return [Utility getStringByKey:@"after_meal"];
    if ([typeCode isEqualToString:@"U"])
        return [Utility getStringByKey:@"not_specified"];
    return @"";
}

+(NSString *)getRoundFloatNSString:(NSString *)originalFloatNSString maximumFractionDigits:(int)maximunDigits {

    float floatNumber = [originalFloatNSString floatValue];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setMaximumFractionDigits:maximunDigits];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];

    NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatNumber]];

    return numberString;
}

+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



+(NSString *)getBirth{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"birth_%@",[GlobalVariables shareInstance].login_id]];
    
    if (result==nil) {
        
        return @"";
    }else{
        
        return result;
    }
    
}
+(NSString *)getGender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"gender_%@",[GlobalVariables shareInstance].login_id]];
    
    if (result==nil) {
        
        return @"";
    }else{
        
        return result;
    }
    
}
+(NSString *)getWeight{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"weight_%@",[GlobalVariables shareInstance].login_id]];
    
    if (result==nil) {
        
        return @"";
    }else{
        
        return result;
    }
    
}
+(NSString *)getWeightdisplay{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"weightdisplay_%@",[GlobalVariables shareInstance].login_id]];
    
    if (result==nil) {
        
        return @"";
    }else{
        
        return result;
    }
    
}
+(NSString *)getHeight{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"height_%@",[GlobalVariables shareInstance].login_id]];
    
    if (result==nil) {
        
        return @"175";
    }else{
        
        return result;
    }
    
}
+(NSString *)getHeightdisplay{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"heightdisplay_%@",[GlobalVariables shareInstance].login_id]];
    
    if (result==nil) {
        
        return @"";
    }else{
        
        return result;
    }
    
}
+(NSString *)getCircumference{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"circumference_%@",[GlobalVariables shareInstance].login_id]];
    
    if (result==nil) {
        
        return @"";
    }else{
        
        return result;
    }
}
+(NSString *)getCircumferencedisplay{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"circumferencedisplay_%@",[GlobalVariables shareInstance].login_id]];
    
    if (result==nil) {
        
        return @"";
    }else{
        
        return result;
    }
}

+(BOOL)isFirstTimeLogin{
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
     NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"first_login_%@",[GlobalVariables shareInstance].login_id]];
    
    

    
    if (result==nil) {
        
        return YES;
    }
    
    if ([result isEqualToString:@"0"]) {
        
        return YES;
        
    }else{
        
        return NO;
    }
    
}

+(void)updateFirstTimeLogin{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"1" forKey:[NSString stringWithFormat:@"first_login_%@",[GlobalVariables shareInstance].login_id]];

    
    [defaults synchronize];
    
//    
//    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"first_login_%@",[GlobalVariables shareInstance].login_id]];
//    
//    
//    NSLog(@"resutl...2....%@",result);

}

+(CGFloat)calculateHeightForString:(NSString *)text usingWidth:(CGFloat)_width usingFont:(UIFont *)_font {
    
    CGSize size = CGSizeMake(_width, MAXFLOAT);
    //CGSize valueSize = [text sizeWithFont:_font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    
    
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    //textStyle.alignment = NSTextAlignmentCenter;

    
    CGRect textRect = [text
                       boundingRectWithSize:size
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName:_font, NSParagraphStyleAttributeName:textStyle,}
                       context:nil];
    
    return textRect.size.height ;
}

+(CGFloat)calculateWidthForString:(NSString *)text usingFont:(UIFont *)_font {
    
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //CGSize valueSize = [text sizeWithFont:_font constrainedToSize:size  lineBreakMode:NSLineBreakByWordWrapping];
    
    
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    //textStyle.alignment = NSTextAlignmentCenter;
    
    
    CGRect textRect = [text
                       boundingRectWithSize:size
                       options:NSStringDrawingUsesLineFragmentOrigin
                       attributes:@{NSFontAttributeName:_font, NSParagraphStyleAttributeName:textStyle,}
                       context:nil];
    
    return textRect.size.width ;
}

+ (BOOL)findAndResignFirstResponder:(UIView*)view {
    if (view.isFirstResponder) {
        [view resignFirstResponder];
        return YES;
    }
    for (UIView *subView in view.subviews) {
        if ([Utility findAndResignFirstResponder:subView])
            return YES;
    }
    return NO;
}

+ (UIView*)findView:(int)tag view:(UIView*)view {
    for(UIView *child in [view subviews]) {
        if([child tag] == tag){
            return (UITextField*)child;
        } else {
            UIView *o = [Utility findView:tag view:child];
            if(o)
                return o;
        }
    }
    return nil;
}

+ (UITextField*)findTextField:(int)tag view:(UIView*)view {
    UIView *aview = [Utility findView:tag view:view];
    if([aview isKindOfClass:[UITextField class]])
        return (UITextField*)aview;
    return nil;
}

+ (UILabel*)findLabel:(int)tag view:(UIView*)view {
    UIView *aview = [Utility findView:tag view:view];
    if([aview isKindOfClass:[UILabel class]])
        return (UILabel*)aview;
    return nil;
}

+(BOOL)isSameDayDate:(NSDate*)date1 theDate:(NSDate*)date2{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent1 = [calendar components:unitFlags fromDate:date1];
    
    NSInteger year=dateComponent1.year;
    NSInteger month=dateComponent1.month;
    NSInteger day=dateComponent1.day;
    
    NSDateComponents *dateComponent2 = [calendar components:unitFlags fromDate:date2];
    
    NSInteger year2=dateComponent2.year;
    NSInteger month2=dateComponent2.month;
    NSInteger day2=dateComponent2.day;
    
    
    if (year==year2&&month==month2&&day==day2) {
        
        return true;
    }
    
    
    return false;
}

+(BOOL)isSameMonthDate:(NSDate*)date1 theDate:(NSDate*)date2{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent1 = [calendar components:unitFlags fromDate:date1];
    
    NSInteger year=dateComponent1.year;
    NSInteger month=dateComponent1.month;
    
    NSDateComponents *dateComponent2 = [calendar components:unitFlags fromDate:date2];
    
    NSInteger year2=dateComponent2.year;
    NSInteger month2=dateComponent2.month;
    
    //NSLog(@"%ld......%ld......date month",(long)month,(long)month2);
    
    if (year==year2&&month==month2) {
        
        return true;
    }
    
    
    return false;
    
}


+ (void)saveBPSort:(NSString*)sort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sort forKey:[NSString stringWithFormat:@"dashboard_bp_short_%@",[GlobalVariables shareInstance].login_id]];
    
    
    [defaults synchronize];
    
}

+ (void)saveHRSort:(NSString*)sort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sort forKey:[NSString stringWithFormat:@"dashboard_hr_short_%@",[GlobalVariables shareInstance].login_id]];
    
    
    [defaults synchronize];
    
}
+ (void)saveBGSort:(NSString*)sort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sort forKey:[NSString stringWithFormat:@"dashboard_bg_short_%@",[GlobalVariables shareInstance].login_id]];
    
    
    [defaults synchronize];
}
+ (void)saveWeightSort:(NSString*)sort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sort forKey:[NSString stringWithFormat:@"dashboard_weight_short_%@",[GlobalVariables shareInstance].login_id]];
    
    
    [defaults synchronize];
}
+ (void)saveBMISort:(NSString*)sort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sort forKey:[NSString stringWithFormat:@"dashboard_bmi_short_%@",[GlobalVariables shareInstance].login_id]];
    
    
    [defaults synchronize];
}
+ (void)saveWalkDurationSort:(NSString*)sort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sort forKey:[NSString stringWithFormat:@"dashboard_walkduration_short_%@",[GlobalVariables shareInstance].login_id]];
    
    
    [defaults synchronize];
}
+ (void)saveCalsSort:(NSString*)sort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sort forKey:[NSString stringWithFormat:@"dashboard_cals_short_%@",[GlobalVariables shareInstance].login_id]];
    
    
    [defaults synchronize];
}

+ (NSString*)getBPSort{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"dashboard_bp_short_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
}
+ (NSString*)getHRSort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"dashboard_hr_short_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
}
+ (NSString*)getBGSort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"dashboard_bg_short_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
}
+ (NSString*)getWeightSort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"dashboard_weight_short_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
}
+ (NSString*)getBMISort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"dashboard_bmi_short_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
}
+ (NSString*)getWalkDurationSort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"dashboard_walkduration_short_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
}
+ (NSString*)getCalsSort{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"dashboard_cals_short_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
}

+ (NSDictionary *)generateWeekDatesFromDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear fromDate:date];

    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date] weekday];
    //NSInteger weekofyear = [components weekOfYear];
    //NSLog(@"dayofweek:%d weekofyear:%d",dayofweek, weekofyear);
    [components setDay:([components day] - ((dayofweek) - 2))];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];

    NSCalendar *gregorianEnd = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsEnd = [gregorianEnd components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSInteger Enddayofweek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date] weekday];// this will give you current day of week
    [componentsEnd setDay:([componentsEnd day]+(7-Enddayofweek)+1)];
    NSDate *EndOfWeek = [gregorianEnd dateFromComponents:componentsEnd];
    
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                                beginningOfWeek, @"startNSDate",
                                                EndOfWeek, @"endNSDate", nil];
    
    return returnDict;
}

+ (NSString*)deviceModelName {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //MARK: You may just return machineName. Following is for convenience
    
    NSDictionary *commonNamesDictionary =
    @{
      @"i386":     @"iPhone Simulator",
      @"x86_64":   @"iPad Simulator",
      
      @"iPhone1,1":    @"iPhone",
      @"iPhone1,2":    @"iPhone 3G",
      @"iPhone2,1":    @"iPhone 3GS",
      @"iPhone3,1":    @"iPhone 4",
      @"iPhone3,2":    @"iPhone 4(Rev A)",
      @"iPhone3,3":    @"iPhone 4(CDMA)",
      @"iPhone4,1":    @"iPhone 4S",
      @"iPhone5,1":    @"iPhone5(GSM)",
      @"iPhone5,2":    @"iPhone5(GSM+CDMA)",
      @"iPhone5,3":    @"iPhone5c(GSM)",
      @"iPhone5,4":    @"iPhone5c(GSM+CDMA)",
      @"iPhone6,1":    @"iPhone5s(GSM)",
      @"iPhone6,2":    @"iPhone5s(GSM+CDMA)",
      @"iPhone7,1":    @"iPhone6Plus",
      @"iPhone7,2":    @"iPhone6",
      
      @"iPad1,1":  @"iPad 1",
      @"iPad2,1":  @"iPad 2(WiFi)",
      @"iPad2,2":  @"iPad 2(GSM)",
      @"iPad2,3":  @"iPad 2(CDMA)",
      @"iPad2,4":  @"iPad 2(WiFi Rev A)",
      @"iPad2,5":  @"iPadMini(WiFi)",
      @"iPad2,6":  @"iPadMini(GSM)",
      @"iPad2,7":  @"iPadMini(GSM+CDMA)",
      @"iPad3,1":  @"iPad3(WiFi)",
      @"iPad3,2":  @"iPad3(GSM+CDMA)",
      @"iPad3,3":  @"iPad3(GSM)",
      @"iPad3,4":  @"iPad4(WiFi)",
      @"iPad3,5":  @"iPad4(GSM)",
      @"iPad3,6":  @"iPad4(GSM+CDMA)",
      @"iPad4,1":  @"iPadAir(Wi-Fi)",
      @"iPad4,2":  @"iPadAir(Wi-Fi+LTE)",
      @"iPad4,3":  @"iPadAir(Rev)",
      @"iPad4,4":  @"iPadmini2(Wi-Fi)",
      @"iPad4,5":  @"iPadmini2(Wi-Fi+LTE)",
      @"iPad4,6":  @"iPadmini2(Rev)",
      @"iPad4,7":  @"iPadmini3(Wi-Fi)",
      @"iPad4,8":  @"iPadmini3(A1600)",
      @"iPad4,9":  @"iPadmini3(A1601)",
      @"iPad5,3":  @"iPadAir2(Wi-Fi)",
      @"iPad5,4":  @"iPadAir2(Wi-Fi+LTE)",
      
      @"iPod1,1":  @"iPod 1st Gen",
      @"iPod2,1":  @"iPod 2nd Gen",
      @"iPod3,1":  @"iPod 3rd Gen",
      @"iPod4,1":  @"iPod 4th Gen",
      @"iPod5,1":  @"iPod 5th Gen",
      
      };
    
    NSString *deviceName = commonNamesDictionary[machineName];
    
    if (deviceName == nil) {
        deviceName = machineName;
    }
    
    return deviceName;
}

+ (NSString *)transeferWeightValue:(NSString *)lbWeightValueImport precision:(int)precision
{
    if ([[Utility getWeightdisplay] isEqualToString:@"lb"]) {
        return lbWeightValueImport;
    } else {
        if (precision == 1)
            return [NSString stringWithFormat:@"%.1f",[lbWeightValueImport floatValue]*0.4535924f];
        else
            return [NSString stringWithFormat:@"%.0f",[lbWeightValueImport floatValue]*0.4535924f];
    }
}


+(NSString *)getCloudStatus{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"clouds_status_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
    
}

+(NSString *)getCloudUrl{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *resutl=[defaults objectForKey:[NSString stringWithFormat:@"clouds_url_%@",[GlobalVariables shareInstance].login_id]];
    
    return resutl;
    
}

+(NSString *)getUUID{
    
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //NSString *statid=[userDefaults stringForKey:@"UUID"];
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
                                         initWithIdentifier:@"HealthReach" accessGroup:nil];
    
    [keychainItem setObject:@"trail_user" forKey:(id)CFBridgingRelease(kSecAttrAccount)];
    
    NSString *statid = [keychainItem objectForKey:(__bridge id)kSecValueData];
    
    if (statid==nil||[statid isEqualToString:@""]) {
        
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        NSString *uuid = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        
        //[userDefaults setObject:uuid forKey:@"UUID"];
        
        //[userDefaults synchronize];
        
        //statid=[userDefaults stringForKey:@"UUID"];
        
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]
                                             initWithIdentifier:@"HealthReach" accessGroup:nil];
        
        [keychainItem setObject:@"trail_user" forKey:(id)CFBridgingRelease(kSecAttrAccount)];
        
        [keychainItem resetKeychainItem];
        
        [keychainItem setObject:uuid forKey:(__bridge id)kSecValueData];
        

        statid = [keychainItem objectForKey:(__bridge id)kSecValueData];
        
    }
    
    
    return statid;
   
}

+(NSString *)getNetworkCode{
    
    CTTelephonyNetworkInfo *tni = [[CTTelephonyNetworkInfo alloc] init];

    //NSString *carrierName = tni.subscriberCellularProvider.carrierName;
    NSString *mobileCountryCode = tni.subscriberCellularProvider.mobileCountryCode;
    NSString *mobileNetworkCode = tni.subscriberCellularProvider.mobileNetworkCode;
    //NSLog(@"carrier: carrierName=%@, mobileCountryCode=%@,mobileNetworkCode=%@",carrierName,mobileCountryCode,mobileNetworkCode);
//    if ([mobileCountryCode isEqualToString:@"454"]&&[mobileNetworkCode isEqualToString:@"06"]) {
//        return true;
//    }

    NSString *networkCode=[NSString stringWithFormat:@"%@%@",mobileCountryCode,mobileNetworkCode];
    
    
    return networkCode;
    
}

@end
