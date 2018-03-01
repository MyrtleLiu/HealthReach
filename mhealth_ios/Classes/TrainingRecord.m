//
//  TrainingRecord.m
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "TrainingRecord.h"
#import "NSString+Utils.h"

@implementation TrainingRecord

@synthesize trainid,result,walkingRecords,timeStr;


- (void)setLevel:(NSInteger)thelevel{
    
    level=thelevel;
}

- (NSInteger)getLevel{
    
    return level;
}

- (void)setRecordtime:(long)thetime{
    
    recordtime=thetime;
    
    
    self.timeStr=[NSString formatTimeAgo:recordtime];
    
    //NSLog(@"%@...............",self.timeStr);
    
}

- (long)getRecordtime{
    
    return recordtime;
}

- (void)setStarttime:(long)thetime{
    
    starttime=thetime;
}

- (long)getStarttime{
    
    return starttime;
}

- (void)setStatus:(int)thestatus{
    
    status=thestatus;
}

- (int)getStatus{
    
    return status;
}

- (id)initWithTrainid:(NSString *)newtrainid result:(NSString *)newresult starttime:(long)newstarttime time:(long)newtime status:(int)newstatus level:(NSInteger)newlevel{
    
    
    if(self = [super init]){
        
		starttime = newstarttime;
        status=newstatus;
        recordtime=newtime;
        level=newlevel;
        
		self.trainid  = newtrainid;
        
        self.result=newresult;

        
        self.timeStr=[NSString formatTimeAgo:recordtime];
	}
    
	return self;
}

@end
