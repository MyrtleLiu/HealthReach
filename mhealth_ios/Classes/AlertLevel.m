//
//  AlertLevel.m
//  mHealth
//
//  Created by admin on 9/3/14.
//
//

#import "AlertLevel.h"

@implementation AlertLevel
@synthesize  lsystolic,hsystolic,ldiastolic,hdiastolic;
@synthesize  bp_lheartrate,bp_hheartrate;
@synthesize  ecg_lheartrate,ecg_hheartrate;
@synthesize  lbg,hbg;
@synthesize  lbg_b,hbg_b;
@synthesize  lbg_a,hbg_a;
@synthesize  lsteps;
@synthesize  hbmi;



-(NSMutableDictionary *)getDictionaryFromAlertLevel{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:lsystolic forKey:@"lsystolic"];
    [dic setValue:hsystolic forKey:@"hsystolic"];
    
    [dic setValue:ldiastolic forKey:@"ldiastolic"];
    [dic setValue:hdiastolic forKey:@"hdiastolic"];
    
    [dic setValue:bp_lheartrate forKey:@"bp_lheartrate"];
    [dic setValue:bp_hheartrate forKey:@"bp_hheartrate"];
    
    [dic setValue:ecg_lheartrate forKey:@"ecg_lheartrate"];
    [dic setValue:ecg_hheartrate forKey:@"ecg_hheartrate"];
    
    [dic setValue:lbg forKey:@"lbg"];
    [dic setValue:hbg forKey:@"hbg"];
    [dic setValue:lbg_b forKey:@"lbg_b"];
    [dic setValue:hbg_b forKey:@"hbg_b"];
    [dic setValue:lbg_a forKey:@"lbg_a"];
    [dic setValue:hbg_a forKey:@"hbg_a"];
    [dic setValue:hbmi forKey:@"hbmi"];
    [dic setValue:lsteps forKey:@"lsteps"];
    
    
    return dic;
}

-(id)initFromDicionary:(NSMutableDictionary *)dic {
    if (dic == nil) {
        return nil;
    }
    if(self = [super init]){
		lsystolic = [dic objectForKey:@"lsystolic"];
        hsystolic = [dic objectForKey:@"hsystolic"];
        ldiastolic = [dic objectForKey:@"ldiastolic"];
        hdiastolic = [dic objectForKey:@"hdiastolic"];
        bp_lheartrate = [dic objectForKey:@"bp_lheartrate"];
        bp_hheartrate = [dic objectForKey:@"bp_hheartrate"];
        ecg_lheartrate = [dic objectForKey:@"ecg_lheartrate"];
        ecg_hheartrate = [dic objectForKey:@"ecg_hheartrate"];
        lbg = [dic objectForKey:@"lbg"];
        hbg = [dic objectForKey:@"hbg"];
        lbg_b = [dic objectForKey:@"lbg_b"];
        hbg_b = [dic objectForKey:@"hbg_b"];
        lbg_a = [dic objectForKey:@"lbg_a"];
        hbg_a = [dic objectForKey:@"hbg_a"];
        lsteps = [dic objectForKey:@"lsteps"];
        hbmi = [dic objectForKey:@"hbmi"];
	}
    
	return self;
}


@end
