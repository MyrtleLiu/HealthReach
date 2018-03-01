//
//  DBHelper.m
//  mHealth
//
//  Created by sngz on 14-2-12.
//
//

#import "DBHelper.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "GlobalVariables.h"
#import "NSString+URLEncoding.h"
#import "Constants.h"
#import "syncUtility.h"
#import "RNEncryptor.h"
#import "RNDecryptor.h"
#import "DiaryViewController.h"

@implementation DBHelper

# pragma mark -
# pragma mark DB Utilities

+ (BOOL) initDB {
    
    __block BOOL result=NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db setShouldCacheStatements:YES];
        
        [db beginTransaction];
        
        
        [db executeUpdate:@"CREATE TABLE ecg ("
         "recordid TEXT ,"
         "ecg TEXT  ,"
         "heartrate TEXT  ,"
         "recordtime LONG PRIMARY KEY,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         "status INTEGER DEFAULT 0,"
         "note TEXT"
         ")"];
        
        [db executeUpdate:@"CREATE TABLE pedometer ("
         "steps TEXT ,"
         "meters TEXT ,"
         "caloburnt TEXT ,"
         "recordtime LONG PRIMARY KEY,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         "status INTEGER DEFAULT 0"
         ")"];
        
        [db executeUpdate:@"CREATE TABLE blood_pressure ("
         "systolic TEXT ,"
         "diastolic TEXT  ,"
         "heartrate TEXT  ,"
         "recordtime LONG PRIMARY KEY,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         //status 0:uploaded; 1:not uploaded
         "status INTEGER DEFAULT 0,"
         "missprevious INTEGER"
         ")"];
        
        
        [db executeUpdate:@"CREATE TABLE blood_glucose ("
         "bg TEXT ,"
         "recordtime LONG PRIMARY KEY,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         "status INTEGER DEFAULT 0,"
         "type TEXT,"
         "missprevious INTEGER"
         ")"];
        
        
        
        [db executeUpdate:@"CREATE TABLE weight ("
         "weight TEXT ,"
         "bmi TEXT ,"
         "recordtime LONG PRIMARY KEY,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         "status INTEGER DEFAULT 0,"
         "missprevious INTEGER"
         ")"];
        
        
        [db executeUpdate:@"CREATE TABLE blood_pressure_average_chart ("
         "id INTEGER PRIMARY KEY, "
         "systolic TEXT ,"
         "diastolic TEXT  ,"
         "heartrate TEXT  ,"
         "recordtime LONG,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         //status 0:uploaded; 1:not uploaded
         "status INTEGER DEFAULT 0,"
         "missprevious INTEGER"
         ")"];
        
        
        [db executeUpdate:@"CREATE TABLE blood_glucose_average_chart ("
         "id INTEGER PRIMARY KEY, "
         "bg TEXT ,"
         "recordtime LONG,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         "status INTEGER DEFAULT 0,"
         "type TEXT,"
         "missprevious INTEGER"
         ")"];
        
        
        
        [db executeUpdate:@"CREATE TABLE weight_average_chart ("
         "id INTEGER PRIMARY KEY, "
         "weight TEXT ,"
         "bmi TEXT ,"
         "recordtime LONG,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         "status INTEGER DEFAULT 0,"
         "missprevious INTEGER"
         ")"];
        
        [db executeUpdate:@"CREATE TABLE blood_pressure_average ("
         "systolic TEXT ,"
         "diastolic TEXT  ,"
         "heartrate TEXT  ,"
         //         "recordtime LONG PRIMARY KEY,"
         "recordtime LONG ,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         //status 0:normal average; 1:average with week and month
         "status INTEGER DEFAULT 0,"
         "weekstart VARCHAR, "
         "weekend VARCHAR, "
         "weekno VARCHAR, "
         "month VARCHAR, "
         "missprevious INTEGER"
         ")"];
        
        
        [db executeUpdate:@"CREATE TABLE blood_glucose_average ("
         "bg TEXT ,"
         //         "recordtime LONG PRIMARY KEY,"
         "recordtime LONG ,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         "status INTEGER DEFAULT 0,"
         "type TEXT,"
         "weekstart VARCHAR, "
         "weekend VARCHAR, "
         "weekno VARCHAR, "
         "month VARCHAR, "
         "missprevious INTEGER"
         ")"];
        
        [db executeUpdate:@"CREATE TABLE weight_average ("
         "weight TEXT ,"
         "bmi TEXT ,"
         "recordtime LONG ,"
         "createtime LONG  ,"
         "uploadtime LONG  ,"
         "status INTEGER DEFAULT 0,"
         "weekstart VARCHAR, "
         "weekend VARCHAR, "
         "weekno VARCHAR, "
         "month VARCHAR, "
         "missprevious INTEGER"
         ")"];
        
        [db executeUpdate:@"CREATE TABLE walking_train_average_chart("
         "id INTEGER PRIMARY KEY, "
         "type INTEGER , "
         "trainid VARCHAR, "
         "recordid VARCHAR, "
         "foodlistid VARCHAR, "
         "result VARCHAR, "
         "gps VARCHAR, "
         "route VARCHAR, "
         "steps VARCHAR, "
         "distance VARCHAR, "
         "caloburnt VARCHAR, "
         "target VARCHAR, "
         "pace VARCHAR, "
         "persistime VARCHAR NOT NULL, "
         "persistimeL LONG NOT NULL, "
         "recordtime LONG"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE walking_cw_average_chart("
         "id INTEGER PRIMARY KEY, "
         "type INTEGER , "
         "trainid VARCHAR, "
         "recordid VARCHAR, "
         "foodlistid VARCHAR, "
         "result VARCHAR, "
         "gps VARCHAR, "
         "route VARCHAR, "
         "steps VARCHAR, "
         "distance VARCHAR, "
         "caloburnt VARCHAR, "
         "target VARCHAR, "
         "pace VARCHAR, "
         "persistime VARCHAR NOT NULL, "
         "persistimeL LONG NOT NULL, "
         "recordtime LONG"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE alarms ("
         "hour INTEGER, "
         "minutes INTEGER, "
         "daysofweek INTEGER, "
         "alarmtime INTEGER, "
         "enabled INTEGER, "
         "vibrate INTEGER, "
         "message TEXT, "
         "alert TEXT,"
         "reminderid TEXT, "
         "createtime LONG, "
         "todayrun INTEGER, "
         "servertime LONG, "
         "checkcount INTEGER, "
         "year INTEGER, "
         "month INTEGER, "
         "dayofmonth INTEGER, "
         "endyear INTEGER, "
         "endmonth INTEGER, "
         "enddayofmonth INTEGER, "
         "endhour INTEGER, "
         "endminutes INTEGER, "
         "dosage TEXT, "
         "meal TEXT, "
         "frequency INTEGER, "
         "titles TEXT, "
         "notes TEXT, "
         "groupid TEXT, "
         "medid INTEGER, "
         "recordtime LONG PRIMARY KEY, "
         "startdate LONG, "
         "enddate LONG, "
         "endtime LONG "
         ")"];
        
        [db executeUpdate:@"CREATE TABLE lastest_updates_dates("
         "type TEXT PRIMARY KEY, "
         "server_updatetime LONG, "
         "db_updatetime LONG "
         ")"];
        
        [db executeUpdate:@"CREATE TABLE trains("
         "id INTEGER PRIMARY KEY, "
         "level INTEGER , "
         "status INTEGER , "
         "trainid VARCHAR, "
         "result VARCHAR, "
         "starttime LONG, "
         "recordtime LONG"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE walking("
         "id INTEGER PRIMARY KEY, "
         "type INTEGER , "
         "trainid VARCHAR, "
         "recordid VARCHAR, "
         "foodlistid VARCHAR, "
         "result VARCHAR, "
         "gps VARCHAR, "
         "route VARCHAR, "
         "steps VARCHAR, "
         "distance VARCHAR, "
         "caloburnt VARCHAR, "
         "target VARCHAR, "
         "pace VARCHAR, "
         "persistime VARCHAR NOT NULL, "
         "persistimeL LONG NOT NULL, "
         "recordtime LONG"
         ");"];
        [db executeUpdate:@"CREATE TABLE calendar_bp("
         "id VARCHAR PRIMARY KEY,"
         "time VARCHAR,"
         "type VARCHAR,"
         "repeat VARCHAR,"
         "createtime VARCHAR,"
         "servertime VARCHAR"
         ");"];
        [db executeUpdate:@"CREATE TABLE calendar_ecg("
         "id VARCHAR PRIMARY KEY,"
         "time VARCHAR,"
         "type VARCHAR,"
         "repeat VARCHAR,"
         "createtime VARCHAR,"
         "servertime VARCHAR"
         ");"];
        [db executeUpdate:@"CREATE TABLE calendar_bg("
         "id VARCHAR PRIMARY KEY,"
         "time VARCHAR,"
         "type VARCHAR,"
         "repeat VARCHAR,"
         "createtime VARCHAR,"
         "servertime VARCHAR"
         ");"];
        [db executeUpdate:@"CREATE TABLE calendar_others("
         "id VARCHAR PRIMARY KEY,"
         "type VARCHAR,"
         "title VARCHAR,"
         "start_time VARCHAR,"
         "end_time VARCHAR,"
         "note VARCHAR,"
         "date VARCHAR,"
         "createtime VARCHAR,"
         "servertime VARCHAR"
         ");"];
        [db executeUpdate:@"CREATE TABLE calendar_walk("
         "id VARCHAR PRIMARY KEY,"
         "type VARCHAR,"
         "start_date VARCHAR,"
         "end_date VARCHAR,"
         "time VARCHAR,"
         "repeat VARCHAR,"
         "createtime VARCHAR,"
         "servertime VARCHAR"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE calendar_medication("
         "meid VARCHAR PRIMARY KEY,"
         "title VARCHAR,"
         "meal VARCHAR,"
         "dosage VARCHAR,"
         "servertime VARCHAR,"
         "reminder_id VARCHAR,"
         "reminder_time VARCHAR,"
         "reminder_ticken VARCHAR,"
         "reminder_image_string VARCHAR,"
         "reminder_repeat VARCHAR" 
         ");"];
        
        [db executeUpdate:@"CREATE TABLE calendar_medication_notes("
         "meid VARCHAR PRIMARY KEY,"
         "title VARCHAR,"
         "note VARCHAR"
         ");"];
        
        [db executeUpdate:@"TRUNCATE TABLE food_list_filename"];
        [db executeUpdate:@"CREATE TABLE food_list_filename("
         "file_name VARCHAR PRIMARY KEY"
         ");"];
        
        [db executeUpdate:@"TRUNCATE TABLE food_list"];
        [db executeUpdate:@"CREATE TABLE food_list("
         "food_id INTEGER, "
         "food_name_en VARCHAR, "
         "food_name_zh VARCHAR, "
         "quantity_en VARCHAR, "
         "quantity_zh VARCHAR, "
         "food_type VARCHAR, "
         "calories INTEGER, "
         "picture_filename VARCHAR, "
         "quantity INTEGER"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE food_records("
         "recordtime VARCHAR PRIMARY KEY, "
         "recordtime_long long, "
         "record_detail TEXT, "
         "total_calories LONG, "
         "not_upload_status INTEGER DEFAULT 1, "
         "record_id VARCHAR"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE light_intro("
         "view VARCHAR PRIMARY KEY, "
         "is_light_intro INTEGER DEFAULT 0"
         ");"];
        
        
        [db executeUpdate:@"CREATE TABLE messages("
         "id INTEGER PRIMARY KEY, "
         "messageid VARCHAR , "
         "is_read VARCHAR , "
         "send_time VARCHAR, "
         "ensummary VARCHAR, "
         "zhsummary VARCHAR, "
         "enicon VARCHAR, "
         "zhicon VARCHAR"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE news("
         "id INTEGER PRIMARY KEY, "
         "messageid VARCHAR , "
         "is_read VARCHAR , "
         "send_time VARCHAR, "
         "ensummary VARCHAR, "
         "zhsummary VARCHAR, "
         "enicon VARCHAR, "
         "zhicon VARCHAR"
         ");"];

        
        
        [db executeUpdate:@"CREATE TABLE save_calendar("
         "id VARCHAR PRIMARY KEY, "
         "is_save INTEGER"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE zhendeyougengxinguoma("
         "id VARCHAR PRIMARY KEY, "
         "is_save INTEGER"
         ");"];
        
        
        [db executeUpdate:@"CREATE TABLE game("
         "id INTEGER PRIMARY KEY, "
         "progress VARCHAR , "
         "gameType VARCHAR , "
         "plantType VARCHAR, "
         "plantName VARCHAR, "
         "status VARCHAR, "
         "distance VARCHAR, "
         "steps VARCHAR, "
         "calories VARCHAR, "
         "fb_key VARCHAR, "
         "startDate long, "
         "endDate long"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE frist_time_rp("
         "id INTEGER PRIMARY KEY, "
         "rp INTEGER,"
         "trynow INTEGER,"
         "progress VARCHAR"
         ");"];
        
        [db executeUpdate:@"CREATE TABLE frist_time_walking"
         "id VARCHAR PRIMARY KEY,"
         "type VARCHAR,"
         "start_date VARCHAR,"
         "end_date VARCHAR,"
         "time VARCHAR,"
         "repeat VARCHAR,"
         "createtime VARCHAR,"
         "servertime VARCHAR"
         ");"];
 
        
        
        [db commit];
        
        [db close];
        
        result=YES;
    }];
    
    return result;
}

+(mHealth_iPhoneAppDelegate *)appDelegate{
    
    return (mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
    
}



+ (FMDatabaseQueue *)dbQueue {
    return [[self appDelegate] dbQueue];
}

+ (NSMutableArray *)getRecordNotUploaded:(NSString *)fromDatabase{
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE status = 1",fromDatabase];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            [returnArray addObject:rs];
        }
    }];
    return returnArray;
}

#pragma mark -
#pragma mark BP

+ (BOOL) addBPRecord:(BloodPressure *) bp{
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM blood_pressure WHERE recordtime = %ld",[bp getRecordtime]];
        
        
        
        
        
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        [check next];
        
        
        if ([check resultDictionary])
        {
            NSLog(@"update...");
            NSString *sql = nil;
            
            sql=[NSString stringWithFormat:@"UPDATE blood_pressure SET systolic=\"%@\", diastolic=\"%@\",heartrate=\"%@\", createtime=%ld, uploadtime=%ld, status=%d, missprevious=%d WHERE recordtime=%ld",bp.sys==nil?@"0":bp.sys,bp.dia==nil?@"0":bp.dia,bp.heartrate==nil?@"0":bp.heartrate,[bp getRecordtime],[bp getRecordtime],[bp getStatus],[bp getMissprevious],[bp getRecordtime]];
            
            
            
            
            
            
            
            
            
            NSLog(@"%@......sql",sql);
            
            
            result=[db executeUpdate:sql];
            
            //// NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            NSLog(@"add...");
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO blood_pressure (systolic,diastolic,heartrate,createtime,uploadtime,recordtime,status,missprevious)  VALUES (\"%@\",\"%@\",\"%@\",%ld,%ld,%ld,%d,%d)",bp.sys==nil?@"0":bp.sys,bp.dia==nil?@"0":bp.dia,bp.heartrate==nil?@"0":bp.heartrate,[bp getRecordtime],[bp getRecordtime],[bp getRecordtime],[bp getStatus],[bp getMissprevious]];
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    return result;
    
}


+ (NSMutableArray *)getBPHistoryRecord{
    __block NSMutableArray *bpResultArray = [[NSMutableArray alloc]init];
    __block NSDictionary *bpResultDict = [[NSMutableDictionary alloc]init];
    __block BloodPressure *bpResult = [[BloodPressure alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT systolic,diastolic,heartrate,recordtime,status,missprevious FROM blood_pressure WHERE NOT(systolic = \"0\")ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        int entryNum = 0;
        
        long beforeThreeMonthTiming = [[NSDate date]timeIntervalSince1970] - 60*60*24*31*3;
        while([rs next]){
            if ([rs longForColumn:@"recordtime"] < beforeThreeMonthTiming)
                break;
            bpResult = [bpResult initWithSys:[rs stringForColumn:@"systolic"] time:[rs longForColumn:@"recordtime"] dia:[rs stringForColumn:@"diastolic"] heartrate:[rs stringForColumn:@"heartrate"] status:[rs intForColumn:@"status"]missprevious:[[rs stringForColumn:@"missprevious"] intValue]];
            
            
            
            bpResult.sys=[DBHelper decryptionString:bpResult.sys];
            bpResult.dia=[DBHelper decryptionString:bpResult.dia];
            bpResult.heartrate=[DBHelper decryptionString:bpResult.heartrate];
            
            
            
            
            bpResultDict = [NSDictionary dictionaryWithObjectsAndKeys:
                            [bpResult sys],@"sys",
                            [bpResult dia],@"dia",
                            [bpResult heartrate],@"pul",
                            [bpResult timeStr],@"time",
                            [NSString stringWithFormat:@"%d",[bpResult getStatus]],@"status", nil];
            if (!(entryNum==0)){
                [bpResultArray addObject:bpResultDict];
            }
            entryNum++;
        }
    }];
    return bpResultArray;
}

+ (BloodPressureList *) getBPByDate:(long)start enddate:(long)end status:(NSInteger)thestatus{
    
    __block BloodPressureList *resultList = [[BloodPressureList alloc] init];
    [resultList setPeriodstart:start];
    [resultList setPeriodend:end];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM blood_pressure WHERE status=%ld AND recordtime BETWEEN %ld AND %ld order by recordtime desc",(long)thestatus,start,end];
        
        if (start==0&&end==0) {
            sql=[NSString stringWithFormat:@"SELECT * FROM blood_pressure WHERE status=%ld order by recordtime desc",(long)thestatus];
        }
        
        if (thestatus==-1) {
            
            sql=[NSString stringWithFormat:@"SELECT * FROM blood_pressure WHERE status=1 OR status=0 AND recordtime BETWEEN %ld AND %ld order by recordtime desc",start,end];
        }
        
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            BloodPressure *bp=[[BloodPressure alloc] initWithSys:[rs stringForColumn:@"systolic"] time:[rs longForColumn:@"recordtime"] dia:[rs stringForColumn:@"diastolic"] heartrate:[rs stringForColumn:@"heartrate"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"]];
            
            
            bp.sys=[DBHelper decryptionString:bp.sys];
            bp.dia=[DBHelper decryptionString:bp.dia];
            bp.heartrate=[DBHelper decryptionString:bp.heartrate];
            
            
            
            [tmpArray addObject:bp];
        }
        [rs close];
        [db close];
        
        [resultList setBpList:[NSArray arrayWithArray:tmpArray]];
    }];
    
    if (resultList.bpList!=nil) {
        if ([resultList.bpList count]>0) {
            [resultList setBp:[resultList.bpList objectAtIndex:0]];
        }
    }
    return resultList;
}

+ (BloodPressure *)getNewestBPRecord{
    
    __block BloodPressure *bpResult = [[BloodPressure alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT systolic,diastolic,heartrate,recordtime,status,missprevious FROM blood_pressure ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        if ([rs next]){
            bpResult = [bpResult initWithSys:[rs stringForColumn:@"systolic"] time:[rs longForColumn:@"recordtime"] dia:[rs stringForColumn:@"diastolic"]heartrate:[rs stringForColumn:@"heartrate"] status:[[rs stringForColumn:@"status"] intValue]missprevious:[[rs stringForColumn:@"missprevious"]intValue]];
            bpResult.sys=[DBHelper decryptionString:bpResult.sys];
            bpResult.dia=[DBHelper decryptionString:bpResult.dia];
            bpResult.heartrate=[DBHelper decryptionString:bpResult.heartrate];
            
        }
    }];
    return bpResult;
}

+ (NSString *)getNewestBPDate_DB{
    __block NSString *newestDate  = [[NSString alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT recordtime FROM blood_pressure ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            newestDate = [rs stringForColumn:@"recordtime"];
            break;
        }
    }];
    return newestDate;
}

+ (NSMutableArray *)getBPNotUpload{
    
    __block BloodPressure *bpRecord = [[BloodPressure alloc]init];
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT systolic,diastolic,heartrate,recordtime,status FROM blood_pressure WHERE status=1"];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            if ([rs intForColumn:@"status"]==1){
                bpRecord = [bpRecord initWithSys:[rs stringForColumn:@"systolic"] time:[rs longForColumn:@"recordtime"] dia:[rs stringForColumn:@"diastolic"] heartrate:[rs stringForColumn:@"heartrate"] status:0 missprevious:0];
                
                bpRecord.sys=[DBHelper decryptionString:bpRecord.sys];
                bpRecord.dia=[DBHelper decryptionString:bpRecord.dia];
                bpRecord.heartrate=[DBHelper decryptionString:bpRecord.heartrate];
                
                
                [returnArray addObject:bpRecord];
                NSLog(@"%@ %@ %@ %d",[rs stringForColumn:@"systolic"],[rs stringForColumn:@"diastolic"],[rs stringForColumn:@"heartrate"],[rs intForColumn:@"status"]);
            }
        }
    }];
    return returnArray;
}

+ (void)delBPRecordAverageChart{
    
    NSLog(@"check average......del bp");
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        
        
        NSString *sql=[NSString stringWithFormat:@"DELETE FROM blood_pressure_average_chart"];
        
        
        [db executeUpdate:sql];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
    
    
}

+ (BOOL) addBPRecordAverageChart:(BloodPressure *) bp{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM blood_pressure_average_chart WHERE recordtime = %ld AND status=%d",[bp getRecordtime],[bp getStatus]];
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        [check next];
        
        
        if ([check resultDictionary])
        {
            NSLog(@"update...");
            NSString *sql = nil;
            
            sql=[NSString stringWithFormat:@"UPDATE blood_pressure_average_chart SET systolic=\"%@\", diastolic=\"%@\",heartrate=\"%@\", createtime=%ld, uploadtime=%ld, status=%d, missprevious=%d WHERE recordtime=%ld",bp.sys==nil?@"0":
                 
                 
                 
                 [DBHelper encryptionString:bp.sys],bp.dia==nil?@"0":[DBHelper encryptionString:bp.dia],bp.heartrate==nil?@"0":[DBHelper encryptionString:bp.heartrate],[bp getRecordtime],[bp getRecordtime],[bp getStatus],[bp getMissprevious],[bp getRecordtime]];
            
            NSLog(@"%@......sql",sql);
            
            
            result=[db executeUpdate:sql];
            
            //NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            NSLog(@"add...");
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO blood_pressure_average_chart (systolic,diastolic,heartrate,createtime,uploadtime,recordtime,status,missprevious)  VALUES (\"%@\",\"%@\",\"%@\",%ld,%ld,%ld,%d,%d)",bp.sys==nil?@"0":[DBHelper encryptionString:bp.sys],bp.dia==nil?@"0":[DBHelper encryptionString:bp.dia],bp.heartrate==nil?@"0":[DBHelper encryptionString:bp.heartrate],[bp getRecordtime],[bp getRecordtime],[bp getRecordtime],[bp getStatus],[bp getMissprevious]];
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    return result;
    
}



+ (BloodPressureList *) getBPAverageChartByDate:(long)start enddate:(long)end status:(NSInteger)thestatus{
    
    __block BloodPressureList *resultList = [[BloodPressureList alloc] init];
    [resultList setPeriodstart:start];
    [resultList setPeriodend:end];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM blood_pressure_average_chart WHERE status=%ld AND recordtime BETWEEN %ld AND %ld order by recordtime desc",(long)thestatus,start,end];
        
        if (start==0&&end==0) {
            sql=[NSString stringWithFormat:@"SELECT * FROM blood_pressure_average_chart WHERE status=%ld order by recordtime desc",(long)thestatus];
        }
        
        NSLog(@"get bp average sql.......%@",sql);
        
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            //NSLog(@"add bp......%lu",(unsigned long)[tmpArray count]);
            
            BloodPressure *bp=[[BloodPressure alloc] initWithSys:[rs stringForColumn:@"systolic"] time:[rs longForColumn:@"recordtime"] dia:[rs stringForColumn:@"diastolic"] heartrate:[rs stringForColumn:@"heartrate"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"]];
            
            bp.sys=[DBHelper decryptionString:bp.sys];
            bp.dia=[DBHelper decryptionString:bp.dia];
            bp.heartrate=[DBHelper decryptionString:bp.heartrate];
            
            
            
            [tmpArray addObject:bp];
        }
        [rs close];
        [db close];
        
        [resultList setBpList:[NSArray arrayWithArray:tmpArray]];
    }];
    
    if (resultList.bpList!=nil) {
        if ([resultList.bpList count]>0) {
            [resultList setBp:[resultList.bpList objectAtIndex:0]];
        }
    }
    return resultList;
}

+ (BOOL) addBPWeekRecord:(BloodPressure *)bp weekno:(NSString *)weekno weekstart:(NSString *)weekstart weekend:(NSString *)weekend
{
    NSLog(@"addBPWeekRecord:%@, weekno:%@ weekstart:%@ weekend:%@",bp ,weekno, weekstart, weekend);
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE weekno = \"%@\"",weekno];
        FMResultSet *checkRS = [db executeQuery:checkSql];
        [checkRS next];
        
        if ([checkRS resultDictionary])
        {
            NSString *updateSql = [NSString stringWithFormat:@"UPDATE blood_pressure_average SET systolic = \"%@\", diastolic = \"%@\", heartrate = \"%@\", status = %d WHERE weekno = \"%@\"",bp.sys==nil?@"0":bp.sys, bp.dia==nil?@"0":bp.dia, bp.heartrate==nil?@"0":bp.heartrate, [bp getStatus], weekno];
            NSLog(@"!!updateBPWeekRecord sql:%@",updateSql);
            result = [db executeUpdate:updateSql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
        } else {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO blood_pressure_average (systolic, diastolic, heartrate, recordtime, createtime, uploadtime, status, weekno, weekstart, weekend, missprevious) VALUES (\"%@\", \"%@\", \"%@\", %ld, %ld, %ld, %d, \"%@\", \"%@\" ,\"%@\", %d)",bp.sys==nil?@"0":bp.sys, bp.dia==nil?@"0":bp.dia, bp.heartrate==nil?@"0":bp.heartrate, [bp getRecordtime], [bp getRecordtime], [bp getRecordtime], [bp getStatus], weekno, weekstart, weekend, [bp getMissprevious]];
            NSLog(@"!!insertBPWeekRecord sql:%@",sql);
            result = [db executeUpdate:sql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
        }
        //        }
        //        [checkRS close];
        [db commit];
        [db close];
        
    }];
    return result;
}

+ (BOOL) addBPMonthRecord:(BloodPressure *)bp month:(NSString *)month
{
    NSLog(@"addBPMonthRecord:%@, month:%@",bp,month);
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE month = \"%@\"",month];
        FMResultSet *checkRS = [db executeQuery:checkSql];
        [checkRS next];
        
        if ([checkRS resultDictionary])
        {
            NSString *updateSql = [NSString stringWithFormat:@"UPDATE blood_pressure_average SET systolic = \"%@\", diastolic = \"%@\", heartrate = \"%@\", status = %d WHERE month = \"%@\" ",bp.sys==nil?@"0":bp.sys, bp.dia==nil?@"0":bp.dia, bp.heartrate==nil?@"0":bp.heartrate, [bp getStatus], month];
            NSLog(@"!!updateBPMonthRecord sql:%@",updateSql);
            result = [db executeUpdate:updateSql];
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
            
        } else {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO blood_pressure_average (systolic, diastolic, heartrate, recordtime, createtime, uploadtime, status, month, missprevious) VALUES (\"%@\", \"%@\", \"%@\", %ld, %ld, %ld, %d, \"%@\", %d)",bp.sys==nil?@"0":bp.sys, bp.dia==nil?@"0":bp.dia, bp.heartrate==nil?@"0":bp.heartrate, [bp getRecordtime], [bp getRecordtime], [bp getRecordtime], [bp getStatus], month, [bp getMissprevious]];
            NSLog(@"!!insertBPMonthRecord sql:%@",sql);
            result = [db executeUpdate:sql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
        }
        //        }
        //        [checkRS close];
        [db commit];
        [db close];
    }];
    return result;
    
}

+ (NSArray *)getAllBPMonthRecord;
{
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE ((month IS NOT NULL) AND NOT(month = \"(null)\")) ORDER BY month DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        int numberOfRecords = 1;
        while ([rs next] && (numberOfRecords <= 4)) {
            numberOfRecords++;
            NSMutableDictionary *eachEntry = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                              [DBHelper decryptionString:[rs stringForColumn:@"systolic"]]
                                              , @"sys",
                                              [DBHelper decryptionString:[rs stringForColumn:@"diastolic"]]
                                              , @"dia",
                                              [DBHelper decryptionString:[rs stringForColumn:@"heartrate"]]
                                              , @"rate",
                                              [rs stringForColumn:@"month"], @"month", nil];
            
            
            
            [returnArray addObject:eachEntry];
        }
        [db close];
        [rs close];
    }];
    return returnArray;
}

