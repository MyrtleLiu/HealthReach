////  BlackWFHGFViewController.m//  mHealth////  Created by admin on 3/2/15.////#import "BlackWFHGFViewController.h"#import "PedometerViewController.h"#import "TrainingPedometerViewController.h"#import "HomeViewController.h"#import "StartingFromBronzeViewController.h"    #import "CurrentWeeklyProgressViewController.h"#import "SyncGame.h"#import "LearnMoreFirstViewController.h"@interface BlackWFHGFViewController ()@end@implementation BlackWFHGFViewController@synthesize paceSetValue;@synthesize targetSetValue;- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];    if (!iPad) {        self = [super initWithNibName:@"BlackWFHGFViewController" bundle:nibBundleOrNil];    }    else    {        NSLog(@"3.5 inch");        self = [super initWithNibName:@"BlackWFHGFViewController3.5" bundle:nibBundleOrNil];    }    if (self) {                    }    return self;}-(void)viewWillAppear:(BOOL)animated{    tpTextLittleBackGuandView.layer.borderWidth=1;    tpTextLittleBackGuandView.layer.cornerRadius=8;    tpTryNowBackGuandView.layer.cornerRadius=8;    tpTextLittleBackGuandView.layer.borderColor=(__bridge CGColorRef)([UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]);    tpTryNowBackGuandView.layer.borderWidth=1;    tpTryNowBackGuandView.layer.borderColor=(__bridge CGColorRef)([UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]);            cwTextLittleBackGuandVIew.layer.borderWidth=1;    cwTextLittleBackGuandVIew.layer.cornerRadius=8;    cwTryNowBackGuandView.layer.cornerRadius=8;    cwTextLittleBackGuandVIew.layer.borderColor=(__bridge CGColorRef)([UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]);    cwTryNowBackGuandView.layer.borderWidth=1;    cwTryNowBackGuandView.layer.borderColor=(__bridge CGColorRef)([UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1]);        wptitleblackScrollview.contentSize=CGSizeMake(270, 180);        tptitleblackScrollview.contentSize=CGSizeMake(270, 260);      [ok_btn.titleLabel setText:[Utility getStringByKey:@"ok"]];    NSLog(@"PACE TESST : %D",paceSetValue);    NSLog(@"target TESST : %@",targetSetValue);    if(targetSetValue!=nil){//        _hideView.hidden=true;//        _adviseText.hidden=true;    }    walkforHealthTextHeanFont.font=[UIFont fontWithName:font65 size:18];    tryNowTPLabelTextFont.font=[UIFont fontWithName:font65 size:23];    rewardSchemeTextFont.font=[UIFont fontWithName:font65 size:18];    rewardNumber.font=[UIFont fontWithName:font45 size:46];    percentTextFont.font=[UIFont fontWithName:font45 size:23];    gamerulesTextFont.font=[UIFont fontWithName:font65 size:24];    tpLittleTextFont.font=[UIFont fontWithName:font65 size:15];    [rewardSchemeTextFont setText:[Utility getStringByKey:@"Reward Scheme"]];           [ok_btn setTitle:[Utility getStringByKey:@"btn_ok"] forState:UIControlStateNormal];      [tpOK_btn setTitle:[Utility getStringByKey:@"btn_ok"] forState:UIControlStateNormal];        [plantstatusTextFont setText:[Utility getStringByKey:@"Plant Status"]];        plantName.font=[UIFont fontWithName:font65 size:18];    plantremarksTextFont.font=[UIFont fontWithName:font65 size:15];    plantstatusTextFont.font=[UIFont fontWithName:font65 size:18];    bignumber.font=[UIFont fontWithName:font65 size:50];    smorenumber.font=[UIFont fontWithName:font65 size:20];    tryNowCWLabelTextFont.font=[UIFont fontWithName:font65 size:23];    tpGamerulesTextFont.font=[UIFont fontWithName:font65 size:24];    cwLittleTextFont.font=[UIFont fontWithName:font65 size:15];                              }- (void)viewDidLoad{    [super viewDidLoad];    NSLog(@"my trynow view is %d ,TP=1 CW=2",self.toTPorCW);      NSString *lemonTreeImageStr0=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_dim" ofType:@"png"];    NSString *treeImageStr=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_00" ofType:@"png"];        NSString *lemonTreeImageStr1=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_01" ofType:@"png"];        NSString *lemonTreeImageStr2=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_02" ofType:@"png"];        NSString *lemonTreeImageStr3=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_03" ofType:@"png"];        NSString *lemonTreeImageStr4=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_04" ofType:@"png"];        NSString *lemonTreeImageStr5=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_05" ofType:@"png"];        NSString *lemonTreeImageStr6=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_06" ofType:@"png"];        NSString *lemonTreeImageStr7=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_07" ofType:@"png"];                    NSString *orangeTreeImageStr0=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_dim" ofType:@"png"];    NSString *orangeTreeImageStr1=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_01" ofType:@"png"];         NSString *orangeTreeImageStr2=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_02" ofType:@"png"];     NSString *orangeTreeImageStr3=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_03" ofType:@"png"];     NSString *orangeTreeImageStr4=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_04" ofType:@"png"];     NSString *orangeTreeImageStr5=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_05" ofType:@"png"];     NSString *orangeTreeImageStr6=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_06" ofType:@"png"];     NSString *orangeTreeImageStr7=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_07" ofType:@"png"];                  // NSString *tomatoTreeImageStr0=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_dim" ofType:@"png"];        NSString *tomatoTreeImageStr1=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_01" ofType:@"png"];    NSString *tomatoTreeImageStr2=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_02" ofType:@"png"];    NSString *tomatoTreeImageStr3=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_03" ofType:@"png"];    NSString *tomatoTreeImageStr4=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_04" ofType:@"png"];    NSString *tomatoTreeImageStr5=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_05" ofType:@"png"];    NSString *tomatoTreeImageStr6=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_06" ofType:@"png"];    NSString *tomatoTreeImageStr7=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_07" ofType:@"png"];             NSString *trophyImageStr0=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_00" ofType:@"png"];    NSString *trophyImageStr1=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_01" ofType:@"png"];      NSString *trophyImageStr2=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_02" ofType:@"png"];      NSString *trophyImageStr3=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_03" ofType:@"png"];      NSString *trophyImageStr4=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_04" ofType:@"png"];      NSString *trophyImageStr5=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_05" ofType:@"png"];      NSString *trophyImageStr6=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_06" ofType:@"png"];      NSString *trophyImageStr7=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_07" ofType:@"png"];      NSString *trophyImageStr8=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_08" ofType:@"png"];      NSString *trophyImageStr9=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_09" ofType:@"png"];      NSString *trophyImageStr10=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_10" ofType:@"png"];            strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"Done"]];        if ([strTempTemp isEqualToString:@"Done"])    {       walkforHealthTextHeanFont.text=@"Walk for Health";        tpGamerulesTextFont.text=@"How to Play";        tpLittleTextFont.text=@"Have you ever challenged yourself to be healthier? Simply complete any 10 training programmes consecutively in 10 weeks and you will be rewarded a trophy and a coupon!You have to fulfill the corresponding requirements of each training programme so as to complete them successfully.Once you have completed a training programme, you have to start another one within 24 hours, otherwise it will not be counted as a consecutive record.";          gamerulesTextFont.text=@"How to Play";        cwLittleTextFont.text=@"Walk towards a better life! Select your favourite plant and make it flower! There are six stages for each plant. You only need to walk 30 minutes and 80 steps per minute to provide adequate nutrients. The plant can only move up one stage a day.You have to provide nutrients at least once a week. Otherwise, your plant will regress to the previous stage.";    }    else    {          walkforHealthTextHeanFont.text=@"健康步行";        tpGamerulesTextFont.text=@"如何參加";        tpLittleTextFont.text=@"你有否曾經因為想更健康，而挑戰自己？ 現在，你只需要連續10個星期完成任何10次步行計劃，便可得到一個獎盃及優惠券！你須要滿足每個步行計劃的個別要求，繼而成功把它們完成。當你成功完成一個步行計劃後，你須要在24小時內開始另一個。否則，將不會被視為連續記錄。";          gamerulesTextFont.text=@"如何參加";        cwLittleTextFont.text=@"步出更美好人生！選擇一盆你喜愛的植物，並培植它開出花朵！每棵植物均有6個階段，你只須要以每分鐘80步的步速，步行30分鐘就能為它提供成長所需的足夠營養。植物每天只會成長一次。你每星期至少要為它提供一次營養。否則，你的植物將退化至前一個階段。";    }                if (self.toTPorCW==1)    {        //TP        tpTryNowBackGuandView.hidden=NO;        cwTryNowBackGuandView.hidden=YES;                    BOOL isTryNowTP=[SyncGame isShowTrophyTryNow];               if (isTryNowTP)        {            tryNowTPLabelTextFont.hidden=YES;            rewardNumber.hidden=NO;            percentTextFont.hidden=NO;           NSString *strNumber=[self.dicTP objectForKey:@"progress"];            int theNumbe=[strNumber intValue];            int theNumberOftheTrophy=theNumbe*10;            NSString *sum=[[NSString alloc] initWithFormat:@"%d",theNumberOftheTrophy];            rewardNumber.text=sum;            if (theNumberOftheTrophy==0) {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr0];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=0&&theNumberOftheTrophy<10)            {                 theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr0];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=10&&theNumberOftheTrophy<20)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr1];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=20&&theNumberOftheTrophy<30)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr2];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=30&&theNumberOftheTrophy<40)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr3];                rewardpicture.image=theTrophyImage;            }                        else if (theNumberOftheTrophy>=40&&theNumberOftheTrophy<50)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr4];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=50&&theNumberOftheTrophy<60)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr5];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=60&&theNumberOftheTrophy<70)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr6];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=70&&theNumberOftheTrophy<80)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr7];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=80&&theNumberOftheTrophy<90)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr8];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy>=90&&theNumberOftheTrophy<100)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr9];                rewardpicture.image=theTrophyImage;            }            else if (theNumberOftheTrophy==100)            {                theTrophyImage=[[UIImage alloc] initWithContentsOfFile:trophyImageStr10];                rewardpicture.image=theTrophyImage;            }                                }        else        {            tryNowTPLabelTextFont.hidden=NO;            rewardNumber.hidden=YES;            percentTextFont.hidden=YES;                                                        }                                                                                    }    else    {        //CW        tpTryNowBackGuandView.hidden=YES;        cwTryNowBackGuandView.hidden=NO;                BOOL isTryNowCW=[SyncGame isShowPlantTryNow];        if (isTryNowCW)        {                    tryNowCWLabelTextFont.hidden=YES;            bignumber.hidden=NO;            smorenumber.hidden=NO;            plantName.text=[self.dicCW objectForKey:@"plantName"];            NSString * Treestr=[self.dicCW objectForKey:@"plantType"];             bignumber.text=[self.dicCW objectForKey:@"progress"];                        if ([bignumber.text isEqualToString:@"0"])            {                            plantName.hidden=YES;                plantremarksTextFont.hidden=YES;                            }            else            {                                plantName.hidden=NO;                plantremarksTextFont.hidden=NO;                            }            NSLog(@"self.dicCW==%@",self.dicCW);            NSLog(@"TREEStr=%@",Treestr);            if ([Treestr isEqualToString:@"T"]) {                if ([strTempTemp isEqualToString:@"Done"]) {                    plantremarksTextFont.text=@"Tomato tree";                }                else                {                    plantremarksTextFont.text=@"蕃茄樹";                 }                NSLog(@"__________yes");                int theNumberOftheTrophy=[bignumber.text intValue];                if (theNumberOftheTrophy==0) {                    theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr1];                    plantpicture.image=theTrophyImage;                }                else if (theNumberOftheTrophy==1)                {                    theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr2];                    plantpicture.image=theTrophyImage;                }                else if (theNumberOftheTrophy==2)                {                    theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr3];                    plantpicture.image=theTrophyImage;                }                else if (theNumberOftheTrophy==3)                {                    theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr4];                    plantpicture.image=theTrophyImage;                }                else if (theNumberOftheTrophy==4)                {                    theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr5];                    plantpicture.image=theTrophyImage;                }                else if (theNumberOftheTrophy==5)                {                    theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr6];                    plantpicture.image=theTrophyImage;                }                else if (theNumberOftheTrophy==6)                {                    theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr7];                    plantpicture.image=theTrophyImage;                }                else if (theNumberOftheTrophy==7)                {                    theTrophyImage=[[UIImage alloc] initWithContentsOfFile:tomatoTreeImageStr7];                    plantpicture.image=theTrophyImage;                }                                                                                            }           else if ([Treestr isEqualToString:@"L"]) {               if ([strTempTemp isEqualToString:@"Done"]) {                   plantremarksTextFont.text=@"Lemon tree";               }               else               {                   plantremarksTextFont.text=@"檸檬樹";                                  }               int theNumberOftheTrophy=[bignumber.text intValue];               if (theNumberOftheTrophy==0) {                   theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr1];                   plantpicture.image=theTrophyImage;               }               else if (theNumberOftheTrophy==1)               {                   theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr2];                   plantpicture.image=theTrophyImage;               }               else if (theNumberOftheTrophy==2)               {                   theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr3];                   plantpicture.image=theTrophyImage;               }               else if (theNumberOftheTrophy==3)               {                   theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr4];                   plantpicture.image=theTrophyImage;               }               else if (theNumberOftheTrophy==4)               {                   theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr5];                   plantpicture.image=theTrophyImage;               }               else if (theNumberOftheTrophy==5)               {                   theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr6];                   plantpicture.image=theTrophyImage;               }               else if (theNumberOftheTrophy==6)               {                   theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr7];                   plantpicture.image=theTrophyImage;               }               else if (theNumberOftheTrophy==7)               {                   theTrophyImage=[[UIImage alloc] initWithContentsOfFile:lemonTreeImageStr0];                   plantpicture.image=theTrophyImage;               }                                                                                       }          else  if ([Treestr isEqualToString:@"O"])          {              if ([strTempTemp isEqualToString:@"Done"]) {                  plantremarksTextFont.text=@"Orange tree";              }              else              {                  plantremarksTextFont.text=@"橙樹";                                }                            int theNumberOftheTrophy=[bignumber.text intValue];              if (theNumberOftheTrophy==0) {                  theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr1];                  plantpicture.image=theTrophyImage;              }              else if (theNumberOftheTrophy==1)              {                  theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr2];                  plantpicture.image=theTrophyImage;              }              else if (theNumberOftheTrophy==2)              {                  theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr3];                  plantpicture.image=theTrophyImage;              }              else if (theNumberOftheTrophy==3)              {                  theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr4];                  plantpicture.image=theTrophyImage;              }              else if (theNumberOftheTrophy==4)              {                  theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr5];                  plantpicture.image=theTrophyImage;              }              else if (theNumberOftheTrophy==5)              {                  theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr6];                  plantpicture.image=theTrophyImage;              }              else if (theNumberOftheTrophy==6)              {                  theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr7];                  plantpicture.image=theTrophyImage;              }              else if (theNumberOftheTrophy==7)              {                  theTrophyImage=[[UIImage alloc] initWithContentsOfFile:orangeTreeImageStr0];                  plantpicture.image=theTrophyImage;              }                                                                    }           else           {               theTrophyImage=[[UIImage alloc] initWithContentsOfFile:      treeImageStr];               plantpicture.image=theTrophyImage;           }                                            }        else        {            NSLog(@"I can Go to Here!");            plantName.hidden=YES;            plantremarksTextFont.hidden=YES;            tryNowCWLabelTextFont.hidden=NO;            bignumber.hidden=YES;            smorenumber.hidden=YES;                                            }                                                                                                            }                    // Do any additional setup after loading the view from its nib.}-(IBAction)tobeDoneWithCW:(id)sender{        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL)    {        NSLog(@"is atcion");              LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];            [historyView setType:@"walk"];            [self.navigationController pushViewController:historyView animated:YES ];                       }    else    {           NSLog(@"is not atcion");        [SyncGame updatePlantTryNow];        PedometerViewController *ped=[[PedometerViewController alloc]initWithNibName:@"PedometerViewController" bundle:nil];        [ped setPaceSetValue:paceSetValue];        [ped setTargetSetValue:targetSetValue];        [self.navigationController pushViewController:ped animated:YES];            }}-(IBAction)tobeDoneWithTP:(id)sender{    NSLog(@"[GlobalVariables shareInstance].session_id=%@",[GlobalVariables shareInstance].session_id);       NSLog(@"[GlobalVariables shareInstance].login_id=%@",[GlobalVariables shareInstance].login_id);    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {        NSLog(@"is atcion");                LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];        [historyView setType:@"walk"];        [self.navigationController pushViewController:historyView animated:YES ];            }    else    {        [SyncGame updateTrophyTryNow];        TrainingRecord *record=[DBHelper getLatestTrainRecord];                NSLog(@"status...........%d",[record getStatus]);        NSLog(@"level...........%ld",(long)[record getLevel]);        NSLog(@"id...........%@",record.trainid);        NSLog(@"starttime...........%ld",[record getStarttime]);        NSLog(@"formatStarttime...........%@",[[NSDate alloc] initWithTimeIntervalSince1970:[record getStarttime]]);                if (record!=nil) {                        NSDate *startDate=[[NSDate alloc] initWithTimeIntervalSince1970:[record getStarttime]];            NSCalendar *calendar = [NSCalendar currentCalendar];            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;                                    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:startDate];                        NSInteger year=dateComponent.year;            NSInteger month=dateComponent.month;            NSInteger day=dateComponent.day;                        //        NSLog(@"year...........%d",year);            //        NSLog(@"month...........%d",month);            //        NSLog(@"day...........%d",day);                        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];                        NSDate *recordStart = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00",(long)year,(long)month,(long)day]];                                    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([recordStart timeIntervalSinceReferenceDate] + 6*24*3600)];            dateComponent = [calendar components:unitFlags fromDate:newDate];            year=dateComponent.year;            month=dateComponent.month;            day=dateComponent.day;            NSLog(@"year...........%ld",(long)year);            NSLog(@"month...........%ld",(long)month);            NSLog(@"day...........%ld",(long)day);            NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)day]];                                                                        //        NSDate *recordEnd = [dateFormat dateFromString:[NSString stringWithFormat:@"%d-%d-%d 23:59:59",year,month,day+6]];                        //NSLog(@"check the recordEndtime : %ld-%ld-%ld",(long)year,(long)month,day+6);            NSLog(@"[record getStatus] is %d",[record getStatus]);            NSLog(@"[NSDate date] timeIntervalSince1970] is %f",[[NSDate date] timeIntervalSince1970]);            NSLog(@"[recordEnd timeIntervalSince1970] is %f",[recordEnd timeIntervalSince1970]);                                                if ([record getStatus]==2&&([[NSDate date] timeIntervalSince1970]<[recordEnd timeIntervalSince1970])) {                                CurrentWeeklyProgressViewController*current=[[CurrentWeeklyProgressViewController alloc]initWithNibName:@"CurrentWeeklyProgressViewController" bundle:nil];                [self.navigationController pushViewController:current animated:YES];                                            }else{                                StartingFromBronzeViewController *starting=[[StartingFromBronzeViewController alloc]initWithNibName:@"StartingFromBronzeViewController" bundle:nil];                [self.navigationController pushViewController:starting animated:YES];            }                                }else{                        StartingFromBronzeViewController *starting=[[StartingFromBronzeViewController alloc]initWithNibName:@"StartingFromBronzeViewController" bundle:nil];            [self.navigationController pushViewController:starting animated:YES];        }          }  }- (void)didReceiveMemoryWarning{    [super didReceiveMemoryWarning];    // Dispose of any resources that can be recreated.}@end