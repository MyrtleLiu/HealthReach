//
//  SyncAverageChart.m
//  mHealth
//
//  Created by smartone_sn on 14-9-3.
//
//

#import "SyncAverageChart.h"
#import "NSNotificationCenter+MainThread.h"
#import"GDataXMLNode.h"

@implementation SyncAverageChart



+(void)syncAverageChartData{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *updateDateStr = [defaults objectForKey:[NSString stringWithFormat:@"update_date_averagechart_%@",[GlobalVariables shareInstance].login_id]];
    
    NSDate *today=[NSDate date];
    
    

    
    
    if (updateDateStr==nil) {

        //clear old data
        [DBHelper delBPRecordAverageChart];
        [DBHelper delBGAverageChart];
        [DBHelper delWeightAverageChart];
        
//        [SyncAverageChart syncBP30AverageChartData];
//        [SyncAverageChart syncBP90AverageChartData];
//        [SyncAverageChart syncBG30AverageChartData];
//        [SyncAverageChart syncBG90AverageChartData];
//        [SyncAverageChart syncWeight30AverageChartData];
//        [SyncAverageChart syncWeight90AverageChartData];
//        [SyncAverageChart syncCW30AverageChartData];
//        [SyncAverageChart syncCW90AverageChartData];
//        [SyncAverageChart syncTrain30AverageChartData];
//        [SyncAverageChart syncTrain90AverageChartData];
        
        //bg
        NSThread *threadSyncBG30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncBG30AverageChartData) object:nil];
        [threadSyncBG30AverageChartData start];
//        NSThread *threadSyncBG90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncBG90AverageChartData) object:nil];
//        [threadSyncBG90AverageChartData start];
        
        //bp
        NSThread *threadSyncBP30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncBP30AverageChartData) object:nil];
        [threadSyncBP30AverageChartData start];
//        NSThread *threadSyncBP90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncBP90AverageChartData) object:nil];
//        [threadSyncBP90AverageChartData start];
        
        //weight
        NSThread *threadSyncWeight30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncWeight30AverageChartData) object:nil];
        [threadSyncWeight30AverageChartData start];
//        NSThread *threadSyncWeight90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncWeight90AverageChartData) object:nil];
//        [threadSyncWeight90AverageChartData start];
        
        //cw
        NSThread *threadSyncCW30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncCW30AverageChartData) object:nil];
        [threadSyncCW30AverageChartData start];
//        NSThread *threadSyncCW90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncCW90AverageChartData) object:nil];
//        [threadSyncCW90AverageChartData start];
        
        //train
        NSThread *threadSyncTrain30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncTrain30AverageChartData) object:nil];
        [threadSyncTrain30AverageChartData start];
//        NSThread *threadSyncTrain90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncTrain90AverageChartData) object:nil];
//        [threadSyncTrain90AverageChartData start];



        

        [defaults setObject:[dateFormatter stringFromDate:today] forKey:[NSString stringWithFormat:@"update_date_averagechart_%@",[GlobalVariables shareInstance].login_id]];
        
        [defaults synchronize];
    
    
    }else{
        
//        NSDate *update=[dateFormatter dateFromString:updateDateStr];
        
        
//        BOOL result=[Utility isSameDayDate:today theDate:update];
        
        BOOL    result=false;
        if (!result) {
            
            //clear old data
            [DBHelper delBPRecordAverageChart];
            [DBHelper delBGAverageChart];
            [DBHelper delWeightAverageChart];
            
//            [SyncAverageChart syncBP30AverageChartData];
//            [SyncAverageChart syncBP90AverageChartData];
//            [SyncAverageChart syncBG30AverageChartData];
//            [SyncAverageChart syncBG90AverageChartData];
//            [SyncAverageChart syncWeight30AverageChartData];
//            [SyncAverageChart syncWeight90AverageChartData];
//            [SyncAverageChart syncCW30AverageChartData];
//            [SyncAverageChart syncCW90AverageChartData];
//            [SyncAverageChart syncTrain30AverageChartData];
//            [SyncAverageChart syncTrain90AverageChartData];
            
            NSThread *threadSyncBP30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncBP30AverageChartData) object:nil];
            [threadSyncBP30AverageChartData start];
//            NSThread *threadSyncBP90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncBP90AverageChartData) object:nil];
//            [threadSyncBP90AverageChartData start];
            NSThread *threadSyncBG30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncBG30AverageChartData) object:nil];
            [threadSyncBG30AverageChartData start];
//            NSThread *threadSyncBG90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncBG90AverageChartData) object:nil];
//            [threadSyncBG90AverageChartData start];
            NSThread *threadSyncWeight30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncWeight30AverageChartData) object:nil];
            [threadSyncWeight30AverageChartData start];
