//
//  TrainingRecordResultViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-8-27.
//
//

#import "TrainingRecordResultViewController.h"
#import "WalkHistoryTableViewCell.h"
#import "TrainingResultViewController.h"
#import "DBHelper.h"
#import "Utility.h"
#import "SyncWalking.h"

@interface TrainingRecordResultViewController ()

@end

@implementation TrainingRecordResultViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (iPad) {
        
        [[NSBundle mainBundle] loadNibNamed:@"TrainingRecordResultViewController_ipad"
                                      owner:self
                                    options:nil];
    }else{
        
        [[NSBundle mainBundle] loadNibNamed:@"TrainingRecordResultViewController"
                                      owner:self
                                    options:nil];
    }
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animatedr
{
    [self.dateTitle setFont:[UIFont fontWithName:font65 size:18]];
    [self.dateTitle setText:(_dateStr) ];
    
    self.actionbar.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [self.actionbar setText:[Utility getStringByKey:@"w_train_title"]];
    
    if(_level==1){
         self.levelImage.image=[UIImage imageNamed:@"07_tr_header_bronze_2"];
    }
    else if (_level==2){
        self.levelImage.image=[UIImage imageNamed:@"07_tr_header_silver_2"];
    }
    else if (_level==3){
        self.levelImage.image=[UIImage imageNamed:@"07_tr_header_gold_2"];
    }
    else if (_level==4){
        self.levelImage.image=[UIImage imageNamed:@"07_tr_header_diamond_2"];
    }
    TrainingRecord *train_record=_record;
    
//    NSLog(@"%lld .....time",[_dateStr LongValue]);
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MM yyyy"];
    
//    NSDate *tmp = [dateFormat dateFromString:_dateStr];
    
//    NSDate *tmp = [[NSDate alloc] initWithTimeIntervalSince1970:train_record.getRecordtime];
      NSDate *tmp = [[NSDate alloc] initWithTimeIntervalSince1970:train_record.getStarttime];
    tmp=[tmp dateByAddingTimeInterval:24*60*60*_indexMark];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];

    
    NSInteger year=dateComponent.year;
    NSInteger month=dateComponent.month;
    NSInteger day=dateComponent.day;
    
    // NSLog(@"%d.....%d.....%d",year,month,day);
    
    NSDateFormatter* dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *recordStart = [dateFormat1 dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
    
    NSLog(@"%@............start",[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]);
    
    NSDate *recordEnd = [dateFormat1 dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
    
    NSLog(@"%@............end",[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]);
    
    
    
    _cwResultArray = [DBHelper getCWRecordDate:[recordStart timeIntervalSince1970] enddate:[recordEnd timeIntervalSince1970] type:[train_record.trainid integerValue]];
    
    

    
    
    
    
    
    
//    for (int i=0; i<[_cwResultArray count]; i++) {
//        
//        WalkingRecord *cwResult = [_cwResultArray objectAtIndex:i];
//
////          (cwResult.distance);
////        cals=cals+[cwResult.calsburnt integerValue];
////        duration=duration+[cwResult getPersistime];
////        
////        if ([cwResult.result integerValue]>result) {
////            
////            result=[cwResult.result integerValue];
////        }
//        
//    }
    
    
    
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WalkingRecord *cwResult = [_cwResultArray objectAtIndex:indexPath.row];

    
    TrainingResultViewController *trrView = [[TrainingResultViewController alloc] initWithNibName:@"TrainingResultViewController" bundle:nil];
      trrView .isUPDateNOW=@"no";
    [trrView setRecord: cwResult];
    [trrView setLevel: _level];
    [trrView setLastActivity:@"History"];

    [self.navigationController pushViewController:trrView animated:YES ];

    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    unsigned long test = (unsigned long)[_cwResultArray count];
    NSLog(@"%lu .....count",test);
    return [_cwResultArray count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"WalkHistoryTableViewCell";
    
    UINib *nib = [UINib nibWithNibName:@"WalkHistoryTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    
    
    WalkHistoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        
        cell=[[WalkHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    else
    {

          WalkingRecord *cwResult = [_cwResultArray objectAtIndex:indexPath.row];
            NSLog(@"%@ .....test",cwResult);
//        cell.distance.text=
     
        NSDate *date_temp=[[NSDate alloc] initWithTimeIntervalSince1970:cwResult.getRecordtime];
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm"];
        NSString *dateStr=[dateFormat stringFromDate:date_temp];
        
        cell.date.text=dateStr;
        //cell.distance.text=cwResult.distance/1000;
        
        double distance=[cwResult.distance doubleValue]/1000;
        
        cell.distance.text=[NSString stringWithFormat:@"%.3f",distance];
        
        NSLog(@"%ld .....Persistime",[cwResult getPersistime]/60);
        NSLog(@"%ld .....Persistime",[cwResult getPersistime]%60);
        NSNumber *longNumber1 = [NSNumber numberWithLong:[cwResult getPersistime]/60];
        NSString *longStr1 = [longNumber1 stringValue];
        NSNumber *longNumber2 = [NSNumber numberWithLong:[cwResult getPersistime]%60];
        NSString *longStr2 = [longNumber2 stringValue];
        NSString *tmp=[NSString stringWithFormat:@"%@'%@''",longStr1,longStr2];
        cell.duration.text=tmp;
        
        cell.cals.text=cwResult.calsburnt;
        
        
        
        //
        //        cell.date.text=[self.historyDateLabels objectAtIndex:indexPath.row];
        //        cell.duration.text=[self.historyDurationLabels objectAtIndex:indexPath.row];
        //        cell.distance.text=[self.historyDistanceLabels objectAtIndex:indexPath.row];
        //        cell.cals.text=[self.historyCalsLabels objectAtIndex:indexPath.row];
        //
        //
        //        if ([cell.duration.text isEqualToString:@"0'0''"]) {
        //
        //            cell.noData.hidden=false;
        //            cell.dataView.hidden=true;
        //
        //        }else{
        //
        //            cell.noData.hidden=true;
        //            cell.dataView.hidden=false;
        //        }
        //
        //
        //        if ([cell.date.text isEqualToString:[NSString formatTimeddMMMyyyy:[[NSDate date] timeIntervalSince1970]]]) {
        //
        //            cell.statusImg.image=[UIImage imageNamed:@"07_tr_check_blue"];
        //            currentDayIndex=indexPath.row;
        //            cell.noData.hidden=true;
        //            cell.dataView.hidden=false;
        //
        //        }else{
        //
        //            NSDate *rowDate=[NSString timeddMMMyyyy2Date:cell.date.text];
        //
        //            if ([rowDate timeIntervalSince1970]>[[NSDate date] timeIntervalSince1970]) {
        //
        //                cell.statusImg.image=[UIImage imageNamed:@"07_tr_check_blank"];
        //
        //
        //            }else{
        //
        //                if ([[self.historyResultLabels objectAtIndex:indexPath.row] isEqualToString:@"100"]) {
        //
        //                    cell.statusImg.image=[UIImage imageNamed:@"07_tr_check_green"];
        //
        //                }else{
        //                    
        //                    cell.statusImg.image=[UIImage imageNamed:@"07_tr_check_red"];
        //                }
        //            }
        //            
        //            
        //            
        //            
        //            
        //        }
        //        
    }
    
    
    
    
    
    
    return cell;
}








@end
