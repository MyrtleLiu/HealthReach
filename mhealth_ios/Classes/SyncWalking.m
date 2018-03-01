//
//  SyncWalking.m
//  mHealth
//
//  Created by smartone_sn on 14-8-12.
//
//

#import "SyncWalking.h"
#import "NSString+URLEncoding.h"
#import "syncUtility.h"
#import "PedometerViewController.h"
#import "NSNotificationCenter+MainThread.h"
#import "GDataXMLNode.h"



@implementation SyncWalking


+(void)syncAllWalkingData{
    
    
    
    NSMutableArray *temArray=[DBHelper getCWRecordDate:0 enddate:0 type:-3];
    for (int i=0; i<[temArray count]; i++) {
        WalkingRecord *result = [temArray objectAtIndex:i];
        [result setType:(0)];
        if(result.plannedRoutePoints.count>0){
            NSLog(@"result.route:%@",result.route);
        }
        [SyncWalking addWalkingRcord:result];
        
        result.steps=[DBHelper encryptionString:result.steps];
        result.distance=[DBHelper encryptionString:result.distance];
        result.calsburnt=[DBHelper encryptionString:result.calsburnt];
        result.persistimeStr=[DBHelper encryptionString:result.persistimeStr];
        
        
        [DBHelper addWalkingRecord:result];
    }
    
    NSMutableArray *temArray2=[DBHelper getCWRecordDate:0 enddate:0 type:-4];
    for (int i=0; i<[temArray2 count]; i++) {
        WalkingRecord *result = [temArray2 objectAtIndex:i];
        [result setType:(1)];
        [SyncWalking addWalkingRcord:result];
        
        result.steps=[DBHelper encryptionString:result.steps];
        result.distance=[DBHelper encryptionString:result.distance];
        result.calsburnt=[DBHelper encryptionString:result.calsburnt];
        result.persistimeStr=[DBHelper encryptionString:result.persistimeStr];
        
        
        [DBHelper addWalkingRecord:result];
    }
    
    
    
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *serverUpdateDate = [defaults objectForKey:[NSString stringWithFormat:@"server_update_date_K_%@",[GlobalVariables shareInstance].login_id]];//[defaults objectForKey:@"server_update_date_K"];
    
    //vaycent edit
    //    if (serverUpdateDate==nil) {
    //        NSLog(@"come to test 1 ");
    //        [SyncWalking getAllWalkingRecord];
    //        return;
    //    }
    
    NSDate *serverDate = [dateFormatter dateFromString:serverUpdateDate];
    
    
    NSString *localUpdateDate=[defaults objectForKey:[NSString stringWithFormat:@"walking_update_date_%@",[GlobalVariables shareInstance].login_id]];
    
    //vaycent edit
    //    if (localUpdateDate==nil) {
    //        NSLog(@"come to test 2 ");
    //
    //        [SyncWalking getAllWalkingRecord];
    //        return;
    //    }
    
    
    NSDate *localDate = [dateFormatter dateFromString:localUpdateDate];
    
    //    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
    //                                                        fromDate:localDate
    //                                                          toDate:serverDate
    //                                                         options:0];
    
    //NSLog(@"the date.....%@...............%@",localDate,serverDate);
    
    
    //    long minutes=[components minute];
    
    //NSLog(@"the mini..........%ld",minutes);
    
    
    NSLog(@"test [serverDate timeIntervalSince1970] : %f",[serverDate timeIntervalSince1970]);
    NSLog(@"test [localDate timeIntervalSince1970] : %f",[localDate timeIntervalSince1970]);
    
    
    //vaycent edit
    //    if (([serverDate timeIntervalSince1970]-[localDate timeIntervalSince1970]>0)) {
    //        NSLog(@"come to test 3 ");
    //
    //        [SyncWalking getAllWalkingRecord];
    //    }
    
    
    [SyncWalking getAllWalkingRecord];
    
    
}


