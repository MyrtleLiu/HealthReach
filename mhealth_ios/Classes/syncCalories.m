//
//  syncCalories.m
//  mHealth
//
//  Created by smartone_sn3 on 8/19/14.
//
//

#import "syncCalories.h"
#import "FoodEntry.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "GlobalVariables.h"
#import "syncUtility.h"
#import "Constants.h"
#import "Utility.h"
#import "NSString+URLEncoding.h"
#import "NSNotificationCenter+MainThread.h"
#import"GDataXMLNode.h"
@implementation syncCalories

#pragma mark -
#pragma mark Sync

+(void)syncAllCaloriesData{
    
    //get newest record date in DATABASE
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *newestFoodDate_DB = [DBHelper getNewestFoodDate_DB];
//    long temp = [newestFoodDate_DB longLongValue];
//    newestFoodDate_DB = [[NSString formatTimeAgo:temp]substringToIndex:10];
//    NSDate *foodDate_DB = [dateFormatter dateFromString:newestFoodDate_DB];
//    
//    if (newestFoodDate_DB.length>=10)
//        newestFoodDate_DB = [newestFoodDate_DB substringToIndex:10];
//    else {
//        if ([newestFoodDate_DB isEqualToString:@""]){
//            newestFoodDate_DB = @"1900-01-01";
//        } else {
//            NSLog(@"trimming newestFoodDate_DB error! newestFoodDate_DB:%@",newestFoodDate_DB);
//            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncCaloriesError" object:nil];
//            return;
//        }
//    }
//    
//    //get newest record date in SERVER
//    NSString *newestFoodDate_Server = [self getNewestFoodDate_Server];
//    if (newestFoodDate_Server.length>=10)
//        newestFoodDate_Server = [newestFoodDate_Server substringToIndex:10];
//    else {
//        if ([newestFoodDate_Server isEqualToString:@""]){
//            newestFoodDate_Server = @"1900-01-01";
//        } else {
//            NSLog(@"trimming newestFoodDate_Server error! newestFoodDate_Server:%@",newestFoodDate_Server);
//            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncCaloriesError" object:nil];            
//            return;
//        }
//    }
//    NSDate *foodDate_Server = [dateFormatter dateFromString:newestFoodDate_Server];
//    
//    //compare two dates and download the missing records
//    NSInteger dayBetween = ([foodDate_Server timeIntervalSince1970]*1 - [foodDate_DB timeIntervalSince1970]*1)/86400;
//    if (dayBetween>0){
//        NSLog(@"Downloading food records from server,%ld days not sync.",(long)dayBetween);
//        [self syncFoodData:dayBetween];
        [self syncFoodData:90];
//
//    } else {
//        NSLog(@"food records are up to date");
//    }
    
    [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncCaloriesFinish" object:nil];
    
    //upload the records which are not unloaded
    NSMutableArray *uploadFoodNotUploadArray = [DBHelper getFoodNotUpload];
    NSLog(@"food records did not uploaded:%@",uploadFoodNotUploadArray);
    [self uploadFoodNotUpload:uploadFoodNotUploadArray];
    
    
    
  
    
    
}

+(NSString *)getNewestFoodDate_Server{
    NSString *dateString = [[NSString alloc]init];
    NSData *xmlData = [self getHistoryRecord:360];
    static NSString *lastRecordFlag = @"lastrecord";
	GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
     GDataXMLElement *rootElement = [doc rootElement];
    NSArray *lastRecord = [rootElement elementsForName:lastRecordFlag];
	for (GDataXMLElement *obj in lastRecord) {
        GDataXMLElement *timeElement = [[obj elementsForName:@"recordtime"]objectAtIndex:0];
        if (timeElement)
            dateString = timeElement.stringValue;
    }
    return dateString;
}


+(NSData *)getHistoryRecord:(NSInteger)dayBetween{
//    if (dayBetween==0) dayBetween=90;
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthFood?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&period="];
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat: @"%d", 90]];
        
        urlStr = [urlStr stringByAppendingString:@"&daily=0"];
        
        
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get history sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get Food History error!");
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncCaloriesNoDataConnection" object:nil];
        } else {
            return xmlData;
        }
    }
    return nil;
}

