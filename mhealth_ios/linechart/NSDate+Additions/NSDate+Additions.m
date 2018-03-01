//
//  NSDate+Additions.m
//
//  Created by Wess Cope on 6/1/11.
//  Copyright 2012. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate(Additions)

+(int) unixTimestampFromDate:(NSDate *)aDate
{
    time_t unixDate = (time_t)[aDate timeIntervalSince1970];
    return (int)unixDate;
}

+(int) unixTimestampNow
{
    return [NSDate unixTimestampFromDate:[NSDate date]];
}

+ (NSDate *)date:(NSDate *)aDate add:(NSUInteger)increment of:(NSDateTimeType)type
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];

    switch (type) 
    {
        case NSDateSecondsType:
            [components setSecond:increment];
            break;
        case NSDateMinutesType:
            [components setMinute:increment];
            break;
            
        case NSDateHoursType:
            [components setHour:increment];
            break;
            
        case NSDateDaysType:
            [components setDay:increment];
            break;
            
        case NSDateWeekType:
            [components setWeekOfYear:increment];
            break;
            
        case NSDateMonthsType:
            [components setMonth:increment];
            break;
            
        case NSDateYearType:
            [components setYear:increment];
            break;
            
        default:
            break;
    }

    return [cal dateByAddingComponents:components toDate:aDate options:0];
}

+ (NSDate*) yesterday{
	DateInformation inf = [[NSDate date] dateInformation];
	inf.day--;
	return [NSDate dateFromDateInformation:inf];
}
+ (NSDate*) month{
    return [[NSDate date] monthDate];
}

- (NSDate*) monthDate {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self];
	[comp setDay:1];
	NSDate *date = [gregorian dateFromComponents:comp];
    return date;
}


- (NSInteger) weekday{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:self];
	NSInteger weekday = [comps weekday];
	return weekday;
}
- (NSDate*) timelessDate {
	NSDate *day = self;
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:day];
	return [gregorian dateFromComponents:comp];
}
- (NSDate*) monthlessDate {
	NSDate *day = self;
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:day];
	return [gregorian dateFromComponents:comp];
}



- (BOOL) isSameDay:(NSDate*)anotherDate{
	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
	NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
	return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
} 

- (int) monthsBetweenDate:(NSDate *)toDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth
                                                fromDate:[self monthlessDate]
                                                  toDate:[toDate monthlessDate]
                                                 options:0];
    NSInteger months = [components month];
    return abs((int32_t)months);
}
- (NSInteger) daysBetweenDate:(NSDate*)d{
	
	NSTimeInterval time = [self timeIntervalSinceDate:d];
	return fabs(time / 60 / 60/ 24);
	
}
- (BOOL) isToday{
	return [self isSameDay:[NSDate date]];
} 



- (NSDate *) dateByAddingDays:(NSUInteger)days {
	NSDateComponents *c = [[NSDateComponents alloc] init];
	c.day = days;
	return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}
+ (NSDate *) dateWithDatePart:(NSDate *)aDate andTimePart:(NSDate *)aTime {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	NSString *datePortion = [dateFormatter stringFromDate:aDate];
	
	[dateFormatter setDateFormat:@"HH:mm"];
	NSString *timePortion = [dateFormatter stringFromDate:aTime];
	
	[dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
	NSString *dateTime = [NSString stringWithFormat:@"%@ %@",datePortion,timePortion];
	return [dateFormatter dateFromString:dateTime];
}



- (NSString*) monthString{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];	
	[dateFormatter setDateFormat:@"MMMM"];
	return [dateFormatter stringFromDate:self];
}
- (NSString*) yearString{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];	
	[dateFormatter setDateFormat:@"yyyy"];
	return [dateFormatter stringFromDate:self];
}



- (DateInformation) dateInformationWithTimeZone:(NSTimeZone*)tz{
	
	
	DateInformation info;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	[gregorian setTimeZone:tz];
	NSDateComponents *comp = [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear |
													NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond)
										  fromDate:self];
	info.day = [comp day];
	info.month = [comp month];
	info.year = [comp year];
	
	info.hour = [comp hour];
	info.minute = [comp minute];
	info.second = [comp second];
	
	info.weekday = [comp weekday];
	
	
	return info;
	
}
- (DateInformation) dateInformation{
	
	DateInformation info;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comp = [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitMinute | NSCalendarUnitYear |
													NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitSecond)
										  fromDate:self];
	info.day = [comp day];
	info.month = [comp month];
	info.year = [comp year];
	
	info.hour = [comp hour];
	info.minute = [comp minute];
	info.second = [comp second];
	
	info.weekday = [comp weekday];
	
    
	return info;
}
+ (NSDate*) dateFromDateInformation:(DateInformation)info timeZone:(NSTimeZone*)tz{
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	[gregorian setTimeZone:tz];
	NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:[NSDate date]];
	
	[comp setDay:info.day];
	[comp setMonth:info.month];
	[comp setYear:info.year];
	[comp setHour:info.hour];
	[comp setMinute:info.minute];
	[comp setSecond:info.second];
	[comp setTimeZone:tz];
	
	return [gregorian dateFromComponents:comp];
}
+ (NSDate*) dateFromDateInformation:(DateInformation)info{
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear| NSCalendarUnitMonth) fromDate:[NSDate date]];
	
	[comp setDay:info.day];
	[comp setMonth:info.month];
	[comp setYear:info.year];
	[comp setHour:info.hour];
	[comp setMinute:info.minute];
	[comp setSecond:info.second];
	//[comp setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	return [gregorian dateFromComponents:comp];
}

+ (NSString*) dateInformationDescriptionWithInformation:(DateInformation)info{
	return [NSString stringWithFormat:@"%ld %ld %ld %ld:%ld:%ld",(long)info.month,(long)info.day,(long)info.year,(long)info.hour,(long)info.minute,(long)info.second];
}

@end
