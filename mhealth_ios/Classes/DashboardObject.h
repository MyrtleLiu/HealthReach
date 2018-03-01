//
//  DashboardObject.h
//  mHealth
//
//  Created by smartone_sn on 14-9-29.
//
//

#import <Foundation/Foundation.h>

@interface DashboardObject : NSObject{
    
    NSString *sort;
    NSString *type;
}

@property (strong, nonatomic) NSString *sort;
@property (strong, nonatomic) NSString *type;


- (id)initWithType:(NSString *)type sort:(NSString *)thesort;

@end