+ (NSArray *)getAllBPWeekRecord
{
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE ((weekno IS NOT NULL) AND NOT(weekno = \"(null)\")) ORDER BY weekno DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        NSString *lastWeek = @"";
        int numberOfMonth = 1;
        while ([rs next] && (numberOfMonth <= 3)) {
            if ([lastWeek isEqualToString:@""])
                lastWeek = [[rs stringForColumn:@"weekstart"] substringToIndex:7];
            
            if (![[[rs stringForColumn:@"weekstart"] substringToIndex:7] isEqualToString:lastWeek]) {
                numberOfMonth ++;
                lastWeek = [[rs stringForColumn:@"weekstart"] substringToIndex:7];
            }
            NSMutableDictionary *eachEntry = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                              //                                              [rs stringForColumn:@"systolic"], @"sys",
                                              //                                              [rs stringForColumn:@"diastolic"], @"dia",
                                              //                                              [rs stringForColumn:@"heartrate"], @"rate",
                                              //                                              [rs stringForColumn:@"weekno"], @"weekno",
                                              //                                              [rs stringForColumn:@"weekstart"], @"weekstart",
                                              //                                              [rs stringForColumn:@"weekend"], @"weekend", nil];
                                              
                                              [DBHelper decryptionString:[rs stringForColumn:@"systolic"]]
                                              , @"sys",
                                              [DBHelper decryptionString:[rs stringForColumn:@"diastolic"]]
                                              , @"dia",
                                              [DBHelper decryptionString:[rs stringForColumn:@"heartrate"]]
                                              , @"rate",
                                              [rs stringForColumn:@"weekno"], @"weekno",
                                              [rs stringForColumn:@"weekstart"], @"weekstart",
                                              [rs stringForColumn:@"weekend"], @"weekend", nil];
            
            [returnArray addObject:eachEntry];
        }
        
        
        [db close];
        [rs close];
    }];
    return returnArray;
}

+ (void)generateBPBlankWeekRecords
{
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        [db beginTransaction];
        
        NSDate *currentNSDate = [[NSDate alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *currentDateString = [dateFormatter stringFromDate:currentNSDate];
        int currentYear = [[currentDateString substringToIndex:4]intValue];
        int currentMonth = [[currentDateString substringFromIndex:6]intValue];
        FMResultSet *checkRS = [[FMResultSet alloc]init];
        
        BOOL firstWeekFound = FALSE;
        NSDate *lastWeekEnd = [[NSDate alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        int headYear = [syncUtility getHeadYear];
        
        for (int rollingYear = headYear; rollingYear <= currentYear; rollingYear++) {
            
            int rollingStartWeek,rollingEndWeek;
            if (headYear==currentYear) {
                rollingStartWeek = [syncUtility getHeadMonth]*4;
                rollingEndWeek = currentMonth*5>52?52:currentMonth * 5;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartWeek = 1;
                    rollingEndWeek =  currentMonth*5>52?52:currentMonth * 5;
                } else {
                    rollingStartWeek = [syncUtility getHeadMonth]*4;
                    rollingEndWeek = 52;
                }
            }
            
            for (int rollingWeek = rollingStartWeek; rollingWeek <= rollingEndWeek; rollingWeek++ ) {
                NSString *rollingString = @"";
                if (rollingWeek < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingWeek];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingWeek];
                
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE weekno = \"%@\"",rollingString];
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (firstWeekFound == FALSE)
                        firstWeekFound = TRUE;
                    lastWeekEnd = [dateFormatter dateFromString:[checkRS stringForColumn:@"weekend"]];
                } else {
                    if (firstWeekFound == TRUE){
                        NSDate *pickDate =  [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([lastWeekEnd timeIntervalSinceReferenceDate] + 24*3600)];
                        NSDictionary *weekDatesDictionary = [Utility generateWeekDatesFromDate:pickDate];
                        
                        NSString *weekstartNSString = [dateFormatter stringFromDate:[weekDatesDictionary objectForKey:@"startNSDate"]];
                        NSString *weekendNSString = [dateFormatter stringFromDate:[weekDatesDictionary objectForKey:@"endNSDate"]];
                        NSString *insertBlankSQL = [NSString stringWithFormat:@"INSERT INTO blood_pressure_average (systolic,diastolic,heartrate,weekno,weekstart,weekend) VALUES (\"0\", \"0\", \"0\", \"%@\", \"%@\", \"%@\")",rollingString, weekstartNSString, weekendNSString];
                        
                        
                        NSDate *today=[[NSDate alloc] init];
                        NSDate *targetDay=[dateFormatter dateFromString:weekstartNSString];
                        
                        if ([today timeIntervalSince1970]>[targetDay timeIntervalSince1970]) {
                            
                            NSLog(@"insert BP Blank Week SQL:%@",insertBlankSQL);
                            [db executeUpdate:insertBlankSQL];
                        }
                        
                        lastWeekEnd = [weekDatesDictionary objectForKey:@"endNSDate"];
                    }
                }
            }
        }
        
        BOOL lastWeekFound = FALSE;
        
        for (int rollingYear = currentYear; rollingYear > headYear; rollingYear--) {
            
            int rollingStartWeek,rollingEndWeek;
            if (headYear==currentYear) {
                rollingStartWeek = [syncUtility getHeadMonth]*4;
                rollingEndWeek = currentMonth*5>52?52:currentMonth * 5;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartWeek = 1;
                    rollingEndWeek =  currentMonth*5>52?52:currentMonth * 5;
                } else {
                    rollingStartWeek = [syncUtility getHeadMonth]*4;
                    rollingEndWeek = 52;
                }
            }
            
            for (int rollingWeek = rollingEndWeek; rollingWeek >= rollingStartWeek; rollingWeek--){
                
                NSString *rollingString = @"";
                if (rollingWeek < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingWeek];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingWeek];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE weekno = \"%@\" AND NOT(systolic = \"0\")",rollingString];
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (lastWeekFound == FALSE)
                        lastWeekFound = TRUE;
                } else if (lastWeekFound == FALSE) {
                    NSString *deleteBlankSQL = [NSString stringWithFormat:@"DELETE FROM blood_pressure_average WHERE weekno = \"%@\" ",rollingString];
                    NSLog(@"delete BP Blank Week SQL:%@",deleteBlankSQL);
                    [db executeUpdate:deleteBlankSQL];
                }
                
                
            }
        }
        
        [checkRS close];
        [db commit];
        [db close];
    }];
}

+ (void)generateBPBlankMonthRecords
{
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        
        [db open];
        [db beginTransaction];
        NSDate *currentNSDate = [[NSDate alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *currentDateString = [dateFormatter stringFromDate:currentNSDate];
        int currentYear = [[currentDateString substringToIndex:4]intValue];
        int currentMonth = [[currentDateString substringFromIndex:6]intValue];
        FMResultSet *checkRS = [[FMResultSet alloc]init];
        
        BOOL firstMonthFound = FALSE;
        
        int headYear = [syncUtility getHeadYear];
        int headMonth = [syncUtility getHeadMonth];
        
        for (int rollingYear = headYear; rollingYear <= currentYear; rollingYear++) {
            
            int rollingStartMonth,rollingEndMonth;
            if (headYear==currentYear) {
                rollingStartMonth = [syncUtility getHeadMonth];
                rollingEndMonth = currentMonth;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartMonth = 1;
                    rollingEndMonth = currentMonth;
                } else {
                    rollingStartMonth = headMonth;
                    rollingEndMonth = 12;
                }
            }
            
            for (int rollingMonth = rollingStartMonth; rollingMonth <= rollingEndMonth; rollingMonth++ ){
                
                NSString *rollingString = @"";
                if (rollingMonth < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingMonth];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingMonth];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE month = \"%@\"",rollingString];
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (firstMonthFound == FALSE)
                        firstMonthFound = TRUE;
                } else {
                    if (firstMonthFound == TRUE){
                        NSString *insertBlankSQL = [NSString stringWithFormat:@"INSERT INTO blood_pressure_average (systolic,diastolic,heartrate,month) VALUES (\"0\", \"0\", \"0\", \"%@\")",rollingString];
                        [db executeUpdate:insertBlankSQL];
                    }
                    
                }
                
            }
        }
        BOOL lastMonthFound = FALSE;
        
        for (int rollingYear = currentYear; rollingYear >= headYear; rollingYear--) {

            int rollingStartMonth,rollingEndMonth;
            if (headYear==currentYear) {
                rollingStartMonth = [syncUtility getHeadMonth];
                rollingEndMonth = currentMonth;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartMonth = 1;
                    rollingEndMonth = currentMonth;
                } else {
                    rollingStartMonth = headMonth;
                    rollingEndMonth = 12;
                }
            }
            
            for (int rollingMonth = rollingEndMonth; rollingMonth >= rollingStartMonth; rollingMonth--){
                
                NSLog(@"rollingYear:%d, rollingMonth:%d", rollingYear, rollingMonth);
                NSString *rollingString = @"";
                if (rollingMonth < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingMonth];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingMonth];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE month = \"%@\" AND NOT(systolic = \"0\")",rollingString];
                NSLog(@"!!checkSQL:%@",checkSQL);
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (lastMonthFound == FALSE)
                        lastMonthFound = TRUE;
                } else if (lastMonthFound == FALSE) {
                    NSString *deleteBlankSQL = [NSString stringWithFormat:@"DELETE FROM blood_pressure_average WHERE month = \"%@\" ",rollingString];
                    NSLog(@"!!deleteBlankSQL:%@",deleteBlankSQL);
                    [db executeUpdate:deleteBlankSQL];
                }
                
                
            }
        }
        
        [checkRS close];
        [db commit];
        [db close];
    }];
}


# pragma mark -
# pragma mark Weight


+ (WeightList *) getWeightByDate:(long)start enddate:(long)end status:(NSInteger)thestatus{
    
    __block WeightList *resultList = [[WeightList alloc] init];
    [resultList setPeriodstart:start];
    [resultList setPeriodend:end];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM weight WHERE status=%ld AND recordtime BETWEEN %ld AND %ld order by recordtime desc",(long)thestatus,start,end];
        
        if (start==0&&end==0) {
            sql=[NSString stringWithFormat:@"SELECT * FROM weight WHERE status=%ld order by recordtime desc",(long)thestatus];
        }
        
        if (thestatus==-1) {
            
            sql=[NSString stringWithFormat:@"SELECT * FROM weight WHERE status=1 OR status=0 AND recordtime BETWEEN %ld AND %ld order by recordtime desc",start,end];
        }
        
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            Weight *weightResult = [[Weight alloc] initWithWeight:[rs stringForColumn:@"weight"] bmi:[rs stringForColumn:@"bmi"] time:[rs longForColumn:@"recordtime"] status:[[rs stringForColumn:@"status"] intValue] missprevious:[rs intForColumn:@"missprevious"]];
            
            weightResult.weight=[DBHelper decryptionString: weightResult.weight];
            weightResult.bmi=[DBHelper decryptionString: weightResult.bmi];
            
            
            
            [tmpArray addObject:weightResult];
        }
        [rs close];
        [db close];
        
        [resultList setWeightList:[NSArray arrayWithArray:tmpArray]];
    }];
    
    if (resultList.weightList!=nil) {
        if ([resultList.weightList count]>0) {
            [resultList setWeight:[resultList.weightList objectAtIndex:0]];
        }
    }
    return resultList;
    
}


+ (BOOL) addWeightRecord:(Weight *)weight{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM weight WHERE recordtime = %ld",[weight getRecordtime]];
        FMResultSet *check = [db executeQuery:checkSql];
        [check next];
        
        if ([check resultDictionary]){
            
            NSLog(@"updating weight record");
            
            NSString *sql = [[NSString alloc]init];
            sql = [NSString stringWithFormat:@"UPDATE weight SET weight=\"%@\", bmi=\"%@\", createtime=%ld, uploadtime=%ld, status=%d, missprevious=%d WHERE recordtime=%ld", weight.weight==nil?@"0":weight.weight, weight.bmi==nil?@"0":weight.bmi, [weight getRecordtime], [weight getRecordtime], [weight getStatus], [weight getMissprevious], [weight getRecordtime]];
            
            NSLog(@"update weight record sql:%@",sql);
            result = [db executeUpdate:sql];
            
            if ([db hadError]&&result==NO){
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result = NO;
            }
        } else {
            NSLog(@"adding weight record");
            
            NSString *sql = [[NSString alloc]init];
            sql = [NSString stringWithFormat:@"INSERT INTO weight(weight,bmi,recordtime,createtime,uploadtime,status,missprevious) VALUES (\"%@\",\"%@\",%ld,%ld,%ld,%d,%d)", weight.weight==nil?@"0":weight.weight, weight.bmi==nil?@"0":weight.bmi, [weight getRecordtime], [weight getRecordtime], [weight getRecordtime], [weight getStatus], [weight getMissprevious]];
            
            NSLog(@"Insert weight record sql:%@",sql);
            result = [db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
        }
        [check close];
        [db commit];
        [db close];
        
    }];
    return result;
}

+ (NSMutableArray *)getWeightHistoryRecord{
    
    __block NSMutableArray *weightResultArray = [[NSMutableArray alloc]init];
    __block NSDictionary *weightResultDict = [[NSMutableDictionary alloc]init];
    __block Weight *weightResult = [[Weight alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT weight,bmi,recordtime,status,missprevious FROM weight ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        int entryNum = 0;
        
        long beforeThreeMonthTiming = [[NSDate date]timeIntervalSince1970] - 60*60*24*31*3;
        while([rs next]){
            if ([rs longForColumn:@"recordtime"] < beforeThreeMonthTiming)
                break;
            weightResult = [weightResult initWithWeight:[rs stringForColumn:@"weight"] bmi:[rs stringForColumn:@"bmi"] time:[rs longForColumn:@"recordtime"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"]];
            
            
            weightResult.weight=[DBHelper decryptionString: weightResult.weight];
            weightResult.bmi=[DBHelper decryptionString: weightResult.bmi];
            
            
            
            weightResultDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [weightResult weight],@"weight",
                                [weightResult bmi],@"bmi",
                                [weightResult timeStr],@"time",nil];
            if (!(entryNum==0))
                [weightResultArray addObject:weightResultDict];
            entryNum++;
        }
    }];
    return weightResultArray;
}

+ (Weight *) getNewestWeightRecord{
    
    __block Weight *weightResult = [[Weight alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT weight,bmi,recordtime,status,missprevious FROM weight ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        if ([rs next]){
            weightResult = [weightResult initWithWeight:[rs stringForColumn:@"weight"] bmi:[rs stringForColumn:@"bmi"] time:[rs longForColumn:@"recordtime"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"]];
            
            weightResult.weight=[DBHelper decryptionString: weightResult.weight];
            weightResult.bmi=[DBHelper decryptionString: weightResult.bmi];
            
        }
    }];
    return weightResult;
}

+ (NSString *)getNewestWeightDate_DB{
    __block NSString *newestDate  = [[NSString alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT recordtime FROM weight ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        while([rs next]){
            newestDate = [rs stringForColumn:@"recordtime"];
            break;
        }
    }];
    return newestDate;
}

+ (NSMutableArray *)getWeightNotUpload{
    
    __block NSDictionary *weightRecordDict;
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT bmi,weight,recordtime,missprevious FROM weight WHERE status = 1"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while ([rs next]){
            weightRecordDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [DBHelper decryptionString: [rs stringForColumn:@"weight"]]
                                , @"weight",
                                [DBHelper decryptionString: [rs stringForColumn:@"bmi"]]
                                , @"bmi",
                                [NSString stringWithFormat:@"%ld",[rs longForColumn:@"recordtime"]], @"recordtime",
                                @"1", @"status",
                                [rs intForColumn:@"missprevious"], @"missprevious",nil];
            
            
            
            
            
            
            
            [returnArray addObject:weightRecordDict];
        }
    }];
    return returnArray;
}


+ (WeightList *) getWeightAverageChartByDate:(long)start enddate:(long)end status:(NSInteger)thestatus{
    
    __block WeightList *resultList = [[WeightList alloc] init];
    [resultList setPeriodstart:start];
    [resultList setPeriodend:end];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM weight_average_chart WHERE status=%ld AND recordtime BETWEEN %ld AND %ld order by recordtime desc",(long)thestatus,start,end];
        
        if (start==0&&end==0) {
            sql=[NSString stringWithFormat:@"SELECT * FROM weight_average_chart WHERE status=%ld order by recordtime desc",(long)thestatus];
        }
        
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            Weight *weightResult = [[Weight alloc] initWithWeight:[rs stringForColumn:@"weight"] bmi:[rs stringForColumn:@"bmi"] time:[rs longForColumn:@"recordtime"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"]];
            
            weightResult.weight=[DBHelper decryptionString: weightResult.weight];
            weightResult.bmi=[DBHelper decryptionString: weightResult.bmi];
            
            
            
            [tmpArray addObject:weightResult];
        }
        [rs close];
        [db close];
        
        [resultList setWeightList:[NSArray arrayWithArray:tmpArray]];
    }];
    
    if (resultList.weightList!=nil) {
        if ([resultList.weightList count]>0) {
            [resultList setWeight:[resultList.weightList objectAtIndex:0]];
        }
    }
    return resultList;
    
}

+ (void)delWeightAverageChart{
    
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        
        
        NSString *sql=[NSString stringWithFormat:@"DELETE FROM weight_average_chart"];
        
        
        [db executeUpdate:sql];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
    
    
}


+ (BOOL) addWeightAverageChartRecord:(Weight *)weight{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM weight_average_chart WHERE recordtime = %ld AND status=%d",[weight getRecordtime],[weight getStatus]];
        FMResultSet *check = [db executeQuery:checkSql];
        [check next];
        
        if ([check resultDictionary]){
            
            NSLog(@"updating weight record");
            
            NSString *sql = [[NSString alloc]init];
            sql = [NSString stringWithFormat:@"UPDATE weight_average_chart SET weight=\"%@\", bmi=\"%@\", createtime=%ld, uploadtime=%ld, status=%d, missprevious=%d WHERE recordtime=%ld", weight.weight==nil?@"0":            [DBHelper encryptionString:weight.weight]
                   , weight.bmi==nil?@"0":            [DBHelper encryptionString:weight.bmi]
                   , [weight getRecordtime], [weight getRecordtime], [weight getStatus], [weight getMissprevious], [weight getRecordtime]];
            
            
            
            
            NSLog(@"update weight record sql:%@",sql);
            result = [db executeUpdate:sql];
            
            if ([db hadError]&&result==NO){
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result = NO;
            }
        } else {
            NSLog(@"adding weight record");
            
            NSString *sql = [[NSString alloc]init];
            sql = [NSString stringWithFormat:@"INSERT INTO weight_average_chart(weight,bmi,recordtime,createtime,uploadtime,status,missprevious) VALUES (\"%@\",\"%@\",%ld,%ld,%ld,%d,%d)", weight.weight==nil?@"0":            [DBHelper encryptionString:weight.weight]
                   , weight.bmi==nil?@"0":            [DBHelper encryptionString:weight.bmi]
                   , [weight getRecordtime], [weight getRecordtime], [weight getRecordtime], [weight getStatus], [weight getMissprevious]];
            
            NSLog(@"Insert weight record sql:%@",sql);
            result = [db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
        }
        [check close];
        [db commit];
        [db close];
        
    }];
    return result;
}

+ (BOOL) addWeightWeekRecord:(Weight *)weight weekno:(NSString *)weekno weekstart:(NSString *)weekstart weekend:(NSString *)weekend
{
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM weight_average WHERE weekno = \"%@\"",weekno];
        FMResultSet *checkRS = [db executeQuery:checkSql];
        [checkRS next];
        
        if ([checkRS resultDictionary]) {
            NSString *updateSql = [NSString stringWithFormat:@"UPDATE weight_average SET weight=\"%@\", bmi=\"%@\" WHERE weekno=\"%@\"",weight.weight==nil?@"0":weight.weight, weight.bmi==nil?@"0":weight.bmi, weekno];
            NSLog(@"!!updateWeightRecord sql:%@",updateSql);
            result = [db executeUpdate:updateSql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
        } else {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO weight_average (weight, bmi, recordtime, createtime, uploadtime, status, weekstart, weekend, weekno, missprevious) VALUES (\"%@\", \"%@\", %ld, %ld, %ld, %d, \"%@\", \"%@\", \"%@\", %d)",weight.weight==nil?@"0":weight.weight, weight.bmi==nil?@"0":weight.bmi, [weight getRecordtime], [weight getRecordtime], [weight getRecordtime], [weight getStatus], weekstart, weekend, weekno, [weight getMissprevious]];
            NSLog(@"!!insertWeightRecord sql:%@",sql);
            result = [db executeUpdate:sql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
        }
        [db commit];
        [db close];
        
    }];
    return result;
}

+ (BOOL) addWeightMonthRecord:(Weight *)weight month:(NSString *)month
{
    NSLog(@"addWeightMonthRecord:%@, month:%@",weight,month);
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT month FROM weight_average WHERE month = \"%@\"",month];
        FMResultSet *checkRS = [db executeQuery:checkSql];
        [checkRS next];
        
        if ([checkRS resultDictionary])
        {
            
            NSString *updateSql = [NSString stringWithFormat:@"UPDATE weight_average SET weight = \"%@\", bmi =\"%@\" WHERE month = \"%@\"",weight.weight==nil?@"0":weight.weight, weight.bmi==nil?@"0":weight.bmi, month];
            NSLog(@"!!updateBPMonthRecord sql:%@",updateSql);
            result = [db executeUpdate:updateSql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
        } else {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO weight_average (weight, bmi, recordtime, createtime, uploadtime, status, month, missprevious) VALUES (\"%@\", \"%@\", %ld, %ld, %ld, %d, \"%@\", %d)",weight.weight==nil?@"0":weight.weight, weight.bmi==nil?@"0":weight.bmi, [weight getRecordtime], [weight getRecordtime], [weight getRecordtime], [weight getStatus], month, [weight getMissprevious]];
            NSLog(@"!!insertWeightMonthRecord sql:%@",sql);
            result = [db executeUpdate:sql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
        }
        //        }
        //        [checkRS close];
        [db commit];
        [db close];
    }];
    return result;
    
}

+ (NSArray *)getAllWeightMonthRecord;
{
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM weight_average WHERE ((month IS NOT NULL) AND NOT(month = \"(null)\")) ORDER BY month DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        int numberOfRecords = 1;
        while ([rs next] && (numberOfRecords <= 4)) {
            numberOfRecords++;
            NSMutableDictionary *eachEntry = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                              [DBHelper decryptionString: [rs stringForColumn:@"weight"]]
                                              , @"weight",
                                              [DBHelper decryptionString: [rs stringForColumn:@"bmi"]]
                                              , @"bmi",
                                              [rs stringForColumn:@"month"], @"month", nil];
            
            
            
            
            
            
            [returnArray addObject:eachEntry];
        }
        [db close];
        [rs close];
    }];
    return returnArray;
}

+ (NSArray *)getAllWeightWeekRecord
{
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM weight_average WHERE ((weekno IS NOT NULL) AND NOT(weekno = \"(null)\")) ORDER BY weekno DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        NSString *lastWeek = @"";
        int numberOfMonth = 1;
        while ([rs next] && (numberOfMonth <= 3)) {
            if ([lastWeek isEqualToString:@""])
                lastWeek = [[rs stringForColumn:@"weekstart"] substringToIndex:7];
            
            if (![[[rs stringForColumn:@"weekstart"] substringToIndex:7] isEqualToString:lastWeek]) {
                numberOfMonth ++;
                lastWeek = [[rs stringForColumn:@"weekstart"] substringToIndex:7];
            }
            NSMutableDictionary *eachEntry = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                              [DBHelper decryptionString: [rs stringForColumn:@"weight"]], @"weight",
                                              [DBHelper decryptionString: [rs stringForColumn:@"bmi"]], @"bmi",
                                              [rs stringForColumn:@"weekno"], @"weekno",
                                              [rs stringForColumn:@"weekstart"], @"weekstart",
                                              [rs stringForColumn:@"weekend"], @"weekend", nil];
            
            
            
            
            
            [returnArray addObject:eachEntry];
        }
        
        
        [db close];
        [rs close];
    }];
    return returnArray;
}

+ (void)generateWeightBlankWeekRecords
{
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        [db beginTransaction];
        
        NSDate *currentNSDate = [[NSDate alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *currentDateString = [dateFormatter stringFromDate:currentNSDate];
        int currentYear = [[currentDateString substringToIndex:4]intValue];
        int currentMonth = [[currentDateString substringFromIndex:6]intValue];
        FMResultSet *checkRS = [[FMResultSet alloc]init];
        
        BOOL firstWeekFound = FALSE;
        NSDate *lastWeekEnd = [[NSDate alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        int headYear = [syncUtility getHeadYear];
        
        for (int rollingYear = headYear; rollingYear <= currentYear; rollingYear++) {
            
            int rollingStartWeek,rollingEndWeek;
            if (headYear==currentYear) {
                rollingStartWeek = [syncUtility getHeadMonth]*4;
                rollingEndWeek = currentMonth*5>52?52:currentMonth * 5;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartWeek = 1;
                    rollingEndWeek = currentMonth*5>52?52:currentMonth * 5;
                } else {
                    rollingStartWeek = [syncUtility getHeadMonth]*4;
                    rollingEndWeek = 52;
                }
            }
            
            for (int rollingWeek = rollingStartWeek; rollingWeek <= rollingEndWeek; rollingWeek++ ) {
                NSString *rollingString = @"";
                if (rollingWeek < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingWeek];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingWeek];
                
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM weight_average WHERE weekno = \"%@\"",rollingString];
                NSLog(@"!!chekcSQL:%@",checkSQL);
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (firstWeekFound == FALSE)
                        firstWeekFound = TRUE;
                    lastWeekEnd = [dateFormatter dateFromString:[checkRS stringForColumn:@"weekend"]];
                    NSLog(@"!!Found & lastWeekEnd after change:%@",lastWeekEnd);
                } else {
                    if (firstWeekFound == TRUE){
                        NSDate *pickDate =  [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([lastWeekEnd timeIntervalSinceReferenceDate] + 24*3600)];
                        NSDictionary *weekDatesDictionary = [Utility generateWeekDatesFromDate:pickDate];
                        
                        NSLog(@"pickDate:%@ weekDatesDictionay:%@",pickDate ,weekDatesDictionary);
                        
                        NSString *weekstartNSString = [dateFormatter stringFromDate:[weekDatesDictionary objectForKey:@"startNSDate"]];
                        NSString *weekendNSString = [dateFormatter stringFromDate:[weekDatesDictionary objectForKey:@"endNSDate"]];
                        NSString *insertBlankSQL = [NSString stringWithFormat:@"INSERT INTO weight_average (weight,bmi,weekno,weekstart,weekend) VALUES (\"0\", \"0\", \"%@\", \"%@\", \"%@\")",rollingString, weekstartNSString, weekendNSString];
                        //NSLog(@"!!insertBlankSQL:%@",insertBlankSQL);
                        //[db executeUpdate:insertBlankSQL];
                        
                        NSDate *today=[[NSDate alloc] init];
                        NSDate *targetDay=[dateFormatter dateFromString:weekstartNSString];
                        
                        if ([today timeIntervalSince1970]>[targetDay timeIntervalSince1970]) {
                            
                            NSLog(@"insert Weight Blank Week SQL:%@",insertBlankSQL);
                            [db executeUpdate:insertBlankSQL];
                        }
                        
                        lastWeekEnd = [weekDatesDictionary objectForKey:@"endNSDate"];
                        NSLog(@"!!lastWeekEnd:%@",lastWeekEnd);
                    }
                }
            }
        }
        
        BOOL lastWeekFound = FALSE;
        
        for (int rollingYear = currentYear; rollingYear > headYear; rollingYear--) {

            int rollingStartWeek,rollingEndWeek;
            if (headYear==currentYear) {
                rollingStartWeek = [syncUtility getHeadMonth] * 4;
                rollingEndWeek = currentMonth*5>52?52:currentMonth * 5;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartWeek = 1;
                    rollingEndWeek =  currentMonth*5>52?52:currentMonth * 5;
                } else {
                    rollingStartWeek = [syncUtility getHeadMonth]*4;
                    rollingEndWeek = 52;
                }
            }

            for (int rollingWeek = rollingEndWeek; rollingWeek >= rollingStartWeek; rollingWeek--){
                
                NSString *rollingString = @"";
                if (rollingWeek < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingWeek];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingWeek];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM weight_average WHERE weekno = \"%@\" AND NOT(weight = \"0\")",rollingString];
                //                    NSLog(@"!!checkSQL:%@",checkSQL);
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (lastWeekFound == FALSE)
                        lastWeekFound = TRUE;
                } else if (lastWeekFound == FALSE) {
                    NSString *deleteBlankSQL = [NSString stringWithFormat:@"DELETE FROM weight_average WHERE weekno = \"%@\" ",rollingString];
                    //                        NSLog(@"!!deleteBlankSQL:%@",deleteBlankSQL);
                    [db executeUpdate:deleteBlankSQL];
                }
                
                
            }
        }
        
        [checkRS close];
        [db commit];
        [db close];
    }];
}

