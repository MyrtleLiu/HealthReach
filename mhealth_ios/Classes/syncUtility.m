//
//  syncUtility.m
//  mHealth
//
//  Created by Apple on 23/5/14.
//
//

#import "syncUtility.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "syncBP.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "TKAlertCenter.h"
#import "Utility.h"
#import"GDataXMLNode.h"
#import "syncMessage.h"

@implementation syncUtility

+ (BOOL)XMLHasError:(NSData *)xmlData{
    
    [self handleTimeoutError:xmlData];
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];

    static NSString *errorFlag = @"errorcode";
    NSArray *errorRecord = [rootElement elementsForName:errorFlag ];
    
    if ([errorRecord count]>0) {
        NSLog(@"XML contains error message:%@",[errorRecord lastObject]);
        
        NSString *errorStr=nil;
        
        NSString *error=((GDataXMLElement*)[errorRecord lastObject]).stringValue;
        
        if ([error isEqualToString:@"INVALID_ACTION"]) {
            
            errorStr=[Utility getStringByKey:@"invalid_parameter"];
            
        }else if ([error isEqualToString:@"SYSTEM_ERROR"]){
            
            errorStr=[Utility getStringByKey:@"sys_error"];
            
            //errorStr=@"noshow";
            
        }else if ([error isEqualToString:@"MISS_PARAM"]){
            
            errorStr=[Utility getStringByKey:@"missing_parameter"];
            
        }else if ([error isEqualToString:@"DUPLICATE_RECORD"]){
            
            errorStr=[Utility getStringByKey:@"record_exist"];
            
        }else if ([error isEqualToString:@"INVALID_PARAM_VALUE"]){
            
            //errorStr=[Utility getStringByKey:@"invalid_param"];
            
            errorStr=@"noshow";
            
        }else if ([error isEqualToString:@"INVALID_SESSION"]) {
            
            errorStr=@"noshow";
            
        }
        
        if (errorStr==nil) {
            
            errorStr=@"Unknow error.";
        }
        
        @try {
            
            if (![errorStr isEqualToString:@"noshow"]) {
                
                [[TKAlertCenter defaultCenter] postAlertWithMessage:errorStr];
            }
            
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
        
        return TRUE;
    }
    return FALSE;
}

+ (void)handleTimeoutError:(NSData *)xmlData{
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    
    static NSString *responseFlag = @"errorcode";
     GDataXMLElement *rootElement = [doc rootElement];
    NSArray *errorRecord = [rootElement elementsForName:responseFlag];
    
    NSLog(@"errorRecord:%@ count:%lu isnull:%@",errorRecord,(unsigned long)[errorRecord count],[errorRecord lastObject]);
    if ([errorRecord count]>0) {
        
        NSString *error=((GDataXMLElement*)[errorRecord lastObject]).stringValue;
        if (error!=nil) {
            if ([error isEqualToString:@"INVALID_SESSION"]) {
                
                //back to login page.....
                
                @try {
                    
                    
                    if (![(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] isLoginView]) {
                        
                        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"invalid_session"]];
                    }
                    
                    
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
                [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
            }
        }
    }
}


+ (NSString *)getAddWalkingRecordMsg:(NSData *)xmlData{
    NSString *result=@"";

    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    
    
    GDataXMLElement *messageElement = [[rootElement elementsForName:@"message"] objectAtIndex:0];
    if([messageElement stringValue]!=nil){
        return [messageElement stringValue];
    }
    
    return result;
}


+ (NSString *)getAddWalkingRecordShareKey:(NSData *)xmlData{
    NSString *result=@"";

    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];

    GDataXMLElement *fbKeyElement = [[rootElement elementsForName:@"fb_key"] objectAtIndex:0];
    if([fbKeyElement stringValue]!=nil){
            return [fbKeyElement stringValue];
    }

    return result;
}

