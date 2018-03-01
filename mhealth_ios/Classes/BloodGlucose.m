//
//  BloodGlucose.m
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "BloodGlucose.h"

@implementation BloodGlucose

@synthesize timeStr,bg,type;

- (id)initWithBG:(NSString *)newbg time:(long)newtime status:(int)newstatus missprevious:(int)newmissprevious type:(NSString *)newtype{
    
    if(self = [super init]){
        
		recordtime = newtime;
        status=newstatus;
        missprevious=newmissprevious;
        type = newtype;
        
		self.bg  = newbg;

        
        self.timeStr=[NSString formatTimeAgo:recordtime];
	}
    
	return self;
}

@end
