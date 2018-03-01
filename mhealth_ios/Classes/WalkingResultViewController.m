//
//  WalkingResultViewController.m
//  mHealth
//
//  Created by sngz on 14-1-29.
//
//
//
#import "WalkingResultViewController.h"
#import "HomeViewController.h"
#import "WalkForHealthViewController.h"
#import "LearnMoreFirstViewController.h"
#import "FirstWalkResultViewController.h"
#import "SyncWalking.h"
#import "GameObject.h"
#import "SyncGame.h"
#import "InTheTreeViewController.h"
#import "StartingFromBronzeViewController.h"
#import "TKAlertCenter.h"
#import "NSNotificationCenter+MainThread.h"
#import "UIView+Toast.h"
#import "UIAlertController+Orientation.h"


@interface WalkingResultViewController (){
    
    BOOL isReturnRoute;
    
    BOOL limitClick;
}

@end

@implementation WalkingResultViewController

@synthesize result;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   // self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   
    if (iPad) {
        

        self = [super initWithNibName:@"WalkingResultViewController3.5" bundle:nibBundleOrNil];

    }
    else{
       self =  [super initWithNibName:@"WalkingResultViewController" bundle:nibBundleOrNil];
    }
    
    
   
    
    
    
    
    
    

    
    if (self) {
        // Custom initialization
        
        
        
        
        
    }
    return self;
}


- (void)updateRecord
{
    
    result= [SyncWalking getWalkingRecordDetail:result.recordid];
    
    [self refreshMap];
    
    //[[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"SyncFinish" object:nil];
    
}

- (void)refreshMap
{
    [result setPlannedRoutePoints];
    [result setTrackPoints];
    if (self.result!=Nil&&[self.result.plannedRoutePoints count]>0) {
        
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *returnRoute=[userDefaults objectForKey:@"isReturnRoute"];
        
        
        if ([returnRoute isEqualToString:@"1"]) {
            
            
            isReturnRoute=true;
            
        }else{
            
            
            isReturnRoute=false;
            
        }
        
        
        
        [self updateRoute];
    }
    
    //NSLog(@"steps here:%@",result.steps);
    if (self.result!=nil&&[self.result.trackPoints count]>0) {
        
        self.polyline = [[GMSPolyline alloc] init];
        self.path = [GMSMutablePath path];
        
        [self updateTrack];
    }
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(![_lastActivity isEqualToString:@"Pedometer"]){
        
        //_record= [SyncWalking getWalkingRecordDetail:_record.recordid];
        
        NSThread *syncThread = [[NSThread alloc]initWithTarget:self selector:@selector(updateRecord) object:nil];
        [syncThread start];
    }
    
    strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"Done"]];
    
    
    if ([self.chickTheCal isEqualToString:@"Yes"])
    {
        _calItemLayout.hidden=true;
        NSLog(@"*(&*&*(&*(&#*(&(*@#&$*#@&*$(#@&$*#@&*($&@*&@(*$@$@#");
        
        NSString *lanuage = [Utility getLanguageCode];
        if([lanuage isEqualToString:@"en"]){
            
            _targetViewLayout.hidden=0;
            _targetCalValue.text=result.target;
            _burnCalValue.text=self.result.calsburnt;
        }
        else
        {
            _targetViewLayout_zh.hidden=0;
            _targetCalValue_zh.text=result.target;
            _burnCalValue_zh.text=self.result.calsburnt;
        }
        
        
    }
  
    
    
    
    
    
    
