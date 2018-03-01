//
//  ECG.h
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import "BaseObeject.h"

@interface ECG : BaseObeject{
    
    NSString *ecg;
    NSString *heartrate;
    NSString *timeStr;
    NSString *note;
    int recordid;
}

@property (strong, nonatomic) NSString *ecg;
@property (strong, nonatomic) NSString *timeStr;
@property (strong, nonatomic) NSString *heartrate;
@property (strong, nonatomic) NSString *note;


- (void)setRecordid:(int)theRecordid;

- (int)getRecordid;

- (id)initWithECG:(NSString *)newecg heartrate:(NSString *)newhr note:(NSString *)newnote time:(long)newtime status:(int)newstatus missprevious:(int)newmissprevious;


@end