+ (TrainingRecord *)getAllWalkingRecord{
    NSLog(@"check if it run : %@",[GlobalVariables shareInstance].session_id );
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        [DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RT"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSLog(@"check the time 1");
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
            // NSLog(@"%@====================",xmlStr);
            
            static NSString *trainingsFlag = @"//trainings";
            static NSString *trainingFlag = @"//training";
            static NSString *recordsFlag = @"//causalwalk";
            static NSString *recordFlag = @"//record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
            
            NSArray *trainingsRecord = [doc nodesForXPath:trainingsFlag error:nil];
            
            
            
            NSLog(@"check the time 2");
            
            
            for (DDXMLElement *obj in trainingsRecord) {
                
                NSArray *records = [obj nodesForXPath:trainingFlag error:nil];
                
                for (DDXMLElement *trainRecord in records){
                    
                    
                    DDXMLElement *trainid = [trainRecord elementForName:@"trainid"];
                    DDXMLElement *trainlv = [trainRecord elementForName:@"trainlv"];
                    DDXMLElement *result = [trainRecord elementForName:@"result"];
                    DDXMLElement *recordtime = [trainRecord elementForName:@"recordtime"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
                    long date_long=[date_string timeIntervalSince1970];
                    
                    NSLog(@"%@,%@,%@,%@",trainid.stringValue,trainlv.stringValue,result.stringValue,date_string);
                    
                    int status=-1;
                    
                    if ([result.stringValue isEqualToString:@"C"]) {
                        
                        status=1;
                        
                    }else if([result.stringValue isEqualToString:@"N"]){
                        
                        NSDate *today = [NSDate date];
                        
                        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                        NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                                            fromDate:date_string
                                                                              toDate:today
                                                                             options:0];
                        
                        long days=[components day];
                        
                        if (days>7) {
                            
                            status=3;
                        }else{
                            
                            status=2;
                        }
                        
                    }else if([result.stringValue isEqualToString:@"T"]){
                        
                        status=3;
                    }
                    
                    NSInteger lv = (NSInteger)[trainlv.stringValue integerValue];
                    
                    TrainingRecord *train=[[TrainingRecord alloc] initWithTrainid:trainid.stringValue result:result.stringValue starttime:date_long time:date_long status:status level:lv];
                    
                    
                    [DBHelper addTrainRecord:train];
                    
                    
                }
                
                
            }
            
            NSLog(@"check the time 3");
            
            
            
            [DBHelper delNoIdRecord];
            
            NSArray *walkRecords = [doc nodesForXPath:recordsFlag error:nil];
            
            NSLog(@"get walking records......1111.....%lu",(unsigned long)[walkRecords count]);
            
            for (DDXMLElement *walkRecord in walkRecords) {
                
                NSArray *walks = [walkRecord nodesForXPath:recordFlag error:nil];
                
                NSLog(@"get walking records.......2222....%lu",(unsigned long)[walks count]);
                
                
                for (DDXMLElement *walk in walks){
                    
                    
                    DDXMLElement *trainid = [walk elementForName:@"trainid"];
                    DDXMLElement *recordid = [walk elementForName:@"recordid"];
                    DDXMLElement *foodlist = [walk elementForName:@"foodlist"];
                    DDXMLElement *duration = [walk elementForName:@"duration"];
                    DDXMLElement *steps = [walk elementForName:@"steps"];
                    DDXMLElement *meters = [walk elementForName:@"meters"];
                    DDXMLElement *caloburnt = [walk elementForName:@"caloburnt"];
                    DDXMLElement *calotarget = [walk elementForName:@"calotarget"];
                    DDXMLElement *result = [walk elementForName:@"result"];
                    DDXMLElement *gps = [walk elementForName:@"gps"];
                    DDXMLElement *route = [walk elementForName:@"route"];
                    
                    
                    
                    
                    NSLog(@"steps:%@",steps.stringValue);
                    if([steps.stringValue isEqualToString:@"7"])
                    {
                        NSLog(@"test in xml :%@",[walk elementForName:@"route"]);
                        
                    }
                    
                    //DDXMLElement *target = [walk elementForName:@"target"];
                    DDXMLElement *recordtime = [walk elementForName:@"recordtime"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
                    long date_long=[date_string timeIntervalSince1970];
                    
                    NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",trainid.stringValue,recordid.stringValue,foodlist.stringValue,duration.stringValue,steps.stringValue,meters.stringValue,caloburnt.stringValue,calotarget.stringValue,result.stringValue,date_string);
                    
                    int type=0;
                    
                    if (trainid!=nil) {
                        if (trainid.stringValue!=nil&&![trainid.stringValue isEqualToString:@""]) {
                            
                            type=1;
                        }
                    }
                    
                    
                    
                    NSString *strTem=steps.stringValue;
                    float floStep=[strTem floatValue];
                    strTem=duration.stringValue;
                    float floTime=[strTem floatValue];
                    float floTem = floStep/(floTime/60);
                    int IntTem=(int)floTem;
                    NSString *pace=[[NSString alloc]initWithFormat:@"%d",IntTem];
                    NSLog(@"pacepacepacepace:%@",pace);
                    
                    
                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:pace trainid:trainid.stringValue gps:gps.stringValue route:route.stringValue recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:type persistime:[duration.stringValue integerValue]];
                    
                    
                    walking.steps=[DBHelper encryptionString:walking.steps];
                    walking.distance=[DBHelper encryptionString:walking.distance];
                    walking.calsburnt=[DBHelper encryptionString:walking.calsburnt];
                    walking.persistimeStr=[DBHelper encryptionString:walking.persistimeStr];
                    
                    
                    [DBHelper addWalkingRecord:walking];
                    
                }
                
                
            }
            
            NSLog(@"check the time 4");
            
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *current=[NSDate date];
            
            [defaults setObject: [dateFormatter stringFromDate:current] forKey: [NSString stringWithFormat:@"walking_update_date_%@",[GlobalVariables shareInstance].login_id]];
            
            [defaults synchronize];
            
            
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"getWalkingAPIAlready" object:nil];
            
            
            
            return [DBHelper getLatestTrainRecord];
        }
        
        
    }
    
    
    
    
    
    
    
    return nil;
}