+ (NSDictionary *)getAllNewestDate_server{
    
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc]init];
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthSubStatus?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    
    NSLog(@"get newest date from server, sending url:%@",url_string);
    
    NSURL *request_url = [NSURL URLWithString:url_string];
	NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    static NSString *lastUpdatesFlag = @"lastupdates";
    static NSString *recordFlag = @"record";
    static NSString *deviceFlag = @"device";
    static NSString *cloudFlag = @"cloud";
     GDataXMLElement *rootElement = [doc rootElement];
    NSArray *lastUpdateRecords = [rootElement elementsForName:lastUpdatesFlag ];
    for (GDataXMLElement *obj in lastUpdateRecords) {
        NSArray *record = [obj elementsForName: recordFlag];
        for (GDataXMLElement *objRecord in record) {
            GDataXMLElement *typeElement = [[objRecord elementsForName:@"type"]objectAtIndex:0];
            GDataXMLElement *lastupdateELement = [[objRecord elementsForName:@"lastupdate"]objectAtIndex:0];
            [returnDict setObject:lastupdateELement.stringValue forKey:typeElement.stringValue];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject: lastupdateELement.stringValue forKey: [NSString stringWithFormat:@"server_update_date_%@_%@",typeElement.stringValue,[GlobalVariables shareInstance].login_id]];
            
            [defaults synchronize];
        }
        
        
        NSArray *devices = [rootElement elementsForName:deviceFlag];
        
        for (GDataXMLElement *devicesRecord in devices) {
            GDataXMLElement *typeElement = [[devicesRecord elementsForName:@"type"]objectAtIndex:0];
            GDataXMLElement *codeELement = [[devicesRecord elementsForName:@"code"]objectAtIndex:0];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject: codeELement.stringValue forKey: [NSString stringWithFormat:@"devices_%@_%@",typeElement.stringValue,[GlobalVariables shareInstance].login_id]];
            
            [defaults synchronize];
        }
        
        NSArray *clouds = [rootElement elementsForName:cloudFlag];
        
        for (GDataXMLElement *cloundRecord in clouds) {
            
            GDataXMLElement *statusElement = [[cloundRecord elementsForName:@"status"]objectAtIndex:0];
            
             GDataXMLElement *gotourlElement = [[cloundRecord elementsForName:@"gotourl"]objectAtIndex:0];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject: statusElement.stringValue forKey: [NSString stringWithFormat:@"clouds_status_%@",[GlobalVariables shareInstance].login_id]];
            
            [defaults setObject: gotourlElement.stringValue forKey: [NSString stringWithFormat:@"clouds_url_%@",[GlobalVariables shareInstance].login_id]];
            
            [defaults synchronize];
        }

        
    }
    
    
    return returnDict;
}
+ (NSString *)getAppVerrsioningCheckKey:(NSData *)xmlData{
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
    NSString *result=@"";
    static NSString *responseFlag = @"warn";
     GDataXMLElement *rootElement = [doc rootElement];
    NSArray *msgRecord = [rootElement elementsForName:responseFlag ];
    
    
    if ([msgRecord count]>0) {
        
        NSString *msg_text=((GDataXMLElement*)[msgRecord lastObject]).stringValue;
        if (msg_text!=nil) {
            
            
            return msg_text;
        }
    }
    
    return result;
}
+(void)getMessageCount{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    
    NSString *urlStr = [[NSString alloc]init];
    urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
    urlStr = [urlStr stringByAppendingString:@"healthMessage?login="];
    urlStr = [urlStr stringByAppendingString:login_id];
    urlStr = [urlStr stringByAppendingString:@"&action=BC"];
    urlStr = [urlStr stringByAppendingString:@"&sessionid="];
    urlStr = [urlStr stringByAppendingString:session_id];
    urlStr = [urlStr stringByAppendingString:@"&type=Message"];

    NSLog(@"rt url:%@",urlStr);
    
    NSURL *request_url = [NSURL URLWithString:urlStr];
    
    [NSData dataWithContentsOfURL:request_url];
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    
    
    if (xmlData) {
        [syncUtility XMLHasError:xmlData];
        static NSString *countFlag = @"count";
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        
        
        GDataXMLElement *count = [[rootElement elementsForName:countFlag]objectAtIndex:0];
        NSString *messageNotReadCount= [count stringValue];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:messageNotReadCount forKey:[NSString stringWithFormat:@"messageNotReadCount_%@",[GlobalVariables shareInstance].login_id]];
        [defaults synchronize];
    }
    
}


