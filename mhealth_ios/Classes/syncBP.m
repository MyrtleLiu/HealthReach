//
//  syncBP.m
//  mHealth
//
//  Created by sngz on 14-3-18.
//
//

#import "syncBP.h"
#import "DBHelper.h"
#import "Utility.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "syncUtility.h"
#import "NSNotificationCenter+MainThread.h"


#import"GDataXMLNode.h"


@implementation syncBP

//init sync BP record
+(void)syncAllBPData:(NSString *)newestBPDate_Server{
    
    //upload the records which are not unloaded
    NSMutableArray *uploadBPNotUploadArray = [DBHelper getBPNotUpload];
    [self uploadBPNotUpload:uploadBPNotUploadArray];
    
    //[self syncBPMonthAndWeekData];
    
    //get newest record date in DATABASE
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *newestBPDate_DB = [DBHelper getNewestBPDate_DB];
    long temp = (long)(newestBPDate_DB);
    newestBPDate_DB = [[NSString formatTimeAgo:temp] substringToIndex:10];
    NSDate *bpDate_DB = [dateFormatter dateFromString:newestBPDate_DB];
    
    if (newestBPDate_DB.length>=10)
        newestBPDate_DB = [newestBPDate_DB substringToIndex:10];
    else {
        [newestBPDate_DB uppercaseString];
        if ([newestBPDate_DB isEqualToString:@""] || ([newestBPDate_DB rangeOfString:@"NULL"]).length>0){
            newestBPDate_DB = @"1900-01-01";
        } else {
            NSLog(@"trimming newestBPDate_DB error! newestBPDate_DB:%@",newestBPDate_DB);
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPError" object:nil];
            return;
        }
    }
    
    //get newest record date in SERVER
    [newestBPDate_Server uppercaseString];
    if (newestBPDate_Server.length>=10)
        newestBPDate_Server = [newestBPDate_Server substringToIndex:10];
    else {
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPError" object:nil];
        return;
    }
    NSDate *bpDate_Server = [dateFormatter dateFromString:newestBPDate_Server];
    NSLog(@"Comparing bpDate_DB:%@ bpDate_Server:%@",bpDate_DB, bpDate_Server);
    //compare two dates and download the missing records
    NSInteger dayBetween = ([bpDate_Server timeIntervalSince1970]*1 - [bpDate_DB timeIntervalSince1970]*1)/86400;
    
    //vaycent edit
    dayBetween=1;
    //======
    if (dayBetween==0) {
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPFinish" object:nil];
        dayBetween = 1;
    }
    if (dayBetween>0){
        //NSLog(@"Downloading BP records from server,%d days not sync.",dayBetween);
        [self syncBPData:dayBetween groupType:@"d"];
    } else {
        NSLog(@"BP records are up to date");
    }
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPFinish" object:nil];
}

+(void)sync14DBPData:(NSString *)newestBPDate_Server{
    
    
    //get newest record date in DATABASE
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *newestBPDate_DB = [DBHelper getNewestBPDate_DB];
    long temp = (long)(newestBPDate_DB);
    newestBPDate_DB = [[NSString formatTimeAgo:temp] substringToIndex:10];
    NSDate *bpDate_DB = [dateFormatter dateFromString:newestBPDate_DB];
    
    if (newestBPDate_DB.length>=10)
        newestBPDate_DB = [newestBPDate_DB substringToIndex:10];
    else {
        [newestBPDate_DB uppercaseString];
        if ([newestBPDate_DB isEqualToString:@""] || ([newestBPDate_DB rangeOfString:@"NULL"]).length>0){
            newestBPDate_DB = @"1900-01-01";
        } else {
            NSLog(@"trimming newestBPDate_DB error! newestBPDate_DB:%@",newestBPDate_DB);
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPError" object:nil];
            return;
        }
    }
    
    //get newest record date in SERVER
    [newestBPDate_Server uppercaseString];
    if (newestBPDate_Server.length>=10)
        newestBPDate_Server = [newestBPDate_Server substringToIndex:10];
    else {
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPError" object:nil];
        return;
    }
    NSDate *bpDate_Server = [dateFormatter dateFromString:newestBPDate_Server];
    NSLog(@"Comparing bpDate_DB:%@ bpDate_Server:%@",bpDate_DB, bpDate_Server);
    //compare two dates and download the missing records
    NSInteger dayBetween = ([bpDate_Server timeIntervalSince1970]*1 - [bpDate_DB timeIntervalSince1970]*1)/86400;
    if (dayBetween==0) {
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPFinish" object:nil];
        dayBetween = 1;
    }
    if (dayBetween>0){
        //NSLog(@"Downloading BP records from server,%d days not sync.",dayBetween);
        [self syncBPData:dayBetween groupType:@"d"];
    } else {
        NSLog(@"BP records are up to date");
    }
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPFinish" object:nil];
}