+ (TrainingRecord *)getTrainRecord:(NSString *)trainid{
    NSLog(@"check if it run : %@",[GlobalVariables shareInstance].session_id );
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RT"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        urlStr = [urlStr stringByAppendingString:@"&trainid="];
        urlStr = [urlStr stringByAppendingString:trainid];
        
        NSLog(@"rt with train id url:%@",urlStr);
        NSLog(@"check the time 1");
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        
        [DBHelper deleteTrainRecordById:trainid];
        


        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            
            
            
            
            static NSString *trainingsFlag = @"//trainings";
            static NSString *trainingFlag = @"//training";
            static NSString *recordsFlag = @"//records";
            static NSString *recordFlag = @"//record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
            
            NSArray *trainingsRecord = [doc nodesForXPath:trainingsFlag error:nil];
            
            
            
            
            
            for (DDXMLElement *obj in trainingsRecord) {
                
                NSArray *records = [obj nodesForXPath:trainingFlag error:nil];
                
                for (DDXMLElement *trainRecord in records){
                    
                    
                    DDXMLElement *trainid = [trainRecord elementForName:@"trainid"];
                    DDXMLElement *trainlv = [trainRecord elementForName:@"trainlv"];
                    DDXMLElement *result = [trainRecord elementForName:@"result"];
                    DDXMLElement *recordtime = [trainRecord elementForName:@"recordtime"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
                    long date_long=[date_string timeIntervalSince1970];
                    
                    NSLog(@"%@,%@,%@,%@",trainid.stringValue,trainlv.stringValue,result.stringValue,date_string);
                    
                    int status=-1;
                    
                    if ([result.stringValue isEqualToString:@"C"]) {
                        
                        status=1;
                        
                    }else if([result.stringValue isEqualToString:@"N"]){
                        
                        NSDate *today = [NSDate date];
                        
                        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                        NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                                            fromDate:date_string
                                                                              toDate:today
                                                                             options:0];
                        
                        long days=[components day];
                        
                        if (days>7) {
                            
                            status=3;
                        }else{
                            
                            status=2;
                        }
                        
                    }else if([result.stringValue isEqualToString:@"T"]){
                        
                        status=3;
                    }
                    
                    NSInteger lv = (NSInteger)[trainlv.stringValue integerValue];
                    
                    TrainingRecord *train=[[TrainingRecord alloc] initWithTrainid:trainid.stringValue result:result.stringValue starttime:date_long time:date_long status:status level:lv];
                    
                    
                    [DBHelper addTrainRecord:train];
                    
                    
                }
                
                
            }
            
            
            NSArray *walkRecords = [doc nodesForXPath:recordsFlag error:nil];
            
            
            for (DDXMLElement *walkRecord in walkRecords) {
                
                NSArray *walks = [walkRecord nodesForXPath:recordFlag error:nil];
                
                
                
                for (DDXMLElement *walk in walks){
                    
                    
                    DDXMLElement *trainid = [walk elementForName:@"trainid"];
                    DDXMLElement *recordid = [walk elementForName:@"recordid"];
                    DDXMLElement *foodlist = [walk elementForName:@"foodlist"];
                    DDXMLElement *duration = [walk elementForName:@"duration"];
                    DDXMLElement *steps = [walk elementForName:@"steps"];
                    DDXMLElement *meters = [walk elementForName:@"meters"];
                    DDXMLElement *caloburnt = [walk elementForName:@"caloburnt"];
                    DDXMLElement *calotarget = [walk elementForName:@"calotarget"];
                    DDXMLElement *result = [walk elementForName:@"result"];
                    DDXMLElement *gps = [walk elementForName:@"gps"];
                    DDXMLElement *route = [walk elementForName:@"route"];
                    
                    
                    
                    
                    NSLog(@"steps:%@",steps.stringValue);
                    if([steps.stringValue isEqualToString:@"7"])
                    {
                        NSLog(@"test in xml :%@",[walk elementForName:@"route"]);
                        
                    }
                    
                    //DDXMLElement *target = [walk elementForName:@"target"];
                    DDXMLElement *recordtime = [walk elementForName:@"recordtime"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
                    long date_long=[date_string timeIntervalSince1970];
                    
                    
                    int type=0;
                    
                    if (trainid!=nil) {
                        if (trainid.stringValue!=nil&&![trainid.stringValue isEqualToString:@""]) {
                            
                            type=1;
                        }
                    }
                    
                    
                    
                    NSString *strTem=steps.stringValue;
                    float floStep=[strTem floatValue];
                    strTem=duration.stringValue;
                    float floTime=[strTem floatValue];
                    float floTem = floStep/(floTime/60);
                    int IntTem=(int)floTem;
                    NSString *pace=[[NSString alloc]initWithFormat:@"%d",IntTem];
                    
                    
                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:pace trainid:trainid.stringValue gps:gps.stringValue route:route.stringValue recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:type persistime:[duration.stringValue integerValue]];
                    
                    
                    walking.steps=[DBHelper encryptionString:walking.steps];
                    walking.distance=[DBHelper encryptionString:walking.distance];
                    walking.calsburnt=[DBHelper encryptionString:walking.calsburnt];
                    walking.persistimeStr=[DBHelper encryptionString:walking.persistimeStr];
                    
                    
                    [DBHelper addWalkingRecord:walking];
                    
                }
                
                
            }
            
            
            
            
            //            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //
            //            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            //            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            //
            //            NSDate *current=[NSDate date];
            //
            //            [defaults setObject: [dateFormatter stringFromDate:current] forKey: [NSString stringWithFormat:@"walking_update_date_%@",[GlobalVariables shareInstance].login_id]];
            //
            //            [defaults synchronize];
            
            
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"refreshTrainData" object:nil];
            [GlobalVariables shareInstance].trainRT_API_running=false;

            
            return [DBHelper getLatestTrainRecord];
        }
        
        
    }
    
    
    
    
    
    return nil;
}


