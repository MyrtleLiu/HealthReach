//
//  ViewController.m
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright (c) 2012 Pete Callaway. All rights reserved.
//

#import "DSLCalendarView.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "MR_ListViewController.h"
#import "AddReminderViewController.h"
@interface ViewController () <DSLCalendarViewDelegate>

@property (nonatomic, weak) IBOutlet DSLCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.calendarView.delegate = self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (iPhone5) {
        self = [super initWithNibName:@"ViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"ViewController" bundle:nibBundleOrNil];
    }
    if (self) {
        //Custom initialization
    }
    return self;
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - DSLCalendarViewDelegate methods
#pragma mark -- 触发事件
- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range {
    
    if (range != nil) {
        NSLog( @"Selected %d/%d - %d/%d", range.startDay.day, range.startDay.month, range.endDay.day, range.endDay.month);
        NSString *str=[[NSString alloc]initWithFormat:@"%d-",range.endDay.day];
        NSString *str1=[[NSString alloc]initWithFormat:@"%d",range.endDay.month];
        NSString*sum1=[[NSString alloc] initWithFormat:@"%@%@",str,str1];
        NSLog(@"%@",sum1);
        NSString *str2=[[NSString alloc]initWithFormat:@"%d-",range.startDay.day];
        NSString *str3=[[NSString alloc]initWithFormat:@"%d",range.startDay.month];
        NSString*sum2=[[NSString alloc] initWithFormat:@"%@%@",str2,str3];
        NSLog(@"%@",sum2);
        NSString*sum3;
        sum3=sum2;
        NSLog(@"sum3==%@",sum3);
        NSString*dateDateStrSum=[[NSString alloc] initWithFormat:@"%d-%d-%d",range.endDay.day,range.endDay.month,range.endDay.year];
   
        dateDate=dateDateStrSum;
        NSLog(@"%@",dateDateStrSum);
    }
    else {
    
        NSLog( @"No selection%@",[NSDate date] );
    }
 
    
}
#pragma mark -- 触发事件
- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range {
    if (NO) { // Only select a single day
        return [[DSLCalendarRange alloc] initWithStartDay:day endDay:day];
    }
    else if (NO) { // Don't allow selections before today
        NSDateComponents *today = [[NSDate date] dslCalendarView_dayWithCalendar:calendarView.visibleMonth.calendar];
        
        NSDateComponents *startDate = range.startDay;
        NSDateComponents *endDate = range.endDay;
        
        if ([self day:startDate isBeforeDay:today] && [self day:endDate isBeforeDay:today]) {
            return nil;
        }
        else {
            if ([self day:startDate isBeforeDay:today]) {
                startDate = [today copy];
            }
            if ([self day:endDate isBeforeDay:today]) {
                endDate = [today copy];
            }
            
            return [[DSLCalendarRange alloc] initWithStartDay:startDate endDay:endDate];
        }
    }
    
    return range;
}

- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    NSLog(@"Will show %@ in %.3f seconds", month, duration);
}

- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
    NSLog(@"Now showing %@", month);
}

- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2 {
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}
-(IBAction)ReminderList:(id)sender
{
    
    MR_ListViewController *homeView = [[MR_ListViewController alloc]initWithNibName:@"MR_ListViewController" bundle:nil];
    if (dateDate) {
        homeView.dateDateStr=dateDate;
    }
    else
    {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"d-M-yyyy"];
        NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
        dateDate=currentDateStr;
        homeView.dateDateStr=dateDate;
    }

  [self.navigationController pushViewController:homeView animated:YES];
    // [self presentViewController:homeView animated:YES completion:nil];

}
-(IBAction)Back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)GoHome:(id)sender
{
//    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
//    [self.navigationController pushViewController:homeView animated:YES];
  //    [self presentViewController:homeView animated:YES completion:nil];
    [self backToHome];
}
-(IBAction)AddReminder:(id)sender
{
   AddReminderViewController *homeView = [[AddReminderViewController alloc]initWithNibName:@"AddReminderViewController" bundle:nil];

    if (dateDate) {
            homeView.dateDateStr=dateDate;
    }
else
    {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d-M-yyyy"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    dateDate=currentDateStr;
          homeView.dateDateStr=dateDate;
     
    }
       [self.navigationController pushViewController:homeView animated:YES];
   // [self presentViewController:homeView animated:YES completion:nil];
}
-(IBAction)buttonDay:(id)sender
{
    self.calendarView.hidden=YES;
    
    
}
-(IBAction)buttonMonth:(id)sender
{
       self.calendarView.hidden=NO;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(void) backToHome{
    
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: 1] animated:YES];
}





@end
