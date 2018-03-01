//
//  syncWeight.m
//  mHealth
//
//  Created by sngz on 14-3-19.
//
//

#import "syncWeight.h"
#import "DBHelper.h"
#import "GlobalVariables.h"
#import "DDXMLElementAdditions.h"
#import "DDXMLDocument.h"
#import "Constants.h"
#import "FMResultSet.h"
#import "Utility.h"
#import "Weight.h"
#import "syncUtility.h"
#import "NSNotificationCenter+MainThread.h"
#import"GDataXMLNode.h"
@implementation syncWeight

+(void)syncAllWeightData:(NSString *)newestWeightDate_Server;
{
    [self uploadData];
    //[self syncWeightMonthAndWeekData];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *newestWeightDate_DB = [DBHelper getNewestWeightDate_DB];
    long temp =(long)(newestWeightDate_DB);
    newestWeightDate_DB = [[NSString formatTimeAgo:temp] substringToIndex:10];
    if (newestWeightDate_DB.length>=10)
        newestWeightDate_DB = [newestWeightDate_DB substringToIndex:10];
    else {
        [newestWeightDate_DB uppercaseString];
        if ([newestWeightDate_DB isEqualToString:@""] || ([newestWeightDate_DB rangeOfString:@"NULL"].length>0)){
            newestWeightDate_DB = @"1900-01-01";
        } else {
            NSLog(@"trimming newestWeightDate_DB error! newestWeightDate_DB:%@",newestWeightDate_DB);
            [[NSNotificationCenter defaultCenter]postMainThreadNotificationWithName:@"SyncWeightError" object:nil];
            return;
        }
    }
    NSDate *weightDate_DB = [dateFormatter dateFromString:newestWeightDate_DB];
    
    //    NSString *newestWeightDate_Server = [self getNewestWeightDate_Server];
    if (newestWeightDate_Server.length>=10)
        newestWeightDate_Server = [newestWeightDate_Server substringToIndex:10];
    else {
        
        
        [[NSNotificationCenter defaultCenter]postMainThreadNotificationWithName:@"SyncWeightError" object:nil];
        return;
    }
    NSDate *weightDate_Server = [dateFormatter dateFromString:newestWeightDate_Server];
    
    NSInteger dayBetween = ([weightDate_Server timeIntervalSince1970]*1 - [weightDate_DB timeIntervalSince1970]*1)/86400;
    //vaycent edit
    dayBetween=1;
    //======
    
    if (dayBetween==0) {
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncWeightFinish" object:nil];
    }
    if (dayBetween>0)
    {
        NSLog(@"Downloading Weight records from server,%ld days not sync.",(long)dayBetween);
        [self syncWeightData:dayBetween groupType:@"d"];
    } else {
        NSLog(@"Weight records are up to date");
    }
    
    //    [self uploadData];
    
    //    [self getAllWeightMonthRecord];
    //    [self getALLWeightWeekRecord];
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncWeightFinish" object:nil];
}

+ (void)syncWeightMonthAndWeekData
{
    [self syncWeightData:150 groupType:@"w"];
    [DBHelper generateWeightBlankMonthRecords];
    [self syncWeightData:150 groupType:@"m"];
    [DBHelper generateWeightBlankWeekRecords];
}
//+(NSString *)getNewestWeightDate_Server
//{
//    NSString *dateString = [[NSString alloc]init];
//    NSData *xmlData = [self getHistoryRecord:360];
//    static NSString *lastRecordFlag = @"//lastrecord";
//	DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//    NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
//	for (DDXMLElement *obj in lastRecord)
//    {
//        DDXMLElement *timeElement = [obj elementForName:@"recordtime"];
//        if (timeElement)
//            dateString = timeElement.stringValue;
//    }
//    return dateString;
//
//}

+(NSData *)getWeightRecord:(NSInteger)dayBetween
{
    return nil;
}

