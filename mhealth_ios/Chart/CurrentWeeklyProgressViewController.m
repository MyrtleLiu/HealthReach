//
//  CurrentWeeklyProgressViewController.m
//  mHealth
//
//  Created by gz dev team on 14年2月27日.
//
//

#import "CurrentWeeklyProgressViewController.h"
#import "HomeViewController.h"
@interface CurrentWeeklyProgressViewController ()

@end

@implementation CurrentWeeklyProgressViewController
@synthesize dataForPlot;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animatedr
{
    [super viewDidLoad];
    _arrayYear=[NSMutableArray new];
    _tableView=[[UITableView alloc]initWithFrame:aView.bounds style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [aView addSubview:_tableView];

    
    NSLog(@"nowDate ＝%@",self.nowDate);
    NSTimeInterval secondsPerDay = (24*60*60);
    NSDate *secondDay = [self.nowDate dateByAddingTimeInterval:secondsPerDay];
    NSLog(@"secondDay= %@",secondDay);
    NSTimeInterval thirdPerDay = (24*60*60)*2;
    NSDate *thirdDay = [self.nowDate dateByAddingTimeInterval:thirdPerDay];
    NSLog(@"secondDay= %@",thirdDay);
    NSTimeInterval fourthPerDay = (24*60*60)*3;
    NSDate *fourthDay =[self.nowDate dateByAddingTimeInterval:fourthPerDay];
    NSLog(@"secondDay= %@",fourthDay);
    NSTimeInterval fifthPerDay = (24*60*60)*4;
    NSDate *fifthDay = [self.nowDate dateByAddingTimeInterval:fifthPerDay];
    NSLog(@"secondDay= %@",fifthDay);
    NSTimeInterval sixthPerDay = (24*60*60)*5;
    NSDate *sixthDay = [self.nowDate dateByAddingTimeInterval:sixthPerDay];
    NSLog(@"secondDay= %@",sixthDay);
    NSTimeInterval seventhPerDay = (24*60*60)*6;
    NSDate *seventhDay = [self.nowDate dateByAddingTimeInterval:seventhPerDay];
    NSLog(@"secondDay= %@",seventhDay);
    
    
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM"];
    NSDateFormatter* dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"%@...." ,dateFormat2);
    NSString *dateStr1 = [dateFormat stringFromDate:self.nowDate];
    NSLog(@"currentDateStr==%@",dateStr1);
    label1.text=dateStr1;
    NSString *dateStr2 = [dateFormat stringFromDate:secondDay];
    NSLog(@"currentDateStr==%@",dateStr2);
    label2.text=dateStr2;
    NSString *dateStr3 = [dateFormat stringFromDate:thirdDay];
    NSLog(@"currentDateStr==%@",dateStr3);
    label3.text=dateStr3;
    NSString *dateStr4 = [dateFormat stringFromDate:fourthDay];
    NSLog(@"currentDateStr==%@",dateStr4);
    label4.text=dateStr4;
    NSString *dateStr5 = [dateFormat stringFromDate:fifthDay];
    NSLog(@"currentDateStr==%@",dateStr5);
    label5.text=dateStr5;
    NSString *dateStr6 = [dateFormat stringFromDate:sixthDay];
    NSLog(@"currentDateStr==%@",dateStr6);
    label6.text=dateStr6;
    NSString *dateStr7 = [dateFormat stringFromDate:seventhDay];
    NSLog(@"currentDateStr==%@",dateStr7);
    label7.text=dateStr7;
    
    
    
    NSString *_tableDateStr1 = [dateFormat2 stringFromDate:self.nowDate];
    NSLog(@"currentDateStr==%@",_tableDateStr1);
    [_arrayYear addObject:_tableDateStr1];
    NSString *_tableDateStr2 = [dateFormat2 stringFromDate:secondDay];
    NSLog(@"currentDateStr==%@",_tableDateStr2);
   [_arrayYear addObject:_tableDateStr2];
    NSString *_tableDateStr3 = [dateFormat2 stringFromDate:thirdDay];
    NSLog(@"currentDateStr==%@",_tableDateStr3);
   [_arrayYear addObject:_tableDateStr3];
    NSString *_tableDateStr4 = [dateFormat2 stringFromDate:fourthDay];
    NSLog(@"currentDateStr==%@",_tableDateStr4);
     [_arrayYear addObject:_tableDateStr4];
    NSString *_tableDateStr5 = [dateFormat2 stringFromDate:fifthDay];
    NSLog(@"currentDateStr==%@",_tableDateStr5);
   [_arrayYear addObject:_tableDateStr5];
    NSString *_tableDateStr6 = [dateFormat2 stringFromDate:sixthDay];
    NSLog(@"currentDateStr==%@",_tableDateStr6);
   [_arrayYear addObject:_tableDateStr6];
    NSString *_tableDateStr7 = [dateFormat2 stringFromDate:seventhDay];
    NSLog(@"currentDateStr==%@",_tableDateStr7);
       [_arrayYear addObject:_tableDateStr7];
    
    float a;
    a=180;
    if (a>=20) {
        label_20.hidden=NO;
    }
    if (a>=40) {
        label_40.hidden=NO;
    }
    if (a>=60) {
        label_60.hidden=NO;
    }
    if (a>=80) {
        label_80.hidden=NO;
    }
    if (a>=100) {
        label_100_1.hidden=NO;
        label_20.frame=CGRectMake(90, 118,18 ,20);
        label_20.hidden=YES;
         label_40.frame=CGRectMake(57+33, 98,18 ,20);
        label_40.hidden=YES;
         label_60.frame=CGRectMake(57+33, 77,18 ,21);
        label_60.hidden=YES;
         label_80.frame=CGRectMake(57+33, 56,18 ,21);
       label_80.hidden=YES;
        NSLog(@"label_80.frame.origin.x=%g,,,,.......label_80.frame.origin.y=%g",label_80.frame.origin.x,label_80.frame.origin.y
              );
    }
    
    
    
    
    
    
    
}
#pragma mark -- cell的内容
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 static NSString*cellIdentifier=@"cell";
    CurrentWeekPCell*currentWeekCell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (currentWeekCell==nil) {
        currentWeekCell=[[CurrentWeekPCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    else
    {
     
        currentWeekCell.labelDay.text=nil;
        
        
    }

  NSString*str1=[_arrayYear objectAtIndex:indexPath.row];
 currentWeekCell.labelDay.text=str1;
    
  //  NSLog(@"%d====%@==",[_arrayYear count],_arrayYear);
    
    return currentWeekCell;
}
#pragma mark -- 有多少组cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayYear count];
}
#pragma mark - 触发cell的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
#pragma mark --  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}
#pragma mark -
#pragma mark Plot Data Source Methods


-(IBAction)goHome:(id)sender
{
    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeView animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