+(void)syncFoodData:(NSInteger)dayBetween{
    
    NSLog(@"dayBetween:%ld",(long)dayBetween);
    NSData *xmlData = [self getHistoryRecord:dayBetween];
    
//    static NSString *lastRecordFlag = @"lastrecord";
    static NSString *recordsFlag = @"records";
    static NSString *recordFlag = @"record";
    
    // initiate the xml document
	GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    
    // NSArray lastRecord for <lastrecord>...</lastrecord> in xml document
    GDataXMLElement *rootElement = [doc rootElement];
    
  
    
    //NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
//    NSArray *lastRecord = [rootElement elementsForName:lastRecordFlag];
    
    // iterate every element in <lastrecord>...</lastrecord>
    
//    GDataXMLElement *recordId,*totalCalories;
    GDataXMLElement *timeElement;
    
//    for (GDataXMLElement *obj in lastRecord) {
//        
//		recordId = [[obj elementsForName:@"recordid"]objectAtIndex:0];
//		totalCalories = [[obj elementsForName:@"calo"]objectAtIndex:0];
//        timeElement = [[obj elementsForName:@"recordtime"]objectAtIndex:0];
//    }
//    if ([recordId stringValue].length <=0 || [totalCalories stringValue].length <= 0 || [timeElement stringValue].length <=0) {
//        return;
//    }
//    NSString *foodRecordDetail = @"";//[self getRecordDetailById:[recordId stringValue]];
    NSString *timeString = [[timeElement stringValue] stringByAppendingString:@":00"];
//    [DBHelper addFoodFinalRecord:timeString foodRecordDetail:foodRecordDetail totalCalories:[NSNumber numberWithInt:[[totalCalories stringValue] intValue]] recordId:[recordId stringValue] status:@"0"];
	

    
    NSArray *records = [rootElement elementsForName:recordsFlag];

//    NSArray *records = [doc nodesForXPath:recordsFlag error:nil];
    
    for (GDataXMLElement *obj in records) {
        NSArray *record = [obj elementsForName:recordFlag];
        for (GDataXMLElement *objRecords in record){
//            if (![objRecords isEqual:[record lastObject]]){
                GDataXMLElement *recordId = [[objRecords elementsForName:@"recordid"] objectAtIndex:0];
                GDataXMLElement *totalCalories = [[objRecords elementsForName:@"calo"]objectAtIndex:0];
                GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
                NSString *foodRecordDetail = @"";//[self getRecordDetailById:[recordId stringValue]];
                timeString = [[timeElement stringValue] stringByAppendingString:@":00"];
                [DBHelper addFoodFinalRecord:timeString foodRecordDetail:foodRecordDetail totalCalories:[NSNumber numberWithInt:[[totalCalories stringValue] intValue]] recordId:[recordId stringValue] status:@"0"];
//            }
        }
    }
}

