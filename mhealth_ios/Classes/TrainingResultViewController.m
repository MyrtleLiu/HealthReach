//
//  TrainingResultViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-8-27.
//
//

#import "TrainingResultViewController.h"
#import "Utility.h"
#import "NSString+Utils.h"
#import "WalkForHealthViewController.h"
#import "DBHelper.h"
#import "SyncWalking.h"
#import "SyncGame.h"
#import "UIAlertController+Orientation.h"


@interface TrainingResultViewController (){
    
    BOOL isReturnRoute;
}

@end

@implementation TrainingResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (iPad) {
        
        
        self = [super initWithNibName:@"TrainingResultViewController3.5" bundle:nibBundleOrNil];
        
    }
    else{
        self =  [super initWithNibName:@"TrainingResultViewController" bundle:nibBundleOrNil];
    }

    
    
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animatedr
{
    scrollView.bounces=NO;
    NSInteger level=_level;
    
    
    
    
    if (level==1) {
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_bronze_title"]];
        [self.levelText setText:[Utility getStringByKey:@"b_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_bronze"];
    }else if(level==2){
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_silver_title"]];
        [self.levelText setText:[Utility getStringByKey:@"s_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_silver"];
        
    }else if(level==3){
        [self.levelTitle setText:[Utility getStringByKey:@"w_gold_title"]];
        [self.levelText setText:[Utility getStringByKey:@"g_text"]];
        
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_gold"];
        
    }else if(level==4){
        
        [self.levelTitle setText:[Utility getStringByKey:@"w_diamond_title"]];
        [self.levelText setText:[Utility getStringByKey:@"d_text"]];
        
        self.levelImg.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
        self.levelBGImg.image=[UIImage imageNamed:@"07_tr_header_diamond"];

    }
    
   [self.date setFont:[UIFont fontWithName:font55 size:16]];
//   self.date.text=[NSString formatTimeAgo:_record.getRecordtime];
    
    
    NSDate* date=[NSDate dateWithTimeIntervalSince1970:_record.getRecordtime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
        [dateFormatter setDateFormat:@"yyyy年M月dd日"];
    } else {
        [dateFormatter setDateFormat:@"dd MMM yyyy"];
    }
    self.date.text = [dateFormatter stringFromDate:date];

    
    
    
    

    NSNumber *longNumber1 = [NSNumber numberWithLong:[_record getPersistime]/60];
    NSString *longStr1 = [longNumber1 stringValue];
    NSNumber *longNumber2 = [NSNumber numberWithLong:[_record getPersistime]%60];
    NSString *longStr2 = [longNumber2 stringValue];
    NSString *tmp=[NSString stringWithFormat:@"%@'%@''",longStr1,longStr2];
   self.durationLabel.text=tmp;

    double distance=[_record.distance doubleValue]/1000;
    
    self.distanceLabel.text=[NSString stringWithFormat:@"%.3f",distance];
    
    float paceF=[_record.steps floatValue]/(((float)[_record getPersistime])/60.0f);
    
    int pace=paceF/1;
    
    //self.distanceLabel.text=_record.distance;
    self.stepsLabel.text=_record.steps;
    self.paceLabel.text=[NSString stringWithFormat:@"%d",pace];//_record.pace;
    self.calsLabel.text=_record.calsburnt;

    double disTancel=[self.distanceLabel.text doubleValue];
    double speedDouble=disTancel/[_record getPersistime]*60*60.0;
    if ([_record getPersistime]>60) {
   
        if (speedDouble>0)
        {
            NSString * speed=[[NSString alloc]initWithFormat:@"%.03f",speedDouble];
            self.speedLabel.text=speed;
        }
        else
        {
            self.speedLabel.text=@"0";
        }
        
        
        
    }
    else
    {
        if (speedDouble>0)
        {
            NSString * speed=[[NSString alloc]initWithFormat:@"%.03f",speedDouble];
            self.speedLabel.text=speed;
        }
        else
        {
            self.speedLabel.text=@"0";
        }
        
    }

    
    
    
    
    
    
        _distanceLabel.font=[UIFont fontWithName:font57 size:38];
        _stepsLabel.font=[UIFont fontWithName:font57 size:38];
        _calsLabel.font=[UIFont fontWithName:font57 size:38];
        _paceLabel.font=[UIFont fontWithName:font57 size:38];
        _durationLabel.font=[UIFont fontWithName:font57 size:38];
        _speedLabel.font=[UIFont fontWithName:font57 size:38];
        
        _distanceLabelUnit.font=[UIFont fontWithName:font77 size:12];
        _stepsLabelUnit.font=[UIFont fontWithName:font77 size:12];
        _calsLabelUnit.font=[UIFont fontWithName:font77 size:12];
        _paceLabelUnit.font=[UIFont fontWithName:font77 size:12];
        _speedLabelUnit.font=[UIFont fontWithName:font77 size:12];
    _speedLabelUnit2.font=[UIFont fontWithName:font77 size:12];
        _distanceLabelText.font=[UIFont fontWithName:font67 size:20];
        _stepsLabelText.font=[UIFont fontWithName:font67 size:20];
        _calsLabelText.font=[UIFont fontWithName:font67 size:20];
        _paceLabelText.font=[UIFont fontWithName:font67 size:20];
        _durationLabelText.font=[UIFont fontWithName:font67 size:20];
        _speedLabelText.font=[UIFont fontWithName:font67 size:20];
        _okBtn.titleLabel.font=[UIFont fontWithName:font65 size:17];
        
        _titleText.font=[UIFont fontWithName:font65 size:18];
        


    
    [_titleText setText:[Utility getStringByKey:@"w_train_title"]];
    [_distanceLabelText setText:[Utility getStringByKey:@"distance_label"]];
    [_stepsLabelText setText:[Utility getStringByKey:@"step_label"]];
    [_calsLabelText setText:[Utility getStringByKey:@"cal_label"]];
    [_paceLabelText setText:[Utility getStringByKey:@"pace_label"]];
    [_durationLabelText setText:[Utility getStringByKey:@"duration_label"]];
    
    [_distanceLabelUnit setText:[Utility getStringByKey:@"km_unit"]];
    [_stepsLabelUnit setText:[Utility getStringByKey:@"step_unit"]];
    [_calsLabelUnit setText:[Utility getStringByKey:@"cal_unit"]];
    [_paceLabelUnit setText:[Utility getStringByKey:@"pace_unit"]];
    [_speedLabelUnit setText:[Utility getStringByKey:@"km"]];
 [_speedLabelUnit2 setText:[Utility getStringByKey:@"/hour"]];
        [_speedLabelText setText:[Utility getStringByKey:@"speed"]];
    [_okBtn setTitle:[Utility getStringByKey:@"ok"] forState: normal];
    _okBtn.titleLabel.textAlignment=NSTextAlignmentCenter;

    
    
    
    if([_lastActivity isEqualToString:@"Pedometer"]){
        [_upload_succ setText:[Utility getStringByKey:@"upload_succ"]];
        _upload_succ.hidden=false;
    }
    
    
    if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
        
        [_track_route_Btn setImage:[UIImage imageNamed:@"07_wa_btn_map_zh.png"] forState:UIControlStateNormal];
    }else{
        [_track_route_Btn setImage:[UIImage imageNamed:@"07_wa_btn_map.png"] forState:UIControlStateNormal];
    }
    
    scrollView.bounces=NO;
    
//    
//       self.speedLabelUnit.frame=CGRectMake(262, 10, 38, 44);
//     self.speedLabelUnit.textAlignment=NSTextAlignmentCenter;
//    NSString *trophyImageStr0=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_00" ofType:@"png"];
//    
//    NSString *trophyImageStr1=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_01" ofType:@"png"];
//    NSString *trophyImageStr2=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_02" ofType:@"png"];
//    NSString *trophyImageStr3=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_03" ofType:@"png"];
//    NSString *trophyImageStr4=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_04" ofType:@"png"];
//    NSString *trophyImageStr5=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_05" ofType:@"png"];
//    NSString *trophyImageStr6=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_06" ofType:@"png"];
//    NSString *trophyImageStr7=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_07" ofType:@"png"];
//    NSString *trophyImageStr8=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_08" ofType:@"png"];
//    NSString *trophyImageStr9=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_09" ofType:@"png"];
    NSString *trophyImageStr10=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_10" ofType:@"png"];
    
    
    strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"Done"]];
    
    NSString * strSure1=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_btn_share_2" ofType:@"png"];
    
    NSString * strSure2=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_btn_share_ch_2" ofType:@"png"];
    if ([strTempTemp isEqualToString:@"Done"]) {
        UIImage*sureImage=[[UIImage alloc] initWithContentsOfFile:strSure1];
        [shareButton setImage:sureImage forState:UIControlStateNormal];
    }
    else
    {
        UIImage*sureImage=[[UIImage alloc] initWithContentsOfFile:strSure2];
        [shareButton setImage:sureImage forState:UIControlStateNormal];
    }

    congratulationsLabelTextFont.text=[Utility getStringByKey:@"Congratulations!"];
    NSLog(@"Self.isUpDateNow ==%@",self.isUPDateNOW);
    if ([self.isUPDateNOW isEqualToString:@"no"]) {
        //
        congratulationsView.hidden=YES;
        self.theMapView.hidden=YES;
        self.trackBtnView.hidden=NO;
        self.dateView.hidden=NO;
        self.statusView.hidden=NO;
        
        imageView.hidden=NO;
        self.statusView.frame=CGRectMake(0, 65, 320, 278+56);
        imageView.frame=CGRectMake(0, 65+278+56, 320, 10);
        self.upload_succ.frame=CGRectMake(20, 65+278+10+56, 280, 21);
        self.okBtn.frame=CGRectMake(101, 382+56, 118, 35);
        shareButton.hidden=YES;
        scrollView.contentSize=CGSizeMake(320, 382+35+20+56);
        
    }
    else
    {
        int upDateDatePress=[self.isUPDateNOW intValue];
        if (upDateDatePress<5)
        {
            //
            
//            
//            if ([strTempTemp isEqualToString:@"Done"])
//            {
//
//            NSString * str=[[NSString alloc]initWithFormat:@"Your progress on getting a trophy  has increased to %d%%. Remember to start the next programme to work towards a trophy.",upDateDatePress*10];
//                  congratulationstitleTextFont.text=str;
//            }
//            else
//            {
//                NSString * str=[[NSString alloc]initWithFormat:@"獎盃的獲取進度已達%d%%。請謹記開始新一輪的步行計劃，以向著獎盃進發。",upDateDatePress*10];
//                congratulationstitleTextFont.text=str;
//            }
//            
          
            if (upDateDatePress==1) {
                //
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"Congratulations on getting your 1st medal. Don’t slack and keep up with it"];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"恭喜你獲取⾸面獎牌!唔好鬆懈,繼續努⼒!"];
                    congratulationstitleTextFont.text=str;
                }

                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                 

                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
                
                
            }
            else   if (upDateDatePress==0) {
                //
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"Your progress on getting a trophy  has increased to %d%%. Remember to start the next programme to work towards a trophy.",upDateDatePress*10];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"獎盃的獲取進度已達%d%%。請謹記開始新一輪的步行計劃，以向著獎盃進發。",upDateDatePress*10];
                    congratulationstitleTextFont.text=str;
                }
                
                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                    
                    
                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
                
            }
            else   if (upDateDatePress==2) {
                //
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"Well done for completing another programme! Keep it up."];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"讚！你又完成咗一個步行計劃，繼續努力！"];
                    congratulationstitleTextFont.text=str;
                }
                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                    
                    
                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
            }
            else   if (upDateDatePress==3) {
                //
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"3rd medal awarded! Give yourself a pat on your back for your achievement."];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"你已獲取第3面獎牌，記得讚吓自己！"];
                    congratulationstitleTextFont.text=str;
                }
                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                    
                    
                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
                
            }                       
            else   if (upDateDatePress==4) {
                //
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"Complete one more training programme and you are halfway to getting your trophy."];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"再⾏一個「步⾏計劃」,你就會完成一半獎盃嘅路程。"];
                    congratulationstitleTextFont.text=str;
                }

                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                    
                    
                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
                
            }
        }
        else if (upDateDatePress<10)
        {
            
//            if ([strTempTemp isEqualToString:@"Done"])
//            {
//                NSString * str=[[NSString alloc]initWithFormat: @"Keep it up your progress on getting a trophy has increased to %d%%.",upDateDatePress*10];
//                congratulationstitleTextFont.text=str;
//         
//            }
//            else
//            {
//                NSString * str=[[NSString alloc]initWithFormat: @"獎盃的獲取進度已達%d%%。繼續努力！",upDateDatePress*10];
//                congratulationstitleTextFont.text=str;
//            }
//            
           
           if (upDateDatePress==5) {
                //
               if ([strTempTemp isEqualToString:@"Done"])
               {
                   
                   NSString * str=[[NSString alloc]initWithFormat:@"Give me five! You’ve just earned your 5th medal."];
                   congratulationstitleTextFont.text=str;
               }
               else
               {
                   NSString * str=[[NSString alloc]initWithFormat:@"畀個5我！你剛獲取你嘅第5面獎牌。"];
                   congratulationstitleTextFont.text=str;
               }
               if (level==1) {
                   
                   trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                   
               }else if(level==2){
                   
                   
                   trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                   
                   
               }else if(level==3){
                   
                   trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                   
               }else if(level==4){
                   
                   trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                   
               }
               
            }
            else   if (upDateDatePress==6) {
                //
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"Don’t give up now as you’ve only got four more programmes to complete!"];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"唔好放棄,只係剩4個「步⾏計劃」就完成!"];
                    congratulationstitleTextFont.text=str;
                }
                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                    
                    
                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
                
            }
            else   if (upDateDatePress==7) {
                //
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"Feeling great and healthy with your 7th medal? Get even fitter after completing 10 programmes and win a trophy."];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"你已獲取第7面獎牌，感覺良好又健康？堅持完成10個步行計劃及獲取獎盃，感覺一定會更好！"];
                    congratulationstitleTextFont.text=str;
                }
                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                    
                    
                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
                
            }
            else   if (upDateDatePress==8) {
                //
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"Excellent! You are only 2 medals to getting the trophy."];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"激讚！攞多2面獎牌就得到獎盃！"];
                    congratulationstitleTextFont.text=str;
                }
                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                    
                    
                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
                
            }
            else
            {
                if ([strTempTemp isEqualToString:@"Done"])
                {
                    
                    NSString * str=[[NSString alloc]initWithFormat:@"The trophy is in your sight! Only one more medal to go."];
                    congratulationstitleTextFont.text=str;
                }
                else
                {
                    NSString * str=[[NSString alloc]initWithFormat:@"獎盃就在眼前，只要再獲取多一面獎牌就可以成功！"];
                    congratulationstitleTextFont.text=str;
                }
          
                if (level==1) {
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_bronze_hr"];
                    
                }else if(level==2){
                    
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_silver_hr"];
                    
                    
                }else if(level==3){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_gold_hr"];
                    
                }else if(level==4){
                    
                    trophyImageView.image=[UIImage imageNamed:@"07_tr_award_diamond_hr"];
                    
                }
                
             
            }
            
        }
    
   
        else
        {
            UIImage *image=[[UIImage alloc]initWithContentsOfFile:trophyImageStr10];
            trophyImageView.image=image;
            if ([strTempTemp isEqualToString:@"Done"])
            {
                
                //  congratulationstitleTextFont.text=@"Congratulations, you have accomplished 10 consecutive training programmes and have earned a trophy. You will receive an email with details to get the coupon.";
                congratulationstitleTextFont.text=@"You’ve won a trophy with a HK$100 health products coupon, and more importantly built a healthy walking habit.\nAn email with details on how to get the coupon will be sent to you. Share your achievement with your friends now!";
            }
            else
            {
//                congratulationstitleTextFont.text=@"恭喜你！你已連續完成10次步行計劃，並成功獲取獎盃。你將會收到電郵，通知你有關優惠券領取的詳情。";
                congratulationstitleTextFont.text=@"恭喜！你已成功得到獎盃及HK$100健康產品優惠券，不過更重要嘅係你已建立健康步行習慣。\n我哋將以電郵通知你優惠券嘅領取詳情。請立即和朋友分享你努力嘅成果！";
            }
        }
        
        //NSLog(@"text....%@",congratulationstitleTextFont.text);
        
        [self sizeLabel:congratulationstitleTextFont];
        
        NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(takeTheTPTime) object:nil];
        [myThread start];
        NSLog(@"******************************");
        congratulationsView.hidden=NO;
        self.theMapView.hidden=YES;
        self.trackBtnView.hidden=NO;
        self.dateView.hidden=NO;
        self.statusView.hidden=NO;
        
        imageView.hidden=NO;
        congratulationsView.frame=CGRectMake(0, 65, 320, 226);
        self.statusView.frame=CGRectMake(0, 65+226, 320, 278+56);
        imageView.frame=CGRectMake(0, 65+226+278+56, 320, 10);
        self.upload_succ.frame=CGRectMake(20, 65+226+278+10+56, 280, 21);
        
        if ([self.isUPDateNOW intValue]==10) {
              self.okBtn.frame=CGRectMake(180, 382+226+56, 118, 35);
            shareButton.hidden=NO;
            shareButton.frame=CGRectMake(20, 382+226+56, 118, 35);
            
        }
        else
        {
            self.okBtn.frame=CGRectMake(101, 382+226+56, 118, 35);
            shareButton.hidden=YES;
        }
        
        scrollView.contentSize=CGSizeMake(320, 382+226+35+20+56);
    }

    
    self.mapView.camera =[GMSCameraPosition cameraWithLatitude:22.30 longitude:114.15 zoom:9];
 
    
}