+(void)getNewsCount{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    
    NSString *urlStr = [[NSString alloc]init];
    urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
    urlStr = [urlStr stringByAppendingString:@"healthMessage?login="];
    urlStr = [urlStr stringByAppendingString:login_id];
    urlStr = [urlStr stringByAppendingString:@"&action=BC"];
    urlStr = [urlStr stringByAppendingString:@"&sessionid="];
    urlStr = [urlStr stringByAppendingString:session_id];
    urlStr = [urlStr stringByAppendingString:@"&type=News"];
    
    NSLog(@"rt url:%@",urlStr);
    
    NSURL *request_url = [NSURL URLWithString:urlStr];
    
    [NSData dataWithContentsOfURL:request_url];
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    
    
    if (xmlData) {
        [syncUtility XMLHasError:xmlData];
        static NSString *countFlag = @"count";
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
        GDataXMLElement *rootElement = [doc rootElement];
        
        
        GDataXMLElement *count = [[rootElement elementsForName:countFlag]objectAtIndex:0];
        NSString *messageNotReadCount= [count stringValue];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        int apiUnreadCount=[messageNotReadCount intValue];
        int localUnreadCount=-1;
        NSString *checkLocalUnreadCount=[defaults objectForKey:[NSString stringWithFormat:@"newsNotReadCount_%@",[GlobalVariables shareInstance].login_id]];
        if(checkLocalUnreadCount!=Nil){
           localUnreadCount=[[defaults objectForKey:[NSString stringWithFormat:@"newsNotReadCount_%@",[GlobalVariables shareInstance].login_id]] intValue];
        }
      
        if(apiUnreadCount>localUnreadCount||localUnreadCount<0){
            NSThread *threadUpdateNews = [[NSThread alloc]initWithTarget:self selector:@selector(UpdateNews:) object:messageNotReadCount];
            [threadUpdateNews start];
        }
        
        [defaults setObject:messageNotReadCount forKey:[NSString stringWithFormat:@"newsNotReadCount_%@",[GlobalVariables shareInstance].login_id]];
        [defaults synchronize];
    }
    
}






