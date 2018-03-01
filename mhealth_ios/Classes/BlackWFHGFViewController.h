//
//  BlackWFHGFViewController.h
//  mHealth
//
//  Created by admin on 3/2/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BlackWFHGFViewController : BaseViewController<UIScrollViewDelegate>
{
    
    IBOutlet UILabel *walkforHealthTextHeanFont;
    
    
    IBOutlet UIView * tpTryNowBackGuandView;
    IBOutlet UIView * cwTryNowBackGuandView;
    IBOutlet UIView * tpTextLittleBackGuandView;
    IBOutlet UIView * cwTextLittleBackGuandVIew;
    //TP_TryNow
    IBOutlet UILabel *tryNowTPLabelTextFont;
    IBOutlet UILabel *rewardSchemeTextFont;
    IBOutlet UILabel *rewardNumber;
    IBOutlet UILabel *percentTextFont;
    IBOutlet UIImageView *rewardpicture;
    IBOutlet UILabel *tpGamerulesTextFont;
    IBOutlet UILabel *tpLittleTextFont;
    IBOutlet UIButton *tpOK_btn;
    UIImage *theTrophyImage;
    //CW_TryNow
    IBOutlet UILabel *tryNowCWLabelTextFont;
    IBOutlet UILabel *plantName;
    IBOutlet UILabel *plantremarksTextFont;
    IBOutlet UILabel *plantstatusTextFont;
    IBOutlet UILabel *gamerulesTextFont;
    IBOutlet UILabel *cwLittleTextFont;
    IBOutlet UILabel *bignumber;
    IBOutlet UILabel *smorenumber;
    IBOutlet UIButton * ok_btn;
    IBOutlet UIImageView *plantpicture;
    
    IBOutlet UIScrollView * tptitleblackScrollview;
    IBOutlet UIScrollView * wptitleblackScrollview;
    
    
    NSString *strTempTemp;
    
}
@property (nonatomic) int paceSetValue;
@property (strong, nonatomic) NSString *targetSetValue;
@property(nonatomic,assign)int toTPorCW;

@property(nonatomic,strong)NSMutableDictionary * dicCW;

@property(nonatomic,strong)NSMutableDictionary * dicTP;


-(IBAction)tobeDoneWithCW:(id)sender;

-(IBAction)tobeDoneWithTP:(id)sender;
@end
