//
//  Constants.m
//  mHealth
//
//  Created by sngz on 14-2-18.
//      
//

#import "Constants.h"


BOOL const isProduction =true;
//NSString * const apiBaseURL = @"http://202.140.96.155/wmc/servlet/";

//NSString * apiBaseURL =setLink;
//
@implementation Constants
//
//
//
+(NSString *)getAPIBase1
{
      NSString *url ;
        if(isProduction){
            url = @"https://www.healthreach.hk/";
    
        }
        else{
            url = @"http://waptest.smartone.com/";
        }
    return url;
}

+(NSString *)getAPIBase2
{
    NSString *url ;
    if(isProduction){
        url = @"https://www.healthreach.hk/wmc/servlet/";
        
    }
    else{
        url = @"http://waptest.smartone.com/wmc/servlet/";
    }
    return url;
}


@end