//07_wa_awards_btn_share_2
//       self.speedLabelUnit.frame=CGRectMake(262, 10, 38, 44);
//    self.speedLabelUnit.textAlignment=NSTextAlignmentCenter;
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
    
    
    lemonTreeImageStr0=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_07_dim" ofType:@"png"];
    treeImageStr=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_00" ofType:@"png"];
    
    lemonTreeImageStr1=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_01" ofType:@"png"];
    lemonTreeImageStr2=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_02" ofType:@"png"];
    lemonTreeImageStr3=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_03" ofType:@"png"];
    lemonTreeImageStr4=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_04" ofType:@"png"];
    lemonTreeImageStr5=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_05" ofType:@"png"];
    lemonTreeImageStr6=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_06" ofType:@"png"];
    lemonTreeImageStr7=[[NSBundle mainBundle] pathForResource:@"07_cw_plant_lemon_07" ofType:@"png"];
    
    
    
    orangeTreeImageStr0=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_07_dim" ofType:@"png"];
    orangeTreeImageStr1=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_01" ofType:@"png"];
    
    orangeTreeImageStr2=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_02" ofType:@"png"];
    orangeTreeImageStr3=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_03" ofType:@"png"];
    orangeTreeImageStr4=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_04" ofType:@"png"];
    orangeTreeImageStr5=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_05" ofType:@"png"];
    orangeTreeImageStr6=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_06" ofType:@"png"];
    orangeTreeImageStr7=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_07" ofType:@"png"];
    NSLog(@"orangeTreeImageStr0===%@",orangeTreeImageStr0);
    NSLog(@"orangeTreeImageStr1===%@",orangeTreeImageStr1);
    NSLog(@"orangeTreeImageStr3===%@",orangeTreeImageStr5);
    NSLog(@"orangeTreeImageStr4===%@",orangeTreeImageStr6);
    tomatoTreeImageStr0=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_07_dim" ofType:@"png"];
    
    tomatoTreeImageStr1=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_01" ofType:@"png"];
    tomatoTreeImageStr2=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_02" ofType:@"png"];
    tomatoTreeImageStr3=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_03" ofType:@"png"];
    tomatoTreeImageStr4=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_04" ofType:@"png"];
    tomatoTreeImageStr5=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_05" ofType:@"png"];
    tomatoTreeImageStr6=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_06" ofType:@"png"];
    tomatoTreeImageStr7=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_07" ofType:@"png"];
    NSLog(@" tomatoTreeImageStr0===%@", tomatoTreeImageStr0);
    NSLog(@" tomatoTreeImageStr1===%@", tomatoTreeImageStr1);
    NSLog(@" tomatoTreeImageStr2===%@", tomatoTreeImageStr2);
    NSLog(@" tomatoTreeImageStr1===%@", tomatoTreeImageStr3);
    NSLog(@" tomatoTreeImageStr1===%@", tomatoTreeImageStr4);
    NSLog(@" tomatoTreeImageStr1===%@", tomatoTreeImageStr5);
    NSLog(@" tomatoTreeImageStr1===%@", tomatoTreeImageStr6);
    NSLog(@" tomatoTreeImageStr1===%@", tomatoTreeImageStr7);
    
    
    // Do any additional setup after loading the view from its nib.
    NSLog(@" tomatoTreeImageStr0===%@", tomatoTreeImageStr0);
    NSLog(@" tomatoTreeImageStr1===%@", tomatoTreeImageStr1);
    NSLog(@" tomatoTreeImageStr2===%@", tomatoTreeImageStr2);
    NSLog(@" tomatoTreeImageStr3===%@", tomatoTreeImageStr3);
    NSLog(@" tomatoTreeImageStr4===%@", tomatoTreeImageStr4);
    NSLog(@" tomatoTreeImageStr5===%@", tomatoTreeImageStr5);
    NSLog(@" tomatoTreeImageStr6===%@", tomatoTreeImageStr6);
    NSLog(@" tomatoTreeImageStr7===%@", tomatoTreeImageStr7);
    GameObject *cwGameObject=[DBHelper getPlantProgress];
    NSString *cwPlantType=[cwGameObject plantType];
    NSString *cwProgress=[cwGameObject progress];
    int cwProgressINT=[cwProgress intValue];
    NSInteger strLength=[self.theADDRoadStr length];
    scrollView.bounces=NO;
    UIToolbar*toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [toolBar setBarStyle:UIBarStyleBlack];
    toolBar.translucent=YES;
    toolBar.tintColor=[UIColor grayColor];
    UIBarButtonItem*barButton1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(leaveEditMode)];
    UIBarButtonItem*barButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(leaveEditMode)];
    NSArray *array=[[NSArray alloc] initWithObjects:barButton1,barButton, nil];
    toolBar.items=array;
    [plantNametextField setInputAccessoryView:toolBar];
    
    //result= [SyncWalking getWalkingRecordDetail:result.recordid];
    
    //[self refreshMap];
    
    plantNametextField.delegate=self;
    
    
    
    
    
  //  cwProgressINT=0;
    NSLog(@"self.theAddRoadStr==%@",self.theADDRoadStr);
    NSLog(@"strLength==%ld",(long)strLength);
    
    if (strLength==11)
    {
        NSString *plant=[self.theADDRoadStr substringWithRange:NSMakeRange(6, 1)];
        NSString *number=[self.theADDRoadStr substringWithRange:NSMakeRange(8, 1)];
        NSString *yORn=[self.theADDRoadStr substringWithRange:NSMakeRange(10, 1)];
        
        isCCCView.hidden=YES;
        
        
        NSLog(@"plant ====%@",plant);
        NSLog(@"nmber====%@",number);
        cwPlantType=plant;
        cwProgressINT=[number intValue];
        
        
        if (cwProgressINT>5) {
            congratulationsLabelTextFont.hidden=NO;
            visit.hidden=NO;
            
            [visit setTitle:[Utility getStringByKey:@"Visit"] forState:UIControlStateNormal];
            congratulationsLabelTextFont.text=[Utility getStringByKey:@"Congratulations!"];
            congratulationsLabelTextFont.hidden=true;
            
            
            if([yORn isEqualToString:@"I"]){
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"false" forKey:[NSString stringWithFormat:@"award_load_from_db_%@",[GlobalVariables shareInstance].login_id]];
                [defaults synchronize];
            }
            

        }
        else
        {
            congratulationsLabelTextFont.hidden=YES;
            visit.hidden=YES;
        }
        
        //    }
        //
        //    if (cwProgressINT>0)//old RP.progress>0
        //    {
        NSLog(@"cwpRogressINT==%d",cwProgressINT);
            if (cwProgressINT==0) {
                //
                if ([plant isEqualToString:@"T"]) {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr1];
                }
                else if ([plant isEqualToString:@"L"])
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr1];
                }
                else
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr1];
                }
                
                bigTreeImageView.image=theBigTreeImage;
                if([result.target isEqualToString:@"0"]){
                    self.okBtn.frame=CGRectMake(101, 415+330, 118, 35);
                }
                else{
                    
                    self.okBtn.frame=CGRectMake(101, 415+330+35, 118, 35);
                }
               
                if ([yORn isEqualToString:@"I"])
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Plant is at stage 0/6. Hello! I am full of energy!"];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"植物已成⾧至6個階段中嘅第0階段。 你好,我已經充滿力量!"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }

                }
                else if ([yORn isEqualToString:@"N"])
                {
                    
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"You have walked more than once today. As the plant has already absorbed its nutrients for the day, its growth stage remains the same."];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"你今天已步行多過一次,由於植物已吸收每⽇所需養分,成⾧階段會維持不變"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }
                else
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"I lack adequate nutrients for growth. Please walk for at least 30 minutes with 80 steps per minute a day so that I can grow and become healthy again. "];
                     NSString *titleTextCH=[[NSString alloc] initWithFormat:@"我因養分不足唔能夠生長至下一階段。請每日最少以每分鐘80步嘅步速步行30分鐘，畀我可以繼續成長及回復健康。"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }
                
                
                
                shareButton.hidden=YES;
                   NSLog(@"0000000");
            }
            else if (cwProgressINT==1)
            {
                if ([plant isEqualToString:@"T"]) {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr2];
                }
                else if ([plant isEqualToString:@"L"])
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr2];
                }
                else
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr2];
                }
                bigTreeImageView.image=theBigTreeImage;
                 if([result.target isEqualToString:@"0"]) {
                    self.okBtn.frame=CGRectMake(101, 415+330, 118, 35);
                }
                else
                {
                    self.okBtn.frame=CGRectMake(101, 415+330+35, 118, 35);
                }
                
                if ([yORn isEqualToString:@"I"])
                {
//                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Tomato is growing to Stage 1/6. Keep it up so it will flower!"];
//                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"蕃茄樹已成長到 1/6階段。請繼續努力讓它開出花朵！"];
                    
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Plant is at stage 1/6. Hello! I am full of energy!"];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"植物已成⾧至6個階段中嘅第1階段。 你好,我已經充滿⼒量!"];
                    
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                    
                }
                else if ([yORn isEqualToString:@"N"])
                {
                    
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"You have walked more than once today. As the plant has already absorbed its nutrients for the day, its growth stage remains the same."];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"你今天已步行多過一次,由於植物已吸收每⽇所需養分,成⾧階段會維持不變。"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }

                else
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"I lack adequate nutrients for growth. Please walk for at least 30 minutes with 80 steps per minute a day so that I can grow and become healthy again. "];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"我因養分不足唔能夠生長至下一階段。請每日最少以每分鐘80步嘅步速步行30分鐘，畀我可以繼續成長及回復健康。"];                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }
                

                
                shareButton.hidden=YES;
                   NSLog(@"111111111");
            }
            else if (cwProgressINT==2)
            {
                if ([plant isEqualToString:@"T"]) {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr3];
                }
                else if ([plant isEqualToString:@"L"])
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr3];
                }
                else
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr3];
                }
                bigTreeImageView.image=theBigTreeImage;
                NSLog(@"theBigTreeImage=%@",tomatoTreeImageStr3);
                if ([yORn isEqualToString:@"I"])
                {
//                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Tomato is growing to Stage 2/6. Keep it up so it will flower!"];
//                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"蕃茄樹已成長到 2/6階段。請繼續努力讓它開出花朵！"];cwGameObject
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"%@ is at stage 2/6. Wow! See my first flower?",cwGameObject.plantName];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"%@ 已成⾧至6個階段中嘅第2階段。嘩!你睇唔睇到我嘅第一朵花?",cwGameObject.plantName];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                    
                }
                else if ([yORn isEqualToString:@"N"])
                {
                    
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"You have walked more than once today. As the plant has already absorbed its nutrients for the day, its growth stage remains the same."];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"你今天已步行多過一次,由於植物已吸收每⽇所需養分,成⾧階段會維持不變"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }

                else
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"I lack adequate nutrients for growth. Please walk for at least 30 minutes with 80 steps per minute a day so that I can grow and become healthy again. "];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"我因養分不足唔能夠生長至下一階段。請每日最少以每分鐘80步嘅步速步行30分鐘，畀我可以繼續成長及回復健康。"];                      if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }
                

                
                  if([result.target isEqualToString:@"0"]){
                    self.okBtn.frame=CGRectMake(101, 415+330, 118, 35);
                }
                else
                {
                    self.okBtn.frame=CGRectMake(101, 415+330+35, 118, 35);
                }
                
                shareButton.hidden=YES;
                   NSLog(@"222222222");
            }
            else if (cwProgressINT==3)
            {
                NSLog(@"33333333");
                if ([plant isEqualToString:@"T"]) {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr4];
                }
                else if ([plant isEqualToString:@"L"])
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr4];
                }
                else
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr4];
                }
                bigTreeImageView.image=theBigTreeImage;
                 NSLog(@"theBigTreeImage=%@",tomatoTreeImageStr4);
                 NSLog(@"theBigTreeImage=%@",theBigTreeImage);
                 NSLog(@"theBigTreeImage=%@",tomatoTreeImageStr4);
                  if([result.target isEqualToString:@"0"]) {
                    self.okBtn.frame=CGRectMake(101, 415+330, 118, 35);
                }
                else
                {
                    self.okBtn.frame=CGRectMake(101, 415+330+35, 118, 35);
                }
                
                shareButton.hidden=YES;
                if ([yORn isEqualToString:@"I"])
                {
//                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Tomato is growing to Stage 3/6. Keep it up so it will flower!"];
//                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"蕃茄樹已成長到 3/6階段。請繼續努力讓它開出花朵！"];
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"%@ is at stage 3/6. Look! I’m healthier today. Hopefully you feel healthier too.",cwGameObject.plantName];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"%@ 已成⾧至6個階段中嘅第3階段。你睇吓!我今⽇成長得更加健康!希望你都覺得更加健康!",cwGameObject.plantName];
                    
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                    
                }
                else if ([yORn isEqualToString:@"N"])
                {
                    
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"You have walked more than once today. As the plant has already absorbed its nutrients for the day, its growth stage remains the same."];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"你今天已步行多過一次,由於植物已吸收每⽇所需養分,成⾧階段會維持不變"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }

                else
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"I lack adequate nutrients for growth. Please walk for at least 30 minutes with 80 steps per minute a day so that I can grow and become healthy again. "];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"我因養分不足唔能夠生長至下一階段。請每日最少以每分鐘80步嘅步速步行30分鐘，畀我可以繼續成長及回復健康。"];                     if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }
                

                
            }
            else if (cwProgressINT==4)
            {
                if ([plant isEqualToString:@"T"]) {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr5];
                }
                else if ([plant isEqualToString:@"L"])
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr5];
                }
                else
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr5];
                }
                bigTreeImageView.image=theBigTreeImage;
                
                   if([result.target isEqualToString:@"0"]) {
                    self.okBtn.frame=CGRectMake(101, 415+330, 118, 35);
                }
                else
                {
                    self.okBtn.frame=CGRectMake(101, 415+330+35, 118, 35);
                }
                
                shareButton.hidden=YES;
                   NSLog(@"444444444");
                if ([yORn isEqualToString:@"I"])
                {
//                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Tomato is growing to Stage 4/6. Keep it up so it will flower!"];
//                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"蕃茄樹已成長到 4/6階段。請繼續努力讓它開出花朵！"];
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"%@ is at stage 4/6. See how walking has transformed me! Keep it up!",cwGameObject.plantName];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"%@ 已成⾧至6個階段中嘅第4階段。睇吓你步⾏嘅努⼒成果?繼續加油!",cwGameObject.plantName];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                    
                }
                else if ([yORn isEqualToString:@"N"])
                {
                    
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"You have walked more than once today. As the plant has already absorbed its nutrients for the day, its growth stage remains the same."];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"你今天已步行多過一次,由於植物已吸收每⽇所需養分,成⾧階段會維持不變"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }

                else
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"I lack adequate nutrients for growth. Please walk for at least 30 minutes with 80 steps per minute a day so that I can grow and become healthy again. "];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"我因養分不足唔能夠生長至下一階段。請每日最少以每分鐘80步嘅步速步行30分鐘，畀我可以繼續成長及回復健康。"];                     if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }
                

                
            }
            else if (cwProgressINT==5)
            {
                if ([plant isEqualToString:@"T"]) {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr6];
                }
                else if ([plant isEqualToString:@"L"])
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr6];
                }
                else
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr6];
                }
                bigTreeImageView.image=theBigTreeImage;
                   if([result.target isEqualToString:@"0"]) {
                    self.okBtn.frame=CGRectMake(101, 415+330, 118, 35);
                }
                else
                {
                    self.okBtn.frame=CGRectMake(101, 415+330+35, 118, 35);
                }
                
                shareButton.hidden=YES;
                   NSLog(@"555555555");
                if ([yORn isEqualToString:@"I"])
                {
//                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Tomato is almost ready to flower, just walk one more time!"];
//                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"你只須步行多一次，蕃茄樹便會開花了！"];
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"%@ is at stage 5/6. One more walk to go and all my fruits will be ripe!",cwGameObject.plantName];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"%@ 已成⾧至6個階段中嘅第5階段。只要再⾏多⼀次,果子就全部成熟!",cwGameObject.plantName];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                    
                }
                else if ([yORn isEqualToString:@"N"])
                {
                    
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"You have walked more than once today. As the plant has already absorbed its nutrients for the day, its growth stage remains the same."];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"你今天已步行多過一次,由於植物已吸收每⽇所需養分,成⾧階段會維持不變"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }

                else
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"I lack adequate nutrients for growth. Please walk for at least 30 minutes with 80 steps per minute a day so that I can grow and become healthy again. "];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"我因養分不足唔能夠生長至下一階段。請每日最少以每分鐘80步嘅步速步行30分鐘，畀我可以繼續成長及回復健康。"];                     if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }
            }
            else if (cwProgressINT==6)
            {
                if ([plant isEqualToString:@"T"]) {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr7];
                }
                else if ([plant isEqualToString:@"L"])
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr7];
                }
                else
                {
                    theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr7];
                }
                bigTreeImageView.image=theBigTreeImage;
                  if([result.target isEqualToString:@"0"]) {
               
                    shareButton.frame=CGRectMake(20 , 415+330, 118 , 35);
                    self.okBtn.frame=CGRectMake(180, 415+330, 118, 35);
                }
                else
                {
                    shareButton.frame=CGRectMake(20 , 415+330+35, 118 , 35);
                    self.okBtn.frame=CGRectMake(180, 415+330+35, 118, 35);
                }
                
                
                shareButton.hidden=NO;
                