+ (void)generateWeightBlankMonthRecords
{
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        
        [db open];
        [db beginTransaction];
        NSDate *currentNSDate = [[NSDate alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *currentDateString = [dateFormatter stringFromDate:currentNSDate];
        int currentYear = [[currentDateString substringToIndex:4]intValue];
        int currentMonth = [[currentDateString substringFromIndex:6]intValue];
        FMResultSet *checkRS = [[FMResultSet alloc]init];
        
        BOOL firstMonthFound = FALSE;
        
        int headYear = [syncUtility getHeadYear];
        int headMonth = [syncUtility getHeadMonth];
        
        for (int rollingYear = headYear; rollingYear <= currentYear; rollingYear++) {
            
            int rollingStartMonth,rollingEndMonth;
            if (headYear==currentYear) {
                rollingStartMonth = [syncUtility getHeadMonth];
                rollingEndMonth = currentMonth;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartMonth = 1;
                    rollingEndMonth = currentMonth;
                } else {
                    rollingStartMonth = headMonth;
                    rollingEndMonth = 12;
                }
            }
            
            for (int rollingMonth = rollingStartMonth; rollingMonth <= rollingEndMonth; rollingMonth++ ){
                
                NSString *rollingString = @"";
                if (rollingMonth < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingMonth];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingMonth];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM weight_average WHERE month = \"%@\"",rollingString];
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (firstMonthFound == FALSE)
                        firstMonthFound = TRUE;
                } else {
                    if (firstMonthFound == TRUE){
                        NSString *insertBlankSQL = [NSString stringWithFormat:@"INSERT INTO weight_average (weight,bmi,month) VALUES (\"0\", \"0\", \"%@\")",rollingString];
                        [db executeUpdate:insertBlankSQL];
                    }
                    
                }
                
            }
        }
        BOOL lastMonthFound = FALSE;
        
        for (int rollingYear = currentYear; rollingYear >= headYear; rollingYear--) {
            int rollingStartMonth,rollingEndMonth;
            if (headYear==currentYear) {
                rollingStartMonth = [syncUtility getHeadMonth];
                rollingEndMonth = currentMonth;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartMonth = 1;
                    rollingEndMonth = currentMonth;
                } else {
                    rollingStartMonth = headMonth;
                    rollingEndMonth = 12;
                }
            }
            
            for (int rollingMonth = rollingEndMonth; rollingMonth >= rollingStartMonth; rollingMonth--){
                
                NSLog(@"rollingYear:%d, rollingMonth:%d", rollingYear, rollingMonth);
                NSString *rollingString = @"";
                if (rollingMonth < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingMonth];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingMonth];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM weight_average WHERE month = \"%@\" AND NOT(weight = \"0\")",rollingString];
                NSLog(@"!!checkSQL:%@",checkSQL);
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (lastMonthFound == FALSE)
                        lastMonthFound = TRUE;
                } else if (lastMonthFound == FALSE) {
                    NSString *deleteBlankSQL = [NSString stringWithFormat:@"DELETE FROM weight_average WHERE month = \"%@\" ",rollingString];
                    NSLog(@"!!deleteBlankSQL:%@",deleteBlankSQL);
                    [db executeUpdate:deleteBlankSQL];
                }
                
                
            }
        }
        
        [checkRS close];
        [db commit];
        [db close];
    }];
}

#pragma mark -
#pragma mark BG


+ (BloodGlucoseList *) getBGByDate:(long)start enddate:(long)end status:(NSInteger)thestatus{
    
    
    __block BloodGlucoseList *resultList = [[BloodGlucoseList alloc] init];
    [resultList setPeriodstart:start];
    [resultList setPeriodend:end];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM blood_glucose WHERE status=%ld AND recordtime BETWEEN %ld AND %ld order by recordtime desc",(long)thestatus,start,end];
        
        if (start==0&&end==0) {
            sql=[NSString stringWithFormat:@"SELECT * FROM blood_glucose WHERE status=%ld order by recordtime desc",(long)thestatus];
        }
        
        if (thestatus==-1) {
            
            sql=[NSString stringWithFormat:@"SELECT * FROM blood_glucose WHERE status=1 OR status=0 AND recordtime BETWEEN %ld AND %ld order by recordtime desc",start,end];
        }
        
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            BloodGlucose *bgResult = [[BloodGlucose alloc] initWithBG:[rs stringForColumn:@"bg"] time:[rs longForColumn:@"recordtime"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"] type:[rs stringForColumn:@"type"]];
            
            bgResult.bg= [DBHelper decryptionString: bgResult.bg];
            
            
            [tmpArray addObject:bgResult];
        }
        [rs close];
        [db close];
        
        [resultList setBgList:[NSArray arrayWithArray:tmpArray]];
    }];
    
    if (resultList.bgList!=nil) {
        if ([resultList.bgList count]>0) {
            [resultList setBg:[resultList.bgList objectAtIndex:0]];
        }
    }
    return resultList;
    
}


+ (BOOL) addBGRecord:(BloodGlucose *)bg{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM blood_glucose WHERE recordtime = %ld",[bg getRecordtime]];
        FMResultSet *check = [db executeQuery:checkSql];
        [check next];
        
        if ([check resultDictionary]){
            
            NSLog(@"updating BG record");
            
            NSString *sql = [[NSString alloc]init];
            sql = [NSString stringWithFormat:@"UPDATE blood_glucose SET bg=\"%@\", createtime=%ld, uploadtime=%ld, status=%d, missprevious=%d, type=\"%@\" WHERE recordtime=%ld", bg.bg==nil?@"0":bg.bg, [bg getRecordtime], [bg getRecordtime], [bg getStatus], [bg getMissprevious], bg.type, [bg getRecordtime]];
            
            NSLog(@"update BG record sql:%@",sql);
            result = [db executeUpdate:sql];
            
            if ([db hadError]&&result==NO){
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result = NO;
            }
        } else {
            NSLog(@"adding BG record");
            
            NSString *sql = [[NSString alloc]init];
            sql = [NSString stringWithFormat:@"INSERT INTO blood_glucose(bg,recordtime,createtime,uploadtime,status,missprevious,type) VALUES (\"%@\",%ld,%ld,%ld,%d,%d,\"%@\")", bg.bg==nil?@"0":bg.bg, [bg getRecordtime], [bg getRecordtime], [bg getRecordtime], [bg getStatus], [bg getMissprevious], bg.type];
            
            NSLog(@"Insert BG record sql:%@",sql);
            result = [db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
        }
        [check close];
        [db commit];
        [db close];
        
    }];
    return result;
}




+ (BloodGlucose *)getNewestBGRecord{
    __block BloodGlucose *bgResult = [[BloodGlucose alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT bg,recordtime,status,missprevious,type FROM blood_glucose ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        if ([rs next]){
            bgResult = [bgResult initWithBG:[rs stringForColumn:@"bg"] time:[rs longForColumn:@"recordtime"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"] type:[rs stringForColumn:@"type"]];
            bgResult.bg= [DBHelper decryptionString: bgResult.bg];
            
        }
    }];
    return bgResult;
}





+ (NSMutableArray *)getBGHistoryRecord{
    
    __block NSMutableArray *bgResultArray = [[NSMutableArray alloc]init];
    __block NSDictionary *bgResultDict;
    __block BloodGlucose *bgResult = [[BloodGlucose alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT bg,recordtime,status,missprevious,type FROM blood_glucose ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        int entryNum = 0;
        long beforeThreeMonthTiming = [[NSDate date]timeIntervalSince1970] - 60*60*24*31*3;
        while([rs next]){
            if ([rs longForColumn:@"recordtime"] < beforeThreeMonthTiming)
                break;
            bgResult = [bgResult initWithBG:[rs stringForColumn:@"bg"] time:[rs longForColumn:@"recordtime"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"] type:[rs stringForColumn:@"type"]];
            
            
            bgResult.bg= [DBHelper decryptionString: bgResult.bg];
            
            NSLog(@"bg value........%@",bgResult.bg);
            
            bgResultDict = [NSDictionary dictionaryWithObjectsAndKeys:
                            [bgResult bg],@"bg",
                            [bgResult timeStr],@"time",
                            [bgResult type],@"type",nil];
            
            if (!(entryNum==0)){
                [bgResultArray addObject:bgResultDict];
            }
            entryNum++;
        }
    }];
    return bgResultArray;
}

+ (NSString *)getNewestBGDate_DB{
    __block NSString *newestDate  = [[NSString alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT recordtime FROM blood_glucose ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            newestDate = [rs stringForColumn:@"recordtime"];
            break;
        }
    }];
    return newestDate;
}

+ (NSMutableArray *)getBGNotUpload{
    
    __block BloodGlucose *bgRecord = [[BloodGlucose alloc]init];
    
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT bg,recordtime,status,type FROM blood_glucose WHERE status=1"];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            if ([rs intForColumn:@"status"]==1){
                bgRecord = [bgRecord initWithBG:[rs stringForColumn:@"bg"] time:[rs longForColumn:@"recordtime"] status:NO missprevious:NO type:[rs stringForColumn:@"type"]];
                
                bgRecord.bg= [DBHelper decryptionString: bgRecord.bg];
                
                
                [returnArray addObject:bgRecord];
            }
        }
    }];
    return returnArray;
}


+ (BloodGlucoseList *) getBGAverageChartByDate:(long)start enddate:(long)end status:(NSInteger)thestatus{
    
    
    __block BloodGlucoseList *resultList = [[BloodGlucoseList alloc] init];
    [resultList setPeriodstart:start];
    [resultList setPeriodend:end];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM blood_glucose_average_chart WHERE status=%ld AND recordtime BETWEEN %ld AND %ld order by recordtime desc",(long)thestatus,start,end];
        
        if (start==0&&end==0) {
            sql=[NSString stringWithFormat:@"SELECT * FROM blood_glucose_average_chart WHERE status=%ld order by recordtime desc",(long)thestatus];
        }
        
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            BloodGlucose *bgResult = [[BloodGlucose alloc] initWithBG:[rs stringForColumn:@"bg"] time:[rs longForColumn:@"recordtime"] status:[rs intForColumn:@"status"] missprevious:[rs intForColumn:@"missprevious"] type:[rs stringForColumn:@"type"]];
            
            bgResult.bg= [DBHelper decryptionString: bgResult.bg];
            
            
            
            [tmpArray addObject:bgResult];
        }
        [rs close];
        [db close];
        
        [resultList setBgList:[NSArray arrayWithArray:tmpArray]];
    }];
    
    if (resultList.bgList!=nil) {
        if ([resultList.bgList count]>0) {
            [resultList setBg:[resultList.bgList objectAtIndex:0]];
        }
    }
    return resultList;
    
}

+ (void)delBGAverageChart{
    
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        
        
        NSString *sql=[NSString stringWithFormat:@"DELETE FROM blood_glucose_average_chart"];
        
        
        [db executeUpdate:sql];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
    
    
}


+ (BOOL) addBGAverageChartRecord:(BloodGlucose *)bg{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average_chart WHERE recordtime = %ld AND status=%d AND type=\"%@\"",[bg getRecordtime],[bg getStatus],bg.type];
        
        FMResultSet *check = [db executeQuery:checkSql];
        [check next];
        
        if ([check resultDictionary]){
            
            NSLog(@"updating BG record");
            
            NSString *sql = [[NSString alloc]init];
            sql = [NSString stringWithFormat:@"UPDATE blood_glucose_average_chart SET bg=\"%@\", createtime=%ld, uploadtime=%ld, status=%d, missprevious=%d, type=\"%@\" WHERE recordtime=%ld", bg.bg==nil?@"0":            [DBHelper encryptionString: bg.bg]
                   , [bg getRecordtime], [bg getRecordtime], [bg getStatus], [bg getMissprevious], bg.type, [bg getRecordtime]];
            
            
            
            
            NSLog(@"update BG record sql:%@",sql);
            result = [db executeUpdate:sql];
            
            if ([db hadError]&&result==NO){
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result = NO;
            }
        } else {
            NSLog(@"adding BG record");
            
            NSString *sql = [[NSString alloc]init];
            sql = [NSString stringWithFormat:@"INSERT INTO blood_glucose_average_chart(bg,recordtime,createtime,uploadtime,status,missprevious,type) VALUES (\"%@\",%ld,%ld,%ld,%d,%d,\"%@\")", bg.bg==nil?@"0":            [DBHelper encryptionString: bg.bg]
                   , [bg getRecordtime], [bg getRecordtime], [bg getRecordtime], [bg getStatus], [bg getMissprevious], bg.type];
            
            NSLog(@"Insert BG record sql:%@",sql);
            result = [db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
        }
        [check close];
        [db commit];
        [db close];
        
    }];
    return result;
}

+ (BOOL) addBGWeekRecord:(BloodGlucose *)bg weekno:(NSString *)weekno weekstart:(NSString *)weekstart weekend:(NSString *)weekend
{
    NSLog(@"addBGWeekRecord:%@, weekno:%@ weekstart:%@ weekend:%@",bg ,weekno, weekstart, weekend);
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average WHERE ((weekno = \"%@\") AND (type = \"%@\"))",weekno ,bg.type];
        FMResultSet *checkRS = [db executeQuery:checkSql];
        [checkRS next];
        
        if ([checkRS resultDictionary])
        {
            NSString *updateSql = [NSString stringWithFormat:@"UPDATE blood_glucose_average SET bg =\"%@\" WHERE ((weekno=\"%@\") AND (type=\"%@\"))", bg.bg, weekno, bg.type];
            NSLog(@"!!updateBGWeekRecord sql:%@",updateSql);
            result = [db executeUpdate:updateSql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
        } else {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO blood_glucose_average (bg, type, recordtime, createtime, uploadtime, status, weekno, weekstart, weekend, missprevious) VALUES (\"%@\", \"%@\", %ld, %ld, %ld, %d, \"%@\", \"%@\" ,\"%@\", %d)",bg.bg==nil?@"0":bg.bg, bg.type==nil?@"F":bg.type, [bg getRecordtime], [bg getRecordtime], [bg getRecordtime], [bg getStatus], weekno, weekstart, weekend, [bg getMissprevious]];
            NSLog(@"!!insertBGWeekRecord sql:%@",sql);
            result = [db executeUpdate:sql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
        }
        
        [db commit];
        [db close];
        
    }];
    return result;
}

+ (BOOL) addBGMonthRecord:(BloodGlucose *)bg month:(NSString *)month
{
    NSLog(@"addBGMonthRecord:%@, month:%@, type:%@",bg.bg ,month, bg.type);
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM blood_pressure_average WHERE ((month = \"%@\") AND (type = \"%@\"))",month,bg.type];
        NSLog(@"Check BG Sql:%@",checkSql);
        FMResultSet *checkRS = [db executeQuery:checkSql];
        [checkRS next];
        
        if ([checkRS resultDictionary])
        {
            NSString *updateSql = [NSString stringWithFormat:@"UPDATE blood_glucose_average SET bg=\"%@\" WHERE ((month = \"%@\") AND (type=\"%@\"))", bg.bg==nil?@"0":bg.bg, month, bg.type];
            NSLog(@"!!updateBGMonthRecord sql:%@",updateSql);
            result = [db executeUpdate:updateSql];
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        } else {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO blood_glucose_average (bg, type, recordtime, createtime, uploadtime, status, month, missprevious) VALUES (\"%@\", \"%@\", %ld, %ld, %ld, %d, \"%@\", %d)",bg.bg==nil?@"0":bg.bg, bg.type==nil?@"F":bg.type,  [bg getRecordtime], [bg getRecordtime], [bg getRecordtime], [bg getStatus], month, [bg getMissprevious]];
            NSLog(@"!!insertBGMonthRecord sql:%@",sql);
            result = [db executeUpdate:sql];
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
        }
        //        [checkRS close];
        [db commit];
        [db close];
    }];
    return result;
}

+ (NSArray *)getAllBGWeekRecord
{
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average WHERE ((weekno IS NOT NULL) AND NOT(weekno = \"(null)\")) ORDER BY weekno DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        NSLog(@"!!get BG week record sql:%@",selectSql);
        NSString *lastWeek = @"";
        int numberOfMonth = 1;
        NSMutableDictionary *eachEntry;
        
        
        
        
        
        while ([rs next] && (numberOfMonth <= 15)) {
            if ([lastWeek isEqualToString:@""]) {
                
//
                    lastWeek = [rs stringForColumn:@"weekno"];
                NSLog(@"first week :%@",[rs stringForColumn:@"weekno"]);
                
                eachEntry = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                             //                             [rs stringForColumn:@"bg"], [rs stringForColumn:@"type"],
                             [rs stringForColumn:@"weekno"], @"weekno",
                             [rs stringForColumn:@"weekstart"], @"weekstart",
                             [rs stringForColumn:@"weekend"], @"weekend", nil];
            }
            
//            NSLog(@"Vaycent check weekno:%@",[rs stringForColumn:@"weekno"]);
//            NSLog(@"Vaycent check weekstart:%@",[rs stringForColumn:@"weekstart"]);
//            NSLog(@"Vaycent check weekend:%@",[rs stringForColumn:@"weekend"]);
            
            
//            NSLog(@"Vaycent check [rs stringForColumn:@weekno]:%@",[rs stringForColumn:@"weekno"]);
//            NSLog(@"Vaycent check lastWeek:%@",lastWeek);

            
            if (![[rs stringForColumn:@"weekno"] isEqualToString:lastWeek]) {
                NSLog(@"aaaaaa");
                numberOfMonth ++;
                lastWeek = [rs stringForColumn:@"weekno"];
                NSLog(@"!!eachEntry:%@",eachEntry);
                [returnArray addObject:eachEntry];
                eachEntry = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                             //                             [rs stringForColumn:@"bg"]
                             
                             [DBHelper decryptionString: [rs stringForColumn:@"bg"]], [rs stringForColumn:@"type"],
                             [rs stringForColumn:@"weekno"], @"weekno",
                             [rs stringForColumn:@"weekstart"], @"weekstart",
                             [rs stringForColumn:@"weekend"], @"weekend", nil];
                
                
                
                
            } else {
                 NSLog(@"bbbbbb");
                //                [eachEntry setObject:[rs stringForColumn:@"bg"] forKey:[rs stringForColumn:@"type"]];
                
                NSLog(@"bbbs's bg :%@",[DBHelper decryptionString: [rs stringForColumn:@"bg"]]);
                [eachEntry setObject: [DBHelper decryptionString: [rs stringForColumn:@"bg"]]
                              forKey:[rs stringForColumn:@"type"]];
                
                
                
            }
//            for(int i=0;i<returnArray.count;i++){
//            NSLog(@"Vaycent check weekno:%@",[[returnArray objectAtIndex:i ] objectForKey:@"weekno"]);
//            NSLog(@"Vaycent check weekstart:%@",[[returnArray objectAtIndex:i ] objectForKey:@"weekstart"]);
//            NSLog(@"Vaycent check weekend:%@",[[returnArray objectAtIndex:i ] objectForKey:@"weekend"]);
//            NSLog(@"***********************");
//            }

        }
        
        if(eachEntry!=NULL)
            [returnArray addObject:eachEntry];
        
        
        [db close];
        [rs close];
    }];
    return returnArray;
}

+ (NSArray *)getAllBGMonthRecord;
{
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average WHERE ((month IS NOT NULL) AND NOT(month = \"(null)\")) ORDER BY month DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        NSLog(@"!!get BG month record sql:%@",selectSql);
        int numberOfMonth = 1;
        NSString *lastMonth = @"";
        NSMutableDictionary *eachEntry;
        while ([rs next] && (numberOfMonth < 5)) {
            NSLog(@"!!numberOfMonth:%d, lastMonth:%@",numberOfMonth,lastMonth);
            if ([lastMonth isEqualToString:@""]) {
                lastMonth = [[rs stringForColumn:@"month"] substringToIndex:7];
                eachEntry = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[rs stringForColumn:@"month"], @"month", nil];
                [returnArray addObject:eachEntry];
            }
            if (![[[rs stringForColumn:@"month"] substringToIndex:7] isEqualToString:lastMonth]) {
                numberOfMonth ++;
                lastMonth = [[rs stringForColumn:@"month"] substringToIndex:7];
                
                NSLog(@"!!eachEntry:%@",eachEntry);
                eachEntry = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[rs stringForColumn:@"month"], @"month",
                             //                             [rs stringForColumn:@"bg"]
                             
                             [DBHelper decryptionString: [rs stringForColumn:@"bg"]]
                             , [rs stringForColumn:@"type"], nil];
                [returnArray addObject:eachEntry];
            } else {
                [eachEntry setObject:                 [DBHelper decryptionString: [rs stringForColumn:@"bg"]]
                              forKey:[rs stringForColumn:@"type"]];
            }
        }
        [db close];
        [rs close];
    }];
    return returnArray;
}

+ (void)generateBGBlankWeekRecords
{
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        [db beginTransaction];
        
        NSDate *currentNSDate = [[NSDate alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *currentDateString = [dateFormatter stringFromDate:currentNSDate];
        int currentYear = [[currentDateString substringToIndex:4]intValue];
        int currentMonth = [[currentDateString substringFromIndex:6]intValue];
        FMResultSet *checkRS = [[FMResultSet alloc]init];
        
        BOOL firstWeekFound = FALSE;
        NSDate *lastWeekEnd = [[NSDate alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSArray *rollingTypeArray = [NSArray arrayWithObjects:@"F", @"A", @"B", @"U", nil];
        
        int headYear = [syncUtility getHeadYear];
        
        for (int rollingYear = headYear; rollingYear <= currentYear; rollingYear++) {
            
            int rollingStartWeek,rollingEndWeek;
            if (headYear==currentYear) {
                rollingStartWeek = [syncUtility getHeadMonth] * 4;
                rollingEndWeek = currentMonth*5>52?52:currentMonth * 5;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartWeek = 1;
                    rollingEndWeek = currentMonth*5>52?52:currentMonth * 5;
                } else {
                    rollingStartWeek = [syncUtility getHeadMonth]*4;
                    rollingEndWeek = 52;
                }
            }
            
            for (int rollingWeek = rollingStartWeek; rollingWeek <= rollingEndWeek; rollingWeek++ ) {
                NSString *rollingString = @"";
                if (rollingWeek < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingWeek];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingWeek];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average WHERE (weekno = \"%@\")",rollingString];
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                // with bg records
                if ([checkRS resultDictionary]) {
                    if (firstWeekFound == FALSE)
                        firstWeekFound = TRUE;
                    lastWeekEnd = [dateFormatter dateFromString:[checkRS stringForColumn:@"weekend"]];
                    NSString *weekstartNSString = [checkRS stringForColumn:@"weekstart"];
                    NSString *weekendNSString = [checkRS stringForColumn:@"weekend"];
                    FMResultSet *checkTypeRS = [[FMResultSet alloc]init];
                    for (NSString *rollingType in rollingTypeArray) {
                        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average WHERE ((weekno = \"%@\") AND (type = \"%@\"))",rollingString, rollingType];
                        checkTypeRS = [db executeQuery:querySQL];
                        [checkTypeRS next];
                        if (![checkTypeRS resultDictionary]) {
                            NSString *insertBlankSQL = [NSString stringWithFormat:@"INSERT INTO blood_glucose_average (bg,weekno,weekstart,weekend,type) VALUES (\"0\", \"%@\", \"%@\", \"%@\",\"%@\")",rollingString, weekstartNSString, weekendNSString,rollingType];
                            [db executeUpdate:insertBlankSQL];
                        } else {
                            // Evan 20150318
                            NSString *updateSQL = [NSString stringWithFormat:@"UPDATE blood_glucose_average SET (weekno, weekstart, weekend) VALUES (\"%@\", \"%@\", \"%@\")",rollingString, weekstartNSString, weekendNSString];
                            NSLog(@"!!new update SQL:%@",updateSQL);
                            [db executeUpdate:updateSQL];
                        }
                        [checkTypeRS close];
                    }
                } else {
                    // no bg record in this week
                    if (firstWeekFound == TRUE){
                        NSDate *pickDate =  [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([lastWeekEnd timeIntervalSinceReferenceDate] + 24*3600)];
                        NSDictionary *weekDatesDictionary = [Utility generateWeekDatesFromDate:pickDate];
                        
                        NSLog(@"pickDate:%@ weekDatesDictionay:%@",pickDate ,weekDatesDictionary);
                        
                        NSString *weekstartNSString = [dateFormatter stringFromDate:[weekDatesDictionary objectForKey:@"startNSDate"]];
                        NSString *weekendNSString = [dateFormatter stringFromDate:[weekDatesDictionary objectForKey:@"endNSDate"]];
                        
                        for (NSString *rollingType in rollingTypeArray) {
                            NSString *insertBlankSQL = [NSString stringWithFormat:@"INSERT INTO blood_glucose_average (bg,weekno,weekstart,weekend,type) VALUES (\"0\", \"%@\", \"%@\", \"%@\",\"%@\")",rollingString, weekstartNSString, weekendNSString,rollingType];
                            //NSLog(@"!!insertBlankSQL:%@",insertBlankSQL);
                            //[db executeUpdate:insertBlankSQL];
                            
                            NSDate *today=[[NSDate alloc] init];
                            NSDate *targetDay=[dateFormatter dateFromString:weekstartNSString];
                            
                            if ([today timeIntervalSince1970]>[targetDay timeIntervalSince1970]) {
                                
                                NSLog(@"insert BG Blank Week SQL:%@",insertBlankSQL);
                                [db executeUpdate:insertBlankSQL];
                            }
                        }
                        lastWeekEnd = [weekDatesDictionary objectForKey:@"endNSDate"];
                        NSLog(@"!!lastWeekEnd:%@",lastWeekEnd);
                    }
                }
            }
        }
        
        BOOL lastWeekFound = FALSE;
        for (int rollingYear = currentYear; rollingYear > headYear; rollingYear--) {

            int rollingStartWeek,rollingEndWeek;
            if (headYear==currentYear) {
                rollingStartWeek = [syncUtility getHeadMonth] * 4;
                rollingEndWeek = currentMonth*5>52?52:currentMonth * 5;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartWeek = 1;
                    rollingEndWeek =  currentMonth*5>52?52:currentMonth * 5;
                } else {
                    rollingStartWeek = [syncUtility getHeadMonth]*4;
                    rollingEndWeek = 52;
                }
            }
            
            for (int rollingWeek = rollingEndWeek; rollingWeek >= rollingStartWeek; rollingWeek--){
                
                NSString *rollingString = @"";
                if (rollingWeek < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingWeek];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingWeek];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average WHERE weekno = \"%@\" AND NOT(bg = \"0\")",rollingString];
                //                    NSLog(@"!!checkSQL:%@",checkSQL);
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (lastWeekFound == FALSE)
                        lastWeekFound = TRUE;
                } else if (lastWeekFound == FALSE) {
                    NSString *deleteBlankSQL = [NSString stringWithFormat:@"DELETE FROM blood_glucose_average WHERE weekno = \"%@\" ",rollingString];
                    //                        NSLog(@"!!deleteBlankSQL:%@",deleteBlankSQL);
                    [db executeUpdate:deleteBlankSQL];
                }
                
                
            }
        }
        
        [checkRS close];
        [db commit];
        [db close];
    }];
}

+ (void)generateBGBlankMonthRecords
{
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        
        [db open];
        [db beginTransaction];
        NSDate *currentNSDate = [[NSDate alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *currentDateString = [dateFormatter stringFromDate:currentNSDate];
        int currentYear = [[currentDateString substringToIndex:4]intValue];
        int currentMonth = [[currentDateString substringFromIndex:6]intValue];
        FMResultSet *checkRS = [[FMResultSet alloc]init];
        
        BOOL firstMonthFound = FALSE;
        NSArray *rollingTypeArray = [NSArray arrayWithObjects:@"F", @"A", @"B", @"U", nil];
        
        int headYear = [syncUtility getHeadYear];
        int headMonth = [syncUtility getHeadMonth];
        
        for (int rollingYear = headYear; rollingYear <= currentYear; rollingYear++) {
            
            int rollingStartMonth,rollingEndMonth;
            if (headYear==currentYear) {
                rollingStartMonth = [syncUtility getHeadMonth];
                rollingEndMonth = currentMonth;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartMonth = 1;
                    rollingEndMonth = currentMonth;
                } else {
                    rollingStartMonth = headMonth;
                    rollingEndMonth = 12;
                }
            }
            
            for (int rollingMonth = rollingStartMonth; rollingMonth <= rollingEndMonth; rollingMonth++ ){
                for (NSString *rollingType in rollingTypeArray){
                    NSString *rollingString = @"";
                    if (rollingMonth < 10)
                        rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingMonth];
                    else
                        rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingMonth];
                    
                    NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average WHERE ((month = \"%@\") AND (type = \"%@\"))",rollingString, rollingType];
                    checkRS = [db executeQuery:checkSQL];
                    [checkRS next];
                    
                    if ([checkRS resultDictionary]) {
                        if (firstMonthFound == FALSE)
                            firstMonthFound = TRUE;
                    } else {
                        if (firstMonthFound == TRUE){
                            NSString *insertBlankSQL = [NSString stringWithFormat:@"INSERT INTO blood_glucose_average (bg,type,month) VALUES (\"0\", \"%@\", \"%@\")", rollingType, rollingString];
                            NSLog(@"!!Insert blank BG SQL:%@",insertBlankSQL);
                            [db executeUpdate:insertBlankSQL];
                        }
                        
                    }
                    
                }
            }
        }
        BOOL lastMonthFound = FALSE;
        
        for (int rollingYear = currentYear; rollingYear >= headYear; rollingYear--) {

            int rollingStartMonth,rollingEndMonth;
            if (headYear==currentYear) {
                rollingStartMonth = [syncUtility getHeadMonth];
                rollingEndMonth = currentMonth;
            } else {
                if (rollingYear == currentYear) {
                    rollingStartMonth = 1;
                    rollingEndMonth = currentMonth;
                } else {
                    rollingStartMonth = headMonth;
                    rollingEndMonth = 12;
                }
            }

            for (int rollingMonth = rollingEndMonth; rollingMonth >= rollingStartMonth; rollingMonth--){
                
                NSLog(@"rollingYear:%d, rollingMonth:%d", rollingYear, rollingMonth);
                NSString *rollingString = @"";
                if (rollingMonth < 10)
                    rollingString = [NSString stringWithFormat:@"%d-0%d",rollingYear ,rollingMonth];
                else
                    rollingString = [NSString stringWithFormat:@"%d-%d",rollingYear ,rollingMonth];
                
                NSString *checkSQL = [NSString stringWithFormat:@"SELECT * FROM blood_glucose_average WHERE month = \"%@\" AND NOT(bg = \"0\")",rollingString];
                NSLog(@"!!checkSQL:%@",checkSQL);
                checkRS = [db executeQuery:checkSQL];
                [checkRS next];
                
                if ([checkRS resultDictionary]) {
                    if (lastMonthFound == FALSE)
                        lastMonthFound = TRUE;
                } else if (lastMonthFound == FALSE) {
                    NSString *deleteBlankSQL = [NSString stringWithFormat:@"DELETE FROM blood_glucose_average WHERE month = \"%@\" ",rollingString];
                    NSLog(@"!!deleteBlankSQL:%@",deleteBlankSQL);
                    [db executeUpdate:deleteBlankSQL];
                }
                
                
            }
        }
        
        [checkRS close];
        [db commit];
        [db close];
    }];
}


