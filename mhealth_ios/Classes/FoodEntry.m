//
//  FoodEntry.m
//  mHealth
//
//  Created by smartone_sn3 on 8/20/14.
//
//

#import "FoodEntry.h"

@implementation FoodEntry

@synthesize foodType,name_en,name_zh,number,quantityUnit_en,quantityUnit_zh,foodCalories,foodImageFileName,quantity;

-(id)initWithNumber:(NSNumber *)newNumber name_en:(NSString *)newName_en name_zh:(NSString *)newName_zh quantityUnit_en:(NSString *)newQuantityUnit_en quantityUnit_zh:(NSString *)newQuantityUnit_zh foodType:(NSString *)newFoodType foodCalories:(NSNumber *)newFoodCalories foodImageFileName:(NSString *)newFoodImageFileName quantity:(NSNumber *)newQuantity{

    if (self = [super init]) {
        number = newNumber;
        name_zh = newName_zh;
        name_en = newName_en;
        quantityUnit_zh = newQuantityUnit_zh;
        quantityUnit_en = newQuantityUnit_en;
        foodType = newFoodType;
        foodCalories = newFoodCalories;
        foodImageFileName = newFoodImageFileName;
        quantity = newQuantity;
    }
    
    return self;
}

-(NSNumber *)getNumber{
    return number;
}
-(void)setNumber:(NSNumber *)newNumber{
    self.number = newNumber;
}

-(NSString *)getName_zh{
    return name_zh;
}
-(void)setName_zh:(NSString *)newName_zh{
    self.name_zh = newName_zh;
}

-(NSString *)getName_en{
    return name_en;
}
-(void)setName_en:(NSString *)newName_en{
    self.name_en = newName_en;
}

-(NSString *)getQuantityUnit_zh{
    return quantityUnit_zh;
}
-(void)setQuantityUnit_zh:(NSString *)newQuantityUnit_zh{
    self.quantityUnit_zh = newQuantityUnit_zh;
}

-(NSString *)getQuantityUnit_en{
    return quantityUnit_en;
}
-(void)setQuantityUnit_en:(NSString *)newQuantityUnit_en{
    self.quantityUnit_en = newQuantityUnit_en;
}

-(NSString *)getFoodType{
    return foodType;
}
-(void)setFoodType:(NSString *)newFoodType{
    self.foodType = newFoodType;
}

-(NSNumber *)getFoodCalories{
    return foodCalories;
}
-(void)setFoodCalories:(NSNumber *)newFoodCalories{
    self.foodCalories = newFoodCalories;
}

-(NSString *)getFoodImageFileName{
    return foodImageFileName;
}
-(void)setFoodImageFileName:(NSString *)newFoodImageFileName{
    self.foodImageFileName = newFoodImageFileName;
}

-(NSNumber *)getQuantity{
    return quantity;
}
-(void)setQuantity:(NSNumber *)newQuantity{
    self.quantity = newQuantity;
}


@end