//                NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Congratulations, you now have a tomato plant. You can try our training programmes to earn a trophy and coupon! "];
//                NSString *titleTextCH=[[NSString alloc] initWithFormat:@"恭喜你！你已經得到了植物蕃茄樹 。你可以嘗試參與步行計劃以獲取獎盃及優惠券。"];
                
                if ([yORn isEqualToString:@"I"])
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"%@ is at stage 6/6. I have become a strong and healthy plant. Congratulations and thanks! Try out the Training Programme and your efforts will be recognised with trophies and you will also win a prize coupon.",cwGameObject.plantName];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"%@ 已成⾧至6個階段中嘅第6階段。我已成⾧為一棵強壯健康嘅植物。多謝你! 試試我哋嘅「步行計劃」,我哋會以獎盃及優惠券⾒證你嘅努力!",cwGameObject.plantName];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                    
                    
                    
                }
                
                else if ([yORn isEqualToString:@"F"])
                {
                    
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"You have walked more than once today. As the plant has already absorbed its nutrients for the day, its growth stage remains the same."];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"你今天已步行多過一次,由於植物已吸收每⽇所需養分,成⾧階段會維持不變"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }
                
                else
                {
                    NSString *titleTextEN=[[NSString alloc] initWithFormat:@"I lack adequate nutrients for growth. Please walk for at least 30 minutes with 80 steps per minute a day so that I can grow and become healthy again. "];
                    NSString *titleTextCH=[[NSString alloc] initWithFormat:@"我因養分不足唔能夠生長至下一階段。請每日最少以每分鐘80步嘅步速步行30分鐘，畀我可以繼續成長及回復健康。"];
                    if ([strTempTemp isEqualToString:@"Done"]) {
                        congratulationsLittleTextFont.text=titleTextEN;
                    }
                    else
                    {
                        congratulationsLittleTextFont.text=titleTextCH;
                    }
                }

            
                
                
                
                
                   NSLog(@"666666666");
            }
        
        
        


        
        
        congratulationsView.hidden=NO;
        chickTreeView.hidden=YES;
        self.theMapView.hidden=YES;
        self.statusView.hidden=NO;
        self.trackBtnView.hidden=NO;
        
        
        congratulationsView.frame=CGRectMake(0, 38, 320, 335);
        self.statusView.frame=CGRectMake(0, 38+335, 320, 334);
        self.targetViewLayout.frame=CGRectMake(0, 260+335+55, 320, 130);
        self.targetViewLayout_zh.frame=CGRectMake(0, 260+335+55, 320, 130);
    
        //  self.okBtn.frame=CGRectMake(101, 415+335, 118, 35);
        NSLog(@"nONONTOTTNOTNTOTNOTNOTNTOTOTNOTNOTNTOTNOTTNTNOTNOTNOTt");
        NSLog(@"");
          if([result.target isEqualToString:@"0"]) {
            scrollView.contentSize=CGSizeMake(320, 415+315+56+35+20);
                  self.upload_succ.frame=CGRectMake(20, 388+335+55+10, 280, 21);
        NSLog(@"______________________________");
        }
        else
        {
            scrollView.contentSize=CGSizeMake(320, 415+315+56+35+20+55);
                self.upload_succ.frame=CGRectMake(20, 388+335+55+10+30, 280, 21);
                  NSLog(@"++++++++++++++++++++++++");
        }

    }
    else //old RP.progress=0
    {
        shareButton.hidden=YES;
        
        //   self.isCOK=@"1";
        NSLog(@"__________________++++++++++___self.isCOK=%@_________",self.isCOK);
        //Chick C
        //self.isCOK=@"1";
        if ([self.isCOK isEqualToString:@"1"])
        {
            
            
            
            
            
            whatTheTree.text=[Utility getStringByKey:@"Tomato tree"];
            
            plantNametextField.placeholder=[Utility getStringByKey:@"My plant name"];
            
         
//            NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Orange is growing to Stage 1/6. Keep it up so it will flower!"];
//            NSString *titleTextCH=[[NSString alloc] initWithFormat:@"已成長到 1/6階段。請繼續努力讓它開出花朵！"];
//            
            NSString *titleTextEN=[[NSString alloc] initWithFormat:@"Plant is at stage 1/6. Hello! I am full of energy!"];
            NSString *titleTextCH=[[NSString alloc] initWithFormat:@"植物已成⾧至6個階段中嘅第1階段。 你好,我已經充滿⼒量!"];
            
            if ([strTempTemp isEqualToString:@"Done"]) {
                 littleTextTextFont.text=titleTextEN;
            }
            else
            {
               littleTextTextFont.text=titleTextCH;
            }
            
 
                isCCCView.hidden=NO;
            //C ok
            NSLog(@"____________ccccccc______++++++++++___self.isCOK=%@_________",self.isCOK);
            
            congratulationsView.hidden=YES;
            chickTreeView.hidden=NO;
            self.theMapView.hidden=YES;
            self.statusView.hidden=NO;
            self.trackBtnView.hidden=NO;
           
            chickTreeView.frame=CGRectMake(0, 38, 320, 315);
            self.statusView.frame=CGRectMake(0, 38+315, 320, 278+56);
            self.targetViewLayout.frame=CGRectMake(0, 260+315+55, 320, 130);
          
         
            self.targetViewLayout_zh.frame=CGRectMake(0, 260+315+55, 320, 130);
              if([result.target isEqualToString:@"0"]) {
                  scrollView.contentSize=CGSizeMake(320, 415+315+56+35+20);
                   self.okBtn.frame=CGRectMake(101, 415+310, 118, 35);
                    self.upload_succ.frame=CGRectMake(20, 388+315+55+10, 280, 21);
            }
          else
          {
                scrollView.contentSize=CGSizeMake(320, 415+315+56+35+20+55);
                 self.okBtn.frame=CGRectMake(101, 415+310+35, 118, 35);
                self.upload_succ.frame=CGRectMake(20, 388+315+55+10+30, 280, 21);
          }
            
//            
//            NSLog(@"chickTreeVIew,hidden===%d",chickTreeView.hidden);
//            scrollView.contentSize=CGSizeMake(320, 800+35+20);
//            
            
        }
        else
        {
            
            
                isCCCView.hidden=YES;
            NSLog(@"NOTNOTNOTNOTNOTNONTONTONOONOTNOTNOTNONTO");
            //C not
            congratulationsView.hidden=YES;
            chickTreeView.hidden=YES;
            self.theMapView.hidden=YES;
            self.statusView.hidden=NO;
            self.trackBtnView.hidden=NO;
            
            self.statusView.frame=CGRectMake(0, 38, 320, 334);
            self.targetViewLayout.frame=CGRectMake(0, 260+55, 320, 130);
            self.targetViewLayout_zh.frame=CGRectMake(0, 260+55, 320, 130);
  
          
              if([result.target isEqualToString:@"0"])
            {
                      NSLog(@"+++++++######$$$^&*&^$#^$#%d...%d",self.targetViewLayout_zh.hidden,self.targetViewLayout.hidden);
                      self.okBtn.frame=CGRectMake(101, 410, 118, 35);
                scrollView.contentSize=CGSizeMake(320, 415+56+35+20);
                          self.upload_succ.frame=CGRectMake(20, 388+55+10, 280, 21);
            }
            else
            {
                NSLog(@"+++++++@@@@@@@@@@########$$$^&*&^$#^$#%d...%d",self.targetViewLayout_zh.hidden,self.targetViewLayout.hidden);
                   self.okBtn.frame=CGRectMake(101, 410+35, 118, 35);
                scrollView.contentSize=CGSizeMake(320, 415+56+35+20+55);
                          self.upload_succ.frame=CGRectMake(20, 388+55+10+30, 280, 21);
                
            }
            
        }
        
        
        
        
        
    }
    
    
    NSLog(@"self.ok button Frame=%@",self.okBtn);
    NSLog(@"self.ok button Hidden=%d",self.okBtn.hidden);
    NSLog(@"scrollView=%@",scrollView);
    
    
    
    
    
    
    
    [result setPlannedRoutePoints];
    [result setTrackPoints];
    if (self.result!=Nil&&[self.result.plannedRoutePoints count]>0) {
        
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *returnRoute=[userDefaults objectForKey:@"isReturnRoute"];
        
        
        if ([returnRoute isEqualToString:@"1"]) {
            
            
            isReturnRoute=true;
            
        }else{
            
            
            isReturnRoute=false;
            
        }
        
        
        
        [self updateRoute];
    }
    
    NSLog(@"steps here:%@",result.steps);
    if (self.result!=nil&&[self.result.trackPoints count]>0) {
        
        self.polyline = [[GMSPolyline alloc] init];
        self.path = [GMSMutablePath path];
        
        [self updateTrack];
    }
    
    double distance=[self.result.distance doubleValue]/1000;
    
    NSLog(@"check1:%@",self.result.distance);
    NSLog(@"check2:%f",distance);

    
    NSLog(@"self.result.steps=%@;self.result.calsburnt=%@;self.result.pace=%@,",self.result.steps,self.result.calsburnt,self.result.pace);
    
    self.distanceLabel.text=[NSString stringWithFormat:@"%.3f",distance];
    
    
    self.stepsLabel.text=self.result.steps;
    self.calsLabel.text=self.result.calsburnt;
    
    float paceF=[self.result.steps floatValue]/(((float)[self.result getPersistime])/60.0f);
    
    int pace=paceF/1;
    
    self.paceLabel.text=[NSString stringWithFormat:@"%d",pace];
    
    double elapsedSeconds=[self.result getPersistime];
    
    NSLog(@"getPersistime===%f",elapsedSeconds);
    
    if (elapsedSeconds>60)
    {
        double disTancel=[self.distanceLabel.text doubleValue];
        
        
        double speedDouble=(disTancel/elapsedSeconds*60.0*60.0);
        NSLog(@"disTancel==%f",disTancel);
        NSLog(@"speedDouble==%f",speedDouble);
        if (speedDouble>0)
        {
            NSString * speed=[[NSString alloc]initWithFormat:@"%0.3f",speedDouble];
            self.speedLabel.text=speed;
        }
        else
        {
            self.speedLabel.text=@"0";
        }
        
        
        
    }
    else
    {
        double disTancel=[self.distanceLabel.text doubleValue];
        double speedDouble=(disTancel/elapsedSeconds*60.0*60.0);
        NSLog(@"disTancel==%f",disTancel);
        NSLog(@"speedDouble==%f",speedDouble);
        if (speedDouble>0)
        {
            NSString * speed=[[NSString alloc]initWithFormat:@"%0.3f",speedDouble];
            self.speedLabel.text=speed;
        }
        else
        {
            self.speedLabel.text=@"0";
        }
        
    }
    long minutes=0;
    long seconds=0;
    
    
    if (elapsedSeconds>=60) {
        
        minutes=elapsedSeconds/60;
        
        elapsedSeconds-=minutes*60;
    }
    
    
    NSLog(@"result.plannedRoutePoints count:%lu",(unsigned long)[self.result.plannedRoutePoints count]);
    NSLog(@"[self.result.trackPoints count]:%lu",(unsigned long)[self.result.trackPoints count]);
    NSLog(@"result.route:%@",result.route);
    
    if ([self.result.plannedRoutePoints count]==0&&[self.result.trackPoints count]<2) {
        
        CLLocation* location = [[CLLocation alloc] initWithLatitude:22.30 longitude:114.15];
        
        self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                             zoom:9];
        
        NSLog(@"come to camera 1");
    }
    
    seconds=elapsedSeconds;
    
    self.durationLabel.text=[NSString stringWithFormat:@"%ld'%ld''",minutes,seconds];

    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[self.result getRecordtime]];
    NSLog(@"[self.result getRecordtime]==%ld",[self.result getRecordtime]);
 NSDate *time1 = [NSDate dateWithTimeIntervalSinceReferenceDate:[self.result getRecordtime]];
    NSLog(@"self.resultpestime=%@",self.result.persistimeStr);
    NSLog(@"timetimetimetimetime==%@,time1timetimetimetime111==%@",time,time1);
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //	self.dateLabel.text = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:time]];
    
    
    //      self.dateLabel.text = [Utility extractDateString:[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:time]] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *oldDate = [dateFormat dateFromString:[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:time]]];
    if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
        [dateFormat setDateFormat:@"yyyy年M月dd日 HH:mm"];
    } else {
        [dateFormat setDateFormat:@"dd MMM yyyy HH:mm"];
    }
    NSString *dateString = [dateFormat stringFromDate:oldDate];
    
    self.dateLabel.text=dateString;
    
    
    
    
    
    