+ (NSString *)getRecordDetailById:(NSString *)recordId
{
    NSLog(@"******************");
    NSString *returnString = @"";
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthFood?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RD&recordid="];
        urlStr = [urlStr stringByAppendingString:recordId];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
            NSLog(@"Get record detail error!");
        } else {
     //       static NSString *foodFlag =@"food";
         
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
               NSLog(@"docsdsdsdssd=%@,",doc);
             GDataXMLElement *rootElement = [doc rootElement];
           NSLog(@"rootElementssssss=%@",rootElement);
           // NSArray *foodRecord = [rootElement nodesForXPath:@"food" error:nil];
           NSArray *foodRecord=[rootElement elementsForName:@"record"];
            NSLog(@"FoodRECORD=%@",foodRecord);
                      for (GDataXMLElement *obj in foodRecord) {
             //   NSLog(@"objjjjjj=%@",obj);
                          NSArray *foodlist=[obj elementsForName:@"foodlist"];
                       //   NSLog(@"foodlist=%@",foodlist);
                          for (GDataXMLElement *foodobj in foodlist) {
                              NSArray *food=[foodobj elementsForName:@"food"];
                       //       NSLog(@"food=%@",food);
                              for (GDataXMLElement *foodany in food) {
                                  GDataXMLElement *ref = [[foodany elementsForName:@"ref"] objectAtIndex:0];
                                  GDataXMLElement *enName = [[foodany elementsForName:@"enname"]objectAtIndex:0];
                                  GDataXMLElement *zhName = [[foodany elementsForName:@"zhname"]objectAtIndex:0];
                                  GDataXMLElement *enUnit = [[foodany elementsForName:@"enunit"]objectAtIndex:0];
                                  GDataXMLElement *zhUnit = [[foodany elementsForName:@"zhunit"]objectAtIndex:0];
                                  GDataXMLElement *type = [[foodany elementsForName:@"type"] objectAtIndex:0];
                                  GDataXMLElement *calo = [[foodany elementsForName:@"cal"]objectAtIndex:0];
                                  GDataXMLElement *image = [[foodany elementsForName:@"image"]objectAtIndex:0];
                                  GDataXMLElement *qty = [[foodany elementsForName:@"qty"]objectAtIndex:0];
                                  returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@|",[ref stringValue],[enName stringValue],[zhName stringValue],[enUnit stringValue],[zhUnit stringValue],[type stringValue],[calo stringValue],[image stringValue],[qty stringValue]]];
                                  
                               //   NSLog(@"returnString=%@",returnString);
                              }
                          }
               
                
            }
        }
    }
    if ([returnString length] > 0)
        returnString = [returnString substringToIndex:[returnString length]-1];
    return returnString;
}

+ (void)uploadFoodNotUpload:(NSMutableArray *)uploadFoodNotUploadArray{
    for (NSDictionary *foodRecord in uploadFoodNotUploadArray){
        [self sendResult:foodRecord];
    }
}

+ (void)sendResult:(NSDictionary *)foodRecord{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthFood?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=A&foodlist="];
        NSString *recordDetail = [foodRecord objectForKey:@"recordDetail"];
        recordDetail = [recordDetail stringByReplacingOccurrencesOfString:@"&" withString:@"%26amp;"];
        urlStr = [urlStr stringByAppendingString:recordDetail];
        urlStr = [urlStr stringByAppendingString:@"&recordtime="];
        
        NSString *recordTime = [foodRecord objectForKey:@"recordTime"];
        if ([recordTime length] > 16){
            recordTime = [recordTime substringToIndex:16];
        }
        urlStr = [urlStr stringByAppendingString:recordTime];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        //        [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        NSURL *request_url = [NSURL URLWithString:urlStr];
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"%25" withString:@"%"];
        NSLog(@"!!urlStr:%@",urlStr);
        
        NSURL *request_url = [[NSURL alloc]initWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        NSData *requestData = [NSData dataWithBytes:[[urlStr encodedURLString]UTF8String]
                                             length:[[urlStr encodedURLString]length]];
        [request setHTTPBody:requestData];
//        NSString *ionaSr=[[NSString alloc]initWithData:requestData encoding:NSUTF8StringEncoding];
        [NSURLConnection sendAsynchronousRequest:request
//                                           queue:[NSOperationQueue currentQueue]
                                            queue:[[NSOperationQueue alloc]init]
                               completionHandler:^(NSURLResponse *response, NSData *xmlData, NSError *error) {
                                   if (xmlData != nil && error == nil)
                                   {
                                       int isSucc = -1;
                                       NSString *recordId;
                                       static NSString *startFlag = @"response";
                                       
                                       GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                                        GDataXMLElement *rootElement = [doc rootElement];
                                       NSArray *responseArray = [rootElement elementsForName:startFlag];
                                       
                                       for (GDataXMLElement *obj in responseArray){
                                           GDataXMLElement *statusElement = [[obj elementsForName:@"status"]objectAtIndex:0];
                                           if (statusElement){
                                               if ([statusElement.stringValue isEqual: @"succ"])
                                                   isSucc = 1;
                                           }
                                           GDataXMLElement *recordidElement = [[obj elementsForName:@"recordid"] objectAtIndex:0];
                                           if (recordidElement){
                                               recordId = [recordidElement stringValue];
                                           }
                                       }
                                       NSLog(@"is upload food record succ:%d",isSucc);
                                       if ((isSucc==1)&&([recordId length]>0)){
                                           
                                           [DBHelper setFoodRecordStatus:0 recordId:recordId recordTime:[foodRecord objectForKey:@"recordTime"] recordDetail:[foodRecord objectForKey:@"recordDetail"]];
                                       }
                                       
                                   }
                                   else
                                   {
                                       // There was an error, alert the user
                                   }
                                   
                               }];
        
    }
}

