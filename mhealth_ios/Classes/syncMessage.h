//
//  syncMessage.h
//  mHealth
//
//  Created by smartone_sn2 on 14-10-8.
//
//

#import <Foundation/Foundation.h>
#import "DBHelper.h"
#import "Utility.h"
#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "GlobalVariables.h"
#import "Constants.h"
#import "MessageObject.h"

@interface syncMessage : NSObject

+ (NSMutableArray *)getAllMessageRecord;

+ (BOOL)getActionMessageRecord:(NSString * )action :(NSString * )messageid;

+ (BOOL )deleteMessageRecord :(NSString * )messageid;





+ (NSMutableArray *)getAllNewsRecord;




@end