//     [plantNametextField setText:[Utility getStringByKey:@"Tomato tree"]];
    
    
    _toastPopOnce=false;
    
    
    
   // NSInteger setSize=[self binarySearchForFontSizeForLabel:congratulationsLabelTextFont withMinFontSize:13 withMaxFontSize:20 withSize:congratulationsLabelTextFont.bounds.size];
    
//    [self sizeBinaryLabel:congratulationsLabelTextFont toRect:congratulationsLabelTextFont.bounds];
    
    [self sizeLabel:congratulationsLittleTextFont];
    
   // NSLog(@"setSize:%ld",(long)setSize);
   // congratulationsLittleTextFont.font=[UIFont fontWithName:font57 size:setSize];
    
}




-(void)viewWillAppear:(BOOL)animated{
    
    _distanceLabel.font=[UIFont fontWithName:font57 size:40];
    _stepsLabel.font=[UIFont fontWithName:font57 size:40];
    _calsLabel.font=[UIFont fontWithName:font57 size:40];
    _paceLabel.font=[UIFont fontWithName:font57 size:40];
    _durationLabel.font=[UIFont fontWithName:font57 size:40];
    _dateLabel.font=[UIFont fontWithName:font55 size:16];
    _speedLabel.font=[UIFont fontWithName:font57 size:40];
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
    _speedLabelText.font=[UIFont fontWithName:font67 size:20];
    _durationLabelText.font=[UIFont fontWithName:font67 size:20];

    _okBtn.titleLabel.font=[UIFont fontWithName:font65 size:17];
    
    _titleText.font=[UIFont fontWithName:font65 size:18];
    cas.font=[UIFont fontWithName:font65 size:18];
       [cas setText:[Utility getStringByKey:@"w_walk_title"]];
    
     [_titleText setText:[Utility getStringByKey:@"w_walk_title"]];
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


      NSLog(@"resultresultresultRes==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@",result,result.distance,result.steps,result.pace,result.calsburnt);
    
    
          NSLog(@"self.resultresultresultRes==%@ result.Distance=%@,result.steps=%@,result.pace=%@,result.calsries=%@",self.result,self.result.distance,self.result.steps,self.result.pace,self.result.calsburnt);
    
    
    
    if ([[Utility getLanguageCode] isEqualToString:@"cn"]) {
        
        [_track_route_Btn setImage:[UIImage imageNamed:@"07_wa_btn_map_zh.png"] forState:UIControlStateNormal];
    }else{
        [_track_route_Btn setImage:[UIImage imageNamed:@"07_wa_btn_map.png"] forState:UIControlStateNormal];
    }

    
    
        NSLog(@"result.target check:%@",result.target);
        if([result.target isEqualToString:@"0"]){
            
        }
        else{
            _calItemLayout.hidden=true;
            
            NSLog(@"come to 3");
            NSString *lanuage = [Utility getLanguageCode];
            if([lanuage isEqualToString:@"en"]){
                NSLog(@"come to 1");
                _targetViewLayout.hidden=0;
                _targetCalValue.text=result.target;
                _burnCalValue.text=self.result.calsburnt;
            }
            else{
                NSLog(@"come to 2");
                _targetViewLayout_zh.hidden=0;
                _targetCalValue_zh.text=result.target;
                _burnCalValue_zh.text=self.result.calsburnt;
            }
            
            
        }
    
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;

    if([_lastActivity isEqualToString:@"Pedometer"]&&(session_id!=NULL&&login_id!=NULL)){
        [_upload_succ setText:[Utility getStringByKey:@"upload_succ"]];
        _upload_succ.hidden=false;
    }
    
    self.mapView.camera =[GMSCameraPosition cameraWithLatitude:22.30 longitude:114.15 zoom:9];
    
    
    
    _select_type_tx.text=[Utility getStringByKey:@"select_type_tx"];

    
   
    

}







