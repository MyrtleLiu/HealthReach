//
//  syncCalories.h
//  mHealth
//
//  Created by smartone_sn3 on 8/19/14.
//
//

#import <Foundation/Foundation.h>
#import "DBHelper.h"

#define FOODLISTTXT_URL @"https://www.healthreach.hk/foodlist/checkupdate.txt"
#define FOODLISTCSV @"https://www.healthreach.hk/foodlist/"
#define FOODLISTIMG @"https://www.healthreach.hk/foodlist/image/"

@interface syncCalories : NSObject

+ (void)syncAllCaloriesData;

//Get new foodlist from server.
+ (void)checkFoodList;
+ (NSString *)getNewFoodListFileName;
+ (void)downloadFoodList:(NSString *)foodListFileName;
+ (void)parseFoodInfoEntry:(NSString *)singleFoodInfoEntry;

+ (void)saveCaloriesData:(NSArray *)foodRecordsArray;
//+ (NSArray *)getFoodHistoryRecord:(NSNumber *)foodId;
+ (NSDictionary *)parseFoodHistoryRecord:(NSString *)recordDetail;
+ (void)deleteFoodDetail:(NSString *)recordTime;
+ (void)uploadFoodNotUpload:(NSMutableArray *)uploadFoodNotUploadArray;
+ (NSString *)getRecordDetailById:(NSString *)recordId;
@end
