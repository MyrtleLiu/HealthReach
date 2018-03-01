//
//  StartingFromBronzeViewController.h
//  mHealth
//
//  Created by gz dev team on 14年2月25日.
//
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
#import "SyncWalking.h"
#import "TrainingRecord.h"

@interface StartingFromBronzeViewController : BaseViewController

{
    IBOutlet UILabel *textLable;
   
    UIButton*buttonBrown;
  
    UIButton*buttonGlay;
 
    UIButton*buttonYellow;
 
    UIButton*buttonBlue;
   
    UIImageView*_goldImageView1;
    UILabel*bronze1;
    UILabel*forBeginner1;
    
    UILabel*_5days1;
    
    
    UIImageView*_goldImageView2;
    UILabel*bronze2;
    UILabel*forBeginner2;
    //UILabel*_30min2;
   // UILabel*_days2;
    UILabel*_5days2;
   // UILabel*_week2;
    //UILabel*gentlePace2;
    
    UIImageView*_goldImageView3;
    UILabel*bronze3;
    UILabel*forBeginner3;
    
    UILabel*_5days3;
    
    
    UIImageView*_goldImageView4;
    UILabel*bronze4;
    UILabel*forBeginner4;
    
    UILabel*_5days4;
    
    
    UIButton*greenButton2;
    
    UIButton*greenButton1;
    
    UIButton*greenButton3;
    
    UIButton*greenButton4;
    
    
    
    
    
    
    
    UIImageView*imageView;


    
}

@property (strong, nonatomic) IBOutlet UILabel *actionTitle;

@property (nonatomic,strong)NSDate*nowDate;
//@property (nonatomic,strong)UIView*addView;



@property (strong, nonatomic) IBOutlet UIImageView *iphone4bg;




@end