-(IBAction)toBack:(id)sender{
    

    
    WalkForHealthViewController *wfhView = [[WalkForHealthViewController alloc] initWithNibName:@"WalkForHealthViewController" bundle:nil];
    
    [self.navigationController pushViewController:wfhView animated:YES ];
}

-(IBAction)showMapView:(id)sender{
    NSLog(@"%f",self.okBtn.frame.origin.y);
    self.trackBtnView.hidden=true;
    self.statusView.hidden=true;
    
    self.theMapView.hidden=false;
    
    congratulationsView.hidden=YES;
    chickTreeView.hidden=YES;
    
    self.mapView.frame=CGRectMake(0, 0, 320, 316);
    self.targetViewLayout.frame=CGRectMake(0, 260+55, 320, 130);
    self.targetViewLayout_zh.frame=CGRectMake(0, 260+55, 320, 130);
       NSInteger strLength=[self.theADDRoadStr length];
    NSLog(@" self.the ADDRoadStr==%@",self.theADDRoadStr);
    if (strLength==11)
    {
        // NSString *plant=[self.theADDRoadStr substringWithRange:NSMakeRange(6, 1)];
        NSString *number=[self.theADDRoadStr substringWithRange:NSMakeRange(8, 1)];
        
        
        if ([number intValue]<6) {
            if([result.target isEqualToString:@"0"]) {
                self.okBtn.frame=CGRectMake(101, 410, 118, 35);
                self.upload_succ.frame=CGRectMake(20, 388+55+10, 280, 21);

            }
            else
            {
                self.okBtn.frame=CGRectMake(101, 410+35, 118, 35);
                self.upload_succ.frame=CGRectMake(20, 388+55+10+30, 280, 21);

            }
            shareButton.hidden=YES;
        }
        else
        {
            if([result.target isEqualToString:@"0"]){
                shareButton.frame=CGRectMake(20 ,410, 118 , 35);
                self.okBtn.frame=CGRectMake(180,410, 118, 35);
                self.upload_succ.frame=CGRectMake(20, 388+55+10, 280, 21);

            }
            else
            {
                shareButton.frame=CGRectMake(20 ,410+35, 118 , 35);
                self.okBtn.frame=CGRectMake(180,410+35, 118, 35);
                self.upload_succ.frame=CGRectMake(20, 388+55+10+30, 280, 21);

            }
            shareButton.hidden=NO;
        }
    }
    else
    {
        if([result.target isEqualToString:@"0"]) {
            self.okBtn.frame=CGRectMake(101, 410, 118, 35);
            self.upload_succ.frame=CGRectMake(20, 388+55+10, 280, 21);

        }
        else
        {
            self.okBtn.frame=CGRectMake(101, 410+35, 118, 35);
            self.upload_succ.frame=CGRectMake(20, 388+55+10+30, 280, 21);

        }
        shareButton.hidden=YES;
    }
    
    if([result.target isEqualToString:@"0"]){
        scrollView.contentSize=CGSizeMake(320, 415+35+20);
        
    }
    else
    {
        scrollView.contentSize=CGSizeMake(320, 415+55+35+20);
    }
    
    
    
    
    
}

