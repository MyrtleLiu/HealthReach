//
//  PedometerController.m
//  mHealth
//
//  Created by smartone_sn2 on 15/8/5.
//
//

#import "PedometerController.h"



@implementation PedometerController

@synthesize fitPedometer;
@synthesize distanceLabel,distanceValueLabel,stepsLabel,stepsValueLabel,paceLabel,paceValueLabel,calsLabel,calsValueLabel,timeLabel;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
     _steps=@"0";
    
    if (self.fitPedometer==nil) {
        
        self.fitPedometer= [[FITPedometer alloc] init];
        
    }
    
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
    
    NSString *isRuning=[sharedDefaults objectForKey:@"isRuning"];
    
    NSLog(@"ge isruning.....%@========",isRuning);
    
    if(distanceValueLabel)NSLog(@"distance....");
    if(stepsValueLabel)NSLog(@"steps....");
    if(paceValueLabel)NSLog(@"pace.....");
    if(calsValueLabel)NSLog(@"cals....");
    
    
    if(isRuning&&[isRuning isEqualToString:@"Y"]){
        
        NSString *stepsStr=[sharedDefaults objectForKey:@"runing_steps"];
        
        self.steps=stepsStr;
        
        NSString *startTimeStr=[sharedDefaults objectForKey:@"runing_start_time"];
        
        NSDate *startTime=[[NSDate alloc] initWithTimeIntervalSince1970:[startTimeStr intValue]];
        
        self.startBtnTitle=@"stop";
        
        _startTime=startTime;
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateTime=[formatter stringFromDate:_startTime];
        NSLog(@"Data here is:%@",dateTime);
        
        
        if (self.clockTimer) {
            
            [self.clockTimer invalidate];
            
            self.clockTimer = nil;
            
        }
        
        self.clockTimer = [NSTimer timerWithTimeInterval:1    //timer 1秒一次
                                                  target:self
                                                selector:@selector(clockDidTick:)
                                                userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.clockTimer forMode:NSRunLoopCommonModes]; //無限循環
        
        
        self.fitPedometer.startDate=_startTime;
        
        
        __weak typeof (self) weakSelf = self;
        
        [self.fitPedometer startWithDidUpdateBlock:^(FITPedometerData *pedometerData) {
            __strong typeof (self) strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                NSString *stepsString = [@([pedometerData.numberOfStepsDelta integerValue]+[strongSelf.steps integerValue]) stringValue];
                
                strongSelf.steps=stepsString;
                
                
                
            });
        }];
        
        [self clockDidTick:self.clockTimer];
        
    }else{
        
        self.startBtnTitle=@"start";
        
        [self.fitPedometer stop];
        
        if (self.clockTimer) {
            
            [self.clockTimer invalidate];
           
            self.clockTimer = nil;
            
        }
        
        [self.timeLabel setText:@"00:00:00"];
    }

    [_startBtn setTitle:self.startBtnTitle];

    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    
    [super didDeactivate];
}


//-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier{
//    
//    
//    //NSLog(@"the context..222..%@",segueIdentifier);
//    
//    return @"casual_walk";
//    
////    return [super contextForSegueWithIdentifier:segueIdentifier];
//    
//}