- (void)updateRecord
{
    
    _record= [SyncWalking getWalkingRecordDetail:_record.recordid];
    
    [self refreshMap];
    
    //[[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncFinish" object:nil];
    
}

- (void)refreshMap
{
    [_record setPlannedRoutePoints];
    [_record setTrackPoints];
    if (self.record!=Nil&&[self.record.plannedRoutePoints count]>0) {
        
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *returnRoute=[userDefaults objectForKey:@"isReturnRoute"];
        
        
        if ([returnRoute isEqualToString:@"1"]) {
            
            
            isReturnRoute=true;
            
        }else{
            
            
            isReturnRoute=false;
            
        }
        
        
        
        [self updateRoute];
    }
    
    NSLog(@"steps here:%@",_record.steps);
    if (self.record!=nil&&[self.record.trackPoints count]>0) {
        
        self.polyline = [[GMSPolyline alloc] init];
        self.path = [GMSMutablePath path];
        
        [self updateTrack];
    }
    
    
}

    


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in notifications )
    {
        
        @try {
            
            if([[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp1"] ||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp2"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp3"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp4"])
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    }
    // Do any additional setup after loading the view from its nib.
    
    if(![_lastActivity isEqualToString:@"Pedometer"]){
        
        //_record= [SyncWalking getWalkingRecordDetail:_record.recordid];
        
        NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(updateRecord) object:nil];
        [syncThread start];
    }
    
    
    
    [_record setPlannedRoutePoints];
    [_record setTrackPoints];

    
    NSLog(@"test hre:%@",_record.gps);
    
    
    if (_record!=Nil&&[_record.plannedRoutePoints count]>0) {
        
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *returnRoute=[userDefaults objectForKey:@"isReturnRoute"];
        
        
        if ([returnRoute isEqualToString:@"1"]) {
            
            
            isReturnRoute=true;
            
        }else{
            
            
            isReturnRoute=false;
            
        }
        
        
        
        [self updateRoute];
    }
    
    if (_record!=nil&&[_record.trackPoints count]>0) {
        
        self.polyline = [[GMSPolyline alloc] init];
        self.path = [GMSMutablePath path];
        
        [self updateTrack];
    }
    

   
    
    
}
-(IBAction)toshareFaceBook:(id)sender
{
    
    
    NSString *contStr=[Constants getAPIBase1];
    
    
    NSString* keyStr=[self.theShareRoad  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *lang=@"en";
    
    if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
        
        lang=@"zh";
    }
    
    NSString *urlStr=[[NSString alloc]initWithFormat:@"%@wmc/jsp/mhealth/fb_share.jsp?key=%@&lang=%@",contStr,keyStr,lang];
    
    //fb share
    // NSString *texttoshare = @"http://www.google.com"; //this is your text string to share
    //UIImage *imagetoshare = _img; //this is your image to share
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    NSArray *activityItems = @[url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    //activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypeMessage];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
    
}


-(IBAction)showMapView:(id)sender{
    
    self.trackBtnView.hidden=true;
    self.statusView.hidden=true;
    self.dateView.hidden=true;
    self.theMapView.hidden=false;
    congratulationsView.hidden=YES;
    
    imageView.frame=CGRectMake(0, 65+278, 320, 10);
    self.upload_succ.frame=CGRectMake(20, 65+278+10, 280, 21);
    if ([self.isUPDateNOW intValue]==10)
    {
         self.okBtn.frame=CGRectMake(180, 382, 118, 35);
        shareButton.hidden=NO;
        shareButton.frame=CGRectMake(20, 382, 118, 35);
    }
    else
    {
        self.okBtn.frame=CGRectMake(101, 382, 118, 35);
        shareButton.hidden=YES;
    }
    
    scrollView.contentSize=CGSizeMake(320, 382+35+20);
}
-(IBAction)showStatusView:(id)sender{
    
    
    if ([self.isUPDateNOW isEqualToString:@"no"]) {
        //
        congratulationsView.hidden=YES;
        self.theMapView.hidden=YES;
        self.trackBtnView.hidden=NO;
        self.dateView.hidden=NO;
        self.statusView.hidden=NO;
        
        imageView.hidden=NO;
        self.statusView.frame=CGRectMake(0, 65, 320, 278+56);
        imageView.frame=CGRectMake(0, 65+278+56, 320, 10);
        self.upload_succ.frame=CGRectMake(20, 65+278+10+56, 280, 21);
        
        self.okBtn.frame=CGRectMake(101, 382+56, 118, 35);
        shareButton.hidden=YES;
        scrollView.contentSize=CGSizeMake(320, 382+35+20+56);
        
    }
    else
    {
       // int upDateDatePress=[self.isUPDateNOW intValue];

        congratulationsView.hidden=NO;
        self.theMapView.hidden=YES;
        self.trackBtnView.hidden=NO;
        self.dateView.hidden=NO;
        self.statusView.hidden=NO;
        
        imageView.hidden=NO;
        congratulationsView.frame=CGRectMake(0, 65, 320, 226);
        self.statusView.frame=CGRectMake(0, 65+226, 320, 278+56);
        imageView.frame=CGRectMake(0, 65+226+278+56, 320, 10);
        self.upload_succ.frame=CGRectMake(20, 65+226+278+10+56, 280, 21);
        if ([self.isUPDateNOW intValue]==10)
        {
             self.okBtn.frame=CGRectMake(180, 382+226+56, 118, 35);
            shareButton.hidden=NO;
            shareButton.frame=CGRectMake(20, 382+226+56, 118, 35);
        }
        else
        {
        self.okBtn.frame=CGRectMake(101, 382+226+56, 118, 35);
        shareButton.hidden=YES;
        }
        scrollView.contentSize=CGSizeMake(320, 382+226+35+20+56);
    }
    
    
    
 
    
    
}


-(IBAction)okBtnClick :(id)sender{
    if([_lastActivity isEqualToString:@"Pedometer"]){
        NSInteger index=[[self.navigationController viewControllers] indexOfObject:self];
        [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: index-2] animated:YES];
        
//        WalkForHealthViewController *wfhView = [[WalkForHealthViewController alloc] initWithNibName:@"WalkForHealthViewController" bundle:nil];
//        GameObject *gameOBjectCW= [DBHelper getPlantProgress];
//        
//        GameObject *gameOBjectTP=  [DBHelper getTrophyProgress];
//        NSLog(@"~~~~~~~~~~~~~~~~~~");
//        NSLog(@"cw.gameObject==%@",gameOBjectCW);
//        NSLog(@"cw.gametype==%@",gameOBjectCW.gameType);
//        NSLog(@"cw.plantType==%@",gameOBjectCW.plantType);
//        NSLog(@"cw.plantname==%@",gameOBjectCW.plantName);
//        NSLog(@"cw.progress==%@",gameOBjectCW.progress);
//        NSLog(@"cw.status==%@",gameOBjectCW.status);
//        NSLog(@"~~~~~~~~~~~~~~~~~~");
//        NSString * str1=gameOBjectCW.gameType;
//        if (str1==NULL) {
//            str1=@"";
//        }
//        
//        NSString *str2=gameOBjectCW.plantType;
//        if (str2==NULL) {
//            str2=@"";
//        }
//        NSString *str3=gameOBjectCW.plantName;
//        if (str3==NULL) {
//            str3=@"";
//        }
//        NSString*str4=gameOBjectCW.progress;
//        if (str4==NULL) {
//            str4=@"";
//        }
//        NSString *str5=gameOBjectCW.status;
//        if (str5==NULL) {
//            str5=@"";
//        }
//        NSLog(@"%@,%@,%@,%@,%@",str5,str4,str3,str2,str1);
//        self.dicCW=[NSDictionary dictionaryWithObjectsAndKeys:
//                    str1,@"gameType",
//                    str2,@"plantType",
//                    str3,@"plantName",
//                    str4,@"progress",
//                    str5,@"status",
//                    nil];
//        
//        NSLog(@"self.dicCW==%@",self.dicCW);
//        
//        NSLog(@"~~~~~~~~~~~~~~~~~~");
//        NSLog(@"tp.gameObject==%@",gameOBjectTP);
//        NSLog(@"tp.gametype==%@",gameOBjectTP.gameType);
//        NSLog(@"tp.plantType==%@",gameOBjectTP.plantType);
//        NSLog(@"tp.plantname==%@",gameOBjectTP.plantName);
//        NSLog(@"tp.progress==%@",gameOBjectTP.progress);
//        NSLog(@"tp.status==%@",gameOBjectTP.status);
//        NSLog(@"~~~~~~~~~~~~~~~~~~");
//        
//        NSString * tstr1=gameOBjectTP.gameType;
//        if (tstr1==NULL) {
//            tstr1=@"";
//        }
//        
//        NSString *tstr2=gameOBjectTP.plantType;
//        if (tstr2==NULL) {
//            tstr2=@"";
//        }
//        NSString *tstr3=gameOBjectTP.plantName;
//        if (tstr3==NULL) {
//            tstr3=@"";
//        }
//        NSString*tstr4=gameOBjectTP.progress;
//        if (tstr4==NULL) {
//            tstr4=@"";
//        }
//        NSString *tstr5=gameOBjectTP.status;
//        if (tstr5==NULL) {
//            tstr5=@"";
//        }
//        NSLog(@"%@,%@,%@,%@,%@",tstr5,tstr4,tstr3,tstr2,tstr1);
//        self.dicTP=[NSDictionary dictionaryWithObjectsAndKeys:
//                    tstr1,@"gameType",
//                    tstr2,@"plantType",
//                    tstr3,@"plantName",
//                    tstr4,@"progress",
//                    tstr5,@"status",
//                    nil];
//        NSLog(@"self.dicTP==%@",self.dicTP);
//        wfhView.dicCW=[[NSMutableDictionary alloc] initWithDictionary:self.dicCW];
//        wfhView.dicTP=[[NSMutableDictionary alloc] initWithDictionary:self.dicTP];
//        
//        [self.navigationController pushViewController:wfhView animated:YES ];
        
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateRoute{
    
    [self.mapView clear];
    
    if (isReturnRoute) {
        
        
        GMSPolyline *polyline = [[GMSPolyline alloc] init];
        GMSMutablePath *path = [GMSMutablePath path];
        
        
        for (int i=0; i<[_record.plannedRoutePoints count]; i++) {
            
            //CLLocation *location = [self.points objectAtIndex:i];
            
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[_record.plannedRoutePoints objectAtIndex:i]];
            
            
            
            [path addCoordinate:location.coordinate];
            
            GMSMarker *australiaMarker = [[GMSMarker alloc] init];
            //australiaMarker.title = @"title";
            australiaMarker.position = location.coordinate;
            australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
            
            
            australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt3"];
            
            if (i==0) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
            }
            
            
            australiaMarker.map = _mapView;
            
            if (i==[_record.plannedRoutePoints count]-1) {
                
                self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                                     zoom:15];
                
                NSLog(@"come to camera 2");
                
            }
            
            
        }
        
        polyline.path = path;
        //polyline.strokeColor = [UIColor colorWithRed:12/255.0 green:169/255.0 blue:97/255.0 alpha:1];
        polyline.strokeColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0/255.0 alpha:100];
        polyline.geodesic = YES;
        polyline.strokeWidth = 10;
        polyline.map = self.mapView;
        
        
        GMSPolyline *polyline_return = [[GMSPolyline alloc] init];
        GMSMutablePath *path_return = [GMSMutablePath path];
        
        
        for (int i=(int)[_record.plannedRoutePoints count]-1; i>-1; i--) {
            
            //CLLocation *location = [self.points objectAtIndex:i];
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[_record.plannedRoutePoints objectAtIndex:i]];
            
            
            
            [path_return addCoordinate:location.coordinate];
            
            GMSMarker *australiaMarker = [[GMSMarker alloc] init];
            //australiaMarker.title = @"title";
            australiaMarker.position = location.coordinate;
            australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
            
            
            australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt3"];
            
            if (i==0) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
            }
            
            
            australiaMarker.map = _mapView;
            
            
        }
        
        polyline_return.path = path;
        polyline_return.strokeColor = [UIColor colorWithRed:12/255.0 green:169/255.0 blue:97/255.0 alpha:1];
        
        polyline_return.geodesic = YES;
        polyline_return.strokeWidth = 3;
        polyline_return.map = self.mapView;
        
        
        
        
        
    }else{
        
        GMSPolyline *polyline = [[GMSPolyline alloc] init];
        GMSMutablePath *path = [GMSMutablePath path];
        
        for (int i=0; i<[_record.plannedRoutePoints count]; i++) {
            
            //CLLocation *location = [self.points objectAtIndex:i];
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[_record.plannedRoutePoints objectAtIndex:i]];
            
            
            
            [path addCoordinate:location.coordinate];
            
            GMSMarker *australiaMarker = [[GMSMarker alloc] init];
            //australiaMarker.title = @"title";
            australiaMarker.position = location.coordinate;
            australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
            
            
            australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt2"];
            
            if (i==0) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
            }
            
            if ([_record.plannedRoutePoints count]>1&&i==[_record.plannedRoutePoints count]-1) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_end"];
            }
            
            australiaMarker.map = _mapView;
            
            if (i==[_record.plannedRoutePoints count]-1) {
                
                self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                                     zoom:15];
                
                NSLog(@"come to camera 3");
                
            }
            
            
        }
        
        polyline.path = path;
        polyline.strokeColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0/255.0 alpha:100];
        polyline.geodesic = YES;
        polyline.strokeWidth = 10;
        polyline.map = self.mapView;
        
    }
    
}

