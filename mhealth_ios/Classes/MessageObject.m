//
//  MessageObject.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-8.
//
//

#import "MessageObject.h"

@implementation MessageObject
@synthesize  messageid;
@synthesize  is_read;
@synthesize send_time;
@synthesize  ensummary;
@synthesize  zhsummary;
@synthesize  enicon;
@synthesize  zhicon;


- (void)setMessageid:(NSString*)mid{
    
    messageid=mid;
}
- (int)getMessageid{
    
    return [messageid intValue];
}


- (void)setIs_read:(NSString *)is_r;{
    is_read=is_r;
}

- (int)getIs_read{
    
    return [is_read intValue] ;
}



- (void)setSend_time:(NSString *)st;{
    
    send_time=st;
}
- (int)getSend_time{
    
    return [send_time intValue];
}




- (void)setEnsummary:(NSString *)ensum{
    
    ensummary=ensum;
}
- (int)getEnsummary{
    
    return [ensummary intValue];
}


- (void)setzhsummary:(NSString *)zhsum;{
    
    zhsummary=zhsum;
}
- (int)getzhsummary{
    
    return [zhsummary intValue];
}


- (void)setEnicon:(NSString *)icon;{
    
    enicon=icon;
}
- (int)geteEicon{
    
    return [enicon intValue];
}

- (void)setZhicon:(NSString *)icon;{
    
    zhicon=icon;
}
- (int)getzhicon{
    
    return [zhicon intValue];
}








- (id)initWithMessageid:(NSString *)newmessageid is_read:(NSString *)newis_read send_time:(NSString *)newsend_time ensummary:(NSString *)newensummary zhsummary:(NSString *)newzhsummary enicon:(NSString *)newenicon zhicon:(NSString *)newzhicon {
    
    
    if(self = [super init]){
        
        self.messageid = newmessageid;
        self.is_read=newis_read;
        self.send_time=newsend_time;
        self.ensummary=newensummary;
        self.zhsummary=newzhsummary;
        self.enicon=newenicon;
        self.zhicon=newzhicon;
	}
	return self;
}



















-(NSMutableDictionary *)getDictionaryFromMessage{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:messageid forKey:@"messageid"];
    [dic setValue:is_read forKey:@"is_read"];
    [dic setValue:send_time forKey:@"send_time"];
    [dic setValue:ensummary forKey:@"ensummary"];
    [dic setValue:zhsummary forKey:@"zhsummary"];
    [dic setValue:enicon forKey:@"enicon"];
    [dic setValue:zhicon forKey:@"zhicon"];
    
    
    return dic;
}

-(id)initFromDicionary:(NSMutableDictionary *)dic {
    if (dic == nil) {
        return nil;
    }
    if(self = [super init]){
		messageid = [dic objectForKey:@"messageid"];
        is_read = [dic objectForKey:@"is_read"];
        send_time = [dic objectForKey:@"send_time"];
        ensummary = [dic objectForKey:@"ensummary"];
        zhsummary = [dic objectForKey:@"zhsummary"];
        enicon = [dic objectForKey:@"enicon"];
        zhicon = [dic objectForKey:@"zhicon"];
       	}
    
	return self;
}





@end