//            NSThread *threadSyncWeight90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncWeight90AverageChartData) object:nil];
//            [threadSyncWeight90AverageChartData start];
            NSThread *threadSyncCW30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncCW30AverageChartData) object:nil];
            [threadSyncCW30AverageChartData start];
//            NSThread *threadSyncCW90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncCW90AverageChartData) object:nil];
//            [threadSyncCW90AverageChartData start];
            NSThread *threadSyncTrain30AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncTrain30AverageChartData) object:nil];
            [threadSyncTrain30AverageChartData start];
//            NSThread *threadSyncTrain90AverageChartData = [[NSThread alloc]initWithTarget:self selector:@selector(syncTrain90AverageChartData) object:nil];
//            [threadSyncTrain90AverageChartData start];

            
            [defaults setObject:[dateFormatter stringFromDate:today] forKey:[NSString stringWithFormat:@"update_date_averagechart_%@",[GlobalVariables shareInstance].login_id]];
            
            [defaults synchronize];

        }
        
        
        
    }

    
    
    
}

+(void)syncBP30AverageChartData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthBP?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 30]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get BP History error!");
        } else {

            
            //[syncUtility saveXMLData:BP30DA xml:xmlData];
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            // initiate the xml document
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];

            
            GDataXMLElement *rootElement = [doc rootElement];
            
            
            
            //NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
            NSArray *lastRecord = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *obj in lastRecord) {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record){
                    //if (![objRecords isEqual:[record lastObject]]){
                        GDataXMLElement *sysElement = [[objRecords elementsForName:@"systolic"] objectAtIndex:0];
                        GDataXMLElement *diaElement = [[objRecords elementsForName:@"diastolic"] objectAtIndex:0];
                        GDataXMLElement *heartRateElement = [[objRecords elementsForName:@"heartrate"] objectAtIndex:0];
                        GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
                        GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"] objectAtIndex:0];
                        
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSDate *bpDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                        long bpDate_long=[bpDate_string timeIntervalSince1970];
                        NSLog(@"bpDate_long:%ld,timeElement.stringValue:%@,bpDate_string:%@",bpDate_long,timeElement.stringValue,[dateFormatter stringFromDate:bpDate_string]);
                        
                        BloodPressure *bpData=[[BloodPressure alloc] initWithSys:[sysElement stringValue] time:bpDate_long dia:[diaElement stringValue] heartrate:[heartRateElement stringValue] status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
                        
                        [DBHelper addBPRecordAverageChart:bpData];
                    //}
                    
                }
            }

        }
    }
    
    
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthBP?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get BP History error!");
        } else {
            
            
            //[syncUtility saveXMLData:BP90DA xml:xmlData];

            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            // initiate the xml document
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
            
            GDataXMLElement *rootElement = [doc rootElement];
            
            
            
            //NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
            NSArray *lastRecord = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *obj in lastRecord) {
                NSArray *record = [obj elementsForName:recordFlag ];
                for (GDataXMLElement *objRecords in record){
                    //if (![objRecords isEqual:[record lastObject]]){
                    GDataXMLElement *sysElement = [[objRecords elementsForName:@"systolic"] objectAtIndex:0];
                    GDataXMLElement *diaElement = [[objRecords elementsForName:@"diastolic"]objectAtIndex:0];
                    GDataXMLElement *heartRateElement = [[objRecords elementsForName:@"heartrate"]objectAtIndex:0];
                    GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"] objectAtIndex:0];
                    GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"]objectAtIndex:0];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *bpDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                    long bpDate_long=[bpDate_string timeIntervalSince1970];
                    NSLog(@"bpDate_long:%ld,timeElement.stringValue:%@,bpDate_string:%@",bpDate_long,timeElement.stringValue,[dateFormatter stringFromDate:bpDate_string]);
                    
                    BloodPressure *bpData=[[BloodPressure alloc] initWithSys:[sysElement stringValue] time:bpDate_long dia:[diaElement stringValue] heartrate:[heartRateElement stringValue] status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
                    
                    [DBHelper addBPRecordAverageChart:bpData];
                    //}
                    
                }
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
}


+(void)syncBP90AverageChartData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthBP?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get BP History error!");
        } else {
            
            
            [syncUtility saveXMLData:BP90DA xml:xmlData];
            
            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            
//            // initiate the xml document
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//
//            
//            NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *obj in records) {
//                NSArray *record = [obj nodesForXPath:recordFlag error:nil];
//                for (DDXMLElement *objRecords in record){
//                    //if (![objRecords isEqual:[record lastObject]]){
//                        DDXMLElement *sysElement = [objRecords elementForName:@"systolic"];
//                        DDXMLElement *diaElement = [objRecords elementForName:@"diastolic"];
//                        DDXMLElement *heartRateElement = [objRecords elementForName:@"heartrate"];
//                        DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
//                        DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
//                        
//                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                        NSDate *bpDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//                        long bpDate_long=[bpDate_string timeIntervalSince1970];
//                        NSLog(@"bpDate_long:%ld,timeElement.stringValue:%@,bpDate_string:%@",bpDate_long,timeElement.stringValue,bpDate_string);
//                        
//                        BloodPressure *bpData=[[BloodPressure alloc] initWithSys:[sysElement stringValue] time:bpDate_long dia:[diaElement stringValue] heartrate:[heartRateElement stringValue] status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
//                        
//                        [DBHelper addBPRecordAverageChart:bpData];
//                    //}
//                    
//                }
//            }
            
        }
    }
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
}