-(IBAction)startRun:(id)sender{
    
    
    if (self.startBtnTitle==nil) {
        
        self.startBtnTitle=@"start";
        
        
    }
        
        if ([self.startBtnTitle isEqualToString:@"start"]) {
            
            
            
            self.startBtnTitle=@"stop";
            
            //*********當前時間************
            _startTime=[NSDate date];
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateTime=[formatter stringFromDate:_startTime];
            NSLog(@"Data here is:%@",dateTime);
            //******************************
            
            //    self.startTime = CFAbsoluteTimeGetCurrent();
            self.clockTimer = [NSTimer timerWithTimeInterval:1    //timer 1秒一次
                                                      target:self
                                                    selector:@selector(clockDidTick:)
                                                    userInfo:nil repeats:YES];
            
            [[NSRunLoop mainRunLoop] addTimer:self.clockTimer forMode:NSRunLoopCommonModes]; //無限循環
            
            
            NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
            
            [sharedDefaults setObject:@"Y" forKey:@"isRuning"];
            
            [sharedDefaults setObject:self.steps forKey:@"runing_steps"];
            
            [sharedDefaults setObject:[NSString stringWithFormat:@"%f",[_startTime timeIntervalSince1970]] forKey:@"runing_start_time"];
            
            [sharedDefaults synchronize];
            
            self.fitPedometer.startDate=_startTime;
            
            
            __weak typeof (self) weakSelf = self;
            
            [self.fitPedometer startWithDidUpdateBlock:^(FITPedometerData *pedometerData) {
                __strong typeof (self) strongSelf = weakSelf;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSString *stepsString = [@([pedometerData.numberOfStepsDelta integerValue]+[strongSelf.steps integerValue]) stringValue];
                    
                    strongSelf.steps=stepsString;
 
                    
                    
                });
            }];
            
        }else{
            
            self.startBtnTitle=@"start";
            
            [self.fitPedometer stop];
            
            if (self.clockTimer) {
                
                [self.clockTimer invalidate];
                
                self.clockTimer = nil;
                
                 NSLog(@"stop clockTimer........");
            }
            
            [self.timeLabel setText:@"00:00:00"];
            
            NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
            
            [sharedDefaults setObject:nil forKey:@"isRuning"];
            
            [sharedDefaults setObject:@"" forKey:@"runing_steps"];
            
            [sharedDefaults setObject:@"" forKey:@"runing_start_time"];
            
            [sharedDefaults synchronize];
            
            NSLog(@"stop walking........");
            
            NSString *isRuning=[sharedDefaults objectForKey:@"isRuning"];
            
            NSLog(@"ge isruning.....%@========",isRuning);
        }
        
        
    
    
    [_startBtn setTitle:self.startBtnTitle];
    
    

    
    
    
    
    
}




