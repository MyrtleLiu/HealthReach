//
//  ChooseHistoryController.h
//  mHealth WatchKit Extension
//
//  Created by smartone_sn on 15/7/23.
//
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface HistoryDetailController : WKInterfaceController{
    
    NSString *currentType;
}


@property(nonatomic, retain) IBOutlet WKInterfaceButton *btn7d;
@property(nonatomic, retain) IBOutlet WKInterfaceButton *btn14d;
@property(nonatomic, retain) IBOutlet WKInterfaceButton *btn1m;
@property(nonatomic, retain) IBOutlet WKInterfaceButton *btn3m;


@property(nonatomic, retain) IBOutlet WKInterfaceGroup *bpGroup;
@property(nonatomic, retain) IBOutlet WKInterfaceGroup *bgGroup;
@property(nonatomic, retain) IBOutlet WKInterfaceGroup *weightGroup;
@property(nonatomic, retain) IBOutlet WKInterfaceGroup *calGroup;

@property(nonatomic, retain) IBOutlet WKInterfaceImage *chartImg;


@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bp_sys_Label;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bp_dia_Label;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bp_hr_Label;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bp_time_Label;

@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bg_value_Label;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bg_type_Label;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bg_time_Label;

@property(nonatomic, retain) IBOutlet WKInterfaceLabel *weight_value_Label;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *weight_bmi_Label;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *weight_time_Label;

@property(nonatomic, retain) IBOutlet WKInterfaceLabel *cal_value_Label;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *cal_time_Label;

-(IBAction)change7dChart:(id)sender;
-(IBAction)change14dChart:(id)sender;
-(IBAction)change1mChart:(id)sender;
-(IBAction)change3mChart:(id)sender;

@end