+ (WalkingRecord *)getWalkingRecordDetail:(NSString *)recordid{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthWalk?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RD&recordid="];
        urlStr = [urlStr stringByAppendingString:recordid];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        [syncUtility XMLHasError:xmlData];
        
        static NSString *recordFlag = @"//record";
        
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:xmlData options:0 error:nil];
        
        
        
        NSArray *walks = [doc nodesForXPath:recordFlag error:nil];
        
        for (DDXMLElement *walk in walks){
            
            
            DDXMLElement *trainid = [walk elementForName:@"trainid"];
            DDXMLElement *recordid = [walk elementForName:@"recordid"];
            DDXMLElement *foodlist = [walk elementForName:@"foodlist"];
            DDXMLElement *duration = [walk elementForName:@"duration"];
            DDXMLElement *steps = [walk elementForName:@"steps"];
            DDXMLElement *meters = [walk elementForName:@"meters"];
            DDXMLElement *caloburnt = [walk elementForName:@"caloburnt"];
            DDXMLElement *calotarget = [walk elementForName:@"calotarget"];
            DDXMLElement *result = [walk elementForName:@"result"];
            DDXMLElement *gps = [walk elementForName:@"gps"];
            DDXMLElement *route = [walk elementForName:@"route"];
            //            DDXMLElement *target = [walk elementForName:@"target"];
            
            DDXMLElement *recordtime = [walk elementForName:@"recordtime"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date_string = [dateFormatter dateFromString:recordtime.stringValue];
            long date_long=[date_string timeIntervalSince1970];
            
            NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",trainid.stringValue,recordid.stringValue,foodlist.stringValue,duration.stringValue,steps.stringValue,meters.stringValue,caloburnt.stringValue,calotarget.stringValue,result.stringValue,date_string,gps.stringValue,route.stringValue);
            
            int type=0;
            
            if (trainid!=nil) {
                if (trainid.stringValue!=nil&&![trainid.stringValue isEqualToString:@""]) {
                    
                    type=1;
                }
            }
            
            WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:gps.stringValue route:route.stringValue recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:type persistime:[duration.stringValue integerValue]];
            
            
            walking.steps=[DBHelper encryptionString:walking.steps];
            walking.distance=[DBHelper encryptionString:walking.distance];
            walking.calsburnt=[DBHelper encryptionString:walking.calsburnt];
            walking.persistimeStr=[DBHelper encryptionString:walking.persistimeStr];
            
            [DBHelper addWalkingRecord:walking];
            
        }
        
        
        return [DBHelper getCWRecordById:recordid];
        
    }
    
    
    
    return nil;
}










