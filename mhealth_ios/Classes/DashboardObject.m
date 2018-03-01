//
//  DashboardObject.m
//  mHealth
//
//  Created by smartone_sn on 14-9-29.
//
//

#import "DashboardObject.h"

@implementation DashboardObject

@synthesize sort,type;

- (id)initWithType:(NSString *)newtype sort:(NSString *)thesort{
    
    
    if(self = [super init]){

        self.type = newtype;
        
		self.sort  = thesort;

        
	}
    
	return self;
    
}

-(NSComparisonResult)compare:(DashboardObject *)otherObj{
	
	
	return [[[NSNumber alloc] initWithInt:[self.sort intValue]] compare: [[NSNumber alloc] initWithLong:[otherObj.sort intValue]]];
	
	
}

@end
