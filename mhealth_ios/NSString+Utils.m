//
//  NSString+Utils.m
//
//
//  Created by Tom Zhang on 13-8-11.
//  Copyright (c) 2013年 Tom Zhang. All rights reserved.
//

#import "NSString+Utils.h"
#import "Utility.h"

@implementation NSString (Utils)

+ (NSString *) getCurrentTime {
    
	NSDate *nowUTC = [NSDate date];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
	return [dateFormat stringFromDate:nowUTC];
	
}

+ (NSString *) formatTimeAgo:(long) time {
	
	
	NSString *timeString=@"";
    
	NSDate* date=[NSDate dateWithTimeIntervalSince1970:time];
	
	NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

	
	timeString=[dateFormat stringFromDate:date];

	return timeString;
}

+ (NSString *) formatTimeddMM:(long) time {
	
	
	NSString *timeString=@"";
    
	NSDate* date=[NSDate dateWithTimeIntervalSince1970:time];
	
	NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
   
    NSString *lanuage = [Utility getLanguageCode];
    
    if([lanuage isEqualToString:@"cn"]||[lanuage isEqualToString:@"zh"]){
        
        [dateFormat setDateFormat:@"M月dd"];
        
    }else{
        
         [dateFormat setDateFormat:@"dd-MM"];
    }
	
	timeString=[dateFormat stringFromDate:date];
    
	return timeString;
}

+ (NSString *) formatTimeddMMM:(long) time {
	
	
	NSString *timeString=@"";
    
	NSDate* date=[NSDate dateWithTimeIntervalSince1970:time];
	
	NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    
    NSString *lanuage = [Utility getLanguageCode];
    
    if([lanuage isEqualToString:@"cn"]||[lanuage isEqualToString:@"zh"]){
        
        [dateFormat setDateFormat:@"M月dd"];
        
    }else{
        
        [dateFormat setDateFormat:@"dd-MMM"];
    }
    
    
    
	
	timeString=[dateFormat stringFromDate:date];
    
	return timeString;
}

+ (NSString *) formatTimemmdd:(long) time {
	
	
	
    long counttime=time;
    
    long minutes = 0;
    long seconds = 0;
    
    if (counttime >= 60) {
        minutes = counttime / 60;
        counttime -= minutes * 60;
    }
    
    seconds = counttime;
    
	NSString *timeString=[NSString stringWithFormat:@"%ld'%ld''",minutes,seconds];
    
	return timeString;
}

+ (NSString *) formatTimeddMMyyyy:(long) time {
	
	
	NSString *timeString=@"";
    
	NSDate* date=[NSDate dateWithTimeIntervalSince1970:time];
	
	NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MM yyyy"];
    
	
	timeString=[dateFormat stringFromDate:date];
    
	return timeString;
}

+ (NSString *) formatTimeddMMMyyyy:(long) time {
	
	
	NSString *timeString=@"";
    
	NSDate* date=[NSDate dateWithTimeIntervalSince1970:time];
	
	NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    
	
	timeString=[dateFormat stringFromDate:date];
    
	return timeString;
}

+ (NSDate *) timeddMMMyyyy2Date:(NSString *) time {
	
	
	NSDate *timeString;
    
	
	NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    
	
	timeString=[dateFormat dateFromString:time];
    
	return timeString;
}

+(NSString *)getSubString:(NSString *)preString fromStr:(NSString *)from_str toStr:(NSString *)to_str
{
	NSRange toprange = [preString rangeOfString:from_str];
	NSInteger startIndex = toprange.location+[from_str length];
	if ([preString length]<startIndex) {
		return @"";
	}
	NSString *withOutFromPart = [preString substringFromIndex: startIndex];
	//NSLog(@"withoutfrom = %@",withOutFromPart);
    
    if ([to_str isEqualToString:@""]) {
        
        return withOutFromPart;
    }
    
	NSRange bottomrange = [withOutFromPart rangeOfString:to_str];
	if([withOutFromPart length]<bottomrange.location){
		return @"";
	}
	NSString *result = [withOutFromPart substringToIndex:bottomrange.location];
	return result;
}



@end