+ (void)getPersonInfo{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthUser?login="];
        urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&sessionid="];
        urlStr = [urlStr stringByAppendingString:session_id];
        NSURL *requestURL = [NSURL URLWithString:urlStr];
        NSLog(@"person info request URL:%@",requestURL);
        NSData *xmlData = [NSData dataWithContentsOfURL:requestURL];
        
        //NSString *xmlSTr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@====================",xmlSTr);
        
        if (!(xmlData == nil)){
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
  
            NSArray *response=[doc  nodesForXPath:@"response" error:nil];

            NSLog(@"responseArray=%@",response);
            for (GDataXMLElement *obj in response){
                GDataXMLElement *heightElement = [[obj elementsForName:@"height"] objectAtIndex:0];
                if (heightElement){
                    NSString *height = heightElement.stringValue;
                    [defaults setObject: height forKey: [NSString stringWithFormat:@"height_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
                GDataXMLElement *phoneElement = [[obj elementsForName:@"phone"]objectAtIndex:0];
                if (phoneElement){
                    NSString *phone = phoneElement.stringValue;
                    [defaults setObject: phone forKey: [NSString stringWithFormat:@"phone_%@",[GlobalVariables shareInstance].login_id]];
                    NSLog(@"check in login : @%@",phone);
                    [defaults synchronize];
                }
                
                GDataXMLElement *emailElement = [[obj elementsForName:@"email"]objectAtIndex:0];
                if (emailElement){
                    NSString *email = emailElement.stringValue;
                    [defaults setObject: email forKey: [NSString stringWithFormat:@"email_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
                GDataXMLElement *genderElement = [[obj elementsForName:@"gender"]objectAtIndex:0];
                if (genderElement){
                    NSString *gender = genderElement.stringValue;
                    [defaults setObject: gender forKey: [NSString stringWithFormat:@"gender_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
                GDataXMLElement *weightElement = [[obj elementsForName:@"weight"]objectAtIndex:0];
                if (weightElement){
                    NSString *weight = weightElement.stringValue;
                    [defaults setObject: weight forKey: [NSString stringWithFormat:@"weight_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
                GDataXMLElement *weightdisplayElement = [[obj elementsForName:@"weightdisplay"]objectAtIndex:0];
                if (weightdisplayElement){
                    NSString *weightdisplay = weightdisplayElement.stringValue;
                    [defaults setObject: weightdisplay forKey: [NSString stringWithFormat:@"weightdisplay_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
                GDataXMLElement *heightdisplayElement = [[obj elementsForName:@"heightdisplay"]objectAtIndex:0];
                if (heightdisplayElement){
                    NSString *heightdisplay = heightdisplayElement.stringValue;
                    [defaults setObject: heightdisplay forKey: [NSString stringWithFormat:@"heightdisplay_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
                GDataXMLElement *circumferenceElement = [[obj elementsForName:@"circumference"]objectAtIndex:0];
                if (circumferenceElement){
                    NSString *circumference = circumferenceElement.stringValue;
                    [defaults setObject: circumference forKey: [NSString stringWithFormat:@"circumference_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
                GDataXMLElement *circumferencedisplayElement = [[obj elementsForName:@"circumferencedisplay"]objectAtIndex:0];
                if (circumferencedisplayElement){
                    NSString *circumferencedisplay = circumferencedisplayElement.stringValue;
                    [defaults setObject: circumferencedisplay forKey: [NSString stringWithFormat:@"circumferencedisplay_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                GDataXMLElement *ethnicityElement = [[obj elementsForName:@"ethnicity"]objectAtIndex:0];
                if (ethnicityElement){
                    NSString *ethnicity = ethnicityElement.stringValue;
                    [defaults setObject: ethnicity forKey: [NSString stringWithFormat:@"ethnicity_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
                //                DDXMLElement *langElement = [obj elementForName:@"lang"];
                //                if (langElement){
                //                    NSString *lang = langElement.stringValue;
                //                    [defaults setObject: lang forKey: [NSString stringWithFormat:@"lang_%@",[GlobalVariables shareInstance].login_id]];
                //
                //                    [defaults synchronize];
                //                }
                
                GDataXMLElement *birthElement = [[obj elementsForName:@"birth"]objectAtIndex:0];
                NSLog(@"birthElement=%@",[birthElement stringValue]);
                if (birthElement){
                    NSString *birth = birthElement.stringValue;
                    [defaults setObject: birth forKey: [NSString stringWithFormat:@"birth_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                GDataXMLElement *trophyElement = [[obj elementsForName:@"is_trophy_started"]objectAtIndex:0];
                if (trophyElement){
                    NSString *birth = trophyElement.stringValue;
                    NSLog(@"trophyElement.stringValue=%@",trophyElement.stringValue);
                    [defaults setObject: birth forKey: [NSString stringWithFormat:@"is_trophy_started_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                else{
                    [defaults setObject: @"0" forKey: [NSString stringWithFormat:@"is_trophy_started_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }

                
                GDataXMLElement *walkElement = [[obj elementsForName:@"is_walk_plant_started"]objectAtIndex:0];
                NSLog(@"walkElement.stringValue=%@",walkElement.stringValue);
                if (walkElement){
                    NSString *birth = walkElement.stringValue;
                    [defaults setObject: birth forKey: [NSString stringWithFormat:@"is_walk_plant_started_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                else{
                    [defaults setObject: @"0" forKey: [NSString stringWithFormat:@"is_walk_plant_started_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                }
                
                
            }
        }
    }
}


//        <phone>63213405</phone>
//        <email></email>
//        <gender>M</gender>
//        <weight>44.00</weight>
//        <weightdisplay>lb</weightdisplay>
//        <height>175.00</height>
//        <heightdisplay>cm</heightdisplay>
//        <circumference>85.00</circumference>
//        <circumferencedisplay>cm</circumferencedisplay>
//        <ethnicity></ethnicity>
//        <lang>en</lang>
//        <webuser></webuser>
//        <webpasswd></webpasswd>
//        <birth>1980</birth>



+ (void)updatePersonInfo:(NSDictionary *)userInfo{
    
    
}

+(void)updatePersonalInfo:(NSString *)weightValueString_lbs{
    NSLog(@"updatePersonalInfo!!,weightValueString:%@",weightValueString_lbs);
    if (!(([weightValueString_lbs isEqualToString:@""]) && ([weightValueString_lbs isEqualToString:@"0"]))) {
        NSLog(@"checkpoint1");
        NSString *genderValue=[Utility getGender];
        NSString *yearValue=[Utility getBirth];
        NSLog(@"weightValueStringweightValueString :%@",weightValueString_lbs);
        NSString *weightValue= weightValueString_lbs;
        NSString *weightDisplayValue=[Utility getWeightdisplay];
        
        NSString *heightValue=[Utility getHeight];
        NSString *heightDisplayValue=[Utility getHeightdisplay];
        
        
        NSString *circumferenceValue=[Utility getCircumference];
        //    circumferenceDisplayValue=self.circumferencedisplayValueLabel.text;
        NSString *circumferenceDisplayValue=[Utility getCircumferencedisplay];
        
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *url_string = [[NSString alloc]init];
        url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
        url_string = [url_string stringByAppendingString:@"healthUser?login="];
        url_string = [url_string stringByAppendingString:login_id];
        url_string = [url_string stringByAppendingString:@"&sessionid="];
        url_string = [url_string stringByAppendingString:session_id];
        
        url_string = [url_string stringByAppendingString:@"&action=U"];
        
        if (yearValue){
            url_string = [url_string stringByAppendingString:@"&birth="];
            url_string = [url_string stringByAppendingString:yearValue];
        }
        if (genderValue){
            url_string = [url_string stringByAppendingString:@"&gender="];
            url_string = [url_string stringByAppendingString:genderValue];
        }
        if (weightValue){
            url_string = [url_string stringByAppendingString:@"&weight="];
            
            url_string = [url_string stringByAppendingString:weightValue];
        }
        if (weightDisplayValue){
            url_string = [url_string stringByAppendingString:@"&weightdisplay="];
            url_string = [url_string stringByAppendingString:weightDisplayValue];
        }
        if (heightValue){
            url_string = [url_string stringByAppendingString:@"&height="];
            url_string = [url_string stringByAppendingString:heightValue];
        }
        if (heightDisplayValue){
            url_string = [url_string stringByAppendingString:@"&heightdisplay="];
            url_string = [url_string stringByAppendingString:heightDisplayValue];
        }
        if (circumferenceValue){
            url_string = [url_string stringByAppendingString:@"&circumference="];
            url_string = [url_string stringByAppendingString:circumferenceValue];
        }
        
        if (circumferenceDisplayValue){
            url_string = [url_string stringByAppendingString:@"&circumferencedisplay="];
            url_string = [url_string stringByAppendingString:circumferenceDisplayValue];
        }

        NSURL *request_url = [NSURL URLWithString:url_string];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if (xmlData){
            int isSucc = [syncUtility XMLHasError:xmlData];
            NSLog(@"is upload user infomation succ:%d",isSucc);
            
        }
    }
}

+ (int)getHeadYear{
    
    NSDate *currentNSDate = [[NSDate alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *currentDateString = [dateFormatter stringFromDate:currentNSDate];
    int currentYear = [[currentDateString substringToIndex:4]intValue];
    int currentMonth = [[currentDateString substringFromIndex:6]intValue];
    if (currentMonth >= 4)
        return currentYear;
    else
        return currentYear-1;
}

+ (int)getHeadMonth{
    NSDate *currentNSDate = [[NSDate alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *currentDateString = [dateFormatter stringFromDate:currentNSDate];
    int currentMonth = [[currentDateString substringFromIndex:6]intValue];
    if (currentMonth >= 4)
        return currentMonth;
    else
        return currentMonth+8;
}


+ (void)saveXMLData:(NSString *)filename xml:(NSData *)data{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
       
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];

        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
            
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil]; //Create folder
            
//            if (result) {
//                
//                NSLog(@"create folder......ok");
//                
//            }else{
//                
//                NSLog(@"create folder......fail");
//            }
            
            
            
            
        }
        

        NSString *filePath=[NSString stringWithFormat:@"%@/%@",dataPath,filename];
        
        
        NSLog(@"file path........%@",filePath);
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            
            //del exist file.
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            
        }
        
        NSError *error=nil;
        
       BOOL result= [data writeToFile:filePath options:0 error:&error];
        
        
        if (error!=nil) {
            
            NSLog(@"error......%@",[error description]);
        }
        
        if (result) {
            
            NSLog(@"save ok....");
        }else{
            
            NSLog(@"save fail....");
        }
        
    }
    
    
}

+ (void)parserAverageBP{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder

        NSData *data30d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BP30DA]];
        
        if (data30d!=nil) {
            
            
                
                static NSString *recordsFlag = @"records";
                static NSString *recordFlag = @"record";
                
                // initiate the xml document
                GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data30d options:0 error:nil];
                 GDataXMLElement *rootElement = [doc rootElement];
                
                NSArray *records = [rootElement elementsForName:recordsFlag];
                
                for (GDataXMLElement *obj in records) {
                    NSArray *record = [obj elementsForName:recordFlag];
                    for (GDataXMLElement *objRecords in record){
                        //if (![objRecords isEqual:[record lastObject]]){
                        GDataXMLElement *sysElement = [[objRecords elementsForName:@"systolic"]objectAtIndex:0];
                        GDataXMLElement *diaElement = [[objRecords elementsForName:@"diastolic"]objectAtIndex:0];
                        GDataXMLElement *heartRateElement = [[objRecords elementsForName:@"heartrate"]objectAtIndex:0];
                        GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
                        GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"]objectAtIndex:0];
                        
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
                
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BP30DA] error:nil];
            
        }
        
        NSData *data90d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BP90DA]];
        
        if (data90d!=nil) {
            
            
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            // initiate the xml document
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data90d options:0 error:nil];
             GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *records = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *obj in records) {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record){
                    //if (![objRecords isEqual:[record lastObject]]){
                    GDataXMLElement *sysElement = [[objRecords elementsForName:@"systolic"]objectAtIndex:0];
                    GDataXMLElement *diaElement = [[objRecords elementsForName:@"diastolic"]objectAtIndex:0];
                    GDataXMLElement *heartRateElement = [[objRecords elementsForName:@"heartrate"]objectAtIndex:0];
                    GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
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
            
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BP90DA] error:nil];
            
        }
        
        
        NSLog(@"parser average bp");

        
    }
}

+ (void)parserAverageBG{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        NSData *data30d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BG30DA]];
        
        NSData *data30db=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BG30DAB]];
        
        NSData *data30df=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BG30DAF]];
        
        NSData *data30du=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BG30DAU]];
        
        if (data30d!=nil) {
            
            [syncUtility parserBGData:data30d status:30];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BG30DA] error:nil];
            
        }
        
        if (data30db!=nil) {
            
            [syncUtility parserBGData:data30db status:30];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BG30DAB] error:nil];
            
        }
        
        if (data30df!=nil) {
            
            [syncUtility parserBGData:data30df status:30];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BG30DAF] error:nil];
            
        }
        
        if (data30du!=nil) {
            
            [syncUtility parserBGData:data30du status:30];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BG30DAU] error:nil];
            
        }
        
        NSData *data90d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BG90DA]];
        
        NSData *data90db=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BG90DAB]];
        
        NSData *data90df=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BG90DAF]];
        
        NSData *data90du=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,BG90DAU]];
        
        if (data90d!=nil) {
            
            [syncUtility parserBGData:data90d status:90];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BG90DA] error:nil];
            
        }
        
        if (data90db!=nil) {
            
            [syncUtility parserBGData:data90db status:90];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BG90DAB] error:nil];
            
        }
        
        if (data90df!=nil) {
            
            [syncUtility parserBGData:data90df status:90];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BG90DAF] error:nil];
            
        }
        
        if (data90du!=nil) {
            
            [syncUtility parserBGData:data90du status:90];
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,BG90DAU] error:nil];
            
        }

        
        NSLog(@"parser average bg");
    }
    
    
}