-(void)updateTrack{
    
    
    [self.path removeAllCoordinates];
    
    for (int i=0; i<[_record.trackPoints count]; i++) {
        
        
        CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[_record.trackPoints objectAtIndex:i]];
        
        
        [self.path addCoordinate:location.coordinate];
        
        
        if (i==[_record.trackPoints count]-1) {
            
            self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                                 zoom:15];
            
            NSLog(@"come to camera 4");
            
            GMSMarker *startPoint=[[GMSMarker alloc] init];
            
            startPoint.position=location.coordinate;
            
            startPoint.icon=[UIImage imageNamed:@"hr_map_icon_end"];
            
            startPoint.appearAnimation = kGMSMarkerAnimationNone;
            
            startPoint.map=self.mapView;
            
        }

        if (i==0) {
            
            GMSMarker *startPoint=[[GMSMarker alloc] init];
            
            startPoint.position=location.coordinate;
            
            startPoint.icon=[UIImage imageNamed:@"hr_map_icon_start"];
            
            startPoint.appearAnimation = kGMSMarkerAnimationNone;
            
            startPoint.map=self.mapView;
        }
        
        
        
    }
    
    
    self.polyline.path = self.path;
    
    self.polyline.strokeColor = [UIColor redColor];
    
    self.polyline.geodesic = YES;
    
    self.polyline.strokeWidth = 10;
    
    self.polyline.map = self.mapView;
    
}
-(void)bownTheTP100
{
    
         NSLog(@"*********************************************************************************************************");
     self.recordTTTT=[DBHelper getLatestTrainRecord];
    long starttime=[self.recordTTTT getStarttime];
    
    NSMutableArray *dateLabels=[[NSMutableArray alloc] initWithCapacity:7];
    
    NSDate *startDate=[[NSDate alloc] initWithTimeIntervalSince1970:starttime];
    
//    if (self.historyDateLabels!=nil) {
//        
//        [self.historyDateLabels removeAllObjects];
//    }
//    
//    if (self.historyDurationLabels!=nil) {
//        
//        [self.historyDurationLabels removeAllObjects];
//    }
//    if (self.historyDistanceLabels!=nil) {
//        
//        [self.historyDistanceLabels removeAllObjects];
//    }
//    if (self.historyCalsLabels!=nil) {
//        
//        [self.historyCalsLabels removeAllObjects];
//    }
//    if (self.historyResultLabels!=nil) {
//        
//        [self.historyResultLabels removeAllObjects];
//    }
    
    
    
    //NSLog(@"%@........start date",startDate);
    
         int  lastResult=0;
    
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
        
     //   [self.historyDateLabels addObject:dateString];
        
        
        //        [self.historyDateLabels addObject:[NSString formatTimeddMMMyyyy:[tmp timeIntervalSince1970]]];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond;
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
            
            
            
            NSLog(@"cwResult:%@",cwResult.distance);
            
            
            
            
            
            if(i==0){
                temp_dis=[cwResult.distance doubleValue];
                temp_cals=[cwResult.calsburnt integerValue];
                tep_duration=[cwResult getPersistime];
                temp_result=[cwResult.result integerValue];
            }
            else{
                if(temp_result>=100){
                    temp_dis=[cwResult.distance doubleValue];
                    temp_cals=[cwResult.calsburnt integerValue];
                    tep_duration=[cwResult getPersistime];
                    temp_result=[cwResult.result integerValue];
                }
                else if(tep_duration<[cwResult getPersistime]){
                    temp_dis=[cwResult.distance doubleValue];
                    temp_cals=[cwResult.calsburnt integerValue];
                    tep_duration=[cwResult getPersistime];
                    temp_result=[cwResult.result integerValue];
                    
                }
            }
        }
        //distance=temp_dis;
        cals=temp_cals;
        duration=tep_duration;
        result=temp_result;
        
        if (result==100)
        {
            lastResult++;
        }
        distance=temp_dis/1000;
        
        //self.distanceLabel.text=[NSString stringWithFormat:@"%.3f",distance];
        
        
        