+(void)syncBG30AverageChartData{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 30]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get BG history sending11 url average....:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
            NSLog(@"Get BG History error!");
        } else {
            
            
            //[syncUtility saveXMLData:BG30DAB xml:xmlData];
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];

             GDataXMLElement *rootElement = [doc rootElement];
            NSArray *records = [rootElement elementsForName :recordsFlag ];
            
            for (GDataXMLElement *obj in records) {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record){
                    //if (![objRecords isEqual:[record lastObject]]){
                    //DDXMLElement *bgElement = [objRecords elementForName:@"bg"];
                    //DDXMLElement *typeELement = [objRecords elementForName:@"type"];
                    GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"] objectAtIndex:0];
                    GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"]objectAtIndex:0];
                    NSString *bgValue = 0;
                    NSString *type = @"";
                    GDataXMLElement *fastingElement = [[objRecords elementsForName:@"fasting"] objectAtIndex:0];
                    GDataXMLElement *afterElement = [[objRecords elementsForName:@"after"] objectAtIndex:0];
                    GDataXMLElement *beforeElement = [[objRecords elementsForName:@"before"] objectAtIndex:0];
                    GDataXMLElement *undefinedElement = [[objRecords elementsForName:@"unspecify"]objectAtIndex:0];
                    // NSLog(@"unspecified:%@",[undefinedElement stringValue]);
                    
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                    long bgDate_long=[bgDate_string timeIntervalSince1970];

                    
                    
                    if ([[fastingElement stringValue]floatValue] > 0) {
                        bgValue = [fastingElement stringValue];
                        
                        type = @"F";
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:bgValue time:bgDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                        
                        
                    }
                    
                    if ([[afterElement stringValue]floatValue] > 0) {
                        bgValue = [afterElement stringValue];
                        
                        type = @"A";
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:bgValue time:bgDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                        
                    }
                    
                    if ([[beforeElement stringValue]floatValue] > 0) {
                        bgValue = [beforeElement stringValue];
                        
                        type = @"B";
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:bgValue time:bgDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                        
                    }
                    
                    if ([[undefinedElement stringValue]floatValue] > 0) {
                        
                        bgValue = [undefinedElement stringValue];
                        
                        type = @"U";
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:bgValue time:bgDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                        
                    }
                    
                    
                    
                    //}
                    
                }
            }
        
        }
    }
    
