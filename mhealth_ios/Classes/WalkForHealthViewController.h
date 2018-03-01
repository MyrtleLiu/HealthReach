//
//  WalkForHealthViewController.h
//  mHealth
//
//  Created by sngz on 14-1-26.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DBHelper.h"
#import "TrainingRecord.h"
#import "CurrentWeeklyProgressViewController.h"
#import "Utility.h"
#import "WalkingHistoryViewController.h"

@interface WalkForHealthViewController : BaseViewController<UIScrollViewDelegate>

{
    IBOutlet UILabel *tryNowCW;
    IBOutlet UILabel *tryNowTP;
    IBOutlet UILabel *numberOneCW;
    IBOutlet UILabel *numberTwoCW;
    IBOutlet UILabel *numberOneTP;
    IBOutlet UILabel *numberTwoTP;
    
    IBOutlet UIView *tryNowBackGuandViewSum;
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

    UILabel *cwTitleTextFont2;
    IBOutlet UIScrollView * tptitleblackScrollview;
    IBOutlet UIScrollView * wptitleblackScrollview;
    
   
   
    
    
    NSString *strTempTemp;
    
    
    BOOL isTryNowCW;
    BOOL isTryNowTP;

    
    
}
@property (strong, nonatomic) IBOutlet UILabel *actionTitle;
@property (strong, nonatomic) IBOutlet UILabel *trainingTitle;
@property (strong, nonatomic) IBOutlet UILabel *trainingText;
@property (strong, nonatomic) IBOutlet UILabel *cwTitle;
@property (strong, nonatomic) IBOutlet UILabel *cwText;
@property (strong, nonatomic) IBOutlet UILabel *historyTitle;
@property (strong, nonatomic) IBOutlet UILabel *adviseText;
@property (strong, nonatomic) IBOutlet UILabel *awardsText;
-(IBAction)BackHome:(id)sender;
-(IBAction)toCasualWalk:(id)sender;
-(IBAction)toStarting:(id)sender;
-(IBAction)toHistory:(id)sender;
-(IBAction)toTPTryNow:(id)sender;
-(IBAction)toCWTryNow:(id)sender;
-(IBAction)toAwards:(id)sender;
@property (nonatomic) int paceSetValue;
@property (strong, nonatomic) NSString *targetSetValue;

@property(nonatomic,assign)int toTPorCW;
-(IBAction)tobeDoneWithCW:(id)sender;

-(IBAction)tobeDoneWithTP:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *hideView;

@property(strong, nonatomic)NSMutableArray * plantArrayCW;
@property(strong, nonatomic)NSMutableArray * plantArrayTP;


@property(nonatomic,strong)NSDictionary * dicCW;

@property(nonatomic,strong)NSDictionary * dicTP;


@property (weak, nonatomic) IBOutlet UIView *WaitingView;


@property (strong, nonatomic) IBOutlet UIButton *toTPButton;
@property (strong, nonatomic) IBOutlet UIButton *toCWButton;





@end
