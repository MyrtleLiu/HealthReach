//
//  WalkingRecord.m
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "WalkingRecord.h"
#import "NSString+Utils.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation WalkingRecord

@synthesize steps,distance,calsburnt,pace,trainid,gps,route,recordid,result,timeStr,persistimeStr,plannedRoutePoints,trackPoints,target,foodlistid;


- (void)setType:(int)thetype{
    
    type=thetype;
}

- (NSInteger)getType{
    
    return type;
}
//1
-(void)setPlannedRoutePoints{
    if (self.plannedRoutePoints==nil) {
        if(self.route==nil||[self.route isEqualToString:@""]){
        }
        else{
            self.plannedRoutePoints=[[NSMutableArray alloc] init];
            // "|"
            NSArray *arrayTem1 = [self.route componentsSeparatedByString:@"|"];
            NSLog(@"arrayTem1.count:%lu",(unsigned long)arrayTem1.count);
            for(int i=0;i<arrayTem1.count-1;i++){
                NSLog(@"arrayTem1 get(i):%@",[arrayTem1 objectAtIndex:i]);
            }
            for(int i=0;i<arrayTem1.count-1;i++){
               NSString *strTem= [arrayTem1  objectAtIndex:i];
               NSArray *arrayTem2 = [strTem componentsSeparatedByString:@","];
                
                NSLog(@"arrayTem2_1 test:%@",[arrayTem2 objectAtIndex:0]);
                NSLog(@"arrayTem2_2 test:%@",[arrayTem2 objectAtIndex:1]);

                
                
                 CLLocation *location = [[CLLocation alloc] initWithLatitude:[[arrayTem2 objectAtIndex:1] floatValue] longitude:[[arrayTem2 objectAtIndex:0] floatValue]];
                [plannedRoutePoints addObject:[NSKeyedArchiver archivedDataWithRootObject:location]];
         
            }

        }
    }
}









-(void)setTrackPoints{
    if (self.trackPoints==nil) {
        if(self.gps==nil||[self.gps isEqualToString:@""]){
        }
        else{
            self.trackPoints=[[NSMutableArray alloc] init];
            // "|"
            NSArray *arrayTem1 = [self.gps componentsSeparatedByString:@"|"];
            NSLog(@"arrayTem1.count:%lu",(unsigned long)arrayTem1.count);
            for(int i=0;i<arrayTem1.count-1;i++){
                NSLog(@"arrayTem1 get(i):%@",[arrayTem1 objectAtIndex:i]);
            }
            for(int i=0;i<arrayTem1.count-1;i++){
                NSString *strTem= [arrayTem1  objectAtIndex:i];
                NSArray *arrayTem2 = [strTem componentsSeparatedByString:@","];
                
                NSLog(@"arrayTem2_1 test:%@",[arrayTem2 objectAtIndex:0]);
                NSLog(@"arrayTem2_2 test:%@",[arrayTem2 objectAtIndex:1]);
                
                
                
                CLLocation *location = [[CLLocation alloc] initWithLatitude:[[arrayTem2 objectAtIndex:1] floatValue] longitude:[[arrayTem2 objectAtIndex:0] floatValue]];
                [trackPoints addObject:[NSKeyedArchiver archivedDataWithRootObject:location]];
                
            }
            
        }
    }
}











- (void)setRecordtime:(long)thetime{
    
    recordtime=thetime;
}

- (long)getRecordtime{
    
    return recordtime;
}

- (void)setPersistime:(long)thepersistime{
    
    persistime=thepersistime;
}

- (long)getPersistime{
    
    return persistime;
}

- (NSString*)getTrackPointsString{
    
    
    NSString *resultString=@"";
    
    if (self.trackPoints) {
        
        
        for (int i=0; i<[self.trackPoints count]; i++) {
            
            
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.trackPoints objectAtIndex:i]];
            
            resultString=[NSString stringWithFormat:@"%@%f,%f|",resultString,location.coordinate.longitude,location.coordinate.latitude];
            
        }
        
        
    }
    
    NSLog(@"%@......track",resultString);
    
    return resultString;
}


- (NSString*)getPlanedPointsString{
    
    
    NSString *resultString=@"";
    
    if (self.plannedRoutePoints) {
        
        
        for (int i=0; i<[self.plannedRoutePoints count]; i++) {
            
            
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.plannedRoutePoints objectAtIndex:i]];
            
            resultString=[NSString stringWithFormat:@"%@%f,%f|",resultString,location.coordinate.longitude,location.coordinate.latitude];
            
        }
        
        
    }
    
    NSLog(@"%@......plannedRoutePoints",resultString);
    
    return resultString;
}

- (int)getMinutesTime{
    
    if (self.persistimeStr!=Nil&&![self.persistimeStr isEqualToString:@""]) {
        
        
        NSArray *timeSplit = [self.persistimeStr componentsSeparatedByString:@":"];
        
        if ([timeSplit count]==3) {
            
            NSString *timeHour=[timeSplit objectAtIndex:0];
            NSString *timeMinute=[timeSplit objectAtIndex:1];
            NSString *timeSecond=[timeSplit objectAtIndex:2];
            
            int resultMin=[timeHour intValue]*60+[timeMinute intValue]+[timeSecond intValue]/60>0?[timeHour intValue]*60+[timeMinute intValue]+[timeSecond intValue]/60:0;
            
            return resultMin;
            
        }else{
            
            return 0;
        }
        
    }else{
        
        return 0;
    }

}

- (id)initWithSteps:(NSString *)newsteps distance:(NSString *)newdistance calsburnt:(NSString *)newcalsburnt pace:(NSString *)newpace trainid:(NSString *)newtrainid gps:(NSString *)newgps route:(NSString *)newroute recordid:(NSString *)newrecordid result:(NSString *)newresult target:(NSString *)newtarget foodlist:(NSString *)newfoodlist persistimeStr:(NSString *)newpersistimeStr time:(long)newtime type:(NSInteger)newtype persistime:(NSInteger)newpersistime{
    
    
    if(self = [super init]){
        
		recordtime = newtime;
        type=newtype;
        persistime=newpersistime;
        
		self.steps  = newsteps;
        
        self.distance=newdistance;
        
        self.calsburnt=newcalsburnt;
        
        self.pace=newpace;
        
        self.trainid=newtrainid;
        
        self.gps=newgps;
        
        self.route=newroute;
        
        self.recordid=newrecordid;
        
        self.result=newresult;
        
        self.target=newtarget;
        
        self.foodlistid=newfoodlist;
        
        self.persistimeStr=newpersistimeStr;
        
        self.timeStr=[NSString formatTimeAgo:recordtime];
	}
    
	return self;
    
}

@end
