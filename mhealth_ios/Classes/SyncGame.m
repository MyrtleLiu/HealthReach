//
//  SyncGame.m
//  mHealth
//
//  Created by smartone_sn on 15-1-14.
//
//

#import "SyncGame.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "syncUtility.h"
#import "DBHelper.h"
#import "GDataXMLNode.h"


@implementation SyncGame


+ (void)startGame:(NSString*)name recordId:(NSString *)type{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=S"];
        urlStr = [urlStr stringByAppendingString:@"&game=WalkPlant"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        
        urlStr = [urlStr stringByAppendingString:@"&plant_name="];
        urlStr = [urlStr stringByAppendingString:name];
        urlStr = [urlStr stringByAppendingString:@"&plant_type="];
        urlStr = [urlStr stringByAppendingString:type];
        
        
        
        
        urlStr=[urlStr  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        NSURL *request_url = [NSURL URLWithString:urlStr];
        
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            NSLog(@"add succ:%d",isSucc);
            
            if (isSucc==1){
                
                
                
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
    }
    
}

+ (GameObject *)getPlantProgress{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RP"];
        urlStr = [urlStr stringByAppendingString:@"&game=WalkPlant"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"game........................ url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *startFlag = @"//response";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:startFlag error:nil];
                
                
                GameObject *result=[[GameObject alloc] init];
                
                for (DDXMLElement *obj in responseArray){
                    
                    DDXMLElement *progress = [obj elementForName:@"progress"];
                    DDXMLElement *type = [obj elementForName:@"type"];
                    DDXMLElement *name = [obj elementForName:@"name"];
                    
                    result.progress=[progress stringValue];
                    result.gameType=GAME_TYPE_PLANT;
                    result.plantName=[name stringValue];
                    result.plantType=[type stringValue];
                    result.status=@"0";
                    NSLog(@"result.progress in safari=%@",result.progress);
                    
                }
                
                [DBHelper addPlant:result];
                NSLog(@"getPlantProgress=%@",result);
                return result;
                
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
    }
    
    return nil;
    
}
+ (GameObject *)getTrophyProgress{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RP"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingTrophy"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                
                
                GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                GDataXMLElement *rootElement = [doc rootElement];
                
                GDataXMLElement *progressElement = [[rootElement elementsForName:@"progress"] objectAtIndex:0];
                GDataXMLElement *typeElement = [[rootElement elementsForName:@"type"] objectAtIndex:0];
                GDataXMLElement *nameElement = [[rootElement elementsForName:@"name"] objectAtIndex:0];

                
                if([progressElement stringValue]!=nil){
                    GameObject *gameObj=[[GameObject alloc] init];

                    gameObj.progress=[progressElement stringValue];
                    gameObj.gameType=GAME_TYPE_TROPHY;
                    gameObj.plantType=[typeElement stringValue];
                    gameObj.plantName=[nameElement stringValue];
                    gameObj.status=@"0";
                    
                    [DBHelper addPlant:gameObj];
                    return gameObj;
                    
                }
            }
            
        }
    }
    
    return nil;
}
//chick C
+(BOOL)checkPlantProgress:(NSString*)duration steps:(NSString*)thesteps{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 111166666");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=C"];
        urlStr = [urlStr stringByAppendingString:@"&game=WalkPlant"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        
        urlStr = [urlStr stringByAppendingString:@"&duration="];
        urlStr = [urlStr stringByAppendingString:duration];
        
        
        urlStr = [urlStr stringByAppendingString:@"&steps="];
        urlStr = [urlStr stringByAppendingString:thesteps];
        
        
        
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==true){
                
                GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                GDataXMLElement *rootElement = [doc rootElement];
                
                GDataXMLElement *isOKElement = [[rootElement elementsForName:@"is_ok"] objectAtIndex:0];
                if([isOKElement stringValue]!=nil){
                    if([[isOKElement stringValue] isEqualToString:@"1"]){
                        return true;
                    }
                }

            }
            
        }
    }
    
    return false;
}
//road CW Plant
+(BOOL)syncPlantList{
    NSLog(@"ROAD CW PLANT");
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R"];
        urlStr = [urlStr stringByAppendingString:@"&game=WalkPlant"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        
        
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *plantFlag = @"//plant";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:plantFlag error:nil];
                
                for (DDXMLElement *obj in responseArray){
                    
                    GameObject *game=[[GameObject alloc] init];
                    
                    DDXMLElement *name = [obj elementForName:@"name"];
                    DDXMLElement *type = [obj elementForName:@"type"];
                    
                    DDXMLElement *starttime = [obj elementForName:@"start"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *start_date_string = [dateFormatter dateFromString:starttime.stringValue];
                    long long start_date_long=[start_date_string timeIntervalSince1970];
                    
                    DDXMLElement *endtime = [obj elementForName:@"end"];
                    
                    
                    
                    NSDate *end_date_string = [dateFormatter dateFromString:endtime.stringValue];
                    long long end_date_long=[end_date_string timeIntervalSince1970];
                    
                    DDXMLElement *distance=[obj elementForName:@"distance"];
                    DDXMLElement *steps=[obj elementForName:@"steps"];
                    DDXMLElement *calories=[obj elementForName:@"calories"];
                    DDXMLElement *fb_key=[obj elementForName:@"fb_key"];
                    
                    
                    game.gameType=GAME_TYPE_PLANT;
                    game.plantType=[type stringValue];
                    game.plantName=[name stringValue];
                    [game setStartDate:start_date_long];
                    [game setEndDate:end_date_long];
                    game.status=@"1";
                    game.distance=[distance stringValue];
                    game.steps=[steps stringValue];
                    game.calories=[calories stringValue];
                    game.fb_key=[fb_key stringValue];
                    NSLog(@"game.distance=%@   game.steps=%@  game.calories=%@  game.fb_key=%@",game.distance,game.steps,game.calories,game.fb_key);
                    
                    [DBHelper addPlant:game];
                    
                }
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
    }
    return true;
    
}

