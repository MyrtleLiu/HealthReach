//
//  CalsHistoryDetailCustomCell.m
//  mHealth
//
//  Created by smartone_sn3 on 9/2/14.
//
//

#import "CalsHistoryDetailCustomCell.h"
#import "Utility.h"

@interface CalsHistoryDetailCustomCell ()

@end

@implementation CalsHistoryDetailCustomCell

@synthesize foodIdNumber;
@synthesize foodNameString;
@synthesize foodQuantityString;
@synthesize foodCaloriesString;
@synthesize foodUnitString;
@synthesize foodImageView;

- (void)setFoodIdNumber:(NSNumber *)foodIdNumber_new {
    foodIdNumber = foodIdNumber_new;
    self.foodId = foodIdNumber;
}

- (void)setFoodNameString:(NSString *)foodNameString_new {
    foodNameString = [foodNameString_new copy];
    [self.foodNameLabel setText:foodNameString];
    [self.foodNameLabel setFont:[UIFont fontWithName:font57 size:17]];
}

- (void)setFoodQuantityString:(NSString *)foodQuantityString_new {
    foodQuantityString = [foodQuantityString_new copy];
    [self.foodQuantityNumberLabel setText:foodQuantityString];
    [self.foodQuantityBigNumberLabel setText:foodQuantityString];
    [self.foodQuantityUnitLabel setText:[Utility getStringByKey:@"total_calories_cal"]];
}

- (void)setFoodCaloriesString:(NSString *)foodCaloriesString_new {
    foodCaloriesString = [foodCaloriesString_new copy];
    [self.foodCaloriesNumberLabel setText:foodCaloriesString];
    [self.foodCaloriesUnitLabel setFont:[UIFont fontWithName:font65 size:11]];
}

- (void)setFoodUnitString:(NSString *)foodUnitString_new {
    foodUnitString = [foodUnitString_new copy];
    [self.foodCaloriesUnitLabel setText:foodUnitString];
    [self.foodCaloriesUnitLabel setFont:[UIFont fontWithName:font65 size:11]];
}

@end