+(void)parserBGData:(NSData*)xmlData status:(int)thestatus{
    
    
    static NSString *recordsFlag = @"records";
    static NSString *recordFlag = @"record";
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    
     GDataXMLElement *rootElement = [doc rootElement];
    NSArray *records = [rootElement elementsForName:recordsFlag];
    
    for (GDataXMLElement *obj in records) {
        NSArray *record = [obj elementsForName:recordFlag];
        for (GDataXMLElement *objRecords in record){
            //if (![objRecords isEqual:[record lastObject]]){
            GDataXMLElement *bgElement = [[objRecords elementsForName:@"bg"]objectAtIndex:0];
            GDataXMLElement *typeELement = [[objRecords elementsForName:@"type"]objectAtIndex:0];
            GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
            GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"]objectAtIndex:0];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *bgDate_string = [dateFormatter dateFromString:timeElement.stringValue];
            long bgDate_long=[bgDate_string timeIntervalSince1970];
            
            BloodGlucose *bgData = [[BloodGlucose alloc] initWithBG:[bgElement stringValue] time:bgDate_long status:thestatus missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1 type:[typeELement stringValue]];
            
            [DBHelper addBGAverageChartRecord:bgData];
            //}
            
        }
    }

}

+ (void)parserAverageWeight{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        NSData *data30d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,W30DA]];
        
        if (data30d!=nil) {
            
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data30d options:0 error:nil];
             GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *records = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *obj in records)
            {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record)
                {
                    //if (![objRecords isEqual:[record lastObject]])
                    //{
                    GDataXMLElement *weightElement = [[objRecords elementsForName:@"weight"]objectAtIndex:0];
                    GDataXMLElement *bmiElement = [[objRecords elementsForName:@"bmi"]objectAtIndex:0];
                    GDataXMLElement *timeElement = [[objRecords elementsForName:@"recordtime"]objectAtIndex:0];
                    GDataXMLElement *missElement = [[objRecords elementsForName:@"missprevious"]objectAtIndex:0];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *weightDate_string = [dateFormatter dateFromString:timeElement.stringValue];
                    long weightDate_long=[weightDate_string timeIntervalSince1970];
                    Weight *weightData=[[Weight alloc]initWithWeight:[weightElement stringValue] bmi:[bmiElement stringValue] time:weightDate_long status:30 missprevious:[missElement.stringValue isEqualToString:@"Y"]?0:1];
                    
                    
                    [DBHelper addWeightAverageChartRecord:weightData];
                    //}
                }
            }
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,W30DA] error:nil];
            
        }
        
        NSData *data90d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,W90DA]];
        
        if (data90d!=nil) {
            
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data90d options:0 error:nil];
             GDataXMLElement *rootElement = [doc rootElement];
            
            NSArray *records = [rootElement elementsForName:recordsFlag];
            
            for (GDataXMLElement *obj in records)
            {
                NSArray *record = [obj elementsForName:recordFlag];
                for (GDataXMLElement *objRecords in record)
                {
                    //if (![objRecords isEqual:[record lastObject]])
                    //{
                    GDataXMLElement *weightElement = [[objRecords elementsForName:@"weight"]objectAtIndex:0];
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

            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,W90DA] error:nil];
           
        }
            
        
        NSLog(@"parser average weight");
            
    }

    
}