//    if ([GlobalVariables shareInstance].session_id!=nil){
//        NSString *session_id = [GlobalVariables shareInstance].session_id;
//        NSString *login_id = [GlobalVariables shareInstance].login_id;
//        NSString *urlStr = [[NSString alloc]init];
//        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
//        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
//        if (login_id)
//            urlStr = [urlStr stringByAppendingString:login_id];
//        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&type=A&period="];
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 30]];
//        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
//        if (session_id)
//            urlStr = [urlStr stringByAppendingString:session_id];
//        NSLog(@"get BG history sending11 url:%@",urlStr);
//        NSURL *request_url = [NSURL URLWithString:urlStr];
//        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
//            NSLog(@"Get BG History error!");
//        } else {
//            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *obj in records) {
//                NSArray *record = [obj nodesForXPath:recordFlag error:nil];
//                for (DDXMLElement *objRecords in record){
//                    //if (![objRecords isEqual:[record lastObject]]){
//                    DDXMLElement *bgElement = [objRecords elementForName:@"bg"];
//                    DDXMLElement *typeELement = [objRecords elementForName:@"type"];
//                    DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
//                    DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                    NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//                    long bgDate_long=[bgDate_string timeIntervalSince1970];
//                    
//                    BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
//                    
//                    [DBHelper addBGAverageChartRecord:bgData];
//                    //}
//                    
//                }
//            }
//            
//            
//        }
//    }
//
//    
//    if ([GlobalVariables shareInstance].session_id!=nil){
//        NSString *session_id = [GlobalVariables shareInstance].session_id;
//        NSString *login_id = [GlobalVariables shareInstance].login_id;
//        NSString *urlStr = [[NSString alloc]init];
//        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
//        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
//        if (login_id)
//            urlStr = [urlStr stringByAppendingString:login_id];
//        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&type=F&period="];
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 30]];
//        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
//        if (session_id)
//            urlStr = [urlStr stringByAppendingString:session_id];
//        NSLog(@"get BG history sending11 url:%@",urlStr);
//        NSURL *request_url = [NSURL URLWithString:urlStr];
//        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
//            NSLog(@"Get BG History error!");
//        } else {
//            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *obj in records) {
//                NSArray *record = [obj nodesForXPath:recordFlag error:nil];
//                for (DDXMLElement *objRecords in record){
//                    //if (![objRecords isEqual:[record lastObject]]){
//                    DDXMLElement *bgElement = [objRecords elementForName:@"bg"];
//                    DDXMLElement *typeELement = [objRecords elementForName:@"type"];
//                    DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
//                    DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
//
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                    NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//                    long bgDate_long=[bgDate_string timeIntervalSince1970];
//                    
//                    BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
//                    
//                    [DBHelper addBGAverageChartRecord:bgData];
//                    //}
//                    
//                }
//            }
//            
//            
//        }
//    }
//    
//    
//    if ([GlobalVariables shareInstance].session_id!=nil){
//        NSString *session_id = [GlobalVariables shareInstance].session_id;
//        NSString *login_id = [GlobalVariables shareInstance].login_id;
//        NSString *urlStr = [[NSString alloc]init];
//        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
//        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
//        if (login_id)
//            urlStr = [urlStr stringByAppendingString:login_id];
//        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&type=U&period="];
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 30]];
//        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
//        if (session_id)
//            urlStr = [urlStr stringByAppendingString:session_id];
//        NSLog(@"get BG history sending11 url:%@",urlStr);
//        NSURL *request_url = [NSURL URLWithString:urlStr];
//        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
//            NSLog(@"Get BG History error!");
//        } else {
//            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *obj in records) {
//                NSArray *record = [obj nodesForXPath:recordFlag error:nil];
//                for (DDXMLElement *objRecords in record){
//                    //if (![objRecords isEqual:[record lastObject]]){
//                    DDXMLElement *bgElement = [objRecords elementForName:@"bg"];
//                    DDXMLElement *typeELement = [objRecords elementForName:@"type"];
//                    DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
//                    DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                    NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//                    long bgDate_long=[bgDate_string timeIntervalSince1970];
//                    
//                    BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
//                    
//                    [DBHelper addBGAverageChartRecord:bgData];
//                    //}
//                    
//                }
//            }
//            
    
//        }
//    }
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get BG history sending11 url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
            NSLog(@"Get BG History error!");
        } else {
            
            
            //[syncUtility saveXMLData:BG90DAB xml:xmlData];
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
             GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *records = [rootElement elementsForName:recordsFlag ];
            
            for (GDataXMLElement *obj in records) {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record){
                    //if (![objRecords isEqual:[record lastObject]]){
                    //DDXMLElement *bgElement = [objRecords elementForName:@"bg"];
                    //DDXMLElement *typeELement = [objRecords elementForName:@"type"];
                    GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"] objectAtIndex:0];
                    GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"] objectAtIndex:0];
                    NSString *bgValue = 0;
                    NSString *type = @"";
                    GDataXMLElement *fastingElement = [[objRecords elementsForName:@"fasting"]objectAtIndex:0];
                    GDataXMLElement *afterElement = [[objRecords elementsForName:@"after"] objectAtIndex:0];
                    GDataXMLElement *beforeElement = [[objRecords elementsForName:@"before"]objectAtIndex:0];
                    GDataXMLElement *undefinedElement = [[objRecords elementsForName:@"unspecify"] objectAtIndex:0];
                   // NSLog(@"unspecified:%@",[undefinedElement stringValue]);
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                    long bgDate_long=[bgDate_string timeIntervalSince1970];

                    if ([[fastingElement stringValue]floatValue] > 0) {
                        bgValue = [fastingElement stringValue];
                        
                        type = @"F";
                       
                        
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:bgValue time:bgDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                        
                    }
                    
                    if ([[afterElement stringValue]floatValue] > 0) {
                        bgValue = [afterElement stringValue];
                        
                        type = @"A";
                        
                        
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:bgValue time:bgDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                        
                    }
                    
                    if ([[beforeElement stringValue]floatValue] > 0) {
                        bgValue = [beforeElement stringValue];
                        
                        type = @"B";
                        
                        
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:bgValue time:bgDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                    }
                    
                    if ([[undefinedElement stringValue]floatValue] > 0) {
                        
                        bgValue = [undefinedElement stringValue];
   
                        type = @"U";
                        
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:bgValue time:bgDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:type];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                    }

                    
                    //}
                    
                }
            }

        }
    }
    
 [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];

    
}