#pragma mark
#pragma mark Daily
#pragma mark -----
#pragma mark Daily-BP
//创建表 或者 更新表
+(BOOL)addCalendarRoadBP:(Alarm *)DiaryAll
{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //  NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bp SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime,[DiaryAll bpID]];
            
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //      NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_bp(id,time,type,repeat,createtime,servertime) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime];
            
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}

//把表的內容變成數組拿下來
+(NSMutableArray *)getCalendarBPRecode
{
    
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    __block NSDictionary *objDIc;
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,time,type,repeat,createtime,servertime FROM calendar_bp"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         while ([rs next]) {
             
             akarn=[akarn initWithBPId:[rs stringForColumn:@"id"] bpRepeat:[rs stringForColumn:@"repeat"] bptime:[rs stringForColumn:@"time"] bptype:[rs stringForColumn:@"type"] bpcreatetime:[rs stringForColumn:@"createtime"] bpservertime:[rs stringForColumn:@"servertime"]];
             
             objDIc=[NSDictionary dictionaryWithObjectsAndKeys:
                     [akarn bpID],@"id",
                     [akarn bpTime],@"time",
                     nil];
             
             
             [calendarResultArray addObject:objDIc];
             
         }
     }];
    
    
    return calendarResultArray;
    
    
}
+(void)getTheCalendarBPRecodeFor_id
{
    
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,time,type,repeat,createtime,servertime FROM calendar_bp WHERE id <-1000"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         while ([rs next]) {
             
             akarn=[akarn initWithBPId:[rs stringForColumn:@"id"] bpRepeat:[rs stringForColumn:@"repeat"] bptime:[rs stringForColumn:@"time"] bptype:[rs stringForColumn:@"type"] bpcreatetime:[rs stringForColumn:@"createtime"] bpservertime:[rs stringForColumn:@"servertime"]];
             
             [calendarResultArray addObject:[akarn bpTime]];
             
         }
     }];
    NSString *uRL_str;
    for (int i=0; i<calendarResultArray.count; i++)
    {
        if (i<calendarResultArray.count-1)
        {
            NSString *temp_st=[NSString stringWithFormat:@"%@,",[calendarResultArray objectAtIndex:i]];
            uRL_str =[uRL_str stringByAppendingString:temp_st];
        }
        else
        {
            NSString *temp_st=[NSString stringWithFormat:@"%@",[calendarResultArray objectAtIndex:i]];
            uRL_str =[uRL_str stringByAppendingString:temp_st];
        }
        
    }
    NSLog(@"------%@",uRL_str);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    NSString *url_string = [[NSString alloc]init];
    //  url_string = [url_string stringByAppendingString:apiBaseURL];
    url_string = [url_string stringByAppendingString:@"login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&action=U"];
    url_string = [url_string stringByAppendingString:@"&type=B"];
    url_string = [url_string stringByAppendingString:@"&id=-1"];
    url_string = [url_string stringByAppendingString:@"&time="];
    url_string = [url_string stringByAppendingString:uRL_str];
    url_string = [url_string stringByAppendingString:@"&createtime="];
    url_string = [url_string stringByAppendingString:currentDateStr];
    
    
    
    NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
    
    NSURL *request_url = [NSURL URLWithString:encodedString];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [ NSData dataWithBytes: [ [uRL_str encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
    [request setHTTPBody:requestData];
    NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"%@+_+_+_",ionaSr);
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (data != nil && error == nil)
                               {
                                   //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                   // It worked, your source HTML is in sourceHTML
                                   
                                   NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
                                   NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
                                   
                               }
                               else
                               {
                                   // There was an error, alert the user
                               }
                               
                           }];
    
    
    
}

+(BOOL)deleteCalendarBPList
{
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM calendar_bp WHERE id" ];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         
         [check next];
         
         
         NSLog(@"Delete....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id"];
         // NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bp SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime,[DiaryAll bpID]];
         result=[db executeUpdate:sql];
         //NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
}


#pragma mark Daily-BG
+(BOOL)addCalendarRoadBG:(Alarm*)DiaryAll
{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_bg WHERE id =\"%@\"",DiaryAll.bgID];
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"UPDATE");
            //     NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bg SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bgID,DiaryAll.bgTime,DiaryAll.bgType,DiaryAll.bgRepeat,DiaryAll.bgCreateTime,DiaryAll.bgServerTime,[DiaryAll bgID]];
            
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //   NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_bg(id,time,type,repeat,createtime,servertime) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",DiaryAll.bgID,DiaryAll.bgTime,DiaryAll.bgType,DiaryAll.bgRepeat,DiaryAll.bgCreateTime,DiaryAll.bgServerTime];
            
            
            result=[db executeUpdate:sql];
            //// NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}
