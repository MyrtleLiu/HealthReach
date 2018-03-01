//
//  WalkForHealthViewController.m
//  mHealth
//
//  Created by sngz on 14-1-26.
//
//

#import "WalkForHealthViewController.h"
#import "PedometerViewController.h"
#import "HomeViewController.h"
#import "StartingFromBronzeViewController.h"
#import "LearnMoreFirstViewController.h"
#import "BlackWFHGFViewController.h"
#import "AwardsViewController.h"
#import "SyncGame.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "UIView+Toast.h"


@interface WalkForHealthViewController ()
   //


@end

@implementation WalkForHealthViewController

@synthesize paceSetValue;
@synthesize targetSetValue;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (iPad) {
            
            [[NSBundle mainBundle] loadNibNamed:@"WalkForHealthViewController3.5"
                                          owner:self
                                        options:nil];
        }else{
            
            [[NSBundle mainBundle] loadNibNamed:@"WalkForHealthViewController"
                                          owner:self
                                        options:nil];
        }
        
    }
    
    [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] setWalkForHealth:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *loaddata=[defaults objectForKey:@"loaddata"];
    
    
    
    
    
    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenWalkLoad];
    
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
   
    
    NSLog(@"checkLoadView:%d",checkLoadView);
    if(checkLoadView||session_id==NULL||login_id==NULL){
        _WaitingView.hidden=true;
    }
    
    if ([loaddata isEqualToString:@"N"]) {
        
         _WaitingView.hidden=false;
    }
    
    
    if([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL){
        
        _WaitingView.hidden=true;
    }

    

    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadViewText];
    [self setUpTrophyValue];    //  set up trophy
    [self setUpCasualWalkValue];    //  set up casual walk

     //check api run already to hidden the loading view
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loaddata=[defaults objectForKey:@"loaddata"];
    BOOL checkLoadView=[(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] getIsHiddenWalkLoad];
    if(checkLoadView){
        _WaitingView.hidden=true;
    }
    if ([loaddata isEqualToString:@"N"]) {
        _WaitingView.hidden=true;
    }
    if([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL){
        _WaitingView.hidden=true;
    }
    //===================>>>>>>>>>>>>>>>>>>>
    
    if([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)
    {
        [self firstTimeSetUpCasualWalk];
        //[_toTPButton.imageView setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"]];
        
        [_toTPButton setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        if([SyncGame isShowTrophyTryNow]==1)
            isTryNowTP=true;
        else
            isTryNowTP=false;
        if([SyncGame isShowPlantTryNow])
            isTryNowCW=true;
        else
            isTryNowCW=false;
        
        [self setUpViewHidden];    //set up view hidden
    }
}


-(void)reloadViewText{
    
    
    [self.trainingTitle setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    [self.cwTitle setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    [self.historyTitle setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    
    [self.trainingText setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14]];
    [self.cwText setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14]];
    [self.adviseText setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14]];

    self.actionTitle.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    self.awardsText.font=[UIFont fontWithName:font65 size:17];
    
    [self.actionTitle setText:[Utility getStringByKey:@"walkforhealth"]];
    [self.trainingTitle setText:[Utility getStringByKey:@"w_train_title"]];
    [self.trainingText setText:[Utility getStringByKey:@"w_train_text"]];
    [self.cwTitle setText:[Utility getStringByKey:@"w_walk_title"]];
    [self.cwText setText:[Utility getStringByKey:@"w_walk_text"]];
    [self.historyTitle setText:[Utility getStringByKey:@"w_history"]];
    [self.adviseText setText:[Utility getStringByKey:@"w_advise"]];
    [self.awardsText setText:[Utility getStringByKey:@"Awards"]];
    
    tryNowTP.font=[UIFont fontWithName:font65 size:25];
    [tryNowTP setText:[Utility getStringByKey:@"Try Now"]];
    tryNowCW.font=[UIFont fontWithName:font65 size:25];
     [tryNowCW setText:[Utility getStringByKey:@"Try Now"]];
    
    numberOneCW.font=[UIFont fontWithName:font55 size:25];
    numberTwoCW.font=[UIFont fontWithName:font55 size:14];
    
    numberOneTP.font=[UIFont fontWithName:font55 size:25];
    numberTwoTP.font=[UIFont fontWithName:font55 size:14];
    
    tryNowTPLabelTextFont.font=[UIFont fontWithName:font65 size:46];
    rewardSchemeTextFont.font=[UIFont fontWithName:font65 size:18];
    rewardNumber.font=[UIFont fontWithName:font45 size:46];
    percentTextFont.font=[UIFont fontWithName:font45 size:23];
    gamerulesTextFont.font=[UIFont fontWithName:font65 size:24];
    tpLittleTextFont.font=[UIFont fontWithName:font65 size:15];
    
    plantName.font=[UIFont fontWithName:font65 size:18];
    plantremarksTextFont.font=[UIFont fontWithName:font65 size:15];
    plantstatusTextFont.font=[UIFont fontWithName:font65 size:18];
    bignumber.font=[UIFont fontWithName:font65 size:50];
    smorenumber.font=[UIFont fontWithName:font65 size:20];
    tryNowCWLabelTextFont.font=[UIFont fontWithName:font65 size:50];
    tpGamerulesTextFont.font=[UIFont fontWithName:font65 size:24];
    cwLittleTextFont.font=[UIFont fontWithName:font65 size:19];
    cwTitleTextFont2=[[UILabel alloc]init];
    cwTitleTextFont2.numberOfLines=5;
    cwTitleTextFont2.textColor=[UIColor colorWithRed:85/255.0 green:102/255.0 blue:105/255.0 alpha:1];

    cwTitleTextFont2.font=[UIFont fontWithName:font65 size:15];
    
        cwTitleTextFont2.textAlignment=NSTextAlignmentCenter;
    
    cwTitleTextFont2.backgroundColor=[UIColor clearColor];
    [wptitleblackScrollview addSubview:cwTitleTextFont2];
    
    [cwLittleTextFont sizeToFit];
     strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"Done"]];
    NSString *strBunle=[[NSBundle mainBundle] pathForResource:@"dot" ofType:@"png"];
    UIImage *imageDot=[[UIImage alloc]initWithContentsOfFile:strBunle];
    UIImageView * imageViewDot1=[[UIImageView alloc]initWithImage:imageDot];
     UIImageView * imageViewDot2=[[UIImageView alloc]initWithImage:imageDot];

    if ([strTempTemp isEqualToString:@"Done"]) {
        cwTitleTextFont2.frame=CGRectMake(0, 200+35, 250, 65);
        cwLittleTextFont.frame=CGRectMake(0, 40, 250, 210);
           wptitleblackScrollview.contentSize=CGSizeMake(250,200+35+60+20);
        tpLittleTextFont.frame=CGRectMake(0, 0, 250, 170);
        imageViewDot1.frame=CGRectMake(5, 27, 5, 5);
         imageViewDot2.frame=CGRectMake(5, 72, 5, 5);
    }
    else
    {
       cwLittleTextFont.frame=CGRectMake(0, 40, 250, 160);
           cwTitleTextFont2.frame=CGRectMake(0, 160+35, 250, 65);
  
        wptitleblackScrollview.contentSize=CGSizeMake(250,200+60+20);
            tpLittleTextFont.frame=CGRectMake(0,0, 250, 170);
        imageViewDot1.frame=CGRectMake(6, 27, 5, 5);
        imageViewDot2.frame=CGRectMake(6, 72, 5, 5);
    }

    

    
    if(targetSetValue!=nil){
        _hideView.hidden=true;
        _adviseText.hidden=true;
    }
    
    tpTextLittleBackGuandView.layer.borderWidth=1;
    tpTextLittleBackGuandView.layer.cornerRadius=8;
    tpTryNowBackGuandView.layer.cornerRadius=8;
    tpTextLittleBackGuandView.layer.borderColor=(__bridge CGColorRef)([UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]);
    tpTryNowBackGuandView.layer.borderWidth=1;
    tpTryNowBackGuandView.layer.borderColor=(__bridge CGColorRef)([UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]);
    
    
    cwTextLittleBackGuandVIew.layer.borderWidth=1;
    cwTextLittleBackGuandVIew.layer.cornerRadius=8;
    cwTryNowBackGuandView.layer.cornerRadius=8;
    cwTextLittleBackGuandVIew.layer.borderColor=(__bridge CGColorRef)([UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]);
    cwTryNowBackGuandView.layer.borderWidth=1;
    cwTryNowBackGuandView.layer.borderColor=(__bridge CGColorRef)([UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]);
    
 
    tptitleblackScrollview.contentSize=CGSizeMake(257, 150);
    [tptitleblackScrollview addSubview:imageViewDot1];
       [tptitleblackScrollview addSubview:imageViewDot2];
}