- (void)clockDidTick:(NSTimer *)timer {
    



   
    
//    
//    [WKInterfaceController openParentApplication:@{@"type":@"casual_walk",@"start":_startTime,@"steps":_steps} reply:^(NSDictionary *replyInfo, NSError *error) {
//        
//        if (!error && replyInfo) {
//            NSString *steps=[replyInfo objectForKey:@"steps"];
//            NSLog(@"reply the correct respond step:%@",steps);
//            _steps=steps;
//            //            NSString *whetherLogin = [replyInfo objectForKey:@"isLogin"];
//            //            if (![whetherLogin isEqualToString:@"Y"]) {
//            //
//            //                NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
//            //                [self presentControllerWithName:@"InterfaceController" context:contextDic];
//            //
//            //                return;
//            //            }
//            //
//            //            if ([currentType isEqualToString:@"bp"]) {
//            //
//            //                NSString *sys=[replyInfo objectForKey:@"sys"];
//            //                NSString *dia=[replyInfo objectForKey:@"dia"];
//            //                NSString *hr=[replyInfo objectForKey:@"hr"];
//            //                NSString *dateStr=[replyInfo objectForKey:@"date"];
//            //
//            //                [bp_sys_Label setText:sys];
//            //                [bp_dia_Label setText:dia];
//            //                [bp_hr_Label setText:hr];
//            //                [bp_time_Label setText:dateStr];
//            //
//            //            }else if ([currentType isEqualToString:@"bg"]){
//            //
//            //                NSString *bg=[replyInfo objectForKey:@"bg"];
//            //                NSString *type=[replyInfo objectForKey:@"type"];
//            //                NSString *dateStr=[replyInfo objectForKey:@"date"];
//            //
//            //                [bg_value_Label setText:bg];
//            //                [bg_type_Label setText:type];
//            //                [bg_time_Label setText:dateStr];
//            //
//            //            }else if ([currentType isEqualToString:@"weight"]){
//            //
//            //                NSString *weight=[replyInfo objectForKey:@"weight"];
//            //                NSString *bmi=[replyInfo objectForKey:@"bmi"];
//            //                NSString *dateStr=[replyInfo objectForKey:@"date"];
//            //
//            //                [weight_value_Label setText:weight];
//            //                [weight_bmi_Label setText:bmi];
//            //                [weight_time_Label setText:dateStr];
//            //
//            //            }else if ([currentType isEqualToString:@"cal"]){
//            //
//            //                NSString *cal_value=[replyInfo objectForKey:@"cal_value"];
//            //                NSString *dateStr=[replyInfo objectForKey:@"date"];
//            //                
//            //                [cal_value_Label setText:cal_value];
//            //                [cal_time_Label setText:dateStr];
//            //            }
//            
//            
//            
//        }else
//        {
//            NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
//            [self presentControllerWithName:@"InterfaceController" context:contextDic];
//        }
//    }];

    
    double currentTime = [[NSDate date] timeIntervalSince1970];
    
    
    double elapsedTime = currentTime - [self.startTime timeIntervalSince1970];//+self.timePre;

    NSString *timeString=[self formatTheTime:elapsedTime*1000];

    [self.timeLabel setText:[NSString stringWithFormat:@"%@",timeString]];
    
    if(self.stepsValueLabel){
        
        
        [self.stepsValueLabel setText:[NSString stringWithFormat:@"%@",self.steps]];
        
    }
    
    if (self.distanceValueLabel) {
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
        
        NSString *userHeight=[sharedDefaults objectForKey:@"user_height"];
        
        
        float dis=(0.414*([userHeight floatValue]/100)*[self.steps doubleValue])/1000;
        
        [self.distanceValueLabel setText:[NSString stringWithFormat:@"%.03f",dis]];
        
    }
    
    if (self.paceValueLabel) {
        
        
        int pace_value=[self.steps integerValue]/(elapsedTime/60);
        
        [self.paceValueLabel setText:[NSString stringWithFormat:@"%d",pace_value]];
        
    }

    if (self.calsValueLabel) {
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
        
        NSString *userHeight=[sharedDefaults objectForKey:@"user_height"];
        NSString *userWeight=[sharedDefaults objectForKey:@"user_weight"];
        NSString *userAge=[sharedDefaults objectForKey:@"user_age"];
        NSString *userGender=[sharedDefaults objectForKey:@"user_gender"];
        
        float weight=[userWeight floatValue];//get weight,unit is kg;
        float height=[userHeight floatValue];//get height,unit is cm;
        float age=[userAge integerValue];//get age;
        
        
        BOOL isMale=[userGender isEqualToString:@"M"];
        
        float bmr=0;
        
        if(isMale){
            
            bmr=(float) (((13.75*weight)+(5*height)-(6.76*age)+66)/24);
            
        }else{
            
            bmr=(float) (((9.56*weight)+(1.85*height)-(4.68*age)+655)/24);
        }
        
        float pace_value=[self.steps floatValue]/(elapsedTime/60.0f);
        
        float speed=(float) (pace_value*0.414*height/100);
        float vo2=(float) (0.1*speed+3.5);
        float met=(float) (vo2/3.5);
        
        //cals=(int)(duration*bmr*met/60)+"";
//        NSLog(@"duration:%f",(elapsedTime/60.0f));
//        NSLog(@"bmr:%f",bmr);
//        NSLog(@"met:%f",met);
        
        int calValue=(int) ((elapsedTime/60.0f)*bmr*met/60);
        
        [self.calsValueLabel setText:[NSString stringWithFormat:@"%d",calValue]];
    }
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
    
    //[sharedDefaults setObject:@"Y" forKey:@"isRuning"];
    
    [sharedDefaults setObject:self.steps forKey:@"runing_steps"];
    
    [sharedDefaults setObject:[NSString stringWithFormat:@"%f",[_startTime timeIntervalSince1970]] forKey:@"runing_start_time"];
    
    [sharedDefaults synchronize];
    
    [self performSelectorOnMainThread:@selector(updateTime:) withObject:timeString waitUntilDone:NO];
    
    
}