+(void)syncWeightData:(NSInteger)dayBetween groupType:(NSString *)groupType
{
    
    NSLog(@"dayBetween:%ld",(long)dayBetween);
    NSData *xmlData = [self getHistoryRecord:dayBetween groupType:groupType];
    
    
    if ([groupType isEqualToString:@"d"]) {
        
        //[syncUtility saveXMLData:WEIGHTD xml:xmlData];
        
        [syncWeight parserWeightData:xmlData groupType:groupType];
        
    }else if([groupType isEqualToString:@"w"]){
        
        //[syncUtility saveXMLData:WEIGHTW xml:xmlData];
        
        [syncWeight parserWeightData:xmlData groupType:groupType];
        
    }else if([groupType isEqualToString:@"m"]){
        
        //[syncUtility saveXMLData:WEIGHTM xml:xmlData];
        
        [syncWeight parserWeightData:xmlData groupType:groupType];
    }
    
    
    
    //    static NSString *lastRecordFlag = @"//lastrecord";
    //    static NSString *recordsFlag = @"//records";
    //    static NSString *recordFlag = @"//record";
    //    NSString *checktype=@"weight";
    //
    //    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    //    NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
    //
    //    for (DDXMLElement *obj in lastRecord)
    //    {
    //        DDXMLElement *weightElement = [obj elementForName:@"weight"];
    //        DDXMLElement *bmiElement = [obj elementForName:@"bmi"];
    //        DDXMLElement *timeElement = [obj elementForName:@"recordtime"];
    //        DDXMLElement *missElement = [obj elementForName:@"missprevious"];
    //
    //        if (!(([[weightElement stringValue]isEqualToString:@"0"]) || ([[[weightElement stringValue] lowercaseString]rangeOfString:@"null"].length>0) || ([[weightElement stringValue]length]==0)))
    //
    //        {
    //
    //            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //            NSDate *weightDate_string = [dateFormatter dateFromString:timeElement.stringValue];
    //            long weightDate_long=[weightDate_string timeIntervalSince1970];
    //
    //            Weight *weightData=[[Weight alloc]initWithWeight:weightElement.stringValue bmi:bmiElement.stringValue time:weightDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
    //
    //
    //
    //            weightData.weight=[DBHelper encryptionString:weightData.weight];
    //            weightData.bmi=[DBHelper encryptionString:weightData.bmi];
    //
    //
    //
    //            if ([groupType isEqualToString:@"d"]) {
    //                [DBHelper addWeightRecord:weightData];
    //            } else if ([groupType isEqualToString:@"m"]) {
    //                DDXMLElement *monthElement = [obj elementForName:@"month"];
    //                [DBHelper addWeightMonthRecord:weightData month:[monthElement stringValue]];
    //            } else if ([groupType isEqualToString:@"w"]) {
    //                DDXMLElement *weeknoElement = [obj elementForName:@"weekno"];
    //                DDXMLElement *weekstartElement = [obj elementForName:@"weekstart"];
    //                DDXMLElement *weekendElement = [obj elementForName:@"weekend"];
    //                [DBHelper addWeightWeekRecord:weightData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
    //            }
    //        }
    //
    //        NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
    //
    //        for (DDXMLElement *obj in records)
    //        {
    //            NSArray *record = [obj nodesForXPath:recordFlag error:nil];
    //            for (DDXMLElement *objRecords in record)
    //            {
    //                if (![objRecords isEqual:[record lastObject]])
    //                {
    //                    DDXMLElement *weightElement = [objRecords elementForName:@"weight"];
    //                    DDXMLElement *bmiElement = [objRecords elementForName:@"bmi"];
    //                    DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
    //                    DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
    //
    //                    if (!(([[weightElement stringValue]isEqualToString:@"0"]) || ([[[weightElement stringValue] lowercaseString]rangeOfString:@"null"].length>0) || ([[weightElement stringValue]length]==0)))
    //
    //                    {
    //
    //                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //                        NSDate *weightDate_string = [dateFormatter dateFromString:timeElement.stringValue];
    //                        long weightDate_long=[weightDate_string timeIntervalSince1970];
    //                        Weight *weightData=[[Weight alloc]initWithWeight:[weightElement stringValue] bmi:[bmiElement stringValue] time:weightDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
    //
    //                        NSLog(@"!!addingWeightRecord:%@",weightData);
    //
    //
    //                        weightData.weight=[DBHelper encryptionString:weightData.weight];
    //                        weightData.bmi=[DBHelper encryptionString:weightData.bmi];
    //
    //
    //                        if ([groupType isEqualToString:@"d"]) {
    //                            [DBHelper addWeightRecord:weightData];
    //                        } else if ([groupType isEqualToString:@"m"]) {
    //                            DDXMLElement *monthElement = [objRecords elementForName:@"month"];
    //                            [DBHelper addWeightMonthRecord:weightData month:[monthElement stringValue]];
    //                        } else if ([groupType isEqualToString:@"w"]) {
    //                            DDXMLElement *weeknoElement = [objRecords elementForName:@"weekno"];
    //                            DDXMLElement *weekstartElement = [objRecords elementForName:@"weekstart"];
    //                            DDXMLElement *weekendElement = [objRecords elementForName:@"weekend"];
    //                            [DBHelper addWeightWeekRecord:weightData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    // NSLog(@"test again:%@,%@",checktype,groupType);
    
    
}