-(IBAction)toTPTryNow:(id)sender
{
    
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)
    {
        //[_toTPButton.imageView setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"]];
        
        [_toTPButton setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"] forState:UIControlStateNormal];
        
    }
    tryNowBackGuandViewSum.hidden=NO;
    cwTryNowBackGuandView.hidden=YES;
    tpTryNowBackGuandView.hidden=NO;
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    BOOL tp_isStarted=[defaults objectForKey:@"tp_isStarted_99999999"];
//    
//    if(([GlobalVariables shareInstance].session_id!=NULL||[GlobalVariables shareInstance].login_id!=NULL)&&![SyncGame isShowTrophyTryNow]){
//        [tpOK_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
//    }
//    else if(([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)&&!tp_isStarted){
//        [tpOK_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
//    }
    

    
}
-(IBAction)toCWTryNow:(id)sender
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    BOOL cw_isStarted=[defaults objectForKey:@"cw_isStarted_99999999"];
//    if(([GlobalVariables shareInstance].session_id!=NULL||[GlobalVariables shareInstance].login_id!=NULL)&&![SyncGame isShowPlantTryNow]){
//        [ok_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
//    }
//    else if(([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)&&!cw_isStarted){
//        [ok_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
//    }


    
    
    
//    if(![SyncGame isShowPlantTryNow])
//        [SyncGame updatePlantTryNow];
//
    tryNowBackGuandViewSum.hidden=NO;
    cwTryNowBackGuandView.hidden=NO;
    tpTryNowBackGuandView.hidden=YES;
    if (tryNowCW.hidden==YES) {
        plantName.hidden=NO;
        plantremarksTextFont.hidden=NO;
        
    }
    else
    {
        plantName.hidden=YES;
        plantremarksTextFont.hidden=YES;
    }
    NSLog(@"plantName.text=%@",plantName.text);
    NSLog(@"plantName.hidden=%d",plantName.hidden);
