//
//  MenuViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-2-20.
//
//

#import "MenuViewController.h"
#import "UserInfoViewController.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "LanguageSettingViewController.h"
#import "GlobalVariables.h"
#import "Utility.h"
#import "PersonalisationViewController.h"
#import "ShareDataViewController.h"
#import "AboutViewController.h"
#import "HowToUseViewController.h"
#import "MessagesBoxViewController.h"
#import "LoginViewController.h"
#import "NewsViewController.h"

@interface MenuViewController (){
    UIView *lineV;
}

@property (strong,nonatomic) UserInfoViewController *userInfoViewController;

@end

@implementation MenuViewController

@synthesize menuTableView, userInfoViewController = _userInfoViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (!iPad) {
        self = [super initWithNibName:@"MenuViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"MenuViewController_ipad" bundle:nibBundleOrNil];
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
    
    self.menuTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	self.menuTableView.backgroundColor = [UIColor clearColor];
	self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.menuTableView.scrollEnabled=FALSE;
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.menuTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionid=[defaults objectForKey:@"sessionid"];
    NSString *login=[defaults objectForKey:@"login"];
     if(sessionid==NULL||login==NULL){
         return 5;
     }else{
         return 6;
     }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // if (indexPath.row==0) {
        
     //   return 50;
    //}
    
    return 35;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionid=[defaults objectForKey:@"sessionid"];
    NSString *login=[defaults objectForKey:@"login"];
    if(sessionid==NULL||login==NULL){
        if (indexPath.row==0) {
            cell.textLabel.text = [Utility getStringByKey:@"about"];
        }else if (indexPath.row==1) {
            cell.textLabel.text = [Utility getStringByKey:@"How to use"];
        }else if (indexPath.row==2) {
            cell.textLabel.text = [Utility getStringByKey:@"share_health_data"];
        }else if (indexPath.row==3) {
            cell.textLabel.text = [Utility getStringByKey:@"personalisation"];
        }else if (indexPath.row==4) {
            cell.textLabel.text = [Utility getStringByKey:@"firstlogin"];
        }
    }
    else{
        if (indexPath.row==0) {
            cell.textLabel.text = [Utility getStringByKey:@"News"];
        }
        else if (indexPath.row==1) {
            cell.textLabel.text = [Utility getStringByKey:@"message"];
        }else if (indexPath.row==2) {
            cell.textLabel.text = [Utility getStringByKey:@"about"];
        }else if (indexPath.row==3) {
            cell.textLabel.text = [Utility getStringByKey:@"How to use"];
        }else if (indexPath.row==4) {
            cell.textLabel.text = [Utility getStringByKey:@"share_health_data"];
        }else if (indexPath.row==5) {
            cell.textLabel.text = [Utility getStringByKey:@"personalisation"];
        }
    }
    
    
    
    cell.contentView.backgroundColor=[UIColor colorWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
   
    lineV=[[UIView alloc] initWithFrame:CGRectMake(0,0,210,1)];
    
    lineV.backgroundColor=[UIColor colorWithRed:114.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0f];
    
    [cell.contentView addSubview:lineV];
    
    [cell.textLabel setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    cell.textLabel.font=[UIFont fontWithName:font55 size:18];

    return cell;
}

#pragma mark UITableViewDelegate


/*

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

	return 24.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
	NSObject *headerText = nil;
    
    if (section==0) {
        
        headerText=@"Settings";
        
    }else if(section==1){
        
        headerText=@"";
        
    }else if(section==2){
        
        headerText=@"";
    }
    
	UIView *headerView = nil;
	if (headerText != [NSNull null]) {
		headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 24.0f)];
		CAGradientLayer *gradient = [CAGradientLayer layer];
		gradient.frame = headerView.bounds;
		gradient.colors = @[
                            (id)[UIColor colorWithRed:(67.0f/255.0f) green:(74.0f/255.0f) blue:(94.0f/255.0f) alpha:1.0f].CGColor,
                            (id)[UIColor colorWithRed:(57.0f/255.0f) green:(64.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f].CGColor,
                            ];
		[headerView.layer insertSublayer:gradient atIndex:0];
		
		UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 12.0f, 5.0f)];
		textLabel.text = (NSString *) headerText;
		textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:([UIFont systemFontSize] * 0.8f)];
		textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
		textLabel.textColor = [UIColor colorWithRed:(125.0f/255.0f) green:(129.0f/255.0f) blue:(146.0f/255.0f) alpha:1.0f];
		textLabel.backgroundColor = [UIColor clearColor];
		[headerView addSubview:textLabel];
		
		UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
        topLine.backgroundColor = [UIColor colorWithRed:(78.0f/255.0f) green:(86.0f/255.0f) blue:(103.0f/255.0f) alpha:1.0f];
		[headerView addSubview:topLine];
		
		UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 21.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
		bottomLine.backgroundColor = [UIColor colorWithRed:(36.0f/255.0f) green:(42.0f/255.0f) blue:(5.0f/255.0f) alpha:1.0f];
		[headerView addSubview:bottomLine];
	}
	return headerView;
}

*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *frontViewController = nil;
//    UIViewController *userInfoViewController = [[UserInfoViewController alloc]initWithNibName:@"UserInfoViewController" bundle:nil];
//    UIViewController *languageViewController = [[LanguageSettingViewController alloc]initWithNibName:@"LanguageSettingViewController" bundle:nil];
    UIViewController *personalisationViewController = [[PersonalisationViewController alloc]initWithNibName:@"PersonalisationViewController" bundle:nil];
    
     UIViewController *shareDataViewController = [[ShareDataViewController alloc]initWithNibName:@"ShareDataViewController" bundle:nil];
//    
    UIViewController *aboutViewController = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    
    UIViewController *howToUseViewController = [[HowToUseViewController alloc]initWithNibName:@"HowToUseViewController" bundle:nil];
    
     UIViewController *messageboxViewController = [[MessagesBoxViewController alloc]initWithNibName:@"MessagesBoxViewController" bundle:nil];
    
     UIViewController *newsViewController = [[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
    
    UIViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sessionid=[defaults objectForKey:@"sessionid"];
    NSString *login=[defaults objectForKey:@"login"];
    if(sessionid==NULL||login==NULL){
        switch (indexPath.row){
            case 0:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:aboutViewController];
            break;
            case 1:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:howToUseViewController];
            break;
            case 2:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:shareDataViewController];
            break  ;
            case 3:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:personalisationViewController];
            break;
            
            case 4:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:loginViewController];
            
            break;
        }
    }
    else{
        switch (indexPath.row){
                
            case 0:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:newsViewController];
            break;
                
            case 1:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:messageboxViewController];
            break;
            case 2:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:aboutViewController];
            break;
            case 3:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:howToUseViewController];
            break  ;
            case 4:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:shareDataViewController];
            break;
            
            case 5:
            frontViewController = [[UINavigationController alloc]initWithRootViewController:personalisationViewController];
            
            break;
        }
    }
    
    if((sessionid==NULL||login==NULL)&&indexPath.row==4){
//        LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//        [self.navigationController pushViewController:loginViewController animated:(false)];
//
//        [self.revealController setFrontViewController:self.navigationController];
//        [self.revealController showViewController:self.revealController.frontViewController];

        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [(mHealth_iPhoneAppDelegate *)[[UIApplication sharedApplication] delegate] backToLogin];
    }
    else{
        if (!(frontViewController==nil)){
            frontViewController.navigationBarHidden=true;
//            [self.revealController setFrontViewController:frontViewController];
//            [self.revealController showViewController:self.revealController.frontViewController];
            
            [self.revealController setFrontViewController:frontViewController];
            [self.revealController showViewController:self.revealController.frontViewController];
            [self.revealController screenSet];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    }
   }

@end