+ (void)syncBPMonthAndWeekData
{
    NSLog(@"test here count");
    [self syncBPData:150 groupType:@"w"];
    [self syncBPData:150 groupType:@"m"];
    [DBHelper generateBPBlankWeekRecords];
    [DBHelper generateBPBlankMonthRecords];
}

+ (void)uploadBPNotUpload:(NSMutableArray *)uploadBPNotUploadArray{
    BloodPressure *bpRecord = [[BloodPressure alloc]init];
    for (bpRecord in uploadBPNotUploadArray){
        [self sendResult:bpRecord];
    }
}

+(void)sendResult:(BloodPressure *)bpRecord{
    
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm"];
    //    NSString *currentTimeStr = [bpRecord timeStr];
    //    [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthBP?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&action=A&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&systolic="];
    url_string = [url_string stringByAppendingString:[bpRecord sys]];
    url_string = [url_string stringByAppendingString:@"&diastolic="];
    url_string = [url_string stringByAppendingString:[bpRecord dia]];
    url_string = [url_string stringByAppendingString:@"&heartrate="];
    url_string = [url_string stringByAppendingString:[bpRecord heartrate]];
    url_string = [url_string stringByAppendingString:@"&recordtime="];
    url_string = [url_string stringByAppendingString:[Utility inURLFormat:[bpRecord timeStr]]];
    
    NSLog(@"BP sending url:%@",url_string);
    
    NSURL *request_url = [NSURL URLWithString:url_string];
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    if (xmlData){
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"is upload BP record succ:%d",isSucc);
        if (isSucc==1){
            [bpRecord setStatus:0];
            
            bpRecord.sys=[DBHelper encryptionString:bpRecord.sys];
            bpRecord.dia=[DBHelper encryptionString:bpRecord.dia];
            bpRecord.heartrate=[DBHelper encryptionString:bpRecord.heartrate];
            [DBHelper addBPRecord:bpRecord];
        }
    }
}

//+(NSString *)getNewestBPDate_Server{
//    NSString *dateString = [[NSString alloc]init];
//    NSData *xmlData = [self getHistoryRecord:360];
//    static NSString *lastRecordFlag = @"//lastrecord";
//	DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//    NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
//	for (DDXMLElement *obj in lastRecord) {
//        DDXMLElement *timeElement = [obj elementForName:@"recordtime"];
//        if (timeElement)
//            dateString = timeElement.stringValue;
//    }
//    return dateString;
//}

+(NSData *)getHistoryRecord:(NSInteger)dayBetween groupType:(NSString *)groupType
{
    if (dayBetween==0) dayBetween=90;
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthBP?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        
        if ([groupType isEqualToString:@"d"]) {
            urlStr = [urlStr stringByAppendingString:@"&daily=0"];
        } else {
            urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"&grouptype=%@",groupType]];
        }
        
        NSLog(@"get history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get BP History error!");
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncBPNoDataConnection" object:nil];
        } else {
            return xmlData;
        }
    }
    return nil;
}