//    BlackWFHGFViewController* bwfhgView=[[BlackWFHGFViewController alloc]initWithNibName:@"BlackWFHGFViewController" bundle:nil];
//    bwfhgView.toTPorCW=2;
//    bwfhgView.dicCW=[[NSMutableDictionary alloc] initWithDictionary:self.dicCW];
//    
//    [self.navigationController pushViewController:bwfhgView animated:NO];
    
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"true" forKey:@"cw_isStarted_99999999"];
        [defaults synchronize];
    }
   

    
}
-(IBAction)toAwards:(id)sender
{
    AwardsViewController *awards=[[AwardsViewController alloc]initWithNibName:@"AwardsViewController" bundle:nil];
    awards.plantArrayCW=[[NSMutableArray alloc]initWithArray:self.plantArrayCW];
    awards.plantArrayTP=[[NSMutableArray alloc]initWithArray:self.plantArrayTP];
    [self.navigationController pushViewController:awards animated:YES];
    
}
-(IBAction)BackHome:(id)sender{

//    [self showhideMenu];
    
    [self backToHome];

    
}
-(IBAction)toStarting:(id)sender
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * tp_Started=[defaults objectForKey:@"tp_isStarted_99999999"];
    BOOL tp_isStarted ;
    
    if (tp_Started == 0) {
        tp_isStarted = false;
    }
    else
    {
        tp_isStarted = true;
    }
    if (([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)&&!tp_isStarted){
//        [ok_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
        [tpOK_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
        
        tryNowBackGuandViewSum.hidden=false;
        cwTryNowBackGuandView.hidden=true;
        tpTryNowBackGuandView.hidden=false;

    }
    else if(([GlobalVariables shareInstance].session_id!=NULL||[GlobalVariables shareInstance].login_id!=NULL)&&![SyncGame isShowTrophyTryNow]){
//        [ok_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
        [tpOK_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
        
        tryNowBackGuandViewSum.hidden=false;
        cwTryNowBackGuandView.hidden=true;
        tpTryNowBackGuandView.hidden=false;
    }
    else{
        
        TrainingRecord *record=[DBHelper getLatestTrainRecord];
        
        NSLog(@"status...........%d",[record getStatus]);
        NSLog(@"level...........%ld",(long)[record getLevel]);
        NSLog(@"id...........%@",record.trainid);
        NSLog(@"starttime...........%ld",[record getStarttime]);
        NSLog(@"formatStarttime...........%@",[[NSDate alloc] initWithTimeIntervalSince1970:[record getStarttime]]);
        
        if (record!=nil) {
            
            NSDate *startDate=[[NSDate alloc] initWithTimeIntervalSince1970:[record getStarttime]];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            
            
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:startDate];
            
            NSInteger year=dateComponent.year;
            NSInteger month=dateComponent.month;
            NSInteger day=dateComponent.day;
            
            //        NSLog(@"year...........%d",year);
            //        NSLog(@"month...........%d",month);
            //        NSLog(@"day...........%d",day);
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
            
            
            NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([recordStart timeIntervalSinceReferenceDate] + 6*24*3600)];
            dateComponent = [calendar components:unitFlags fromDate:newDate];
            year=dateComponent.year;
            month=dateComponent.month;
            day=dateComponent.day;
            NSLog(@"year...........%ld",(long)year);
            NSLog(@"month...........%ld",(long)month);
            NSLog(@"day...........%ld",(long)day);
            NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
            
            
            
            
            
            //        NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%d-%d-%d 23:59:59",year,month,day+6]];
            
            //NSLog(@"check the recordEndtime : %ld-%ld-%ld",(long)year,(long)month,day+6);
            NSLog(@"[record getStatus] is %d",[record getStatus]);
            NSLog(@"[NSDate date] timeIntervalSince1970] is %f",[[NSDate date] timeIntervalSince1970]);
            NSLog(@"[recordEnd timeIntervalSince1970] is %f",[recordEnd timeIntervalSince1970]);
            
            
            
            if ([record getStatus]==2&&([[NSDate date] timeIntervalSince1970]<[recordEnd timeIntervalSince1970])) {
                
                CurrentWeeklyProgressViewController*current=[[CurrentWeeklyProgressViewController alloc]initWithNibName:@"CurrentWeeklyProgressViewController" bundle:nil];
                
//                [current setHideWaitView];
                
                [self.navigationController pushViewController:current animated:YES];
                
                
            }else{
                
                StartingFromBronzeViewController *starting=[[StartingFromBronzeViewController alloc]initWithNibName:@"StartingFromBronzeViewController" bundle:nil];
                [self.navigationController pushViewController:starting animated:YES];
            }
            
            
        }else{
            
            StartingFromBronzeViewController *starting=[[StartingFromBronzeViewController alloc]initWithNibName:@"StartingFromBronzeViewController" bundle:nil];
            [self.navigationController pushViewController:starting animated:YES];
        }
        

    }
    
  
    
    
    
    
    
}

