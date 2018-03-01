//
//  MeasureTitleCustomCell.m
//  mHealth
//
//  Created by gz dev team on 14年1月26日.
//
//

#import "MeasureTitleCustomCell.h"

@interface MeasureTitleCustomCell ()

@end

@implementation MeasureTitleCustomCell

@synthesize titleString;
@synthesize valueString;
@synthesize unitString;

@synthesize titleLabel;
@synthesize valueLabel;
@synthesize unitLabel;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

-(void)setValueString:(NSString *)valueStringInput{
    if (![valueStringInput isEqualToString:valueString]){
        valueString = [valueStringInput copy];
        [valueLabel setText:valueString];
    }
}

-(void)setTitleString:(NSString *)titleStringInput{
    if (![titleStringInput isEqualToString:titleString]){
        titleString = [titleStringInput copy];
        [titleLabel setText:titleString];
    }
}

-(void)setUnitString:(NSString *)unitStringInput{
    if (![unitStringInput isEqualToString:unitString]){
        unitString = [unitStringInput copy];
        [unitLabel setText:unitString];
    }
}

@end
