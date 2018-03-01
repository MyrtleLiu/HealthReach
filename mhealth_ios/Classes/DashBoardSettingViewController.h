//
//  DashBoardSettingViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-9-29.
//
//

#import "BaseViewController.h"

@interface DashBoardSettingViewController : BaseViewController


@property (strong, nonatomic) IBOutlet UIButton *doneBtn;

@property (strong, nonatomic) IBOutlet UILabel *moveTextView;

@property (strong, nonatomic) IBOutlet UILabel *actionbar;

-(IBAction)saveSort:(id)sender;

@end