+ (NSMutableArray *)addWalkingRcord:(WalkingRecord *)record{
    
    NSLog(@"-----------come here---------");
    __block NSString *result_msg=[[NSString alloc]init];
    __block NSString * last_MSG=@"0";
    __block NSString *fbkey=[[NSString alloc]init];
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    //url_string = [url_string stringByAppendingString:apiBaseURL];
    url_string = [url_string stringByAppendingString:@"login="];
    if (login_id) {
        url_string = [url_string stringByAppendingString:login_id];
    }
    
    url_string = [url_string stringByAppendingString:@"&action=A&sessionid="];
    if (session_id
        ) {
        url_string = [url_string stringByAppendingString:session_id];
    }
    
    url_string = [url_string stringByAppendingString:@"&trainid="];
    url_string = [url_string stringByAppendingString:record.trainid];
    NSLog(@"-------Frist time----come here---------");
    url_string = [url_string stringByAppendingString:@"&duration="];
    url_string = [url_string stringByAppendingString:[NSString stringWithFormat:@"%ld",[record getPersistime]]];
    
    url_string = [url_string stringByAppendingString:@"&steps="];
    url_string = [url_string stringByAppendingString:record.steps];
    
    url_string = [url_string stringByAppendingString:@"&meters="];
    url_string = [url_string stringByAppendingString:record.distance];
    
    url_string = [url_string stringByAppendingString:@"&caloburnt="];
    url_string = [url_string stringByAppendingString:record.calsburnt];
    
    url_string = [url_string stringByAppendingString:@"&calotarget="];
    url_string = [url_string stringByAppendingString:record.target];
    
    url_string = [url_string stringByAppendingString:@"&gps="];
    url_string = [url_string stringByAppendingString:record.gps];
    
    url_string = [url_string stringByAppendingString:@"&route="];
    url_string = [url_string stringByAppendingString:record.route];
    
    url_string = [url_string stringByAppendingString:@"&foodlist="];
    url_string = [url_string stringByAppendingString:record.foodlistid];
    
    
    
    
    
    
    
    url_string = [url_string stringByAppendingString:@"&starttime="];
    if([record timeStr]!=nil){
        url_string = [url_string stringByAppendingString:[Utility inURLFormat:[record timeStr]]];
    }
    else{
        
        NSString *tem=[NSString formatTimeAgo:[record getRecordtime]];
        
        //        NSString *tem= [NSString stringWithFormat:@"%@",[record timeStr]];
        url_string = [url_string stringByAppendingString:[Utility inURLFormat:tem]];
    }
    
    
    
    
    
    
    
    url_string = [url_string stringByAppendingString:@"&recordtime="];
    //    url_string = [url_string stringByAppendingString:[Utility inURLFormat:[record timeStr]]];
    
    
    if([record timeStr]!=nil){
        
        url_string = [url_string stringByAppendingString:[Utility inURLFormat:[record timeStr]]];
    }
    else{
        NSString *tem=[NSString formatTimeAgo:[record getRecordtime]];
        //        NSString *tem= [NSString stringWithFormat:@"%@",[record timeStr]];
        url_string = [url_string stringByAppendingString:[Utility inURLFormat:tem]];
    }
    
    
    
    
    
    
//    NSLog(@"walking add url:%@",url_string);
    
    
    NSString *encodedString=[NSString stringWithFormat:@"%@healthWalk",[Constants getAPIBase2]];
    
    NSURL *request_url = [NSURL URLWithString:encodedString];
    
    NSLog(@"request_url:%@",encodedString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [ NSData dataWithBytes: [url_string UTF8String] length: [url_string length] ];
    [request setHTTPBody:requestData];
//    NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@+_+_+_",ionaSr);
    
    
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if (data!= nil)
    {

        if (data)
        {
            
            [syncUtility XMLHasError:data];
            
            int isSucc = [Utility isSucc:data];
            if (isSucc==1)
            {
                
                result_msg=[syncUtility getAddWalkingRecordMsg:data];
                fbkey=[syncUtility getAddWalkingRecordShareKey:data];
                
             
                last_MSG=result_msg;
                record.steps=[DBHelper encryptionString:record.steps];
                record.distance=[DBHelper encryptionString:record.distance];
                record.calsburnt=[DBHelper encryptionString:record.calsburnt];
                record.persistimeStr=[DBHelper encryptionString:record.persistimeStr];
                
                [DBHelper addWalkingRecord:record];
                
            }
            else
            {
                NSLog(@"32132111111");
                
            }
            
        }
        else
        {
            
            NSLog(@"result is nil......");
            
        }
    }
    
    else
    {
        // There was an error, alert the user
        NSLog(@"test here");
        NSLog(@"check the type : %ld",(long)[record getType]);
        if([record getType]==0){
            [record setType:(3)];
            
        }
        else if([record getType]==1){
            [record setType:(4)];
            
        }
        
        record.steps=[DBHelper encryptionString:record.steps];
        record.distance=[DBHelper encryptionString:record.distance];
        record.calsburnt=[DBHelper encryptionString:record.calsburnt];
        record.persistimeStr=[DBHelper encryptionString:record.persistimeStr];
        
        
        [DBHelper addWalkingRecord:record];
        
    }
    
    
   
//    NSLog(@"result_msg_result_msg_result_msg=%@",result_msg);
//    NSLog(@"last _msg=%@",last_MSG);
    
    
    NSMutableArray * array=[[NSMutableArray alloc] initWithObjects:result_msg,fbkey, nil];
    return array;
}

+ (void)addTrainRcord:(TrainingRecord *)record{
    
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthWalk?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&action=AT&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&trainlv="];
    url_string = [url_string stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)[record getLevel]]];
    url_string = [url_string stringByAppendingString:@"&recordtime="];
    url_string = [url_string stringByAppendingString:[Utility inURLFormat:record.timeStr]];
    
    NSURL *request_url = [NSURL URLWithString:url_string];
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    
    NSLog(@"add train url....%@",url_string);
    
    if (xmlData){
        
        
        [syncUtility XMLHasError:xmlData];
        
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"add train record succ:%d",isSucc);
        if (isSucc==1){
            
            static NSString *startFlag = @"//response";
            
            DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
            NSArray *responseArray = [doc nodesForXPath:startFlag error:nil];
            
            for (DDXMLElement *obj in responseArray){
                
                DDXMLElement *trainidElement = [obj elementForName:@"trainid"];
                record.trainid=trainidElement.stringValue;
                
            }
            
            [DBHelper addTrainRecord:record];
        }
    }
    
}
+ (void)delTrainRcord:(NSString *)trainid{
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthWalk?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&action=TT&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&trainid="];
    url_string = [url_string stringByAppendingString:trainid];
    
    NSLog(@"train del url:%@",url_string);
    
    NSURL *request_url = [NSURL URLWithString:url_string];
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    if (xmlData){
        
        [syncUtility XMLHasError:xmlData];
        
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"del train record succ:%d",isSucc);
        if (isSucc==1){
            
            [DBHelper delTrainRecord:trainid];
        }
    }
    
}

@end