#pragma mark -
#pragma mark Download/Refresh food list

+(void)checkFoodList
{
    NSString *foodListFileName_server = [self getNewFoodListFileName];
    BOOL isNew = [DBHelper isFoodListFileNameNew:foodListFileName_server];
    if (isNew) {
        [self downloadFoodList:foodListFileName_server];
    }
}

+(NSString *)getNewFoodListFileName;
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:FOODLISTTXT_URL]];
    NSError *error;
    NSData *downloadData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    
    if (downloadData != nil) {
        NSString *txt_nsstring = [[NSString alloc] initWithData:downloadData encoding:NSUTF8StringEncoding];
        return txt_nsstring;
    } else {
        NSLog(@"Checking food list error :%@",error);
    }
    return @"";
}

+(void)downloadFoodList:(NSString *)foodListFileName
{
    NSURL *foodListUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FOODLISTCSV,foodListFileName]];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:foodListUrl];
    
    NSError *error = nil;
    NSData *csv_data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil
                                                         error:&error];
    
    if (error!=nil) {
        return;
    }
    
    NSString *csv_nsstring = [[NSString alloc]initWithData:csv_data encoding:NSUTF8StringEncoding];
    
    NSRange range = [csv_nsstring rangeOfString:@"\n"];
    csv_nsstring = [csv_nsstring substringFromIndex:(range.location+range.length)];
    do {
        range = [csv_nsstring rangeOfString:@"\n"];
        NSInteger endLocation = (range.location<csv_nsstring.length)&&(range.location>0)?range.location:csv_nsstring.length;
        NSString *singleFoodInfoEntry = [csv_nsstring substringToIndex:endLocation];
        csv_nsstring = [csv_nsstring substringFromIndex:(endLocation+range.length)];
        
        
        
        [self parseFoodInfoEntry:singleFoodInfoEntry];
    } while (range.location+range.length<csv_nsstring.length);
    
}

