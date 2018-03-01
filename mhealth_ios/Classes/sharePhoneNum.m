//
//  sharePhoneNum.m
//  mHealth
//
//  Created by smartone_sn2 on 14-9-4.
//
//

#import "sharePhoneNum.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "Utility.h"

@implementation sharePhoneNum



+ (BOOL)sendShare:(NSString *)phoneNum{
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *url_string = [[NSString alloc]init];
    url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
    url_string = [url_string stringByAppendingString:@"healthDoctor?login="];
    url_string = [url_string stringByAppendingString:login_id];
    url_string = [url_string stringByAppendingString:@"&action=S&sessionid="];
    url_string = [url_string stringByAppendingString:session_id];
    
    url_string = [url_string stringByAppendingString:@"&bysms=1"];
    
    url_string = [url_string stringByAppendingString:@"&phone="];
    url_string = [url_string stringByAppendingString:phoneNum];


    
    
    NSURL *request_url = [NSURL URLWithString:url_string];
	NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
    
    if (xmlData){
        int isSucc = [Utility isSucc:xmlData];
        NSLog(@"is upload sharePhoneNum record succ:%d",isSucc);
        if (isSucc==1)
        {
            return true;
        }
    }
    
    
    return false;
    
    
}






@end
