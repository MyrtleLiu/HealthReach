//
//  syncAlertLevel.m
//  mHealth
//
//  Created by admin on 9/3/14.
//
//

#import "syncAlertLevel.h"
#import "Utility.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "syncUtility.h"
#import"GDataXMLNode.h"
@implementation syncAlertLevel

+(void)syncAlertLevelData {
    
    NSLog(@"syncAlertLevelData:");
    NSData *xmlData = [self getHistoryRecord];
    
    static NSString *recordFlag = @"alertlevel";
    
	GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    NSLog(@"doc:%@",doc);
    GDataXMLElement *rootElement = [doc rootElement];
    
    
    
    //NSArray *lastRecord = [doc nodesForXPath:lastRecordFlag error:nil];
    NSArray *lastRecord = [rootElement elementsForName:recordFlag];
    NSLog(@"lastRecord=%@",lastRecord);
	for (GDataXMLElement *obj in lastRecord) {
		GDataXMLElement *lsystolicElement = [[obj elementsForName:@"lsystolic"] objectAtIndex:0];
        NSLog(@"[lsystolicElement stringValue]%@",[lsystolicElement stringValue]);
        GDataXMLElement *hsystolicELement = [[obj elementsForName:@"hsystolic"] objectAtIndex:0];
        NSLog(@"hsystolicELement=%@",[hsystolicELement stringValue]);
        GDataXMLElement *ldiastolicElement = [[obj elementsForName:@"ldiastolic"] objectAtIndex:0];
        NSLog(@"ldiastolicElement=%@",[hsystolicELement stringValue]);
        GDataXMLElement *hdiastolicElement = [[obj elementsForName:@"hdiastolic"] objectAtIndex:0];
        NSLog(@"hdiastolicElement =%@",[hdiastolicElement stringValue]);
        GDataXMLElement *bp_lheartrateElement = [[obj elementsForName:@"bp_lheartrate"] objectAtIndex:0];
        GDataXMLElement *bp_hheartrateELement = [[obj elementsForName:@"bp_hheartrate"] objectAtIndex:0];
        
        GDataXMLElement *ecg_lheartrateElement = [[obj elementsForName:@"ecg_lheartrate"] objectAtIndex:0];
        GDataXMLElement *ecg_hheartrateElement = [[obj elementsForName:@"ecg_hheartrate"] objectAtIndex:0];
        
        
        GDataXMLElement *lbgElement = [[obj elementsForName:@"lbg"] objectAtIndex:0];
        GDataXMLElement *hbgELement = [[obj elementsForName:@"hbg"]objectAtIndex:0];
        
        GDataXMLElement *lbg_bElement = [[obj elementsForName:@"lbg_b"]objectAtIndex:0];
        GDataXMLElement *hbg_bElement = [[obj elementsForName:@"hbg_b"]objectAtIndex:0];
        
        GDataXMLElement *lbg_aElement = [[obj elementsForName:@"lbg_a"] objectAtIndex:0];
        GDataXMLElement *hbg_aELement = [[obj elementsForName:@"hbg_a"] objectAtIndex:0];
        
        GDataXMLElement *lstepsElement = [[obj elementsForName:@"lsteps"] objectAtIndex:0];
        GDataXMLElement *hbmiElement = [[obj elementsForName:@"hbmi"]objectAtIndex:0];
        
        AlertLevel *alertLevel = [AlertLevel new];
        [alertLevel setLsystolic:[lsystolicElement stringValue]];
        [alertLevel setHsystolic:[hsystolicELement stringValue]];
        
        [alertLevel setLdiastolic:[ldiastolicElement stringValue]];
        [alertLevel setHdiastolic:[hdiastolicElement stringValue]];
        
        [alertLevel setBp_lheartrate:[bp_lheartrateElement stringValue]];
        [alertLevel setBp_hheartrate:[bp_hheartrateELement stringValue]];
        [alertLevel setEcg_lheartrate:[ecg_lheartrateElement stringValue]];
        [alertLevel setEcg_hheartrate:[ecg_hheartrateElement stringValue]];

        [alertLevel setLbg:[lbgElement stringValue]];
        [alertLevel setHbg:[hbgELement stringValue]];
        [alertLevel setLbg_b:[lbg_bElement stringValue]];
        [alertLevel setHbg_b:[hbg_bElement stringValue]];
        [alertLevel setLbg_a:[lbg_aElement stringValue]];
        [alertLevel setHbg_a:[hbg_aELement stringValue]];
        [alertLevel setLsteps:[lstepsElement stringValue]];
        [alertLevel setHbmi:[hbmiElement stringValue]];
        
        [[NSUserDefaults standardUserDefaults] setObject:[alertLevel getDictionaryFromAlertLevel] forKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
	}

}


+ (NSData *)getHistoryRecord{

    if ([GlobalVariables shareInstance].session_id!=nil){
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthAlertLevel?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"get alertlevel sending url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
            NSLog(@"Get alertlevel History error!");
        } else {
            return xmlData;
        }
    }
    return nil;
}

+ (void)sendResult:(AlertLevel *)alertLevelRecord setUpdateType:(NSString *)updateType{

    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthAlertLevel?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            stringByAppendingString:@"&action=U&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
 
    if ([updateType isEqualToString:@"BP"]) {
        url_string = [url_string stringByAppendingString:@"&lsystolic="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord lsystolic]];
        url_string = [url_string stringByAppendingString:@"&hsystolic="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord hsystolic]];
        url_string = [url_string stringByAppendingString:@"&ldiastolic="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord ldiastolic]];
        url_string = [url_string stringByAppendingString:@"&hdiastolic="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord hdiastolic]];
    }else if([updateType isEqualToString:@"BG"]){
        url_string = [url_string stringByAppendingString:@"&lbg="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord lbg]];
        url_string = [url_string stringByAppendingString:@"&hbg="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord hbg]];
        url_string = [url_string stringByAppendingString:@"&lbg_b="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord lbg_b]];
        url_string = [url_string stringByAppendingString:@"&hbg_b="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord hbg_b]];
        url_string = [url_string stringByAppendingString:@"&lbg_a="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord lbg_a]];
        url_string = [url_string stringByAppendingString:@"&hbg_a="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord hbg_a]];
    }
    else if ([updateType isEqualToString:@"HR"])
    {
        url_string = [url_string stringByAppendingString:@"&bp_lheartrate="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord bp_lheartrate]];
        url_string = [url_string stringByAppendingString:@"&bp_hheartrate="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord bp_hheartrate]];
        url_string = [url_string stringByAppendingString:@"&ecg_lheartrate="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord ecg_lheartrate]];
        url_string = [url_string stringByAppendingString:@"&ecg_lheartrate="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord ecg_hheartrate]];
    }
    else if ([updateType isEqualToString:@"BMI"])
    {
        url_string = [url_string stringByAppendingString:@"&hbmi="];
        url_string = [url_string stringByAppendingString:[alertLevelRecord hbmi]];
    }

    
    
    NSURL *request_url = [NSURL URLWithString:url_string];
	NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    if ((xmlData == nil) || [syncUtility XMLHasError:xmlData]){
        
    }else{
        
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"is upload AlertLevel record succ:%d",isSucc);
        if (isSucc==1){
            //set to userdefault
            [[NSUserDefaults standardUserDefaults] setObject:[alertLevelRecord getDictionaryFromAlertLevel] forKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
        }
        else{
            
            NSLog(@"catch the error");
        }

        
    }


}


@end
