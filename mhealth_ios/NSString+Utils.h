//
//  NSString+Utils.h
//  
//
//  Created by Tom Zhang on 13-8-11.
//  Copyright (c) 2013年 Tom Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Utils)

+ (NSString *) getCurrentTime;
+ (NSString *) formatTimeAgo:(long) time;
+ (NSString *) formatTimeddMMyyyy:(long) time;
+ (NSString *) formatTimeddMM:(long) time;
+ (NSString *) formatTimeddMMMyyyy:(long) time;
+ (NSString *) formatTimeddMMM:(long) time;
+ (NSString *) formatTimemmdd:(long) time;
+ (NSDate *) timeddMMMyyyy2Date:(NSString *) time;
+(NSString *)getSubString:(NSString *)preString fromStr:(NSString *)from_str toStr:(NSString *)to_str;


@end