+(void)syncBG90AverageChartData{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get BG history sending11 url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
            NSLog(@"Get BG History error!");
        } else {
            
            
            //[syncUtility saveXMLData:BG90DAB xml:xmlData];
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
             GDataXMLElement *rootElement = [doc rootElement];
            NSArray *records = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *obj in records) {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record){
                    //if (![objRecords isEqual:[record lastObject]]){
                        GDataXMLElement *bgElement = [[objRecords elementsForName:@"bg"] objectAtIndex:0];
                        GDataXMLElement *typeELement = [[objRecords elementsForName:@"type"]objectAtIndex:0];
                        GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
                        GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"] objectAtIndex:0];
                        
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                        long bgDate_long=[bgDate_string timeIntervalSince1970];
                        
                        BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
                        
                        [DBHelper addBGAverageChartRecord:bgData];
                    //}
                    
                }
            }
            
            
        }
    }
    
//    if ([GlobalVariables shareInstance].session_id!=nil){
//        NSString *session_id = [GlobalVariables shareInstance].session_id;
//        NSString *login_id = [GlobalVariables shareInstance].login_id;
//        NSString *urlStr = [[NSString alloc]init];
//        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
//        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
//        if (login_id)
//            urlStr = [urlStr stringByAppendingString:login_id];
//        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&type=A&period="];
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
//        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
//        if (session_id)
//            urlStr = [urlStr stringByAppendingString:session_id];
//        NSLog(@"get BG history sending11 url:%@",urlStr);
//        NSURL *request_url = [NSURL URLWithString:urlStr];
//        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
//            NSLog(@"Get BG History error!");
//        } else {
//            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *obj in records) {
//                NSArray *record = [obj nodesForXPath:recordFlag error:nil];
//                for (DDXMLElement *objRecords in record){
//                    //if (![objRecords isEqual:[record lastObject]]){
//                    DDXMLElement *bgElement = [objRecords elementForName:@"bg"];
//                    DDXMLElement *typeELement = [objRecords elementForName:@"type"];
//                    DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
//                    DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                    NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//                    long bgDate_long=[bgDate_string timeIntervalSince1970];
//                    
//                    BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
//                    
//                    [DBHelper addBGAverageChartRecord:bgData];
//                    //}
//                    
//                }
//            }
//            
//            
//        }
//    }
//
//    
//    if ([GlobalVariables shareInstance].session_id!=nil){
//        NSString *session_id = [GlobalVariables shareInstance].session_id;
//        NSString *login_id = [GlobalVariables shareInstance].login_id;
//        NSString *urlStr = [[NSString alloc]init];
//        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
//        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
//        if (login_id)
//            urlStr = [urlStr stringByAppendingString:login_id];
//        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&type=F&period="];
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
//        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
//        if (session_id)
//            urlStr = [urlStr stringByAppendingString:session_id];
//        NSLog(@"get BG history sending11 url:%@",urlStr);
//        NSURL *request_url = [NSURL URLWithString:urlStr];
//        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
//            NSLog(@"Get BG History error!");
//        } else {
//            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *obj in records) {
//                NSArray *record = [obj nodesForXPath:recordFlag error:nil];
//                for (DDXMLElement *objRecords in record){
//                    //if (![objRecords isEqual:[record lastObject]]){
//                    DDXMLElement *bgElement = [objRecords elementForName:@"bg"];
//                    DDXMLElement *typeELement = [objRecords elementForName:@"type"];
//                    DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
//                    DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                    NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//                    long bgDate_long=[bgDate_string timeIntervalSince1970];
//                    
//                    BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
//                    
//                    [DBHelper addBGAverageChartRecord:bgData];
//                    //}
//                    
//                }
//            }
//            
//            
//        }
//    }
//    
//    
//    if ([GlobalVariables shareInstance].session_id!=nil){
//        NSString *session_id = [GlobalVariables shareInstance].session_id;
//        NSString *login_id = [GlobalVariables shareInstance].login_id;
//        NSString *urlStr = [[NSString alloc]init];
//        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
//        urlStr = [urlStr stringByAppendingString:@"healthGlucose?login="];
//        if (login_id)
//            urlStr = [urlStr stringByAppendingString:login_id];
//        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&type=U&period="];
//        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
//        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
//        if (session_id)
//            urlStr = [urlStr stringByAppendingString:session_id];
//        NSLog(@"get BG history sending11 url:%@",urlStr);
//        NSURL *request_url = [NSURL URLWithString:urlStr];
//        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
//            NSLog(@"Get BG History error!");
//        } else {
//            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *obj in records) {
//                NSArray *record = [obj nodesForXPath:recordFlag error:nil];
//                for (DDXMLElement *objRecords in record){
//                    //if (![objRecords isEqual:[record lastObject]]){
//                    DDXMLElement *bgElement = [objRecords elementForName:@"bg"];
//                    DDXMLElement *typeELement = [objRecords elementForName:@"type"];
//                    DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
//                    DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                    NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//                    long bgDate_long=[bgDate_string timeIntervalSince1970];
//                    
//                    BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
//                    
//                    [DBHelper addBGAverageChartRecord:bgData];
//                    //}
//                    
//                }
//            }
//            
//            
//        }
//    }
//

     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
    
}

