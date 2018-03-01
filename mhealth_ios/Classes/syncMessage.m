//
//  syncMessage.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-8.
//
//

#import "syncMessage.h"
#import "syncUtility.h"
#import "GDataXMLNode.h"
@implementation syncMessage

+ (NSMutableArray *)getAllMessageRecord{
    NSLog(@"check if it run : %@",[GlobalVariables shareInstance].session_id );
    
    NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
//        [DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthMessage?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R"];
        urlStr = [urlStr stringByAppendingString:@"&type=Message"];

        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            NSLog(@"come to 1");

            
            [syncUtility XMLHasError:xmlData];
            
            NSLog(@"come to 1");

            
            static NSString *trainingsFlag = @"messages";
            static NSString *trainingFlag = @"message";

            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
            GDataXMLElement *rootElement=[doc rootElement];
            NSArray *MessageRecord = [rootElement elementsForName:trainingsFlag];
            
          
            
            for (GDataXMLElement *obj in MessageRecord) {
                
                NSArray *records = [obj elementsForName:trainingFlag];
                
                for (GDataXMLElement *trainRecord in records){
                    
                    
                    GDataXMLElement *messageid = [[trainRecord elementsForName:@"messageid"]objectAtIndex:0];
                    GDataXMLElement *is_read = [[trainRecord elementsForName:@"is_read"]objectAtIndex:0];
                    GDataXMLElement *send_time = [[trainRecord elementsForName:@"send_time"]objectAtIndex:0];
                    GDataXMLElement *ensummary = [[trainRecord elementsForName:@"ensummary"]objectAtIndex:0];
                    GDataXMLElement *zhsummary = [[trainRecord elementsForName:@"zhsummary"]objectAtIndex:0];
                    GDataXMLElement *enicon = [[trainRecord elementsForName:@"enicon"]objectAtIndex:0];
                    GDataXMLElement *zhicon = [[trainRecord elementsForName:@"zhicon"]objectAtIndex:0];
                    
                    MessageObject *result=[[MessageObject alloc] initWithMessageid:messageid.stringValue is_read:is_read.stringValue send_time:send_time.stringValue ensummary:ensummary.stringValue zhsummary:zhsummary.stringValue enicon:[enicon stringValue] zhicon:[zhicon stringValue] ];
                   
                    
                    
                    [DBHelper addMessageRecordToDB:result];
                    
                    
                    [resultArrary addObject :result];
                    
                    
                }
                
                
            }
            for(int i=0;i<resultArrary.count;i++){
                MessageObject *test= [resultArrary objectAtIndex: i];
                NSLog(@"messageid: %@",test.messageid);
                NSLog(@"is_read: %@",test.is_read);
                NSLog(@"ensummary: %@",test.ensummary);
                NSLog(@"zhsummary: %@",test.zhsummary);
                NSLog(@"send_time: %@",test.send_time);
                NSLog(@"enicon: %@",test.enicon);
                NSLog(@"zhicon: %@",test.zhicon);

            }

        }
    }
    
    
    return resultArrary;
}


















+ (BOOL)getActionMessageRecord :(NSString * )action :(NSString * )messageid{
    NSLog(@"check if it run : %@",[GlobalVariables shareInstance].session_id );
    if ([GlobalVariables shareInstance].session_id!=nil){
        //        [DBHelper delNoIdRecord];
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthMessage?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action="];
        if(action)
            urlStr = [urlStr stringByAppendingString:action];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        urlStr = [urlStr stringByAppendingString:@"&messageid="];
        if (messageid)
            urlStr = [urlStr stringByAppendingString:messageid];

        NSLog(@"rt url:%@",urlStr);
        
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"is upload AlertLevel record succ:%d",isSucc);
        if (isSucc==1){
            NSLog(@"catch the Succ");

        }
        else{
            
            NSLog(@"catch the error");
        }

        
        if (xmlData) {
            [syncUtility XMLHasError:xmlData];
            
            
            static NSString *messagesFlag = @"messages";
            static NSString *messageFlag = @"message";

            
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
            GDataXMLElement *rootElement=[doc rootElement];
            NSArray *MessageRecord = [rootElement elementsForName:messagesFlag];
            
            
            
            for (GDataXMLElement *obj in MessageRecord) {
                
                NSArray *records = [obj elementsForName:messageFlag];
                
                for (GDataXMLElement *messageRecord in records){
                    
                    
                    GDataXMLElement *messageid = [[messageRecord elementsForName:@"messageid"]objectAtIndex:0];
                    GDataXMLElement *is_read = [[messageRecord elementsForName:@"is_read"]objectAtIndex:0];
                    GDataXMLElement *send_time = [[messageRecord elementsForName:@"send_time"]objectAtIndex:0];
                    GDataXMLElement *ensummary = [[messageRecord elementsForName:@"ensummary"]objectAtIndex:0];
                    GDataXMLElement *zhsummary = [[messageRecord elementsForName:@"zhsummary"]objectAtIndex:0];
                    GDataXMLElement *enicon = [[messageRecord elementsForName:@"enicon"]objectAtIndex:0];
                    GDataXMLElement *zhicon = [[messageRecord elementsForName:@"zhicon"]objectAtIndex:0];
                    
                    MessageObject *result=[[MessageObject alloc] initWithMessageid:messageid.stringValue is_read:is_read.stringValue send_time:send_time.stringValue ensummary:ensummary.stringValue zhsummary:zhsummary.stringValue enicon:enicon.stringValue zhicon:zhicon.stringValue ];
                    NSLog(@"messageid: %@",result.messageid);
                    NSLog(@"is_read: %@",result.is_read);
                    NSLog(@"ensummary: %@",result.ensummary);
                    NSLog(@"zhsummary: %@",result.zhsummary);
                    NSLog(@"send_time: %@",result.send_time);
                    NSLog(@"enicon: %@",result.enicon);
                    NSLog(@"zhicon: %@",result.zhicon);
                    
                    
                    
                    [DBHelper addMessageRecordToDB:result];
                    
                    
                }
                
                
            }
            
        }
    }
    
    return true;

}