-(IBAction)toCasualWalk:(id)sender{
    //vaycent
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL cw_isStarted;
   NSNumber *cw_Started=[defaults objectForKey:@"cw_isStarted_99999999"];
    if (cw_Started ==0) {
        cw_isStarted = false;
    }
    else
    {
        cw_isStarted = true;
    }
    if (([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)&&!cw_isStarted){
        [ok_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
//        [tpOK_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
        
        tryNowBackGuandViewSum.hidden=false;
        cwTryNowBackGuandView.hidden=false;
        tpTryNowBackGuandView.hidden=true;
        
    }
    else if(([GlobalVariables shareInstance].session_id!=NULL||[GlobalVariables shareInstance].login_id!=NULL)&&![SyncGame isShowPlantTryNow]){
        [ok_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
//        [tpOK_btn setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
        
        tryNowBackGuandViewSum.hidden=false;
        cwTryNowBackGuandView.hidden=false;
        tpTryNowBackGuandView.hidden=true;
    }
    else{
        PedometerViewController *cwView = [[PedometerViewController alloc] initWithNibName:@"PedometerViewController" bundle:nil];
        [cwView setPaceSetValue:paceSetValue];
        [cwView setTargetSetValue:targetSetValue];
        
        [self.navigationController pushViewController:cwView animated:YES ];
    }
}


-(IBAction)toHistory:(id)sender{
    
//    NSString *session_id = [GlobalVariables shareInstance].session_id;
//    NSString *login_id = [GlobalVariables shareInstance].login_id;
//    if(session_id==NULL||login_id==NULL){
//        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
//        [historyView setType:@"walk"];
//        [self.navigationController pushViewController:historyView animated:YES ];
//    }
//    else{
        WalkingHistoryViewController *historyView = [[WalkingHistoryViewController alloc] initWithNibName:@"WalkingHistoryViewController" bundle:nil];
        
        [self.navigationController pushViewController:historyView animated:YES ];
  //  }
    
  
    
}



-(IBAction)tobeDoneWithCW:(id)sender
{
    tryNowBackGuandViewSum.hidden=true;
    cwTryNowBackGuandView.hidden=true;
    tpTryNowBackGuandView.hidden=true;
    
    [_toCWButton setImage:[UIImage imageNamed:@"07_wa_index_btn_cw_2.png"] forState:UIControlStateNormal];

    
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"true" forKey:@"cw_isStarted_99999999"];
        [defaults synchronize];
        
        
        if([ok_btn.titleLabel.text isEqualToString:[Utility getStringByKey:@"tr_start"]]){
            
            tryNowBackGuandViewSum.hidden=true;
            tryNowCWLabelTextFont.hidden=true;
            cwTryNowBackGuandView.hidden=true;
            
            PedometerViewController *cwView = [[PedometerViewController alloc] initWithNibName:@"PedometerViewController" bundle:nil];
            [cwView setPaceSetValue:paceSetValue];
            [cwView setTargetSetValue:targetSetValue];
            
            [self.navigationController pushViewController:cwView animated:YES ];
            
            
        }else{
            
            bignumber.hidden=false;
            smorenumber.hidden=false;
            
            tryNowCW.hidden=true;
            numberTwoCW.hidden=false;
            numberOneCW.hidden=false;
            
            tryNowBackGuandViewSum.hidden=true;
            tryNowCWLabelTextFont.hidden=true;
            cwTryNowBackGuandView.hidden=true;

        }

        
        
    }
    else
    {
        if (![SyncGame isShowPlantTryNow]) {   //减少call api
            [SyncGame updatePlantTryNow];
        }
        if([ok_btn.titleLabel.text isEqualToString:[Utility getStringByKey:@"tr_start"]]){
            PedometerViewController *ped=[[PedometerViewController alloc]initWithNibName:@"PedometerViewController" bundle:nil];
                      [ped setPaceSetValue:paceSetValue];
                    [ped setTargetSetValue:targetSetValue];
                  [self.navigationController pushViewController:ped animated:YES];
        }else{
            tryNowBackGuandViewSum.hidden=YES;
            tpTryNowBackGuandView.hidden=YES;
            cwTryNowBackGuandView.hidden=YES;
            
            
            
        }
        //vaycent add
        bignumber.hidden=false;
        smorenumber.hidden=false;
        
        tryNowCWLabelTextFont.hidden=true;
        tryNowCW.hidden=true;
        numberTwoCW.hidden=false;
        numberOneCW.hidden=false;

    }
    
}
-(IBAction)tobeDoneWithTP:(id)sender
{
    
    tryNowBackGuandViewSum.hidden=true;
    cwTryNowBackGuandView.hidden=true;
    tpTryNowBackGuandView.hidden=true;
    
     [_toTPButton setImage:[UIImage imageNamed:@"07_wa_index_btn_tr_2.png"] forState:UIControlStateNormal];
    
    
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)
    {
        NSLog(@"is atcion");
        
        //        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
        //        [historyView setType:@"walk"];
        //        [self.navigationController pushViewController:historyView animated:YES ];
        
        //
        
       
        
        
        
        if([tpOK_btn.titleLabel.text isEqualToString:[Utility getStringByKey:@"tr_start"]]){
        
                    tryNowBackGuandViewSum.hidden=true;
                    tryNowCWLabelTextFont.hidden=true;
                    cwTryNowBackGuandView.hidden=true;
        
                    StartingFromBronzeViewController *starting=[[StartingFromBronzeViewController alloc]initWithNibName:@"StartingFromBronzeViewController" bundle:nil];
                    [self.navigationController pushViewController:starting animated:YES];
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"true" forKey:@"tp_isStarted_99999999"];
            
            [defaults synchronize];
            
        }else{

      
            tryNowTPLabelTextFont.hidden=true;
       
            rewardNumber.hidden=true;
        
            percentTextFont.hidden=true;
        
       
            tryNowBackGuandViewSum.hidden=true;
        
            tpTryNowBackGuandView.hidden=true;
      
            cwTryNowBackGuandView.hidden=true;
      
            //[_toTPButton.imageView setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"]];

        
            [_toTPButton setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"] forState:UIControlStateNormal];
        
            
        }
        
    }
    else
    {
        if (![SyncGame isShowTrophyTryNow]){  //减少call api
            [SyncGame updateTrophyTryNow];
        }
        
        
        //    if (![SyncGame isShowTrophyTryNow])
        if([tpOK_btn.titleLabel.text isEqualToString:[Utility getStringByKey:@"tr_start"]]){
            
            
            
            
            TrainingRecord *record=[DBHelper getLatestTrainRecord];
            
            NSLog(@"status...........%d",[record getStatus]);
            NSLog(@"level...........%ld",(long)[record getLevel]);
            NSLog(@"id...........%@",record.trainid);
            NSLog(@"starttime...........%ld",[record getStarttime]);
            NSLog(@"formatStarttime...........%@",[[NSDate alloc] initWithTimeIntervalSince1970:[record getStarttime]]);
            
            if (record!=nil) {
                
                NSDate *startDate=[[NSDate alloc] initWithTimeIntervalSince1970:[record getStarttime]];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
                
                
                NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:startDate];
                
                NSInteger year=dateComponent.year;
                NSInteger month=dateComponent.month;
                NSInteger day=dateComponent.day;
                
                //        NSLog(@"year...........%d",year);
                //        NSLog(@"month...........%d",month);
                //        NSLog(@"day...........%d",day);
                
                NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];
                
                
                NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([recordStart timeIntervalSinceReferenceDate] + 6*24*3600)];
                dateComponent = [calendar components:unitFlags fromDate:newDate];
                year=dateComponent.year;
                month=dateComponent.month;
                day=dateComponent.day;
                NSLog(@"year...........%ld",(long)year);
                NSLog(@"month...........%ld",(long)month);
                NSLog(@"day...........%ld",(long)day);
                NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];
                
                
                
                
                
                //        NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%d-%d-%d 23:59:59",year,month,day+6]];
                
                //NSLog(@"check the recordEndtime : %ld-%ld-%ld",(long)year,(long)month,day+6);
                NSLog(@"[record getStatus] is %d",[record getStatus]);
                NSLog(@"[NSDate date] timeIntervalSince1970] is %f",[[NSDate date] timeIntervalSince1970]);
                NSLog(@"[recordEnd timeIntervalSince1970] is %f",[recordEnd timeIntervalSince1970]);
                
                
                
                if ([record getStatus]==2&&([[NSDate date] timeIntervalSince1970]<[recordEnd timeIntervalSince1970])) {
                    
                    CurrentWeeklyProgressViewController*current=[[CurrentWeeklyProgressViewController alloc]initWithNibName:@"CurrentWeeklyProgressViewController" bundle:nil];
                    
//                    [current setHideWaitView];
                    
                    [self.navigationController pushViewController:current animated:YES];
                    
                    
                }else{
                    
                    StartingFromBronzeViewController *starting=[[StartingFromBronzeViewController alloc]initWithNibName:@"StartingFromBronzeViewController" bundle:nil];
                    [self.navigationController pushViewController:starting animated:YES];
                }
                
                
            }else{
                
                StartingFromBronzeViewController *starting=[[StartingFromBronzeViewController alloc]initWithNibName:@"StartingFromBronzeViewController" bundle:nil];
                [self.navigationController pushViewController:starting animated:YES];
            }
            
            
        }
        else
        {
            //NSLog(@"is atcion");
            
            numberOneTP.hidden=false;
                numberTwoTP.hidden=false;
            
            
            tryNowBackGuandViewSum.hidden=YES;
            tpTryNowBackGuandView.hidden=YES;
            cwTryNowBackGuandView.hidden=YES;
        }
    }
    
    //vaycent add
