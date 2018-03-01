//
//  CustomAlertView.h
//  mHealth
//
//  Created by Mocona on 9/1/14.
//
//


#import <UIKit/UIKit.h>
#import "Utility.h"

@protocol CustomAlertViewDelegate

- (void)dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface CustomAlertView : UIView<CustomAlertViewDelegate>

@property (nonatomic, retain) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)
@property (nonatomic, retain) UIView *buttonView;    // Buttons on the bottom of the dialog

@property (nonatomic, assign) id<CustomAlertViewDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonTitles;
@property (nonatomic, assign) BOOL useMotionEffects;

@property (copy) void (^onButtonTouchUpInside)(CustomAlertView *alertView, int buttonIndex) ;

- (id)init;


- (void)show;
- (void)close;

- (IBAction)buttonTouchUpInside:(id)sender;
- (void)setOnButtonTouchUpInside:(void (^)(CustomAlertView *alertView, int buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange: (NSNotification *)notification;
- (void)dealloc;

@end