+(void)syncWeight30AverageChartData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWeight?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 30]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get Weight History error!");
        } else
        {
            
            // [syncUtility saveXMLData:W30DA xml:xmlData];
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *records = [rootElement elementsForName:recordsFlag ];
            
            for (GDataXMLElement *obj in records)
            {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record)
                {
                    //if (![objRecords isEqual:[record lastObject]])
                    //{
                        GDataXMLElement *weightElement = [[objRecords elementsForName:@"weight"] objectAtIndex:0];
                        GDataXMLElement *bmiElement = [[objRecords elementsForName:@"bmi"] objectAtIndex:0];
                        GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
                        GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"] objectAtIndex:0];
                        
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                        NSDate *weightDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                        long weightDate_long=[weightDate_string timeIntervalSince1970];
                        Weight *weightData=[[Weight alloc]initWithWeight:[weightElement stringValue] bmi:[bmiElement stringValue] time:weightDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
                        
                       
                        [DBHelper addWeightAverageChartRecord:weightData];
                    //}
                }
            }
        }
    }
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWeight?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get Weight History error!");
        } else
        {
            
           // [syncUtility saveXMLData:W90DA xml:xmlData];
            
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
             GDataXMLElement *rootElement = [doc rootElement];
            NSArray *records = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *obj in records)
            {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record)
                {
                    //if (![objRecords isEqual:[record lastObject]])
                    //{
                    GDataXMLElement *weightElement = [[objRecords elementsForName:@"weight"] objectAtIndex:0];
                    GDataXMLElement *bmiElement = [[objRecords elementsForName:@"bmi"]objectAtIndex:0];
                    GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
                    GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"]objectAtIndex:0];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *weightDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                    long weightDate_long=[weightDate_string timeIntervalSince1970];
                    Weight *weightData=[[Weight alloc]initWithWeight:[weightElement stringValue] bmi:[bmiElement stringValue] time:weightDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
                    
                    
                    [DBHelper addWeightAverageChartRecord:weightData];
                    //}
                }
            }

        }
    }
    
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
}


+(void)syncWeight90AverageChartData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWeight?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get Weight History error!");
        } else
        {
            
            [syncUtility saveXMLData:W90DA xml:xmlData];
            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *obj in records)
//            {
//                NSArray *record = [obj nodesForXPath:recordFlag error:nil];
//                for (DDXMLElement *objRecords in record)
//                {
//                    //if (![objRecords isEqual:[record lastObject]])
//                    //{
//                        DDXMLElement *weightElement = [objRecords elementForName:@"weight"];
//                        DDXMLElement *bmiElement = [objRecords elementForName:@"bmi"];
//                        DDXMLElement *timeElement = [objRecords elementForName:@"recordtime"];
//                        DDXMLElement *missElement = [objRecords elementForName:@"missprevious"];
//                        
//                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                        NSDate *weightDate_string = [dateFormatter dateFromString:timeElement.stringValue];
//                        long weightDate_long=[weightDate_string timeIntervalSince1970];
//                        Weight *weightData=[[Weight alloc]initWithWeight:[weightElement stringValue] bmi:[bmiElement stringValue] time:weightDate_long status:90 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
//                        
//                        
//                        [DBHelper addWeightAverageChartRecord:weightData];
//                    //}
//                }
//            }
        }
    }
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
}