-(IBAction)showStatusView:(id)sender{
       NSLog(@"%f",self.okBtn.frame.origin.y);
    self.trackBtnView.hidden=false;
    self.statusView.hidden=false;
    
    self.theMapView.hidden=true;
    GameObject *cwGameObject=[DBHelper getPlantProgress];
    NSString *cwPlantType=[cwGameObject plantType];
    NSString *cwProgress=[cwGameObject progress];
    int cwProgressINT=[cwProgress intValue];
    NSInteger strLength=[self.theADDRoadStr length];
    //  scrollView.bounces=NO;
    NSLog(@"strLength===%lu",(long)strLength);
    if (strLength==11)
    {
        NSString *plant=[self.theADDRoadStr substringWithRange:NSMakeRange(6, 1)];
        NSString *number=[self.theADDRoadStr substringWithRange:NSMakeRange(8, 1)];
        
        cwPlantType=plant;
        cwProgressINT=[number intValue];
        //    if (cwProgressINT>0)//old RP.progress>0
        //    {
        congratulationsView.hidden=NO;
        chickTreeView.hidden=YES;
        self.theMapView.hidden=YES;
        self.statusView.hidden=NO;
        self.trackBtnView.hidden=NO;
        
        congratulationsView.frame=CGRectMake(0, 38, 320, 335);
        self.statusView.frame=CGRectMake(0, 38+335, 320, 278+56);
        self.targetViewLayout.frame=CGRectMake(0, 260+335+55, 320, 130);
        self.targetViewLayout_zh.frame=CGRectMake(0, 260+335+55, 320, 130);
        self.upload_succ.frame=CGRectMake(20, 388+335+55+10, 280, 21);
        if ([number intValue]<6) {
            if([result.target isEqualToString:@"0"]) {
                self.okBtn.frame=CGRectMake(101, 415+330, 118, 35);
                self.upload_succ.frame=CGRectMake(20, 388+335+55+10, 280, 21);
            }
            else
            {
                self.okBtn.frame=CGRectMake(101, 415+330+35, 118, 35);
                self.upload_succ.frame=CGRectMake(20, 388+335+55+10+30, 280, 21);
            }
            shareButton.hidden=YES;
            
        }
        else
        {
            if([result.target isEqualToString:@"0"]){
                self.okBtn.frame=CGRectMake(180, 415+330, 118, 35);
                shareButton.frame=CGRectMake(20 ,415+330, 118 , 35);
                self.upload_succ.frame=CGRectMake(20, 388+335+55+10, 280, 21);
            }
            else
            {
                self.okBtn.frame=CGRectMake(180, 415+330+35, 118, 35);
                shareButton.frame=CGRectMake(20 ,415+35+330, 118 , 35);
                self.upload_succ.frame=CGRectMake(20, 388+335+55+10+30, 280, 21);
            }
            shareButton.hidden=NO;
        }
        
        if([result.target isEqualToString:@"0"]) {
            
            scrollView.contentSize=CGSizeMake(320, 415+335+35+20+56);
        }
        else
        {
            scrollView.contentSize=CGSizeMake(320, 415+335+35+20+56+55);
        }
        
    }
    else //old RP.progress=0
    {
        NSLog(@" shit=  OK   ==%lu",(long)strLength);
        //Chick C
        if ([self.isCOK isEqualToString:@"1"])
        {
            //C ok
            
            congratulationsView.hidden=YES;
            chickTreeView.hidden=NO;
            self.theMapView.hidden=YES;
            self.statusView.hidden=NO;
            self.trackBtnView.hidden=NO;
            
            chickTreeView.frame=CGRectMake(0, 38, 320, 315);
            self.statusView.frame=CGRectMake(0, 38+315, 320, 278+56);
            self.targetViewLayout.frame=CGRectMake(0, 260+315+55, 320, 130);
        
       
            self.targetViewLayout_zh.frame=CGRectMake(0, 260+315+55, 320, 130);
               if([result.target isEqualToString:@"0"])
            {
                self.okBtn.frame=CGRectMake(101, 410+315, 118, 35);
                scrollView.contentSize=CGSizeMake(320, 415+315+56+35+20);
                    self.upload_succ.frame=CGRectMake(20, 388+315+55+10, 280, 21);
            }
            else
            {
                self.okBtn.frame=CGRectMake(101, 415+310+35, 118, 35);
                scrollView.contentSize=CGSizeMake(320, 415+315+56+35+20+55);
                    self.upload_succ.frame=CGRectMake(20, 388+315+55+10+30, 280, 21);
            }
            shareButton.hidden=YES;
            
        }
        else
        {
            
                      NSLog(@" shit=  NO   ==%lu",(long)strLength);
            //C not
            congratulationsView.hidden=YES;
            chickTreeView.hidden=YES;
            self.theMapView.hidden=YES;
            self.statusView.hidden=NO;
            self.trackBtnView.hidden=NO;
            
            self.statusView.frame=CGRectMake(0, 38, 320, 278+56);
             self.targetViewLayout_zh.frame=CGRectMake(0, 260+55, 320, 130);
            self.targetViewLayout.frame=CGRectMake(0, 260+55, 320, 130);
            self.upload_succ.frame=CGRectMake(20, 388+55+10, 280, 21);
          if([result.target isEqualToString:@"0"])
            {
                self.okBtn.frame=CGRectMake(101, 410, 118, 35);
                self.upload_succ.frame=CGRectMake(20, 388+55+10, 280, 21);
                scrollView.contentSize=CGSizeMake(320, 415+56+35+20);
            }
            else
            {
                self.upload_succ.frame=CGRectMake(20, 388+55+10+30, 280, 21);
                self.okBtn.frame=CGRectMake(101, 410+35, 118, 35);
                scrollView.contentSize=CGSizeMake(320, 415+56+35+20+55);
            }
            
             shareButton.hidden=YES;
        }
        
        
        
        
        
    }
    

}

-(void)updateRoute{
    
    [self.mapView clear];
    
    if (isReturnRoute) {
        
        
        GMSPolyline *polyline = [[GMSPolyline alloc] init];
        GMSMutablePath *path = [GMSMutablePath path];
        
        
        for (int i=0; i<[self.result.plannedRoutePoints count]; i++) {
            
            //CLLocation *location = [self.points objectAtIndex:i];
            
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.result.plannedRoutePoints objectAtIndex:i]];
            
            
            
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
            
            if (i==[self.result.plannedRoutePoints count]-1) {
                
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
        
        
        for (int i=(int)[self.result.plannedRoutePoints count]-1; i>-1; i--) {
            
            //CLLocation *location = [self.points objectAtIndex:i];
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.result.plannedRoutePoints objectAtIndex:i]];
            
            
            
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
        
        for (int i=0; i<[self.result.plannedRoutePoints count]; i++) {
            
            //CLLocation *location = [self.points objectAtIndex:i];
            CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.result.plannedRoutePoints objectAtIndex:i]];
            
            
            
            [path addCoordinate:location.coordinate];
            
            GMSMarker *australiaMarker = [[GMSMarker alloc] init];
            //australiaMarker.title = @"title";
            australiaMarker.position = location.coordinate;
            australiaMarker.appearAnimation = kGMSMarkerAnimationNone;
            
            
            australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_pt2"];
            
            if (i==0) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_start"];
            }
            
            if ([self.result.plannedRoutePoints count]>1&&i==[self.result.plannedRoutePoints count]-1) {
                
                australiaMarker.icon = [UIImage imageNamed:@"hr_map_icon_end"];
            }
            
            australiaMarker.map = _mapView;
            
            if (i==[self.result.plannedRoutePoints count]-1) {
                
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

    for (int i=0; i<[self.result.trackPoints count]; i++) {
        
        
        CLLocation* location = [NSKeyedUnarchiver unarchiveObjectWithData:[self.result.trackPoints objectAtIndex:i]];

        
        [self.path addCoordinate:location.coordinate];
        
        
        if (i==[self.result.trackPoints count]-1) {
            
            self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                                 zoom:15];
            
            //NSLog(@"come to camera 4");
            
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)shuoming:(id)sender
{
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

-(IBAction)tryleftTree:(id)sender
{
    if ([whatTheTree.text isEqualToString:@"Orange tree"]||[whatTheTree.text isEqualToString:@"橙樹"])
    {
        whatTheTree.text=[Utility getStringByKey:@"Lemon tree"];
        theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr1];
        smarttreeImageView.image=theBigTreeImage;
//        if ([plantNametextField.text isEqualToString:@"Lemon tree"]||[plantNametextField.text isEqualToString:@"檸檬樹"]||[plantNametextField.text isEqualToString:@"Tomato tree"]||[plantNametextField.text isEqualToString:@"蕃茄樹"]||[plantNametextField.text isEqualToString:@"Orange tree"]||[plantNametextField.text isEqualToString:@"橙樹"])
//        [plantNametextField setText:[Utility getStringByKey:@"Lemon tree"]];

        
    }
    else if ([whatTheTree.text isEqualToString:@"Tomato tree"]||[whatTheTree.text isEqualToString:@"蕃茄樹"]) {
        whatTheTree.text=[Utility getStringByKey:@"Orange tree"];
        theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr1];
        smarttreeImageView.image=theBigTreeImage;
        
//        if ([plantNametextField.text isEqualToString:@"Lemon tree"]||[plantNametextField.text isEqualToString:@"檸檬樹"]||[plantNametextField.text isEqualToString:@"Tomato tree"]||[plantNametextField.text isEqualToString:@"蕃茄樹"]||[plantNametextField.text isEqualToString:@"Orange tree"]||[plantNametextField.text isEqualToString:@"橙樹"])
//        [plantNametextField setText:[Utility getStringByKey:@"Orange tree"]];

    }
    else if ([whatTheTree.text isEqualToString:@"Lemon tree"]||[whatTheTree.text isEqualToString:@"檸檬樹"]) {
        whatTheTree.text=[Utility getStringByKey:@"Tomato tree"];
        theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr1];
        smarttreeImageView.image=theBigTreeImage;
        
        
//        if ([plantNametextField.text isEqualToString:@"Lemon tree"]||[plantNametextField.text isEqualToString:@"檸檬樹"]||[plantNametextField.text isEqualToString:@"Tomato tree"]||[plantNametextField.text isEqualToString:@"蕃茄樹"]||[plantNametextField.text isEqualToString:@"Orange tree"]||[plantNametextField.text isEqualToString:@"橙樹"])
//        [plantNametextField setText:[Utility getStringByKey:@"Tomato tree"]];

    }

}
- (void)leaveEditMode
{
    [plantNametextField resignFirstResponder];
    
}
-(IBAction)tryRightTree:(id)sende;
{
    if ([whatTheTree.text isEqualToString:@"Tomato tree"]||[whatTheTree.text isEqualToString:@"蕃茄樹"])
    {
         whatTheTree.text=[Utility getStringByKey:@"Lemon tree"];
        theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:lemonTreeImageStr1];
        smarttreeImageView.image=theBigTreeImage;
        
//        if ([plantNametextField.text isEqualToString:@"Lemon tree"]||[plantNametextField.text isEqualToString:@"檸檬樹"]||[plantNametextField.text isEqualToString:@"Tomato tree"]||[plantNametextField.text isEqualToString:@"蕃茄樹"]||[plantNametextField.text isEqualToString:@"Orange tree"]||[plantNametextField.text isEqualToString:@"橙樹"])
//        [plantNametextField setText:[Utility getStringByKey:@"Lemon tree"]];

        
    }
    else if ([whatTheTree.text isEqualToString:@"Lemon tree"]||[whatTheTree.text isEqualToString:@"檸檬樹"]) {
         whatTheTree.text=[Utility getStringByKey:@"Orange tree"];
        theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:orangeTreeImageStr1];
        smarttreeImageView.image=theBigTreeImage;
        