- (void)updateTime:(NSString *)timeString{
    
    //NSLog(@"updateTime.........%@",[NSString stringWithFormat:@"time:%@ step:%@",timeString,self.steps]);
    
    
    double currentTime = [[NSDate date] timeIntervalSince1970];
    
    
    double elapsedTime = currentTime - [self.startTime timeIntervalSince1970];//+self.timePre;
    
    [self.timeLabel setText:[NSString stringWithFormat:@"%@",timeString]];
    
    if(self.stepsValueLabel){
        
        
        [self.stepsValueLabel setText:[NSString stringWithFormat:@"%@",self.steps]];
        
    }
    
    if (self.distanceValueLabel) {
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
        
        NSString *userHeight=[sharedDefaults objectForKey:@"user_height"];
        
        
        float dis=(0.414*([userHeight floatValue]/100)*[self.steps doubleValue])/1000;
        
        [self.distanceValueLabel setText:[NSString stringWithFormat:@"%.03f",dis]];
        
    }
    
    if (self.distanceValueLabel) {
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
        
        NSString *userHeight=[sharedDefaults objectForKey:@"user_height"];
        
        
        float dis=(0.414*([userHeight floatValue]/100)*[self.steps doubleValue])/1000;
        
        [self.distanceValueLabel setText:[NSString stringWithFormat:@"%.03f",dis]];
        
    }
    
    if (self.paceValueLabel) {
        
        
        int pace_value=[self.steps integerValue]/(elapsedTime/60);
        
        [self.paceValueLabel setText:[NSString stringWithFormat:@"%d",pace_value]];
        
    }
    
    if (self.calsValueLabel) {
        
        NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
        
        NSString *userHeight=[sharedDefaults objectForKey:@"user_height"];
        NSString *userWeight=[sharedDefaults objectForKey:@"user_weight"];
        NSString *userAge=[sharedDefaults objectForKey:@"user_age"];
        NSString *userGender=[sharedDefaults objectForKey:@"user_gender"];
        
        float weight=[userWeight floatValue];//get weight,unit is kg;
        float height=[userHeight floatValue];//get height,unit is cm;
        float age=[userAge integerValue];//get age;
        
        
        BOOL isMale=[userGender isEqualToString:@"M"];
        
        float bmr=0;
        
        if(isMale){
            
            bmr=(float) (((13.75*weight)+(5*height)-(6.76*age)+66)/24);
            
        }else{
            
            bmr=(float) (((9.56*weight)+(1.85*height)-(4.68*age)+655)/24);
        }
        
        float pace_value=[self.steps floatValue]/(elapsedTime/60.0f);
        
        float speed=(float) (pace_value*0.414*height/100);
        float vo2=(float) (0.1*speed+3.5);
        float met=(float) (vo2/3.5);
        
        //cals=(int)(duration*bmr*met/60)+"";
//        NSLog(@"duration:%f",(elapsedTime/60.0f));
//        NSLog(@"bmr:%f",bmr);
//        NSLog(@"met:%f",met);
        
        int calValue=(int) ((elapsedTime/60.0f)*bmr*met/60);
        
        [self.calsValueLabel setText:[NSString stringWithFormat:@"%d",calValue]];
    }
    
}

-(NSString*)formatTheTime:(long)time{
    
    long elapsedSeconds=time/1000;
    long hours=0;
    long minutes=0;
    long seconds=0;
    
    if (elapsedSeconds>=3600) {
        
        hours=elapsedSeconds/3600;
        elapsedSeconds-=hours*3600;
    }
    
    if (elapsedSeconds>=60) {
        
        minutes=elapsedSeconds/60;
        
        elapsedSeconds-=minutes*60;
    }
    
    seconds=elapsedSeconds;
    
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours,minutes,seconds];
    
}


@end