//        [self.historyDistanceLabels addObject:[NSString stringWithFormat:@"%.3f",distance]];
//        [self.historyCalsLabels addObject:[NSString stringWithFormat:@"%ld",(long)cals]];
//        [self.historyDurationLabels addObject:[NSString formatTimemmdd:duration]];
//        [self.historyResultLabels addObject:[NSString stringWithFormat:@"%ld",(long)result]];
//        
//        
//        
        
        
        
     //   [_historyListView reloadData];
        

    }
    if (lastResult==4)
    {
         long strLong=[[NSDate date] timeIntervalSince1970];
        long timeminSince=strLong-starttime;
        NSLog(@"timeMinSince==%ld",timeminSince);
        long  howday=timeminSince/86400;
        NSLog(@"howDay==%ld",howday);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
        NSLog(@"%@", strDate);
        
        NSString *strTemp=[[NSString alloc]initWithFormat:@"%@ 09:00:00",strDate];
        
        
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date2 = [dateFormatter2 dateFromString:strTemp];
        NSLog(@"%@", date2);
        
        switch (howday) {
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
                for (int i=1; i<3; i++)
                {
                    NSTimeInterval secondsPerDay7 = (24*60*60)*i;
                    NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
                    NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"tp1",@"title", nil];
                    NSString *name01;
                    if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                        
                        name01=@"獎牌就在眼前!只須多步行⼀次,就可完成「步⾏計劃」。";
                    }
                    else
                    {
                        name01=@"A medal is in your sight! Only one more walk to complete your Training Programme.";
                    }
                    [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
                }
                break;
                break;
            case 5:
                for (int i=1; i<3; i++)
                {
                    NSTimeInterval secondsPerDay7 = (24*60*60)*i;
                    NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
                    NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"tp1",@"title", nil];
                    NSString *name01;
                    if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                        
                        name01=@"獎牌就在眼前!只須多步行⼀次,就可完成「步⾏計劃」。";
                    }
                    else
                    {
                        name01=@"A medal is in your sight! Only one more walk to complete your Training Programme.";
                    }
                    [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
                }
                break;
                break;
            case 6:
                
                for (int i=1; i<2; i++)
                {
                    NSTimeInterval secondsPerDay7 = (24*60*60)*i;
                    NSDate *tomorrow7 = [date2 dateByAddingTimeInterval:secondsPerDay7];
                    NSDictionary *dic01=[[NSDictionary alloc]initWithObjectsAndKeys:@"tp1",@"title", nil];
                    NSString *name01;
                    if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
                        
                        name01=@"獎牌就在眼前!只須多步行⼀次,就可完成「步⾏計劃」。";
                    }
                    else
                    {
                        name01=@"A medal is in your sight! Only one more walk to complete your Training Programme.";
                    }
                    [self resetClock:tomorrow7 timeNAme:name01 userInfo:dic01];
                }
                break;
            case 7:
           
                

                break;
            default:
                break;
        }
        
        
        
    }
    
    
    
}
-(void)takeTheTPTime
{
        NSLog(@"************************************************************");
    
    NSLog(@"!!!!!@!@!#@$#@!#!@$34");
        int upDateDatePress=[self.isUPDateNOW intValue];
    
    NSLog(@"upDateDatePress=upDateDatePress=upDateDatePress=upDateDatePress==%d",upDateDatePress);
    
    [self bownTheTP100];
    
    
    if (upDateDatePress>0)
    {
        //摞左牌后30分钟
          NSDictionary*  dic0=[[NSDictionary alloc]initWithObjectsAndKeys: @"tp1",@"title",nil];
        NSDate *date30min=[NSDate dateWithTimeIntervalSinceNow:30*60];
        NSString *name1;
        NSLog(@"upDateDatePress==%d",upDateDatePress);
        if (upDateDatePress==1)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@"Congratulations on getting your 1st medal. Remember to start a new programme within the next 2 days.";
            }
            else
            {
                name1=@"恭喜你獲得⾸面獎牌!繼續努力,並緊記在未來2天內開始新嘅「步⾏計劃」。";
            }
        }
        else if(upDateDatePress==2)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@"Well done for completing another programme! Keep it up. Remember to start a new programme within the next 2 days.";
            }
            else
            {
                name1=@"讚!你又完成咗⼀個步⾏計劃, 繼續努力,並緊記在未來2天內開始新嘅「步行計劃」。";
            }
        }
        else if(upDateDatePress==3)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@"3rd medal awarded! Don’t forget to start a new programme within the next 2 days.";
            }
            else
            {
                name1=@"你已獲取第3面獎牌,記得讚吓自己,並緊記在未來2天內開始新嘅「步⾏計劃」。";
            }
        }
        else if(upDateDatePress==4)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@"Complete one more training programme and you are halfway to getting your trophy with a HK$100 health products coupon.";
            }
            else
            {
                name1=@"再完成多一個步行計劃,你就會完成一半得到獎盃及HK$100健品產品優惠券嘅路程。";
            }
        }
        else if(upDateDatePress==5)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@"Give me five! You’ve just gotten your 5th medal. Remember to start a new programme within the next 2 days.";
            }
            else
            {
                name1=@"畀個5我!你剛獲取你嘅第5⾯獎牌。緊記在未來2天內開始新嘅「步行計劃」。";
            }
        }
        else if(upDateDatePress==6)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@"Don’t give up now as you’ve only got four more programmes to complete!";
            }
            else
            {
                name1=@"唔好而家放棄,只係剩4個「步⾏計劃」就完成!";
            }
        }
        else if(upDateDatePress==7)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@"Feeling great and healthy with your 7th medal? Get even fitter after completing 10 programmes.";
            }
            else
            {
                name1=@"你已獲取第7面獎牌!感覺良好又健康?堅持完成10個步⾏計劃,感覺一定會更好!";
            }
        }
        else if(upDateDatePress==8)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@" Excellent! You are only 2 medals away from the trophy. Remember to start a new programme within the next 2 days.";
            }
            else
            {
                name1=@"激讚!攞多2面獎牌就得到獎盃。緊記在未來2天內開始新嘅「步行計劃」。";
            }
        }
        else if(upDateDatePress==9)
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@"The trophy is in your sight! Only one more medal to go. Remember to start a new programme within the next 2 days.";
            }
            else
            {
                name1=@"獎盃就在眼前,只要再獲取多⼀面獎牌就可以成功!緊記在未來2天內開始新嘅「步行計劃」。";
            }
        }
        else
        {
            if ([strTempTemp isEqualToString:@"Done"]) {
                name1=@" Congratulations! You’ve won a trophy with a HK$100 health products coupon, Share your achievement with your friends now!";
            }
            else
            {
                name1=@"恭喜!你已成功得到獎盃及HK$100健康產品優惠券,⽴即和朋友分享你努力嘅成果!";
            }
        }
         [self resetClock:date30min timeNAme:name1 userInfo:dic0];
        
        
        
        
        
        
        
        
        
        
        
        if (upDateDatePress<5) {
            //前四次
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
            NSLog(@"%@", strDate);
            
            NSString *strTemp=[[NSString alloc]initWithFormat:@"%@ 9:00:00",strDate];
            
            
            
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date2 = [dateFormatter2 dateFromString:strTemp];
            NSLog(@"%@", date2);
            
     
            NSTimeInterval secondsPerDay2 = (24*60*60)*2;
            NSDate *tomorrow2 = [date2 dateByAddingTimeInterval:secondsPerDay2];
            NSDictionary*  dic=[[NSDictionary alloc]initWithObjectsAndKeys: @"tp2",@"title",nil];
            NSString *name2;
            if ([strTempTemp isEqualToString:@"Done"])
            {
                name2=@"Make a move and continue the Training Programme today or the medal count towards winning a trophy will be reset to 0.";
            }
            else
            {
                name2=@"今日就動起來,繼續你嘅「步⾏計劃」,不然,獎牌數⽬就會被重設至零,⽽你將須要從新累積獎牌以得到獎盃。";
            }
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
          
            NSString *oldNumber=[defaults objectForKey:@"The number of training false"];
            
   

            
            if ([oldNumber intValue]<3)
            {
            
                [self resetClock:tomorrow2 timeNAme:name2 userInfo:dic];
            }
           
            
            
         
        }
        if (upDateDatePress>4&&upDateDatePress<10) {
            //後五次
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
            NSLog(@"%@", strDate);
            
            NSString *strTemp=[[NSString alloc]initWithFormat:@"%@ 9:00:00",strDate];
            
            
            
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date2 = [dateFormatter2 dateFromString:strTemp];
            NSLog(@"%@", date2);
            
            
            
            NSTimeInterval secondsPerDay2 = (24*60*60)*2;
            NSDate *tomorrow2 = [date2 dateByAddingTimeInterval:secondsPerDay2];
            NSDictionary*  dic=[[NSDictionary alloc]initWithObjectsAndKeys: @"tp3",@"title",nil];
            NSString *name3;
            if ([strTempTemp isEqualToString:@"Done"])
            {
                name3=@"You are more than halfway to getting your trophy, don’t give up now and continue your training programme today.";
            }
            else
            {
                name3=@"你已完成超過一半獲取獎盃所需嘅路程,不要現在放棄,繼續你嘅「步行計劃」。";
            }
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
            NSString *oldNumber=[defaults objectForKey:@"The number of training false"];
            
            

            if ([oldNumber intValue]<3)
            {
                [self resetClock:tomorrow2 timeNAme:name3 userInfo:dic];

            }
            

            
            
            
            
            
        }
        if (upDateDatePress>0)
        {
            //摞盃后两日
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
            NSLog(@"%@", strDate);
            
            NSString *strTemp=[[NSString alloc]initWithFormat:@"%@ 12:00:00",strDate];
            
            
            
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date2 = [dateFormatter2 dateFromString:strTemp];
            NSLog(@"%@", date2);
            
            
            
            NSTimeInterval secondsPerDay2 = (24*60*60)*2;
            NSDate *tomorrow2 = [date2 dateByAddingTimeInterval:secondsPerDay2];
            NSDictionary*  dic=[[NSDictionary alloc]initWithObjectsAndKeys: @"tp4",@"title",nil];
            NSString *name4;
            if ([strTempTemp isEqualToString:@"Done"])
            {
                name4=@"You did well with your last trophy, keep up the good work and start a new training programme today!";
            }
            else
            {
                name4=@"喺取得上一個獎盃嘅過程,你做得好好。繼續努力,今日就開始⼀一個新嘅「步⾏計劃」!";
            }
            
                [self resetClock:tomorrow2 timeNAme:name4 userInfo:dic];
    
        }
        
        
        
    }

    
    
   
    
    
}


