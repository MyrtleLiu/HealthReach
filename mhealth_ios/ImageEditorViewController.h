//
//  ViewController.h
//  QuickContacts
//
//  Created by  on 11-12-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageEditorViewController : UIViewController <UIScrollViewDelegate> {
}

@property (nonatomic, copy) void (^completionHandler)(UIImage *editedImage);

- (id)initWithOriginalImage:(UIImage *)image cropWidth:(float)width cropHeight:(float)height;

@end
