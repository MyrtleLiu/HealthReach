//
//  Weight.m
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "Weight.h"

@implementation Weight

@synthesize weight,bmi,timeStr;

- (id)initWithWeight:(NSString *)newweight bmi:(NSString *)newbmi time:(long)newtime status:(int)newstatus missprevious:(int)newmissprevious{
    
    
    if(self = [super init]){
        
		recordtime = newtime;
        status=newstatus;
        missprevious=newmissprevious;
        
		self.weight  = newweight;
        
        self.bmi=newbmi;

        self.timeStr=[NSString formatTimeAgo:recordtime];
	}
    
	return self;
    
}

@end