+(void)syncBPData:(NSInteger)dayBetween groupType:(NSString *)groupType
{
    NSLog(@"dayBetween:%ld groupType:%@",(long)dayBetween,groupType);
    NSData *xmlData = [self getHistoryRecord:dayBetween groupType:groupType];
    
    
    if ([groupType isEqualToString:@"d"]) {
        
        //[syncUtility saveXMLData:BPD xml:xmlData];
        
        [syncBP parserBPData:xmlData groupType:groupType];
        
    }else if([groupType isEqualToString:@"w"]){
        
        //[syncUtility saveXMLData:BPW xml:xmlData];
        
        [syncBP parserBPData:xmlData groupType:groupType];
        
    }else if([groupType isEqualToString:@"m"]){
        
        //[syncUtility saveXMLData:BPM xml:xmlData];
        
        [syncBP parserBPData:xmlData groupType:groupType];
    }
    
    
    //    static NSString *lastRecordFlag = @"//lastrecord";
    //    static NSString *recordsFlag = @"//records";
    //    static NSString *recordFlag = @"//record";
    //    NSString *checktype=@"bp";
    //
    //    // initiate the xml document
    //    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    //
    //    // NSArray lastRecord for <lastrecord>...</lastrecord> in xml document
    //    NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
    //
    //    // iterate every element in <lastrecord>...</lastrecord>
    //    for (DDXMLElement *obj in lastRecord) {
    //
    //        // get content in <systolic> <diastolic> <heartrate> <recordtime>
    //        DDXMLElement *sysElement = [obj elementForName:@"systolic"];
    //        DDXMLElement *diaElement = [obj elementForName:@"diastolic"];
    //        DDXMLElement *heartRateElement = [obj elementForName:@"heartrate"];
    //        DDXMLElement *timeElement = [obj elementForName:@"recordtime"];
    //        DDXMLElement *missElement = [obj elementForName:@"missprevious"];
    //
    //        if (!(
    //            ([[sysElement stringValue]isEqualToString:@"0"]) || ([[[sysElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
    //            ([[diaElement stringValue]isEqualToString:@"0"]) || ([[[diaElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
    //            ([[heartRateElement stringValue]isEqualToString:@"0"]) || ([[[heartRateElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) || ([[sysElement stringValue]length]==0) || ([[diaElement stringValue]length]==0) || ([[heartRateElement stringValue]length]==0)
    //            )) {
    //
    //            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //            NSDate *bpDate_string = [dateFormatter dateFromString:timeElement.stringValue];
    //            long bpDate_long=[bpDate_string timeIntervalSince1970];
    //            NSLog(@"bpDate_long:%ld,timeElement.stringValue:%@,bpDate_string:%@",bpDate_long,timeElement.stringValue,bpDate_string);
    //
    //            // get the string with [DDXMLElement stringValue]
    //            BloodPressure *bpData=[[BloodPressure alloc] initWithSys:[sysElement stringValue] time:bpDate_long dia:[diaElement stringValue] heartrate:[heartRateElement stringValue] status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
    //
    //
    //            bpData.sys=[DBHelper encryptionString:bpData.sys];
    //            bpData.dia=[DBHelper encryptionString:bpData.dia];
    //            bpData.heartrate=[DBHelper encryptionString:bpData.heartrate];
    //
    //
    //            if ([groupType isEqualToString:@"d"]) {
    //
    //                [DBHelper addBPRecord:bpData];
    //            } else if ([groupType isEqualToString:@"m"]) {
    //                DDXMLElement *monthElement = [obj elementForName:@"month"];
    //                NSLog(@"!!monthElement:%@",[monthElement stringValue]);
    //                [DBHelper addBPMonthRecord:bpData month:[monthElement stringValue]];
    //            } else if ([groupType isEqualToString:@"w"]) {
    //                DDXMLElement *weeknoElement = [obj elementForName:@"weekno"];
    //                DDXMLElement *weekstartElement = [obj elementForName:@"weekstart"];
    //                DDXMLElement *weekendElement = [obj elementForName:@"weekend"];
    //                [DBHelper addBPWeekRecord:bpData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
    //            }
    //
    //        }
    //
    //        NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
    //
    //        for (DDXMLElement *obj in records) {
    //            NSArray *record = [obj nodesForXPath:recordFlag error:nil];
    //            for (DDXMLElement *objRecords in record){
    //                if (![objRecords isEqual:[record lastObject]]){
    //                    DDXMLElement *sysElement = [objRecords elementForName:@"systolic"];
    //                    DDXMLElement *diaElement = [objRecords elementForName:@"diastolic"];
    //                    DDXMLElement *heartRateElement = [objRecords elementForName:@"heartrate"];
    //                    DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
    //                    DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
    //
    //                    if (!(
    //                          ([[sysElement stringValue]isEqualToString:@"0"]) || ([[[sysElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
    //                          ([[diaElement stringValue]isEqualToString:@"0"]) || ([[[diaElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
    //                          ([[heartRateElement stringValue]isEqualToString:@"0"]) || ([[[heartRateElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) || ([[sysElement stringValue]length]==0) || ([[diaElement stringValue]length]==0) || ([[heartRateElement stringValue]length]==0)
    //                          )) {
    //
    //                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //                        NSDate *bpDate_string = [dateFormatter dateFromString:timeElement.stringValue];
    //                        long bpDate_long=[bpDate_string timeIntervalSince1970];
    //                        NSLog(@"bpDate_long:%ld,timeElement.stringValue:%@,bpDate_string:%@",bpDate_long,timeElement.stringValue,bpDate_string);
    //
    //                        BloodPressure *bpData=[[BloodPressure alloc] initWithSys:[sysElement stringValue] time:bpDate_long dia:[diaElement stringValue] heartrate:[heartRateElement stringValue] status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
    //
    //                        bpData.sys=[DBHelper encryptionString:bpData.sys];
    //                        bpData.dia=[DBHelper encryptionString:bpData.dia];
    //                        bpData.heartrate=[DBHelper encryptionString:bpData.heartrate];
    //
    //
    //
    //                        if ([groupType isEqualToString:@"d"]) {
    //
    //                            [DBHelper addBPRecord:bpData];
    //                        } else if ([groupType isEqualToString:@"m"]) {
    //                            DDXMLElement *monthElement = [objRecords elementForName:@"month"];
    //                            [DBHelper addBPMonthRecord:bpData month:[monthElement stringValue]];
    //
    //
    //                        } else if ([groupType isEqualToString:@"w"]) {
    //                            DDXMLElement *weeknoElement = [objRecords elementForName:@"weekno"];
    //                            DDXMLElement *weekstartElement = [objRecords elementForName:@"weekstart"];
    //                            DDXMLElement *weekendElement = [objRecords elementForName:@"weekend"];
    //                            [DBHelper addBPWeekRecord:bpData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
    //
    //                        }
    //
    //                    }
    //                }
    //            }
    //        }
    //    }
    //NSLog(@"test again:%@,%@",checktype,groupType);
    
    
}

