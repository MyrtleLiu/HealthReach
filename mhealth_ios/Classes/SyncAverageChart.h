//
//  SyncAverageChart.h
//  mHealth
//
//  Created by smartone_sn on 14-9-3.
//
//

#import <Foundation/Foundation.h>
#import "syncUtility.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "BloodPressure.h"
#import "BloodGlucose.h"
#import "Weight.h"
#import "WalkingRecord.h"
#import "DBHelper.h"
#import "Utility.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"

@interface SyncAverageChart : NSObject



+(void)syncAverageChartData;

+(void)syncBP30AverageChartData;
+(void)syncBP90AverageChartData;
+(void)syncBG90AverageChartData;
+(void)syncBG30AverageChartData;
+(void)syncWeight90AverageChartData;
+(void)syncWeight30AverageChartData;
+(void)syncCW90AverageChartData;
+(void)syncCW30AverageChartData;
+(void)syncTrain90AverageChartData;
+(void)syncTrain30AverageChartData;






@end