//road TP
+(BOOL)syncTrophyList{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingTrophy"];
        
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        
        
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *trophyFlag = @"//trophy";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:trophyFlag error:nil];
                
                for (DDXMLElement *obj in responseArray){
                    
                    
                    GameObject *game=[[GameObject alloc] init];
                    
                    
                    DDXMLElement *starttime = [obj elementForName:@"start"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *start_date_string = [dateFormatter dateFromString:starttime.stringValue];
                    long long start_date_long=[start_date_string timeIntervalSince1970];
                    
                    DDXMLElement *endtime = [obj elementForName:@"end"];
                    DDXMLElement *distance=[obj elementForName:@"distance"];
                    DDXMLElement *steps=[obj elementForName:@"steps"];
                    DDXMLElement *calories=[obj elementForName:@"calories"];
                    DDXMLElement *fb_key=[obj elementForName:@"fb_key"];
                    
                    NSDate *end_date_string = [dateFormatter dateFromString:endtime.stringValue];
                    long long  end_date_long=[end_date_string timeIntervalSince1970];
                    
                    game.gameType=GAME_TYPE_TROPHY;
                    game.status=@"1";
                    game.distance=[distance stringValue];
                    game.steps=[steps stringValue];
                    game.calories=[calories stringValue];
                    game.fb_key=[fb_key stringValue];
                    
                    [game setStartDate:start_date_long];
                    [game setEndDate:end_date_long];
                    
                    
                    [DBHelper addPlant:game];
                    
                }
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
    }
    return true;
}

+(BOOL)syncDiamondList{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *
        urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R"];
        urlStr = [urlStr stringByAppendingString:@"&medal_type=Diamond"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingMedal"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL * request_url = [NSURL URLWithString:urlStr];
        NSData* xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *trophyFlag = @"//medal";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:trophyFlag error:nil];
                
                for (DDXMLElement *obj in responseArray){
                    
                    
                    GameObject *game=[[GameObject alloc] init];
                    
                    
                    DDXMLElement *starttime = [obj elementForName:@"start"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *start_date_string = [dateFormatter dateFromString:starttime.stringValue];
                    long long start_date_long=[start_date_string timeIntervalSince1970];
                    
                    DDXMLElement *endtime = [obj elementForName:@"end"];
                    DDXMLElement *distance=[obj elementForName:@"distance"];
                    DDXMLElement *steps=[obj elementForName:@"steps"];
                    DDXMLElement *calories=[obj elementForName:@"calories"];
                    
                    
                    NSDate *end_date_string = [dateFormatter dateFromString:endtime.stringValue];
                    long long  end_date_long=[end_date_string timeIntervalSince1970];
                    
                    game.gameType=@"TrainingDiamond";
                    game.status=@"1";
                    game.distance=[distance stringValue];
                    game.steps=[steps stringValue];
                    game.calories=[calories stringValue];
                    
                    
                    [game setStartDate:start_date_long];
                    [game setEndDate:end_date_long];
                    
                    
                    [DBHelper addPlant:game];
                    
                }
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
    }
    return true;
}

