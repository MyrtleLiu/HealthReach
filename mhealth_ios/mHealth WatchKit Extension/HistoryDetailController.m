//
//  ChooseHistoryController.m
//  mHealth WatchKit Extension
//
//  Created by smartone_sn on 15/7/23.
//
//

#import "HistoryDetailController.h"


@interface HistoryDetailController()

@end


@implementation HistoryDetailController


@synthesize btn7d,btn14d,btn1m,btn3m;
@synthesize bgGroup,bpGroup,weightGroup,calGroup;
@synthesize chartImg;
@synthesize bg_time_Label,bg_type_Label,bg_value_Label;
@synthesize bp_dia_Label,bp_hr_Label,bp_sys_Label,bp_time_Label;
@synthesize weight_bmi_Label,weight_time_Label,weight_value_Label;
@synthesize cal_time_Label,cal_value_Label;


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    currentType=@"";
    
    //NSLog(@"the context....%@",context);
    
    if ([context isEqualToString:@"bp"]) {
        
        currentType=@"bp";
        
        
    }else if ([context isEqualToString:@"bg"]){
        
        currentType=@"bg";
        
        
    }else if ([context isEqualToString:@"weight"]){
        
        currentType=@"weight";
        
        
    }else if ([context isEqualToString:@"cal"]){
        
        currentType=@"cal";
        
    }

    
}



- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    if ([currentType isEqualToString:@"bp"]) {
 
        [bpGroup setHidden:NO];
        [bgGroup setHidden:YES];
        [weightGroup setHidden:YES];
        [calGroup setHidden:YES];
        
        //[chartImg setImageNamed:@"slide4_5"];
        
    }else if ([currentType isEqualToString:@"bg"]){

        
        [bpGroup setHidden:YES];
        [bgGroup setHidden:NO];
        [weightGroup setHidden:YES];
        [calGroup setHidden:YES];
        
        
        //[chartImg setImageNamed:@"slide4_9"];
        
    }else if ([currentType isEqualToString:@"weight"]){

        
        [bpGroup setHidden:YES];
        [bgGroup setHidden:YES];
        [weightGroup setHidden:NO];
        [calGroup setHidden:YES];
        
        //[chartImg setImageNamed:@"slide6_11"];
        
    }else if ([currentType isEqualToString:@"cal"]){

        
        [bpGroup setHidden:YES];
        [bgGroup setHidden:YES];
        [weightGroup setHidden:YES];
        [calGroup setHidden:NO];
        
        //[chartImg setImageNamed:@"slide5_5"];
    }

    [WKInterfaceController openParentApplication:@{@"type":[NSString stringWithFormat:@"chart_data_%@",currentType],@"period":@"7"} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        if (!error && replyInfo) {
            
            NSString *whetherLogin = [replyInfo objectForKey:@"isLogin"];
            if (![whetherLogin isEqualToString:@"Y"]) {
                
                NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
                [self presentControllerWithName:@"InterfaceController" context:contextDic];
                
                return;
            }
            
            
            NSString *imagedata=[replyInfo objectForKey:@"image_data"];
            
            NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:imagedata options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chartimage=[[UIImage alloc]initWithData:datetmp];
            
            [chartImg setImage:chartimage];
            
            
            
        }else
        {
            NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
            [self presentControllerWithName:@"InterfaceController" context:contextDic];
        }
    }];
    
    
    [WKInterfaceController openParentApplication:@{@"type":[NSString stringWithFormat:@"latest_record_%@",currentType]} reply:^(NSDictionary *replyInfo, NSError *error) {
        
                if (!error && replyInfo) {
                    
                    NSString *whetherLogin = [replyInfo objectForKey:@"isLogin"];
                    if (![whetherLogin isEqualToString:@"Y"]) {
                        
                        NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
                        [self presentControllerWithName:@"InterfaceController" context:contextDic];
                        
                        return;
                    }
                
                    if ([currentType isEqualToString:@"bp"]) {
                    
                        NSString *sys=[replyInfo objectForKey:@"sys"];
                        NSString *dia=[replyInfo objectForKey:@"dia"];
                        NSString *hr=[replyInfo objectForKey:@"hr"];
                        NSString *dateStr=[replyInfo objectForKey:@"date"];
                        
                        [bp_sys_Label setText:sys];
                        [bp_dia_Label setText:dia];
                        [bp_hr_Label setText:hr];
                        [bp_time_Label setText:dateStr];
                        
                    }else if ([currentType isEqualToString:@"bg"]){
                        
                        NSString *bg=[replyInfo objectForKey:@"bg"];
                        NSString *type=[replyInfo objectForKey:@"type"];
                        NSString *dateStr=[replyInfo objectForKey:@"date"];
                        
                        [bg_value_Label setText:bg];
                        [bg_type_Label setText:type];
                        [bg_time_Label setText:dateStr];
                        
                    }else if ([currentType isEqualToString:@"weight"]){
                        
                        NSString *weight=[replyInfo objectForKey:@"weight"];
                        NSString *bmi=[replyInfo objectForKey:@"bmi"];
                        NSString *dateStr=[replyInfo objectForKey:@"date"];
                        
                        [weight_value_Label setText:weight];
                        [weight_bmi_Label setText:bmi];
                        [weight_time_Label setText:dateStr];
                        
                    }else if ([currentType isEqualToString:@"cal"]){
                        
                        NSString *cal_value=[replyInfo objectForKey:@"cal_value"];
                        NSString *dateStr=[replyInfo objectForKey:@"date"];
                        
                        [cal_value_Label setText:cal_value];
                        [cal_time_Label setText:dateStr];
                    }
                    
                
                
                }else
                {
                    NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
                    [self presentControllerWithName:@"InterfaceController" context:contextDic];
                }
            }];
    

    

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(IBAction)change7dChart:(id)sender{
    
    [btn7d setBackgroundColor:[[UIColor alloc] initWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1.0f]];
    [btn14d setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    [btn1m setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    [btn3m setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    
    [WKInterfaceController openParentApplication:@{@"type":[NSString stringWithFormat:@"chart_data_%@",currentType],@"period":@"7"} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        if (!error && replyInfo) {
            
            NSString *whetherLogin = [replyInfo objectForKey:@"isLogin"];
            if (![whetherLogin isEqualToString:@"Y"]) {
                
                NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
                [self presentControllerWithName:@"InterfaceController" context:contextDic];
                
                return;
            }

            NSString *imagedata=[replyInfo objectForKey:@"image_data"];
            
            NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:imagedata options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chartimage=[[UIImage alloc]initWithData:datetmp];
            
            [chartImg setImage:chartimage];
            
            
        }else
        {
            NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
            [self presentControllerWithName:@"InterfaceController" context:contextDic];
        }
    }];
    
}
-(IBAction)change14dChart:(id)sender{
    
    [btn14d setBackgroundColor:[[UIColor alloc] initWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1.0]];
    [btn7d setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    [btn1m setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    [btn3m setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    
    [WKInterfaceController openParentApplication:@{@"type":[NSString stringWithFormat:@"chart_data_%@",currentType],@"period":@"14"} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        if (!error && replyInfo) {
            
            NSString *whetherLogin = [replyInfo objectForKey:@"isLogin"];
            if (![whetherLogin isEqualToString:@"Y"]) {
                
                NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
                [self presentControllerWithName:@"InterfaceController" context:contextDic];
                
                return;
            }
            
            NSString *imagedata=[replyInfo objectForKey:@"image_data"];
            
            NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:imagedata options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chartimage=[[UIImage alloc]initWithData:datetmp];
            
            [chartImg setImage:chartimage];
            
            
        }else
        {
            NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
            [self presentControllerWithName:@"InterfaceController" context:contextDic];
        }
    }];
    
}
-(IBAction)change1mChart:(id)sender{
    
    [btn1m setBackgroundColor:[[UIColor alloc] initWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1.0]];
    [btn14d setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    [btn7d setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    [btn3m setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    
    [WKInterfaceController openParentApplication:@{@"type":[NSString stringWithFormat:@"chart_data_%@",currentType],@"period":@"30"} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        if (!error && replyInfo) {
            
            NSString *whetherLogin = [replyInfo objectForKey:@"isLogin"];
            if (![whetherLogin isEqualToString:@"Y"]) {
                
                NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
                [self presentControllerWithName:@"InterfaceController" context:contextDic];
                
                return;
            }
            
            NSString *imagedata=[replyInfo objectForKey:@"image_data"];
            
            NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:imagedata options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chartimage=[[UIImage alloc]initWithData:datetmp];
            
            [chartImg setImage:chartimage];
            
            
        }else
        {
            NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
            [self presentControllerWithName:@"InterfaceController" context:contextDic];
        }
    }];
    
}
-(IBAction)change3mChart:(id)sender{
    
    
    [btn3m setBackgroundColor:[[UIColor alloc] initWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1.0]];
    [btn14d setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    [btn1m setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    [btn7d setBackgroundColor:[[UIColor alloc] initWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0]];
    
    [WKInterfaceController openParentApplication:@{@"type":[NSString stringWithFormat:@"chart_data_%@",currentType],@"period":@"90"} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        if (!error && replyInfo) {
            
            NSString *whetherLogin = [replyInfo objectForKey:@"isLogin"];
            if (![whetherLogin isEqualToString:@"Y"]) {
                
                NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
                [self presentControllerWithName:@"InterfaceController" context:contextDic];
                
                return;
            }
            
            NSString *imagedata=[replyInfo objectForKey:@"image_data"];
            
            NSData *datetmp=[[NSData alloc] initWithBase64EncodedString:imagedata options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *chartimage=[[UIImage alloc]initWithData:datetmp];
            
            [chartImg setImage:chartimage];
            
            
        }else
        {
            NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
            [self presentControllerWithName:@"InterfaceController" context:contextDic];
        }
    }];
    
}

@end