//    tryNowTP.hidden=true;
//    numberOneTP.hidden=false;
//    numberTwoTP.hidden=false;
//    
//    tryNowTPLabelTextFont.hidden=true;
//    rewardNumber.hidden=false;
//    percentTextFont.hidden=false;
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)firstTimeSetUpCasualWalk{
    {
        GameObject *gameOBjectCW= [DBHelper getPlantProgress];
        if ([gameOBjectCW.progress isEqualToString:@"6"])    //跑滿6日且過了1日
        {
            long long strLong=[[NSDate date] timeIntervalSince1970] ;
            long long  lastTime=strLong-[gameOBjectCW getEndDate];
            if (lastTime>=86400)
            {
                gameOBjectCW.gameType=@"";
                gameOBjectCW.plantType=@"";
                gameOBjectCW.plantName=@"";
                gameOBjectCW.progress=@"0";
            }
            else
            {
            }
        }
        if (gameOBjectCW.plantType!=nil)     //已經開始跑了
        {
            NSString * str1=gameOBjectCW.gameType;
            if (str1==NULL) {
                str1=@"";
            }
            
            NSString *str2=gameOBjectCW.plantType;
            if (str2==NULL) {
                str2=@"";
            }
            NSString *str3=gameOBjectCW.plantName;
            if (str3==NULL) {
                str3=@"";
            }
            long long strLong=[[NSDate date] timeIntervalSince1970] ;
            long long  lastTime=strLong-[gameOBjectCW getEndDate];
            long long  howday=(lastTime/86400)/7;
            if (howday<0) {
                howday=0;
            }
            NSLog(@"howday:%lld",howday);
            NSString*str4=[[NSString alloc]initWithFormat:@"%lld",[gameOBjectCW.progress intValue]-howday];
            if ([str4 intValue]<0 ) {
                str4=@"0";
            }
            NSString *str5=gameOBjectCW.status;
            if (str5==NULL) {
                str5=@"";
            }
            NSLog(@"%@,%@,%@,%@,%@",str5,str4,str3,str2,str1);
            self.dicCW=[NSDictionary dictionaryWithObjectsAndKeys:
                        str1,@"gameType",
                        str2,@"plantType",
                        str3,@"plantName",
                        str4,@"progress",
                        str5,@"status",
                        nil];
            NSLog(@"self.dicCW===%@",self.dicCW);
            isTryNowCW=YES;
            GameObject *result=[[GameObject alloc] init];
            
            result.progress=str4;
            result.plantName=str3;
            result.plantType=str2;
            result.gameType=@"WalkPlanyt";
            result.status=@"0";
            if (howday>0) {
                [result setEndDate:[gameOBjectCW getEndDate]+(7*86400*howday)];
            }
            else
            {
                [result setEndDate:[gameOBjectCW getEndDate]];
            }
            
            [DBHelper addPlant:result];
        }
        if(gameOBjectCW.plantType==nil){
            NSLog(@"9999999u7");
            //            gameOBjectCW.plantType=@"";
            gameOBjectCW.plantName=@"";
            gameOBjectCW.progress=@"0";
            gameOBjectCW.status=@"0";
            gameOBjectCW.gameType=@"WalkPlanyt";
            [gameOBjectCW setEndDate:[gameOBjectCW getEndDate]];
            [DBHelper addPlant:gameOBjectCW];
        }
        
    }
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
//    BOOL tp_isStarted=[defaults1 objectForKey:@"tp_isStarted_99999999"];
    
    BOOL cw_isStarted;
    
    NSNumber *cw_Started =[defaults1 objectForKey:@"cw_isStarted_99999999"];
    if (cw_Started ==0) {
        cw_isStarted = true;
    }
    else
    {
        cw_isStarted= false;
    }
    
    
    //    if(tp_isStarted){
//        tryNowTP.hidden=true;
//
//        //[_toTPButton.imageView setImage:[UIImage imageNamed:@"07_wa_index_btn_tr_2.png"]];
//
//        [_toTPButton setImage:[UIImage imageNamed:@"07_wa_index_btn_tr_2.png"] forState:UIControlStateNormal];
//        
//        numberOneTP.hidden=false;
//        numberTwoTP.hidden=false;
//        
//        tryNowTPLabelTextFont.hidden=true;
//        rewardNumber.hidden=false;
//        percentTextFont.hidden=false;
//    }else{
        tryNowTP.hidden=true;
        //[_toTPButton.imageView setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"]];
 
        [_toTPButton setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"] forState:UIControlStateNormal];
        
        numberOneTP.hidden=true;
        numberTwoTP.hidden=true;
        
        tryNowTPLabelTextFont.hidden=true;
        rewardNumber.hidden=true;
        percentTextFont.hidden=true;
//    }
    if(cw_isStarted){
        tryNowCW.hidden=true;
        //[_toCWButton.imageView setImage:[UIImage imageNamed:@"07_wa_index_btn_cw_2.png"]];
        
        [_toCWButton setImage:[UIImage imageNamed:@"07_wa_index_btn_cw_2.png"] forState:UIControlStateNormal];

        numberTwoCW.hidden=false;
        numberOneCW.hidden=false;
        
        tryNowCWLabelTextFont.hidden=true;
        bignumber.hidden=false;
        smorenumber.hidden=false;
        
    }else{
        tryNowCW.hidden=true;
        //[_toCWButton.imageView setImage:[UIImage imageNamed:@"new_index_btn_cw_game_2.png"]];

        [_toCWButton setImage:[UIImage imageNamed:@"new_index_btn_cw_game_2.png"] forState:UIControlStateNormal];
        
        numberTwoCW.hidden=true;
        numberOneCW.hidden=true;
        
        tryNowCWLabelTextFont.hidden=false;
        bignumber.hidden=true;
        smorenumber.hidden=true;
        
    }


}


-(void)setUpViewHidden{
    {
        if([SyncGame isShowTrophyTryNow]){
            tryNowTP.hidden=true;
            //[_toTPButton.imageView setImage:[UIImage imageNamed:@"07_wa_index_btn_tr_2.png"]];

            [_toTPButton setImage:[UIImage imageNamed:@"07_wa_index_btn_tr_2.png"] forState:UIControlStateNormal];
            
            numberOneTP.hidden=false;
            numberTwoTP.hidden=false;
            
            tryNowTPLabelTextFont.hidden=true;
            rewardNumber.hidden=false;
            percentTextFont.hidden=false;
            
        }else{
            tryNowTP.hidden=true;
            //[_toTPButton.imageView setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"]];
            
            [_toTPButton setImage:[UIImage imageNamed:@"new_index_btn_tp_game_2.png"] forState:UIControlStateNormal];

            numberOneTP.hidden=true;
            numberTwoTP.hidden=true;
            
            tryNowTPLabelTextFont.hidden=false;
            rewardNumber.hidden=true;
            percentTextFont.hidden=true;
            
        }
        if([SyncGame isShowPlantTryNow]){
            tryNowCW.hidden=true;
            //[_toCWButton.imageView setImage:[UIImage imageNamed:@"07_wa_index_btn_cw_2.png"]];

            
            [_toCWButton setImage:[UIImage imageNamed:@"07_wa_index_btn_cw_2.png"] forState:UIControlStateNormal];
            
            numberTwoCW.hidden=false;
            numberOneCW.hidden=false;
            
            tryNowCWLabelTextFont.hidden=true;
            bignumber.hidden=false;
            smorenumber.hidden=false;
            
        }else{
            tryNowCW.hidden=true;
            //[_toCWButton.imageView setImage:[UIImage imageNamed:@"new_index_btn_cw_game_2.png"]];

            
            [_toCWButton setImage:[UIImage imageNamed:@"new_index_btn_cw_game_2.png"] forState:UIControlStateNormal];
            
            numberTwoCW.hidden=true;
            numberOneCW.hidden=true;
            
            tryNowCWLabelTextFont.hidden=false;
            bignumber.hidden=true;
            smorenumber.hidden=true;
            
        }
        
    }
}


-(void)setUpTrophyValue{
    // value==============>>>>>>>
    GameObject *gameOBjectTP=  [DBHelper getTrophyProgress];
    int theNumberOftheTrophy=[gameOBjectTP.progress intValue]*10;
    NSString *tpProgress=[[NSString alloc]initWithFormat:@"%d", theNumberOftheTrophy];
    numberOneTP.text=tpProgress;
    rewardNumber.text=tpProgress;
    
    [rewardSchemeTextFont setText:[Utility getStringByKey:@"Reward Scheme"]];
    [tpOK_btn setTitle:[Utility getStringByKey:@"back"] forState:UIControlStateNormal];
    [tryNowTPLabelTextFont setText:@""];
    
    
    //set up picture========>>>>>>>>>
    NSString *trophyImageStr0=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_00" ofType:@"png"];
    
    NSString *trophyImageStr1=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_01" ofType:@"png"];
    NSString *trophyImageStr2=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_02" ofType:@"png"];
    NSString *trophyImageStr3=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_03" ofType:@"png"];
    NSString *trophyImageStr4=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_04" ofType:@"png"];
    NSString *trophyImageStr5=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_05" ofType:@"png"];
    NSString *trophyImageStr6=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_06" ofType:@"png"];
    NSString *trophyImageStr7=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_07" ofType:@"png"];
    NSString *trophyImageStr8=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_08" ofType:@"png"];
    NSString *trophyImageStr9=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_09" ofType:@"png"];
    NSString *trophyImageStr10=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_10" ofType:@"png"];

    if (theNumberOftheTrophy==0) {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr0];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=0&&theNumberOftheTrophy<10)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr0];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=10&&theNumberOftheTrophy<20)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr1];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=20&&theNumberOftheTrophy<30)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr2];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=30&&theNumberOftheTrophy<40)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr3];
        rewardpicture.image=theTrophyImage;
    }
    
    else if (theNumberOftheTrophy>=40&&theNumberOftheTrophy<50)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr4];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=50&&theNumberOftheTrophy<60)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr5];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=60&&theNumberOftheTrophy<70)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr6];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=70&&theNumberOftheTrophy<80)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr7];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=80&&theNumberOftheTrophy<90)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr8];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy>=90&&theNumberOftheTrophy<100)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr9];
        rewardpicture.image=theTrophyImage;
    }
    else if (theNumberOftheTrophy==100)
    {
        theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr10];
        rewardpicture.image=theTrophyImage;
    }
    
    // how it works ===============>
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"]){
        tpGamerulesTextFont.text=@"How it works";
        tpLittleTextFont.text=@"     Get a medal every time you complete a Training Programme.\n\n     Get 10 medals consecutively to win a trophy and a HK$100 health products coupon.\n\nStart now and get your first medal!";
        gamerulesTextFont.text=@"How it works";
        cwLittleTextFont.text=@"Transform the energy from walking to help your plant grow by walking 30 minutes a day with 80 steps per minute.\n\nStart building a good walking habit now and have fun.\n\n";
        cwTitleTextFont2.text=@"Each plant has 6 stages of growth and it can only grow once a day. Walk at least once a week or else it will regress to the previous stage.";
        
        
    }
    else
    {
        tpGamerulesTextFont.text=@"簡介";
        tpLittleTextFont.text=@"      每完成⼀個「步⾏計劃」,你將獲取⼀面獎牌。\n\n      連續完成10個「步行計劃」,你將獲 得⼀個獎盃及HK$100健康產品禮券。\n\n⽴即開始並獲取你嘅⾸面獎牌!";
        gamerulesTextFont.text=@"簡介";
        cwLittleTextFont.text=@"將步行轉化為能量,以每日每分鐘80步嘅步速步行30分鐘,就足夠培植你嘅植物成長。\n\n⽴即建立良好步行習慣,享受箇中樂趣!\n\n";
        cwTitleTextFont2.text=@"每棵植物都有6個成長階段,⽽每日只可成⾧⼀次。每星期必須⾄少步⾏⼀次,不然植物將退化至前一個成長階段。";
    }


}