+(BOOL)syncGoldList{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *
        urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R"];
        urlStr = [urlStr stringByAppendingString:@"&medal_type=Gold"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingMedal"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL * request_url = [NSURL URLWithString:urlStr];
        NSData* xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *trophyFlag = @"//medal";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:trophyFlag error:nil];
                
                for (DDXMLElement *obj in responseArray){
                    
                    
                    GameObject *game=[[GameObject alloc] init];
                    
                    
                    DDXMLElement *starttime = [obj elementForName:@"start"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *start_date_string = [dateFormatter dateFromString:starttime.stringValue];
                    long long start_date_long=[start_date_string timeIntervalSince1970];
                    
                    DDXMLElement *endtime = [obj elementForName:@"end"];
                    DDXMLElement *distance=[obj elementForName:@"distance"];
                    DDXMLElement *steps=[obj elementForName:@"steps"];
                    DDXMLElement *calories=[obj elementForName:@"calories"];
                    
                    
                    NSDate *end_date_string = [dateFormatter dateFromString:endtime.stringValue];
                    long long  end_date_long=[end_date_string timeIntervalSince1970];
                    
                    game.gameType=@"TrainingGold";
                    game.status=@"1";
                    game.distance=[distance stringValue];
                    game.steps=[steps stringValue];
                    game.calories=[calories stringValue];
                    
                    
                    [game setStartDate:start_date_long];
                    [game setEndDate:end_date_long];
                    
                    
                    [DBHelper addPlant:game];
                    
                }
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
    }
    return true;
}

+(BOOL)syncSilverList{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *
        urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R"];
        urlStr = [urlStr stringByAppendingString:@"&medal_type=Silver"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingMedal"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL * request_url = [NSURL URLWithString:urlStr];
        NSData* xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *trophyFlag = @"//medal";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:trophyFlag error:nil];
                
                for (DDXMLElement *obj in responseArray){
                    
                    
                    GameObject *game=[[GameObject alloc] init];
                    
                    
                    DDXMLElement *starttime = [obj elementForName:@"start"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *start_date_string = [dateFormatter dateFromString:starttime.stringValue];
                    long long start_date_long=[start_date_string timeIntervalSince1970];
                    
                    DDXMLElement *endtime = [obj elementForName:@"end"];
                    DDXMLElement *distance=[obj elementForName:@"distance"];
                    DDXMLElement *steps=[obj elementForName:@"steps"];
                    DDXMLElement *calories=[obj elementForName:@"calories"];
                    
                    
                    NSDate *end_date_string = [dateFormatter dateFromString:endtime.stringValue];
                    long long  end_date_long=[end_date_string timeIntervalSince1970];
                    
                    game.gameType=@"TrainingSilver";
                    game.status=@"1";
                    game.distance=[distance stringValue];
                    game.steps=[steps stringValue];
                    game.calories=[calories stringValue];
                    
                    
                    [game setStartDate:start_date_long];
                    [game setEndDate:end_date_long];
                    
                    
                    [DBHelper addPlant:game];
                    
                }
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
    }
    return true;
}

