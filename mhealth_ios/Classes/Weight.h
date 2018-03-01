//
//  Weight.h
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "BaseObeject.h"

@interface Weight : BaseObeject{
    
    NSString *weight;
    NSString *bmi;
    NSString *timeStr;
}


@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSString *timeStr;
@property (strong, nonatomic) NSString *bmi;

- (id)initWithWeight:(NSString *)newweight bmi:(NSString *)newbmi time:(long)newtime status:(int)newstatus missprevious:(int)newmissprevious;

@end
