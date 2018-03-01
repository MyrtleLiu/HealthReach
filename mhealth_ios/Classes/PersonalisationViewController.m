//
//  PersonalisationViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-8-29.
//
//

#import "PersonalisationViewController.h"
#import "UserInfoViewController.h"
#import "LanguageSettingViewController.h"
#import "LoginSettingViewController.h"
#import "PresetLevelViewController.h"
#import "HomeViewController.h"
#import "Utility.h"
#import "syncUtility.h"
#import "GlobalVariables.h"
#import "menuLearnMoreViewController.h"

@interface PersonalisationViewController ()

@end

@implementation PersonalisationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (!iPad) {
        self = [super initWithNibName:@"PersonalisationViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"PersonalisationViewController_ipad" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [_actionbar setText:[Utility getStringByKey:@"personalisation"]];
    
//    [_personalinfo.titleLabel setText:[Utility getStringByKey:@"personalinfo"]];
//    [_loginmethod.titleLabel setText:[Utility getStringByKey:@"loginmetho"]];
//    [_presetlevel.titleLabel setText:[Utility getStringByKey:@"presetlevel"]];
//    [_language.titleLabel setText:[Utility getStringByKey:@"language"]];

    [_personalinfo setTitle:[Utility getStringByKey:@"personalinfo"] forState: normal];
    _personalinfo.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_loginmethod setTitle:[Utility getStringByKey:@"loginmetho"] forState: normal];
    _loginmethod.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_presetlevel setTitle:[Utility getStringByKey:@"presetlevel"] forState: normal];
    _presetlevel.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_language setTitle:[Utility getStringByKey:@"language"] forState: normal];
    _language.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    
    
    _personalinfo.titleLabel.font=[UIFont fontWithName:font65 size:18];
    _loginmethod.titleLabel.font=[UIFont fontWithName:font65 size:18];
    _presetlevel.titleLabel.font=[UIFont fontWithName:font65 size:18];
    _language.titleLabel.font=[UIFont fontWithName:font65 size:18];

    
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(syncAllData) object:nil];
    [thread start];
    
    
}

-(void)syncAllData{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        return;
    }
    else{
        [syncUtility getPersonInfo];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchToPersonalInfo:(id)sender
{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        menuLearnMoreViewController *historyView = [[menuLearnMoreViewController alloc] initWithNibName:@"menuLearnMoreViewController" bundle:nil];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        UserInfoViewController *intent = [[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil];
        [self.navigationController pushViewController:intent animated:YES ];
    }

   
}
- (IBAction)switchToLanguage:(id)sender
{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        menuLearnMoreViewController *historyView = [[menuLearnMoreViewController alloc] initWithNibName:@"menuLearnMoreViewController" bundle:nil];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        LanguageSettingViewController *intent = [[LanguageSettingViewController alloc] initWithNibName:@"LanguageSettingViewController" bundle:nil];
        [self.navigationController pushViewController:intent animated:YES ];

    }
}
- (IBAction)switchToLonginSetting:(id)sender
{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        menuLearnMoreViewController *historyView = [[menuLearnMoreViewController alloc] initWithNibName:@"menuLearnMoreViewController" bundle:nil];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        LoginSettingViewController *intent = [[LoginSettingViewController alloc] initWithNibName:@"LoginSettingViewController" bundle:nil];
        [self.navigationController pushViewController:intent animated:YES ];
    }
   
}
- (IBAction)switchToPresetLevel:(id)sender
{
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        menuLearnMoreViewController *historyView = [[menuLearnMoreViewController alloc] initWithNibName:@"menuLearnMoreViewController" bundle:nil];
        [self.navigationController pushViewController:historyView animated:YES ];
    }
    else{
        PresetLevelViewController *intent = [[PresetLevelViewController alloc] initWithNibName:@"PresetLevelViewController" bundle:nil];
        [self.navigationController pushViewController:intent animated:YES ];
 
    }
}




- (IBAction)newBackToHome:(id)sender
{
    HomeViewController *intent = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:intent animated:YES ];
}


@end
