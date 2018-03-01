//
//  MessageObject.h
//  mHealth
//
//  Created by smartone_sn2 on 14-10-8.
//
//

#import "BaseObeject.h"

@interface MessageObject : BaseObeject{
    
    NSString * messageid;
    NSString * is_read;
    NSString *send_time;
    NSString *ensummary;
    NSString *zhsummary;
    NSString *enicon;
    NSString *zhicon;
}
@property (strong, nonatomic) NSString *messageid;
@property (strong, nonatomic) NSString *is_read;

@property (strong, nonatomic) NSString *send_time;
@property (strong, nonatomic) NSString *ensummary;
@property (strong, nonatomic) NSString *zhsummary;
@property (strong, nonatomic) NSString *enicon;
@property (strong, nonatomic) NSString *zhicon;

@property (assign, nonatomic) BOOL isChecked;



- (id)initWithMessageid:(NSString *)newmessageid is_read:(NSString *)newis_read send_time:(NSString *)newsend_time ensummary:(NSString *)newensummary zhsummary:(NSString *)newzhsummary enicon:(NSString *)newenicon zhicon:(NSString *)newzhicon;



-(NSMutableDictionary *)getDictionaryFromMessage;

-(id)initFromDicionary:(NSMutableDictionary *)dic;

@end
