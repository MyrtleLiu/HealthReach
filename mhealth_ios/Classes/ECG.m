//
//  ECG.m
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "ECG.h"

@implementation ECG

@synthesize ecg,heartrate,timeStr,note;

- (void)setRecordid:(int)theRecordid{
    
    recordid=theRecordid;
}

- (int)getRecordid{
    
    return recordid;
}

- (id)initWithECG:(NSString *)newecg heartrate:(NSString *)newhr note:(NSString *)newnote time:(long)newtime status:(int)newstatus missprevious:(int)newmissprevious{
    
    if(self = [super init]){
        
		recordtime = newtime;
        status=newstatus;
        missprevious=newmissprevious;

		self.ecg  = newecg;
        
        self.heartrate=newhr;
        
        self.note=newnote;

        
        self.timeStr=[NSString formatTimeAgo:recordtime];
	}
    
	return self;
    
}

@end