//        if ([plantNametextField.text isEqualToString:@"Lemon tree"]||[plantNametextField.text isEqualToString:@"檸檬樹"]||[plantNametextField.text isEqualToString:@"Tomato tree"]||[plantNametextField.text isEqualToString:@"蕃茄樹"]||[plantNametextField.text isEqualToString:@"Orange tree"]||[plantNametextField.text isEqualToString:@"橙樹"])
//        [plantNametextField setText:[Utility getStringByKey:@"Orange tree"]];

    }
    else if ([whatTheTree.text isEqualToString:@"Orange tree"]||[whatTheTree.text isEqualToString:@"橙樹"]) {
        whatTheTree.text=[Utility getStringByKey:@"Tomato tree"];
        theBigTreeImage=[[UIImage alloc]initWithContentsOfFile:tomatoTreeImageStr1];
        smarttreeImageView.image=theBigTreeImage;
        
//        if ([plantNametextField.text isEqualToString:@"Lemon tree"]||[plantNametextField.text isEqualToString:@"檸檬樹"]||[plantNametextField.text isEqualToString:@"Tomato tree"]||[plantNametextField.text isEqualToString:@"蕃茄樹"]||[plantNametextField.text isEqualToString:@"Orange tree"]||[plantNametextField.text isEqualToString:@"橙樹"])
//        [plantNametextField setText:[Utility getStringByKey:@"Tomato tree"]];

    }

}
-(IBAction) resultOkBtn :(id)sender
{
    
   

    if([self.isCOK isEqualToString:@"1"]&&(plantNametextField.text==nil||[plantNametextField.text isEqualToString:@""]))
    {
//        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"pless intput the flower name"];
        
        
        if ([whatTheTree.text isEqualToString:@"Tomato tree"]||[whatTheTree.text isEqualToString:@"蕃茄樹"])
        {
            [plantNametextField setText:[Utility getStringByKey:@"Tomato tree"]];
        }
        else if ([whatTheTree.text isEqualToString:@"Lemon tree"]||[whatTheTree.text isEqualToString:@"檸檬樹"]) {
            [plantNametextField setText:[Utility getStringByKey:@"Lemon tree"]];
        }
        else if ([whatTheTree.text isEqualToString:@"Orange tree"]||[whatTheTree.text isEqualToString:@"橙樹"]) {
            [plantNametextField setText:[Utility getStringByKey:@"Orange tree"]];
        }

        
        
        
    }
    
        
        
    GameObject *cwGameObject=[DBHelper getPlantProgress];
    
    NSString *cwProgress=[cwGameObject progress];
    int cwProgressINT=[cwProgress intValue];
    if (cwProgressINT>0)//old RP.progress>0
    {
        
     

        
        
        
        
    }
    else //old RP.progress=0
    {
        //Chick C
        
        if ([self.isCOK isEqualToString:@"1"])
        {
            //C ok
            
        
                
            NSString *theType;
            if ([whatTheTree.text isEqualToString:@"Tomato tree"]||[whatTheTree.text isEqualToString:@"蕃茄樹"])
            {
                theType=@"T";
            }
            else if ([whatTheTree.text isEqualToString:@"Lemon tree"]||[whatTheTree.text isEqualToString:@"檸檬樹"]) {
                theType=@"L";
            }
            else if ([whatTheTree.text isEqualToString:@"Orange tree"]||[whatTheTree.text isEqualToString:@"橙樹"]) {
                theType=@"O";
            }
            
            
            NSString * str1  =plantNametextField.text ;
            
            
            
            NSString *session_id = [GlobalVariables shareInstance].session_id;
            NSString *login_id = [GlobalVariables shareInstance].login_id;
            
            
            if(session_id==NULL||login_id==NULL){
                NSLog(@"I'm frist time");
                
                GameObject *resulttt=[[GameObject alloc] init];
                
             
                resulttt.plantName=plantNametextField.text;
                resulttt.plantType=theType;
                resulttt.gameType=@"WalkPlanyt";
                resulttt.status=@"0";
                   resulttt.progress=@"1";
                [resulttt setEndDate:[[NSDate date]timeIntervalSince1970]];
          
                [DBHelper addPlant:resulttt];
                NSLog(@"");
                
                
                result.steps=[DBHelper encryptionString:result.steps];
                result.distance=[DBHelper encryptionString:result.distance];
                result.calsburnt=[DBHelper encryptionString:result.calsburnt];
                result.persistimeStr=[DBHelper encryptionString:result.persistimeStr];
                
                
            [DBHelper addWalkingRecord:result];
                
            }
            else
            {
                [SyncGame startGame:str1 recordId:theType];
                [SyncWalking addWalkingRcord:result];
                [SyncGame updatePlantTryNow];
                [SyncGame getPlantProgress];
                
                
            }
            
            
            
            
            
        }
        else
        {
            
            //C not
            
            
        }
        
        
        
        
        
        
    }
    
    
    
//    NSString *session_id = [GlobalVariables shareInstance].session_id;
//    NSString *login_id = [GlobalVariables shareInstance].login_id;
//    if(session_id==NULL||login_id==NULL){
//        FirstWalkResultViewController *historyView = [[FirstWalkResultViewController alloc] initWithNibName:@"FirstWalkResultViewController" bundle:nil];
//        [self.navigationController pushViewController:historyView animated:YES ];
//        
//    }
//    else{
        if([_lastActivity isEqualToString:@"Pedometer"])
        {
            NSLog(@"%@.....check _lastActivity :",_lastActivity);
            NSInteger index=[[self.navigationController viewControllers] indexOfObject:self];
            [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: index-2] animated:YES];
            
//            WalkForHealthViewController *wfhView = [[WalkForHealthViewController alloc] initWithNibName:@"WalkForHealthViewController" bundle:nil];
//            GameObject *gameOBjectCW= [DBHelper getPlantProgress];
//            
//            GameObject *gameOBjectTP=  [DBHelper getTrophyProgress];
//            NSLog(@"~~~~~~~~~~~~~~~~~~");
//            NSLog(@"cw.gameObject==%@",gameOBjectCW);
//            NSLog(@"cw.gametype==%@",gameOBjectCW.gameType);
//            NSLog(@"cw.plantType==%@",gameOBjectCW.plantType);
//            NSLog(@"cw.plantname==%@",gameOBjectCW.plantName);
//            NSLog(@"cw.progress==%@",gameOBjectCW.progress);
//            NSLog(@"cw.status==%@",gameOBjectCW.status);
//            NSLog(@"~~~~~~~~~~~~~~~~~~");
//            NSString * str1=gameOBjectCW.gameType;
//            if (str1==NULL) {
//                str1=@"";
//            }
//            
//            NSString *str2=gameOBjectCW.plantType;
//            if (str2==NULL) {
//                str2=@"";
//            }
//            NSString *str3=gameOBjectCW.plantName;
//            if (str3==NULL) {
//                str3=@"";
//            }
//            NSString*str4=gameOBjectCW.progress;
//            if (str4==NULL) {
//                str4=@"";
//            }
//            NSString *str5=gameOBjectCW.status;
//            if (str5==NULL) {
//                str5=@"";
//            }
//            NSLog(@"%@,%@,%@,%@,%@",str5,str4,str3,str2,str1);
//            self.dicCW=[NSDictionary dictionaryWithObjectsAndKeys:
//                        str1,@"gameType",
//                        str2,@"plantType",
//                        str3,@"plantName",
//                        str4,@"progress",
//                        str5,@"status",
//                        nil];
//            
//            NSLog(@"self.dicCW==%@",self.dicCW);
//            
//            NSLog(@"~~~~~~~~~~~~~~~~~~");
//            NSLog(@"tp.gameObject==%@",gameOBjectTP);
//            NSLog(@"tp.gametype==%@",gameOBjectTP.gameType);
//            NSLog(@"tp.plantType==%@",gameOBjectTP.plantType);
//            NSLog(@"tp.plantname==%@",gameOBjectTP.plantName);
//            NSLog(@"tp.progress==%@",gameOBjectTP.progress);
//            NSLog(@"tp.status==%@",gameOBjectTP.status);
//            NSLog(@"~~~~~~~~~~~~~~~~~~");
//            
//            NSString * tstr1=gameOBjectTP.gameType;
//            if (tstr1==NULL) {
//                tstr1=@"";
//            }
//            
//            NSString *tstr2=gameOBjectTP.plantType;
//            if (tstr2==NULL) {
//                tstr2=@"";
//            }
//            NSString *tstr3=gameOBjectTP.plantName;
//            if (tstr3==NULL) {
//                tstr3=@"";
//            }
//            NSString*tstr4=gameOBjectTP.progress;
//            if (tstr4==NULL) {
//                tstr4=@"";
//            }
//            NSString *tstr5=gameOBjectTP.status;
//            if (tstr5==NULL) {
//                tstr5=@"";
//            }
//            NSLog(@"%@,%@,%@,%@,%@",tstr5,tstr4,tstr3,tstr2,tstr1);
//            self.dicTP=[NSDictionary dictionaryWithObjectsAndKeys:
//                        tstr1,@"gameType",
//                        tstr2,@"plantType",
//                        tstr3,@"plantName",
//                        tstr4,@"progress",
//                        tstr5,@"status",
//                        nil];
//            NSLog(@"self.dicTP==%@",self.dicTP);
//            wfhView.dicCW=[[NSMutableDictionary alloc] initWithDictionary:self.dicCW];
//            wfhView.dicTP=[[NSMutableDictionary alloc] initWithDictionary:self.dicTP];
//            
//            [self.navigationController pushViewController:wfhView animated:YES ];
//        
       }
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    
    
 //   }
    
}
-(IBAction)toshareFaceBook:(id)sender
{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    
    if (self.theShareStrRoad==nil) {
        self.theShareStrRoad=@"";
    }
    
    if(session_id!=NULL&&login_id!=NULL)
    {
        
        //[SyncGame shareCW:self.theShareStrRoad];
        
        
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *distanceStr=[defaults objectForKey:@"__distance"];
        NSString *stepsStr=[defaults objectForKey:@"__steps"];
        NSString *calsStr=[defaults objectForKey:@"__cals"];
        
        
        [defaults synchronize];
        
        GameObject *gameObjCheck=[DBHelper getPlantProgress];
        
        
        
        self.theShareStrRoad=[SyncGame shareFristTimethePlantName:gameObjCheck.plantName theType:gameObjCheck.plantType theSteps:stepsStr thecalories:calsStr theDistance:distanceStr];
        
        
        //[SyncGame shareCW:self.theShareStrRoad];
        
    }
    //NSLog(@"%@",sender);
    
    NSString *contStr=[Constants getAPIBase1];
    
    
    NSString* keyStr=[self.theShareStrRoad  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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

-(BOOL)shouldAutorotate {
    
    return NO;
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations{
#else
    - (UIInterfaceOrientationMask)supportedInterfaceOrientations{
#endif
    return UIInterfaceOrientationMaskPortrait;
    
}

#define NMUBERS @"./*-+~!@#$%^&()_+-=,./;'[]{}:<>?`"
//限制文本框输入
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    //int checkLength=[self getToInt:plantNametextField.text]+[self getToInt:string];
    //NSLog(@"字節長:%d",checkLength);
    
    
    
    //    strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding
    
//    if(checkLength >=15&&![string isEqualToString:@""]){
    
    if (plantNametextField.text.length >=15&&![string isEqualToString:@""]) {
        
        
        
        if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
            [self.view makeToast:@"-你棵植物嘅名字可以由中文、 英文及/或數字組成\n-最多可包含15位字元"
                        duration:3.0
             //                        position:[NSValue valueWithCGPoint:CGPointMake(0, 50)]];
                        position:CSToastPositionTop];
        } else {
            [self.view makeToast:@"-Your plant name can be a combination of Chinese, English and/or numbers\n-It can contain a max. of 15 characters"
                        duration:3.0
             //                        position:[NSValue valueWithCGPoint:CGPointMake(0, 50)]];
                        position:CSToastPositionTop];
        }
        
        return NO;
    }
    
    //只能输入英文或中文
    NSCharacterSet * charact;
    charact = [[NSCharacterSet characterSetWithCharactersInString:NMUBERS]invertedSet];
    
    NSString * filtered = [[string componentsSeparatedByCharactersInSet:charact]componentsJoinedByString:@""];
    
    NSLog(@"stringstringstring:%@",string);
    NSLog(@"filteredfilteredfiltered:%@",filtered);
    
    
    BOOL canChange = [string isEqualToString:filtered]&&![string isEqualToString:@""];
    if(canChange) {
        if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
            [self.view makeToast:@"-你棵植物嘅名字可以由中文、 英文及/或數字組成\n-最多可包含15位字元"
                        duration:3.0
             //                        position:[NSValue valueWithCGPoint:CGPointMake(0, 50)]];
                        position:CSToastPositionTop];
        } else {
            [self.view makeToast:@"-Your plant name can be a combination of Chinese, English and/or numbers\n-It can contain a max. of 15 characters"
                        duration:3.0
             //                        position:[NSValue valueWithCGPoint:CGPointMake(0, 50)]];
                        position:CSToastPositionTop];
        }
        
        return NO;
        
    }
    
    return YES;
}

- (int)getToInt:(NSString*)strtemp

{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return (int)[da length];
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"run here");
    
    CGPoint contentOffset = scrollView.contentOffset;
    if(contentOffset.y<=100)
        [scrollView setContentOffset:CGPointMake( 0,  100) animated:YES];
}




