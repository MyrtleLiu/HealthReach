//
//  BloodGlucoseList.h
//  mHealth
//
//  Created by sngz on 14-2-11.
//
//

#import <Foundation/Foundation.h>
#import "BloodGlucose.h"

@interface BloodGlucoseList : NSObject{
    
    BloodGlucose *bg;
    NSArray *bgList;
    
    long periodstart;
    long periodend;
}

@property (strong, nonatomic) BloodGlucose *bg;
@property (strong, nonatomic) NSArray *bgList;

- (void)setPeriodstart:(long)thetime;

- (long)getPeriodstart;

- (void)setPeriodend:(long)thetime;

- (long)getPeriodend;

@end
