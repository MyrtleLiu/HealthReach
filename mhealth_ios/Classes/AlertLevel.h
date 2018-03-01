//
//  AlertLevel.h
//  mHealth
//
//  Created by admin on 9/3/14.
//
//

#import <Foundation/Foundation.h>
#import "BaseObeject.h"

@interface AlertLevel : BaseObeject{
    
    NSString *lsystolic;
    NSString *hsystolic;
    
    NSString *ldiastolic;
    NSString *hdiastolic;
    
    NSString *bp_lheartrate;
    NSString *bp_hheartrate;
    
    NSString *ecg_lheartrate;
    NSString *ecg_hheartrate;
    
    NSString *lbg;
    NSString *hbg;
    
    NSString *lbg_b;
    NSString *hbg_b;
    
    NSString *lbg_a;
    NSString *hbg_a;
    
    NSString *lsteps;
    NSString *hbmi;
    


}


@property (strong, nonatomic) NSString *lsystolic;
@property (strong, nonatomic) NSString *hsystolic;

@property (strong, nonatomic) NSString *ldiastolic;
@property (strong, nonatomic) NSString *hdiastolic;

@property (strong, nonatomic) NSString *bp_lheartrate;
@property (strong, nonatomic) NSString *bp_hheartrate;

@property (strong, nonatomic) NSString *ecg_lheartrate;
@property (strong, nonatomic) NSString *ecg_hheartrate;

@property (strong, nonatomic) NSString *lbg;
@property (strong, nonatomic) NSString *hbg;

@property (strong, nonatomic) NSString *lbg_b;
@property (strong, nonatomic) NSString *hbg_b;

@property (strong, nonatomic) NSString *lbg_a;
@property (strong, nonatomic) NSString *hbg_a;

@property (strong, nonatomic) NSString *lsteps;
@property (strong, nonatomic) NSString *hbmi;




-(NSMutableDictionary *)getDictionaryFromAlertLevel;

-(id)initFromDicionary:(NSMutableDictionary *)dic;

@end