- (void)resetClock:(NSDate*)date timeNAme:(NSString*)name userInfo:(NSDictionary*)dic
{
    
    
    UILocalNotification *notification = [[UILocalNotification alloc] init] ;
    //设置時間
    NSLog(@"%@      %@    %@",date,[NSDate date],name);
    NSDate *pushDate = date ;
    if (notification != nil)
    {
        // 设置推送时间
        notification.fireDate = pushDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        //  notification.repeatInterval = kCFCalendarUnitDay;
        notification.repeatInterval = 0;
        // 推送声音
        notification.soundName =@"oldphone-mono-30s.caf";
        // 推送内容
        notification.alertBody =name;
        
        
        
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 0;
        
        
        
        //设置userinfo 方便在之后需要撤销的时候使用
        //  NSDictionary *info = [NSDictionary dictionaryWithObject:name forKey:@"id"];
        //NSLog(@"info=%@",info);
        

        
        
        notification.userInfo = dic;
        
        //添加推送到UIApplication
        //[[UIApplication sharedApplication] scheduleLocalNotification:notification];
        //这句真的特别特别重要。如果不加这一句，通知到时间了，发现顶部通知栏提示的地方有了，然后你通过通知栏进去，然后你发现通知栏里边还有这个提示
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
        
    }
    
    
    
    
}




- (void) sizeLabel: (UILabel *) label {
    
    // Set the frame of the label to the targeted rectangle
    //label.frame = labelRect;
    
    // Try all font sizes from largest to smallest font size
    int fontSize = 50;
    int minFontSize = 10;
    
    // Fit label width wize
    CGSize constraintSize = CGSizeMake(label.frame.size.width, MAXFLOAT);
    
    do {
        // Set current font size
        label.font = [UIFont fontWithName:label.font.fontName size:fontSize];
        
        // Find label size for current font size
        CGRect textRect = [[label text] boundingRectWithSize:constraintSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:label.font}
                                                     context:nil];
        
        CGSize labelSize = textRect.size;
        
        
        //NSLog(@"adjust size.......%d,%f,%f",fontSize,label.frame.size.height,labelSize.height);
        
        // Done, if created label is within target size
        if( labelSize.height <= label.frame.size.height )
            break;
        
        // Decrease the font size and try again
        fontSize -= 2;
        
    } while (fontSize > minFontSize);
}



@end
