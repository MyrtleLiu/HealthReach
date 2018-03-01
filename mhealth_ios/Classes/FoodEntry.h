//
//  FoodEntry.h
//  mHealth
//
//  Created by smartone_sn3 on 8/20/14.
//
//

#import <Foundation/Foundation.h>

@interface FoodEntry : NSObject {
    NSNumber *number;
    NSString *name_en;
    NSString *name_zh;
    NSString *quantityUnit_en;
    NSString *quantityUnit_zh;
    NSString *foodType;
    NSNumber *foodCalories;
    NSString *foodImageFileName;
    NSNumber *quantity;
}

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *name_en;
@property (strong, nonatomic) NSString *name_zh;
@property (strong, nonatomic) NSString *quantityUnit_en;
@property (strong, nonatomic) NSString *quantityUnit_zh;
@property (strong, nonatomic) NSString *foodType;
@property (strong, nonatomic) NSNumber *foodCalories;
@property (strong, nonatomic) NSString *foodImageFileName;
@property (strong, nonatomic) NSNumber *quantity;

-(id)initWithNumber:(NSNumber *)newNumber name_en:(NSString *)newName_en name_zh:(NSString *)newName_zh quantityUnit_en:(NSString *)newQuantityUnit_en quantityUnit_zh:(NSString *)newQuantityUnit_zh foodType:(NSString *)newFoodType foodCalories:(NSNumber *)newFoodCalories foodImageFileName:(NSString *)newFoodImageFileName quantity:(NSNumber *)newQuantity;

-(NSNumber *)getNumber;
-(void)setNumber:(NSNumber *)newNumber;

-(NSString *)getName_zh;
-(void)setName_zh:(NSString *)newName_zh;

-(NSString *)getName_en;
-(void)setName_en:(NSString *)newName_en;

-(NSString *)getQuantityUnit_zh;
-(void)setQuantityUnit_zh:(NSString *)newQuantityUnit_zh;

-(NSString *)getQuantityUnit_en;
-(void)setQuantityUnit_en:(NSString *)newQuantityUnit_en;

-(NSString *)getFoodType;
-(void)setFoodType:(NSString *)newFoodType;

-(NSNumber *)getFoodCalories;
-(void)setFoodCalories:(NSNumber *)newFoodCalories;

-(NSString *)getFoodImageFileName;
-(void)setFoodImageFileName:(NSString *)newFoodImageFileName;

-(NSNumber *)getQuantity;
-(void)setQuantity:(NSNumber *)newQuantity;

@end
