//
//  WeightList.h
//  mHealth
//
//  Created by sngz on 14-2-11.
//
//

#import <Foundation/Foundation.h>
#import "Weight.h"

@interface WeightList : NSObject{
    
    Weight *weight;
    NSArray *weightList;
    
    long periodstart;
    long periodend;
}

@property (strong, nonatomic) Weight *weight;
@property (strong, nonatomic) NSArray *weightList;

- (void)setPeriodstart:(long)thetime;

- (long)getPeriodstart;

- (void)setPeriodend:(long)thetime;

- (long)getPeriodend;

@end
