//
//  SyncGame.h
//  mHealth
//
//  Created by smartone_sn on 15-1-14.
//
//

#import <Foundation/Foundation.h>
#import "DBHelper.h"
#import "Utility.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "GameObject.h"

@interface SyncGame : NSObject


+ (void)startGame:(NSString*)name recordId:(NSString *)type;
+ (GameObject *)getPlantProgress;
+ (GameObject *)getTrophyProgress;
+(BOOL)checkPlantProgress:(NSString*)duration steps:(NSString*)thesteps;
+(BOOL)syncPlantList;
+(BOOL)syncTrophyList;
+(BOOL)syncBronzeList;
+(BOOL)syncSilverList;
+(BOOL)syncGoldList;
+(BOOL)syncDiamondList;

+(BOOL)isShowTrophyTryNow;
+(BOOL)isShowPlantTryNow;

+ (void)updateTrophyTryNow;
+ (void)updatePlantTryNow;

+ (BOOL)getMedal;


+ (NSString *)getMedalBronze;
+ (NSString *)getMedalSilver;
+ (NSString *)getMedalGold;
+ (NSString *)getMedalDiamond;
//+(BOOL)shareCW:(NSString*)fb_key;
+(void)trialCheckPlantProgress:(NSString*)duration steps:(NSString*)thesteps;
+(NSString *)shareFristTimethePlantName:(NSString*)plantName theType:(NSString*)type theSteps:(NSString*)steps thecalories:(NSString*)calories theDistance:(NSString *)distance;
@end
