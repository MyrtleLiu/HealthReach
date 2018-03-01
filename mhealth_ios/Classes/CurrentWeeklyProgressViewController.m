//
//  CurrentWeeklyProgressViewController.m
//  mHealth
//
//  Created by gz dev team on 14年2月27日.
//
//

#import "CurrentWeeklyProgressViewController.h"
#import "TrainingRecordResultViewController.h"
#import "TrainingPedometerViewController.h"


@interface CurrentWeeklyProgressViewController ()

@end

@implementation CurrentWeeklyProgressViewController
@synthesize record,WaitingView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (iPad) {
        
        
        self = [super initWithNibName:@"CurrentWeeklyProgressViewController_iPhone4iOS7" bundle:nibBundleOrNil];
        
    }
    else{
        self =  [super initWithNibName:@"CurrentWeeklyProgressViewController" bundle:nibBundleOrNil];
    }
    
    
    
    
    if (self) {
        // Custom initialization
        
        self.historyDateLabels=[[NSMutableArray alloc] initWithCapacity:7];
        self.historyDurationLabels=[[NSMutableArray alloc] initWithCapacity:7];
        self.historyDistanceLabels=[[NSMutableArray alloc] initWithCapacity:7];
        self.historyCalsLabels=[[NSMutableArray alloc] initWithCapacity:7];
        self.historyResultLabels=[[NSMutableArray alloc] initWithCapacity:7];
        
    }
    return self;
}

- (void)refreshData{
    
    [GlobalVariables shareInstance].trainRT_API_running=false;

    
    
    self.WaitingView.hidden=true;
    
     self.record=[DBHelper getLatestTrainRecord];
    
    [self setupBarChat];
}





