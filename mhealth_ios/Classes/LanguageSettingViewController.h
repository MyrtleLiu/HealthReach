//
//  LanguageSettingViewController.h
//  mHealth
//
//  Created by sngz on 14-3-21.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LanguageSettingViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *englishButton;
@property (weak, nonatomic) IBOutlet UIButton *chineseButton;
@property (weak, nonatomic) NSString *languageResult;

@property (weak, nonatomic) IBOutlet UILabel *actionbar;

@property (weak, nonatomic) IBOutlet UIImageView *btnView;



@end
