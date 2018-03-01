//
//  syncBG.m
//  mHealth
//
//  Created by sngz on 14-3-28.
//
//

#import "syncBG.h"
#import "DBHelper.h"
#import "Utility.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "syncUtility.h"
#import "NSNotificationCenter+MainThread.h"

#import"GDataXMLNode.h"


@implementation syncBG

+(void)syncAllBGData:(NSString *)newestBGDate_Server{
    
    NSMutableArray *uploadBGNotUploadArray = [DBHelper getBGNotUpload];
    NSLog(@"upload BG array:%@",uploadBGNotUploadArray);
    [self uploadBGNotUpload:uploadBGNotUploadArray];
    
    //[self syncBGMonthAndWeekData];
    
    //get newest record date in DATABASE
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *newestBGDate_DB = [DBHelper getNewestBGDate_DB];
    long dbDate_long = (long)(newestBGDate_DB);
    newestBGDate_DB = [NSString formatTimeAgo:dbDate_long];
    if (newestBGDate_DB.length>=10)
        newestBGDate_DB = [newestBGDate_DB substringToIndex:10];
    else {
        [newestBGDate_DB uppercaseString];
        if ([newestBGDate_DB isEqualToString:@""] || ([newestBGDate_DB rangeOfString:@"NULL"].length>0)){
            newestBGDate_DB = @"1900-01-01";
        } else {
            NSLog(@"trimming newestBGDate_DB error! newestBGDate_DB:%@",newestBGDate_DB);
            [[NSNotificationCenter defaultCenter]postMainThreadNotificationWithName:@"SyncBGError" object:nil];
            return;
        }
    }
    NSDate *bgDate_DB = [dateFormatter dateFromString:newestBGDate_DB];
    NSLog(@"newestBGDate_DB:%@",newestBGDate_DB);
    
    
    //get newest record date in SERVER
    if (newestBGDate_Server.length>=10)
        newestBGDate_Server = [newestBGDate_Server substringToIndex:10];
    else {
        [[NSNotificationCenter defaultCenter]postMainThreadNotificationWithName:@"SyncBGError" object:nil];
        return;
    }
    NSDate *bgDate_Server = [dateFormatter dateFromString:newestBGDate_Server];
    
    //compare two dates and download the missing records
    NSInteger dayBetween = ([bgDate_Server timeIntervalSince1970]*1 - [bgDate_DB timeIntervalSince1970]*1)/86400;
    
    
    //vaycent edit
    dayBetween=1;
    
    if (dayBetween==0) {
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBGFinish" object:nil];
        dayBetween = 1;
    }
    if (dayBetween>0){
        // NSLog(@"Downloading BG records from server,%d days not sync.",dayBetween);
        [self syncBGData:dayBetween groupType:@"d"];
    } else {
        NSLog(@"BG records are up to date");
    }
    
    //upload the records which are not unloaded
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBGFinish" object:nil];
}

+ (void) syncBGMonthAndWeekData {
    [self syncBGData:130 groupType:@"w"];
    [self syncBGData:130 groupType:@"m"];
    [DBHelper generateBGBlankWeekRecords];
    [DBHelper generateBGBlankMonthRecords];
}

+ (void)uploadBGNotUpload:(NSMutableArray *)uploadBGNotUploadArray{
    BloodGlucose *bgRecord = [[BloodGlucose alloc]init];
    for (bgRecord in uploadBGNotUploadArray){
        [self sendResult:bgRecord];
    }
}

+(void)sendResult:(BloodGlucose *)bgRecord{
    
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm"];
    //    NSString *currentTimeStr = [bgRecord timeStr];
    //    [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthGlucose?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&action=A&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&bg="];
    url_string = [url_string stringByAppendingString:[bgRecord bg]];
    url_string = [url_string stringByAppendingString:@"&recordtime="];
    url_string = [url_string stringByAppendingString:[Utility inURLFormat:[bgRecord timeStr]]];
    url_string = [url_string stringByAppendingString:@"&type="];
    url_string = [url_string stringByAppendingString:[Utility inURLFormat:[bgRecord type]]];
    
    
    NSLog(@"BP sending url:%@",url_string);
    
    NSURL *request_url = [NSURL URLWithString:url_string];
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    if (xmlData){
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"is upload BG record succ:%d",isSucc);
        if (isSucc==1){
            [bgRecord setStatus:0];
            
            bgRecord.bg=[DBHelper encryptionString:bgRecord.bg];
            
            
            
            [DBHelper addBGRecord:bgRecord];
        }
    }
}