+(NSData *)getHistoryRecord:(NSInteger)dayBetween groupType:(NSString *)groupType
{
    if (dayBetween==0) dayBetween=90;
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWeight?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d",90]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get history sending url:%@",urlStr);
        
        if ([groupType isEqualToString:@"d"]) {
            urlStr = [urlStr stringByAppendingString:@"&daily=0"];
        } else {
            urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"&grouptype=%@",groupType]];
        }
        
        NSLog(@"!!weight request_url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get Weight History error!");
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncWeightNoDataConnection" object:nil];
        } else
        {
            return xmlData;
        }
    }
    return nil;
}

+(void)uploadData{
    NSString *latestWeightString = @"";
    
    Weight *weightRecord = [[Weight alloc]init];
    NSMutableArray *recordArray = [DBHelper getWeightNotUpload];
    NSLog(@"return recordArray:%@",recordArray);
    for (NSDictionary *weightRecordDict in recordArray){
        NSString *weightStr = [NSString stringWithFormat:@"%@",[weightRecordDict valueForKey:@"weight"]];
        weightRecord = [weightRecord initWithWeight:weightStr
                                                bmi:[weightRecordDict valueForKey:@"bmi"]
                                               time:(long)[[NSString stringWithFormat:@"%@",[weightRecordDict objectForKey:@"recordtime"]] longLongValue]
                                             status:[[weightRecordDict objectForKey:@"status"] intValue]
                                       missprevious:[[weightRecordDict objectForKey:@"missprevious"] intValue]];
        [self sendResult:weightRecord];
        latestWeightString = [weightRecord weight];
    }
    
}

+ (void)sendResult:(Weight *)weightRecord{
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthWeight?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&action=A&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&weight="];
    url_string = [url_string stringByAppendingString:[weightRecord weight]];
    url_string = [url_string stringByAppendingString:@"&recordtime="];
    url_string = [url_string stringByAppendingString:[Utility inURLFormat:[weightRecord timeStr]]];
    
    NSLog(@"Weight sending url:%@",url_string);
    NSURL *request_url = [NSURL URLWithString:url_string];
    NSLog(@"request_url:%@",request_url);
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    if (xmlData){
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"is upload Weight record successfully:%d",isSucc);
        if (isSucc) {
            weightRecord.status = 0;
            
            weightRecord.weight=[DBHelper encryptionString:weightRecord.weight];
            weightRecord.bmi=[DBHelper encryptionString:weightRecord.bmi];
            
            [DBHelper addWeightRecord:weightRecord];
        }
    }
    
}

+ (NSArray *) getAllWeightMonthRecord
{
    NSArray *returnArray = [DBHelper getAllWeightMonthRecord];
    NSLog(@"returnMonthArray:%@",returnArray);
    return returnArray;
}

+ (NSArray *) getALLWeightWeekRecord
{
    NSArray *returnArray = [DBHelper getAllWeightWeekRecord];
    NSLog(@"returnWeekArray:%@",returnArray);
    return returnArray;
}