+ (void)parseFoodInfoEntry:(NSString *)singleFoodInfOEntry
{
    NSArray *foodInfoArray = [singleFoodInfOEntry componentsSeparatedByString:NSLocalizedString(@",", nil)];
    NSRange enUnitRange = [foodInfoArray[3] rangeOfString:@" "];
    NSRange zhUnitRange = [foodInfoArray[4] rangeOfString:@" "];
    NSString *quantityUnit_en_string,*quantityUnit_zh_string;
    if (enUnitRange.length == 1) {
        quantityUnit_en_string = [foodInfoArray[3] substringFromIndex:enUnitRange.location+enUnitRange.length];
    } else {
        quantityUnit_en_string = [foodInfoArray[3] substringFromIndex:1];
    }
    if (zhUnitRange.length == 1) {
        quantityUnit_zh_string = [foodInfoArray[4] substringFromIndex:zhUnitRange.location+zhUnitRange.length];
    } else {
        quantityUnit_zh_string = [foodInfoArray[4] substringFromIndex:1];
    }
    
    NSString *foodImageFileName = foodInfoArray[7];
    foodImageFileName = [foodImageFileName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSRange range = [foodImageFileName rangeOfString:@"%0D"];
    if ((range.location>0)&&(range.location<[foodImageFileName length]))
        foodImageFileName = [foodImageFileName substringToIndex:range.location];
    
    FoodEntry *foodEntry = [[FoodEntry alloc]initWithNumber:[NSNumber numberWithInt:[foodInfoArray[0] intValue]]
                                                    name_en:foodInfoArray[1]
                                                    name_zh:foodInfoArray[2]
                                            quantityUnit_en:quantityUnit_en_string
                                            quantityUnit_zh:quantityUnit_zh_string
                                                   foodType:foodInfoArray[5]
                                               foodCalories:foodInfoArray[6]
                                          foodImageFileName:foodImageFileName
                                                   quantity:[NSNumber numberWithInt:0]];
    BOOL isOK = [DBHelper addFoodRecord:foodEntry];
    isOK = 1;
}

#pragma mark -
#pragma mark Calories History

+ (void)saveCaloriesData:(NSArray *)foodRecordsArray
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *recordTimeNSDate = [[NSDate alloc]init];
    NSString *recordDetail = @"";
    NSString *recordTimeNSString = [dateFormatter stringFromDate:recordTimeNSDate];
    long totalCalories_long = 0;
    for (FoodEntry *eachFoodRecord in foodRecordsArray){
        NSString *newRecord = [NSString stringWithFormat:@"%d,%@,%@,%@,%@,%@,%d,%@,%d|",[[eachFoodRecord getNumber]intValue], [eachFoodRecord getName_en], [eachFoodRecord getName_zh], [eachFoodRecord getQuantityUnit_en], [eachFoodRecord getQuantityUnit_zh], [eachFoodRecord getFoodType], [[eachFoodRecord getFoodCalories]intValue], [eachFoodRecord getFoodImageFileName], [[eachFoodRecord getQuantity]intValue]];
        recordDetail = [recordDetail stringByAppendingString:newRecord];
        totalCalories_long += [[eachFoodRecord getFoodCalories] intValue] * [[eachFoodRecord getQuantity]intValue];
    }
    recordDetail = [recordDetail substringToIndex:[recordDetail length]-1];
    NSLog(@"!!recordDetail before DB:%@",recordDetail);
    
    [DBHelper addFoodFinalRecord:recordTimeNSString foodRecordDetail:recordDetail totalCalories:[NSNumber numberWithLong:totalCalories_long] recordId:@"" status:@"1"];
    [DBHelper resetFoodListTable];
    
}

