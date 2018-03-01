//
//  SaveCalendarViewController.m
//  mHealth
//
//  Created by gz dev team on 14年11月6日.
//
//

#import "SaveCalendarViewController.h"
#import "Utility.h"
#import "SettentViewController.h"
#import "DBHelper.h"
@interface SaveCalendarViewController ()

@end

@implementation SaveCalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
            self = [super initWithNibName:@"SaveCalendarViewController" bundle:nibBundleOrNil];
    }
    else
    {
            self = [super initWithNibName:@"SaveCalendarViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    mHealthHendTextFont.text=[Utility getStringByKey:@"HealthReach Calendar"];
    mHealthHendTextFont.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString * ismHEalth=[[NSString alloc]initWithString:[Utility getStringByKey:@"HealthReach Calendar"]];

    NSString * onChBtn=[[NSBundle mainBundle]pathForResource:@"set_btn_on" ofType:@"png"];
    UIImage * onChBtnImage=[[UIImage alloc]initWithContentsOfFile:onChBtn];
    
    NSString * offChBtn=[[NSBundle mainBundle]pathForResource:@"set_btn_off" ofType:@"png"];
    UIImage * offChBtnImage=[[UIImage alloc]initWithContentsOfFile:offChBtn];
    
    
    NSString * onEnBtn=[[NSBundle mainBundle]pathForResource:@"enbtnon" ofType:@"png"];
    UIImage * onEnBtnImage=[[UIImage alloc]initWithContentsOfFile:onEnBtn];
    
    NSString * offEnBtn=[[NSBundle mainBundle]pathForResource:@"enbtnoff" ofType:@"png"];
    UIImage * offEnBtnImage=[[UIImage alloc]initWithContentsOfFile:offEnBtn];
    
    
    
    NSString * onEnBack=[[NSBundle mainBundle]pathForResource:@"enbgon" ofType:@"png"];
    UIImage * onENBackGuand=[[UIImage alloc]initWithContentsOfFile:onEnBack];
    NSLog(@"%@",onENBackGuand);
    NSString * offEnBack=[[NSBundle mainBundle]pathForResource:@"enbgoff" ofType:@"png"];
    UIImage * offENBackGuand=[[UIImage alloc]initWithContentsOfFile:offEnBack];
    NSLog(@"%@",offENBackGuand);
    
    
    NSString * onCHBack=[[NSBundle mainBundle] pathForResource:@"set_bg_on" ofType:@"png"];
    
    UIImage * onCHBackGuand=[[UIImage alloc]initWithContentsOfFile:onCHBack];
    NSLog(@"%@",onCHBackGuand);
    NSString * offCHBack=[[NSBundle mainBundle] pathForResource:@"set_bg_off" ofType:@"png"];
    UIImage * offCHBackGuand=[[UIImage alloc]initWithContentsOfFile:offCHBack];
    NSLog(@"%@",offCHBackGuand);
    self.isCalendar=[DBHelper isSave];
    
    
    UILabel *_youMayImport=[[UILabel alloc]initWithFrame:CGRectMake(20, 25, 280, 85)];
   
    _youMayImport.textColor= [UIColor colorWithRed:50/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    _youMayImport.numberOfLines=5;
    _youMayImport.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:14];
    _youMayImport.backgroundColor=[UIColor clearColor];
    [textBackGoundView addSubview:_youMayImport];
    

    if (self.isCalendar==1)
    {
        if ([ismHEalth isEqualToString:@"HealthReach Calendar"])
        {
            //
          //
            NSLog(@"----------------------en off");
            onButton.hidden=YES;
            offButton.hidden=NO;
            _BTNONONON.image=onEnBtnImage;
            _BTOFFOFFOFF.hidden=YES;
            
            _youMayImport.text=@"You may switch off the importation from HealthReach Calendar to your handset's default calendar but all event(s) from HealthReach Calendar will be removed from your handset's default calendar.";
              _imageView.image=onENBackGuand;
          
                  offButton.frame=CGRectMake(0, 0, 280, 50);
        }
        else
        {
          //
            NSLog(@"----------------------ch off");

            onButton.hidden=YES;
            offButton.hidden=NO;
            _youMayImport.text=@"你可以關掉健易達行事曆的日程輸出至手機內的預設行事曆，所有日程將自動從手機的預設行事曆內移除。";

            onButton.hidden=YES;
            offButton.hidden=NO;
            _BTNONONON.image=onChBtnImage;
            _BTOFFOFFOFF.hidden=YES;
              offButton.frame=CGRectMake(0, 0, 280, 50);
               _imageView.image=onCHBackGuand;
        }
    }
    else
    {
        if ([ismHEalth isEqualToString:@"HealthReach Calendar"]) {
            //
            NSLog(@"----------------------en on");

       //
            _youMayImport.text=@"You may import HealthReach Calendar's event(s) to your handset's default calendar.Reminders will only be dispatched by HealthReach Calendar.";
         
            
            offButton.hidden=YES;
            onButton.hidden=NO;
            _BTOFFOFFOFF.image=offEnBtnImage;
            _BTNONONON.hidden=YES;
              onButton.frame=CGRectMake(0, 50, 280, 50);
            _imageView.image=offENBackGuand;
        }
        else
        {
            NSLog(@"----------------------ch on");

         //
            offButton.hidden=YES;
            onButton.hidden=NO;
            _youMayImport.text=@"你可以把健易達行事曆的日程輸出至手機內的預設行事曆。相關提示只會由健易達行事曆發出。";
        
            _BTOFFOFFOFF.image=offChBtnImage;
            _BTNONONON.hidden=YES;
              onButton.frame=CGRectMake(0, 50, 280, 50);
             _imageView.image=offCHBackGuand;
        
        }
    }
    
    
    
    
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
-(IBAction)ONtheCalendar:(id)sender
{
    SettentViewController *setten=[[SettentViewController alloc]initWithNibName:@"SettentViewController" bundle:nil];
    self.isCalendar=0;
   setten.isCalendar=0;
    
    [DBHelper addSaveCalendar:1];
    [DBHelper zhendeyouma:1];

    
    
    [self.navigationController pushViewController:setten animated:YES];
}
-(IBAction)OFFtheCalendar:(id)sender
{
    SettentViewController *setten=[[SettentViewController alloc]initWithNibName:@"SettentViewController" bundle:nil];
    self.isCalendar=1;
     setten.isCalendar=1;
       [DBHelper addSaveCalendar:2];
    [DBHelper zhendeyouma:2];
    [self.navigationController pushViewController:setten animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
