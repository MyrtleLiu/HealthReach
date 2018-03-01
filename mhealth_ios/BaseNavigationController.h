//
//  BaseNavigationController.h
//  mHealth
//
//  Created by smartone_sn on 14-2-18.
//
//

#import <UIKit/UIKit.h>



@interface BaseNavigationController : UINavigationController<UINavigationControllerDelegate>{
    
    
}


- (void) pushCodeBlock:(void (^)())codeBlock;
- (void) runNextBlock;

@property (nonatomic, retain) NSMutableArray* stack;
@property (nonatomic, assign) bool transitioning;


@end
