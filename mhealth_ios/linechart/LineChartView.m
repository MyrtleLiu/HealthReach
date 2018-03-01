//
//  LineChartView.m
//  
//
//  Created by Marcel Ruegenberg on 02.08.13.
//
//

#import "LineChartView.h"
#import "LegendView.h"
#import "InfoView.h"
#import "NSArray+FPAdditions.h"
#import "GlobalVariables.h"
#import "Utility.h"

@interface LineChartDataItem ()

@property (readwrite) float x; // should be within the x range
@property (readwrite) float y; // should be within the y range
@property (readwrite) NSInteger missPre; // should be within the y range
@property (readwrite) NSString *xLabel; // label to be shown on the x axis
@property (readwrite) NSString *dataLabel; // label to be shown directly at the data item

- (id)initWithhX:(float)x y:(float)y xLabel:(NSString *)xLabel dataLabel:(NSString *)dataLabel missPrePoint:(NSInteger)theMissPre;

@end

@implementation LineChartDataItem

- (id)initWithhX:(float)x y:(float)y xLabel:(NSString *)xLabel dataLabel:(NSString *)dataLabel missPrePoint:(NSInteger)theMissPre{
    if((self = [super init])) {
        self.x = x;
        self.y = y;
        self.xLabel = xLabel;
        self.dataLabel = dataLabel;
        self.missPre=theMissPre;
        
       // NSLog(@"add.......%@........%f",[NSDate dateWithTimeIntervalSince1970:x],y);
        
        
    }
    return self;
}

+ (LineChartDataItem *)dataItemWithX:(float)x y:(float)y xLabel:(NSString *)xLabel dataLabel:(NSString *)dataLabel missPrePoint:(NSInteger)theMissPre{
    return [[LineChartDataItem alloc] initWithhX:x y:y xLabel:xLabel dataLabel:dataLabel missPrePoint:theMissPre];
}

@end



@implementation LineChartData

@end



@interface LineChartView ()

@property LegendView *legendView;
@property InfoView *infoView;
@property UIView *currentPosView;
@property UILabel *xAxisLabel;

- (BOOL)drawsAnyData;

@end


#define X_AXIS_SPACE 15
#define PADDING 10


@implementation LineChartView
@synthesize data=_data;
@synthesize drawsBG;
@synthesize startColor;
@synthesize endColor;


- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {
        self.currentPosView = [[UIView alloc] initWithFrame:CGRectMake(PADDING, PADDING, 1 / self.contentScaleFactor, 50)];
        self.currentPosView.backgroundColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
        self.currentPosView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.currentPosView.alpha = 0.0;
        [self addSubview:self.currentPosView];
        
        self.legendView = [[LegendView alloc] initWithFrame:CGRectMake(frame.size.width - 50 - 10, 10, 50, 30)];
        self.legendView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.legendView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.legendView];
        
        self.xAxisLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        self.xAxisLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.xAxisLabel.font = [UIFont boldSystemFontOfSize:10];
        self.xAxisLabel.textColor = [UIColor grayColor];
        self.xAxisLabel.textAlignment = NSTextAlignmentCenter;
        self.xAxisLabel.alpha = 0.0;
        self.xAxisLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.xAxisLabel];
        
        self.backgroundColor = [UIColor whiteColor];
        self.scaleFont = [UIFont systemFontOfSize:10.0];
        
        self.autoresizesSubviews = YES;
        self.contentMode = UIViewContentModeRedraw;

        self.drawsDataPoints = YES;
        self.drawsDataLines  = YES;
    }
    return self;
}

- (void)showLegend:(BOOL)show animated:(BOOL)animated {
    if(! animated) {
        self.legendView.alpha = show ? 1.0 : 0.0;
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.legendView.alpha = show ? 1.0 : 0.0;
    }];
}
                           
- (void)layoutSubviews {
    [self.legendView sizeToFit];
    CGRect r = self.legendView.frame;
    r.origin.x = self.frame.size.width - self.legendView.frame.size.width - 3 - PADDING;
    r.origin.y = 3 + PADDING;
    self.legendView.frame = r;
    
    r = self.currentPosView.frame;
    CGFloat h = self.frame.size.height;
    r.size.height = h - 2 * PADDING - X_AXIS_SPACE;
    self.currentPosView.frame = r;
    
    [self.xAxisLabel sizeToFit];
    r = self.xAxisLabel.frame;
    r.origin.y = self.frame.size.height - X_AXIS_SPACE - PADDING + 2;
    self.xAxisLabel.frame = r;
    
    [self bringSubviewToFront:self.legendView];
}

- (void)setData:(NSArray *)data {
    if(data != _data) {
        NSMutableArray *titles = [NSMutableArray arrayWithCapacity:[data count]];
        NSMutableDictionary *colors = [NSMutableDictionary dictionaryWithCapacity:[data count]];
        for(LineChartData *dat in data) {
            [titles addObject:dat.title];
            [colors setObject:dat.color forKey:dat.title];
        }
        self.legendView.titles = titles;
        self.legendView.colors = colors;
        
        _data = data;
        
        //NSLog(@"set data......");
    }
}



- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    //NSLog(@"%f.......y scale.......%f",_yMax,_yMin);
    
    //CGContextClearRect(c, rect);
    //CGContextFlush(c);
    
//    [self setNeedsDisplay];
//    NSLog(@"clear.......");
    
    //CGFloat availableHeight = self.bounds.size.height - 2 * PADDING - X_AXIS_SPACE;
    
    
