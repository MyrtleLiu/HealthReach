//
//  InterfaceController.m
//  mHealth WatchKit Extension
//
//  Created by smartone_sn on 15/7/23.
//
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController


@synthesize loginView,groupView1,groupView2;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.smartone.healthreach"];
    
    NSString *isLogin=[sharedDefaults objectForKey:@"isLogin"];

    if ([isLogin isEqualToString:@"Y"]) {
        
        [loginView setHidden:YES];
        [groupView1 setHidden:NO];
        [groupView2 setHidden:NO];
        
    }else{
        
        [loginView setHidden:NO];
        [groupView1 setHidden:YES];
        [groupView2 setHidden:YES];
    }
    
    
    [loginView setHidden:YES];
    [groupView1 setHidden:NO];
    [groupView2 setHidden:NO];


}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



