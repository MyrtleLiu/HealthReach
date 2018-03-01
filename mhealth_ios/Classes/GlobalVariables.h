//
//  GlobalVariables.h
//  mHealth
//
//  Created by gz dev team on 14年1月21日.
//
//

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject{
    NSString *login_id;
    NSString *session_id;
    id viewID;
    
    NSString *caloriesTotal;
    NSDictionary *foodHistoryDict;
    
    
    

}

@property(nonatomic,retain) NSString *login_id;
@property(nonatomic,retain) NSString *session_id;
@property(nonatomic,retain) id viewId;





@property(nonatomic) Boolean trainRT_API_running;




@property(nonatomic,retain) NSString *caloriesTotal;

@property (nonatomic, retain) NSDictionary *foodHistoryDict;

// 1 is already sync 0 is not sync
@property (nonatomic, retain) NSString *BPAlreadySync;
@property (nonatomic, retain) NSString *WeightAlreadySync;
@property (nonatomic, retain) NSString *BGAlreadySync;
@property (nonatomic, retain) NSString *CaloriesAlreadySync;

+(GlobalVariables *)shareInstance;


@property(nonatomic,retain) NSString *distanceGlo;
@property(nonatomic,retain) NSString *stepseGlo;
@property(nonatomic,retain) NSString *paceGlo;
@property(nonatomic,retain) NSString *caleGlo;
@property(nonatomic,retain) NSString *targetGlo;
@property(nonatomic,retain) NSString *timeeGlo;
@property(nonatomic,retain) NSString *running;

@property long touchTime;











@end