- (NSInteger)binarySearchForFontSizeForLabel:(UILabel *)label withMinFontSize:(NSInteger)minFontSize withMaxFontSize:(NSInteger)maxFontSize withSize:(CGSize)size {
    // If the sizes are incorrect, return 0, or error, or an assertion.
    if (maxFontSize < minFontSize) {
        return 0;
    }
    
    
    // Find the middle
    NSInteger fontSize = (minFontSize + maxFontSize) / 2;
    // Create the font
    UIFont *font = [UIFont fontWithName:label.font.fontName size:fontSize];
    // Create a constraint size with max height
    CGSize constraintSize = CGSizeMake(size.width, MAXFLOAT);
    // Find label size for current font size
    CGRect rect = [label.text boundingRectWithSize:constraintSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : font}
                                           context:nil];
    CGSize labelSize = rect.size;
    
    // EDIT:  The next block is modified from the original answer posted in SO to consider the width in the decision. This works much better for certain labels that are too thin and were giving bad results.
    if (labelSize.height >= (size.height + 10) && labelSize.width >= (size.width + 10) && labelSize.height <= (size.height) && labelSize.width <= (size.width)) {
        return fontSize;
    } else if (labelSize.height > size.height || labelSize.width > size.width) {
        return [self binarySearchForFontSizeForLabel:label withMinFontSize:minFontSize withMaxFontSize:fontSize - 1 withSize:size];
    } else {
        return [self binarySearchForFontSizeForLabel:label withMinFontSize:fontSize + 1 withMaxFontSize:maxFontSize withSize:size];
    }
}

- (void)sizeBinaryLabel:(UILabel *)label toRect:(CGRect)labelRect {
    
    // Set the frame of the label to the targeted rectangle
    label.frame = labelRect;
    
    // Try all font sizes from largest to smallest font
    int maxFontSize = 50;
    int minFontSize = 1;
    
    NSInteger size = [self binarySearchForFontSizeForLabel:label withMinFontSize:minFontSize withMaxFontSize:maxFontSize withSize:label.frame.size];
    
    label.font = [UIFont fontWithName:label.font.fontName size:size];
    
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
        //NSLog(@"adjust font size.....%d",fontSize);
        // Done, if created label is within target size
        if( labelSize.height <= label.frame.size.height )
            break;
        
        // Decrease the font size and try again
        fontSize -= 2;
        
    } while (fontSize > minFontSize);
}




@end
