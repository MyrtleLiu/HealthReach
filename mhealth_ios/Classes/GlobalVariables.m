//
//  GlobalVariables.m
//  mHealth
//
//  Created by gz dev team on 14年1月21日.
//
//

#import "GlobalVariables.h"

@implementation GlobalVariables

@synthesize viewId;
@synthesize session_id;
@synthesize login_id;

@synthesize caloriesTotal;

@synthesize foodHistoryDict;

@synthesize BPAlreadySync;
@synthesize BGAlreadySync;
@synthesize WeightAlreadySync;
@synthesize CaloriesAlreadySync;





@synthesize distanceGlo;
@synthesize stepseGlo;
@synthesize paceGlo;
@synthesize caleGlo;
@synthesize targetGlo;
@synthesize timeeGlo;
@synthesize running;


@synthesize touchTime;





static GlobalVariables *_instance = nil;

+(GlobalVariables *)shareInstance{
    if (_instance==nil){
        _instance=[[super alloc]init];
    }
    return _instance;
}

-(id)init{
    if (self =[super init]){
        touchTime = [[NSDate date] timeIntervalSince1970];
//        NSLog(@"touch time is %ld",currentDate);
    }
    return self;
}
@end
