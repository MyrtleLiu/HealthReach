//
//  ChooseHistoryController.m
//  mHealth WatchKit Extension
//
//  Created by smartone_sn on 15/7/23.
//
//

#import "ChooseHistoryController.h"


@interface ChooseHistoryController()

@end


@implementation ChooseHistoryController


@synthesize bgUpdateLabel,bpUpdateLabel,weightUpdateLabel,calsUpdateLabel;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
    
    NSString *currentDate=[sharedDefaults objectForKey:@"data_update_date"];


    NSString *lang=[sharedDefaults objectForKey:@"lang"];
    
    NSString *updateText=@"  update date: ";

    if ([lang isEqualToString:@"cn"]){
       
        updateText=@"  更新日期: ";
        
    }

    [bgUpdateLabel setText:[NSString stringWithFormat:@"%@%@",updateText,currentDate]];
    [bpUpdateLabel setText:[NSString stringWithFormat:@"%@%@",updateText,currentDate]];
    [weightUpdateLabel setText:[NSString stringWithFormat:@"%@%@",updateText,currentDate]];
    [calsUpdateLabel setText:[NSString stringWithFormat:@"%@%@",updateText,currentDate]];
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier{
    
    
    //NSLog(@"the context..222..%@",segueIdentifier);
    
    if ([segueIdentifier isEqualToString:@"bp"]) {
        
         return @"bp";
        
        
    }else if ([segueIdentifier isEqualToString:@"bg"]){
        
        return @"bg";
        
        
    }else if ([segueIdentifier isEqualToString:@"weight"]){
        
        return @"weight";
        
        
    }else if ([segueIdentifier isEqualToString:@"cal"]){
        
        return @"cal";
        
    }
    
    
    
    
    return [super contextForSegueWithIdentifier:segueIdentifier];
    
}

@end