+(NSMutableArray *)getCalendarBGRecode
{
    
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    __block NSDictionary *objDIc;
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,time,type,repeat,createtime,servertime FROM calendar_bg"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         NSLog(@"%@++",rs);
         while ([rs next]) {
             
             akarn=[akarn initWithBGId:[rs stringForColumn:@"id"] bgRepeat:[rs stringForColumn:@"repeat"] bgtime:[rs stringForColumn:@"time"] bgtype:[rs stringForColumn:@"type"] bgcreatetime:[rs stringForColumn:@"createtime"] bgservertime:[rs stringForColumn:@"servertime"]];
             
             objDIc=[NSDictionary dictionaryWithObjectsAndKeys:
                     [akarn bgID],@"id",
                     [akarn bgTime],@"time",
                     nil];
             
             [calendarResultArray addObject:objDIc];
             
         }
     }];
    
    
    
    return calendarResultArray;
    
    
}
+(void)getTheCalendarBGRecodeFor_id;
{
    
    
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,time,type,repeat,createtime,servertime FROM calendar_bg WHERE id<-1000"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         while ([rs next]) {
             
             akarn=[akarn initWithBGId:[rs stringForColumn:@"id"] bgRepeat:[rs stringForColumn:@"repeat"] bgtime:[rs stringForColumn:@"time"] bgtype:[rs stringForColumn:@"type"] bgcreatetime:[rs stringForColumn:@"createtime"] bgservertime:[rs stringForColumn:@"servertime"]];
             
             
             
             [calendarResultArray addObject:[akarn bgTime]];
             
         }
     }];
    
    NSString *uRL_str;
    for (int i=0; i<calendarResultArray.count; i++)
    {
        if (i<calendarResultArray.count-1)
        {
            NSString *temp_st=[NSString stringWithFormat:@"%@,",[calendarResultArray objectAtIndex:i]];
            uRL_str =[uRL_str stringByAppendingString:temp_st];
        }
        else
        {
            NSString *temp_st=[NSString stringWithFormat:@"%@",[calendarResultArray objectAtIndex:i]];
            uRL_str =[uRL_str stringByAppendingString:temp_st];
        }
        
    }
    NSLog(@"------%@",uRL_str);
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    NSString *url_string = [[NSString alloc]init];
    //  url_string = [url_string stringByAppendingString:apiBaseURL];
    url_string = [url_string stringByAppendingString:@"login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&action=U"];
    url_string = [url_string stringByAppendingString:@"&type=G"];
    url_string = [url_string stringByAppendingString:@"&id=-1"];
    url_string = [url_string stringByAppendingString:@"&time="];
    url_string = [url_string stringByAppendingString:uRL_str];
    url_string = [url_string stringByAppendingString:@"&createtime="];
    url_string = [url_string stringByAppendingString:currentDateStr];
    
    
    
    NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
    
    NSURL *request_url = [NSURL URLWithString:encodedString];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [ NSData dataWithBytes: [ [uRL_str encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
    [request setHTTPBody:requestData];
    NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"%@+_+_+_",ionaSr);
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (data != nil && error == nil)
                               {
                                   //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                   // It worked, your source HTML is in sourceHTML
                                   
                                   NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
                                   NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
                                   
                               }
                               else
                               {
                                   // There was an error, alert the user
                               }
                               
                           }];
    
    
    
    
}
+(BOOL)deleteCalendarBGList
{
    
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_bg WHERE id"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bg WHERE id"];
         
         
         result=[db executeUpdate:sql];
         //NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
    
}
#pragma mark Daily-ECG
+(BOOL)addCalendarRoadECG:(Alarm *)DiaryAll
{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_ecg WHERE id =\"%@\"",DiaryAll.ecgID];
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //     NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_ecg SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.ecgID,DiaryAll.ecgTime,DiaryAll.ecgType,DiaryAll.ecgRepeat,DiaryAll.ecgCreateTime,DiaryAll.ecgServerTime,[DiaryAll ecgID]];
            
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //   NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_ecg(id,time,type,repeat,createtime,servertime) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",DiaryAll.ecgID,DiaryAll.ecgTime,DiaryAll.ecgType,DiaryAll.ecgRepeat,DiaryAll.ecgCreateTime,DiaryAll.ecgServerTime];
            
            
            
            
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
    
}
+(NSMutableArray *)getCalendarECGRecode
{
    
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    __block NSDictionary *objDIc;
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,time,type,repeat,createtime,servertime FROM calendar_ecg"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithECGId:[rs stringForColumn:@"id"] ecgRepeat:[rs stringForColumn:@"repeat"] ecgtime:[rs stringForColumn:@"time"] ecgtype:[rs stringForColumn:@"type"] ecgcreatetime:[rs stringForColumn:@"createtime"] ecgservertime:[rs stringForColumn:@"servertime"]];
             
             objDIc=[NSDictionary dictionaryWithObjectsAndKeys:
                     [akarn ecgID],@"id",
                     [akarn ecgTime],@"time",
                     nil];
             
             
             [calendarResultArray addObject:objDIc];
             
         }
     }];
    
    
    return calendarResultArray;
    
    
}
+(void)getTheCalendarECGRecodeFor_id;
{
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,time,type,repeat,createtime,servertime FROM calendar_ecg WHERE id <-1000"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithECGId:[rs stringForColumn:@"id"] ecgRepeat:[rs stringForColumn:@"repeat"] ecgtime:[rs stringForColumn:@"time"] ecgtype:[rs stringForColumn:@"type"] ecgcreatetime:[rs stringForColumn:@"createtime"] ecgservertime:[rs stringForColumn:@"servertime"]];
             
             [calendarResultArray addObject:[akarn ecgTime]];
             
         }
     }];
    NSString *uRL_str;
    for (int i=0; i<calendarResultArray.count; i++)
    {
        if (i<calendarResultArray.count-1)
        {
            NSString *temp_st=[NSString stringWithFormat:@"%@,",[calendarResultArray objectAtIndex:i]];
            uRL_str =[uRL_str stringByAppendingString:temp_st];
        }
        else
        {
            NSString *temp_st=[NSString stringWithFormat:@"%@",[calendarResultArray objectAtIndex:i]];
            uRL_str =[uRL_str stringByAppendingString:temp_st];
        }
        
    }
    NSLog(@"------%@",uRL_str);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    NSString *url_string = [[NSString alloc]init];
    //  url_string = [url_string stringByAppendingString:apiBaseURL];
    url_string = [url_string stringByAppendingString:@"login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&action=U"];
    url_string = [url_string stringByAppendingString:@"&type=E"];
    url_string = [url_string stringByAppendingString:@"&id=-1"];
    url_string = [url_string stringByAppendingString:@"&time="];
    url_string = [url_string stringByAppendingString:uRL_str];
    url_string = [url_string stringByAppendingString:@"&createtime="];
    url_string = [url_string stringByAppendingString:currentDateStr];
    
    
    
    NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
    
    NSURL *request_url = [NSURL URLWithString:encodedString];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [ NSData dataWithBytes: [ [uRL_str encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
    [request setHTTPBody:requestData];
    NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"%@+_+_+_",ionaSr);
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (data != nil && error == nil)
                               {
                                   //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                   // It worked, your source HTML is in sourceHTML
                                   
                                   NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
                                   NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
                                   
                               }
                               else
                               {
                                   // There was an error, alert the user
                               }
                               
                           }];
    
    
    
    
    
}
+(BOOL)deleteCalendarECGList
{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_ecg WHERE id"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_ecg WHERE id"];
         
         
         result=[db executeUpdate:sql];
         //// NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
    
};
#pragma mark Daily-Others
+(BOOL)addCalendarRoadOthers:(Alarm*)DiaryAll
{
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_others WHERE id =\"%@\"",DiaryAll.othersID];
        NSLog(@"calendar others id=%@",DiaryAll.othersID);
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //     NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_others SET id=\"%@\",type=\"%@\",title=\"%@\",start_time=\"%@\",end_time=\"%@\",note=\"%@\",date=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.othersID,DiaryAll.otherType,DiaryAll.othersTitle,DiaryAll.othersStarTime,DiaryAll.othersEndTime,DiaryAll.othersNote,DiaryAll.othersDate,DiaryAll.otherCreateTime,DiaryAll.otherServerTime,DiaryAll.othersID];
            
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //   NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_others(id,type,title,start_time,end_time,note,date,createtime,servertime) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",DiaryAll.othersID,DiaryAll.otherType,DiaryAll.othersTitle,DiaryAll.othersStarTime,DiaryAll.othersEndTime,DiaryAll.othersNote,DiaryAll.othersDate,DiaryAll.otherCreateTime,DiaryAll.otherServerTime];
            
            
            
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
    
}
+(NSMutableArray *)getCalendarOthersRecode
{
    
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    __block NSDictionary *objDIc;
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,type,title,start_time,end_time,note,date,createtime,servertime FROM calendar_others"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithOthersId:[rs stringForColumn:@"id"] Title:[rs stringForColumn:@"title"] StartTime:[rs stringForColumn:@"start_time"] EndTime:[rs stringForColumn:@"end_time"] Note:[rs stringForColumn:@"note"] Date:[rs stringForColumn:@"date"] Type:[rs stringForColumn:@"type"] Createtime:[rs stringForColumn:@"createtime"] Servertime:[rs stringForColumn:@"servertime"]];
             
             objDIc=[NSDictionary dictionaryWithObjectsAndKeys:
                     [akarn othersID],@"id",
                     [akarn othersDate],@"date",
                     [akarn othersStarTime],@"start_time",
                     [akarn othersEndTime],@"end_time",
                     [akarn othersTitle],@"title",
                     [akarn othersNote],@"note",
                     nil];
             
             
             [calendarResultArray addObject:objDIc];
             
         }
     }];
    
    return calendarResultArray;
    
    
}
+(void)getTheCalendarOthersRecodeFor_id
{
    NSMutableArray * titleArray=[NSMutableArray new];
    NSMutableArray * noteArray=[NSMutableArray new];
    NSMutableArray * starTimeArray=[NSMutableArray new];
    NSMutableArray * endTimeArray=[NSMutableArray new];
    NSMutableArray * dateArray=[NSMutableArray new];
    
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,type,title,start_time,end_time,note,date,createtime,servertime FROM calendar_others WHERE id<-1000"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithOthersId:[rs stringForColumn:@"id"] Title:[rs stringForColumn:@"title"] StartTime:[rs stringForColumn:@"start_time"] EndTime:[rs stringForColumn:@"end_time"] Note:[rs stringForColumn:@"note"] Date:[rs stringForColumn:@"date"] Type:[rs stringForColumn:@"type"] Createtime:[rs stringForColumn:@"createtime"] Servertime:[rs stringForColumn:@"servertime"]];
             
             [titleArray addObject:[akarn othersTitle]];
             [noteArray addObject:[akarn othersNote]];
             [dateArray addObject:[akarn othersDate]];
             [starTimeArray addObject:[akarn othersStarTime]];
             [endTimeArray addObject:[akarn othersEndTime]];
         }
     }];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    
    for (int i=0; i<titleArray.count; i++) {
        NSString *url_string = [[NSString alloc]init];
        //  url_string = [url_string stringByAppendingString:apiBaseURL];
        url_string = [url_string stringByAppendingString:@"login="];
        url_string = [url_string stringByAppendingString:login_id];
        url_string = [url_string stringByAppendingString:@"&sessionid="];
        url_string = [url_string stringByAppendingString:session_id];
        url_string = [url_string stringByAppendingString:@"&action=A"];
        url_string = [url_string stringByAppendingString:@"&type=A"];
        url_string = [url_string stringByAppendingString:@"&startdate="];
        url_string = [url_string stringByAppendingString:[dateArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:[starTimeArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&endtime="];
        url_string = [url_string stringByAppendingString:[endTimeArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&title="];
        url_string = [url_string stringByAppendingString:[titleArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&note="];
        url_string = [url_string stringByAppendingString:[noteArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        
        NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
        
        NSURL *request_url = [NSURL URLWithString:encodedString];
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        NSData *requestData = [ NSData dataWithBytes: [ [url_string encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
        [request setHTTPBody:requestData];
        NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
        NSLog(@"%@+_+_+_",ionaSr);
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue currentQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   
                                   if (data != nil && error == nil)
                                   {
                                       //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                       // It worked, your source HTML is in sourceHTML
                                       
                                       NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                       
                                       NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
                                       
                                   }
                                   else
                                   {
                                       // There was an error, alert the user
                                   }
                                   
                               }];
        
    }
    
}
+(BOOL)deleteCalendarOthersList:(NSString *)DiaryAll
{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_others WHERE id"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_others WHERE id =\"%@\"",DiaryAll];
         
         result=[db executeUpdate:sql];
         //NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
    
};

#pragma mark Daily-Walking
+(BOOL)addCalendarRoadWalking:(Alarm*)DiaryAll
{
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_walk WHERE id =\"%@\"",DiaryAll.walkingID];
        NSLog(@"calendar walk id=%@",DiaryAll.walkingID);
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //     NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_walk SET id=\"%@\",type=\"%@\",start_date=\"%@\",end_date=\"%@\",time=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.walkingID,DiaryAll.walkingType,DiaryAll.walkingStartDate,DiaryAll.walkingEndDate,DiaryAll.walkingTime,DiaryAll.walkingRepeat,DiaryAll.walkingCreateTime,DiaryAll.walkingServerTime,DiaryAll.walkingID];
            
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //   NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_walk(id,type,start_date,end_date,time,repeat,createtime,servertime) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",DiaryAll.walkingID,DiaryAll.walkingType,DiaryAll.walkingStartDate,DiaryAll.walkingEndDate,DiaryAll.walkingTime,DiaryAll.walkingRepeat,DiaryAll.walkingCreateTime,DiaryAll.walkingServerTime];
            
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}

//把表的內容變成數組拿下來
+(NSMutableArray *)getCalendarWalkingRecode
{
    
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    __block NSDictionary *objDIc;
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,type,start_date,end_date,time,repeat,createtime,servertime FROM calendar_walk"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithWalkingId:[rs stringForColumn:@"id"] StartDate:[rs stringForColumn:@"start_date"] EndDate:[rs stringForColumn:@"end_date"] Type:[rs stringForColumn:@"type"] Time:[rs stringForColumn:@"time"] Repeat:[rs stringForColumn:@"repeat"] CreateTime:[rs stringForColumn:@"createtime"] Servertime:[rs stringForColumn:@"servertime"]];
             
             objDIc=[NSDictionary dictionaryWithObjectsAndKeys:
                     [akarn walkingID],@"id",
                     [akarn walkingTime],@"time",
                     [akarn walkingStartDate],@"start_date",
                     [akarn walkingEndDate],@"end_date",
                     nil];
             
             
             [calendarResultArray addObject:objDIc];
             
         }
     }];
    
    return calendarResultArray;
    
    
}
+(void)getTHeCalendarWalkingRecodeFor_id
{
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,type,start_date,end_date,time,repeat,createtime,servertime FROM calendar_walk WHERE id<-1000"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithWalkingId:[rs stringForColumn:@"id"] StartDate:[rs stringForColumn:@"start_date"] EndDate:[rs stringForColumn:@"end_date"] Type:[rs stringForColumn:@"type"] Time:[rs stringForColumn:@"time"] Repeat:[rs stringForColumn:@"repeat"] CreateTime:[rs stringForColumn:@"createtime"] Servertime:[rs stringForColumn:@"servertime"]];
             
             //             objDIc=[NSDictionary dictionaryWithObjectsAndKeys:
             //                     [akarn walkingID],@"id",
             //                     [akarn walkingTime],@"time",
             //                     [akarn walkingStartDate],@"start_date",
             //                     [akarn walkingEndDate],@"end_date",
             //                     nil];
             
             
             [calendarResultArray addObject:[akarn walkingTime]];
             
             
         }
     }];
    
    NSString *uRL_str;
    for (int i=0; i<calendarResultArray.count; i++)
    {
        if (i<calendarResultArray.count-1)
        {
            NSString *temp_st=[NSString stringWithFormat:@"%@,",[calendarResultArray objectAtIndex:i]];
            uRL_str =[uRL_str stringByAppendingString:temp_st];
        }
        else
        {
            NSString *temp_st=[NSString stringWithFormat:@"%@",[calendarResultArray objectAtIndex:i]];
            uRL_str =[uRL_str stringByAppendingString:temp_st];
        }
        
    }
    NSLog(@"------%@",uRL_str);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    NSString *url_string = [[NSString alloc]init];
    //  url_string = [url_string stringByAppendingString:apiBaseURL];
    url_string = [url_string stringByAppendingString:@"login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    url_string = [url_string stringByAppendingString:@"&action=U"];
    url_string = [url_string stringByAppendingString:@"&type=K"];
    url_string = [url_string stringByAppendingString:@"&id=-1"];
    url_string=[url_string stringByAppendingString:@"&startdate="];
    url_string=[url_string stringByAppendingString:[akarn walkingStartDate]];
    url_string=[url_string stringByAppendingString:@"&enddate="];
    url_string=[url_string stringByAppendingString:[akarn walkingEndDate]];
    url_string = [url_string stringByAppendingString:@"&time="];
    url_string = [url_string stringByAppendingString:uRL_str];
    url_string = [url_string stringByAppendingString:@"&createtime="];
    url_string = [url_string stringByAppendingString:currentDateStr];
    
    NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
    
    NSURL *request_url = [NSURL URLWithString:encodedString];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestData = [ NSData dataWithBytes: [ [url_string encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
    [request setHTTPBody:requestData];
    NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
    NSLog(@"%@+_+_+_",ionaSr);
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (data != nil && error == nil)
                               {
                                   //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                   // It worked, your source HTML is in sourceHTML
                                   
                                   NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   
                                   NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
                                   
                               }
                               else
                               {
                                   // There was an error, alert the user
                               }
                               
                           }];
    
    
}
+(BOOL)deleteCalendarWalkingList
{
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_walk WHERE id"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_walk WHERE id"];
         // NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bp SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime,[DiaryAll bpID]];
         
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
}

#pragma mark Daily-Medication
+(BOOL)addCalendarRoadMedication:(Alarm*)DiaryAll
{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM calendar_medication WHERE meid =\"%@\"",DiaryAll.medicationMedID];
        
        NSLog(@"calendar medication id=%@",DiaryAll.medicationMedID);
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //     NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_medication SET meid=\"%@\",title=\"%@\",meal=\"%@\",dosage=\"%@\",servertime=\"%@\",reminder_id=\"%@\",reminder_time=\"%@\",reminder_ticken=\"%@\",reminder_repeat=\"%@\",reminder_image_string=\"%@\" WHERE meid=\"%@\"",DiaryAll.medicationMedID,DiaryAll.medicationTitle,DiaryAll.medicationMeal,DiaryAll.medicationDosage,DiaryAll.medicationServerTime,DiaryAll.medicationReminderid,DiaryAll.medicationReminderTime,DiaryAll.medicationReminderTicken,DiaryAll.medicationReminderRepeat,DiaryAll.medicationReminderImageString,DiaryAll.medicationMedID];
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //   NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_medication(meid,title,meal,dosage,servertime,reminder_id,reminder_time,reminder_ticken,reminder_repeat,reminder_image_string) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",DiaryAll.medicationMedID,DiaryAll.medicationTitle,DiaryAll.medicationMeal,DiaryAll.medicationDosage,DiaryAll.medicationServerTime,DiaryAll.medicationReminderid,DiaryAll.medicationReminderTime,DiaryAll.medicationReminderTicken,DiaryAll.medicationReminderRepeat,DiaryAll.medicationReminderImageString];
            
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}

//把表的內容變成數組拿下來
+(NSMutableArray *)getCalendarMedicationRecode
{
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    __block NSDictionary *objDIc;
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT meid,title,meal,dosage,servertime,reminder_id,reminder_time,reminder_ticken,reminder_repeat,reminder_image_string FROM calendar_medication"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithMedicationId:[rs stringForColumn:@"meid"]
                                         Title:[rs stringForColumn:@"title"]
                                          Meal:[rs stringForColumn:@"meal"]
                                        DosAge:[rs stringForColumn:@"dosage"]
                                    Servertime:[rs stringForColumn:@"servertime"]
                                  ReminderTime:[rs stringForColumn:@"reminder_time"]
                                    ReminderID:[rs stringForColumn:@"reminder_id"]
                                  ReminderType:@""
                                ReminderRepeat:@"reminder_repeat"
                                ReminderTicken:[rs stringForColumn:@"reminder_ticken"]
                            ReminderCreateTime:@""
                            ReminderserverTime:@""
                           ReminderImageString:[rs stringForColumn:@"reminder_image_string"]
                    Note:@""
                    ];
             
             objDIc=[NSDictionary dictionaryWithObjectsAndKeys:[akarn medicationMedID],@"meid",[akarn medicationTitle],@"title",[akarn medicationDosage],@"dosage",[akarn medicationMeal],@"meal",[akarn medicationReminderid],@"reminder_id",[akarn medicationReminderTime],@"reminder_time",[akarn medicationReminderTicken],@"reminder_ticken",[akarn medicationServerTime],@"servertime",[akarn medicationReminderImageString],@"reminder_image_string", nil];
             
          //   NSLog(@"[akarn medicationDosage]=====%@",[akarn medicationDosage]);
             [calendarResultArray addObject:objDIc];
             
         }
     }];
    
    return calendarResultArray;
    
    
}
+(void)getCalendarMedicationRecodeFor_id
{
    NSMutableArray*titleArray=[NSMutableArray new];
    NSMutableArray*mealArray=[NSMutableArray new];
    NSMutableArray*dosAgeArray=[NSMutableArray new];
    NSMutableArray *timeArray=[NSMutableArray new];
    NSMutableArray *imageStrArray=[NSMutableArray new];
    NSMutableArray *noteArray=[NSMutableArray new];
    __block Alarm *akarn=[[Alarm alloc]init];
    __block Alarm *akarn2=[[Alarm alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT meid,title,meal,dosage,servertime,reminder_id,reminder_time,reminder_ticken,reminder_repeat,reminder_image_string FROM calendar_medication WHERE meid<-1000"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithMedicationId:[rs stringForColumn:@"meid"]
                                         Title:[rs stringForColumn:@"title"]
                                          Meal:[rs stringForColumn:@"meal"]
                                        DosAge:[rs stringForColumn:@"dosage"]
                                    Servertime:[rs stringForColumn:@"servertime"]
                                  ReminderTime:[rs stringForColumn:@"reminder_time"]
                                    ReminderID:[rs stringForColumn:@"reminder_id"]
                                  ReminderType:@""
                                ReminderRepeat:@"reminder_repeat"
                                ReminderTicken:[rs stringForColumn:@"reminder_ticken"]
                            ReminderCreateTime:@""
                            ReminderserverTime:@""
                           ReminderImageString:[rs stringForColumn:@"reminder_image_string"]
                    Note:@""];
             
             [titleArray addObject:[akarn medicationTitle]];
             [mealArray addObject:[akarn medicationMeal]];
             [dosAgeArray addObject:[akarn medicationDosage]];
             [timeArray addObject:[akarn medicationReminderTime]];
             [imageStrArray addObject:[akarn medicationReminderImageString]];
             
         }
     }];
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSLog(@"session_id=%@",session_id);
    NSLog(@"login_id=%@",login_id);
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT meid,title,note FROM calendar_medication_notes WHERE meid<-1000"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn2=[akarn2 initWithMedicationId:[rs stringForColumn:@"meid"]
                                         Title:[rs stringForColumn:@"title"]
                                          Meal:@""
                                        DosAge:@""
                                    Servertime:@""
                                  ReminderTime:@""
                                    ReminderID:@""
                                  ReminderType:@""
                                ReminderRepeat:@""
                                ReminderTicken:@""
                            ReminderCreateTime:@""
                            ReminderserverTime:@""
                           ReminderImageString:@""
                                          Note:[rs stringForColumn:@"note"]];
             
             [noteArray addObject:[akarn2 medicationNote]];
         }
     }];

    
    for (int i=0; i<titleArray.count; i++) {
        
        NSString *url_string = [[NSString alloc]init];
        //  url_string = [url_string stringByAppendingString:apiBaseURL];
        url_string = [url_string stringByAppendingString:@"login="];
        url_string = [url_string stringByAppendingString:login_id];
        url_string = [url_string stringByAppendingString:@"&sessionid="];
        url_string = [url_string stringByAppendingString:session_id];
        url_string = [url_string stringByAppendingString:@"&action=A"];
        url_string = [url_string stringByAppendingString:@"&type=M"];
        url_string = [url_string stringByAppendingString:@"&time="];
        url_string = [url_string stringByAppendingString:[timeArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&title="];
        url_string = [url_string stringByAppendingString:[titleArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&dosage="];
        url_string = [url_string stringByAppendingString:[dosAgeArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&meal="];
        url_string = [url_string stringByAppendingString:[mealArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&note="];
        url_string = [url_string stringByAppendingString:[noteArray objectAtIndex:i]];
        url_string = [url_string stringByAppendingString:@"&createtime="];
        url_string = [url_string stringByAppendingString:currentDateStr];
        NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
        
        NSURL *request_url = [NSURL URLWithString:encodedString];
        
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        NSData *requestData = [ NSData dataWithBytes: [ [url_string encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
        [request setHTTPBody:requestData];
        NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
        NSLog(@"%@+_+_+_",ionaSr);
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue currentQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   
                                   if (data != nil && error == nil)
                                   {
                                       //NSString *sourceHTML = [[NSString alloc] initWithData:data];
                                       // It worked, your source HTML is in sourceHTML
                                       
                                       NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                       
                                       NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
                                       
                                   }
                                   else
                                   {
                                       // There was an error, alert the user
                                   }
                                   
                               }];
        
        
    }
    
    
}
+(BOOL)deleteCalendarMedicationList:(NSString*)DiaryAll
{
    
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM calendar_medication WhERE meid"];
         NSLog(@"MEID===---------------------------------------------------------------------------==%@",DiaryAll);
         
         FMResultSet *check = [db executeQuery: checkSql];
         NSLog(@"check===%@",check);
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_medication WHERE meid =\"%@\"",DiaryAll];
         // NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bp SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime,[DiaryAll bpID]];
         
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
}



#pragma mark Daily-Medication
+(BOOL)UPDateTakenMedication:(Alarm*)DiaryAll
{
    NSLog(@"929292929292");
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM calendar_medication WHERE meid =\"%@\"",DiaryAll.medicationMedID];
        
        NSLog(@"calendar medication id=%@",DiaryAll.medicationMedID);
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //     NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_medication SET reminder_ticken=\"%@\" WHERE meid=\"%@\"",DiaryAll.medicationReminderTicken,DiaryAll.medicationMedID];
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //   NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_medication(meid,title,meal,dosage,servertime,reminder_id,reminder_time,reminder_ticken,reminder_repeat,reminder_image_string) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",DiaryAll.medicationMedID,DiaryAll.medicationTitle,DiaryAll.medicationMeal,DiaryAll.medicationDosage,DiaryAll.medicationServerTime,DiaryAll.medicationReminderid,DiaryAll.medicationReminderTime,DiaryAll.medicationReminderTicken,DiaryAll.medicationReminderRepeat,DiaryAll.medicationReminderImageString];
            
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}




#pragma mark Daily-Medication_Notes
+(BOOL)addCalendarRoadMedication_Notes:(Alarm*)DiaryAll
{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        NSLog(@"Daily medicationNote=%@",DiaryAll.medicationNote);
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM calendar_medication_notes WHERE meid =\"%@\"",DiaryAll.medicationMedID];
        
        NSLog(@"SELECT * FROM calendar_medication_notes id=%@",DiaryAll.medicationMedID);
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //     NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_medication_notes SET meid=\"%@\",title=\"%@\",note=\"%@\" WHERE meid=\"%@\"",DiaryAll.medicationMedID,DiaryAll.medicationTitle,DiaryAll.medicationNote,DiaryAll.medicationMedID];
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //   NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_medication_notes(meid,title,note) VALUES (\"%@\",\"%@\",\"%@\")",DiaryAll.medicationMedID,DiaryAll.medicationTitle,DiaryAll.medicationNote];
            
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}

//把表的內容變成數組拿下來
+(NSMutableArray *)getCalendarMedicationRecode_Notes
{
    __block NSMutableArray *calendarResultArray=[[NSMutableArray alloc]init];
    __block NSDictionary *objDIc;
    __block Alarm *akarn=[[Alarm alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT meid,title,note FROM calendar_medication_notes"];
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         while ([rs next]) {
             
             akarn=[akarn initWithMedicationId:[rs stringForColumn:@"meid"] Title:[rs stringForColumn:@"title"] Meal:@"" DosAge:@"" Servertime:@"" ReminderTime:@"" ReminderID:@"" ReminderType:@"" ReminderRepeat:@"" ReminderTicken:@"" ReminderCreateTime:@"" ReminderserverTime:@"" ReminderImageString:@"" Note:[rs stringForColumn:@"note"]];
             
             NSLog(@"[akarn medicationNote],=%@[rs stringForColumn:note=%@",[akarn medicationNote],[rs stringForColumn:@"note"]);
             objDIc=[NSDictionary dictionaryWithObjectsAndKeys:[akarn medicationMedID],@"meid",[akarn medicationTitle],@"title",[akarn medicationNote],@"note", nil];
             
             //   NSLog(@"[akarn medicationDosage]=====%@",[akarn medicationDosage]);
             [calendarResultArray addObject:objDIc];
             
         }
     }];
    
    return calendarResultArray;
    
    
}
//+(void)getCalendarMedicationRecodeFor_id_Notes
//{
//    NSMutableArray*titleArray=[NSMutableArray new];
//    NSMutableArray*noteArray=[NSMutableArray new];
//
//    __block Alarm *akarn=[[Alarm alloc]init];
//    
//    [self.dbQueue inDatabase:^(FMDatabase *db)
//     {
//         [db open];
//         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT meid,title,note FROM calendar_medication_notes WHERE meid<-1000"];
//         
//         FMResultSet *rs = [db executeQuery:selectSql];
//         
//         while ([rs next]) {
//             
//             akarn=[akarn initWithMedicationNote:[rs stringForColumn:@"meid"] Title:[rs stringForColumn:@"title"] Note:[rs stringForColumn:@"note"]];
//             
//             [titleArray addObject:[akarn medicationTitle]];
//             [noteArray addObject:[akarn medicationNote]];
//             
//         }
//     }];
//    
//    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
//    NSString *session_id = [GlobalVariables shareInstance].session_id;
//    NSString *login_id = [GlobalVariables shareInstance].login_id;
//    NSLog(@"session_id=%@",session_id);
//    NSLog(@"login_id=%@",login_id);
//    
//    
//    
//    for (int i=0; i<titleArray.count; i++) {
//        
//        NSString *url_string = [[NSString alloc]init];
//        //  url_string = [url_string stringByAppendingString:apiBaseURL];
//        url_string = [url_string stringByAppendingString:@"login="];
//        url_string = [url_string stringByAppendingString:login_id];
//        url_string = [url_string stringByAppendingString:@"&sessionid="];
//        url_string = [url_string stringByAppendingString:session_id];
//        url_string = [url_string stringByAppendingString:@"&action=A"];
//        url_string = [url_string stringByAppendingString:@"&type=M"];
//        url_string = [url_string stringByAppendingString:@"&time="];
//        url_string = [url_string stringByAppendingString:[timeArray objectAtIndex:i]];
//        url_string = [url_string stringByAppendingString:@"&title="];
//        url_string = [url_string stringByAppendingString:[titleArray objectAtIndex:i]];
//        url_string = [url_string stringByAppendingString:@"&dosage="];
//        url_string = [url_string stringByAppendingString:[dosAgeArray objectAtIndex:i]];
//        url_string = [url_string stringByAppendingString:@"&meal="];
//        url_string = [url_string stringByAppendingString:[mealArray objectAtIndex:i]];
//        url_string = [url_string stringByAppendingString:@"&createtime="];
//        url_string = [url_string stringByAppendingString:currentDateStr];
//        NSString *encodedString=[NSString stringWithFormat:@"%@healthReminder",[Constants getAPIBase2]];
//        NSLog(@"Weight sending url:%@",url_string);
//        
//        NSURL *request_url = [NSURL URLWithString:encodedString];
//        
//        NSLog(@"request_url:%@",encodedString);
//        
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
//        
//        [request setHTTPMethod:@"POST"];
//        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        NSData *requestData = [ NSData dataWithBytes: [ [url_string encodedURLString] UTF8String ] length: [ [url_string encodedURLString] length ] ];
//        [request setHTTPBody:requestData];
//        NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
//        NSLog(@"%@+_+_+_",ionaSr);
//        [NSURLConnection sendAsynchronousRequest:request
//                                           queue:[NSOperationQueue currentQueue]
//                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                                   
//                                   if (data != nil && error == nil)
//                                   {
//                                       //NSString *sourceHTML = [[NSString alloc] initWithData:data];
//                                       // It worked, your source HTML is in sourceHTML
//                                       
//                                       NSString *xmlSTr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                       
//                                       NSLog(@"+++++++++++%@=============%lu======",xmlSTr,(unsigned long)[xmlSTr length]);
//                                       
//                                   }
//                                   else
//                                   {
//                                       // There was an error, alert the user
//                                   }
//                                   
//                               }];
//        
//        
//    }
//    
//    
//}
+(BOOL)deleteCalendarMedicationList_Notes:(NSString*)DiaryAll
{
    
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM calendar_medication_notes WhERE meid"];
         NSLog(@"MEID===---------------------------------------------------------------------------==%@",DiaryAll);
         
         FMResultSet *check = [db executeQuery: checkSql];
         NSLog(@"check===%@",check);
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_medication_notes WHERE meid =\"%@\"",DiaryAll];
         // NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bp SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime,[DiaryAll bpID]];
         
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
}



#pragma mark Daily-Medication
+(BOOL)UPDateTakenMedication_Notes:(Alarm*)DiaryAll
{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM calendar_medication_notes WHERE meid =\"%@\"",DiaryAll.medicationMedID];
        
        NSLog(@"calendar medication id=%@",DiaryAll.medicationMedID);
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //     NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_medication SET reminder_ticken=\"%@\" WHERE meid=\"%@\"",DiaryAll.medicationReminderTicken,DiaryAll.medicationMedID];
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //   NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO calendar_medication(meid,title,meal,dosage,servertime,reminder_id,reminder_time,reminder_ticken,reminder_repeat,reminder_image_string) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",DiaryAll.medicationMedID,DiaryAll.medicationTitle,DiaryAll.medicationMeal,DiaryAll.medicationDosage,DiaryAll.medicationServerTime,DiaryAll.medicationReminderid,DiaryAll.medicationReminderTime,DiaryAll.medicationReminderTicken,DiaryAll.medicationReminderRepeat,DiaryAll.medicationReminderImageString];
            
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}


#pragma mark -
#pragma mark WALKING

+ (BOOL) addWalkingRecord:(WalkingRecord *) walking{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        
        
        NSString *checkSql;
        
        
        
              
        NSLog(@"Vaycent check walkingDB recordid:%@",walking.recordid);
        NSLog(@"Vaycent check walkingDB recordTime:%ld",[walking getRecordtime]);
        NSLog(@"Vaycent check walkingDB recordid:%@",walking.recordid);
        NSLog(@"Vaycent check walkingDB steps:%@",walking.steps);
        NSLog(@"Vaycent check walkingDB distance:%@",walking.distance);
        NSLog(@"Vaycent check walkingDB pace:%@",walking.pace);



        
        
        if (walking.recordid!=nil&&![walking.recordid isEqualToString:@""]) {
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM walking WHERE recordid = \"%@\"",walking.recordid];
            
            
        }else{
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM walking WHERE recordtime = %ld",[walking getRecordtime]];
        }
        
        
  
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        WalkingRecord *cwResult = nil;
        
        if ([check next]) {
            
            cwResult = [[WalkingRecord alloc]init];
            [cwResult setType:[check intForColumn:@"type"]];
            cwResult.foodlistid=[check stringForColumn:@"foodlistid"];
            cwResult.trainid=[check stringForColumn:@"trainid"];
            cwResult.result=[check stringForColumn:@"result"];
            cwResult.gps=[check stringForColumn:@"gps"];
            cwResult.route=[check stringForColumn:@"route"];
            cwResult.steps=[check stringForColumn:@"steps"];
            cwResult.distance=[check stringForColumn:@"distance"];
            cwResult.calsburnt=[check stringForColumn:@"caloburnt"];
            cwResult.target=[check stringForColumn:@"target"];
            cwResult.pace=[check stringForColumn:@"pace"];
            cwResult.persistimeStr=[check stringForColumn:@"persistime"];
            cwResult.recordid=[check stringForColumn:@"recordid"];
            [cwResult setPersistime:[check longForColumn:@"persistimeL"]];
            [cwResult setRecordtime:[check longForColumn:@"recordtime"]];
            
        };
        
        
        if ([check resultDictionary])
        {
            NSString *sql = nil;
            
            
            if (walking.recordid!=nil&&![walking.recordid isEqualToString:@""]) {
                
                
                NSString *gpsVlaue=(walking.gps==nil||[walking.gps isEqualToString:@""])?@"":walking.gps;
                
                if (cwResult) {
                    
                    if (cwResult.gps) {
                        
                        if (![cwResult.gps isEqualToString:@""]) {
                            
                            gpsVlaue=cwResult.gps;
                        }
                    }
                }
                
                NSString *routeVlaue=(walking.route==nil||[walking.route isEqualToString:@""])?@"":walking.route;
                
                if (cwResult) {
                    
                    if (cwResult.route) {
                        
                        if (![cwResult.route isEqualToString:@""]) {
                            
                            routeVlaue=cwResult.route;
                        }
                    }
                }
                
                NSString *paceVlaue=(walking.pace==nil||[walking.pace isEqualToString:@""])?@"0":walking.pace;
                
                if (cwResult) {
                    
                    if (cwResult.pace) {
                        
                        if (![cwResult.pace isEqualToString:@""]) {
                            
                            paceVlaue=cwResult.pace;
                        }
                    }
                }
                
                
                
                
                sql=[NSString stringWithFormat:@"UPDATE walking SET type=%ld,foodlistid=\"%@\", trainid=\"%@\",result=\"%@\",gps=\"%@\",route=\"%@\",steps=\"%@\",distance=\"%@\",caloburnt=\"%@\",target=\"%@\",pace=\"%@\",persistime=\"%@\", persistimeL=%ld, recordtime=%ld WHERE recordid=\"%@\"",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,gpsVlaue,routeVlaue,walking.steps==nil?@"0":walking.steps,walking.distance==nil?@"0":walking.distance,walking.calsburnt==nil?@"0":walking.calsburnt,walking.target==nil?@"0":walking.target,paceVlaue,walking.persistimeStr==nil?@"":walking.persistimeStr,[walking getPersistime],[walking getRecordtime],walking.recordid];
                
                
                
                
            }else{
                
                
                NSString *gpsVlaue=(walking.gps==nil||[walking.gps isEqualToString:@""])?@"":walking.gps;
                
                if (cwResult) {
                    
                    if (cwResult.gps) {
                        
                        if (![cwResult.gps isEqualToString:@""]) {
                            
                            gpsVlaue=cwResult.gps;
                        }
                    }
                }
                
                NSString *routeVlaue=(walking.route==nil||[walking.route isEqualToString:@""])?@"":walking.route;
                
                if (cwResult) {
                    
                    if (cwResult.route) {
                        
                        if (![cwResult.route isEqualToString:@""]) {
                            
                            routeVlaue=cwResult.route;
                        }
                    }
                }
                
                NSString *paceVlaue=(walking.pace==nil||[walking.pace isEqualToString:@""])?@"0":walking.pace;
                
                if (cwResult) {
                    
                    if (cwResult.pace) {
                        
                        if (![cwResult.pace isEqualToString:@""]) {
                            
                            paceVlaue=cwResult.pace;
                        }
                    }
                }
                
                
                
                sql=[NSString stringWithFormat:@"UPDATE walking SET type=%ld,foodlistid=\"%@\", trainid=\"%@\",result=\"%@\",gps=\"%@\",route=\"%@\",steps=\"%@\",distance=\"%@\",caloburnt=\"%@\",target=\"%@\",pace=\"%@\",persistime=\"%@\", persistimeL=%ld,recordid=\"%@\" WHERE recordtime=%ld",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,gpsVlaue,routeVlaue,walking.steps==nil?@"0":walking.steps,walking.distance==nil?@"0":walking.distance,walking.calsburnt==nil?@"0":walking.calsburnt,walking.target==nil?@"0":walking.target,paceVlaue,walking.persistimeStr==nil?@"":walking.persistimeStr,[walking getPersistime],walking.recordid==nil?@"":walking.recordid,[walking getRecordtime]];
            }
            
            
            
            result=[db executeUpdate:sql];
            
            
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            NSLog(@"add...");
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO walking(type,foodlistid, trainid,result,gps,route,steps,distance,caloburnt,target,pace,persistime, persistimeL,recordid,recordtime) VALUES (%ld,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%ld,\"%@\",%ld)",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,walking.gps==nil?@"":walking.gps,walking.route==nil?@"":walking.route,walking.steps==nil?@"0":walking.steps,walking.distance==nil?@"0":walking.distance,walking.calsburnt==nil?@"0":walking.calsburnt,walking.target==nil?@"0":walking.target,walking.pace==nil?@"0":walking.pace,walking.persistimeStr==nil?@"":walking.persistimeStr,[walking getPersistime],walking.recordid==nil?@"":walking.recordid,[walking getRecordtime]];
            
            NSLog(@"Vaycent test this sql add:%@",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    return result;
    
}

+ (NSMutableArray *)getCWRecord{
    __block NSMutableArray *cwResultArray = [[NSMutableArray alloc]init];
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=0 ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while([rs next]){
            
            WalkingRecord *cwResult = [[WalkingRecord alloc]init];
            
            [cwResult setType:[rs intForColumn:@"type"]];
            cwResult.foodlistid=[rs stringForColumn:@"foodlistid"];
            cwResult.trainid=[rs stringForColumn:@"trainid"];
            cwResult.result=[rs stringForColumn:@"result"];
            cwResult.gps=[rs stringForColumn:@"gps"];
            cwResult.route=[rs stringForColumn:@"route"];
            cwResult.steps=[rs stringForColumn:@"steps"];
            cwResult.distance=[rs stringForColumn:@"distance"];
            cwResult.calsburnt=[rs stringForColumn:@"caloburnt"];
            cwResult.target=[rs stringForColumn:@"target"];
            cwResult.pace=[rs stringForColumn:@"pace"];
            cwResult.persistimeStr=[rs stringForColumn:@"persistime"];
            cwResult.recordid=[rs stringForColumn:@"recordid"];
            [cwResult setPersistime:[rs longForColumn:@"persistimeL"]];
            [cwResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            
            NSLog(@"test distance1 in db:%@",cwResult.distance);
            NSLog(@"test calsburnt1 in db:%@",cwResult.calsburnt);
            
            
            cwResult.steps=[DBHelper decryptionString:cwResult.steps];
            cwResult.distance=[DBHelper decryptionString:cwResult.distance];
            cwResult.calsburnt=[DBHelper decryptionString:cwResult.calsburnt];
            cwResult.persistimeStr=[DBHelper decryptionString:cwResult.persistimeStr];
            
            
            NSLog(@"test distance2 in db:%@",cwResult.distance);
            NSLog(@"test calsburnt2 in db:%@",cwResult.calsburnt);
            
            
            
            [cwResultArray addObject:cwResult];
            
        }
    }];
    return cwResultArray;
}

+ (WalkingRecord *)getCWRecordById:(NSString*)recordid{
    
    __block WalkingRecord *cwResult = [[WalkingRecord alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM walking WHERE recordid=\"%@\" ORDER BY recordtime DESC",recordid];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while([rs next]){
            
            
            [cwResult setType:[rs intForColumn:@"type"]];
            cwResult.foodlistid=[rs stringForColumn:@"foodlistid"];
            cwResult.trainid=[rs stringForColumn:@"trainid"];
            cwResult.result=[rs stringForColumn:@"result"];
            cwResult.gps=[rs stringForColumn:@"gps"];
            cwResult.route=[rs stringForColumn:@"route"];
            cwResult.steps=[rs stringForColumn:@"steps"];
            cwResult.distance=[rs stringForColumn:@"distance"];
            cwResult.calsburnt=[rs stringForColumn:@"caloburnt"];
            cwResult.target=[rs stringForColumn:@"target"];
            cwResult.pace=[rs stringForColumn:@"pace"];
            cwResult.persistimeStr=[rs stringForColumn:@"persistime"];
            cwResult.recordid=[rs stringForColumn:@"recordid"];
            [cwResult setPersistime:[rs longForColumn:@"persistimeL"]];
            [cwResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            cwResult.steps=[DBHelper decryptionString:cwResult.steps];
            cwResult.distance=[DBHelper decryptionString:cwResult.distance];
            cwResult.calsburnt=[DBHelper decryptionString:cwResult.calsburnt];
            cwResult.persistimeStr=[DBHelper decryptionString:cwResult.persistimeStr];
            
            
            break;
            
            
            
        }
    }];
    return cwResult;
}

+ (NSMutableArray *)getCWRecordDate:(long)start enddate:(long)end type:(NSInteger)thetype{
    
    //thetype  -1 mean get casual walk record; -2 mean get train walk record; other value mean train id .
    
    __block NSMutableArray *cwResultArray = [[NSMutableArray alloc]init];
    
    
    NSDate *startDate=[[NSDate alloc] initWithTimeIntervalSince1970:start];
    NSDate *endDate=[[NSDate alloc] initWithTimeIntervalSince1970:end];
    
    
    NSLog(@"start:%@",startDate);
    NSLog(@"enddate:%@",endDate);
    NSLog(@"thetype:%ld",(long)thetype);
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql;
        
        if (thetype==-1) {
            
            selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=0 AND recordtime BETWEEN %ld AND %ld ORDER BY recordtime DESC",start,end];
            
            if (start==0&&end==0) {
                
                selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=0 ORDER BY recordtime DESC"];
            }
            
        }else if (thetype==-2) {
            
            selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=1 AND recordtime BETWEEN %ld AND %ld ORDER BY recordtime DESC",start,end];
            
            if (start==0&&end==0) {
                
                selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=1 ORDER BY recordtime DESC"];
            }
            
        }
        else if (thetype==-3) {
            
            selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=3 AND recordtime BETWEEN %ld AND %ld ORDER BY recordtime DESC",start,end];
            
            if (start==0&&end==0) {
                
                selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=3 ORDER BY recordtime DESC"];
            }
            
        }
        else if (thetype==-4) {
            
            selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=4 AND recordtime BETWEEN %ld AND %ld ORDER BY recordtime DESC",start,end];
            
            if (start==0&&end==0) {
                
                selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE type=4 ORDER BY recordtime DESC"];
            }
            
        }
        
        
        
        
        
        
        
        else{
            
            selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE trainid=\"%ld\" AND recordtime BETWEEN %ld AND %ld ORDER BY recordtime DESC",(long)thetype,start,end];
            
            if (start==0&&end==0) {
                
                selectSql= [NSString stringWithFormat:@"SELECT * FROM walking WHERE trainid=\"%ld\" ORDER BY recordtime DESC",(long)thetype];
            }
        }
        
        //NSLog(@"%@.......sql",selectSql);
        
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while([rs next]){
            WalkingRecord *cwResult = [[WalkingRecord alloc]init];
            [cwResult setType:[rs intForColumn:@"type"]];
            cwResult.foodlistid=[rs stringForColumn:@"foodlistid"];
            cwResult.trainid=[rs stringForColumn:@"trainid"];
            cwResult.result=[rs stringForColumn:@"result"];
            cwResult.gps=[rs stringForColumn:@"gps"];
            cwResult.route=[rs stringForColumn:@"route"];
            cwResult.steps=[rs stringForColumn:@"steps"];
            cwResult.distance=[rs stringForColumn:@"distance"];
            cwResult.calsburnt=[rs stringForColumn:@"caloburnt"];
            cwResult.target=[rs stringForColumn:@"target"];
            cwResult.pace=[rs stringForColumn:@"pace"];
            cwResult.persistimeStr=[rs stringForColumn:@"persistime"];
            cwResult.recordid=[rs stringForColumn:@"recordid"];
            [cwResult setPersistime:[rs longForColumn:@"persistimeL"]];
            [cwResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            
            cwResult.steps=[DBHelper decryptionString:cwResult.steps];
            cwResult.distance=[DBHelper decryptionString:cwResult.distance];
            cwResult.calsburnt=[DBHelper decryptionString:cwResult.calsburnt];
            cwResult.persistimeStr=[DBHelper decryptionString:cwResult.persistimeStr];
            
            
            
            
            
            
            [cwResultArray addObject:cwResult];
            
        }
    }];
    return cwResultArray;
}









+ (BOOL) addTrainRecord:(TrainingRecord *) train{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        
        
        NSString *checkSql;
        
        
        if (train.trainid!=nil&&![train.trainid isEqualToString:@""]) {
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM trains WHERE trainid = \"%@\"",train.trainid];
            
            
        }else{
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM trains WHERE recordtime = %ld",[train getRecordtime]];
        }
        
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        [check next];
        
        
        if ([check resultDictionary])
        {
            NSString *sql = nil;
            
            
            
            
            
            if (train.trainid!=nil&&![train.trainid isEqualToString:@""]) {
                
                
                sql=[NSString stringWithFormat:@"UPDATE trains SET level=%ld,status=%d,result=\"%@\", starttime=%ld, recordtime=%ld WHERE trainid=\"%@\"",(long)[train getLevel],[train getStatus],train.result,[train getStarttime],[train getRecordtime],train.trainid];
                
                
                
                
            }else{
                
                
                sql=[NSString stringWithFormat:@"UPDATE trains SET level=%ld,status=%d,result=\"%@\", starttime=%ld,trainid=\"%@\" WHERE recordtime=%ld",(long)[train getLevel],[train getStatus],train.result,[train getStarttime],train.trainid,[train getRecordtime]];
                
                
            }
            
            
            
            result=[db executeUpdate:sql];
            
            
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO trains(level,status, trainid,result,starttime,recordtime) VALUES (%ld,%d,\"%@\",\"%@\",%ld,%ld)",(long)[train getLevel],[train getStatus],train.trainid,train.result,[train getStarttime],[train getRecordtime]];
            
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    if (result) {
        NSLog(@"add train ok......");
    }
    
    return result;
    
}

+ (NSMutableArray *)getTrainRecord{
    __block NSMutableArray *trainResultArray = [[NSMutableArray alloc]init];
    
    //__block TrainingRecord *trainResult = [[TrainingRecord alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM trains ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while([rs next]){
            
            TrainingRecord *trainResult = [[TrainingRecord alloc]init];
            
            
            [trainResult setLevel:[rs intForColumn:@"level"]];
            
            [trainResult setStatus:[rs intForColumn:@"status"]];
            
            trainResult.trainid=[rs stringForColumn:@"trainid"];
            trainResult.result=[rs stringForColumn:@"result"];
            
            [trainResult setStarttime:[rs longForColumn:@"starttime"]];
            [trainResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            
            
            
            
            
            
            [trainResultArray addObject:trainResult];
            
        }
    }];
    return trainResultArray;
}

+ (TrainingRecord *)getTrainRecordByID:(NSString *) trainid{
    
    __block TrainingRecord *trainResult = [[TrainingRecord alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM trains WHERE trainid=\"%@\" ORDER BY recordtime DESC",trainid];
        
        NSLog(@"%@....",selectSql);
        
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while([rs next]){
            
            [trainResult setLevel:[rs intForColumn:@"level"]];
            
            [trainResult setStatus:[rs intForColumn:@"status"]];
            
            trainResult.trainid=[rs stringForColumn:@"trainid"];
            
            NSLog(@"result.1..null");
            trainResult.result=[rs stringForColumn:@"result"];
            NSLog(@"result..2.null");
            
            [trainResult setStarttime:[rs longForColumn:@"starttime"]];
            [trainResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            break;
            
        }
    }];
    return trainResult;
}

+ (TrainingRecord *)getLatestTrainRecord{
    
    __block TrainingRecord *trainResult = [[TrainingRecord alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM trains ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        NSLog(@"get result..latest train...%lu",(unsigned long)[[rs resultDictionary] count]);

        
        while([rs next]){

            //NSLog(@"get result.....%@",[rs stringForColumn:@"trainid"]);
            
            // trainResult = [[TrainingRecord alloc]init];
            
            
            [trainResult setLevel:[rs intForColumn:@"level"]];
            
            
            [trainResult setStatus:[rs intForColumn:@"status"]];
            
            
            trainResult.trainid=[rs stringForColumn:@"trainid"];
            
            trainResult.result=[rs stringForColumn:@"result"];
            
            
            [trainResult setStarttime:[rs longForColumn:@"starttime"]];
            
            [trainResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            //            NSLog(@"trainid %@",[rs stringForColumn:@"trainid"]);
            
            
            
            break;
            
            
            
            
            
        }
    }];
    return trainResult;
}

+ (void)delNoIdRecord{
    
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        
        NSLog(@"check if it run ?");
        
        NSString *sql=[NSString stringWithFormat:@"DELETE FROM walking WHERE type=0"];
        
        
        [db executeUpdate:sql];
        
        
        NSString *sql2=[NSString stringWithFormat:@"DELETE FROM walking WHERE type=1"];
        
        
        [db executeUpdate:sql2];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
    
    
}



+ (void)deleteTrainRecordById:(NSString *) trainid{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        
        
        [db beginTransaction];
        
        
        NSLog(@"test here :%@",trainid);
        
        NSString *sql=[NSString stringWithFormat:@"DELETE FROM walking WHERE type=1 AND trainid = \"%@\" ",trainid];
        
     
        
        [db executeUpdate:sql];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db commit];
        
        [db close];
        
        
    }];
}