+ (NSArray *) getAllBPMonthRecord
{
    NSArray *returnArray = [DBHelper getAllBPMonthRecord];
    NSLog(@"returnMonthArray:%@",returnArray);
    return returnArray;
}

+ (NSArray *) getALLBPWeekRecord
{
    NSArray *returnArray = [DBHelper getAllBPWeekRecord];
    NSLog(@"returnWeekArray:%@",returnArray);
    return returnArray;
}

+(void)parserBPData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        //        NSLog(@"path.........%@",[NSString stringWithFormat:@"%@/%@",dataPath,BPD]);
        //        NSLog(@"path.........%@",[NSString stringWithFormat:@"%@/%@",dataPath,BPW]);
        //        NSLog(@"path.........%@",[NSString stringWithFormat:@"%@/%@",dataPath,BPM]);
        //
        //
        //        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BPD]]) {
        //
        //
        //            NSLog(@"file exists........%@",[NSString stringWithFormat:@"%@/%@",dataPath,BPD]);
        //        }
        
        NSData *data30d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BPD]];
        
        NSData *data30w=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BPW]];
        
        NSData *data30m=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BPM]];
        
        //NSLog(@"parser bp...........");
        
        if (data30d!=nil) {
            
            [syncBP parserBPData:data30d groupType:@"d"];
            
            //NSLog(@"parser bp......d.....");
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BPD] error:nil];
            
        }
        
        
        if (data30w!=nil) {
            
            [syncBP parserBPData:data30w groupType:@"w"];
            
            // NSLog(@"parser bp......w.....");
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BPW] error:nil];
            
        }
        
        if (data30m!=nil) {
            
            [syncBP parserBPData:data30m groupType:@"m"];
            
            //NSLog(@"parser bp.......m....");
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BPM] error:nil];
            
        }
        
        
    }
    
}


