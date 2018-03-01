//
//  WalkingHistoryViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-8-18.
//
//

#import "WalkingHistoryViewController.h"
#import "TrainingRecord.h"
#import "CurrentWeeklyProgressViewController.h"
#import "LearnMoreFirstViewController.h"
@interface WalkingHistoryViewController ()

@end

@implementation WalkingHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (iPad) {
        
        [[NSBundle mainBundle] loadNibNamed:@"WalkingHistoryViewController_ipad"
                                      owner:self
                                    options:nil];
    }else{
        
        [[NSBundle mainBundle] loadNibNamed:@"WalkingHistoryViewController"
                                      owner:self
                                    options:nil];
    }
    
    if (self) {
        // Custom initialization
        
        currentViewIndex=0;
        
        
       
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(load_from_db) object:nil];
    [thread start];
    
    
//    NSString *session_id = [GlobalVariables shareInstance].session_id;
//    NSString *login_id = [GlobalVariables shareInstance].login_id;
//    if(session_id==NULL||login_id==NULL)
//    {
//        fristTimepictureofTP.hidden=NO;
//        
//    }
//    else
//    {
//        fristTimepictureofTP.hidden=YES;
//    }
    if (self.trainingHistory==nil) {
        self.trainingHistory=[[NSMutableArray alloc] init];
    }
    
    if (self.cwHistory==nil) {
        self.cwHistory=[[NSMutableArray alloc] init];
    }
    
    self.actionTitle.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    [self.actionTitle setText:[Utility getStringByKey:@"walkforhealth"]];
    
    [self.trainBtn.titleLabel setFont:[UIFont fontWithName:font65 size:17]];
    [self.cwBtn.titleLabel setFont:[UIFont fontWithName:font65 size:17]];
    [self.histroyTitle setFont:[UIFont fontWithName:font65 size:18]];
    
    [_histroyTitle setText:[Utility getStringByKey:@"history_title"]];
    
    [_trainBtn setTitle:[Utility getStringByKey:@"w_train_title"] forState: normal];
    [_cwBtn setTitle:[Utility getStringByKey:@"w_walk_title"] forState: normal];

    
}

-(IBAction)viewTraining:(id)sender{
    
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL)
    {
        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
        [historyView setType:@"walk"];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    
    else{
        //[self.trainBtn setBackgroundImage:[Utility imageWithColor:[UIColor colorWithRed:73.0f/255.0f green:61.0f/255.0f blue:39.0f/255.0f alpha:1]] forState:UIControlStateNormal];
        
        self.trainBtn.backgroundColor=[UIColor colorWithRed:79.0f/255.0f green:104.0f/255.0f blue:7.0f/255.0f alpha:1];
        
        self.cwBtn.backgroundColor=[UIColor colorWithRed:52.0f/255.0f green:54.0f/255.0f blue:42.0f/255.0f alpha:1];
        
        self.line1Btn.backgroundColor=[UIColor colorWithRed:125.0f/255.0f green:143.0f/255.0f blue:69.0f/255.0f alpha:1];
        
        self.line2Btn.backgroundColor=[UIColor colorWithRed:38.0f/255.0f green:40.0f/255.0f blue:30.0f/255.0f alpha:1];
        
        currentViewIndex=0;
        
        
//        if(session_id==NULL||login_id==NULL)
//        {
//            fristTimepictureofTP.hidden=NO;
//            
//        }
//        else
//        {
//            fristTimepictureofTP.hidden=YES;
//        }
        [self.historyListView reloadData];

    }
    
    
    
 }

-(IBAction)viewCasualWalk:(id)sender{

//    fristTimepictureofTP.hidden=YES;

    self.cwBtn.backgroundColor=[UIColor colorWithRed:79.0f/255.0f green:104.0f/255.0f blue:7.0f/255.0f alpha:1];
    
    self.trainBtn.backgroundColor=[UIColor colorWithRed:52.0f/255.0f green:54.0f/255.0f blue:42.0f/255.0f alpha:1];
   
    self.line2Btn.backgroundColor=[UIColor colorWithRed:125.0f/255.0f green:143.0f/255.0f blue:69.0f/255.0f alpha:1];
    
    self.line1Btn.backgroundColor=[UIColor colorWithRed:38.0f/255.0f green:40.0f/255.0f blue:30.0f/255.0f alpha:1];
    
    
    currentViewIndex=1;
    
    [self.historyListView reloadData];
}
-(IBAction)fristTimeofTPClick:(id)sender
{
    LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
    [historyView setType:@"walk"];
    [self.navigationController pushViewController:historyView animated:YES ];
}
#pragma mark - TableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (currentViewIndex==0) {
        
        static NSString *trainingCell=@"TrainingCell";
        
        
        UINib *trainNib = [UINib nibWithNibName:@"TrainingHistoryCell" bundle:nil];
        [tableView registerNib:trainNib forCellReuseIdentifier:trainingCell];
        
        
        TrainingHistoryCell *cell=[tableView dequeueReusableCellWithIdentifier:trainingCell];
        
        if (cell==nil) {
            
            cell=[[TrainingHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:trainingCell];
            
        }
       
        
            TrainingRecord *record=[self.trainingHistory objectAtIndex:indexPath.row];
            
//            cell.startDate.text=[NSString formatTimeddMMMyyyy:[record getStarttime]];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate* date=[NSDate dateWithTimeIntervalSince1970:[record getStarttime]];
        if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
            [dateFormatter setDateFormat:@"yyyy年M月dd日"];
        } else {
            [dateFormatter setDateFormat:@"dd MMM yyyy"];
        }
        cell.startDate.text = [dateFormatter stringFromDate:date];
        
      

        date=[NSDate dateWithTimeIntervalSince1970:[record getStarttime]+6*24*60*60];
        cell.endDate.text=[dateFormatter stringFromDate:date];

