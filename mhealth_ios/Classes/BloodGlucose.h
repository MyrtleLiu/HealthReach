//
//  BloodGlucose.h
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "BaseObeject.h"

@interface BloodGlucose : BaseObeject{
    
    NSString *bg;
    NSString *timeStr;
    NSString *type;
}

@property (strong, nonatomic) NSString *bg;
@property (strong, nonatomic) NSString *timeStr;
@property (strong, nonatomic) NSString *type;


- (id)initWithBG:(NSString *)newbg time:(long)newtime status:(int)newstatus missprevious:(int)newmissprevious type:(NSString *)newtype;


@end