+(void)parserBPData:(NSData*)xmlData groupType:(NSString *)groupType
{
    
    // static NSString *lastRecordFlag = @"lastrecord";
    static NSString *recordsFlag = @"records";
    static NSString *recordFlag = @"record";
    //NSString *checktype=@"bp";
    
    // initiate the xml document
    //    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    
    // NSArray lastRecord for <lastrecord>...</lastrecord> in xml document
    //    NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
    
    // iterate every element in <lastrecord>...</lastrecord>
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"groupType:%@",groupType);
    
    //NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
    //    NSArray *lastRecord = [rootElement elementsForName:lastRecordFlag];
    //
    //
    //    for (GDataXMLElement *obj in lastRecord) {
    //
    //        // get content in <systolic> <diastolic> <heartrate> <recordtime>
    //        GDataXMLElement *sysElement = [[obj elementsForName:@"systolic"]objectAtIndex:0];
    //        GDataXMLElement *diaElement = [[obj elementsForName:@"diastolic"]objectAtIndex:0];
    //        GDataXMLElement *heartRateElement = [[obj elementsForName:@"heartrate"]objectAtIndex:0];
    //        GDataXMLElement *timeElement = [[obj elementsForName:@"recordtime"]objectAtIndex:0];
    //        GDataXMLElement *missElement = [[obj elementsForName:@"missprevious"]objectAtIndex:0];
    //
    //        if (!(
    //              ([[sysElement stringValue]isEqualToString:@"0"]) || ([[[sysElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
    //              ([[diaElement stringValue]isEqualToString:@"0"]) || ([[[diaElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
    //              ([[heartRateElement stringValue]isEqualToString:@"0"]) || ([[[heartRateElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) || ([[sysElement stringValue]length]==0) || ([[diaElement stringValue]length]==0) || ([[heartRateElement stringValue]length]==0)
    //              )) {
    //
    //            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //            NSDate *bpDate_string = [dateFormatter dateFromString:timeElement.stringValue];
    //            long bpDate_long=[bpDate_string timeIntervalSince1970];
    //            NSLog(@"bpDate_long:%ld,timeElement.stringValue:%@,bpDate_string:%@",bpDate_long,timeElement.stringValue,bpDate_string);
    //
    //            // get the string with [DDXMLElement stringValue]
    //            BloodPressure *bpData=[[BloodPressure alloc] initWithSys:[sysElement stringValue] time:bpDate_long dia:[diaElement stringValue] heartrate:[heartRateElement stringValue] status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
    //
    //
    //            bpData.sys=[DBHelper encryptionString:bpData.sys];
    //            bpData.dia=[DBHelper encryptionString:bpData.dia];
    //            bpData.heartrate=[DBHelper encryptionString:bpData.heartrate];
    //
    //
    //            if ([groupType isEqualToString:@"d"]) {
    //
    //                [DBHelper addBPRecord:bpData];
    //            } else if ([groupType isEqualToString:@"m"]) {
    //                GDataXMLElement *monthElement = [[obj elementsForName:@"month"]objectAtIndex:0];
    //                NSLog(@"!!monthElement:%@",[monthElement stringValue]);
    //                [DBHelper addBPMonthRecord:bpData month:[monthElement stringValue]];
    //            } else if ([groupType isEqualToString:@"w"]) {
    //                GDataXMLElement *weeknoElement = [[obj elementsForName:@"weekno"]objectAtIndex:0];
    //                GDataXMLElement *weekstartElement = [[obj elementsForName:@"weekstart"]objectAtIndex:0];
    //                GDataXMLElement *weekendElement = [[obj elementsForName:@"weekend"]objectAtIndex:0];
    //                [DBHelper addBPWeekRecord:bpData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
    //            }
    //
    //        }
    //
    //
    //    }
    
    //NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
    NSArray *records = [rootElement elementsForName:recordsFlag];
    
    for (GDataXMLElement *obj in records) {
        
        NSArray *record = [obj elementsForName:recordFlag];
        //NSArray *record = [obj nodesForXPath:recordFlag error:nil];
        
        for (GDataXMLElement *objRecords in record){
            // if (![objRecords isEqual:[record lastObject]]){
            GDataXMLElement *sysElement = [[objRecords elementsForName:@"systolic"]objectAtIndex:0];
            GDataXMLElement *diaElement = [[objRecords elementsForName:@"diastolic"]objectAtIndex:0];
            GDataXMLElement *heartRateElement = [[objRecords elementsForName:@"heartrate"]objectAtIndex:0];
            GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
            GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"]objectAtIndex:0];
            
            if (!(
                  ([[sysElement stringValue]isEqualToString:@"0"]) || ([[[sysElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
                  ([[diaElement stringValue]isEqualToString:@"0"]) || ([[[diaElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) ||
                  ([[heartRateElement stringValue]isEqualToString:@"0"]) || ([[[heartRateElement stringValue]lowercaseString]rangeOfString:@"null"].length>0) || ([[sysElement stringValue]length]==0) || ([[diaElement stringValue]length]==0) || ([[heartRateElement stringValue]length]==0)
                  )) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSDate *bpDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                long bpDate_long=[bpDate_string timeIntervalSince1970];
                NSLog(@"bpDate_long:%ld,timeElement.stringValue:%@,bpDate_string:%@",bpDate_long,timeElement.stringValue,bpDate_string);
                
                BloodPressure *bpData=[[BloodPressure alloc] initWithSys:[sysElement stringValue] time:bpDate_long dia:[diaElement stringValue] heartrate:[heartRateElement stringValue] status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
                
                bpData.sys=[DBHelper encryptionString:bpData.sys];
                bpData.dia=[DBHelper encryptionString:bpData.dia];
                bpData.heartrate=[DBHelper encryptionString:bpData.heartrate];
                
                
                
                if ([groupType isEqualToString:@"d"]) {
                    
                    [DBHelper addBPRecord:bpData];
                } else if ([groupType isEqualToString:@"m"]) {
                    GDataXMLElement *monthElement = [[objRecords elementsForName:@"month"]objectAtIndex:0];
                    [DBHelper addBPMonthRecord:bpData month:[monthElement stringValue]];
                    
                    
                } else if ([groupType isEqualToString:@"w"]) {
                    GDataXMLElement *weeknoElement = [[objRecords elementsForName:@"weekno"]objectAtIndex:0];
                    GDataXMLElement *weekstartElement = [[objRecords elementsForName:@"weekstart"]objectAtIndex:0];
                    GDataXMLElement *weekendElement = [[objRecords elementsForName:@"weekend"]objectAtIndex:0];
                    [DBHelper addBPWeekRecord:bpData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
                    
                }
                
            }
            //}
            //}
        }
    }
    
    
    
}

@end
