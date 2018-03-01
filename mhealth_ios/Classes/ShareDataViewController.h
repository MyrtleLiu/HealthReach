//
//  ShareDataViewController.h
//  mHealth
//
//  Created by smartone_sn2 on 14-8-29.
//
//

#import "BaseViewController.h"

@interface ShareDataViewController : BaseViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *actionbar;

@property (strong, nonatomic) IBOutlet UIView *topView_en;
@property (strong, nonatomic) IBOutlet UIView *topView_cn;

@property (strong, nonatomic) IBOutlet UILabel *tx1;
@property (strong, nonatomic) IBOutlet UILabel *tx2;
@property (strong, nonatomic) IBOutlet UILabel *tx3;
@property (strong, nonatomic) IBOutlet UILabel *tx4;

@property (strong, nonatomic) IBOutlet UIButton *confirm_Btn;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *topTextEn1;
@property (strong, nonatomic) IBOutlet UIButton *topTextEn_link;

@property (strong, nonatomic) IBOutlet UILabel *topTextCn1;
@property (strong, nonatomic) IBOutlet UILabel *topTextCn2;
@property (strong, nonatomic) IBOutlet UIButton *topTextCn_link;

@property (strong, nonatomic) IBOutlet UITextField* phoneNeum1;
@property (strong, nonatomic) IBOutlet UITextField* phoneNeum2;


@property (strong, nonatomic) IBOutlet UIView* resultView;
@property (strong, nonatomic) IBOutlet UILabel *resultText;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;



@property (strong, nonatomic) IBOutlet UIView *tempView;


@end