+(void)syncCW30AverageChartData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        //[DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=2&period=30"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            
           // [syncUtility saveXMLData:CW30DA xml:xmlData];
            
            //[syncUtility XMLHasError:xmlData];
            
            // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
            // NSLog(@"%@====================",xmlStr);

            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
             GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *walkRecords = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *walkRecord in walkRecords) {
                
                NSArray *walks = [walkRecord elementsForName:recordFlag];
                
                for (GDataXMLElement *walk in walks){
                    
                    
                    GDataXMLElement *trainid = [[walk elementsForName:@"trainid"] objectAtIndex:0];
                    GDataXMLElement *recordid = [[walk elementsForName:@"recordid"]objectAtIndex:0];
                    GDataXMLElement *foodlist = [[walk elementsForName:@"foodlist"]objectAtIndex:0];
                    GDataXMLElement *duration = [[walk elementsForName:@"duration"]objectAtIndex:0];
                    GDataXMLElement *steps = [[walk elementsForName:@"steps"]objectAtIndex:0];
                    GDataXMLElement *meters = [[walk elementsForName:@"meters"]objectAtIndex:0];
                    GDataXMLElement *caloburnt = [[walk elementsForName:@"caloburnt"]objectAtIndex:0];
                    GDataXMLElement *calotarget = [[walk elementsForName:@"calotarget"]objectAtIndex:0];
                    GDataXMLElement *result = [[walk elementsForName:@"result"]objectAtIndex:0];
                    
                    //DDXMLElement *target = [walk elementForName:@"target"];
                    GDataXMLElement *recordtime = [[walk elementsForName:@"recordtime"] objectAtIndex:0];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
                    long date_long=[date_string timeIntervalSince1970];
                    

                    
                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:@"" route:@"" recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:30 persistime:[duration.stringValue integerValue]];
                    
                    [DBHelper addWalkingCWAverageChartRecord:walking];
                    
                }
                
                
            }

        }
        
        
    }
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        //[DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=2&period=90"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
           // [syncUtility saveXMLData:CW90DA xml:xmlData];
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
             GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *walkRecords = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *walkRecord in walkRecords) {
                
                NSArray *walks = [walkRecord elementsForName:recordFlag];
                
                for (GDataXMLElement *walk in walks){
                    
                    
                    GDataXMLElement *trainid = [[walk elementsForName:@"trainid"] objectAtIndex:0];
                    GDataXMLElement *recordid = [[walk elementsForName:@"recordid"] objectAtIndex:0];
                    GDataXMLElement *foodlist = [[walk elementsForName:@"foodlist"]objectAtIndex:0];
                    GDataXMLElement *duration = [[walk elementsForName:@"duration"]objectAtIndex:0];
                    GDataXMLElement *steps = [[walk elementsForName:@"steps"]objectAtIndex:0];
                    GDataXMLElement *meters = [[walk elementsForName:@"meters"]objectAtIndex:0];
                    GDataXMLElement *caloburnt = [[walk elementsForName:@"caloburnt"]objectAtIndex:0];
                    GDataXMLElement *calotarget = [[walk elementsForName:@"calotarget"]objectAtIndex:0];
                    GDataXMLElement *result = [[walk elementsForName:@"result"]objectAtIndex:0];
                    
                    //DDXMLElement *target = [walk elementForName:@"target"];
                    GDataXMLElement *recordtime = [[walk elementsForName:@"recordtime"]objectAtIndex:0];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
                    long date_long=[date_string timeIntervalSince1970];
                    
                    
                    
                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:@"" route:@"" recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:90 persistime:[duration.stringValue integerValue]];
                    
                    [DBHelper addWalkingCWAverageChartRecord:walking];
                    
                }
                
                
            }

        }
    }

     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
}

+(void)syncCW90AverageChartData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        //[DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=2&period=90"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility saveXMLData:CW90DA xml:xmlData];
            
//            [syncUtility XMLHasError:xmlData];
//            
//            // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
//            
//            // NSLog(@"%@====================",xmlStr);
//            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            // static NSString *causalwalkFlag = @"//causalwalk";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            
//            NSArray *walkRecords = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *walkRecord in walkRecords) {
//                
//                NSArray *walks = [walkRecord nodesForXPath:recordFlag error:nil];
//                
//                for (DDXMLElement *walk in walks){
//                    
//                    
//                    DDXMLElement *trainid = [walk elementForName:@"trainid"];
//                    DDXMLElement *recordid = [walk elementForName:@"recordid"];
//                    DDXMLElement *foodlist = [walk elementForName:@"foodlist"];
//                    DDXMLElement *duration = [walk elementForName:@"duration"];
//                    DDXMLElement *steps = [walk elementForName:@"steps"];
//                    DDXMLElement *meters = [walk elementForName:@"meters"];
//                    DDXMLElement *caloburnt = [walk elementForName:@"caloburnt"];
//                    DDXMLElement *calotarget = [walk elementForName:@"calotarget"];
//                    DDXMLElement *result = [walk elementForName:@"result"];
//                    
//                    //DDXMLElement *target = [walk elementForName:@"target"];
//                    DDXMLElement *recordtime = [walk elementForName:@"recordtime"];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
//                    long date_long=[date_string timeIntervalSince1970];
//                    
//                    
//                    
//                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:@"" route:@"" recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:90 persistime:[duration.stringValue integerValue]];
//                    
//                    [DBHelper addWalkingCWAverageChartRecord:walking];
//                    
//                }
//                
//                
//            }
            
        }
        
        
    }
    
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
}

+(void)syncTrain30AverageChartData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        //[DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period=30"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            //[syncUtility XMLHasError:xmlData];
            
           //            [syncUtility saveXMLData:TP30DA xml:xmlData];
