//
//  ViewController.h
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright (c) 2012 Pete Callaway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
   IBOutlet  UITableView* _tableDayView;
    NSString * dateDate;
   
    
}

-(IBAction)GoHome:(id)sender;
-(IBAction)ReminderList:(id)sender;
-(IBAction)AddReminder:(id)sender;
-(IBAction)Back:(id)sender;
-(IBAction)buttonDay:(id)sender;
-(IBAction)buttonMonth:(id)sender;
@end
