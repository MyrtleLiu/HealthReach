//
//  FirstTimeSlideViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-9-9.
//
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@interface FirstTimeSlideViewController : UIViewController<UIScrollViewDelegate,RTLabelDelegate>{
//    IBOutlet UILabel *message;
//    IBOutlet UIScrollView *myScrollView;
//    IBOutlet UIPageControl *myPageControl;
    UIView *appForceView;
    UIImageView *imagehandImageView;
    UIImageView*healthReachImageView;
}

@property (retain, nonatomic) IBOutlet UILabel *message;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageController;
@property (retain, nonatomic) NSMutableArray *images;

@property (retain, nonatomic) IBOutlet UIButton *nextBtn;
@property (retain, nonatomic) IBOutlet UIButton *checkBtn;
@property (retain, nonatomic) IBOutlet UILabel *textBtn;
@property (retain, nonatomic) IBOutlet UIView *checkView;

@property (retain, nonatomic) IBOutlet UIButton *vedioBtn;

@property (strong, nonatomic) IBOutlet RTLabel *tx1;


@end