//            cell.endDate.text=[NSString formatTimeddMMMyyyy:([record getStarttime]+6*24*60*60)];
        
            NSInteger level=[record getLevel];
            
            if (level==1) {

                //todo:wait for image
                cell.levelImg.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];

            }else if(level==2){

                //todo:wait for image
                cell.levelImg.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                
                
            }else if(level==3){

                //todo:wait for image
                cell.levelImg.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                
                
            }else if(level==4){

                //todo:wait for image
                cell.levelImg.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                
                
            }
            
            int status=[record getStatus];//1.finish 2.Process 3.Unfinish
        
            if (status==1) {
                
//                cell.status.text=@"Finish";
                
                [cell.status setText:[Utility getStringByKey:@"train_history_finish"]];
            }else if(status==3){
                
//                cell.status.text=@"Unfinish";
                [cell.status setText:[Utility getStringByKey:@"train_history_unfinish"]];

                
                
            }else if(status==2){
                
                
//                cell.status.text=@"Process";
                [cell.status setText:[Utility getStringByKey:@"train_history_process"]];

                
                
            }
        
        
        //NSLog(@"%d.....%d",level,status);
        
        
        return cell;
        
    }else{
        
        static NSString *casualWalkCell=@"CasualWalkCell";
        UINib *cwNib = [UINib nibWithNibName:@"CasualWalkCell" bundle:nil];
        [tableView registerNib:cwNib forCellReuseIdentifier:casualWalkCell];
        
        
        
        CasualWalkCell *cell=[tableView dequeueReusableCellWithIdentifier:casualWalkCell];
        
        if (cell==nil) {
            
            cell=[[CasualWalkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:casualWalkCell];
            
        }
        
        
            WalkingRecord *record=[self.cwHistory objectAtIndex:indexPath.row];
        
//            cell.date.text=[NSString formatTimeAgo:[record getRecordtime]];
            cell.date.text = [Utility extractDateString:[NSString formatTimeAgo:[record getRecordtime]] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];

        
            double distance=[record.distance doubleValue]/1000;

            cell.distance.text=[NSString stringWithFormat:@"%.2f",distance];
            
            cell.cals.text=record.calsburnt;
            
            cell.duration.text=[NSString formatTimemmdd:[record getPersistime]];
            
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        if(session_id==NULL||login_id==NULL)
        {
            cell.arrow_info.hidden=true;
        }
        
        
        
        
        return cell;
        
        
    }
    
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (currentViewIndex==0) {
        
        return [self.trainingHistory count];
        
    }else{
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        if(session_id==NULL||login_id==NULL)
        {
            if([self.cwHistory count]<=10){
                return [self.cwHistory count];
            }
            else{
                return 10;
            }
            
        }else{
             return [self.cwHistory count];
        }
        
       
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    
    
    
    if (currentViewIndex==0) {
        
       TrainingRecord *record=[self.trainingHistory objectAtIndex:indexPath.row];
        
        
        
        CurrentWeeklyProgressViewController *resultView = [[CurrentWeeklyProgressViewController alloc] initWithNibName:@"CurrentWeeklyProgressViewController" bundle:nil];
        
        [resultView setRecord:record];
        [resultView setCheckFromHistory:1];
        [self.navigationController pushViewController:resultView animated:YES ];
        
        
        
        
    }else{
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        if(session_id==NULL||login_id==NULL)
        {

        }
        else{
            
            WalkingRecord *record=[self.cwHistory objectAtIndex:indexPath.row];
            
            //record= [SyncWalking getWalkingRecordDetail:record.recordid];
            
            
            //NSLog(@"test route in history:%@",record.route);
            //NSLog(@"test steps in history:%@",record.steps);
            //NSLog(@"test caltarget:%@",record.calsburnt);
            // NSLog(@"test plannedRoutePoints in history:%@",record.plannedRoutePoints);
            
            
            WalkingResultViewController *resultView = [[WalkingResultViewController alloc] initWithNibName:@"WalkingResultViewController" bundle:nil];
            
            [resultView setResult:record];
            NSLog(@"_______________________");
            [self.navigationController pushViewController:resultView animated:YES ];
        }
        
        
       
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL)
    {
        
        currentViewIndex=1;
        self.cwBtn.backgroundColor=[UIColor colorWithRed:79.0f/255.0f green:104.0f/255.0f blue:7.0f/255.0f alpha:1];
        
        self.trainBtn.backgroundColor=[UIColor colorWithRed:52.0f/255.0f green:54.0f/255.0f blue:42.0f/255.0f alpha:1];
        
        self.line2Btn.backgroundColor=[UIColor colorWithRed:125.0f/255.0f green:143.0f/255.0f blue:69.0f/255.0f alpha:1];
        
        self.line1Btn.backgroundColor=[UIColor colorWithRed:38.0f/255.0f green:40.0f/255.0f blue:30.0f/255.0f alpha:1];
        
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)load_from_db{
    self.trainingHistory=[DBHelper getTrainRecord];
    self.cwHistory=[DBHelper getCWRecord];
    [self.historyListView reloadData];


}



@end
