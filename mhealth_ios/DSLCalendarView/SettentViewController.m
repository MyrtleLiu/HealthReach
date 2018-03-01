//
//  SettentViewController.m
//  mHealth
//
//  Created by gz dev team on 14年11月7日.
//
//

#import "SettentViewController.h"
#import "Utility.h"
#import "DiaryViewController.h"

@interface SettentViewController ()

@end

@implementation SettentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
 
    if (!iPad) {
        self = [super initWithNibName:@"SettentViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"SettentViewController3.5" bundle:nibBundleOrNil];
    }

    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [hendLabelFont setText:[Utility getStringByKey:@"HealthReach Calendar"]];
    hendLabelFont.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [isOK setTitle:[Utility getStringByKey:@"btn_ok"] forState:UIControlStateNormal];
        isOK.titleLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString * ismHEalth=[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];
    
    UILabel *_youMayImport=[[UILabel alloc]initWithFrame:CGRectMake(20, 45+35, 280, 75)];
    
    _youMayImport.textColor= [UIColor colorWithRed:50/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    _youMayImport.numberOfLines=5;
    _youMayImport.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    _youMayImport.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_youMayImport];
    
    if (self.isCalendar==1)
    {
        if ([ismHEalth isEqualToString:@"HealthReach Calendar"])
        {
            //
            //
            NSLog(@"----------------------en off");
     
            _youMayImport.text=@"All events from HealthReach Calendar has been removed.";
    
        }
        else
        {
            //
            NSLog(@"----------------------ch off");
    
            _youMayImport.text=@"日程輸出已成功關掉";
        }
    }
    else
    {
        if ([ismHEalth isEqualToString:@"HealthReach Calendar"]) {
            //
            NSLog(@"----------------------en on");
            
            //
            _youMayImport.text=@"HealthReach Calendar’s event(s) has been successfully imported in to your handset's default calendar.";
    
        }
        else
        {
            NSLog(@"----------------------ch on");
            
      
            _youMayImport.text=@"健易達行事曆的日程已成功輸出至手機內的預設行事曆";
          
            
       
            
        }
    }
    
    


    
    NSLog(@"self.isCalendar====%d",self.isCalendar);
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)goHome:(id)sender
{
           [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: 1] animated:YES];
}
-(IBAction)isOK:(id)sender
{
    DiaryViewController * diary=[[DiaryViewController alloc]initWithNibName:@"DiaryViewController" bundle:nil];
//    diary.isCalendar=self.isCalendar;
    [self.navigationController pushViewController:diary animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