-(void)setUpCasualWalkValue{
    GameObject *gameOBjectCW= [DBHelper getPlantProgress];
    numberOneCW.text=gameOBjectCW.progress==nil?@"0":gameOBjectCW.progress;
    
    [ok_btn setTitle:[Utility getStringByKey:@"back"] forState:UIControlStateNormal];
    [plantstatusTextFont setText:[Utility getStringByKey:@"Plant Status"]];
    [tryNowCWLabelTextFont setText:@""];
    
    NSString * Treestr=@"";
    if(gameOBjectCW.plantType!=nil){
        plantName.text=gameOBjectCW.plantName;
        bignumber.text=gameOBjectCW.progress;
        Treestr=gameOBjectCW.plantType;
    }
    
    
    
    NSString *lemonTreeImageStr0=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_dim" ofType:@"png"];
    NSString *lemonTreeImageStr1=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_00" ofType:@"png"];
    NSString *lemonTreeImageStr2=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_02" ofType:@"png"];
    NSString *lemonTreeImageStr3=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_03" ofType:@"png"];
    NSString *lemonTreeImageStr4=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_04" ofType:@"png"];
    NSString *lemonTreeImageStr5=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_05" ofType:@"png"];
    NSString *lemonTreeImageStr6=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_06" ofType:@"png"];
    NSString *lemonTreeImageStr7=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_07" ofType:@"png"];
    
    
    
    NSString *orangeTreeImageStr0=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_dim" ofType:@"png"];
    NSString *orangeTreeImageStr1=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_00" ofType:@"png"];
    
    NSString *orangeTreeImageStr2=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_02" ofType:@"png"];
    NSString *orangeTreeImageStr3=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_03" ofType:@"png"];
    NSString *orangeTreeImageStr4=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_04" ofType:@"png"];
    NSString *orangeTreeImageStr5=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_05" ofType:@"png"];
    NSString *orangeTreeImageStr6=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_06" ofType:@"png"];
    NSString *orangeTreeImageStr7=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_07" ofType:@"png"];
    
    
    NSString *tomatoTreeImageStr1=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_00" ofType:@"png"];
    NSString *tomatoTreeImageStr2=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_02" ofType:@"png"];
    NSString *tomatoTreeImageStr3=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_03" ofType:@"png"];
    NSString *tomatoTreeImageStr4=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_04" ofType:@"png"];
    NSString *tomatoTreeImageStr5=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_05" ofType:@"png"];
    NSString *tomatoTreeImageStr6=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_06" ofType:@"png"];
    NSString *tomatoTreeImageStr7=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_07" ofType:@"png"];
    
    
    NSString *lanuage = [Utility getLanguageCode];
    if ([Treestr isEqualToString:@"T"]) {
        if([lanuage isEqualToString: @"en"]){
            plantremarksTextFont.text=@"Tomato tree";
        }else{
            plantremarksTextFont.text=@"蕃茄樹";
        }
        int theNumberOftheTrophy=[bignumber.text intValue];
        if (theNumberOftheTrophy==0) {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr1];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==1)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr2];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==2)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr3];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==3)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr4];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==4)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr5];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==5)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr6];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==6)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr7];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==7)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr7];
            plantpicture.image=theTrophyImage;
        }
    }
    else if ([Treestr isEqualToString:@"L"]) {
        if([lanuage isEqualToString: @"en"]){
            plantremarksTextFont.text=@"Lemon tree";
        }else{
            plantremarksTextFont.text=@"檸檬樹";
        }
        int theNumberOftheTrophy=[bignumber.text intValue];
        if (theNumberOftheTrophy==0) {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr1];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==1)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr2];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==2)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr3];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==3)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr4];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==4)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr5];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==5)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr6];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==6)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr7];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==7)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr0];
            plantpicture.image=theTrophyImage;
        }
    }
    else  if ([Treestr isEqualToString:@"O"])
    {
        if([lanuage isEqualToString: @"en"]){
            plantremarksTextFont.text=@"Orange tree";
        }else{
            plantremarksTextFont.text=@"橙樹";
        }
        int theNumberOftheTrophy=[bignumber.text intValue];
        if (theNumberOftheTrophy==0) {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr1];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==1)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr2];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==2)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr3];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==3)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr4];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==4)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr5];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==5)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr6];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==6)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr7];
            plantpicture.image=theTrophyImage;
        }
        else if (theNumberOftheTrophy==7)
        {
            theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr0];
            plantpicture.image=theTrophyImage;
        }
    }
}

@end