+(BOOL)syncBronzeList{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        NSLog(@"check if it run 1111");
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *
        urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=R"];
        urlStr = [urlStr stringByAppendingString:@"&medal_type=Bronze"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingMedal"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL * request_url = [NSURL URLWithString:urlStr];
        NSData* xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *trophyFlag = @"//medal";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:trophyFlag error:nil];
                
                for (DDXMLElement *obj in responseArray){
                    
                    
                    GameObject *game=[[GameObject alloc] init];
                    
                    
                    DDXMLElement *starttime = [obj elementForName:@"start"];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    NSDate *start_date_string = [dateFormatter dateFromString:starttime.stringValue];
                    long long start_date_long=[start_date_string timeIntervalSince1970];
                    
                    NSLog(@"start_date_string=%@",start_date_string);
                    NSLog(@"start_date_long=%lld",start_date_long);
                    
                    DDXMLElement *endtime = [obj elementForName:@"end"];
                    DDXMLElement *distance=[obj elementForName:@"distance"];
                    DDXMLElement *steps=[obj elementForName:@"steps"];
                    DDXMLElement *calories=[obj elementForName:@"calories"];
                    
                    
                    NSDate *end_date_string = [dateFormatter dateFromString:endtime.stringValue];
                    
                    
                    long long  end_date_long=[end_date_string timeIntervalSince1970];
                    
                    game.gameType=@"TrainingBronze";
                    game.status=@"1";
                    game.distance=[distance stringValue];
                    game.steps=[steps stringValue];
                    game.calories=[calories stringValue];
                    
                    
                    [game setStartDate:start_date_long];
                    
                    [game setEndDate:end_date_long];
                    
                    
                    [DBHelper addPlant:game];
                    NSLog(@"++++++++++++BRONZE");
                }
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
    }
    return true;
}




+(BOOL)isShowTrophyTryNow{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *trophy=[defaults objectForKey:[NSString stringWithFormat:@"is_trophy_started_%@",[GlobalVariables shareInstance].login_id]];
    
    
    if (trophy!=nil&&![trophy isEqualToString:@""]) {
        
        if ([trophy isEqualToString:@"1"]) {
            
            return true;
        }
        
    }
    
    return  false;
    
    
}
+(BOOL)isShowPlantTryNow{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *trophy=[defaults objectForKey:[NSString stringWithFormat:@"is_walk_plant_started_%@",[GlobalVariables shareInstance].login_id]];
    
    
    
    if (trophy!=nil&&![trophy isEqualToString:@""]) {
        
        if ([trophy isEqualToString:@"1"]) {
            
            return true;
        }
        
        
    }
    
    return  false;
    
}

+ (void)updateTrophyTryNow{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        
        
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *url_string = [[NSString alloc]init];
        url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
        url_string = [url_string stringByAppendingString:@"healthUser?login="];
        url_string = [url_string stringByAppendingString:login_id];
        url_string = [url_string stringByAppendingString:@"&sessionid="];
        url_string = [url_string stringByAppendingString:session_id];
        
        url_string = [url_string stringByAppendingString:@"&action=U"];
        
        
        
        
        url_string = [url_string stringByAppendingString:@"&is_trophy_started=1"];
        
        
        
        
        NSLog(@"Update personal info weight:%@",url_string);
        NSURL *request_url = [NSURL URLWithString:url_string];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if (xmlData){
            int haserror = [syncUtility XMLHasError:xmlData];
            NSLog(@"is upload user infomation succ:%d",haserror);
            
            if (!haserror) {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                
                [defaults setObject: @"1" forKey: [NSString stringWithFormat:@"is_trophy_started_%@",[GlobalVariables shareInstance].login_id]];
                
                [defaults synchronize];
            }else{
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                
                [defaults setObject: @"0" forKey: [NSString stringWithFormat:@"is_trophy_started_%@",[GlobalVariables shareInstance].login_id]];
                
                [defaults synchronize];
                
            }
            
        }
    }
    
    
}
+ (void)updatePlantTryNow{
    NSLog(@"----------------------updatePlantTryNow");
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *url_string = [[NSString alloc]init];
        url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
        url_string = [url_string stringByAppendingString:@"healthUser?login="];
        url_string = [url_string stringByAppendingString:login_id];
        url_string = [url_string stringByAppendingString:@"&sessionid="];
        url_string = [url_string stringByAppendingString:session_id];
        
        url_string = [url_string stringByAppendingString:@"&action=U"];
        
        
        
        url_string = [url_string stringByAppendingString:@"&is_walk_plant_started=1"];
        
        
        
        
        NSLog(@"Update personal info weight:%@",url_string);
        NSURL *request_url = [NSURL URLWithString:url_string];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if (xmlData){
            int haserror = [syncUtility XMLHasError:xmlData];
            NSLog(@"is upload user infomation succ:%d",haserror);
            
            if (!haserror) {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                
                [defaults setObject: @"1" forKey: [NSString stringWithFormat:@"is_walk_plant_started_%@",[GlobalVariables shareInstance].login_id]];
                
                [defaults synchronize];
            }else{
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                
                [defaults setObject: @"0" forKey: [NSString stringWithFormat:@"is_walk_plant_started_%@",[GlobalVariables shareInstance].login_id]];
                
                [defaults synchronize];
                
            }
            
        }
    }
    
    
}