+ (void)parserAverageCW{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        NSData *data30d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,CW30DA]];
        
        if (data30d!=nil) {
            
            
            [syncUtility XMLHasError:data30d];
            
            // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
            // NSLog(@"%@====================",xmlStr);
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data30d options:0 error:nil];
            
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
                    
                    [DBHelper addWalkingCWAverageChartRecord:walking];
                    
                }
                
                
            }
            
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,CW30DA] error:nil];
        }
        
        NSData *data90d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,CW90DA]];
        
        if (data90d!=nil) {
            
            
                        [syncUtility XMLHasError:data90d];
            
                        // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
                        // NSLog(@"%@====================",xmlStr);
            
                        static NSString *recordsFlag = @"records";
                        static NSString *recordFlag = @"record";
                        // static NSString *causalwalkFlag = @"//causalwalk";
            
                        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data90d options:0 error:nil];
            
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
            
            
            
                                WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:@"" route:@"" recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:90 persistime:[duration.stringValue integerValue]];
                                
                                [DBHelper addWalkingCWAverageChartRecord:walking];
                                
                            }
                            
                            
                        }
            
             [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,CW90DA] error:nil];
            
        }
        
        
        NSLog(@"parser average cw");
    }
    

    
}
+ (void)parserAverageTP{
    
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",login_id]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        NSData *data30d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,TP30DA]];
        
        if (data30d!=nil) {
            
            
            [syncUtility XMLHasError:data30d];
            
            // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
            // NSLog(@"%@====================",xmlStr);
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data30d options:0 error:nil];
            
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

        
             [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,TP30DA] error:nil];
        
            
        }
        
        NSData *data90d=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",dataPath,TP90DA]];
        
        if (data90d!=nil) {
            
            
            [syncUtility XMLHasError:data90d];
            
            // NSString *xmlStr=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
            
            // NSLog(@"%@====================",xmlStr);
            
            static NSString *recordsFlag = @"records";
            static NSString *recordFlag = @"record";
            // static NSString *causalwalkFlag = @"//causalwalk";
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data90d options:0 error:nil];
            
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
                    
                    
                    
                    WalkingRecord *walking=[[WalkingRecord alloc] initWithSteps:steps.stringValue distance:meters.stringValue calsburnt:caloburnt.stringValue pace:@"" trainid:trainid.stringValue gps:@"" route:@"" recordid:recordid.stringValue result:result.stringValue target:calotarget.stringValue foodlist:foodlist.stringValue persistimeStr:@"" time:date_long type:90 persistime:[duration.stringValue integerValue]];
                    
                    [DBHelper addWalkingTrainAverageChartRecord:walking];
                    
                }
                
                
            }
            
            
             [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",dataPath,TP90DA] error:nil];
        }
        
        
        NSLog(@"parser average tp");
        
        
    }
    
    
    
    
   

    
}



+(void)UpdateNews:(NSString*)messageNotReadCount{
    [syncMessage getAllNewsRecord];
    
    
}




@end
