//
//  CaloriesCustomCell.m
//  mHealth
//
//  Created by evanli on 16/7/14.
//
//

#import "CaloriesCustomCell.h"
#import "GlobalVariables.h"
#import "NSNotificationCenter+MainThread.h"
#import "DBHelper.h"
#import "Utility.h"
#import "LearnMoreFirstViewController.h"

@interface CaloriesCustomCell ()

@end

@implementation CaloriesCustomCell

@synthesize foodCaloriesString;
@synthesize foodUnitString;
@synthesize foodQuantityString;
@synthesize foodNameString;
@synthesize foodImageString;
@synthesize foodIdNumber;
@synthesize foodQuantityLabel1;
@synthesize foodImageView;


//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}


- (void)setFoodIdNumber:(NSNumber *)foodIdNumber_new{
    foodIdNumber = foodIdNumber_new;
    self.foodId = foodIdNumber;
}

- (NSNumber *)getFoodIdNumber{
    return self.foodId;
}

-(void)setFoodCaloriesString:(NSString *)caloriesString{
    if (![caloriesString isEqual:foodCaloriesString]){
        foodCaloriesString = [caloriesString copy];
        self.foodCaloriesLabel.text = foodCaloriesString;
        [self.foodCaloriesLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:16]];
    }
}

-(void)setFoodUnitString:(NSString *)unitString{
    if (![unitString isEqual:foodUnitString]){
        foodUnitString = [unitString copy];
        self.foodUnitLabel.text = foodUnitString;
    }
    [self.foodUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:11]];
    [self.foodCalsUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:11]];
    [self.foodCalsUnitLabel setText:[Utility getStringByKey:@"total_calories_cal"]];
}

-(void)setFoodQuantityString:(NSString *)quantityString{
    if (![quantityString isEqual:foodQuantityString]){
        foodQuantityString = [quantityString copy];
        self.foodQuantityLabel1.text = foodQuantityString;
        self.foodQuantityLabel2.text = foodQuantityString;
    }
    [self.foodQuantityLabel2 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:16]];
    [self.foodQuantityLabel1 setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:20]];
    if ([foodQuantityString isEqualToString:@"0"])
        self.quantityBackgroundImageView.image = [UIImage imageNamed:@"08_cal_cal_p1_off.png"];
    else
        self.quantityBackgroundImageView.image = [UIImage imageNamed:@"08_cal_cal_p1_on.png"];
}

-(void)setFoodNameString:(NSString *)nameString{
    if (![nameString isEqual:foodNameString]){
        foodNameString = [nameString copy];
        self.foodNameLabel.text = foodNameString;
    }
    [self.foodNameLabel setFont:[UIFont fontWithName:font57 size:17]];
}

- (BOOL)checkQuantity{
    int quantityInt = [self.foodQuantityString intValue];
    if (0 == quantityInt) {
        self.quantityBackgroundImageView.image = [UIImage imageNamed:@"08_cal_cal_p1_off.png"];
        return TRUE;
    } else if (quantityInt < 0) {
        self.quantityBackgroundImageView.image = [UIImage imageNamed:@"08_cal_cal_p1_off.png"];
        self.foodQuantityString = @"0";
        return FALSE;
    } else if (quantityInt > 0) {
        self.quantityBackgroundImageView.image = [UIImage imageNamed:@"08_cal_cal_p1_on.png"];
        return TRUE;
    }
    return FALSE;
}

- (IBAction)quantityPlus:(id)sender {
    
    
    NSLog(@"quantityPlus1111111");
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        [[NSNotificationCenter defaultCenter]postMainThreadNotificationWithName:@"nologinid" object:nil];
    }
    else{
        
        NSString *foodQuantity_NSString = [NSString stringWithFormat:@"%d",[self.foodQuantityLabel1.text intValue]+1];
        self.foodQuantityString = foodQuantity_NSString;
        if ([self checkQuantity]) {
            [DBHelper changeFoodQuantityUpdateDB:self.foodId foodQuantity:[self.foodQuantityLabel1.text intValue]];
            int caloriesTotal = [[GlobalVariables shareInstance].caloriesTotal intValue];
            int foodCalories = [self.foodCaloriesLabel.text intValue];
            [GlobalVariables shareInstance].caloriesTotal = [NSString stringWithFormat:@"%d",(caloriesTotal + foodCalories)];
            
            [[NSNotificationCenter defaultCenter]postMainThreadNotificationWithName:@"refreshCaloriesTotal" object:nil];
            
            NSLog(@"quantityPlus");
            
        }

    }

    
    
    
    
    
    
    
}

- (IBAction)quantityMinus:(id)sender {
    NSString *foodQuantity_NSString = [NSString stringWithFormat:@"%d",[self.foodQuantityLabel1.text intValue]-1];
    self.foodQuantityString = foodQuantity_NSString;
    
    if ([self checkQuantity]) {
        [DBHelper changeFoodQuantityUpdateDB:self.foodId foodQuantity:[self.foodQuantityLabel1.text intValue]];
        int caloriesTotal = [[GlobalVariables shareInstance].caloriesTotal intValue];
        int foodCalories = [self.foodCaloriesLabel.text intValue];
        [GlobalVariables shareInstance].caloriesTotal = [NSString stringWithFormat:@"%d",(caloriesTotal - foodCalories)];
        
        [[NSNotificationCenter defaultCenter]postMainThreadNotificationWithName:@"refreshCaloriesTotal" object:nil];
    } else {
        self.foodQuantityString = @"0";
    }
    
}


@end