+ (NSDictionary *)parseFoodHistoryRecord:(NSString *)recordDetail{
    
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc]init];
    
    NSMutableArray *breakfastArray = [[NSMutableArray alloc]init];
    NSMutableArray *teaArray = [[NSMutableArray alloc]init];
    NSMutableArray *dinnerArray = [[NSMutableArray alloc]init];
    NSMutableArray *lunchArray = [[NSMutableArray alloc]init];
    NSMutableArray *seasonalArray = [[NSMutableArray alloc]init];
    
    NSArray *entriesInFoodRecord = [recordDetail componentsSeparatedByString:@"|"];
    NSLog(@"!!entriesInFoodRecord:%@",entriesInFoodRecord);
    for (NSString *eachEntry_NSString in entriesInFoodRecord){
        NSArray *eachEntry_NSArray = [eachEntry_NSString componentsSeparatedByString:@","];
        NSString *quantityUnit_en;
        NSString *quantityUnit_zh;
 
            quantityUnit_en = [eachEntry_NSArray objectAtIndex:3];
            quantityUnit_zh = [eachEntry_NSArray objectAtIndex:4];
   
  
        
        // trimming quantity number
        NSRange trimmingUnitRange = [quantityUnit_en rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]];
        if (trimmingUnitRange.length > 0) {
            quantityUnit_en = [quantityUnit_en substringFromIndex:trimmingUnitRange.location+trimmingUnitRange.length];
        }
        
        trimmingUnitRange = [quantityUnit_zh rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]];
        if (trimmingUnitRange.length > 0) {
            quantityUnit_zh = [quantityUnit_zh substringFromIndex:trimmingUnitRange.location+trimmingUnitRange.length];
        }

        // trimming quantity space
        trimmingUnitRange = [quantityUnit_en rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        if (trimmingUnitRange.length > 0) {
            quantityUnit_en = [quantityUnit_en substringFromIndex:trimmingUnitRange.location+trimmingUnitRange.length];
        }
        
        trimmingUnitRange = [quantityUnit_zh rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0 "]];
        if (trimmingUnitRange.length > 0) {
            quantityUnit_zh = [quantityUnit_zh substringFromIndex:trimmingUnitRange.location+trimmingUnitRange.length];
        }
        
        FoodEntry *eachFoodEntry = [[FoodEntry alloc]initWithNumber:[NSNumber numberWithInt:[[eachEntry_NSArray objectAtIndex:0]intValue]]
                                                            name_en:[eachEntry_NSArray objectAtIndex:1]
                                                            name_zh:[eachEntry_NSArray objectAtIndex:2]
                                                    quantityUnit_en:quantityUnit_en
                                                    quantityUnit_zh:quantityUnit_zh
                                                           foodType:[eachEntry_NSArray objectAtIndex:5]
                                                       foodCalories:[NSNumber numberWithInt:[[eachEntry_NSArray objectAtIndex:6]intValue]]
                                                  foodImageFileName:[eachEntry_NSArray objectAtIndex:7]
                                                           quantity:[NSNumber numberWithInt:[[eachEntry_NSArray objectAtIndex:8]intValue]]];
        if ([[eachEntry_NSArray objectAtIndex:5] isEqualToString:@"Breakfast"]) {
            [breakfastArray addObject:eachFoodEntry];
        } else if ([[eachEntry_NSArray objectAtIndex:5] isEqualToString:@"Lunch"]) {
            [lunchArray addObject:eachFoodEntry];
        } else if ([[eachEntry_NSArray objectAtIndex:5] isEqualToString:@"Dinner"]) {
            [dinnerArray addObject:eachFoodEntry];
        } else if ([[eachEntry_NSArray objectAtIndex:5] isEqualToString:@"Seasonal"]) {
            [seasonalArray addObject:eachFoodEntry];
        } else if ([[eachEntry_NSArray objectAtIndex:5] isEqualToString:@"Afternoon tea/ Snack"]) {
            [teaArray addObject:eachFoodEntry];
        }
    }
    
    if ([breakfastArray count]>0) {
        [returnDict setObject:breakfastArray forKey:@"Breakfast"];
    }
    if ([lunchArray count]>0) {
        [returnDict setObject:lunchArray forKey:@"Lunch"];
    }
    if ([teaArray count]>0) {
        [returnDict setObject:teaArray forKey:@"Afternoon tea/ Snack"];
    }
    if ([dinnerArray count]>0) {
        [returnDict setObject:dinnerArray forKey:@"Dinner"];
    }
    if ([seasonalArray count]>0) {
        [returnDict setObject:seasonalArray forKey:@"Seasonal"];
    }
    return returnDict;
}

+ (void)deleteFoodDetail:(NSString *)recordTime
{
    NSString *recordId = [DBHelper deleteFoodDetail:recordTime];
    if ([recordId length]>0){
        NSString *lang = [Utility getLanguageCode];
        if ([lang isEqualToString:@"cn"])
            lang = @"zh";
        
        if ([GlobalVariables shareInstance].session_id!=nil){
            NSString *session_id = [GlobalVariables shareInstance].session_id;
            NSString *login_id = [GlobalVariables shareInstance].login_id;
            NSString *urlStr = [[NSString alloc]init];
            urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
            urlStr = [urlStr stringByAppendingString:@"healthFood?login="];
            if (login_id)
                urlStr = [urlStr stringByAppendingString:login_id];
            urlStr = [urlStr stringByAppendingString:@"&action=D&recordid="];
            urlStr = [urlStr stringByAppendingString:recordId];
            urlStr = [urlStr stringByAppendingString:@"&lang="];
            urlStr = [urlStr stringByAppendingString:lang];
            urlStr = [urlStr stringByAppendingString:@"&sessionid="];
            urlStr = [urlStr stringByAppendingString:session_id];
            NSURL *request_url = [NSURL URLWithString:urlStr];
            NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
            if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]) {
                NSLog(@"delete food record error!");
            }
        }
    } else {
        NSLog(@"deleteFoodDetail error, recordTime:%@ not found",recordTime);
    }
    
}

@end