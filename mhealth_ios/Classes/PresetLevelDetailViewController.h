//
//  PresetLevelDetailViewController.h
//  mHealth
//
//  Created by Mocona on 9/2/14.
//
//

#import "BaseViewController.h"
#import "Utility.h"
#import "GlobalVariables.h"
#import "AlertLevel.h"
#import "syncAlertLevel.h"

@interface PresetLevelDetailViewController : BaseViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>{
    NSMutableDictionary *alertLevelDic;
}


@property(nonatomic, retain) IBOutlet UILabel *title_label;
@property(nonatomic, retain) IBOutlet UIScrollView *scroll_view;

@property(nonatomic, retain) NSString *viewType;

@property (nonatomic, retain) UITapGestureRecognizer *viewTapGestureRecognizer;

-(void) initBPView;

@end
