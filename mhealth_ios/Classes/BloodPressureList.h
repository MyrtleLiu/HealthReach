//
//  BloodPressureList.h
//  mHealth
//
//  Created by sngz on 14-2-11.
//
//

#import <Foundation/Foundation.h>
#import "BloodPressure.h"

@interface BloodPressureList : NSObject{
    
    BloodPressure *bp;
    NSArray *bpList;
    
    long periodstart;
    long periodend;
}

@property (strong, nonatomic) BloodPressure *bp;
@property (strong, nonatomic) NSArray *bpList;


- (void)setPeriodstart:(long)thetime;

- (long)getPeriodstart;

- (void)setPeriodend:(long)thetime;

- (long)getPeriodend;

@end