+ (void)delTrainRecord:(NSString *) trainid{
    
    
    TrainingRecord *record=[DBHelper getTrainRecordByID:trainid];
    
    [record setStatus:3];
    
    [DBHelper addTrainRecord:record];
    
    
}


+ (BOOL) addWalkingCWAverageChartRecord:(WalkingRecord *) walking{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        
        
        NSString *checkSql;
        
        
        if (walking.recordid!=nil&&![walking.recordid isEqualToString:@""]) {
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM walking_cw_average_chart WHERE recordid = \"%@\"",walking.recordid];
            
            
        }else{
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM walking_cw_average_chart WHERE recordtime = %ld AND type = %ld",[walking getRecordtime],(long)[walking getType]];
        }
        
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        [check next];
        
        
        if ([check resultDictionary])
        {
            NSLog(@"update...");
            NSString *sql = nil;
            
            
            if (walking.recordid!=nil&&![walking.recordid isEqualToString:@""]) {
                
                
                sql=[NSString stringWithFormat:@"UPDATE walking_cw_average_chart SET type=%ld,foodlistid=\"%@\", trainid=\"%@\",result=\"%@\",gps=\"%@\",route=\"%@\",steps=\"%@\",distance=\"%@\",caloburnt=\"%@\",target=\"%@\",pace=\"%@\",persistime=\"%@\", persistimeL=%ld, recordtime=%ld WHERE recordid=\"%@\"",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,walking.gps==nil?@"":walking.gps,walking.route==nil?@"":walking.route,walking.steps==nil?@"0":[DBHelper encryptionString:walking.steps],walking.distance==nil?@"0":[DBHelper encryptionString:walking.distance],walking.calsburnt==nil?@"0":[DBHelper encryptionString:walking.calsburnt],walking.target==nil?@"0":walking.target,walking.pace==nil?@"0":walking.pace,walking.persistimeStr==nil?@"":[DBHelper encryptionString:walking.persistimeStr],[walking getPersistime],[walking getRecordtime],walking.recordid];
                
                
                
                
            }else{
                
                sql=[NSString stringWithFormat:@"UPDATE walking_cw_average_chart SET type=%ld,foodlistid=\"%@\", trainid=\"%@\",result=\"%@\",gps=\"%@\",route=\"%@\",steps=\"%@\",distance=\"%@\",caloburnt=\"%@\",target=\"%@\",pace=\"%@\",persistime=\"%@\", persistimeL=%ld,recordid=\"%@\" WHERE recordtime=%ld",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,walking.gps==nil?@"":walking.gps,walking.route==nil?@"":walking.route,walking.steps==nil?@"0":[DBHelper encryptionString:walking.steps],walking.distance==nil?@"0":[DBHelper encryptionString:walking.distance],walking.calsburnt==nil?@"0":[DBHelper encryptionString:walking.calsburnt],walking.target==nil?@"0":walking.target,walking.pace==nil?@"0":walking.pace,walking.persistimeStr==nil?@"":[DBHelper encryptionString:walking.persistimeStr],[walking getPersistime],walking.recordid==nil?@"":walking.recordid,[walking getRecordtime]];
            }
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            NSLog(@"add...");
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO walking_cw_average_chart(type,foodlistid, trainid,result,gps,route,steps,distance,caloburnt,target,pace,persistime, persistimeL,recordid,recordtime) VALUES (%ld,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%ld,\"%@\",%ld)",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,walking.gps==nil?@"":walking.gps,walking.route==nil?@"":walking.route,walking.steps==nil?@"0":[DBHelper encryptionString:walking.steps],walking.distance==nil?@"0":[DBHelper encryptionString:walking.distance],walking.calsburnt==nil?@"0":[DBHelper encryptionString:walking.calsburnt],walking.target==nil?@"0":walking.target,walking.pace==nil?@"0":walking.pace,walking.persistimeStr==nil?@"":[DBHelper encryptionString:walking.persistimeStr],[walking getPersistime],walking.recordid==nil?@"":walking.recordid,[walking getRecordtime]];
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    return result;
    
}


+ (NSMutableArray *)getCWAverageChartRecordDate:(long)start enddate:(long)end type:(NSInteger)thetype{
    
    
    __block NSMutableArray *cwResultArray = [[NSMutableArray alloc]init];
    
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql;
        
        selectSql= [NSString stringWithFormat:@"SELECT * FROM walking_cw_average_chart WHERE  type=%ld AND recordtime BETWEEN %ld AND %ld ORDER BY recordtime DESC",(long)thetype,start,end];
        
        if (start==0&&end==0) {
            
            selectSql= [NSString stringWithFormat:@"SELECT * FROM walking_cw_average_chart WHERE type=%ld ORDER BY recordtime DESC",(long)thetype];
        }
        
        //NSLog(@"%@.......sql",selectSql);
        
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while([rs next]){
            WalkingRecord *cwResult = [[WalkingRecord alloc]init];
            [cwResult setType:[rs intForColumn:@"type"]];
            cwResult.foodlistid=[rs stringForColumn:@"foodlistid"];
            cwResult.trainid=[rs stringForColumn:@"trainid"];
            cwResult.result=[rs stringForColumn:@"result"];
            cwResult.gps=[rs stringForColumn:@"gps"];
            cwResult.route=[rs stringForColumn:@"route"];
            cwResult.steps=[rs stringForColumn:@"steps"];
            cwResult.distance=[rs stringForColumn:@"distance"];
            cwResult.calsburnt=[rs stringForColumn:@"caloburnt"];
            cwResult.target=[rs stringForColumn:@"target"];
            cwResult.pace=[rs stringForColumn:@"pace"];
            cwResult.persistimeStr=[rs stringForColumn:@"persistime"];
            cwResult.recordid=[rs stringForColumn:@"recordid"];
            [cwResult setPersistime:[rs longForColumn:@"persistimeL"]];
            [cwResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            
            cwResult.steps=[DBHelper decryptionString:cwResult.steps];
            cwResult.distance=[DBHelper decryptionString:cwResult.distance];
            cwResult.calsburnt=[DBHelper decryptionString:cwResult.calsburnt];
            cwResult.persistimeStr=[DBHelper decryptionString:cwResult.persistimeStr];
            
            
            
            [cwResultArray addObject:cwResult];
            
        }
    }];
    return cwResultArray;
}


+ (BOOL) addWalkingTrainAverageChartRecord:(WalkingRecord *) walking{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        
        
        NSString *checkSql;
        
        
        if (walking.recordid!=nil&&![walking.recordid isEqualToString:@""]) {
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM walking_train_average_chart WHERE recordid = \"%@\"",walking.recordid];
            
            
        }else{

             checkSql=[NSString stringWithFormat:@"SELECT * FROM walking_train_average_chart WHERE recordtime = %ld AND type = %ld",[walking getRecordtime],(long)[walking getType]];
        }
        
        NSLog(@"check sql......%@",checkSql);
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        [check next];
        
        
        if ([check resultDictionary])
        {
            NSLog(@"update...");
            NSString *sql = nil;
            
            
            if (walking.recordid!=nil&&![walking.recordid isEqualToString:@""]) {
                
                
                sql=[NSString stringWithFormat:@"UPDATE walking_train_average_chart SET type=%ld,foodlistid=\"%@\", trainid=\"%@\",result=\"%@\",gps=\"%@\",route=\"%@\",steps=\"%@\",distance=\"%@\",caloburnt=\"%@\",target=\"%@\",pace=\"%@\",persistime=\"%@\", persistimeL=%ld, recordtime=%ld WHERE recordid=\"%@\"",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,walking.gps==nil?@"":walking.gps,walking.route==nil?@"":walking.route,walking.steps==nil?@"0":[DBHelper encryptionString:walking.steps],walking.distance==nil?@"0":[DBHelper encryptionString:walking.distance],walking.calsburnt==nil?@"0":[DBHelper encryptionString:walking.calsburnt],walking.target==nil?@"0":walking.target,walking.pace==nil?@"0":walking.pace,walking.persistimeStr==nil?@"":[DBHelper encryptionString:walking.persistimeStr],[walking getPersistime],[walking getRecordtime],walking.recordid];
                
                
                
                
            }else{
                
                sql=[NSString stringWithFormat:@"UPDATE walking_train_average_chart SET type=%ld,foodlistid=\"%@\", trainid=\"%@\",result=\"%@\",gps=\"%@\",route=\"%@\",steps=\"%@\",distance=\"%@\",caloburnt=\"%@\",target=\"%@\",pace=\"%@\",persistime=\"%@\", persistimeL=%ld,recordid=\"%@\" WHERE recordtime=%ld",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,walking.gps==nil?@"":walking.gps,walking.route==nil?@"":walking.route,walking.steps==nil?@"0":[DBHelper encryptionString:walking.steps],walking.distance==nil?@"0":[DBHelper encryptionString:walking.distance],walking.calsburnt==nil?@"0":[DBHelper encryptionString:walking.calsburnt],walking.target==nil?@"0":walking.target,walking.pace==nil?@"0":walking.pace,walking.persistimeStr==nil?@"":[DBHelper encryptionString:walking.persistimeStr],[walking getPersistime],walking.recordid==nil?@"":walking.recordid,[walking getRecordtime]];
            }
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            NSLog(@"add...");
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO walking_train_average_chart(type,foodlistid, trainid,result,gps,route,steps,distance,caloburnt,target,pace,persistime, persistimeL,recordid,recordtime) VALUES (%ld,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%ld,\"%@\",%ld)",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,walking.gps==nil?@"":walking.gps,walking.route==nil?@"":walking.route,walking.steps==nil?@"0":[DBHelper encryptionString:walking.steps],walking.distance==nil?@"0":[DBHelper encryptionString:walking.distance],walking.calsburnt==nil?@"0":[DBHelper encryptionString:walking.calsburnt],walking.target==nil?@"0":walking.target,walking.pace==nil?@"0":walking.pace,walking.persistimeStr==nil?@"":[DBHelper encryptionString:walking.persistimeStr],[walking getPersistime],walking.recordid==nil?@"":walking.recordid,[walking getRecordtime]];
            
            //NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    return result;
    
}


+ (NSMutableArray *)getTrainAverageChartRecordDate:(long)start enddate:(long)end type:(NSInteger)thetype{
    
    
    __block NSMutableArray *cwResultArray = [[NSMutableArray alloc]init];
    
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql;
        
        selectSql= [NSString stringWithFormat:@"SELECT * FROM walking_train_average_chart WHERE type=%ld AND recordtime BETWEEN %ld AND %ld ORDER BY recordtime DESC",(long)thetype,start,end];
        
        if (start==0&&end==0) {
            
            selectSql= [NSString stringWithFormat:@"SELECT * FROM walking_train_average_chart WHERE type=%ld  ORDER BY recordtime DESC",(long)thetype];
        }
        
        //NSLog(@"%@.......sql",selectSql);
        
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while([rs next]){

            WalkingRecord *cwResult = [[WalkingRecord alloc]init];
            [cwResult setType:[rs intForColumn:@"type"]];
            cwResult.foodlistid=[rs stringForColumn:@"foodlistid"];
            cwResult.trainid=[rs stringForColumn:@"trainid"];
            cwResult.result=[rs stringForColumn:@"result"];
            cwResult.gps=[rs stringForColumn:@"gps"];
            cwResult.route=[rs stringForColumn:@"route"];
            cwResult.steps=[rs stringForColumn:@"steps"];
            cwResult.distance=[rs stringForColumn:@"distance"];
            cwResult.calsburnt=[rs stringForColumn:@"caloburnt"];
            cwResult.target=[rs stringForColumn:@"target"];
            cwResult.pace=[rs stringForColumn:@"pace"];
            cwResult.persistimeStr=[rs stringForColumn:@"persistime"];
            cwResult.recordid=[rs stringForColumn:@"recordid"];
            [cwResult setPersistime:[rs longForColumn:@"persistimeL"]];
            [cwResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            
            cwResult.steps=[DBHelper decryptionString:cwResult.steps];
            cwResult.distance=[DBHelper decryptionString:cwResult.distance];
            cwResult.calsburnt=[DBHelper decryptionString:cwResult.calsburnt];
            cwResult.persistimeStr=[DBHelper decryptionString:cwResult.persistimeStr];
            
            
            
            [cwResultArray addObject:cwResult];
            
        }
    }];
    return cwResultArray;
}


#pragma mark -- DELETE the id<0 for Calendar
+(BOOL)deleteCalendarBP
{
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM calendar_bp WHERE id" ];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         
         [check next];
         
         
         NSLog(@"Delete....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id<0"];
         // NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bp SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime,[DiaryAll bpID]];
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    //1
    
    return result;
}
+(BOOL)deleteCalendarBG
{
    
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_bg WHERE id"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bg WHERE id<0"];
         
         
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
    
}
+(BOOL)deleteCalendarECG
{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_ecg WHERE id"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_ecg WHERE id<0"];
         
         
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
    
};
+(BOOL)deleteCalendarOthers
{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_others WHERE id"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_others WHERE id<0"];
         
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
    
};
+(BOOL)deleteCalendarWalking
{
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_walk WHERE id"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_walk WHERE id<0"];
         // NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bp SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime,[DiaryAll bpID]];
         
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
}
+(BOOL)deleteCalendarMedication
{
    
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         [db beginTransaction];
         
         NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  calendar_medication WHERE meid"];
         
         
         FMResultSet *check = [db executeQuery: checkSql];
         NSLog(@"check===%@",check);
         
         [check next];
         
         
         NSLog(@"upDate....");
         NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_medication WHERE meid<0"];
         // NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE calendar_bp SET id=\"%@\",time=\"%@\",type=\"%@\",repeat=\"%@\",createtime=\"%@\",servertime=\"%@\" WHERE id=\"%@\"",DiaryAll.bpID,DiaryAll.bpTime,DiaryAll.bpType,DiaryAll.bpRepeat,DiaryAll.bpCreateTime,DiaryAll.bpServerTime,[DiaryAll bpID]];
         
         result=[db executeUpdate:sql];
         // NSLog(@"result=%hhd",result);
         if ([db hadError]&&result==NO) {
             NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
             
             result=NO;
         }
         [check close];
         
         [db commit];
         
         [db close];
         
     }];
    
    
    return result;
}



#pragma mark -
#pragma mark Calorie Reckoner
+(BOOL)isFoodListFileNameNew:(NSString *)filename
{
    __block NSString *filename_db;
    __block BOOL isNew = FALSE;
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT file_name FROM food_list_filename "];
      //  NSLog(@"Vaycent check foodlist issue checkSql:%@",checkSql);
        FMResultSet *check = [db executeQuery:checkSql];
        
        if ([check next]) {
            filename_db = [check stringForColumn:@"file_name"];
        }
       
        
        if ([filename isEqualToString:filename_db])
            isNew = FALSE;
        else
            isNew = TRUE;
        
      //  NSLog(@"Vaycent check foodlist issue isNew:%d",isNew);

        if (isNew)
        {
            if (filename_db.length > 0)
            {
                NSLog(@"New food list file found...old:%@ new:%@",filename_db,filename);
                NSString *sql = [NSString stringWithFormat:@"UPDATE food_list_filename  SET (file_name) VALUES (\"%@\") WHERE file_name = \"%@\" ",filename,filename_db];
                result = [db executeUpdate:sql];
                if ([db hadError]||result==NO) {
                    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                    result = NO;
                }
            } else {
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO food_list_filename (file_name) VALUES (\"%@\")",filename];
                result = [db executeUpdate:sql];
                if ([db hadError]||result==NO) {
                    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                    result = NO;
                }
            }
        }
        [check close];
        [db close];
    }];
    
    return isNew;
}

+(BOOL)addFoodRecord:(FoodEntry *)foodEntry
{
    __block BOOL result = YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        NSString *checkSql = [NSString stringWithFormat:@"SELECT food_name_en FROM food_list WHERE food_id = %d",[[foodEntry getNumber]intValue]];
        FMResultSet *checkRS = [db executeQuery:checkSql];
        
        if ([checkRS next]) {
            NSString *sql = [NSString stringWithFormat:@"UPDATE food_list SET food_name_en=\"%@\",food_name_zh=\"%@\",quantity_en=\"%@\",quantity_zh=\"%@\",food_type=\"%@\",calories=%d,picture_filename=\"%@\",quantity=%d,food_id=%d WHERE food_id = %d",[foodEntry getName_en],[foodEntry getName_zh],[foodEntry getQuantityUnit_en],[foodEntry getQuantityUnit_zh],[foodEntry getFoodType],[[foodEntry getFoodCalories]intValue],[foodEntry getFoodImageFileName],[[foodEntry getQuantity]intValue],[[foodEntry getNumber]intValue],[[foodEntry getNumber]intValue]];
            result = [db executeUpdate:sql];
            
            if ([db hadError]||result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
        } else {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO food_list (food_name_en,food_name_zh,quantity_en,quantity_zh,food_type,calories,picture_filename,quantity,food_id) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,\"%@\",%d,%d)",[foodEntry getName_en],[foodEntry getName_zh],[foodEntry getQuantityUnit_en],[foodEntry getQuantityUnit_zh],[foodEntry getFoodType],[[foodEntry getFoodCalories]intValue],[foodEntry getFoodImageFileName],[[foodEntry getQuantity]intValue],[[foodEntry getNumber]intValue]];
            result = [db executeUpdate:sql];
            if ([db hadError]||result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                result=NO;
            }
        }
        [checkRS close];
        [db commit];
        [db close];
    }];
    return result;
}

+ (NSMutableArray *)getAllFoodRecord:(NSString *)foodType{
    __block NSMutableArray *foodResultArray = [[NSMutableArray alloc]init];
    __block FoodEntry *foodResult;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT food_name_en,food_name_zh,quantity_en,quantity_zh,food_type,calories,picture_filename,quantity,food_id FROM food_list WHERE food_type = \"%@\"",foodType];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]) {
            foodResult = [[FoodEntry alloc] initWithNumber:[NSNumber numberWithInt:[rs intForColumn:@"food_id"]]
                                                   name_en:[rs stringForColumn:@"food_name_en"]
                                                   name_zh:[rs stringForColumn:@"food_name_zh"]
                                           quantityUnit_en:[rs stringForColumn:@"quantity_en"]
                                           quantityUnit_zh:[rs stringForColumn:@"quantity_zh"]
                                                  foodType:[rs stringForColumn:@"food_type"]
                                              foodCalories:[NSNumber numberWithInt:[rs intForColumn:@"calories"]]
                                         foodImageFileName:[rs stringForColumn:@"picture_filename"]
                                                  quantity:[NSNumber numberWithInt:[rs intForColumn:@"quantity"]] ];
            [foodResultArray addObject:foodResult];
        }
        [rs close];
        [db close];
    }];
    return foodResultArray;
}

+(void)changeFoodQuantityUpdateDB:(NSNumber *)food_id foodQuantity:(NSInteger)newFoodQuantity {
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE food_list SET quantity = %ld WHERE food_id = %d",(long)newFoodQuantity,[food_id intValue]];
        NSLog(@"updateSql:%@",updateSql);
        [db executeUpdate:updateSql];
        
        [db close];
    }];
}

+ (NSMutableArray *)getFoodRecordsModified{
    __block NSMutableArray *returnResultArray = [[NSMutableArray alloc]init];
    __block FoodEntry *eachFoodEntry;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT food_id,food_name_en,food_name_zh,quantity_en,quantity_zh,food_type,calories,picture_filename,quantity FROM food_list WHERE quantity > 0 order by food_id asc"];
        
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]) {
            eachFoodEntry = [[FoodEntry alloc] initWithNumber:[NSNumber numberWithInt:[rs intForColumn:@"food_id"]]
                                                      name_en:[rs stringForColumn:@"food_name_en"]
                                                      name_zh:[rs stringForColumn:@"food_name_zh"]
                                              quantityUnit_en:[rs stringForColumn:@"quantity_en"]
                                              quantityUnit_zh:[rs stringForColumn:@"quantity_zh"]
                                                     foodType:[rs stringForColumn:@"food_type"]
                                                 foodCalories:[NSNumber numberWithInt:[rs intForColumn:@"calories"]]
                                            foodImageFileName:[rs stringForColumn:@"picture_filename"]
                                                     quantity:[NSNumber numberWithInt:[rs intForColumn:@"quantity"]] ];
            [returnResultArray addObject:eachFoodEntry];
        }
        [rs close];
        [db close];
    }];
    return returnResultArray;
}

+ (void)resetFoodListTable{
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *sql = [NSString stringWithFormat:@"UPDATE food_list SET quantity = 0"];
        NSLog(@"reseting sql:%@",sql);
        [db executeUpdate:sql];
        
        [db close];
    }];
}

+ (void)updateFoodDetail:(NSString *)recordId foodRecordDetail:(NSString *)recordDetail{
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE food_records SET record_detail = \"%@\" WHERE record_id = \"%@\"",recordDetail,recordId];
        NSLog(@"updateSql:%@",updateSql);
        [db executeUpdate:updateSql];
        
        
        [db close];
    }];
    
}

+ (void)addFoodFinalRecord:(NSString *)recordTime foodRecordDetail:(NSString *)recordDetail totalCalories:(NSNumber *)totalCalories recordId:(NSString *)recordId status:(NSString *)status{
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *recordtime_NSDate = [dateFormatter dateFromString:recordTime];
        long recordTime_long = [recordtime_NSDate timeIntervalSince1970];
        NSLog(@"!!inserting nsdate:%@ recordTime_long:%ld",recordtime_NSDate, recordTime_long);
        //        NSString *checkSql = []
        
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO food_records (recordtime_long,recordtime,record_detail,total_calories,record_id,not_upload_status) VALUES (%ld,\"%@\",\"%@\",%lld,\"%@\",%@)",recordTime_long,recordTime,recordDetail,[totalCalories longLongValue],recordId,status];
        NSLog(@"!!Calo insertSql:%@",insertSql);
        [db executeUpdate:insertSql];
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
}

+ (NSMutableArray *)getAllCaloriesRecords{
    __block NSMutableArray *returnResultArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT recordtime,record_detail,total_calories,record_id FROM food_records ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        long beforeThreeMonthTiming = [[NSDate date]timeIntervalSince1970] - 60*60*24*31*3;
        
        while ([rs next]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *recordtime_NSDate = [dateFormatter dateFromString:[rs stringForColumn:@"recordtime"]];
            long recordTime_long = [recordtime_NSDate timeIntervalSince1970];
            if (recordTime_long < beforeThreeMonthTiming)
                break;
            NSMutableDictionary *entryDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [rs stringForColumn:@"record_id"],@"record_id",
                                       [rs stringForColumn:@"recordtime"],@"recordTime",
                                       [rs stringForColumn:@"record_detail"],@"record_detail",
                                       [NSNumber numberWithLong:[rs longForColumn:@"total_calories"] ],@"totalCalories", nil];
            [returnResultArray addObject:entryDict];
        }
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [rs close];
        [db close];
    }];
    return returnResultArray;
}

+ (NSMutableDictionary *)getNewestFoodRecords{
    
    __block NSMutableDictionary *entryDict;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT recordtime,record_detail,total_calories,record_id FROM food_records ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        long beforeThreeMonthTiming = [[NSDate date]timeIntervalSince1970] - 60*60*24*31*3;
        
        while ([rs next]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *recordtime_NSDate = [dateFormatter dateFromString:[rs stringForColumn:@"recordtime"]];
            long recordTime_long = [recordtime_NSDate timeIntervalSince1970];
            if (recordTime_long < beforeThreeMonthTiming)
                break;
            
            entryDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                              [rs stringForColumn:@"record_id"],@"record_id",
                                              [rs stringForColumn:@"recordtime"],@"recordTime",
                                              [rs stringForColumn:@"record_detail"],@"record_detail",
                                              [NSNumber numberWithLong:[rs longForColumn:@"total_calories"] ],@"totalCalories", nil];
           
        }
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [rs close];
        [db close];
    }];
    return entryDict;
}

+ (NSString *)getNewestFoodDate_DB{
    __block NSString *newestDate  = [[NSString alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT recordtime_long FROM food_records ORDER BY recordtime_long DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            newestDate = [NSString stringWithFormat:@"%ld",[rs longForColumn:@"recordtime_long"]];
            break;
        }
    }];
    return newestDate;
}

+ (NSMutableArray *)getFoodNotUpload{
    
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT recordtime, record_detail, total_calories FROM food_records WHERE not_upload_status = 1"];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]){
            NSDictionary *foodRecord_NSDict = [[NSDictionary alloc]init];
            foodRecord_NSDict = [NSDictionary dictionaryWithObjectsAndKeys:[rs stringForColumn:@"recordtime"],@"recordTime",
                                 [rs stringForColumn:@"record_detail"],@"recordDetail",
                                 [NSNumber numberWithInt:[rs intForColumn:@"total_calories"]], @"totalCalories",  nil];
            [returnArray addObject:foodRecord_NSDict];
        }
        [db close];
    }];
    NSLog(@"!!getFoodNotUpload:%@",returnArray);
    return returnArray;
}

+ (NSMutableArray *)getRecordIdsWithEmptyRecordDetail{
    __block NSMutableArray *returnArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT record_id FROM food_records WHERE (length(record_detail) < 0))"];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]) {
            NSString *recordId = [rs stringForColumn:@"record_id"];
            [returnArray addObject:recordId];
        }
        [db close];
    }];
    NSLog(@"!!recordIdsWithEmptyRecordDetail:%@",returnArray);
    return returnArray;
}

+ (void)setFoodRecordStatus:(NSInteger)status recordId:(NSString *)recordId recordTime:(NSString *)recordTime recordDetail:(NSString *)recordDetail {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSString *updateSql = [NSString stringWithFormat:@"UPDATE food_records SET record_id = \"%@\", not_upload_status = %ld WHERE (record_detail=\"%@\")AND(recordtime = \"%@\")",recordId, (long)status, recordDetail,recordTime];
        [db executeUpdate:updateSql];
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
}

+ (NSMutableArray *) getCaloriesRecordsByDate:(long)start enddate:(long)end{
    
    __block NSMutableArray *returnResultArray = [[NSMutableArray alloc]init];
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT recordtime_long,record_detail,total_calories FROM food_records WHERE recordtime_long BETWEEN %ld AND %ld ORDER BY recordtime DESC",start,end];
        FMResultSet *rs = [db executeQuery:selectSql];
        NSLog(@"!!selectSql:%@",selectSql);
        while ([rs next]) {
            //NSLog(@"!!rs in totalCalories:%ld, record_detail:%@",[rs longForColumn:@"total_calories"],[rs stringForColumn:@"record_detail"]);
            
            NSString *recordtime_str=[NSString stringWithFormat:@"%ld",[rs longForColumn:@"recordtime_long"]];
            
            NSString *total_cals=[NSString stringWithFormat:@"%ld",[rs longForColumn:@"total_calories"]];
            
            
            NSDictionary *entryDict = [NSDictionary dictionaryWithObjectsAndKeys:recordtime_str,@"recordtime",total_cals,@"total_cals", nil];
            
            
            //NSLog(@"!!entryDict:%@",entryDict);
            
            
            [returnResultArray addObject:entryDict];
        }
        [rs close];
        [db close];
    }];
    return returnResultArray;
}

+ (NSString *)deleteFoodDetail:(NSString *)recordTime {
    __block NSString *recordId = @"";
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT record_id FROM food_records WHERE recordtime = \"%@\" ",recordTime];
        FMResultSet *rs = [db executeQuery:selectSql];
        while ([rs next]) {
            recordId = [rs stringForColumn:@"record_id"];
        }
        
        NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM food_records WHERE record_id = \"%@\"",recordId];
        [db executeUpdate:deleteSql];
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
    return recordId;
}

#pragma mark -
#pragma mark Step by step slideshow / light intro

+ (BOOL)isLightIntro:(NSString *)view {
    __block BOOL returnBool;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        NSString *selectSql = [NSString stringWithFormat:@"SELECT is_light_intro FROM light_intro WHERE view = \"%@\"",view];
        FMResultSet *rs = [db executeQuery:selectSql];
        int lightIntroStatus;
        while ([rs next]) {
            lightIntroStatus = [rs intForColumn:@"is_light_intro"];
        }
        if (lightIntroStatus == 1)
            returnBool = TRUE;
        else
            returnBool = FALSE;
        
        [rs close];
        [db close];
    }];
    return returnBool;
}

+ (void)changeLightIntro:(NSString *)view status:(NSInteger)status{
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        [db beginTransaction];
        
        NSString *checkSql = [NSString stringWithFormat:@"SELECT * FROM light_intro WHERE view = \"%@\"",view];
        FMResultSet *check = [db executeQuery:checkSql];
        [check next];
        
        NSString *sql = nil;
        if ([check resultDictionary])
        {
            sql = [NSString stringWithFormat:@"UPDATE light_intro SET is_light_intro=%ld WHERE view = \"%@\"",(long)status,view];
            result = [db executeUpdate:sql];
            if ([db hadError]&&result == NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            }
        } else {
            sql = [NSString stringWithFormat:@"INSERT INTO light_intro (view,is_light_intro) VALUES (\"%@\",%ld)",view,(long)status];
            result = [db executeUpdate:sql];
            if ([db hadError]&&result == NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            }
            
        }
        [check close];
        [db commit];
        [db close];
    }];
}



