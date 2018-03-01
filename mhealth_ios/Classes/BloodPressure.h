//
//  BloodPressure.h
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "BaseObeject.h"

@interface BloodPressure : BaseObeject{
    
    NSString *sys;
    NSString *dia;
    NSString *heartrate;
    NSString *timeStr;
}


@property (strong, nonatomic) NSString *sys;
@property (strong, nonatomic) NSString *dia;
@property (strong, nonatomic) NSString *heartrate;
@property (strong, nonatomic) NSString *timeStr;


- (id)initWithSys:(NSString *)newsys time:(long)newtime  dia:(NSString *)newdia  heartrate:(NSString *)newhr status:(int)newstatus missprevious:(int)newmissprevious;

@end
