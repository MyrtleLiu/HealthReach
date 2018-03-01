//
//  LanguageSettingViewController.m
//  mHealth
//
//  Created by sngz on 14-3-21.
//
//

#import "LanguageSettingViewController.h"
#import "HomeViewController.h"
#import "Utility.h"

@interface LanguageSettingViewController ()

@end

@implementation LanguageSettingViewController

@synthesize englishButton;
@synthesize chineseButton;
@synthesize languageResult;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"LanguageSettingViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"LanguageSettingViewController" bundle:nibBundleOrNil];
    }
    return self;	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    NSString *lanuage = [Utility getLanguageCode];
//    if ([lanuage isEqual: @"en"]) {
//        [self.englishButton setBackgroundImage:[UIImage imageNamed:@"hr_setting_bg_2.png"] forState:UIControlStateNormal];
//        [self.chineseButton setBackgroundImage:[UIImage imageNamed:@"hr_setting_bg_3.png"] forState:UIControlStateNormal];
//        languageResult = @"en";
//    } else {
//        [self.englishButton setBackgroundImage:[UIImage imageNamed:@"hr_setting_bg_3.png"] forState:UIControlStateNormal];
//        [self.chineseButton setBackgroundImage:[UIImage imageNamed:@"hr_setting_bg_2.png"] forState:UIControlStateNormal];
//        languageResult = @"cn";
//    }
    
    
   
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [_actionbar setText:[Utility getStringByKey:@"language"]];
    
    
    NSString *lanuage = [Utility getLanguageCode];
    if ([lanuage isEqual: @"en"]) {
        [self.englishButton setBackgroundImage:[UIImage imageNamed:@"set_lang_en_on.png"] forState:UIControlStateNormal];
        [self.chineseButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [_btnView setImage:[UIImage imageNamed:@"set_lang_tc_off.png"]];
      
        languageResult = @"en";
    } else {
        [self.englishButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.chineseButton setBackgroundImage:[UIImage imageNamed:@"set_lang_tc_on.png"] forState:UIControlStateNormal];
        languageResult = @"cn";
         [_btnView setImage:[UIImage imageNamed:@"set_lang_en_off.png"]];
    }

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseEnglish:(id)sender {
    [self.englishButton setBackgroundImage:[UIImage imageNamed:@"set_lang_en_on.png"] forState:UIControlStateNormal];
    [self.chineseButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    languageResult = @"en";
    
     [Utility setLanguage:languageResult];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chooseChinese:(id)sender {
    [self.englishButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.chineseButton setBackgroundImage:[UIImage imageNamed:@"set_lang_tc_on.png"] forState:UIControlStateNormal];
    languageResult=@"cn";
    
    [Utility setLanguage:languageResult];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)okButtonDown:(id)sender {
    [Utility setLanguage:languageResult];
//    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
//    [self.navigationController pushViewController:homeView animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    

}
- (IBAction)cancelButtonDown:(id)sender {
    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeView animated:YES];
}

@end