//    UIFont *textFont = [UIFont systemFontOfSize:14];
//    
//    CGFloat h=[textFont lineHeight];
//    
//    NSLog(@"text font h.....%f",h);
    
    CGFloat availableHeight = self.frame.size.height-40;
    
    //CGFloat availableWidth = self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth;
    
    CGFloat availableWidth = self.frame.size.width-2*PADDING-2*38;
    
    CGFloat xStart = PADDING + 38;
    CGFloat yStart = 40;
    
    
    if (!drawsBG) {
        
        //availableHeight=availableHeight-yStart;
        yStart = 20;
        xStart = 25;
        
        
        availableHeight=self.frame.size.height-20;
        
        availableWidth=self.frame.size.width-10-xStart;

//        NSLog(@"%f........%f",self.frame.size.height,availableHeight);
        
    }
    
    if (_isWatch==1) {
        
        
        availableHeight = self.frame.size.height-20;

        availableWidth = self.frame.size.width-20;
        
        xStart = 10;
        yStart = 10;

        
        
    }
    
    CGFloat oneHeightValue = 1/((_yMax-_yMin)/availableHeight);

    
    
    
    CGFloat setpValue=_yMax*0.2;
    
    CGFloat totalValue=_yMax-_yMin;
    
    CGFloat percentValue=totalValue/_yMax;
    
    CGFloat testValue=8;
    
    CGFloat bg_testValue=0.5;
    
    CGFloat adjust_y_label_pos=5;


    

    
    //NSLog(@"%f......availableWidth........%f",self.frame.size.height,setpValue);
    
    static CGFloat dashedPattern[] = {4,2};
    
    // draw scale and horizontal lines

    
    

    
    
    if (drawsBG) {

        
//        CGFloat heightPerStep = self.ySteps == nil || [self.ySteps count] == 0 ? availableHeight : (availableHeight / ([self.ySteps count] - 1));
//        
//        NSUInteger i = 0;
//        CGContextSaveGState(c);
//        CGContextSetLineWidth(c, 1.0);
//        NSUInteger yCnt = [self.ySteps count];
//        for(NSString *step in self.ySteps) {
//            [[UIColor whiteColor] set];
//            CGFloat h = [self.scaleFont lineHeight];
//            CGFloat y = yStart + heightPerStep * (yCnt - 1 - i);
//            [step drawInRect:CGRectMake(yStart, y - h / 2, self.yAxisLabelsWidth - 6, h) withFont:self.scaleFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentRight];
            

            
            //draw line
//            [[UIColor colorWithWhite:0.9 alpha:1.0] set];
//            CGContextSetLineDash(c, 0, dashedPattern, 2);
//            CGContextMoveToPoint(c, xStart, round(y) + 0.5);
//            CGContextAddLineToPoint(c, self.bounds.size.width - PADDING, round(y) + 0.5);
//            CGContextStrokePath(c);
//            
//            i++;
//        }
        
//        NSUInteger xCnt = self.xStepsCount;
//        if(xCnt > 1) {
//            CGFloat widthPerStep = availableWidth / (xCnt - 1);
//            
//            [[UIColor grayColor] set];
//            for(NSUInteger i = 0; i < xCnt; ++i) {
//                NSLog(@"i: %d x: %d", i, xCnt);
//                CGFloat x = xStart + widthPerStep * (xCnt - 1 - i);
//                
//                [[UIColor colorWithWhite:0.9 alpha:1.0] set];
//                CGContextMoveToPoint(c, round(x) + 0.5, PADDING);
//                CGContextAddLineToPoint(c, round(x) + 0.5, yStart + availableHeight);
//                CGContextStrokePath(c);
//            }
//        }
        
       // CGContextRestoreGState(c);
        
        
        if (_isWatch==1) {
            
            
            if (self.startColor!=nil&&self.endColor!=nil) {
                
                
                const CGFloat* componentsStart = CGColorGetComponents(self.startColor.CGColor);
                const CGFloat* componentsEnd = CGColorGetComponents(self.endColor.CGColor);
                
                CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
                
                CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){componentsStart[0], componentsStart[1], componentsStart[2], 1.0f});
                
                CGColorRef endtheColor = CGColorCreate(colorSpaceRef, (CGFloat[]){componentsEnd[0], componentsEnd[1], componentsEnd[2], 1.0f});
                
                CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, endtheColor}, 2, nil);
                
                CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){
                    0.0f,       // 对应起点颜色位置
                    1.0f        // 对应终点颜色位置
                });
                
                CFRelease(colorArray);
                
                CGColorRelease(beginColor);
                CGColorRelease(endtheColor);
                
                CGColorSpaceRelease(colorSpaceRef);
                
                CGContextDrawLinearGradient(c, gradientRef, CGPointMake(0.0f, 0.0f), CGPointMake(0.0f, self.frame.size.height), 0);
                
                // CGContextDrawLinearGradient(c, gradientRef, CGPointMake(self.frame.size.width, self.frame.size.height), CGPointMake(0.0f, self.frame.size.height), 0);
                
                CGGradientRelease(gradientRef);
                
                //NSLog(@"draw bg.........");
                
            }
        }
        
        
    }
    else{
       
        
        if (self.startColor!=nil&&self.endColor!=nil) {

            
            const CGFloat* componentsStart = CGColorGetComponents(self.startColor.CGColor);
            const CGFloat* componentsEnd = CGColorGetComponents(self.endColor.CGColor);

            CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();

            CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){componentsStart[0], componentsStart[1], componentsStart[2], 1.0f});

            CGColorRef endtheColor = CGColorCreate(colorSpaceRef, (CGFloat[]){componentsEnd[0], componentsEnd[1], componentsEnd[2], 1.0f});

            CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, endtheColor}, 2, nil);

            CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){
                0.0f,       // 对应起点颜色位置
                1.0f        // 对应终点颜色位置
            });

            CFRelease(colorArray);

            CGColorRelease(beginColor);
            CGColorRelease(endtheColor);

            CGColorSpaceRelease(colorSpaceRef);
            
            CGContextDrawLinearGradient(c, gradientRef, CGPointMake(0.0f, 0.0f), CGPointMake(0.0f, self.frame.size.height), 0);
            
           // CGContextDrawLinearGradient(c, gradientRef, CGPointMake(self.frame.size.width, self.frame.size.height), CGPointMake(0.0f, self.frame.size.height), 0);

            CGGradientRelease(gradientRef);
            
            //NSLog(@"draw bg.........");
            
        }
       

    }
    
    //draw x axis
    if (_xLabelCount>0&&_isWatch!=1) {
        
        
       // NSLog(@"%ld........label",(long)_xLabelCount);

        
        if (_xLabelCount==90) {
            
            NSDate *tmp=[[NSDate alloc] initWithTimeIntervalSince1970:((long)_xMin)];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"d"];
            NSString *label1 = [formatter stringFromDate:tmp];
            
            int startDays=1;
            
            if ([label1 integerValue]>1&&[label1 integerValue]<15) {
                
                startDays=15;
            }
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
            
            NSInteger year=dateComponent.year;
            NSInteger month=dateComponent.month;
            NSInteger minDay=dateComponent.day;
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d 00:00:00",(long)year,(long)month,startDays]];
            
            if ([recordStart timeIntervalSince1970]<[tmp timeIntervalSince1970]) {
                
                recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)minDay]];
            }
            
            for (int i=0; i<6; i++) {
                
                
                NSDate *date=[recordStart dateByAddingTimeInterval:24*60*60*i*15];
                
                NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc] init];
                [tmpFormatter setDateFormat:@"d"];
                NSString *checkDaysLabel = [formatter stringFromDate:date];
                
                //NSLog(@"the day......%@",checkDaysLabel);
                
                
                if ([checkDaysLabel integerValue]==14||[checkDaysLabel integerValue]==29) {
                    
                    date=[recordStart dateByAddingTimeInterval:(24*60*60*i*15+24*60*60)];
                }
                
                if ([checkDaysLabel integerValue]==16||[checkDaysLabel integerValue]==31||[checkDaysLabel integerValue]==2) {
                    
                    date=[recordStart dateByAddingTimeInterval:(24*60*60*i*15-24*60*60)];
                }
                
                if ([checkDaysLabel integerValue]==3||[checkDaysLabel integerValue]==17) {
                    
                    date=[recordStart dateByAddingTimeInterval:(24*60*60*i*15-2*24*60*60)];
                }
                
                if ([checkDaysLabel integerValue]==4||[checkDaysLabel integerValue]==18) {
                    
                    date=[recordStart dateByAddingTimeInterval:(24*60*60*i*15-3*24*60*60)];
                }
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                
                NSLocale *locale;
                if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
                    locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
                    
                } else {
                    locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                    
                }
                
                [formatter setLocale:locale];
                
                [formatter setDateFormat:@"MMM dd"];
                float textWidth=55.0f;
                if (i>0&&[Utility isSameMonthDate:date theDate:[recordStart dateByAddingTimeInterval:24*60*60*(i-1)*15]]) {
                    
                    [formatter setDateFormat:@"dd"];
                    textWidth=32.0f;
                    
                }
                
                NSString *restult = [formatter stringFromDate:date];
                
                NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
                
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                
                textStyle.alignment = NSTextAlignmentLeft;
                
                UIFont *textFont = [UIFont systemFontOfSize:14];
                
                if (!drawsBG) {
                    
                    
                    textFont = [UIFont systemFontOfSize:9];
                }
                
                CGFloat h=[textFont lineHeight];
                
                float xRangeLen = _xMax - _xMin;
                
                CGFloat xVal = round((xRangeLen == 0 ? 0.5 : (([date timeIntervalSince1970] - _xMin) / xRangeLen)) * availableWidth)+xStart;
                
                CGFloat yVal =self.frame.size.height-h-5;
                
                
                if (!drawsBG) {
                    
                    
                    yVal=yVal+adjust_y_label_pos;
                    
                    xVal = 15 + round((([date timeIntervalSince1970] - _xMin) / xRangeLen) * availableWidth);
                    
                    
                }
                
                
                //NSLog(@"draw x label....%@",restult);
                
                [restult drawInRect:CGRectMake(xVal, yVal, textWidth, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                
            }
            
            
            
        }
        
        if (_xLabelCount==30) {
            
            NSDate *tmp=[[NSDate alloc] initWithTimeIntervalSince1970:((long)_xMin)];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"d"];
            NSString *label1 = [formatter stringFromDate:tmp];
            
            int startDays=1;
            
            if ([label1 integerValue]>1&&[label1 integerValue]<7) {
                
                startDays=7;
            }
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
            
            NSInteger year=dateComponent.year;
            NSInteger month=dateComponent.month;
            NSInteger minDay=dateComponent.day;
            
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%d 00:00:00",(long)year,(long)month,startDays]];
            
            if ([recordStart timeIntervalSince1970]<[tmp timeIntervalSince1970]) {
                
                recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)minDay]];
            }
            
            
            for (int i=0; i<5; i++) {
                
                
                NSDate *date=[recordStart dateByAddingTimeInterval:24*60*60*i*6];

                
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                NSLocale *locale;
                if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
                    locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
                    
                } else {
                    locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                    
                }
                
                [formatter setLocale:locale];
                
                [formatter setDateFormat:@"MMM dd"];
                float textWidth=55.0f;
                if (i>0&&[Utility isSameMonthDate:date theDate:[recordStart dateByAddingTimeInterval:24*60*60*(i-1)*6]]) {
                    
                    [formatter setDateFormat:@"dd"];
                    textWidth=32.0f;
                }
                
                NSString *restult = [formatter stringFromDate:date];
                
                NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
                
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                
                textStyle.alignment = NSTextAlignmentLeft;
                
                UIFont *textFont = [UIFont systemFontOfSize:14];
                
                if (!drawsBG) {
                    
                    
                    textFont = [UIFont systemFontOfSize:9];
                }
                
                CGFloat h=[textFont lineHeight];
                
                float xRangeLen = _xMax - _xMin;
                
                CGFloat xVal = round((xRangeLen == 0 ? 0.5 : (([date timeIntervalSince1970] - _xMin) / xRangeLen)) * availableWidth)+xStart;
                
                CGFloat yVal =self.frame.size.height-h-5;
                
                
                if (!drawsBG) {
                    
                    
                    yVal=yVal+adjust_y_label_pos;
                    
                    xVal = 15 + round((([date timeIntervalSince1970] - _xMin) / xRangeLen) * availableWidth);
                    
                    
                }
                
                [restult drawInRect:CGRectMake(xVal, yVal, textWidth, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                
            }
            
            
            
        }
        
        if (_xLabelCount==14) {
            
            NSDate *tmp=[[NSDate alloc] initWithTimeIntervalSince1970:((long)_xMin)];
            
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
            
            NSInteger year=dateComponent.year;
            NSInteger month=dateComponent.month;
            NSInteger days=dateComponent.day;
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)days]];
            
            if ([recordStart timeIntervalSince1970]<[tmp timeIntervalSince1970]) {
                
                recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)days]];
            }
            
            for (int i=0; i<5; i++) {
                
                
                NSDate *date=[recordStart dateByAddingTimeInterval:24*60*60*i*3];
                
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                
                NSLocale *locale;
                if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
                    locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
                    
                } else {
                    locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                    
                }
                
                [formatter setLocale:locale];
                
                [formatter setDateFormat:@"MMM dd"];
                float textWidth=55.0f;
                if (i>0&&[Utility isSameMonthDate:date theDate:[recordStart dateByAddingTimeInterval:24*60*60*(i-1)*3]]) {
                    
                    [formatter setDateFormat:@"dd"];
                    
                    textWidth=32.0f;
                    
                }
                
                
                
                NSString *restult = [formatter stringFromDate:date];
                
                NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
                
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                
                textStyle.alignment = NSTextAlignmentLeft;
                
                UIFont *textFont = [UIFont systemFontOfSize:14];
                
                if (!drawsBG) {
                    
                    
                    textFont = [UIFont systemFontOfSize:9];
                }
                
                CGFloat h=[textFont lineHeight];
                
                float xRangeLen = _xMax - _xMin;
                
                CGFloat xVal = round((xRangeLen == 0 ? 0.5 : (([date timeIntervalSince1970] - _xMin) / xRangeLen)) * availableWidth)+xStart;
                
                CGFloat yVal =self.frame.size.height-h-5;
                
                
                if (!drawsBG) {
                    
                    
                    yVal=yVal+adjust_y_label_pos;
                    
                    xVal = 15 + round((([date timeIntervalSince1970] - _xMin) / xRangeLen) * availableWidth);
                    
                    
                }

                
                [restult drawInRect:CGRectMake(xVal, yVal, textWidth, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                
            }
            
            
            
        }
        
        
        if (_xLabelCount==7) {
            
            NSDate *tmp=[[NSDate alloc] initWithTimeIntervalSince1970:((long)_xMin)];
            
            
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
            
            NSInteger year=dateComponent.year;
            NSInteger month=dateComponent.month;
            NSInteger days=dateComponent.day;
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)days]];
            
            for (int i=0; i<7; i++) {
                
                
                NSDate *date=[recordStart dateByAddingTimeInterval:24*60*60*i];
                
                NSDate *pre_date=i==0?[recordStart dateByAddingTimeInterval:0]:[recordStart dateByAddingTimeInterval:24*60*60*(i-1)];
                
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                
                NSLocale *locale;
                if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
                    locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
                    
                } else {
                    locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                    
                }
                
                [formatter setLocale:locale];
                
                [formatter setDateFormat:@"MMM dd"];
                float textWidth=55.0f;
                
                if (i>0&&[Utility isSameMonthDate:date theDate:pre_date]) {
                    
                    [formatter setDateFormat:@"dd"];
                    
                    textWidth=32.0f;
                    
                }
                
                NSString *restult = [formatter stringFromDate:date];
                
                //NSLog(@"date......%@,,,,%f",restult,textWidth);
                
                NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
                
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                
                textStyle.alignment = NSTextAlignmentLeft;
                
                UIFont *textFont = [UIFont systemFontOfSize:14];
                
                if (!drawsBG) {
                    
                    
                    textFont = [UIFont systemFontOfSize:9];
                }
                
                CGFloat h=[textFont lineHeight];
                
                float xRangeLen = _xMax - _xMin;
                
                CGFloat xVal = round((xRangeLen == 0 ? 0.5 : (([date timeIntervalSince1970] - _xMin) / xRangeLen)) * availableWidth)+xStart;
                
                CGFloat yVal =self.frame.size.height-h-5;
                
                
                if (!drawsBG) {
                   
                    
                    yVal=yVal+adjust_y_label_pos;
                    
                    xVal = 15 + round((([date timeIntervalSince1970] - _xMin) / xRangeLen) * availableWidth);
                   
                }
                
                //NSLog(@"draw x label.....%f,%f,%f",xVal,yVal,h);
                
                [restult drawInRect:CGRectMake(xVal, yVal, textWidth, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                
            }
            
            
            
        }
        
    }
    
    
    //draw bg line
    if (!drawsBG) {
        
        CGContextSaveGState(c);
        
        [[UIColor whiteColor] set];
        CGContextSetLineWidth(c, 1);
        CGContextMoveToPoint(c, xStart, self.frame.size.height-15);
        CGContextAddLineToPoint(c, self.frame.size.width-20, self.frame.size.height-15);
        
        
        
        CGContextStrokePath(c);
        
        if (_chartType==TYPE_WEIGHT_DB||_chartType==TYPE_CALS||_chartType==TYPE_BP
            ||_chartType==TYPE_BG||_chartType==TYPE_HR||_chartType==TYPE_WALKING) {
            
            
            CGContextMoveToPoint(c, xStart, 8);
            
        }else{
            
            CGContextMoveToPoint(c, xStart, 0);
        }
        
        
        CGContextAddLineToPoint(c, xStart, self.frame.size.height-15);
        
        CGContextStrokePath(c);
        
        CGContextRestoreGState(c);
        
    }
    
    //draw y axis
    
    if (drawsBG) {
        
        if (_isWatch!=1) {
            
            
            for (int i=5; i>0; i--) {
                
                
                float drawValue=setpValue*i;
                
                float drawPos=(setpValue*(5-i)*percentValue)*oneHeightValue;
                
                NSString *drawString=[NSString stringWithFormat:@"%.1f",drawValue];
                
                if (_chartType!=TYPE_BG) {
                    
                    drawString=[NSString stringWithFormat:@"%d",(int)drawValue];
                }
                
                NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
                
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                
                textStyle.alignment = NSTextAlignmentCenter;
                
                UIFont *textFont = [UIFont systemFontOfSize:10];
                
                CGFloat h=[textFont lineHeight];
                
                // NSLog(@"%f.....%f.....",yStart, drawPos);
                
                CGFloat yVal=drawPos;
                
                CGFloat xVal=5;
                
                CGFloat wVal=30.0f;
                
                
                [drawString drawInRect:CGRectMake(xVal, yVal, wVal, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                
                //NSLog(@"draw y lable.....%@,%f",drawString,xVal);
                
                if (_chartType==TYPE_BPALL||_chartType==TYPE_WEIGHT) {
                    
                    if (_chartType==TYPE_BPALL) {
                        
                        
                        drawString=[NSString stringWithFormat:@"%d",((int)drawValue-BPALL_MOVE_POS)];
                    }
                    
                    if (_chartType==TYPE_WEIGHT) {
                        
                        drawString=[NSString stringWithFormat:@"%d",((int)drawValue-WEIGHT_MOVE_POS)];
                        
                    }
                    
                    [drawString drawInRect:CGRectMake(5+availableWidth+PADDING+38, drawPos, 30.0f, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    
                }
            }
            
        }
        
        
        

        
    }
    else{

        
        for (int i=5; i>0; i--) {
            
            
            float drawValue=setpValue*i;
            
            float drawPos=(setpValue*(5-i)*percentValue)*oneHeightValue;
            
            drawValue=((_yMax-_yMin)/4)*(i-1)+_yMin;
            
            if (i==5) {
                
                drawValue=_yMax;
            }
            
            if (i==1) {
                
                drawValue=_yMin;
            }
            
            drawPos=[self calDashboardValue:drawValue];
            
            NSString *drawString=[NSString stringWithFormat:@"%.1f",drawValue];
            
            if (_chartType!=TYPE_BG) {
                
                drawString=[NSString stringWithFormat:@"%d",(int)drawValue];
            }
            
            NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            
            textStyle.alignment = NSTextAlignmentCenter;
            
            UIFont *textFont = [UIFont systemFontOfSize:10];
            
            CGFloat h=[textFont lineHeight];
            
            //NSLog(@"%@.....%f....checky.",drawString, drawPos);
            
            CGFloat yVal=drawPos;
            
            CGFloat xVal=5;
            
            CGFloat wVal=30.0f;
            
            if (!drawsBG) {
                
                textFont = [UIFont systemFontOfSize:8];
                
                xVal=1;
                
                textStyle.alignment = NSTextAlignmentRight;
                
                wVal=20.0f;
            }
            
            if (_chartType==TYPE_CALS&&i==5) {
                
                
                xVal=-2;
                
                wVal=24.0f;
                
            }
            
            [drawString drawInRect:CGRectMake(xVal, yVal, wVal, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
           // NSLog(@"draw y lable.....%@,%f,%f,%f,%f",drawString,xVal, yVal, wVal, h);
            
            if (i==5&&!drawsBG) {
                
                textFont = [UIFont systemFontOfSize:7];
                
                if (_chartType==TYPE_BP) {
                    
                    drawString=@"mmHg";
                    
                    
                    
                    [drawString drawInRect:CGRectMake(xVal+18, yVal-2, wVal+5, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                }
                
                if (_chartType==TYPE_BG) {
                    
                    drawString=@"mmol/L";
                    
                    [drawString drawInRect:CGRectMake(xVal+18, yVal-2, wVal+7, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    
                }
                
                if (_chartType==TYPE_HR) {
                    
                    drawString=@"bpm";
                    
                    [drawString drawInRect:CGRectMake(xVal+15, yVal-2, wVal, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    
                }
                
                if (_chartType==TYPE_CALS) {
                    
                    
                    
                    if ([[Utility getLanguageCode] isEqualToString:@"en"])
                    {
                          drawString=@"Cal";
                    }
                    else{
                          drawString=@"千卡";
                    }

                    
                    
                    
                    
                    
                    [drawString drawInRect:CGRectMake(xVal+14, yVal, wVal, h+2) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    
                }
                
                
                
                
                
                
                if (_chartType==TYPE_WALKING) {
                    
                    
                    
                    if ([[Utility getLanguageCode] isEqualToString:@"en"])
                    {
                        drawString=@"min";
                    }
                    else{
                        drawString=@"分鐘";
                    }
                    
                    
                    
                    
                    
                    
                    [drawString drawInRect:CGRectMake(xVal+14, yVal, wVal, h+2) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    
                }

                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                if (_chartType==TYPE_WEIGHT_DB) {
                    
                    drawString=[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"];
                    
                    
                    
                    
                    
                    if([[Utility getWeightdisplay] isEqualToString:@"kg"]&&[[Utility getStringByKey:@"kg_unit"] isEqualToString:@"公斤"]){
                        
                        
                        [drawString drawInRect:CGRectMake(xVal+15, yVal, wVal, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    }
                    else{
                        [drawString drawInRect:CGRectMake(xVal+11, yVal, wVal, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                    }
                  
                    
                }

            }
            

            
            //NSLog(@"draw y lable.....%@",drawString);
            
            if (_chartType==TYPE_BPALL||_chartType==TYPE_WEIGHT) {
                
                if (_chartType==TYPE_BPALL) {
                    
                    
                    drawString=[NSString stringWithFormat:@"%d",((int)drawValue-BPALL_MOVE_POS)];
                }
                
                if (_chartType==TYPE_WEIGHT) {
                    
                    drawString=[NSString stringWithFormat:@"%d",((int)drawValue-WEIGHT_MOVE_POS)];
                    
                }
                
                [drawString drawInRect:CGRectMake(5+availableWidth+PADDING+38, drawPos, 30.0f, h) withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor whiteColor]}];
                
            }
        }
    }
    
    
    if (drawsBG) {
        
        CGContextTranslateCTM(c, 0, self.frame.size.height);
        
        CGContextScaleCTM(c, 1, -1);
    }
    

    
    NSMutableDictionary *alertLevelDic= [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"alertlevel_%@",[GlobalVariables shareInstance].login_id]];
    
    CGContextSaveGState(c);
    //draw stand line
    
    int standline_padding=35;
    
    if (_isWatch==1) {
        
        standline_padding=0;
    }
    
    if (_chartType==TYPE_BPALL) {
        
        NSString *sys=[alertLevelDic objectForKey:@"hsystolic"];

        float drawSysValue=[sys floatValue]-testValue;
        
        if ([sys floatValue]>0) {
            
            float drawSysPos=(drawSysValue*percentValue)*oneHeightValue+yStart;
            
            [[UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1] set];
            CGContextSetLineDash(c, 0, dashedPattern, 2);
            CGContextMoveToPoint(c, standline_padding, drawSysPos);
            CGContextAddLineToPoint(c, self.frame.size.width-standline_padding, drawSysPos);
            CGContextStrokePath(c);

        }
        
        
        
        NSString *dia= [alertLevelDic objectForKey:@"hdiastolic"];
        
        float drawDiaValue=[dia floatValue]-testValue;
        
        if ([dia floatValue]>0) {
            
            float drawDiaPos=(drawDiaValue*percentValue)*oneHeightValue+yStart;
            
            [[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1] set];
            CGContextSetLineDash(c, 0, dashedPattern, 2);
            CGContextMoveToPoint(c, standline_padding, drawDiaPos);
            CGContextAddLineToPoint(c, self.frame.size.width-standline_padding, drawDiaPos);
            CGContextStrokePath(c);

        }
        
        
        
        NSString *hr= [alertLevelDic objectForKey:@"bp_hheartrate"];
        
        float drawHRValue=[hr floatValue]+BPALL_MOVE_POS-testValue;
        
        //NSLog(@"%f........hr",drawHRValue);
        
        if ([hr floatValue]) {
            
            float drawHRPos=(drawHRValue*percentValue)*oneHeightValue+yStart;
            
            [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1] set];
            CGContextSetLineDash(c, 0, dashedPattern, 2);
            CGContextMoveToPoint(c, standline_padding, drawHRPos);
            CGContextAddLineToPoint(c, self.frame.size.width-standline_padding, drawHRPos);
            CGContextStrokePath(c);
        }
        
        

        
    }
    else if (_chartType==TYPE_BP){
        
        NSString *sys=[alertLevelDic objectForKey:@"hsystolic"];

//        NSLog(@"draw lint max.....%f",_yMax);
//        NSLog(@"draw lint min.....%f",_yMin);
//        
//        NSLog(@"draw lint sys.....%@",sys);

        
        float drawSysValue=[sys floatValue]-testValue;
        
        if ([sys floatValue]>0&&[sys floatValue]<=_yMax) {
            
            float drawSysPos=(drawSysValue*percentValue)*oneHeightValue+yStart;
            
            CGFloat xVal=0;
            
            CGFloat yVal=self.frame.size.width;
            
            if (!drawsBG) {

                drawSysPos=[self calDashboardValue:[sys floatValue]]+5;// 5 for adjust text label center to line.
                
                xVal=xStart;
                
                yVal=yVal-20;
                
            }
            
            
            [[UIColor colorWithRed:255.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1] set];
            CGContextSetLineDash(c, 0, dashedPattern, 2);
            CGContextMoveToPoint(c, xVal, drawSysPos);
            CGContextAddLineToPoint(c, yVal, drawSysPos);
            CGContextStrokePath(c);
        }
        
        
        
        
        NSString *dia= [alertLevelDic objectForKey:@"hdiastolic"];
        
        //NSLog(@"draw lint dia.....%@",dia);
        
        float drawDiaValue=[dia floatValue]-testValue;
        
        if ([dia floatValue]>0&&[dia floatValue]<=_yMax) {
            
            
            float drawDiaPos=(drawDiaValue*percentValue)*oneHeightValue+yStart;
            
            
            CGFloat xVal=0;
            
            CGFloat yVal=self.frame.size.width;
            
            if (!drawsBG) {

                drawDiaPos=[self calDashboardValue:[dia floatValue]]+5;// 5 for adjust text label center to line.
                
                xVal=xStart;
                
                yVal=yVal-20;
                
            }
            
            [[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1] set];
            CGContextSetLineDash(c, 0, dashedPattern, 2);
            CGContextMoveToPoint(c, xVal, drawDiaPos);
            CGContextAddLineToPoint(c, yVal, drawDiaPos);
            CGContextStrokePath(c);
        }
        
       
        
        
    }
    else if (_chartType==TYPE_HR){
        
        NSString *hr= [alertLevelDic objectForKey:@"bp_hheartrate"];
        
//        NSLog(@"draw lint hr.....%@",hr);
//        NSLog(@"draw lint max h.....%f",_yMax);
//        NSLog(@"draw lint min h.....%f",_yMin);
        
        float drawHRValue=[hr floatValue]-testValue;
        
        if ([hr floatValue]>0&&[hr floatValue]<=_yMax) {
            
            float drawHRPos=(drawHRValue*percentValue)*oneHeightValue+yStart;

            
            CGFloat xVal=0;
            
            CGFloat yVal=self.frame.size.width;
            
            if (!drawsBG) {

                drawHRPos=[self calDashboardValue:[hr floatValue]]+5;
                
                xVal=xStart;
                
                yVal=yVal-20;
                
            }
            
            [[UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:0.0f/255.0f alpha:1] set];
            CGContextSetLineDash(c, 0, dashedPattern, 2);
            CGContextMoveToPoint(c, xVal, drawHRPos);
            CGContextAddLineToPoint(c, yVal, drawHRPos);
            CGContextStrokePath(c);
        }
        
        
        
        

    }
    else if (_chartType==TYPE_BG){
        
        NSString *sys=[alertLevelDic objectForKey:@"hbg_b"];
        
        //NSLog(@"bg b......%@",sys);
        
        float drawSysValue=[sys floatValue]-bg_testValue;
        
        if ([sys floatValue]>0) {
            
            float drawSysPos=(drawSysValue*percentValue)*oneHeightValue+yStart;
            
            [[UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1] set];
            
            
            if (drawsBG) {
                
                CGContextSetLineDash(c, 0, dashedPattern, 2);
                CGContextMoveToPoint(c, standline_padding, drawSysPos);
                CGContextAddLineToPoint(c, self.frame.size.width-standline_padding, drawSysPos);
                CGContextStrokePath(c);
                
            }else{
                
                if ([sys floatValue]<=_yMax) {
                 
                    CGFloat xVal=0;
                    
                    CGFloat yVal=self.frame.size.width;
                    
                    if (!drawsBG) {

                        drawSysPos=[self calDashboardValue:[sys floatValue]]+5;
                        
                        xVal=xStart;
                        
                        yVal=yVal-20;
                   
                    }
                    
                    
                  
                [[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1] set];
                    
                CGContextSetLineDash(c, 0, dashedPattern, 2);
                CGContextMoveToPoint(c, xVal, drawSysPos);
                CGContextAddLineToPoint(c, yVal, drawSysPos);
                CGContextStrokePath(c);
                    
                }
            }
        }
        
        
        
        NSString *dia= [alertLevelDic objectForKey:@"hbg_a"];
        
       //  NSLog(@"bg a......%@",dia);
        
        float drawDiaValue=[dia floatValue]-bg_testValue;
        
        if ([dia floatValue]>0) {
            
            float drawDiaPos=(drawDiaValue*percentValue)*oneHeightValue+yStart;
            
            [[UIColor colorWithRed:120.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1] set];
            
            
            if (drawsBG) {
                
                CGContextSetLineDash(c, 0, dashedPattern, 2);
                CGContextMoveToPoint(c, standline_padding, drawDiaPos);
                CGContextAddLineToPoint(c, self.frame.size.width-standline_padding, drawDiaPos);
                CGContextStrokePath(c);
            }else{
                
                if ([dia floatValue]<=_yMax) {
                    
                    CGFloat xVal=0;
                    
                    CGFloat yVal=self.frame.size.width;
                  
                    if (!drawsBG) {

                        drawDiaPos=[self calDashboardValue:[dia floatValue]]+5;
                        
                        xVal=xStart;
                        
                        yVal=yVal-20;
                        
                    }
                
                     [[UIColor colorWithRed:220.0f/255.0f green:80.0f/255.0f blue:220.0f/255.0f alpha:1] set];
                    
                CGContextSetLineDash(c, 0, dashedPattern, 2);
                CGContextMoveToPoint(c, xVal, drawDiaPos);
                CGContextAddLineToPoint(c, yVal, drawDiaPos);
                CGContextStrokePath(c);
                    
                }
            }

        }
        
        
        
        NSString *hr= [alertLevelDic objectForKey:@"hbg"];
        
       //  NSLog(@"bg f......%@",hr);
        
        float drawHRValue=[hr floatValue]-bg_testValue;
        
        if ([hr floatValue]) {
            
            float drawHRPos=(drawHRValue*percentValue)*oneHeightValue+yStart;
            
            
            [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1] set];
            
            
            if (drawsBG) {
                
                CGContextSetLineDash(c, 0, dashedPattern, 2);
                CGContextMoveToPoint(c, standline_padding, drawHRPos);
                CGContextAddLineToPoint(c, self.frame.size.width-standline_padding, drawHRPos);
                CGContextStrokePath(c);
            }else{
                
                if ([hr floatValue]<=_yMax) {
                    
                    CGFloat xVal=0;
                    
                    CGFloat yVal=self.frame.size.width;
                    
                    if (!drawsBG) {

                        drawHRPos=[self calDashboardValue:[hr floatValue]]+5;
                        
                        xVal=xStart;
                        
                        yVal=yVal-20;
                        
                    }
                 [[UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:0.0f/255.0f alpha:1] set];
                CGContextSetLineDash(c, 0, dashedPattern, 2);
                CGContextMoveToPoint(c, xVal, drawHRPos);
                CGContextAddLineToPoint(c, yVal, drawHRPos);
                CGContextStrokePath(c);
                    
                }
            }
        }
        
        
        
    }
    else if (_chartType==TYPE_WEIGHT||_chartType==TYPE_BMI){
        
        
        NSString *hr= [alertLevelDic objectForKey:@"hbmi"];
        
        float drawHRValue=[hr floatValue]-testValue;
        
//        NSLog(@"%f........bmi",[hr floatValue]);
//        NSLog(@"draw lint max h.....%f",_yMax);
//        NSLog(@"draw lint min h.....%f",_yMin);
        
        if ([hr floatValue]>0) {
            
            
            float drawHRPos=(drawHRValue*percentValue)*oneHeightValue+yStart;
            
            if (_chartType==TYPE_BMI) {
                
                [[UIColor colorWithRed:0.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1] set];
                
            }else{
                
                [[UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1] set];
                
                
            }
            
            
            if (drawsBG) {
                
                drawHRPos=((drawHRValue+WEIGHT_MOVE_POS)*percentValue)*oneHeightValue+yStart;
                
                CGContextSetLineDash(c, 0, dashedPattern, 2);
                CGContextMoveToPoint(c, standline_padding, drawHRPos);
                CGContextAddLineToPoint(c, self.frame.size.width-standline_padding, drawHRPos);
                CGContextStrokePath(c);
                
            }else{
                
                if ([hr floatValue]<=_yMax) {
                    
                    CGFloat xVal=0;
                    
                    CGFloat yVal=self.frame.size.width;
                    
                    if (!drawsBG) {
                        
                        drawHRPos=[self calDashboardValue:[hr floatValue]]+5;
                        
                        xVal=xStart;
                        
                        yVal=yVal-20;
                        
                    }
                    
               // drawHRPos=([hr floatValue]*percentValue)*oneHeightValue+yStart;
                CGContextSetLineDash(c, 0, dashedPattern, 2);
                CGContextMoveToPoint(c, xVal, drawHRPos);
                CGContextAddLineToPoint(c, yVal, drawHRPos);
                CGContextStrokePath(c);
                    
                }
                
                
            }
        }
        
        
        
        
        
    }
    
     CGContextRestoreGState(c);
    

    
    if (!self.drawsAnyData) {
        NSLog(@"You configured LineChartView to draw neither lines nor data points. No data will be visible. This is most likely not what you wanted. (But we aren't judging you, so here's your chart background.)");
    } // warn if no data will be drawn

    
    //draw line and point
    
    for(LineChartData *data in self.data) {
        if (self.drawsDataLines) {
            float xRangeLen = data.xMax - data.xMin;
            if(data.itemCount >= 2) {
                LineChartDataItem *datItem = data.getData(0);
               //NSLog(@"miss...0......%ld,%@",(long)datItem.missPre,datItem.xLabel);
                CGMutablePathRef path = CGPathCreateMutable();

                CGFloat xVal;
                CGFloat yVal = (datItem.y*percentValue)*oneHeightValue-testValue+yStart;
                
                if (!drawsBG) {
                    
                    yVal=[self calDashboardValue:datItem.y]+5;

                    
                }
                
                if (!drawsBG) {
                    
                    xVal = xStart + round(((datItem.x - data.xMin) / xRangeLen) * availableWidth);

                    
                }else{
                    
                    float xRangeLen = _xMax - _xMin;
                    
                    xVal = round((xRangeLen == 0 ? 0.5 : ((datItem.x - _xMin) / xRangeLen)) * availableWidth)+xStart;
                
                }
                
                

                
                if (datItem.missPre==0) {
                    
                    
                }else{
                    
                    CGPathMoveToPoint(path, NULL,
                                      xVal,
                                      yVal);
                }

               
                for(NSUInteger i = 1; i < data.itemCount; i++) {
                    
                    LineChartDataItem *beforItem = data.getData(i-1);
                    
                    LineChartDataItem *datItem = data.getData(i);
                    
                   // NSLog(@"miss.........%ld,%@",(long)datItem.missPre,datItem.xLabel);
                    
                    //LineChartDataItem *nextItem = data.getData(i+1);
                    
                    if (!drawsBG) {
                        
                        xVal = xStart + round(((datItem.x - data.xMin) / xRangeLen) * availableWidth);
                        
                        
                    }else{
                        
                        float xRangeLen = _xMax - _xMin;
                        
                        xVal = round((xRangeLen == 0 ? 0.5 : ((datItem.x - _xMin) / xRangeLen)) * availableWidth)+xStart;
                        
                    }

                    CGFloat yVal = (datItem.y*percentValue)*oneHeightValue-testValue+yStart;
                    
                    
                    if (!drawsBG) {
                        
                        yVal=[self calDashboardValue:datItem.y]+5;
 
                        
                    }

                    
                    if(beforItem.missPre==1||beforItem.missPre==-1){

                        
                        if(datItem.missPre==1||datItem.missPre==-1){
                            
                            CGPathAddLineToPoint(path, NULL,
                                                 xVal,
                                                 yVal);
                            
                            //NSLog(@"add line......%lu",(unsigned long)i);
                            
                        }else{
                            
                            CGContextAddPath(c, path);
                            CGContextSetStrokeColorWithColor(c, [data.color CGColor]);
                            CGContextSetLineWidth(c, 2);
                            CGContextSetLineCap(c, kCGLineCapRound);
                            CGContextSetLineJoin(c, kCGLineJoinRound);
                            CGContextSetAllowsAntialiasing(c, YES);
                            CGContextStrokePath(c);

                            
                        }
                        
                    }else{
                        
                        
                        if(datItem.missPre==1){
                            
                            
                            path = CGPathCreateMutable();
                            
                            CGFloat xValb;
                            CGFloat yValb = (beforItem.y*percentValue)*oneHeightValue-testValue+yStart;
                            
                            if (!drawsBG) {
                                
                                yValb=[self calDashboardValue:beforItem.y]+5;
                                
                                
                            }
                            
                            if (!drawsBG) {
                                
                                xValb = xStart + round(((beforItem.x - data.xMin) / xRangeLen) * availableWidth);
                                
                                
                            }else{
                                
                                float xRangeLen = _xMax - _xMin;
                                
                                xValb = round((xRangeLen == 0 ? 0.5 : ((beforItem.x - _xMin) / xRangeLen)) * availableWidth)+xStart;
                                
                            }
                            
                            
                            
                            
                             CGPathMoveToPoint(path, NULL,
                                                  xValb,
                                                  yValb);

                            CGPathAddLineToPoint(path, NULL,
                                                 xVal,
                                                 yVal);
                            
                            //NSLog(@"add line......%lu",(unsigned long)i);
                            
                        }else{
                            
                            CGContextAddPath(c, path);
                            CGContextSetStrokeColorWithColor(c, [data.color CGColor]);
                            CGContextSetLineWidth(c, 2);
                            CGContextSetLineCap(c, kCGLineCapRound);
                            CGContextSetLineJoin(c, kCGLineJoinRound);
                            CGContextSetAllowsAntialiasing(c, YES);
                            CGContextStrokePath(c);
                            
                            
                        }
                        
                        
                        
                        
                    }

                    
                }
                
                
                CGContextAddPath(c, path);
                CGContextSetStrokeColorWithColor(c, [data.color CGColor]);
                CGContextSetLineWidth(c, 2);
                CGContextSetLineCap(c, kCGLineCapRound);
                CGContextSetLineJoin(c, kCGLineJoinRound);
                CGContextSetAllowsAntialiasing(c, YES);
                CGContextStrokePath(c);
                //NSLog(@"end......");
                CGPathRelease(path);
            }
        }
        
        
        
        // draw data points
        if (self.drawsDataPoints) {
            float xRangeLen = data.xMax - data.xMin;
            for(NSUInteger i = 0; i < data.itemCount; ++i) {
                LineChartDataItem *datItem = data.getData(i);
                CGFloat xVal;
                
                
                
                if (!drawsBG) {
                    
                    xVal = xStart + round((xRangeLen == 0 ? 0.5 : ((datItem.x - data.xMin) / xRangeLen)) * availableWidth);
                    
                    
                }else{
                    
                    float xRangeLen = _xMax - _xMin;
                    
                    //NSLog(@"date.......%@........%f",[NSDate dateWithTimeIntervalSince1970:datItem.x],datItem.y);
                    
                    xVal = round((xRangeLen == 0 ? 0.5 : ((datItem.x - _xMin) / xRangeLen)) * availableWidth)+xStart;
                    
                    
                }
                
                

                CGFloat yVal = (datItem.y*percentValue)*oneHeightValue-testValue+yStart;
                
                if (!drawsBG) {
                    
                    yVal=[self calDashboardValue:datItem.y]+5;
                    
                    
                   
                    
                }
                //[self.backgroundColor setFill];
                //[data.color setFill];
                //CGContextFillEllipseInRect(c, CGRectMake(xVal - 5.5, yVal - 5.5, 11, 11));
                [data.color setFill];
                CGContextFillEllipseInRect(c, CGRectMake(xVal - 4, yVal - 4, 8, 8));
                //[data.color setFill];
                //CGContextFillEllipseInRect(c, CGRectMake(xVal - 3, yVal - 3, 5, 5));
            } // for
        }
    }
}

- (void)showIndicatorForTouch:(UITouch *)touch {
    if(! self.infoView) {
        self.infoView = [[InfoView alloc] init];
        [self addSubview:self.infoView];
    }
    
    CGPoint pos = [touch locationInView:self];
    CGFloat xStart = PADDING + self.yAxisLabelsWidth;
    CGFloat yStart = PADDING;
    CGFloat yRangeLen = self.yMax - self.yMin;
    CGFloat xPos = pos.x - xStart;
    CGFloat yPos = pos.y - yStart;
    CGFloat availableWidth = self.bounds.size.width - 2 * PADDING - self.yAxisLabelsWidth;
    CGFloat availableHeight = self.bounds.size.height - 2 * PADDING - X_AXIS_SPACE;
    
    LineChartDataItem *closest = nil;
    float minDist = FLT_MAX;
    float minDistY = FLT_MAX;
    CGPoint closestPos = CGPointZero;
    
    for(LineChartData *data in self.data) {
        float xRangeLen = data.xMax - data.xMin;
        for(NSUInteger i = 0; i < data.itemCount; ++i) {
            LineChartDataItem *datItem = data.getData(i);
            CGFloat xVal = round((xRangeLen == 0 ? 0.5 : ((datItem.x - data.xMin) / xRangeLen)) * availableWidth);
            CGFloat yVal = round((1.0 - (datItem.y - self.yMin) / yRangeLen) * availableHeight);
            
            float dist = fabs(xVal - xPos);
            float distY = fabs(yVal - yPos);
            if(dist < minDist || (dist == minDist && distY < minDistY)) {
                minDist = dist;
                minDistY = distY;
                closest = datItem;
                closestPos = CGPointMake(xStart + xVal - 3, yStart + yVal - 7);
            }
        }
    }
    
    self.infoView.infoLabel.text = closest.dataLabel;
    self.infoView.tapPoint = closestPos;
    [self.infoView sizeToFit];
    [self.infoView setNeedsLayout];
    [self.infoView setNeedsDisplay];
    
    if(self.currentPosView.alpha == 0.0) {
        CGRect r = self.currentPosView.frame;
        r.origin.x = closestPos.x + 3 - 1;
        self.currentPosView.frame = r;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self.infoView.alpha = 1.0;
        self.currentPosView.alpha = 1.0;
        self.xAxisLabel.alpha = 1.0;
        
        CGRect r = self.currentPosView.frame;
        r.origin.x = closestPos.x + 3 - 1;
        self.currentPosView.frame = r;
        
        self.xAxisLabel.text = closest.xLabel;
        if(self.xAxisLabel.text != nil) {
            [self.xAxisLabel sizeToFit];
            r = self.xAxisLabel.frame;
            r.origin.x = round(closestPos.x - r.size.width / 2);
            self.xAxisLabel.frame = r;
        }
    }];
}

- (void)hideIndicator {
    [UIView animateWithDuration:0.1 animations:^{
        self.infoView.alpha = 0.0;
        self.currentPosView.alpha = 0.0;
        self.xAxisLabel.alpha = 0.0;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_enableTouch) {
        
        [self showIndicatorForTouch:[touches anyObject]];
    }
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    if (_enableTouch) {
        
        [self showIndicatorForTouch:[touches anyObject]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    if (_enableTouch) {
        
       [self hideIndicator];
    }
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_enableTouch) {
        
        [self hideIndicator];

    }
}


#pragma mark Helper methods

- (BOOL)drawsAnyData {
    return self.drawsDataPoints || self.drawsDataLines;
}

// TODO: This should really be a cached value. Invalidated iff ySteps changes.
- (CGFloat)yAxisLabelsWidth {
    NSNumber *requiredWidth = [[self.ySteps mapWithBlock:^id(id obj) {
        NSString *label = (NSString*)obj;
        CGSize labelSize = [label sizeWithAttributes:@{NSFontAttributeName:self.scaleFont}];
        return @(labelSize.width); // Literal NSNumber Conversion
    }] valueForKeyPath:@"@max.self"]; // gets biggest object. Yeah, NSKeyValueCoding. Deal with it.
    return [requiredWidth floatValue] + PADDING;
}

- (CGFloat)calDashboardValue:(CGFloat)theValue {
    
//    NSLog(@"%f....checky...the value",theValue);
//
//    NSLog(@"%f.......the value2",((theValue-_yMin)/(_yMax-_yMin)));
//    
//    NSLog(@"%f.......the value3",(self.frame.size.height-40));
    

    CGFloat availableHeight=self.frame.size.height-20;
    
    //CGFloat availableWidth=self.frame.size.width-10;
    
    CGFloat oneHeightValue = 1/((_yMax-_yMin)/availableHeight);

    
    //CGFloat totalValue=_yMax-_yMin;
    
    //CGFloat percentValue=totalValue/_yMax;
    
    float result=((_yMax-theValue))*oneHeightValue;
    
    //float result= ((theValue-_yMin)/(_yMax-_yMin))*(self.frame.size.height-20);//(self.frame.size.height-40);
    
    //NSLog(@"%f...checky..result",result);
    
    return result;
    
}

- (UIImage *)graphImage
{
    [self.currentPosView removeFromSuperview];

    [self.legendView removeFromSuperview];
    
    [self.xAxisLabel removeFromSuperview];


    CGRect scrollViewFrame = self.frame;
    
    
    UIGraphicsBeginImageContext(scrollViewFrame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext: context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    

    
    return viewImage;
}

@end
