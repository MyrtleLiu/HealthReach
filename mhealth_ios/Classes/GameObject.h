//
//  GameObject.h
//  mHealth
//
//  Created by smartone_sn on 15-1-14.
//
//

#import <Foundation/Foundation.h>


#define GAME_TYPE_TROPHY @"TrainingTrophy"
#define GAME_TYPE_PLANT @"WalkPlanyt"

@interface GameObject : NSObject{
    
    NSString *progress;
    NSString *gameType;
    long long startDate;
    long long endDate;
    NSString *plantType;
    NSString *plantName;
    NSString *status;//0 current game record;1 history game record
    NSString *distance;
    NSString *steps;
    NSString *calories;
    NSString *fb_key;
    
    NSString *theMSG;

}


@property (strong, nonatomic) NSString *gameType;
@property (strong, nonatomic) NSString *plantType;
@property (strong, nonatomic) NSString *plantName;
@property (strong, nonatomic) NSString *progress;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *theMSG;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *steps;
@property (strong, nonatomic) NSString *calories;
@property (strong, nonatomic) NSString *fb_key;
- (void)setStartDate:(long long)thestartDate;
- (long long)getStartDate;

- (void)setEndDate:(long long)theendDate;
- (long long)getEndDate;

- (id)initGameObject:(NSString *)newgameType plantType:(NSString *)newplantType plantName:(NSString *)newplantName status:(NSString *)newstatus progress:(NSString *)newprogress theMSG:(NSString *)newtheMSG;

@end
