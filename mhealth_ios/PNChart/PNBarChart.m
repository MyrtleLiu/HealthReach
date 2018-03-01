//
//  PNBarChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNBarChart.h"
#import "PNColor.h"
#import "PNChartLabel.h"


@interface PNBarChart () {
    
}

- (UIColor *)barColorAtIndex:(NSUInteger)index;

@end

@implementation PNBarChart

@synthesize bars,labels;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds   = YES;
        _showLabel           = YES;
        _barBackgroundColor  = PNLightGrey;
        _labelTextColor      = [UIColor whiteColor];
        _labelFont           = [UIFont systemFontOfSize:10.0f];
        //self.labels              = [NSMutableArray array];
        //self.bars                = [NSMutableArray array];
        _xLabelSkip          = 1;
        _yLabelSum           = 4;
        _labelMarginTop      = 10;
        _chartMargin         = 8.0;
        _barRadius           = 2.0;
        _showChartBorder     = YES;
        _yChartLabelWidth    = 18;
    }

    return self;
}


- (void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    
    if (_yMaxValue) {
        _yValueMax = _yMaxValue;
    }else{
        [self getYValueMax:yValues];
    }
   // _yValueMax=100;

   // _xLabelWidth = (self.frame.size.width - _chartMargin * 2) / [_yValues count];
}

- (void)setYValueMax:(int)yMax{
    
    _yValueMax=yMax;
}

- (void)setShowLabel:(BOOL)showLabel{
    
    _showLabel=showLabel;
}


- (void)getYValueMax:(NSArray *)yLabels
{
    int max = [[yLabels valueForKeyPath:@"@max.intValue"] intValue];
    
    _yValueMax = (int)max;
    
    if (_yValueMax == 0) {
        _yValueMax = _yMinValue;
    }
}


- (void)setYLabels:(NSArray *)yLabels
{
    _yLabels=yLabels;
    
    _yLabelSum=[_yLabels count];
}


- (void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;

    
    _xLabelWidth = (self.frame.size.width - _chartMargin * 2) / [xLabels count]-5;
    
}


- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
}

-(void)setTheBarWidth:(int)width{
    
    _barWidth=width;
    _chartMargin=10;
    _labelMarginTop=5.0;
}

