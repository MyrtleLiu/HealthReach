//
//  TrainingRecord.h
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import <Foundation/Foundation.h>

@interface TrainingRecord : NSObject{
    
    NSInteger level;// 1.bronze 2.silver 3.gold 4.diamond
    int status;//1.finish 3.unfinish 2.process
    NSString *trainid;
    NSString *result;
    long recordtime;
    long starttime;
    
    NSString *timeStr;
    
    NSArray *walkingRecords;
    
}

@property (strong, nonatomic) NSString *trainid;
@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSArray *walkingRecords;
@property (strong, nonatomic) NSString *timeStr;


- (void)setLevel:(NSInteger)thelevel;

- (NSInteger)getLevel;

- (void)setRecordtime:(long)thetime;

- (long)getRecordtime;

- (void)setStarttime:(long)thetime;

- (long)getStarttime;

- (void)setStatus:(int)thestatus;

- (int)getStatus;

- (id)initWithTrainid:(NSString *)newtrainid result:(NSString *)newresult starttime:(long)newstarttime time:(long)newtime status:(int)newstatus level:(NSInteger)newlevel;

@end