#pragma mark - encryption

+ (NSString *) encryptionString:(NSString *) strvalue{
    
    if([strvalue isEqualToString:@"0"]){
        NSLog(@"strvalue:%@",strvalue);
        
        return @"0";
    }
    
    NSData* data = [strvalue dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSData *encryptedData = [RNEncryptor encryptData:data
    //                                        withSettings:kRNCryptorAES256Settings
    //                                            password:nil
    //                                               error:nil];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *check1=[defaults objectForKey:@"key1"];
    NSData *check2=[defaults objectForKey:@"key2"];
    NSData *encryptionKey;
    NSData *HMACKey;
    
    if(check1==nil||check2==nil){
        encryptionKey = [RNCryptor randomDataOfLength:kRNCryptorAES256Settings.keySettings.keySize];
        HMACKey = [RNCryptor randomDataOfLength:kRNCryptorAES256Settings.HMACKeySettings.keySize];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject: encryptionKey forKey: @"key1"];
        [defaults setObject: HMACKey forKey: @"key2"];
        
        [defaults synchronize];
        
    }
    
    encryptionKey= [defaults objectForKey:@"key1"];
    HMACKey =[defaults objectForKey:@"key2"];
    
    NSData *encryptedData = [RNEncryptor encryptData:data
                                        withSettings:kRNCryptorAES256Settings
                                       encryptionKey:encryptionKey
                                             HMACKey:HMACKey
                                               error:nil];
    
    
    
    
    NSString *result=[encryptedData base64EncodedStringWithOptions:NO];
    
    return result;
}

+ (NSString *) decryptionString:(NSString *) strvalue2{
    if([strvalue2 isEqualToString:@"0"]){
        NSLog(@"strvalue2:%@",strvalue2);
        
        return @"0";
    }
    
    
    NSData *tmp=[[NSData alloc] initWithBase64EncodedString:strvalue2 options:NO];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *encryptionKey= [defaults objectForKey:@"key1"];
    NSData *HMACKey =[defaults objectForKey:@"key2"];
    
    NSData *decryptedData = [RNDecryptor decryptData:tmp withEncryptionKey:encryptionKey HMACKey:HMACKey error:nil];
    
    NSString *result = [[NSString alloc] initWithData:decryptedData  encoding:NSUTF8StringEncoding];
    
    
    return result;
}




#pragma mark -
#pragma mark  News
+ (BOOL) addNewsRecordToDB:(MessageObject *) message{
    
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        
        NSString *checkSql;
        
        
        if (message.messageid!=nil&&![message.messageid isEqualToString:@""]) {
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM news WHERE messageid = \"%@\"",message.messageid];
            
            
        }else{
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM news WHERE send_time = \"%@\"",message.send_time];
        }
        
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        [check next];
        
        
        if ([check resultDictionary])
        {
            NSLog(@"update...");
            NSString *sql = nil;
            
            
            
            
            if (message.messageid!=nil&&![message.messageid isEqualToString:@""]) {
                
                
                sql=[NSString stringWithFormat:@"UPDATE news SET is_read=\"%@\",send_time=\"%@\",ensummary=\"%@\", zhsummary=\"%@\", enicon=\"%@\", zhicon=\"%@\" WHERE messageid=\"%@\"",message.is_read,message.send_time,message.ensummary,message.zhsummary,message.enicon,message.zhicon ,message.messageid];
                
                
                
                
            }else{
                
                sql=[NSString stringWithFormat:@"UPDATE news SET is_read=%@,send_time=%@,ensummary=%@, zhsummary=%@, enicon=%@, zhicon=%@ WHERE messageid=%@",message.is_read,message.send_time,message.ensummary,message.zhsummary,message.enicon,message.zhicon ,message.messageid];
                //                sql=[NSString stringWithFormat:@"UPDATE trains SET level=%d,status=%d,result=\"%@\", starttime=%ld,trainid=\"%@\" WHERE recordtime=%ld",[train getLevel],[train getStatus],train.result,[train getStarttime],train.trainid,[train getRecordtime]];
                
                
            }
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            NSLog(@"add...");
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO news(messageid,is_read,send_time, ensummary,zhsummary,enicon,zhicon) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",message.messageid, message.is_read,message.send_time,message.ensummary,message.zhsummary,message.enicon,message.zhicon];
            
            
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    if (result) {
        NSLog(@"add News ok......");
    }
    
    return result;
    
    
    
    //    return true;
}

+ (NSMutableArray *) loadNewsFromDB{
    NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM news ORDER BY send_time DESC"];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            MessageObject *obj=[[MessageObject alloc] initWithMessageid:[rs stringForColumn:@"messageid"] is_read:[rs stringForColumn:@"is_read"] send_time:[rs stringForColumn:@"send_time"] ensummary:[rs stringForColumn:@"ensummary"] zhsummary:[rs stringForColumn:@"zhsummary"] enicon:[rs stringForColumn:@"enicon"] zhicon:[rs stringForColumn:@"zhicon"]];
            [resultArrary addObject:obj];
        }
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    
    return resultArrary;
}

+ (void) setNewsRead:(NSString *) messageid{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *sql=[NSString stringWithFormat:@"UPDATE news SET is_read=\"%@\" WHERE messageid=\"%@\"",@"Y",messageid];
        [db executeUpdate:sql];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
    
    
}





#pragma mark -
#pragma mark  MessageBox
+ (BOOL) addMessageRecordToDB:(MessageObject *) message{
    
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        
        NSString *checkSql;
        
        
        if (message.messageid!=nil&&![message.messageid isEqualToString:@""]) {
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM messages WHERE messageid = \"%@\"",message.messageid];
            
            
        }else{
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM messages WHERE send_time = \"%@\"",message.send_time];
        }
        
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        [check next];
        
        
        if ([check resultDictionary])
        {
            NSLog(@"update...");
            NSString *sql = nil;
            
            
            
            
            if (message.messageid!=nil&&![message.messageid isEqualToString:@""]) {
                
                
                sql=[NSString stringWithFormat:@"UPDATE messages SET is_read=\"%@\",send_time=\"%@\",ensummary=\"%@\", zhsummary=\"%@\", enicon=\"%@\", zhicon=\"%@\" WHERE messageid=\"%@\"",message.is_read,message.send_time,message.ensummary,message.zhsummary,message.enicon,message.zhicon ,message.messageid];
                
                
                
                
            }else{
                
                sql=[NSString stringWithFormat:@"UPDATE messages SET is_read=%@,send_time=%@,ensummary=%@, zhsummary=%@, enicon=%@, zhicon=%@ WHERE messageid=%@",message.is_read,message.send_time,message.ensummary,message.zhsummary,message.enicon,message.zhicon ,message.messageid];
                //                sql=[NSString stringWithFormat:@"UPDATE trains SET level=%d,status=%d,result=\"%@\", starttime=%ld,trainid=\"%@\" WHERE recordtime=%ld",[train getLevel],[train getStatus],train.result,[train getStarttime],train.trainid,[train getRecordtime]];
                
                
            }
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            NSLog(@"add...");
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO messages(messageid,is_read,send_time, ensummary,zhsummary,enicon,zhicon) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",message.messageid, message.is_read,message.send_time,message.ensummary,message.zhsummary,message.enicon,message.zhicon];
            
            
            
            
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    if (result) {
        NSLog(@"add message ok......");
    }
    
    return result;
    
    
    
    //    return true;
}

+ (NSMutableArray *) loadMessageFromDB{
    NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM messages ORDER BY send_time DESC"];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            MessageObject *obj=[[MessageObject alloc] initWithMessageid:[rs stringForColumn:@"messageid"] is_read:[rs stringForColumn:@"is_read"] send_time:[rs stringForColumn:@"send_time"] ensummary:[rs stringForColumn:@"ensummary"] zhsummary:[rs stringForColumn:@"zhsummary"] enicon:[rs stringForColumn:@"enicon"] zhicon:[rs stringForColumn:@"zhicon"]];
            [resultArrary addObject:obj];
        }
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    
    return resultArrary;
}

+ (void) deleteMessageRecordFromDB:(NSString *) messageid{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *sql=[NSString stringWithFormat:@"DELETE  FROM messages WHERE messageid=\"%@\"",messageid];
        
        
        
        [db executeUpdate:sql];
        
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
    
    
}

+ (void) setMessageRead:(NSString *) messageid{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *sql=[NSString stringWithFormat:@"UPDATE messages SET is_read=\"%@\" WHERE messageid=\"%@\"",@"Y",messageid];
        [db executeUpdate:sql];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        
        [db close];
    }];
    
    
}




#pragma mark - SAVE GENG
//创建表 或者 更新表
+(BOOL)addSaveCalendar:(int)isSave
{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  save_calendar "];
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //  NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE save_calendar SET is_save=\"%d\" WHERE id=\"%@\"",isSave,@"ISOK"];
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //      NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO save_calendar(id,is_save) VALUES (\"%@\",\"%d\")",@"ISOK",isSave];
            
            
            result=[db executeUpdate:sql];
            // NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}

//把表的內容變成數組拿下來
+(int)isSave
{
    __block int isSave;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,is_save  FROM save_calendar "];
         
         
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         
         while([rs next]){
             isSave =[rs intForColumn:@"is_save"] ;
         }
         
         
         
     }];
    
    NSLog(@"--------------------isSave=%d",isSave);
    return isSave;
    
    
}
#pragma mark - SAVE CALENDAR
//创建表 或者 更新表
+(BOOL)zhendeyouma:(int)isSave
{
    
    __block BOOL result=YES;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db beginTransaction];
        
        NSString *checkSql=[NSString stringWithFormat:@"SELECT * FROM  zhendeyougengxinguoma"];
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            //  NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE zhendeyougengxinguoma SET is_save=\"%d\" WHERE id=\"%@\"",isSave,@"GENG"];
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else
        {
            NSLog(@"ADD...");
            //      NSString *sql =[[NSString alloc] initWithFormat:@"DELETE FROM calendar_bp WHERE id =\"%@\"",DiaryAll.bpID];
            NSString *sql=[[NSString alloc]initWithFormat:@"INSERT INTO zhendeyougengxinguoma(id,is_save) VALUES (\"%@\",\"%d\")",@"GENG",isSave];
            
            
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
        }
        
        
        
        [check close];
        
        [db commit];
        
        [db close];
        
        
        
        
    }];
    
    
    
    return result;
    
}

//把表的內容變成數組拿下來
+(int)gengxinguoma
{
    __block int isSave;
    
    [self.dbQueue inDatabase:^(FMDatabase *db)
     {
         [db open];
         NSString* selectSql=[[NSString alloc]initWithFormat:@"SELECT id,is_save  FROM zhendeyougengxinguoma"];
         
         
         
         FMResultSet *rs = [db executeQuery:selectSql];
         
         
         while([rs next]){
             isSave =[rs intForColumn:@"is_save"] ;
         }
         
         
         
     }];
    
    NSLog(@"--------------------isSave=%d",isSave);
    return isSave;
    
    
}


#pragma mark -
#pragma mark  Game

+ (NSMutableArray *) getPlantList{
    
    
    __block  NSMutableArray * resultArrary=[[NSMutableArray alloc] init];
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,distance,steps,calories,fb_key,startDate,endDate FROM game WHERE status=\"1\" AND gameType=\"WalkPlanyt\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            GameObject *obj=[[GameObject alloc] init];
            
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            obj.distance=[rs stringForColumn:@"distance"];
            obj.steps=[rs stringForColumn:@"steps"];
            obj.calories=[rs stringForColumn:@"calories"];
            obj.fb_key=[rs stringForColumn:@"fb_key"];
            
            
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            NSLog(@"obj.gameType=%@",obj.gameType);
            NSLog(@" obj.plantType=%@", obj.plantType);
            NSLog(@"obj.plantName=%@",obj.plantName);
            NSLog(@"obg.SetStartdate=%ld",[rs longForColumn:@"startDate"]);
            
            [resultArrary addObject:obj];
            
            
            
        }
        NSLog(@"ResultArrayCW==%@",resultArrary);
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    
    return resultArrary;
    
}

+ (NSMutableArray *) getTrophyList{
    
    __block NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,distance,steps,calories,fb_key,startDate,endDate FROM game WHERE status=\"1\" AND gameType=\"TrainingTrophy\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            __block  GameObject *obj=[[GameObject alloc] init];
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            obj.distance=[rs stringForColumn:@"distance"];
            obj.steps=[rs stringForColumn:@"steps"];
            obj.calories=[rs stringForColumn:@"calories"];
            obj.fb_key=[rs stringForColumn:@"fb_key"];
            
            
            
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            NSLog(@"obj.gameType=%@",obj.gameType);
            NSLog(@" obj.plantType=%@", obj.plantType);
            NSLog(@"obj.plantName=%@",obj.plantName);
            NSLog(@"obg.SetStartdate=%ld",[rs longForColumn:@"startDate"]);
            
            [resultArrary addObject:obj];
            
        }
        NSLog(@"ResultArrayCW==%@",resultArrary);
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    
    return resultArrary;
    
}
+ (NSMutableArray *) getBronzeList{
    
    __block NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,distance,steps,calories,fb_key,startDate,endDate FROM game WHERE status=\"1\" AND gameType=\"TrainingBronze\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            __block  GameObject *obj=[[GameObject alloc] init];
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            obj.distance=[rs stringForColumn:@"distance"];
            obj.steps=[rs stringForColumn:@"steps"];
            obj.calories=[rs stringForColumn:@"calories"];

        
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            NSLog(@"obj.gameType=%@",obj.gameType);
            NSLog(@" obj.plantType=%@", obj.plantType);
            NSLog(@"obj.plantName=%@",obj.plantName);
            NSLog(@"obg.SetStartdate=%ld",[rs longForColumn:@"startDate"]);
            
            [resultArrary addObject:obj];
            
        }
        NSLog(@"ResultArrayTB==%@",resultArrary);
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    
    return resultArrary;
    
}
+ (NSMutableArray *) getSilverList{
    
    __block NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,distance,steps,calories,fb_key,startDate,endDate FROM game WHERE status=\"1\" AND gameType=\"TrainingSilver\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            __block  GameObject *obj=[[GameObject alloc] init];
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            obj.distance=[rs stringForColumn:@"distance"];
            obj.steps=[rs stringForColumn:@"steps"];
            obj.calories=[rs stringForColumn:@"calories"];
            
            
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            NSLog(@"obj.gameType=%@",obj.gameType);
            NSLog(@" obj.plantType=%@", obj.plantType);
            NSLog(@"obj.plantName=%@",obj.plantName);
            NSLog(@"obg.SetStartdate=%ld",[rs longForColumn:@"startDate"]);
            
            [resultArrary addObject:obj];
            
        }
        NSLog(@"ResultArrayTS==%@",resultArrary);
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    
    return resultArrary;
    
}

+ (NSMutableArray *) getGoldList{
    
    __block NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,distance,steps,calories,fb_key,startDate,endDate FROM game WHERE status=\"1\" AND gameType=\"TrainingGold\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            __block  GameObject *obj=[[GameObject alloc] init];
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            obj.distance=[rs stringForColumn:@"distance"];
            obj.steps=[rs stringForColumn:@"steps"];
            obj.calories=[rs stringForColumn:@"calories"];
            
            
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            NSLog(@"obj.gameType=%@",obj.gameType);
            NSLog(@" obj.plantType=%@", obj.plantType);
            NSLog(@"obj.plantName=%@",obj.plantName);
            NSLog(@"obg.SetStartdate=%ld",[rs longForColumn:@"startDate"]);
            
            [resultArrary addObject:obj];
            
        }
        NSLog(@"ResultArrayTG==%@",resultArrary);
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    
    return resultArrary;
    
}
+ (NSMutableArray *) getDiamondList{
    
    __block NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,distance,steps,calories,fb_key,startDate,endDate FROM game WHERE status=\"1\" AND gameType=\"TrainingDiamond\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            __block  GameObject *obj=[[GameObject alloc] init];
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            obj.distance=[rs stringForColumn:@"distance"];
            obj.steps=[rs stringForColumn:@"steps"];
            obj.calories=[rs stringForColumn:@"calories"];
            
            
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            NSLog(@"obj.gameType=%@",obj.gameType);
            NSLog(@" obj.plantType=%@", obj.plantType);
            NSLog(@"obj.plantName=%@",obj.plantName);
            NSLog(@"obg.SetStartdate=%ld",[rs longForColumn:@"startDate"]);
            
            [resultArrary addObject:obj];
            
        }
        NSLog(@"ResultArrayTD==%@",resultArrary);
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    
    return resultArrary;
    
}

+ (GameObject *) getTrophyProgress{
    
    GameObject *obj=[[GameObject alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,startDate,endDate FROM game WHERE status=\"0\" AND gameType=\"TrainingTrophy\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            
            
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            
            
        }
        
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    return obj;
    
}

+ (GameObject *) getPlantProgress{
    
    GameObject *obj=[[GameObject alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,startDate,endDate FROM game WHERE status=\"0\" AND gameType=\"WalkPlanyt\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            
            
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            
            
        }
        
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    return obj;
    
}
+ (BOOL)deletePlantProgress{
    
    __block BOOL result=false;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *sql=[NSString stringWithFormat:@"DELETE  FROM game WHERE status=\"0\" AND gameType=\"WalkPlanyt\""];
        
        
        
        [db executeUpdate:sql];
        
        result=true;
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
            result=false;
        }
        
        [db close];
    }];
    
    return result;
}

+ (BOOL)addPlant:(GameObject *)game{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        NSString *sql;
        if ([game.status isEqualToString:@"0"]) {
            
            sql=[NSString stringWithFormat:@"DELETE  FROM game WHERE status=\"0\" AND gameType=\"%@\"",game.gameType];
            
            
            
            [db executeUpdate:sql];
            
            
            
        }
        
        
        sql=[NSString stringWithFormat:@"SELECT * FROM game WHERE status=\"1\" AND startDate=\"%lld\" AND gameType=\"%@\"",game.getStartDate,game.gameType];
        
        //[db executeUpdate:sql];
        
        FMResultSet *check=[db executeQuery:sql];
        NSLog(@"______________check=%@",check);
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE game SET gameType=\"%@\",plantType=\"%@\",plantName=\"%@\", progress=\"%@\",status=\"%@\",distance=\"%@\",steps=\"%@\",calories=\"%@\",fb_key=\"%@\",startDate=\"%lld\",endDate=\"%lld\" WHERE startDate=\"%lld\" AND  gameType=\%@\"",game.gameType, game.plantType,game.plantName,game.progress,game.status,game.distance,game.steps,game.calories,game.fb_key,[game getStartDate],[game getEndDate],[game getStartDate],game.gameType];
            
            NSLog(@",SQL==%@",sql);
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO)
            {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        
        else
        {
            NSLog(@"add....");
            
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO game(gameType,plantType,plantName, progress,status,distance,steps,calories,fb_key,startDate,endDate) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%lld,%lld)",game.gameType, game.plantType,game.plantName,game.progress,game.status,game.distance,game.steps,game.calories,game.fb_key,[game getStartDate],[game getEndDate]];
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            NSLog(@"result==%d",result);
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        
        [check close];
        [db commit];
        
        [db close];
        
    }];
    
    
    if (result) {
        NSLog(@"add plant ok......");
    }
    
    return result;
    
    
}

+ (BOOL)deletePlantList{
    
    __block BOOL result=false;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *sql=[NSString stringWithFormat:@"DELETE  FROM game WHERE status=\"0\" AND gameType=\"WalkPlanyt\""];
        
        
        
        [db executeUpdate:sql];
        
        result=true;
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
            result=false;
        }
        
        [db close];
    }];
    
    return result;
}

+ (BOOL)deleteTrophyList{
    
    __block BOOL result=false;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *sql=[NSString stringWithFormat:@"DELETE  FROM game WHERE status=\"1\" AND gameType=\"TrainingTrophy\""];
        
        
        
        [db executeUpdate:sql];
        
        result=true;
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
            result=false;
        }
        
        [db close];
    }];
    
    return result;
}
#pragma mark -- Frist time game RP
+ (GameObject *) getFristTimePlantProgress{
    
    GameObject *obj=[[GameObject alloc] init];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)  {
        [db open];
        NSString *sql=[NSString stringWithFormat:@"SELECT gameType,plantType,plantName,progress,status,startDate,endDate FROM frist_time_rp WHERE status=\"0\" AND gameType=\"WalkPlanyt\""];
        FMResultSet *rs = [db executeQuery: sql];
        while ([rs next]) {
            
            
            
            
            obj.gameType=[rs stringForColumn:@"gameType"];
            obj.plantType=[rs stringForColumn:@"plantType"];
            obj.plantName=[rs stringForColumn:@"plantName"];
            obj.progress=[rs stringForColumn:@"progress"];
            obj.status=[rs stringForColumn:@"status"];
            
            [obj setStartDate:[rs longForColumn:@"startDate"]];
            
            [obj setEndDate:[rs longForColumn:@"endDate"]];
            
            
        }
        
        [rs close];
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [db close];
    }];
    
    
    return obj;
    
}

+ (BOOL)addFristTimePlant:(GameObject *)game{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        NSString *sql;
        if ([game.status isEqualToString:@"0"]) {
            
            sql=[NSString stringWithFormat:@"DELETE  FROM frist_time_rp WHERE status=\"0\" AND gameType=\"%@\"",game.gameType];
            
            
            
            [db executeUpdate:sql];
            
            
            
        }
        
        
        sql=[NSString stringWithFormat:@"SELECT * FROM frist_time_rp WHERE status=\"1\" AND startDate=\"%lld\" AND gameType=\"%@\"",game.getStartDate,game.gameType];
        
        //[db executeUpdate:sql];
        
        FMResultSet *check=[db executeQuery:sql];
        NSLog(@"______________check=%@",check);
        [check next];
        
        if ([check resultDictionary])
        {
            NSLog(@"upDate....");
            
            NSString*sql=[[NSString alloc]initWithFormat:@"UPDATE frist_time_rp SET gameType=\"%@\",plantType=\"%@\",plantName=\"%@\", progress=\"%@\",status=\"%@\",startDate=\"%lld\",endDate=\"%lld\" WHERE startDate=\"%lld\" AND  gameType=\%@\"",game.gameType, game.plantType,game.plantName,game.progress,game.status,[game getStartDate],[game getEndDate],[game getStartDate],game.gameType];
            
            NSLog(@",SQL==%@",sql);
            result=[db executeUpdate:sql];
            //NSLog(@"result=%hhd",result);
            if ([db hadError]&&result==NO)
            {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        
        else
        {
            NSLog(@"add....");
            
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO frist_time_rp(gameType,plantType,plantName, progress,status,startDate,endDate) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%lld,%lld)",game.gameType, game.plantType,game.plantName,game.progress,game.status,[game getStartDate],[game getEndDate]];
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
             
        }
        
        [check close];
        [db commit];
        
        [db close];
        
    }];
    
    
    if (result) {
        NSLog(@"add plant ok......");
    }
    
    return result;
    
    
}
#pragma mark -- Frist time Walking
+ (BOOL)deleteFristTimePlantList{
    
    __block BOOL result=false;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        NSString *sql=[NSString stringWithFormat:@"DELETE  FROM frist_time_rp WHERE status=\"0\" AND gameType=\"WalkPlanyt\""];
        
        
        
        [db executeUpdate:sql];
        
        result=true;
        
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            
            result=false;
        }
        
        [db close];
    }];
    
    return result;
}
+ (BOOL) addFristTimeWalkingRecord:(WalkingRecord *) walking{
    
    __block BOOL result=YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        
        [db beginTransaction];
        
        
        
        NSString *checkSql;
        
        
        if (walking.recordid!=nil&&![walking.recordid isEqualToString:@""]) {
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM frist_time_walking WHERE recordid = \"%@\"",walking.recordid];
            
            
        }else{
            
            checkSql=[NSString stringWithFormat:@"SELECT * FROM frist_time_walking WHERE recordtime = %ld",[walking getRecordtime]];
        }
        
        
        //        NSString *sql2=[NSString stringWithFormat:@"DELETE FROM walking WHERE type=%ld AND recordtime = %ld AND persistimeL=%ld AND steps=\"%@\"",(long)[walking getType],[walking getRecordtime],[walking getPersistime],walking.steps];
        //
        //        NSLog(@"del......%@",sql2);
        //
        //        [db executeUpdate:sql2];
        
        
        FMResultSet *check = [db executeQuery: checkSql];
        
        WalkingRecord *cwResult = nil;
        
        if ([check next]) {
            
            cwResult = [[WalkingRecord alloc]init];
            [cwResult setType:[check intForColumn:@"type"]];
            cwResult.foodlistid=[check stringForColumn:@"foodlistid"];
            cwResult.trainid=[check stringForColumn:@"trainid"];
            cwResult.result=[check stringForColumn:@"result"];
            cwResult.gps=[check stringForColumn:@"gps"];
            cwResult.route=[check stringForColumn:@"route"];
            cwResult.steps=[check stringForColumn:@"steps"];
            cwResult.distance=[check stringForColumn:@"distance"];
            cwResult.calsburnt=[check stringForColumn:@"caloburnt"];
            cwResult.target=[check stringForColumn:@"target"];
            cwResult.pace=[check stringForColumn:@"pace"];
            cwResult.persistimeStr=[check stringForColumn:@"persistime"];
            cwResult.recordid=[check stringForColumn:@"recordid"];
            [cwResult setPersistime:[check longForColumn:@"persistimeL"]];
            [cwResult setRecordtime:[check longForColumn:@"recordtime"]];
            
        };
        
        
        if ([check resultDictionary])
        {
            NSLog(@"update...");
            NSString *sql = nil;
            
            
            if (walking.recordid!=nil&&![walking.recordid isEqualToString:@""]) {
                
                
                NSString *gpsVlaue=(walking.gps==nil||[walking.gps isEqualToString:@""])?@"":walking.gps;
                
                if (cwResult) {
                    
                    if (cwResult.gps) {
                        
                        if (![cwResult.gps isEqualToString:@""]) {
                            
                            gpsVlaue=cwResult.gps;
                        }
                    }
                }
                
                NSString *routeVlaue=(walking.route==nil||[walking.route isEqualToString:@""])?@"":walking.route;
                
                if (cwResult) {
                    
                    if (cwResult.route) {
                        
                        if (![cwResult.route isEqualToString:@""]) {
                            
                            routeVlaue=cwResult.route;
                        }
                    }
                }
                
                NSString *paceVlaue=(walking.pace==nil||[walking.pace isEqualToString:@""])?@"0":walking.pace;
                
                if (cwResult) {
                    
                    if (cwResult.pace) {
                        
                        if (![cwResult.pace isEqualToString:@""]) {
                            
                            paceVlaue=cwResult.pace;
                        }
                    }
                }
                
                
                
                
                sql=[NSString stringWithFormat:@"UPDATE frist_time_walking SET type=%ld,foodlistid=\"%@\", trainid=\"%@\",result=\"%@\",gps=\"%@\",route=\"%@\",steps=\"%@\",distance=\"%@\",caloburnt=\"%@\",target=\"%@\",pace=\"%@\",persistime=\"%@\", persistimeL=%ld, recordtime=%ld WHERE recordid=\"%@\"",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,gpsVlaue,routeVlaue,walking.steps==nil?@"0":walking.steps,walking.distance==nil?@"0":walking.distance,walking.calsburnt==nil?@"0":walking.calsburnt,walking.target==nil?@"0":walking.target,paceVlaue,walking.persistimeStr==nil?@"":walking.persistimeStr,[walking getPersistime],[walking getRecordtime],walking.recordid];
                
                
                
                
            }else{
                
                
                NSString *gpsVlaue=(walking.gps==nil||[walking.gps isEqualToString:@""])?@"":walking.gps;
                
                if (cwResult) {
                    
                    if (cwResult.gps) {
                        
                        if (![cwResult.gps isEqualToString:@""]) {
                            
                            gpsVlaue=cwResult.gps;
                        }
                    }
                }
                
                NSString *routeVlaue=(walking.route==nil||[walking.route isEqualToString:@""])?@"":walking.route;
                
                if (cwResult) {
                    
                    if (cwResult.route) {
                        
                        if (![cwResult.route isEqualToString:@""]) {
                            
                            routeVlaue=cwResult.route;
                        }
                    }
                }
                
                NSString *paceVlaue=(walking.pace==nil||[walking.pace isEqualToString:@""])?@"0":walking.pace;
                
                if (cwResult) {
                    
                    if (cwResult.pace) {
                        
                        if (![cwResult.pace isEqualToString:@""]) {
                            
                            paceVlaue=cwResult.pace;
                        }
                    }
                }
                
                
                
                sql=[NSString stringWithFormat:@"UPDATE frist_time_walking SET type=%ld,foodlistid=\"%@\", trainid=\"%@\",result=\"%@\",gps=\"%@\",route=\"%@\",steps=\"%@\",distance=\"%@\",caloburnt=\"%@\",target=\"%@\",pace=\"%@\",persistime=\"%@\", persistimeL=%ld,recordid=\"%@\" WHERE recordtime=%ld",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,gpsVlaue,routeVlaue,walking.steps==nil?@"0":walking.steps,walking.distance==nil?@"0":walking.distance,walking.calsburnt==nil?@"0":walking.calsburnt,walking.target==nil?@"0":walking.target,paceVlaue,walking.persistimeStr==nil?@"":walking.persistimeStr,[walking getPersistime],walking.recordid==nil?@"":walking.recordid,[walking getRecordtime]];
            }
            
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            
            
            if ([db hadError]&&result==NO) {
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
        }
        else{
            
            NSLog(@"add...");
            
            NSString *sql=[NSString stringWithFormat:@"INSERT INTO frist_time_walking(type,foodlistid, trainid,result,gps,route,steps,distance,caloburnt,target,pace,persistime, persistimeL,recordid,recordtime) VALUES (%ld,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%ld,\"%@\",%ld)",(long)[walking getType],walking.foodlistid==nil?@"":walking.foodlistid,walking.trainid==nil?@"-1":walking.trainid,walking.result==nil?@"0":walking.result,walking.gps==nil?@"":walking.gps,walking.route==nil?@"":walking.route,walking.steps==nil?@"0":walking.steps,walking.distance==nil?@"0":walking.distance,walking.calsburnt==nil?@"0":walking.calsburnt,walking.target==nil?@"0":walking.target,walking.pace==nil?@"0":walking.pace,walking.persistimeStr==nil?@"":walking.persistimeStr,[walking getPersistime],walking.recordid==nil?@"":walking.recordid,[walking getRecordtime]];
            
            NSLog(@"%@......sql",sql);
            
            result=[db executeUpdate:sql];
            
            if ([db hadError]&&result==NO) {
                
                NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                
                result=NO;
            }
            
            
            
            
            
        }
        
        
        [check close];
        
        [db commit];
        
        [db close];
    }];
    
    
    return result;
    
}