//+(NSString *)getNewestBGDate_Server{
//    NSString *dateString = [[NSString alloc]init];
//    NSData *xmlData = [self getHistoryRecord:360];
//    static NSString *lastRecordFlag = @"//lastrecord";
//	DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//    NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
//	for (DDXMLElement *obj in lastRecord) {
//        DDXMLElement *timeElement = [obj elementForName:@"recordtime"];
//        if (timeElement) {
//            dateString = [timeElement stringValue];
//            return dateString;
//        }
//    }
//    return @"1900-01-01 00:00:00";
//}

+(void)syncBGData:(NSInteger)dayBetween groupType:(NSString *)groupType{
    
    //NSLog(@"dayBetween:%d groupType:%@",dayBetween, groupType);
    NSData *xmlData = [self getHistoryRecord:90 groupType:groupType];
    
    NSLog(@"bg xml....%@",[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding]);
    
    if ([groupType isEqualToString:@"d"]) {
        
        //[syncUtility saveXMLData:BGD xml:xmlData];
        
        [syncBG parserBGData:xmlData groupType:groupType];
        
    }else if([groupType isEqualToString:@"w"]){
        
        //[syncUtility saveXMLData:BGW xml:xmlData];
        
        [syncBG parserBGData:xmlData groupType:groupType];
        
    }else if([groupType isEqualToString:@"m"]){
        
        //[syncUtility saveXMLData:BGM xml:xmlData];
        
        [syncBG parserBGData:xmlData groupType:groupType];
    }
    
    
    
    
    //NSLog(@"test again:%@,%@",checktype,groupType);
    
    
    
}

+(NSData *)getHistoryRecord:(NSInteger)dayBetween groupType:(NSString *)groupType{
    
    
    
    if (dayBetween==0) dayBetween=90;
    
    if ([groupType isEqualToString:@"d"]) {
        
        if (dayBetween>90) {
            
            dayBetween=90;
        }
    }
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)dayBetween]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        
        if ([groupType isEqualToString:@"d"]) {
            urlStr = [urlStr stringByAppendingString:@"&daily=0"];
        } else {
            urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"&grouptype=%@",groupType]];
        }
        
        NSLog(@"get BG history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
            NSLog(@"Get BG History error!");
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBGNoDataConnection" object:nil];
        } else {
            return xmlData;
        }
    }
    return nil;
}