//            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
             GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *walkRecords = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *walkRecord in walkRecords) {
                
                NSArray *walks = [walkRecord elementsForName:recordFlag];
                
                for (GDataXMLElement *walk in walks){
                    
                    
                    GDataXMLElement *trainid = [[walk elementsForName:@"trainid"]objectAtIndex:0];
                    GDataXMLElement *recordid = [[walk elementsForName:@"recordid"]objectAtIndex:0];
                    GDataXMLElement *foodlist = [[walk elementsForName:@"foodlist"]objectAtIndex:0];
                    GDataXMLElement *duration = [[walk elementsForName:@"duration"]objectAtIndex:0];
                    GDataXMLElement *steps = [[walk elementsForName:@"steps"]objectAtIndex:0];
                    GDataXMLElement *meters = [[walk elementsForName:@"meters"]objectAtIndex:0];
                    GDataXMLElement *caloburnt = [[walk elementsForName:@"caloburnt"]objectAtIndex:0];
                    GDataXMLElement *calotarget = [[walk elementsForName:@"calotarget"]objectAtIndex:0];
                    GDataXMLElement *result = [[walk elementsForName:@"result"]objectAtIndex:0];
                    
                    //DDXMLElement *target = [walk elementForName:@"target"];
                    GDataXMLElement *recordtime = [[walk elementsForName:@"recordtime"]objectAtIndex:0];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
                    long date_long=[date_string timeIntervalSince1970];
                    
                    
                    
                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:@"" route:@"" recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:30 persistime:[duration.stringValue integerValue]];
                    
                    [DBHelper addWalkingTrainAverageChartRecord:walking];
                    
                    
                }
                
                
            }
            
        }
        
        
    }
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        //[DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period=90"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            //[syncUtility XMLHasError:xmlData];
            
            // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
            // NSLog(@"%@====================",xmlStr);
            
            //[syncUtility saveXMLData:TP90DA xml:xmlData];
            
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
             GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *walkRecords = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *walkRecord in walkRecords) {
                
                NSArray *walks = [walkRecord elementsForName:recordFlag];
                
                for (GDataXMLElement *walk in walks){
                    
                    
                    GDataXMLElement *trainid = [[walk elementsForName:@"trainid"] objectAtIndex:0];
                    GDataXMLElement *recordid = [[walk elementsForName:@"recordid"]objectAtIndex:0];
                    GDataXMLElement *foodlist = [[walk elementsForName:@"foodlist"]objectAtIndex:0];
                    GDataXMLElement *duration = [[walk elementsForName:@"duration"]objectAtIndex:0];
                    GDataXMLElement *steps = [[walk elementsForName:@"steps"]objectAtIndex:0];
                    GDataXMLElement *meters = [[walk elementsForName:@"meters"]objectAtIndex:0];
                    GDataXMLElement *caloburnt = [[walk elementsForName:@"caloburnt"]objectAtIndex:0];
                    GDataXMLElement *calotarget = [[walk elementsForName:@"calotarget"]objectAtIndex:0];
                    GDataXMLElement *result = [[walk elementsForName:@"result"]objectAtIndex:0];
                    
                    //DDXMLElement *target = [walk elementForName:@"target"];
                    GDataXMLElement *recordtime = [[walk elementsForName:@"recordtime"]objectAtIndex:0];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
                    long date_long=[date_string timeIntervalSince1970];
                    
                    
                    
                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:@"" route:@"" recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:90 persistime:[duration.stringValue integerValue]];
                    
                    [DBHelper addWalkingTrainAverageChartRecord:walking];
                    
                }
                
                
            }

        }
    }
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
    
    
}

+(void)syncTrain90AverageChartData{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        //[DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&daily=1&period=90"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            //[syncUtility XMLHasError:xmlData];
            
            // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
            // NSLog(@"%@====================",xmlStr);
            
            [syncUtility saveXMLData:TP90DA xml:xmlData];
            
//            static NSString *recordsFlag = @"//records";
//            static NSString *recordFlag = @"//record";
//            // static NSString *causalwalkFlag = @"//causalwalk";
//            
//            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
//            
//            
//            
//            NSArray *walkRecords = [doc nodesForXPath:recordsFlag error:nil];
//            
//            for (DDXMLElement *walkRecord in walkRecords) {
//                
//                NSArray *walks = [walkRecord nodesForXPath:recordFlag error:nil];
//                
//                for (DDXMLElement *walk in walks){
//                    
//                    
//                    DDXMLElement *trainid = [walk elementForName:@"trainid"];
//                    DDXMLElement *recordid = [walk elementForName:@"recordid"];
//                    DDXMLElement *foodlist = [walk elementForName:@"foodlist"];
//                    DDXMLElement *duration = [walk elementForName:@"duration"];
//                    DDXMLElement *steps = [walk elementForName:@"steps"];
//                    DDXMLElement *meters = [walk elementForName:@"meters"];
//                    DDXMLElement *caloburnt = [walk elementForName:@"caloburnt"];
//                    DDXMLElement *calotarget = [walk elementForName:@"calotarget"];
//                    DDXMLElement *result = [walk elementForName:@"result"];
//                    
//                    //DDXMLElement *target = [walk elementForName:@"target"];
//                    DDXMLElement *recordtime = [walk elementForName:@"recordtime"];
//                    
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
//                    long date_long=[date_string timeIntervalSince1970];
//                    
//                    
//                    
//                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:@"" route:@"" recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:90 persistime:[duration.stringValue integerValue]];
//                    
//                    [DBHelper addWalkingTrainAverageChartRecord:walking];
//                    
//                }
//                
//                
//            }
            
        }
        
        
    }
     [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getDataFromChatAPI" object:nil];
}

@end
