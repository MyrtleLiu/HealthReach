//
//  StartingFromBronzeViewController.h
//  mHealth
//
//  Created by gz dev team on 14年2月25日.
//
//

#import <UIKit/UIKit.h>

@interface StartingFromBronzeViewController : UIViewController

{
    
   UIButton*buttonBrown;
   UIButton*buttonGlay;
  UIButton*buttonYellow;
  UIButton*buttonBlue;
   
    UIImageView*_goldImageView1;
    UILabel*bronze1;
    UILabel*forBeginner1;
    UILabel*_30min1;
    UILabel*_days1;
    UILabel*_5days1;
    UILabel*_week1;
    UILabel*gentlePace1;
    
    
    UIImageView*_goldImageView2;
    UILabel*bronze2;
    UILabel*forBeginner2;
    UILabel*_30min2;
    UILabel*_days2;
    UILabel*_5days2;
    UILabel*_week2;
    UILabel*gentlePace2;
    
    UIImageView*_goldImageView3;
    UILabel*bronze3;
    UILabel*forBeginner3;
    UILabel*_30min3;
    UILabel*_days3;
    UILabel*_5days3;
    UILabel*_week3;
    UILabel*gentlePace3;
    
    UIImageView*_goldImageView4;
    UILabel*bronze4;
    UILabel*forBeginner4;
    UILabel*_30min4;
    UILabel*_days4;
    UILabel*_5days4;
    UILabel*_week4;
    UILabel*gentlePace4;
    
    UIButton*greenButton2;
    UILabel*label2;
    UIButton*greenButton1;
    UILabel*label1;
    UIButton*greenButton3;
    UILabel*label3;
    UIButton*greenButton4;
    UILabel*label4;
    
    
    
    
    
    
    UIImageView*imageView;
  
    IBOutlet UIButton*goHome;

    
}
@property (nonatomic,strong)NSDate*nowDate;
@property (nonatomic,strong)UIView*addView;
-(IBAction)home:(id)sender;
@end
