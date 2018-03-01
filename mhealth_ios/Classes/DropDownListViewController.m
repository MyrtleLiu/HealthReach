//
//  DropDownListViewController.m
//  mHealth
//
//  Created by sngz on 14-2-28.
//
//

#import "DropDownListViewController.h"

@interface DropDownListViewController ()

@end

@implementation DropDownListViewController

@synthesize buttonText;

-(void)setButtonText:(NSString *)newButtonText{
    if (![buttonText isEqual:newButtonText]){
        buttonText = [newButtonText copy];
        [self.TextButton setTitle:buttonText forState:normal];
    }
}

- (IBAction)showDropDownList:(id)sender {

}

@end