+ (BOOL )deleteMessageRecord :(NSString * )messageid{
    {
        NSLog(@"check if it run : %@",[GlobalVariables shareInstance].session_id );
        if ([GlobalVariables shareInstance].session_id!=nil){
            //        [DBHelper delNoIdRecord];
            
            NSString *session_id = [GlobalVariables shareInstance].session_id;
            NSString *login_id = [GlobalVariables shareInstance].login_id;
            NSString *urlStr = [[NSString alloc]init];
            urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
            urlStr = [urlStr stringByAppendingString:@"healthMessage?login="];
            if (login_id)
                urlStr = [urlStr stringByAppendingString:login_id];
            urlStr = [urlStr stringByAppendingString:@"&action=D"];
            urlStr = [urlStr stringByAppendingString:@"&sessionid="];
            if (session_id)
                urlStr = [urlStr stringByAppendingString:session_id];
            urlStr = [urlStr stringByAppendingString:@"&messageid="];
            if (messageid)
                urlStr = [urlStr stringByAppendingString:messageid];
            
            NSLog(@"rt url:%@",urlStr);
            
            NSURL *request_url = [NSURL URLWithString:urlStr];
            NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
            
            int isSucc = [Utility isSucc:xmlData];
            NSLog(@"is upload AlertLevel record succ:%d",isSucc);
            if (isSucc==1){
                NSLog(@"delete succ");
                [DBHelper deleteMessageRecordFromDB:messageid];
            }
            else{
                
                NSLog(@"catch the error");
            }

        }
        
    }
    
    
    
    return true;

}





+ (NSMutableArray *)getAllNewsRecord{
    
    NSMutableArray *resultArrary;
    resultArrary=[[NSMutableArray alloc] init];
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthMessage?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R"];
        urlStr = [urlStr stringByAppendingString:@"&type=News"];
        
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        
        
        
        
        
        if (xmlData) {
            
            
            
            [syncUtility XMLHasError:xmlData];
            
            
            
            static NSString *messagessFlag = @"messages";
            static NSString *messageFlag = @"message";
            
            
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
            
            GDataXMLElement *rootElement=[doc rootElement];
            
            NSArray *MessageRecord = [rootElement nodesForXPath:messagessFlag error:nil];
            
            
            for (GDataXMLElement *obj in MessageRecord) {
                
                NSArray *records = [obj elementsForName:messageFlag];
                
                for (GDataXMLElement *trainRecord in records){
                    
                    
                    GDataXMLElement *messageid = [[trainRecord elementsForName:@"messageid"]objectAtIndex:0];
                    GDataXMLElement *is_read = [[trainRecord elementsForName:@"is_read"]objectAtIndex:0];
                    GDataXMLElement *send_time = [[trainRecord elementsForName:@"send_time"]objectAtIndex:0];
                    GDataXMLElement *ensummary = [[trainRecord elementsForName:@"ensummary"]objectAtIndex:0];
                    GDataXMLElement *zhsummary = [[trainRecord elementsForName:@"zhsummary"]objectAtIndex:0];
                    GDataXMLElement *enicon = [[trainRecord elementsForName:@"enicon"]objectAtIndex:0];
                    GDataXMLElement *zhicon = [[trainRecord elementsForName:@"zhicon"]objectAtIndex:0];
                    
                    
                    
                    
                    NSString *eniconStr=[enicon stringValue];
                    NSString *zhiconStr=[zhicon stringValue];
                    
                    if(eniconStr==NULL||[eniconStr isEqualToString:@"null"]||[eniconStr isEqualToString:@"NULL"]){
                        eniconStr=@"";
                    }
                    if(zhiconStr==NULL||[zhiconStr isEqualToString:@"null"]||[zhiconStr isEqualToString:@"NULL"]){
                        zhiconStr=@"";
                    }
                    

                    
                    
                    MessageObject *result=[[MessageObject alloc] initWithMessageid:messageid.stringValue is_read:is_read.stringValue send_time:send_time.stringValue ensummary:ensummary.stringValue zhsummary:zhsummary.stringValue enicon:eniconStr zhicon:zhiconStr ];
                    
                    
                    
                    
                    
                    
                    Boolean addDB_Result=[DBHelper addNewsRecordToDB:result];
                    
                    
                    NSLog(@"Test News addDB result:%d",addDB_Result);
                    
                }
                
                
            }
            
        }
    }
    
    
    return resultArrary;
}





@end
