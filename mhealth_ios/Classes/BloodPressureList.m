//
//  BloodPressureList.m
//  mHealth
//
//  Created by sngz on 14-2-11.
//
//

#import "BloodPressureList.h"

@implementation BloodPressureList

@synthesize bp,bpList;

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
