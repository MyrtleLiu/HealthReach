//
//  BloodGlucoseList.m
//  mHealth
//
//  Created by sngz on 14-2-11.
//
//

#import "BloodGlucoseList.h"

@implementation BloodGlucoseList

@synthesize bg,bgList;


- (void)setPeriodstart:(long)thetime{
    
    periodstart=thetime;
}

- (long)getPeriodstart{
    
    return periodstart;
}

- (void)setPeriodend:(long)thetime{
    
    periodend=thetime;
}

- (long)getPeriodend{
    
    return periodend;
}

@end
