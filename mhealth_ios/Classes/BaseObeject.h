//
//  BaseObeject.h
//  mHealth
//
//  Created by sngz on 14-2-10.
//
//

#import <Foundation/Foundation.h>
#import "NSString+Utils.h"

@interface BaseObeject : NSObject{
    
    
    long recordtime;
    
    int status;
    
    int missprevious;
    

    
}


- (void)setRecordtime:(long)thetime;

- (long)getRecordtime;


- (void)setStatus:(int)thestatus;

- (int)getStatus;

- (void)setMissprevious:(int)theMissprevious;

- (int)getMissprevious;


@end