+(void)parserWeightData:(NSData*)xmlData groupType:(NSString *)groupType{
    
    static NSString *lastRecordFlag = @"lastrecord";
    static NSString *recordsFlag = @"records";
    static NSString *recordFlag = @"record";
    //NSString *checktype=@"weight";
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    NSLog(@"docdocdoc=%@",doc);
    GDataXMLElement *rootElement = [doc rootElement];
    
    NSLog(@"groupType:%@",groupType);
    
    //NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
    NSArray *lastRecord = [rootElement elementsForName:lastRecordFlag];
    NSLog(@"lastRecord=%@",lastRecord);
//    for (GDataXMLElement *obj in lastRecord)
//    {
//        GDataXMLElement *weightElement = [[obj elementsForName:@"weight"] objectAtIndex:0];
//        GDataXMLElement *bmiElement = [[obj elementsForName:@"bmi"] objectAtIndex:0];
//        GDataXMLElement *timeElement = [[obj elementsForName:@"recordtime"] objectAtIndex:0];
//        GDataXMLElement *missElement = [[obj elementsForName:@"missprevious"] objectAtIndex:0];
//        
//        if (!(([[weightElement stringValue]isEqualToString:@"0"]) || ([[[weightElement stringValue] lowercaseString]rangeOfString:@"null"].length>0) || ([[weightElement stringValue]length]==0)))
//            
//        {
//            
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//            NSDate *weightDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//            long weightDate_long=[weightDate_string timeIntervalSince1970];
//            
//            Weight *weightData=[[Weight alloc]initWithWeight:weightElement.stringValue bmi:bmiElement.stringValue time:weightDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
//            
//            
//            
//            weightData.weight=[DBHelper encryptionString:weightData.weight];
//            weightData.bmi=[DBHelper encryptionString:weightData.bmi];
//            
//            
//            
//            if ([groupType isEqualToString:@"d"]) {
//                [DBHelper addWeightRecord:weightData];
//            } else if ([groupType isEqualToString:@"m"]) {
//                GDataXMLElement *monthElement = [[obj elementsForName:@"month"] objectAtIndex:0];
//                [DBHelper addWeightMonthRecord:weightData month:[monthElement stringValue]];
//            } else if ([groupType isEqualToString:@"w"]) {
//                GDataXMLElement *weeknoElement = [[obj elementsForName:@"weekno"] objectAtIndex:0];
//                GDataXMLElement *weekstartElement = [[obj elementsForName:@"weekstart"] objectAtIndex:0];
//                GDataXMLElement *weekendElement = [[obj elementsForName:@"weekend"] objectAtIndex:0];
//                [DBHelper addWeightWeekRecord:weightData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
//            }
//        }
        
        //NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
        NSArray *Records = [rootElement elementsForName:recordsFlag];
        
        for (GDataXMLElement *obj in Records)
        {
            NSArray *record = [obj elementsForName:recordFlag];
            for (GDataXMLElement *objRecords in record)
            {
//                if (![objRecords isEqual:[record lastObject]])
//                {
                    GDataXMLElement *weightElement = [[objRecords elementsForName:@"weight"] objectAtIndex:0];
                    GDataXMLElement *bmiElement = [[objRecords elementsForName:@"bmi"] objectAtIndex:0];
                    GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"] objectAtIndex:0];
                    GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"] objectAtIndex:0];
                    
                    if (!(([[weightElement stringValue]isEqualToString:@"0"]) || ([[[weightElement stringValue] lowercaseString]rangeOfString:@"null"].length>0) || ([[weightElement stringValue]length]==0)))
                        
                    {
                        
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSDate *weightDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                        long weightDate_long=[weightDate_string timeIntervalSince1970];
                        Weight *weightData=[[Weight alloc]initWithWeight:[weightElement stringValue] bmi:[bmiElement stringValue] time:weightDate_long status:0 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
                        
                        NSLog(@"!!addingWeightRecord:%@",weightData);
                        
                        
                        weightData.weight=[DBHelper encryptionString:weightData.weight];
                        weightData.bmi=[DBHelper encryptionString:weightData.bmi];
                        
                        
                        if ([groupType isEqualToString:@"d"]) {
                            [DBHelper addWeightRecord:weightData];
                        } else if ([groupType isEqualToString:@"m"]) {
                            GDataXMLElement *monthElement = [[objRecords elementsForName:@"month"] objectAtIndex:0];
                            [DBHelper addWeightMonthRecord:weightData month:[monthElement stringValue]];
                        } else if ([groupType isEqualToString:@"w"]) {
                            GDataXMLElement *weeknoElement = [[objRecords elementsForName:@"weekno"] objectAtIndex:0];
                            GDataXMLElement *weekstartElement = [[objRecords elementsForName:@"weekstart"]objectAtIndex:0];
                            GDataXMLElement *weekendElement = [[objRecords elementsForName:@"weekend"] objectAtIndex:0];
                            [DBHelper addWeightWeekRecord:weightData weekno:[weeknoElement stringValue] weekstart:[weekstartElement stringValue] weekend:[weekendElement stringValue]];
                        }
                    }
//                }
            }
        }
//    }
    
}

+(void)parserWeightData{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        NSData *data30d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTD]];
        
        NSData *data30w=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTW]];
        
        NSData *data30m=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTM]];
        
        
        if (data30d!=nil) {
            
            [syncWeight parserWeightData:data30d groupType:@"d"];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTD] error:nil];
            
        }
        
        
        if (data30w!=nil) {
            
            [syncWeight parserWeightData:data30w groupType:@"w"];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTW] error:nil];
            
        }
        
        if (data30m!=nil) {
            
            [syncWeight parserWeightData:data30m groupType:@"m"];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,WEIGHTM] error:nil];
            
        }
        
        
    }
    
}

@end
