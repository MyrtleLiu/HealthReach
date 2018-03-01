//
//  BloodPressure.m
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "BloodPressure.h"

@implementation BloodPressure

@synthesize sys,dia,heartrate,timeStr;

- (id)initWithSys:(NSString *)newsys time:(long)newtime  dia:(NSString *)newdia  heartrate:(NSString *)newhr status:(int)newstatus missprevious:(int)newmissprevious{
    
    if(self = [super init]){
        
		recordtime = newtime;
        status=newstatus;
        missprevious=newmissprevious;
        
		self.sys  = newsys;
        self.dia = newdia;
		self.heartrate  = newhr;
        
        self.timeStr=[NSString formatTimeAgo:recordtime];
	}
    
	return self;
}

@end