- (void)viewWillDisappear:(BOOL)animated
{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animatedr
{
    [super viewWillAppear:animatedr];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refreshTrainData" object:nil];
    
    [self.dataLoading setText:[Utility getStringByKey:@"data_loading" ]];
    
    if(_checkFromHistory==1){
        self.stopBtn.hidden=true;
        self.continueBtn.hidden=true;
        self.WaitingView.hidden=true;
    }
    else{
        
        if (self.record==nil) {
            
            self.record=[DBHelper getLatestTrainRecord];
            NSLog(@"check the startTime here : %ld",record.getStarttime);
        }
        else{
            self.stopBtn.hidden=true;
            self.continueBtn.hidden=true;
            
        }

    }


    [self setupBarChat];
    
    NSInteger level=[self.record getLevel];
    
    if (level==1) {
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_bronze_title"]];
        [self.levelText setText:[Utility getStringByKey:@"b_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_bronze"];
        
        self.bView.backgroundColor=[UIColor colorWithRed:59/255 green:46/255 blue:38/255 alpha:1];
        
        
    }else if(level==2){
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_silver_title"]];
        [self.levelText setText:[Utility getStringByKey:@"s_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_silver"];
        
        self.bView.backgroundColor=[UIColor colorWithRed:60/255 green:60/255 blue:60/255 alpha:1];
        
    }else if(level==3){
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_gold_title"]];
        [self.levelText setText:[Utility getStringByKey:@"g_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_gold"];
        
        self.bView.backgroundColor=[UIColor colorWithRed:73/255 green:61/255 blue:39/255 alpha:1];
        
    }else if(level==4){
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_diamond_title"]];
        [self.levelText setText:[Utility getStringByKey:@"d_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_diamond"];
        
        self.bView.backgroundColor=[UIColor colorWithRed:41/255 green:57/255 blue:58/255 alpha:1];
    }

    [self.levelTitle setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:22]];
    [self.levelText setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:11]];
    
    [self.currentTitle setFont:[UIFont fontWithName:font65 size:12]];
    
    self.actionTitle.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    [self.actionTitle setText:[Utility getStringByKey:@"w_train_title"]];
    
    [self.currentTitle setText:[Utility getStringByKey:@"tr_current_title"]];
    
   
    
    [self.stopBtn setTitle:[Utility getStringByKey:@"tr_stop"] forState: normal];
    self.stopBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.continueBtn setTitle:[Utility getStringByKey:@"tr_continue"] forState: normal];
    self.continueBtn.titleLabel.textAlignment=NSTextAlignmentCenter;

    
    
    
    //********trainning RT API**********
    Boolean checkRT_Running=[GlobalVariables shareInstance].trainRT_API_running;
    NSLog(@"Vaycent check checkRT_Running:%d",checkRT_Running);
    if(checkRT_Running==1){
        self.WaitingView.hidden=false;
    }else{
        self.WaitingView.hidden=true;
    }
    
}

-(void)setupBarChat{
    NSLog(@"run the setupBarChat");
    self.barChart.backgroundColor = [UIColor clearColor];

    
    long starttime=[self.record getStarttime];
    
    NSMutableArray *dateLabels=[[NSMutableArray alloc] initWithCapacity:7];
    
    NSDate *startDate=[[NSDate alloc] initWithTimeIntervalSince1970:starttime];
    
    if (self.historyDateLabels!=nil) {
        
        [self.historyDateLabels removeAllObjects];
    }

    if (self.historyDurationLabels!=nil) {
        
        [self.historyDurationLabels removeAllObjects];
    }
    if (self.historyDistanceLabels!=nil) {
        
        [self.historyDistanceLabels removeAllObjects];
    }
    if (self.historyCalsLabels!=nil) {
        
        [self.historyCalsLabels removeAllObjects];
    }
    if (self.historyResultLabels!=nil) {
        
        [self.historyResultLabels removeAllObjects];
    }
    
    
    
    //NSLog(@"%@........start date",startDate);

    for (int i=0; i<7; i++) {
        
        
        float distance=0;
        NSInteger cals=0;
        long duration=0;
        NSInteger result=0;
        
        NSDate *tmp=[startDate dateByAddingTimeInterval:24*60*60*i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
            [dateFormatter setDateFormat:@"yyyy年M月dd日"];
        } else {
            [dateFormatter setDateFormat:@"dd MMM yyyy"];
        }
        NSString *dateString = [dateFormatter stringFromDate:tmp];
        
        
        
        
        
        
        [dateLabels addObject:[NSString formatTimeddMMM:[tmp timeIntervalSince1970]]];
        
        
        NSLog(@"dateString:%@",dateString);
        
         [self.historyDateLabels addObject:dateString];
        
        
//        [self.historyDateLabels addObject:[NSString formatTimeddMMMyyyy:[tmp timeIntervalSince1970]]];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:tmp];
        
        
//        NSLog(@"year: %i", dateComponent.year);
//        
//        	NSLog(@"month:%i", dateComponent.month);
//        	NSLog(@"day:%i", dateComponent.day);
//        	NSLog(@"hour:%i", dateComponent.hour);
//        	NSLog(@"minute:%i", dateComponent.minute);
//        	NSLog(@"second:%i", dateComponent.second);
        
        NSInteger year=dateComponent.year;
        NSInteger month=dateComponent.month;
        NSInteger day=dateComponent.day;
        
//        NSLog(@"%d.....%d.....%d",year,month,day);
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
        
         NSLog(@"%@............start",[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]);
        
        NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
       
        NSLog(@"%@............end",[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]);
        
        //NSLog(@"%@........date.....%@",[dateFormat stringFromDate:recordStart],[dateFormat stringFromDate:recordEnd]);
        
        
        NSLog(@"recordStart:%@",recordStart);
        NSLog(@"recordEnd:%@",recordEnd);
        NSLog(@"id:%ld",(long)[self.record.trainid integerValue]);
        
        //vaycent check ?
        NSMutableArray *cwResultArray = [DBHelper getCWRecordDate:[recordStart timeIntervalSince1970] enddate:[recordEnd timeIntervalSince1970] type:[self.record.trainid integerValue]];
        NSLog(@"cwResultArray.len:%lu",(unsigned long)cwResultArray.count);
        
        //NSLog(@"get count........%d",[cwResultArray count]);
        
        double temp_dis=0;
        NSInteger temp_cals=0;
        NSInteger tep_duration=0;
        NSInteger temp_result=0;
        for (int i=0; i<[cwResultArray count]; i++) {
            
            
            //疊加--------------------
//            WalkingRecord *cwResult = [cwResultArray objectAtIndex:i];
//            
//            distance=distance+[cwResult.distance integerValue];
//            cals=cals+[cwResult.calsburnt integerValue];
//            duration=duration+[cwResult getPersistime];
//            
//            if ([cwResult.result integerValue]>result) {
//                
//                result=[cwResult.result integerValue];
//            }
            //-----------------------
           
            WalkingRecord *cwResult = [cwResultArray objectAtIndex:i];
            
            
            
            NSLog(@"cwResult.distance:%@",cwResult.distance);
            NSLog(@"cwResult.result:%@",cwResult.result);

            
            NSLog(@"========************========");

            
            NSLog(@"check i:%ld",(long)i);

            
            
//            if(i==0){
            if([cwResultArray count]<=1){
                temp_dis=[cwResult.distance doubleValue];
                temp_cals=[cwResult.calsburnt integerValue];
                tep_duration=[cwResult getPersistime];
                temp_result=[cwResult.result integerValue];
            }
            else{
                
                //vaycnet add
                temp_dis=[cwResult.distance doubleValue];
                temp_cals=[cwResult.calsburnt integerValue];
                temp_result=[cwResult.result integerValue];
                //=====
                
                NSLog(@"check:temp_result:%ld",(long)temp_result);
                if(temp_result>=100){
                    temp_dis=[cwResult.distance doubleValue];
                    temp_cals=[cwResult.calsburnt integerValue];
                    tep_duration=[cwResult getPersistime];
                    temp_result=[cwResult.result integerValue];
                    NSLog(@"111111111111111");
                    
                    //vaycent add  不需要再循環
                    i=(int)[cwResultArray count];
                    //====>

                }
                else if(tep_duration<[cwResult getPersistime]){
                    NSLog(@"22222222222222222");

                    temp_dis=[cwResult.distance doubleValue];
                    temp_cals=[cwResult.calsburnt integerValue];
//                    tep_duration=[cwResult getPersistime];
                    temp_result=[cwResult.result integerValue];

                }
                tep_duration=[cwResult getPersistime];
            }
        }
        //distance=temp_dis;
        cals=temp_cals;
        duration=tep_duration;
        result=temp_result;


        distance=temp_dis/1000;
        
        //self.distanceLabel.text=[NSString stringWithFormat:@"%.3f",distance];
        
        
        
        [self.historyDistanceLabels addObject:[NSString stringWithFormat:@"%.3f",distance]];
        [self.historyCalsLabels addObject:[NSString stringWithFormat:@"%ld",(long)cals]];
        [self.historyDurationLabels addObject:[NSString formatTimemmdd:duration]];
        [self.historyResultLabels addObject:[NSString stringWithFormat:@"%ld",(long)result]];
        
        
        
        
        
        
        [_historyListView reloadData];
    }
    
    
    [self.barChart setXLabels:dateLabels];
    [self.barChart setYLabels:@[@"20%",@"40%",@"60%",@"80%",@"100%"]];
	
    [self.barChart setYValues:self.historyResultLabels];
    self.barChart.showLabel=true;
    [self.barChart setYValueMax:100];
    [self.barChart setTheBarWidth:17];
    [self.barChart setStrokeColor:[UIColor colorWithRed:127 green:127 blue:127 alpha:1]];
	[self.barChart strokeChart];

}

#pragma mark - TableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *cellIdentifier=@"TrainingHistoryTableViewCell";
    
    UINib *nib = [UINib nibWithNibName:@"TrainingHistoryTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    
    
    TrainingHistoryTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        
        cell=[[TrainingHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    else
    {
     
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//        [dateFormatter setLocale:usLocale];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//        NSDate* date=[NSDate dateWithTimeIntervalSince1970:[record getStarttime]];
//        if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
//            [dateFormatter setDateFormat:@"yyyy年M月dd日"];
//        } else {
//            [dateFormatter setDateFormat:@"dd MMM yyyy"];
//        }
//        cell.startDate.text = [dateFormatter stringFromDate:date];


        
        
        
        
        cell.date.text=[self.historyDateLabels objectAtIndex:indexPath.row];
        cell.duration.text=[self.historyDurationLabels objectAtIndex:indexPath.row];
        cell.distance.text=[self.historyDistanceLabels objectAtIndex:indexPath.row];
        cell.cals.text=[self.historyCalsLabels objectAtIndex:indexPath.row];
        
//        NSLog(@"%@............date",cell.date.text);
//         NSLog(@"%@............duration",cell.duration.text);
//         NSLog(@"%@............distance",cell.distance.text);
//         NSLog(@"%@............cals",cell.cals.text);
        
        
        if ([cell.duration.text isEqualToString:@"0'0''"]) {
            
            cell.noData.hidden=false;
            cell.dataView.hidden=true;
            
        }else{
            
            cell.noData.hidden=true;
            cell.dataView.hidden=false;
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        
        if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
            [dateFormatter setDateFormat:@"yyyy年M月dd日"];
        } else {
            [dateFormatter setDateFormat:@"dd MMM yyyy"];
        }
        
        NSString *theDate= [dateFormatter stringFromDate:[NSDate date]];
        
        if ([cell.date.text isEqualToString:theDate]) {
            
            cell.statusImg.image=[UIImage imageNamed:@"07_tr_check_blue"];
            currentDayIndex=indexPath.row;
            cell.noData.hidden=true;
            cell.dataView.hidden=false;
            
        }else{
            
            NSDate *rowDate=[dateFormatter dateFromString: cell.date.text];
            
            if ([rowDate timeIntervalSince1970]>[[NSDate date] timeIntervalSince1970]) {
                
                cell.statusImg.image=[UIImage imageNamed:@"07_tr_check_blank"];
                
                
            }else{
                
                if ([[self.historyResultLabels objectAtIndex:indexPath.row] isEqualToString:@"100"]) {
                    
                    cell.statusImg.image=[UIImage imageNamed:@"07_tr_check_green"];
                    
                }else{
                    
                    cell.statusImg.image=[UIImage imageNamed:@"07_tr_check_red"];
                }
            }
            
            
           
            
            
        }
        
    }


    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 7;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index=indexPath.row;
    
    NSLog(@"%ld.....click",(long)index);
    
    
    NSString *str_temp=[self.historyDateLabels objectAtIndex:index];
    
    
    
    
 
    
    
    //TrainingRecord *record=[self.trainingHistory objectAtIndex:indexPath.row];
    
    NSInteger level=[self.record getLevel];
    TrainingRecord *train_record=self.record;
    NSLog(@"check the recordtime : %ld",[train_record getRecordtime]);
    
    TrainingRecordResultViewController *trrView = [[TrainingRecordResultViewController alloc] initWithNibName:@"TrainingRecordResultViewController" bundle:nil];
    
    [trrView setDateStr:str_temp ];
    [trrView setLevel : level];
    [trrView setRecord: train_record];
    [trrView setIndexMark:index];
    
    [self.navigationController pushViewController:trrView animated:YES ];
    
    if(_checkFromHistory==0)
    self.record=nil;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 33;
//}

-(void) back{
    
   if(_checkFromHistory==1){
       [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        for (int i=0; i<[[self.navigationController viewControllers] count]; i++) {
            
            UIViewController *tmp=[[self.navigationController viewControllers] objectAtIndex:i];
            
            if ([tmp isKindOfClass:[WalkForHealthViewController class]]) {
                
                [self.navigationController popToViewController:tmp animated:YES];
//                break;
            }
            
            
        }

    }
    
    
    
    
}


-(IBAction)stopTraining:(id)sender{
    
    [SyncWalking delTrainRcord:self.record.trainid];
  
    NSLog(@"back this page.... %@",self.record.trainid);
    [self back];
}



-(IBAction)toContinue:(id)sender{
    TrainingRecord *train_record=self.record;
   
    
    NSInteger level=[self.record getLevel];
    TrainingPedometerViewController *trrView = [[TrainingPedometerViewController alloc] initWithNibName:@"TrainingPedometerViewController" bundle:nil];
     [trrView setLevel : level];
    [trrView setTrainid :  train_record.trainid];
    [self.navigationController pushViewController:trrView animated:YES ];
    
    self.record=nil;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
