//
//  FirstWalkResultViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-10-21.
//
//

#import "FirstWalkResultViewController.h"
#import "Utility.h"
@interface FirstWalkResultViewController ()

@end

@implementation FirstWalkResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    [_okBtn setTitle:[Utility getStringByKey:@"ok"] forState: UIControlStateNormal];
    _okBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_actionbar setText:[Utility getStringByKey:@"w_walk_title"]];

    
    _text=[_text initWithFrame:_text.frame];
    _text.delegate=self;
    [_text setParagraphReplacement:@""];
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"]){
        _text.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>PreView version - No walking record entered into history. To enjoy full service, please visit our <a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>authorised dealers</font></a> to subscribe the service and purchase the designated connected device.</font>";
        
    }
    else{
        _text.text=@"<font face='HelveticaNeueLTPro-Roman' size=15 color=#326464>預覽版 - 運動紀錄將不備儲存。如果你有興趣享用健易達全部功能，請即前往<a href='http://www.smartone.com/jsp/privileges_and_support/contact_us/english/store_location_m.jsp?tt=2'><font face='HelveticaNeueLTPro-Md' size=15 color=#4848f6>特許代理</font></a>登記服務及購買指定量度儀器。</font>";
    }

    if (iPad) {
        
        _barView.frame=CGRectMake(0, 0, 320, 45);
    }
    
}
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
    NSString * link=[url absoluteString];
    
    
    NSLog(@"did select link %@", link);
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
    
    
    
}



-(IBAction)okBtnClick:(id)sender{
    NSInteger index=[[self.navigationController viewControllers] indexOfObject:self];
    [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: index-3] animated:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
