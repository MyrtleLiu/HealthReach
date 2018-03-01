//
//  PedometerController.h
//  mHealth
//
//  Created by smartone_sn2 on 15/8/5.
//
//

#import <WatchKit/WatchKit.h>
#import "RelativeFitDataKit.h"

@interface PedometerController : WKInterfaceController

@property(nonatomic, retain) IBOutlet WKInterfaceButton *startBtn;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *timeLabel;

@property(nonatomic, retain) IBOutlet WKInterfaceLabel *distanceLabel;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *distanceValueLabel;

@property(nonatomic, retain) IBOutlet WKInterfaceLabel *stepsLabel;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *stepsValueLabel;

@property(nonatomic, retain) IBOutlet WKInterfaceLabel *paceLabel;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *paceValueLabel;

@property(nonatomic, retain) IBOutlet WKInterfaceLabel *calsLabel;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *calsValueLabel;

@property (strong, nonatomic) NSTimer *clockTimer;
@property (nonatomic) NSDate* startTime;
@property (nonatomic) NSString* steps;

@property (nonatomic) NSString* startBtnTitle;

@property (strong, nonatomic) FITPedometer *fitPedometer;


@end