+(void)parserBGData:(NSData*)xmlData groupType:(NSString *)groupType{
    
    static NSString *lastRecordFlag = @"lastrecord";
    static NSString *recordsFlag = @"records";
    static NSString *recordFlag = @"record";
    //NSString *checktype=@"bg";
    
    //DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"groupType:%@",groupType);
    
    //NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
    NSArray *lastRecord = [rootElement elementsForName:lastRecordFlag];
    NSLog(@"lastRecord lastRecord =%@",lastRecord);
    for (GDataXMLElement *obj in lastRecord) {
        GDataXMLElement *bgElement = [[obj elementsForName:@"bg"] objectAtIndex:0];
        GDataXMLElement *typeELement = [[obj elementsForName:@"type"] objectAtIndex:0];
        GDataXMLElement *timeElement = [[obj elementsForName:@"recordtime"] objectAtIndex:0];
        GDataXMLElement *missElement = [[obj elementsForName:@"missprevious"] objectAtIndex:0];
        
        //        if (!(([[bgElement stringValue] isEqualToString:@"0"]) ||
        //              ([[[bgElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
        //              ([[bgElement stringValue]length]==0)
        //              )) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
        long bgDate_long=[bgDate_string timeIntervalSince1970];
        
        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
        bgData.bg=[DBHelper encryptionString:bgData.bg];
        
        if ([groupType isEqualToString:@"d"]) {
            [DBHelper addBGRecord:bgData];
        } else if ([groupType isEqualToString:@"m"]) {
            NSString *bgValue = 0;
            NSString *type = @"";
            GDataXMLElement *fastingElement = [[obj elementsForName:@"fasting"] objectAtIndex:0];
            GDataXMLElement *afterElement = [[obj elementsForName:@"after"] objectAtIndex:0];
            GDataXMLElement *beforeElement = [[obj elementsForName:@"before"] objectAtIndex:0];
            GDataXMLElement *notSpecifiedElement = [[obj elementsForName:@"unspecify"] objectAtIndex:0];
            NSLog(@"unspecified:%@",[notSpecifiedElement stringValue]);
            
            if ([[fastingElement stringValue]floatValue] > 0) {
                bgValue = [fastingElement stringValue];
                
                bgValue=[DBHelper encryptionString:bgValue];
                
                type = @"F";
                bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                
                GDataXMLElement *monthElement = [[obj elementsForName:@"month"] objectAtIndex:0];
                [DBHelper addBGMonthRecord:bgData month:[monthElement stringValue]];
            }
            if ([[afterElement stringValue]floatValue] > 0) {
                bgValue = [afterElement stringValue];
                
                bgValue=[DBHelper encryptionString:bgValue];
                
                
                type = @"A";
                bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                
                GDataXMLElement *monthElement = [[obj elementsForName:@"month"] objectAtIndex:0];
                [DBHelper addBGMonthRecord:bgData month:[monthElement stringValue]];
                
            }
            if ([[beforeElement stringValue]floatValue] > 0) {
                bgValue = [beforeElement stringValue];
                
                bgValue=[DBHelper encryptionString:bgValue];
                
                
                type = @"B";
                bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                
                GDataXMLElement *monthElement = [[obj elementsForName:@"month"] objectAtIndex:0];
                [DBHelper addBGMonthRecord:bgData month:[monthElement stringValue]];
                
            }
            if ([[notSpecifiedElement stringValue]floatValue] > 0) {
                bgValue = [notSpecifiedElement stringValue];
                
                bgValue=[DBHelper encryptionString:bgValue];
                
                
                type = @"U";
                bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                
                GDataXMLElement *monthElement = [[obj elementsForName:@"month"] objectAtIndex:0];
                [DBHelper addBGMonthRecord:bgData month:[monthElement stringValue]];
            }
            //
        } else if ([groupType isEqualToString:@"w"]) {
            NSString *bgValue = 0;
            NSString *type = @"";
            GDataXMLElement *fastingElement = [[obj elementsForName:@"fasting"] objectAtIndex:0];
            GDataXMLElement *afterElement = [[obj elementsForName:@"after"] objectAtIndex:0];
            GDataXMLElement *beforeElement = [[obj elementsForName:@"before"] objectAtIndex:0];
            GDataXMLElement *notSpecifiedElement = [[obj elementsForName:@"unspecify"] objectAtIndex:0];
            NSLog(@"unspecified:%@",[notSpecifiedElement stringValue]);
            if ([[fastingElement stringValue]floatValue] > 0) {
                bgValue = [fastingElement stringValue];
                
                bgValue=[DBHelper encryptionString:bgValue];
                
                
                type = @"F";
                bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                
                GDataXMLElement *weeknoElement = [[obj elementsForName:@"weekno"] objectAtIndex:0];
                GDataXMLElement *weekstartElement = [[obj elementsForName:@"weekstart"] objectAtIndex:0];
                GDataXMLElement *weekendElement = [[obj elementsForName:@"weekend"] objectAtIndex:0];
                [DBHelper addBGWeekRecord:bgData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
            }
            if ([[afterElement stringValue]floatValue] > 0) {
                bgValue = [afterElement stringValue];
                
                bgValue=[DBHelper encryptionString:bgValue];
                
                
                type = @"A";
                bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                
                GDataXMLElement *weeknoElement = [[obj elementsForName:@"weekno"] objectAtIndex:0];
                GDataXMLElement *weekstartElement = [[obj elementsForName:@"weekstart"] objectAtIndex:0];
                GDataXMLElement *weekendElement = [[obj elementsForName:@"weekend"] objectAtIndex:0];
                [DBHelper addBGWeekRecord:bgData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
            }
            if ([[beforeElement stringValue]floatValue] > 0) {
                bgValue = [beforeElement stringValue];
                
                bgValue=[DBHelper encryptionString:bgValue];
                
                
                type = @"B";
                bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                
                GDataXMLElement *weeknoElement = [[obj elementsForName:@"weekno"] objectAtIndex:0];
                GDataXMLElement *weekstartElement = [[obj elementsForName:@"weekstart"] objectAtIndex:0];
                GDataXMLElement *weekendElement = [[obj elementsForName:@"weekend"] objectAtIndex:0];
                [DBHelper addBGWeekRecord:bgData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
            }if ([[notSpecifiedElement stringValue]floatValue] > 0) {
                bgValue = [notSpecifiedElement stringValue];
                
                bgValue=[DBHelper encryptionString:bgValue];
                
                
                type = @"U";
                bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                
                GDataXMLElement *weeknoElement = [[obj elementsForName:@"weekno"] objectAtIndex:0];
                GDataXMLElement *weekstartElement = [[obj elementsForName:@"weekstart"] objectAtIndex:0];
                GDataXMLElement *weekendElement = [[obj elementsForName:@"weekend"] objectAtIndex:0];
                [DBHelper addBGWeekRecord:bgData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
            }
            //
            
        }
        //}
    }
    
    NSArray *records = [rootElement elementsForName:recordsFlag];
    
    //NSLog(@"records....%d",[records count]);
    
    for (GDataXMLElement *obj in records) {
        //NSArray *record = [obj nodesForXPath:recordFlag error:nil];
        
        NSArray *record = [obj elementsForName:recordFlag];
        
        //NSLog(@"record....%d",[record count]);
        
        for (GDataXMLElement *objRecords in record){
           // if (![objRecords isEqual:[record lastObject]]){
                GDataXMLElement *bgElement = [[objRecords elementsForName:@"bg"] objectAtIndex:0];
                GDataXMLElement *typeELement = [[objRecords elementsForName:@"type"] objectAtIndex:0];
                GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"] objectAtIndex:0];
                GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"] objectAtIndex:0];
                
                //                if (!(([[bgElement stringValue] isEqualToString:@"0"]) ||
                //                      ([[[bgElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
                //                      ([[bgElement stringValue]length]==0)
                //                      )) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                long bgDate_long=[bgDate_string timeIntervalSince1970];
                
                BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
                
                bgData.bg=[DBHelper encryptionString:bgData.bg];
                
                
                if ([groupType isEqualToString:@"d"]) {
                    [DBHelper addBGRecord:bgData];
                } else if ([groupType isEqualToString:@"m"]) {
                    NSString *bgValue = 0;
                    NSString *type = @"";
                    GDataXMLElement *fastingElement = [[objRecords elementsForName:@"fasting"] objectAtIndex:0];
                    GDataXMLElement *afterElement = [[objRecords elementsForName:@"after"] objectAtIndex:0];
                    GDataXMLElement *beforeElement = [[objRecords elementsForName:@"before"] objectAtIndex:0];
                    GDataXMLElement *undefinedElement = [[objRecords elementsForName:@"unspecify"] objectAtIndex:0];
                    NSLog(@"unspecified:%@",[undefinedElement stringValue]);
                    GDataXMLElement *monthElement = [[objRecords elementsForName:@"month"] objectAtIndex:0];
                    if ([[fastingElement stringValue]floatValue] > 0) {
                        bgValue = [fastingElement stringValue];
                        bgValue=[DBHelper encryptionString:bgValue];
                        
                        type = @"F";
                        
                        bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        [DBHelper addBGMonthRecord:bgData month:[monthElement stringValue]];
                        
                    }
                    if ([[afterElement stringValue]floatValue] > 0) {
                        bgValue = [afterElement stringValue];
                        bgValue=[DBHelper encryptionString:bgValue];
                        
                        type = @"A";
                        bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        [DBHelper addBGMonthRecord:bgData month:[monthElement stringValue]];
                        
                    }
                    if ([[beforeElement stringValue]floatValue] > 0) {
                        bgValue = [beforeElement stringValue];
                        bgValue=[DBHelper encryptionString:bgValue];
                        
                        type = @"B";
                        bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        [DBHelper addBGMonthRecord:bgData month:[monthElement stringValue]];
                    }
                    if ([[undefinedElement stringValue]floatValue] > 0) {
                        bgValue = [undefinedElement stringValue];
                        bgValue=[DBHelper encryptionString:bgValue];
                        
                        type = @"U";
                        bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        [DBHelper addBGMonthRecord:bgData month:[monthElement stringValue]];
                    }
                } else if ([groupType isEqualToString:@"w"]) {
                    NSString *bgValue = 0;
                    NSString *type = @"";
                    GDataXMLElement *fastingElement = [[objRecords elementsForName:@"fasting"] objectAtIndex:0];
                    GDataXMLElement *afterElement = [[objRecords elementsForName:@"after"] objectAtIndex:0];
                    GDataXMLElement *beforeElement = [[objRecords elementsForName:@"before"] objectAtIndex:0];
                    GDataXMLElement *undefinedElement = [[objRecords elementsForName:@"unspecify"] objectAtIndex:0];
                    NSLog(@"unspecified:%@",[undefinedElement stringValue]);
                    GDataXMLElement *weeknoElement = [[objRecords elementsForName:@"weekno"] objectAtIndex:0];
                    GDataXMLElement *weekstartElement = [[objRecords elementsForName:@"weekstart"] objectAtIndex:0];
                    GDataXMLElement *weekendElement = [[objRecords elementsForName:@"weekend"] objectAtIndex:0];
                    if ([[fastingElement stringValue]floatValue] > 0) {
                        bgValue = [fastingElement stringValue];
                        bgValue=[DBHelper encryptionString:bgValue];
                        
                        type = @"F";
                        bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        [DBHelper addBGWeekRecord:bgData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
                        
                    }
                    
                    if ([[afterElement stringValue]floatValue] > 0) {
                        bgValue = [afterElement stringValue];
                        bgValue=[DBHelper encryptionString:bgValue];
                        
                        type = @"A";
                        bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        [DBHelper addBGWeekRecord:bgData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
                    }
                    
                    if ([[beforeElement stringValue]floatValue] > 0) {
                        bgValue = [beforeElement stringValue];
                        bgValue=[DBHelper encryptionString:bgValue];
                        
                        type = @"B";
                        bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        [DBHelper addBGWeekRecord:bgData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
                    }
                    
                    if ([[undefinedElement stringValue]floatValue] > 0) {
                        bgValue = [undefinedElement stringValue];
                        bgValue=[DBHelper encryptionString:bgValue];
                        
                        type = @"U";
                        bgData = [[BloodGlucose alloc]initWithBG:bgValue time:bgDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        [DBHelper addBGWeekRecord:bgData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
                    }
                    
                    
                    
                //}
                
                //}
            }
            
        }
    }
}


+(void)parserBGData{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        NSData *data30d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BGD]];
        
        NSData *data30w=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BGW]];
        
        NSData *data30m=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BGM]];
        
        
        if (data30d!=nil) {
            
            [syncBG parserBGData:data30d groupType:@"d"];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTD] error:nil];
            
        }
        
        
        if (data30w!=nil) {
            
            [syncBG parserBGData:data30w groupType:@"w"];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTW] error:nil];
            
        }
        
        if (data30m!=nil) {
            
            [syncBG parserBGData:data30m groupType:@"m"];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTM] error:nil];
            
        }
        
        
    }
    
}



@end