+ (BOOL)getMedal{
    
    if ([GlobalVariables shareInstance].session_id!=nil){
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RP"];
        urlStr = [urlStr stringByAppendingString:@"&medal_type=Bronze"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingMedal"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        NSURL *request_url = [NSURL URLWithString:urlStr];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *startFlag = @"//response";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:startFlag error:nil];
                
                
                GameObject *result=[[GameObject alloc] init];
                
                for (DDXMLElement *obj in responseArray){
                    
                    DDXMLElement *progress = [obj elementForName:@"progress"];
                    
                    result.progress=[progress stringValue];
                    NSLog(@" result.progress==%@", result.progress);
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    
                    [defaults setObject: progress.stringValue forKey: [NSString stringWithFormat:@"training_medal_bronze_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                    
                }
                
                
                
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
        
        urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RP"];
        urlStr = [urlStr stringByAppendingString:@"&medal_type=Silver"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingMedal"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        request_url = [NSURL URLWithString:urlStr];
        xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *startFlag = @"//response";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:startFlag error:nil];
                
                
                GameObject *result=[[GameObject alloc] init];
                
                for (DDXMLElement *obj in responseArray){
                    
                    DDXMLElement *progress = [obj elementForName:@"progress"];
                    
                    result.progress=[progress stringValue];
                    NSLog(@" result.progress==%@", result.progress);
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    
                    [defaults setObject: progress.stringValue forKey: [NSString stringWithFormat:@"training_medal_silver_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                    
                }
                
                
                
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
        urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RP"];
        urlStr = [urlStr stringByAppendingString:@"&medal_type=Gold"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingMedal"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        request_url = [NSURL URLWithString:urlStr];
        xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *startFlag = @"//response";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:startFlag error:nil];
                
                
                GameObject *result=[[GameObject alloc] init];
                
                for (DDXMLElement *obj in responseArray){
                    
                    DDXMLElement *progress = [obj elementForName:@"progress"];
                    
                    result.progress=[progress stringValue];
                    NSLog(@" result.progress==%@", result.progress);
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    
                    [defaults setObject: progress.stringValue forKey: [NSString stringWithFormat:@"training_medal_gold_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                    
                }
                
                
                
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
        urlStr = [[NSString alloc]init];
        urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
        urlStr = [urlStr stringByAppendingString:@"healthGame?login="];
        if (login_id)
            urlStr = [urlStr stringByAppendingString:login_id];
        urlStr = [urlStr stringByAppendingString:@"&action=RP"];
        urlStr = [urlStr stringByAppendingString:@"&medal_type=Diamond"];
        urlStr = [urlStr stringByAppendingString:@"&game=TrainingMedal"];
        urlStr = [urlStr stringByAppendingString:@"&sessionid="];
        if (session_id)
            urlStr = [urlStr stringByAppendingString:session_id];
        NSLog(@"rt url:%@",urlStr);
        request_url = [NSURL URLWithString:urlStr];
        xmlData = [NSData dataWithContentsOfURL:request_url];
        
        if (xmlData) {
            
            [syncUtility XMLHasError:xmlData];
            
            
            int isSucc = [Utility isSucc:xmlData];
            
            if (isSucc==1){
                
                static NSString *startFlag = @"//response";
                
                DDXMLDocument *doc = [[DDXMLDocument alloc]initWithData:xmlData options:0 error:nil];
                NSArray *responseArray = [doc nodesForXPath:startFlag error:nil];
                
                
                GameObject *result=[[GameObject alloc] init];
                
                for (DDXMLElement *obj in responseArray){
                    
                    DDXMLElement *progress = [obj elementForName:@"progress"];
                    
                    result.progress=[progress stringValue];
                    NSLog(@" result.progress==%@", result.progress);
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    
                    [defaults setObject: progress.stringValue forKey: [NSString stringWithFormat:@"training_medal_diamond_%@",[GlobalVariables shareInstance].login_id]];
                    
                    [defaults synchronize];
                    
                }
                
                
                
                
            }
            else{
                
                NSLog(@"add fail.");
                
            }
        }else{
            
            NSLog(@"result fail.");
        }
        
        
        
        
        
    }
    return true;
    
    
    
}


+ (NSString *)getMedalBronze{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"training_medal_bronze_%@",[GlobalVariables shareInstance].login_id]];
    
    
    return result;
    
    
}
+ (NSString *)getMedalSilver{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"training_medal_silver_%@",[GlobalVariables shareInstance].login_id]];
    
    
    return result;
    
}
+ (NSString *)getMedalGold{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"training_medal_gold_%@",[GlobalVariables shareInstance].login_id]];
    
    
    return result;
    
}
+ (NSString *)getMedalDiamond{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result=[defaults objectForKey:[NSString stringWithFormat:@"training_medal_diamond_%@",[GlobalVariables shareInstance].login_id]];
    
    
    return result;
}


+(void)trialCheckPlantProgress:(NSString*)duration steps:(NSString*)thesteps{
    
    
    NSString *urlStr = [[NSString alloc]init];
    
    urlStr = [urlStr stringByAppendingString:[Constants getAPIBase2]];
    
    urlStr = [urlStr stringByAppendingString:@"healthGame?stat_id="];
    
    urlStr = [urlStr stringByAppendingString:[Utility getUUID]];
    
    urlStr = [urlStr stringByAppendingString:@"&stat_network="];
    
    urlStr = [urlStr stringByAppendingString:[Utility getNetworkCode]];
    
    urlStr = [urlStr stringByAppendingString:@"&action=TC"];
    
    urlStr = [urlStr stringByAppendingString:@"&game=WalkPlant"];
    
    
    urlStr = [urlStr stringByAppendingString:@"&duration="];
    
    urlStr = [urlStr stringByAppendingString:duration];
    
    
    
    urlStr = [urlStr stringByAppendingString:@"&steps="];
    
    urlStr = [urlStr stringByAppendingString:thesteps];
    
    
    
    
    
    NSURL *request_url = [NSURL URLWithString:urlStr];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:request_url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               //NSString *xmlStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               
                               //NSLog(@"%@====================",xmlStr);
                               
                               
                               
                           }];
    
    
}

