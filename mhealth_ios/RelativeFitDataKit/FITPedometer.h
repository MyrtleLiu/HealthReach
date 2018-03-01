#import <Foundation/Foundation.h>
@class FITPedometerData;

@interface FITPedometer : NSObject

@property (nonatomic, strong) NSDate *startDate;

- (void)startWithDidUpdateBlock:(void(^)(FITPedometerData * pedometerData))pedometerDidUpdateBlock;

- (void)stop;

@end