- (void)strokeChart
{

    if (self.labels==nil) {
        
        self.labels= [[NSMutableArray alloc] init];
        
    }
    
    if (self.bars==nil) {
        
        self.bars= [[NSMutableArray alloc] init];
        
    }

    [self viewCleanupForCollection:self.labels];
    
   // NSLog(@"%d.....%d",self.labels.count,self.bars.count);
    
    //Add Labels
    if (_showLabel) {
        
        NSLog(@"show label....");
        //Add x labels
        int labelAddCount = 0;
        for (int index = 0; index < _xLabels.count; index++) {
            labelAddCount += 1;
            
            //if (labelAddCount == _xLabelSkip) {
                NSString *labelText = _xLabels[index];
                PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectZero];
                label.font = [UIFont systemFontOfSize:10];
                label.textColor = [UIColor whiteColor];
                [label setTextAlignment:NSTextAlignmentCenter];
                label.text = labelText;
                [label sizeToFit];
                CGFloat labelXPosition  = (index *  _xLabelWidth + _chartMargin + _xLabelWidth /2.0 );
                
                label.center = CGPointMake(labelXPosition,
                                           self.frame.size.height - xLabelHeight - _chartMargin + label.frame.size.height /2.0 + _labelMarginTop);
                labelAddCount = 0;
                
            
                [self.labels addObject:label];
                [self addSubview:label];
            //}
        }
        
        //Add y labels
        
        float yLabelSectionHeight = (self.frame.size.height - _chartMargin * 2 - xLabelHeight) / _yLabelSum;
        
        for (int index = 0; index < _yLabelSum; index++) {

            NSString *labelText = [NSString stringWithFormat:@"%.0f%@",(float)_yValueMax * ( (_yLabelSum - index) / (float)_yLabelSum ),@"%"];
            
            //NSString *labelText = [_yLabels objectAtIndex:index];
            
            PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(index==0?-16:-11,
                                                                                  yLabelSectionHeight * index + _chartMargin - yLabelHeight/2.0,
                                                                                  _yChartLabelWidth,
                                                                                  yLabelHeight)];
            label.font = [UIFont systemFontOfSize:8];
            label.textColor = [UIColor whiteColor];
            [label setTextAlignment:NSTextAlignmentRight];
            label.text = labelText;
            [label sizeToFit];
            //label.center = CGPointMake(102,yLabelSectionHeight * index + _chartMargin - yLabelHeight/2.0);
            
            NSLog(@"add y label......%@",labelText);
            
            [self.labels addObject:label];
            [self addSubview:label];
            
            if ([labelText isEqualToString:@"20%"]) {
                
                PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(-6,
                                                                                      yLabelSectionHeight * (index+1) + _chartMargin - yLabelHeight/2.0,
                                                                                      _yChartLabelWidth,
                                                                                      yLabelHeight)];
                label.font = [UIFont systemFontOfSize:8];
                label.textColor = [UIColor whiteColor];
                [label setTextAlignment:NSTextAlignmentRight];
                label.text = @"0%";
                [label sizeToFit];
                //label.center = CGPointMake(102,yLabelSectionHeight * index + _chartMargin - yLabelHeight/2.0);
                
                NSLog(@"add y label......%@",labelText);
                
                [self.labels addObject:label];
                [self addSubview:label];
                
            }

            

        }
    }
    

    [self viewCleanupForCollection:self.bars];
    
    
    //Add bars
    CGFloat chartCavanHeight = self.frame.size.height - _chartMargin * 2 - xLabelHeight;
    NSInteger index = 0;

    for (NSNumber *valueString in _yValues) {
        float value = [valueString floatValue];

        //NSLog(@"the result.....111.......%f",value);
        
        float grade = (float)value / (float)_yValueMax;
        
        if (isnan(grade)) {
            grade = 0;
        }
        
        //NSLog(@"the result.....2222.......%f",grade);
        
        PNBar *bar;
        CGFloat barWidth;
        CGFloat barXPosition;
        
        if (_barWidth) {
            barWidth = _barWidth;
            barXPosition = index *  _xLabelWidth + _chartMargin + _xLabelWidth /2.0 - _barWidth /2.0;
            
            
            
        }else{
            barXPosition = index *  _xLabelWidth + _chartMargin + _xLabelWidth * 0.25;
            if (_showLabel) {
                barWidth = _xLabelWidth * 0.5;
                
            }
            else {
                barWidth = _xLabelWidth * 0.6;
                
            }
        }
        
        bar = [[PNBar alloc] initWithFrame:CGRectMake(barXPosition, //Bar X position
                                                      self.frame.size.height - chartCavanHeight - xLabelHeight - _chartMargin, //Bar Y position
                                                      barWidth, // Bar witdh
                                                      chartCavanHeight)]; //Bar height
        
        //Change Bar Radius
        bar.barRadius = _barRadius;
        
        //Change Bar Background color
        bar.backgroundColor = PNCleanGrey;
        
        //Bar StrokColor First
        if (self.strokeColor) {
            bar.barColor = self.strokeColor;
        }else{
            bar.barColor = [self barColorAtIndex:index];
        }
        
        //bar.barColor =[UIColor colorWithRed:127 green:127 blue:127 alpha:1];
        
        //Height Of Bar
        bar.grade = grade;
        
        // Add gradient
        bar.barColorGradientStart = _barColorGradientStart;
        

        //For Click Index
        bar.tag = index;
        
        [bar setNeedsDisplay];
        
        [self.bars addObject:bar];
        [self addSubview:bar];

        index += 1;
    }
    
    
    
   // NSLog(@"%d..2...%d",self.labels.count,self.bars.count);
    
    
    //Add chart border lines
    
    //if (_showChartBorder) {
        _chartBottomLine = [CAShapeLayer layer];
        _chartBottomLine.lineCap      = kCALineCapButt;
        _chartBottomLine.fillColor    = [[UIColor whiteColor] CGColor];
        _chartBottomLine.lineWidth    = 1.0;
        _chartBottomLine.strokeEnd    = 0.0;
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        
        [progressline moveToPoint:CGPointMake(_chartMargin, self.frame.size.height - xLabelHeight - _chartMargin)];
        [progressline addLineToPoint:CGPointMake(self.frame.size.width - _chartMargin,  self.frame.size.height - xLabelHeight - _chartMargin)];
        
        [progressline setLineWidth:1.0];
        [progressline setLineCapStyle:kCGLineCapSquare];
        _chartBottomLine.path = progressline.CGPath;
        
        
        _chartBottomLine.strokeColor = PNLightGrey.CGColor;
        
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.5;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;
        [_chartBottomLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        _chartBottomLine.strokeEnd = 1.0;
        
        [self.layer addSublayer:_chartBottomLine];
        
        //Add left Chart Line
        
        _chartLeftLine = [CAShapeLayer layer];
        _chartLeftLine.lineCap      = kCALineCapButt;
        _chartLeftLine.fillColor    = [[UIColor whiteColor] CGColor];
        _chartLeftLine.lineWidth    = 1.0;
        _chartLeftLine.strokeEnd    = 0.0;
        
        UIBezierPath *progressLeftline = [UIBezierPath bezierPath];
        
        [progressLeftline moveToPoint:CGPointMake(_chartMargin, self.frame.size.height - xLabelHeight - _chartMargin)];
        [progressLeftline addLineToPoint:CGPointMake(_chartMargin,  _chartMargin)];
        
        [progressLeftline setLineWidth:1.0];
        [progressLeftline setLineCapStyle:kCGLineCapSquare];
        _chartLeftLine.path = progressLeftline.CGPath;
        
        
        _chartLeftLine.strokeColor = PNLightGrey.CGColor;
        
        
        CABasicAnimation *pathLeftAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathLeftAnimation.duration = 0.5;
        pathLeftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathLeftAnimation.fromValue = @0.0f;
        pathLeftAnimation.toValue = @1.0f;
        [_chartLeftLine addAnimation:pathLeftAnimation forKey:@"strokeEndAnimation"];
        
        _chartLeftLine.strokeEnd = 1.0;
        
        [self.layer addSublayer:_chartLeftLine];
    //}
}


- (void)viewCleanupForCollection:(NSMutableArray *)array
{

    if (array.count) {

        [array makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [array removeAllObjects];
    }
}


#pragma mark - Class extension methods

- (UIColor *)barColorAtIndex:(NSUInteger)index
{
    if ([self.strokeColors count] == [self.yValues count]) {
        return self.strokeColors[index];
    }
    else {
        return self.strokeColor;
    }
}


#pragma mark - Touch detection

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchPoint:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}


- (void)touchPoint:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Get the point user touched
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    UIView *subview = [self hitTest:touchPoint withEvent:nil];
    
    if ([subview isKindOfClass:[PNBar class]] && [self.delegate respondsToSelector:@selector(userClickedOnBarCharIndex:)]) {
        [self.delegate userClickedOnBarCharIndex:subview.tag];
    }
}


@end
