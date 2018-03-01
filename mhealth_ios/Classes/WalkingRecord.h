//
//  WalkingRecord.h
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import <Foundation/Foundation.h>

@interface WalkingRecord : NSObject{

    
    NSString *steps;
    NSString *distance;
    NSString *calsburnt;
    NSString *pace;
    
    NSString *trainid;
    NSString *foodlistid;
    
    NSString *gps;
    NSString *route;
    
    NSString *recordid;
    NSString *result;
    
    NSString *target;
    
    NSString *timeStr;
    NSString *persistimeStr;
    long persistime;
    long recordtime;
    
    NSInteger type; // 0 trains; 1 casual;

    NSMutableArray *plannedRoutePoints;
    NSMutableArray *trackPoints;
    
    
}

@property (strong, nonatomic) NSString *foodlistid;
@property (strong, nonatomic) NSString *target;
@property (strong, nonatomic) NSString *steps;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *calsburnt;
@property (strong, nonatomic) NSString *pace;
@property (strong, nonatomic) NSString *timeStr;
@property (strong, nonatomic) NSString *trainid;
@property (strong, nonatomic) NSString *gps;
@property (strong, nonatomic) NSString *route;
@property (strong, nonatomic) NSString *recordid;
@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSString *persistimeStr;
@property(nonatomic, strong) NSArray *plannedRoutePoints;
@property(nonatomic, strong) NSArray *trackPoints;



- (void)setType:(int)thetype;

- (NSInteger)getType;

- (void)setRecordtime:(long)thetime;

- (long)getRecordtime;

- (void)setPersistime:(long)thepersistime;

- (long)getPersistime;

- (int)getMinutesTime;

-(void)setPlannedRoutePoints;
-(void)setTrackPoints;

//- (int)getPersisTime;
- (NSString*)getTrackPointsString;

- (NSString*)getPlanedPointsString;


- (id)initWithSteps:(NSString *)newsteps distance:(NSString *)newdistance calsburnt:(NSString *)newcalsburnt pace:(NSString *)newpace trainid:(NSString *)newtrainid gps:(NSString *)newgps route:(NSString *)newroute recordid:(NSString *)newrecordid result:(NSString *)newresult target:(NSString *)newtarget foodlist:(NSString *)newfoodlist persistimeStr:(NSString *)newpersistimeStr time:(long)newtime type:(NSInteger)newtype persistime:(NSInteger)newpersistime;

@end
