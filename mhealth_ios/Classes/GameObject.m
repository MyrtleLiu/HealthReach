//
//  GameObject.m
//  mHealth
//
//  Created by smartone_sn on 15-1-14.
//
//

#import "GameObject.h"

@implementation GameObject

@synthesize gameType,plantType,plantName,status,progress,theMSG,distance,steps,calories,fb_key;



- (void)setStartDate:(long long)thestartDate{
    
    startDate=thestartDate;
}

- (long long)getStartDate{
    
    return startDate;
}


- (void)setEndDate:(long long)theendDate{
    
    endDate=theendDate;
}

- (long long)getEndDate{
    
    return endDate;
}


- (id)initGameObject:(NSString *)newgameType plantType:(NSString *)newplantType plantName:(NSString *)newplantName status:(NSString *)newstatus progress:(NSString *)newprogress theMSG:(NSString *)newtheMSG{
    
    
    if(self = [super init]){
        
		gameType = newgameType;
        plantType=newplantType;
        plantName=newplantName;
        status=newstatus;
        progress=newprogress;
        theMSG=newtheMSG;
        
		
	}
    
	return self;
}




@end