//+(BOOL)shareCW:(NSString*)fb_key
//{
//    NSString *contStr=[Constants getAPIBase1];
//
//
//   NSString* keyStr=[fb_key  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    NSString *urlStr=[[NSString alloc]initWithFormat:@"%@wmc/jsp/mhealth/fb_share.jsp?key=%@",contStr,keyStr];
//    NSURL *request_url = [NSURL URLWithString:urlStr];
//    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
//    NSLog(@"urlStr=%@",urlStr);
//    NSLog(@"request_url=%@",request_url);
//      NSLog(@"xmlData=%@",xmlData);
//    if (xmlData) {
//
//        return YES;
//    }
//    else
//       return NO;
//}
+(NSString *)shareFristTimethePlantName:(NSString*)plantName theType:(NSString*)type theSteps:(NSString*)steps thecalories:(NSString*)calories theDistance:(NSString *)distance
{
    __block NSString *fbkey=[[NSString alloc]init];
    NSString *contStr=[Constants getAPIBase1];
    
    
    NSString* plantNameStr=[plantName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *urlStr=[[NSString alloc]initWithFormat:@"%@wmc/servlet/healthGame?action=TFB&game=WalkPlant&plant_name=%@&plant_type=%@&steps=%@&calories=%@&distance=%@",contStr,plantNameStr,type,steps,calories,distance];
    
    NSURL *request_url = [NSURL URLWithString:urlStr];
    NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    
    
    
    if (xmlData) {
        
        
        [syncUtility XMLHasError:xmlData];
        
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"add walking record dddddd:%d",isSucc);
        if (isSucc==1)
        {
            
            
            fbkey=[syncUtility getAddWalkingRecordShareKey:xmlData];
            NSLog(@"fb____key==%@",fbkey);
            return fbkey;
            
        }
    }
    return fbkey;
    
}

@end