+ (NSMutableArray *)getFristTimeCWRecord{
    __block NSMutableArray *cwResultArray = [[NSMutableArray alloc]init];
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        [db open];
        
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM frist_time_walking WHERE type=0 ORDER BY recordtime DESC"];
        FMResultSet *rs = [db executeQuery:selectSql];
        
        while([rs next]){
            
            WalkingRecord *cwResult = [[WalkingRecord alloc]init];
            
            [cwResult setType:[rs intForColumn:@"type"]];
            cwResult.foodlistid=[rs stringForColumn:@"foodlistid"];
            cwResult.trainid=[rs stringForColumn:@"trainid"];
            cwResult.result=[rs stringForColumn:@"result"];
            cwResult.gps=[rs stringForColumn:@"gps"];
            cwResult.route=[rs stringForColumn:@"route"];
            cwResult.steps=[rs stringForColumn:@"steps"];
            cwResult.distance=[rs stringForColumn:@"distance"];
            cwResult.calsburnt=[rs stringForColumn:@"caloburnt"];
            cwResult.target=[rs stringForColumn:@"target"];
            cwResult.pace=[rs stringForColumn:@"pace"];
            cwResult.persistimeStr=[rs stringForColumn:@"persistime"];
            cwResult.recordid=[rs stringForColumn:@"recordid"];
            [cwResult setPersistime:[rs longForColumn:@"persistimeL"]];
            [cwResult setRecordtime:[rs longForColumn:@"recordtime"]];
            
            
            
            cwResult.steps=[DBHelper decryptionString:cwResult.steps];
            cwResult.distance=[DBHelper decryptionString:cwResult.distance];
            cwResult.calsburnt=[DBHelper decryptionString:cwResult.calsburnt];
            cwResult.persistimeStr=[DBHelper decryptionString:cwResult.persistimeStr];
            
            
            NSLog(@"test steps in db:%@",cwResult.steps);
            NSLog(@"test route in db:%@",cwResult.route);
            
            
            
            [cwResultArray addObject:cwResult];
            
        }
    }];
    return cwResultArray;
}


#pragma mark  -- todayMeasurement

-(NSMutableArray*)todayMeasurement
{
    
    NSDateFormatter* dateFormat00000 = [[NSDateFormatter alloc] init];
    [dateFormat00000 setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr678 = [dateFormat00000 stringFromDate:[NSDate date]];
    dateDate=currentDateStr678;
    
    NSMutableArray* _timeArray=[[NSMutableArray alloc]initWithObjects:@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00", nil];
    
    
    DiaryViewController *diary=[[DiaryViewController alloc]init];
    [diary getHistoryRecord];
    
    
    
    NSString *timeBloodLength=[[NSString alloc]initWithFormat:@"%@",diary.timeBloodMutableArray];
    if ([timeBloodLength length]>3) {
        timeBloodArray=[NSMutableArray new];
        for (int i=0; i<diary.timeBloodMutableArray.count; i++) {
            NSString * temp=[NSString new];
            temp=[diary.timeBloodMutableArray objectAtIndex:i];
            if ([temp length]>3) {
                NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                [timeBloodArray addObject:timeStr];
            }
            
        }
        
    }
    
    timeECGArray=[NSMutableArray new];
    for (int i=0; i<diary.timeECGMutableArray.count; i++) {
        NSString * temp=[NSString new];
        temp=[diary.timeECGMutableArray objectAtIndex:i];
        NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
        NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
        ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
        [timeECGArray addObject:timeStr];
    }
    timeGloodArray=[NSMutableArray new];
    for (int i=0; i<diary.timeGlucoseMutableArray.count; i++) {
        NSString * temp=[NSString new];
        temp=[diary.timeGlucoseMutableArray objectAtIndex:i];
        NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
        NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
        ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
        [timeGloodArray addObject:timeStr];
    }
    timeStartTime=[NSMutableArray new];
    
    for (int i=0; i<diary.startTimesArray.count; i++) {
        NSString * temp=[NSString new];
        temp=[diary.startTimesArray objectAtIndex:i];
        if ([temp length]>4) {
            NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
            NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
            ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
            [timeStartTime addObject:timeStr];
        }
        
    }
    timeWalkingArray=[NSMutableArray new];
    for (int i=0; i<diary.timeWalkMustableArray.count; i++) {
        NSString * temp=[NSString new];
        temp=[diary.timeWalkMustableArray objectAtIndex:i];
        NSString * timeStrRain=[temp substringWithRange:NSMakeRange(0, 3)];
        NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
        ////NSLog(@"--------------------------------%@-----------------------------------",timeStr);
        [timeWalkingArray addObject:timeStr];
    }
    
    
    timeMationArray=[NSMutableArray new];
    for (int i = 0 ; i<[diary.timesMedicationArray count]; i++) {
        NSString *timeMEdicationText=[diary.timesMedicationArray objectAtIndex:i];
        float ff=[timeMEdicationText lengthOfBytesUsingEncoding:NSASCIIStringEncoding];
        //NSLog(@">>>>>%f<<<<<",ff);
        NSMutableArray *timeTextArray=[NSMutableArray new];
        if (ff>1&&ff<7) {
            NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(0, 5)];
            NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
            NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
            //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
            
            [timeTextArray addObject:timeStr];
        }
        else if (ff>=7&&ff<=13)
        {
            for (int temmm=0; temmm<2; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
        }
        else if (ff>=13&&ff<=19)
        {
            for (int temmm=0; temmm<3; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
            
        }
        else if (ff>=19&&ff<=25)
        {
            for (int temmm=0; temmm<4; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
            
        }
        else if (ff>=25&&ff<=31)
        {
            for (int temmm=0; temmm<5; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
            
        }
        else if (ff>=31)
        {
            for (int temmm=0; temmm<2; temmm++) {
                NSString *str =[timeMEdicationText substringWithRange:NSMakeRange(temmm*6, 5)];
                NSString * timeStrRain=[str substringWithRange:NSMakeRange(0, 3)];
                NSString * timeStr=[[NSString alloc]initWithFormat:@"%@00",timeStrRain];
                //NSLog(@"--------------------------------%@-----------------------------------",timeStr);
                
                [timeTextArray addObject:timeStr];
            }
            
        }
        else
        {
            //NSLog(@"Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error Error");
        }
        [timeMationArray addObject:timeTextArray];
        
    }
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    NSString *timeStrRaindateDate1=[currentDateStr substringWithRange:NSMakeRange(0, 4)];
    NSString *timeStrRaindateDate2=[currentDateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *timeStrRaindateDate3=[currentDateStr substringWithRange:NSMakeRange(8, 2)];
    NSString *timeStrRaindateDateSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRaindateDate1,timeStrRaindateDate2,timeStrRaindateDate3];
    
    
    NSLog(@"%@",timeStrRaindateDateSum);
    
    NSString *timeStrRainStratDateSum;
    NSString *timeStrRainENDDateSum;
    
    if([diary.walkStartDate length]>6)
    {
        NSString *timeStrRainStratDate1=[diary.walkStartDate substringWithRange:NSMakeRange(0, 4)];
        NSString *timeStrRainStratDate2=[diary.walkStartDate substringWithRange:NSMakeRange(5, 2)];
        NSString *timeStrRainStratDate3=[diary.walkStartDate substringWithRange:NSMakeRange(8, 2)];
        timeStrRainStratDateSum =[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainStratDate1,timeStrRainStratDate2,timeStrRainStratDate3];
    }
    else
    {
        timeStrRainStratDateSum=@"0";
    }
    if([diary.walkEndDate length]>6)
    {
        NSString *timeStrRainENDDate1=[diary.walkEndDate substringWithRange:NSMakeRange(0, 4)];
        NSString *timeStrRainENDDate2=[diary.walkEndDate substringWithRange:NSMakeRange(5, 2)];
        NSString *timeStrRainENDDate3=[diary.walkEndDate substringWithRange:NSMakeRange(8, 2)];
        timeStrRainENDDateSum=[[NSString alloc]initWithFormat:@"%@%@%@",timeStrRainENDDate1,timeStrRainENDDate2,timeStrRainENDDate3];
    }
    else
    {
        timeStrRainENDDateSum=@"0";
    }
    NSDateFormatter* dateFormat000 = [[NSDateFormatter alloc] init];
    [dateFormat000 setDateFormat:@"yyyy-MM-dd"];
    // NSString *currentDateStr = [dateFormat000 stringFromDate:[NSDate date]];
    //NSLog(@"%@",currentDateStr);
    
    NSDateFormatter* dateFormat111 = [[NSDateFormatter alloc] init];
    [dateFormat111 setDateFormat:@"yyyyMMdd"];
    NSString *currentDateStr111 = [dateFormat111 stringFromDate:[NSDate date]];
    NSLog(@"%@",currentDateStr111);
    
    
    NSMutableArray *timeArray0=[[NSMutableArray alloc]initWithObjects:@"00:00", nil];
    NSMutableArray *timeArray1=[[NSMutableArray alloc]initWithObjects:@"01:00", nil];
    NSMutableArray *timeArray2=[[NSMutableArray alloc]initWithObjects:@"02:00", nil];
    NSMutableArray *timeArray3=[[NSMutableArray alloc]initWithObjects:@"03:00", nil];
    NSMutableArray *timeArray4=[[NSMutableArray alloc]initWithObjects:@"04:00", nil];
    NSMutableArray *timeArray5=[[NSMutableArray alloc]initWithObjects:@"05:00", nil];
    NSMutableArray *timeArray6=[[NSMutableArray alloc]initWithObjects:@"06:00", nil];
    NSMutableArray *timeArray7=[[NSMutableArray alloc]initWithObjects:@"07:00", nil];
    
    NSMutableArray *timeArray8=[[NSMutableArray alloc]initWithObjects:@"08:00", nil];
    NSMutableArray *timeArray9=[[NSMutableArray alloc]initWithObjects:@"09:00", nil];
    NSMutableArray *timeArray10=[[NSMutableArray alloc]initWithObjects:@"10:00", nil];
    NSMutableArray *timeArray11=[[NSMutableArray alloc]initWithObjects:@"11:00", nil];
    NSMutableArray *timeArray12=[[NSMutableArray alloc]initWithObjects:@"12:00", nil];
    NSMutableArray *timeArray13=[[NSMutableArray alloc]initWithObjects:@"13:00", nil];
    NSMutableArray *timeArray14=[[NSMutableArray alloc]initWithObjects:@"14:00", nil];
    NSMutableArray *timeArray15=[[NSMutableArray alloc]initWithObjects:@"15:00", nil];
    
    NSMutableArray *timeArray16=[[NSMutableArray alloc]initWithObjects:@"16:00", nil];
    NSMutableArray *timeArray17=[[NSMutableArray alloc]initWithObjects:@"17:00", nil];
    NSMutableArray *timeArray18=[[NSMutableArray alloc]initWithObjects:@"18:00", nil];
    NSMutableArray *timeArray19=[[NSMutableArray alloc]initWithObjects:@"19:00", nil];
    NSMutableArray *timeArray20=[[NSMutableArray alloc]initWithObjects:@"20:00", nil];
    NSMutableArray *timeArray21=[[NSMutableArray alloc]initWithObjects:@"21:00", nil];
    NSMutableArray *timeArray22=[[NSMutableArray alloc]initWithObjects:@"22:00", nil];
    NSMutableArray *timeArray23=[[NSMutableArray alloc]initWithObjects:@"23:00", nil];
    
    for (int joker=0; joker<_timeArray.count; joker++)
    {
        
        
        
        for (int i=0; i<[timeBloodArray count]; i++)
        {
            if ([[timeBloodArray objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
            {
                
                
                //    _button .backgroundColor=[UIColor colorWithRed:250/255.0 green:150/255.0 blue:150/255.0 alpha:1];
                
                
                NSString * str=[[NSString alloc]initWithFormat:@"Daily Measurement , Blood Pressure, time=%@",[diary.timeBloodMutableArray objectAtIndex:i ]];
                
                NSLog(@"%@",str);
                switch (joker) {
                    case 0:
                        [timeArray0 addObject:str];
                        break;
                    case 1:
                        [timeArray1 addObject:str];
                        break;
                    case 2:
                        [timeArray2 addObject:str];
                        break;
                    case 3:
                        [timeArray3 addObject:str];
                        break;
                    case 4:
                        [timeArray4 addObject:str];
                        break;
                    case 5:
                        [timeArray5 addObject:str];
                        break;
                    case 6:
                        [timeArray6 addObject:str];
                        break;
                    case 7:
                        [timeArray7 addObject:str];
                        break;
                    case 8:
                        [timeArray8 addObject:str];
                        break;
                    case 9:
                        [timeArray9 addObject:str];
                        break;
                    case 10:
                        [timeArray10 addObject:str];
                        break;
                    case 11:
                        [timeArray11 addObject:str];
                        break;
                    case 12:
                        [timeArray12 addObject:str];
                        break;
                    case 13:
                        [timeArray13 addObject:str];
                        break;
                    case 14:
                        [timeArray14 addObject:str];
                        break;
                    case 15:
                        [timeArray15 addObject:str];
                        break;
                    case 16:
                        [timeArray16 addObject:str];
                        break;
                    case 17:
                        [timeArray17 addObject:str];
                        break;
                    case 18:
                        [timeArray18 addObject:str];
                        break;
                    case 19:
                        [timeArray19 addObject:str];
                        break;
                    case 20:
                        [timeArray20 addObject:str];
                        break;
                    case 21:
                        [timeArray21 addObject:str];
                        break;
                    case 22:
                        [timeArray22 addObject:str];
                        break;
                    case 23:
                        [timeArray23 addObject:str];
                        break;
                    default:
                        break;
                }
                
                
            }
            
        }
        
        for (int i=0; i<[timeECGArray count]; i++)
        {
            
            if ([[timeECGArray objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
            {
                
                
                NSString * str=[[NSString alloc]initWithFormat:@"Daily Measurement , ECG, time=%@",[diary.timeECGMutableArray objectAtIndex:i ]];
                NSLog(@"%@",str);
                switch (joker) {
                    case 0:
                        [timeArray0 addObject:str];
                        break;
                    case 1:
                        [timeArray1 addObject:str];
                        break;
                    case 2:
                        [timeArray2 addObject:str];
                        break;
                    case 3:
                        [timeArray3 addObject:str];
                        break;
                    case 4:
                        [timeArray4 addObject:str];
                        break;
                    case 5:
                        [timeArray5 addObject:str];
                        break;
                    case 6:
                        [timeArray6 addObject:str];
                        break;
                    case 7:
                        [timeArray7 addObject:str];
                        break;
                    case 8:
                        [timeArray8 addObject:str];
                        break;
                    case 9:
                        [timeArray9 addObject:str];
                        break;
                    case 10:
                        [timeArray10 addObject:str];
                        break;
                    case 11:
                        [timeArray11 addObject:str];
                        break;
                    case 12:
                        [timeArray12 addObject:str];
                        break;
                    case 13:
                        [timeArray13 addObject:str];
                        break;
                    case 14:
                        [timeArray14 addObject:str];
                        break;
                    case 15:
                        [timeArray15 addObject:str];
                        break;
                    case 16:
                        [timeArray16 addObject:str];
                        break;
                    case 17:
                        [timeArray17 addObject:str];
                        break;
                    case 18:
                        [timeArray18 addObject:str];
                        break;
                    case 19:
                        [timeArray19 addObject:str];
                        break;
                    case 20:
                        [timeArray20 addObject:str];
                        break;
                    case 21:
                        [timeArray21 addObject:str];
                        break;
                    case 22:
                        [timeArray22 addObject:str];
                        break;
                    case 23:
                        [timeArray23 addObject:str];
                        break;
                    default:
                        break;
                }
            }
            else
            {
                ////NSLog(@"////NSLog==%d",buttonHeiger00);
            }
        }
        for (int i =0; i< [timeGloodArray count]; i++)
            
        {
            if ([[timeGloodArray objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
            {
                
                NSString * str=[[NSString alloc]initWithFormat:@"Daily Measurement , Blood Glucose, time=%@",[diary.timeGlucoseMutableArray objectAtIndex:i ]];
                NSLog(@"%@",str);
                switch (joker) {
                    case 0:
                        [timeArray0 addObject:str];
                        break;
                    case 1:
                        [timeArray1 addObject:str];
                        break;
                    case 2:
                        [timeArray2 addObject:str];
                        break;
                    case 3:
                        [timeArray3 addObject:str];
                        break;
                    case 4:
                        [timeArray4 addObject:str];
                        break;
                    case 5:
                        [timeArray5 addObject:str];
                        break;
                    case 6:
                        [timeArray6 addObject:str];
                        break;
                    case 7:
                        [timeArray7 addObject:str];
                        break;
                    case 8:
                        [timeArray8 addObject:str];
                        break;
                    case 9:
                        [timeArray9 addObject:str];
                        break;
                    case 10:
                        [timeArray10 addObject:str];
                        break;
                    case 11:
                        [timeArray11 addObject:str];
                        break;
                    case 12:
                        [timeArray12 addObject:str];
                        break;
                    case 13:
                        [timeArray13 addObject:str];
                        break;
                    case 14:
                        [timeArray14 addObject:str];
                        break;
                    case 15:
                        [timeArray15 addObject:str];
                        break;
                    case 16:
                        [timeArray16 addObject:str];
                        break;
                    case 17:
                        [timeArray17 addObject:str];
                        break;
                    case 18:
                        [timeArray18 addObject:str];
                        break;
                    case 19:
                        [timeArray19 addObject:str];
                        break;
                    case 20:
                        [timeArray20 addObject:str];
                        break;
                    case 21:
                        [timeArray21 addObject:str];
                        break;
                    case 22:
                        [timeArray22 addObject:str];
                        break;
                    case 23:
                        [timeArray23 addObject:str];
                        break;
                    default:
                        break;
                }
            }
            else
            {
                ////NSLog(@"////NSLog==%d",buttonHeiger00);
            }
        }
        for (int i=0; i<[timeMationArray count]; i++)
        {
            NSMutableArray *obTimeMation=[timeMationArray objectAtIndex:i];
            
            for (int j=0; j<[obTimeMation count]; j++)
            {
                if ([[obTimeMation objectAtIndex:j]isEqualToString:[_timeArray objectAtIndex:joker]])
                {
                    
                    NSString *meal=[diary.mealMedicationArray objectAtIndex:i];
                    NSString *mealStr;
                    if ([meal isEqualToString:@"A"])
                    {
                        mealStr=@"After meal";
                    }
                    else if ([meal isEqualToString:@"B"])
                    {
                        mealStr=@"Before meal";
                    }
                    else
                    {
                        mealStr=@"N/A";
                    }
                    
                    
                    NSString *str=[[NSString alloc]initWithFormat:@"Daily Medication, medicine=%@ , dosage=%@, meal=%@, time=%@, note=%@, image=%@",[diary.titleMedicationArray objectAtIndex:i],[diary.dosageMedicationArray objectAtIndex:i],mealStr,[diary.timesMedicationArray objectAtIndex:i],[diary.noteMedicationArray objectAtIndex:i],[diary.imageMedicationArray objectAtIndex:i]];
                    
                    NSLog(@"%@",str);
                    switch (joker) {
                        case 0:
                            [timeArray0 addObject:str];
                            break;
                        case 1:
                            [timeArray1 addObject:str];
                            break;
                        case 2:
                            [timeArray2 addObject:str];
                            break;
                        case 3:
                            [timeArray3 addObject:str];
                            break;
                        case 4:
                            [timeArray4 addObject:str];
                            break;
                        case 5:
                            [timeArray5 addObject:str];
                            break;
                        case 6:
                            [timeArray6 addObject:str];
                            break;
                        case 7:
                            [timeArray7 addObject:str];
                            break;
                        case 8:
                            [timeArray8 addObject:str];
                            break;
                        case 9:
                            [timeArray9 addObject:str];
                            break;
                        case 10:
                            [timeArray10 addObject:str];
                            break;
                        case 11:
                            [timeArray11 addObject:str];
                            break;
                        case 12:
                            [timeArray12 addObject:str];
                            break;
                        case 13:
                            [timeArray13 addObject:str];
                            break;
                        case 14:
                            [timeArray14 addObject:str];
                            break;
                        case 15:
                            [timeArray15 addObject:str];
                            break;
                        case 16:
                            [timeArray16 addObject:str];
                            break;
                        case 17:
                            [timeArray17 addObject:str];
                            break;
                        case 18:
                            [timeArray18 addObject:str];
                            break;
                        case 19:
                            [timeArray19 addObject:str];
                            break;
                        case 20:
                            [timeArray20 addObject:str];
                            break;
                        case 21:
                            [timeArray21 addObject:str];
                            break;
                        case 22:
                            [timeArray22 addObject:str];
                            break;
                        case 23:
                            [timeArray23 addObject:str];
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    ////NSLog(@"////NSLog==%d",buttonHeiger00);
                }
            }
        }
        
        for (int i =0; i< [diary.adDateDate count]; i++)
            
        {
            
            if ( [dateDate isEqualToString:[diary.adDateDate objectAtIndex:i ]])
                
            {
                
                
                if ([[timeStartTime objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
                {
                    
                    NSString *str=[[NSString alloc]initWithFormat:@"Others, title=%@, note=%@, date=%@, start time=%@ ,end time=%@",[diary.titleAdhocArray objectAtIndex:i],[diary.adHoNote objectAtIndex:i],[diary.adDateDate objectAtIndex:i],[diary.startTimesArray objectAtIndex:i],[diary.endTimesArray objectAtIndex:i]];
                    
                    NSLog(@"%@",str);
                    switch (joker) {
                        case 0:
                            [timeArray0 addObject:str];
                            break;
                        case 1:
                            [timeArray1 addObject:str];
                            break;
                        case 2:
                            [timeArray2 addObject:str];
                            break;
                        case 3:
                            [timeArray3 addObject:str];
                            break;
                        case 4:
                            [timeArray4 addObject:str];
                            break;
                        case 5:
                            [timeArray5 addObject:str];
                            break;
                        case 6:
                            [timeArray6 addObject:str];
                            break;
                        case 7:
                            [timeArray7 addObject:str];
                            break;
                        case 8:
                            [timeArray8 addObject:str];
                            break;
                        case 9:
                            [timeArray9 addObject:str];
                            break;
                        case 10:
                            [timeArray10 addObject:str];
                            break;
                        case 11:
                            [timeArray11 addObject:str];
                            break;
                        case 12:
                            [timeArray12 addObject:str];
                            break;
                        case 13:
                            [timeArray13 addObject:str];
                            break;
                        case 14:
                            [timeArray14 addObject:str];
                            break;
                        case 15:
                            [timeArray15 addObject:str];
                            break;
                        case 16:
                            [timeArray16 addObject:str];
                            break;
                        case 17:
                            [timeArray17 addObject:str];
                            break;
                        case 18:
                            [timeArray18 addObject:str];
                            break;
                        case 19:
                            [timeArray19 addObject:str];
                            break;
                        case 20:
                            [timeArray20 addObject:str];
                            break;
                        case 21:
                            [timeArray21 addObject:str];
                            break;
                        case 22:
                            [timeArray22 addObject:str];
                            break;
                        case 23:
                            [timeArray23 addObject:str];
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    ////NSLog(@"////NSLog==%d",buttonHeiger00);
                }
            }
        }
        
        
        
        
        if (([timeStrRaindateDateSum intValue]>=[timeStrRainStratDateSum intValue])&&([timeStrRaindateDateSum intValue]<=[timeStrRainENDDateSum intValue])) {
            
            for (int i=0; i<[timeWalkingArray count]; i++)
            {
                
                if ([[timeWalkingArray objectAtIndex:i]isEqualToString:[_timeArray objectAtIndex:joker]])
                {
                    
                    
                    
                    NSString *str=[[NSString alloc]initWithFormat:@"Exercise, %@",[diary.timeWalkMustableArray objectAtIndex:i]];
                    
                    NSLog(@"%@",str);
                    switch (joker) {
                        case 0:
                            [timeArray0 addObject:str];
                            break;
                        case 1:
                            [timeArray1 addObject:str];
                            break;
                        case 2:
                            [timeArray2 addObject:str];
                            break;
                        case 3:
                            [timeArray3 addObject:str];
                            break;
                        case 4:
                            [timeArray4 addObject:str];
                            break;
                        case 5:
                            [timeArray5 addObject:str];
                            break;
                        case 6:
                            [timeArray6 addObject:str];
                            break;
                        case 7:
                            [timeArray7 addObject:str];
                            break;
                        case 8:
                            [timeArray8 addObject:str];
                            break;
                        case 9:
                            [timeArray9 addObject:str];
                            break;
                        case 10:
                            [timeArray10 addObject:str];
                            break;
                        case 11:
                            [timeArray11 addObject:str];
                            break;
                        case 12:
                            [timeArray12 addObject:str];
                            break;
                        case 13:
                            [timeArray13 addObject:str];
                            break;
                        case 14:
                            [timeArray14 addObject:str];
                            break;
                        case 15:
                            [timeArray15 addObject:str];
                            break;
                        case 16:
                            [timeArray16 addObject:str];
                            break;
                        case 17:
                            [timeArray17 addObject:str];
                            break;
                        case 18:
                            [timeArray18 addObject:str];
                            break;
                        case 19:
                            [timeArray19 addObject:str];
                            break;
                        case 20:
                            [timeArray20 addObject:str];
                            break;
                        case 21:
                            [timeArray21 addObject:str];
                            break;
                        case 22:
                            [timeArray22 addObject:str];
                            break;
                        case 23:
                            [timeArray23 addObject:str];
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    ////NSLog(@"////NSLog==%d",buttonHeiger00);
                }
            }
        }
        
        
        
        
        
        
    }
    
    
    
    NSMutableArray * array =[[NSMutableArray alloc]init];
    if ([timeArray0 count]>1)
    {
        [array addObject:timeArray0];
    }
    if ([timeArray1 count]>1)
    {
        [array addObject:timeArray1];
    }
    if ([timeArray2 count]>1)
    {
        [array addObject:timeArray2];
    }
    if ([timeArray3 count]>1)
    {
        [array addObject:timeArray3];
    }
    if ([timeArray4 count]>1)
    {
        [array addObject:timeArray4];
    }
    if ([timeArray5 count]>1)
    {
        [array addObject:timeArray5];
    }
    if ([timeArray6 count]>1)
    {
        [array addObject:timeArray6];
    }
    if ([timeArray7 count]>1)
    {
        [array addObject:timeArray7];
    }
    if ([timeArray8 count]>1)
    {
        [array addObject:timeArray8];
    }
    if ([timeArray9 count]>1)
    {
        [array addObject:timeArray9];
    }
    if ([timeArray10 count]>1)
    {
        [array addObject:timeArray10];
    }
    
    
    
    
    if ([timeArray11 count]>1)
    {
        [array addObject:timeArray11];
    }
    if ([timeArray12 count]>1)
    {
        [array addObject:timeArray12];
    }
    if ([timeArray13 count]>1)
    {
        [array addObject:timeArray13];
    }
    if ([timeArray14 count]>1)
    {
        [array addObject:timeArray14];
    }
    if ([timeArray15 count]>1)
    {
        [array addObject:timeArray15];
    }
    if ([timeArray16 count]>1)
    {
        [array addObject:timeArray16];
    }
    if ([timeArray17 count]>1)
    {
        [array addObject:timeArray17];
    }
    if ([timeArray18 count]>1)
    {
        [array addObject:timeArray18];
    }
    if ([timeArray19 count]>1)
    {
        [array addObject:timeArray19];
    }
    if ([timeArray20 count]>1)
    {
        [array addObject:timeArray20];
    }
    
    if ([timeArray21 count]>1)
    {
        [array addObject:timeArray21];
    }
    if ([timeArray22 count]>1)
    {
        [array addObject:timeArray22];
    }
    if ([timeArray23 count]>1)
    {
        [array addObject:timeArray23];
    }
    
    
    
    return array;
}
@end
