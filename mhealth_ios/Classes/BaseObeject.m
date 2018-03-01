//
//  BaseObeject.m
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "BaseObeject.h"

@implementation BaseObeject

//static int MISS_PRE_Y=0;
//static int MISS_PRE_N=1;

- (void)setRecordtime:(long)thetime{
    
    recordtime=thetime;
    
}

- (long)getRecordtime{
    
    return recordtime;
}


- (void)setStatus:(int)thestatus{
    
    status=thestatus;
    
}


- (int)getStatus{
    
    return status;
}

- (void)setMissprevious:(int)theMissprevious{
    
    missprevious=theMissprevious;
}

- (int)getMissprevious{
        
    
    return missprevious;
    
}

@end
