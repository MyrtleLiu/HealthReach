//
//  StartingFromBronzeViewController.m
//  mHealth
//
//  Created by gz dev team on 14年2月25日.
//
//

#import "StartingFromBronzeViewController.h"
#import "WalkForHealthViewController.h"
#import "HomeViewController.h"
#import "CurrentWeeklyProgressViewController.h"
@interface StartingFromBronzeViewController ()

@end

@implementation StartingFromBronzeViewController

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
    //hr_walk_program_bg_bronze  hr_walk_program_bg_gold  hr_walk_program_bg_diamond  hr_walk_program_bg_silver
    //hr_icon_tp_award_bronze_b
    self.addView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.addView.backgroundColor=[UIColor whiteColor];
    self.addView.alpha=0.8;
    
   imageView=[[UIImageView alloc] initWithFrame:CGRectMake(40, 180, 240, 200)];
    imageView.backgroundColor=[UIColor blackColor];
    imageView.layer.cornerRadius = 12;//设置那个圆角的有多圆
    imageView.userInteractionEnabled=YES;
    imageView.alpha=1;
    [self.view addSubview:imageView];
    UILabel*longlongLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 40, 200, 100)];
    longlongLabel.text=@"Do you want to set a reminder";
    longlongLabel.textColor=[UIColor whiteColor];
    longlongLabel.numberOfLines=2;
    longlongLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:24];
    [imageView addSubview:longlongLabel];
    
    NSString*str11=[[NSBundle mainBundle] pathForResource:@"hr_btn_wa_red_1" ofType:@"png"];
    NSString*str22=[[NSBundle mainBundle]pathForResource:@"hr_btn_wa_green_2" ofType:@"png"];
    UIImage*redImage=[[UIImage alloc] initWithContentsOfFile:str11];
    UIImage*greenImage=[[UIImage alloc]initWithContentsOfFile:str22];
    UIButton*noButton=[UIButton buttonWithType:UIButtonTypeCustom];
    noButton.frame=CGRectMake(20, 150, 90, 40);
    [noButton setImage:redImage forState:UIControlStateNormal];
    [noButton addTarget:self action:@selector(addbuttonNO) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:noButton];
    UIButton*yesButton=[UIButton buttonWithType:UIButtonTypeCustom];
    yesButton.frame=CGRectMake(130, 150, 90, 40);
    [yesButton setImage:greenImage forState:UIControlStateNormal];
    [yesButton addTarget:self action:@selector(addbuttonYew) forControlEvents:UIControlEventTouchUpInside];
     [imageView addSubview:yesButton];
    imageView.hidden=YES;
    UILabel*noLabel=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 30, 30) ];
    noLabel.text=@"No";
    noLabel.textColor=[UIColor whiteColor];
    [noButton addSubview:noLabel];
    
    UILabel*yesLabel=[[UILabel alloc]initWithFrame:CGRectMake(32, 5, 30, 30)];
    yesLabel.textColor=[UIColor whiteColor];
    yesLabel.text=@"Yes";
    [yesButton addSubview:yesLabel];
    
    
    
    
    [self.view addSubview:self.addView];
    self.addView.hidden=YES;
    
    NSString*gold1=[[NSBundle mainBundle]pathForResource:@"hr_icon_tp_award_bronze_b" ofType:@"png" ];
    UIImage*goldImage1=[[UIImage alloc] initWithContentsOfFile:gold1];
   _goldImageView1=[[UIImageView alloc]initWithImage:goldImage1];
    _goldImageView1.frame=CGRectMake(20, 20, 25, 25);
   bronze1=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 70, 25)];
    bronze1.adjustsFontSizeToFitWidth=YES;
    bronze1.textColor=[UIColor whiteColor];
    bronze1.text=@"Bronze";
    forBeginner1=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 80, 20)];
    forBeginner1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner1.adjustsFontSizeToFitWidth=YES;
    forBeginner1.textColor=[UIColor whiteColor];
    forBeginner1.text=@"for Beginner";
    _30min1=[[UILabel alloc ]initWithFrame:CGRectMake(140, 30, 50, 20 )];
        _30min1.text=@"30min";
    _30min1.adjustsFontSizeToFitWidth=YES;
    _30min1.textColor=[UIColor whiteColor];
    _days1=[[UILabel alloc]initWithFrame:CGRectMake(190, 30, 50, 20)];
    _days1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days1.adjustsFontSizeToFitWidth=YES;
    _days1.text=@"/days,";
    _days1.textColor=[UIColor whiteColor];
    
    _5days1=[[UILabel alloc ]initWithFrame:CGRectMake(70, 50, 40, 20 )];
    _5days1.text=@"5days";
    _5days1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days1.adjustsFontSizeToFitWidth=YES;
    _5days1.textColor=[UIColor whiteColor];
    _week1=[[UILabel alloc]initWithFrame:CGRectMake(110, 50, 50, 20)];
    _week1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week1.adjustsFontSizeToFitWidth=YES;
    _week1.text=@"/week,";
    _week1.textColor=[UIColor whiteColor];
   gentlePace1=[[UILabel alloc]initWithFrame:CGRectMake(160, 50, 70, 20)];
    gentlePace1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace1.adjustsFontSizeToFitWidth=YES;
    gentlePace1.text=@"gantle pace";
    gentlePace1.textColor=[UIColor whiteColor];

    
    NSString*gold2=[[NSBundle mainBundle]pathForResource:@"hr_icon_tp_award_silver_b" ofType:@"png" ];
    UIImage*goldImage2=[[UIImage alloc] initWithContentsOfFile:gold2];
   _goldImageView2=[[UIImageView alloc]initWithImage:goldImage2];
    _goldImageView2.frame=CGRectMake(20, 20, 25, 25);
   bronze2=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 70, 25)];
    bronze2.adjustsFontSizeToFitWidth=YES;
    bronze2.textColor=[UIColor whiteColor];
    bronze2.text=@"Silver";
   forBeginner2=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 80, 20)];
    forBeginner2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner2.adjustsFontSizeToFitWidth=YES;
    forBeginner2.textColor=[UIColor whiteColor];
    forBeginner2.text=@"for Amatures";
   _30min2=[[UILabel alloc ]initWithFrame:CGRectMake(140, 30, 50, 20 )];
    _30min2.text=@"45min";
    _30min2.adjustsFontSizeToFitWidth=YES;
    _30min2.textColor=[UIColor whiteColor];
   _days2=[[UILabel alloc]initWithFrame:CGRectMake(190, 30, 50, 20)];
    _days2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days2.adjustsFontSizeToFitWidth=YES;
    _days2.text=@"/days,";
    _days2.textColor=[UIColor whiteColor];
    
    _5days2=[[UILabel alloc ]initWithFrame:CGRectMake(70, 50, 40, 20 )];
    _5days2.text=@"5days";
    _5days2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days2.adjustsFontSizeToFitWidth=YES;
    _5days2.textColor=[UIColor whiteColor];
   _week2=[[UILabel alloc]initWithFrame:CGRectMake(110, 50, 50, 20)];
    _week2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week2.adjustsFontSizeToFitWidth=YES;
    _week2.text=@"/week,";
    _week2.textColor=[UIColor whiteColor];
   gentlePace2=[[UILabel alloc]initWithFrame:CGRectMake(160, 50, 70, 20)];
    gentlePace2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace2.adjustsFontSizeToFitWidth=YES;
    gentlePace2.text=@"gantle pace";
    gentlePace2.textColor=[UIColor whiteColor];
    
   NSString* gold3=[[NSBundle mainBundle]pathForResource:@"hr_icon_tp_award_gold_b" ofType:@"png" ];
    UIImage*goldImage3=[[UIImage alloc] initWithContentsOfFile:gold3];
  _goldImageView3=[[UIImageView alloc]initWithImage:goldImage3];
    _goldImageView3.frame=CGRectMake(20, 20, 25, 25);
   bronze3=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 70, 25)];
    bronze3.adjustsFontSizeToFitWidth=YES;
    bronze3.textColor=[UIColor whiteColor];
    bronze3.text=@"Gold";
    forBeginner3=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 80, 20)];
    forBeginner3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner3.adjustsFontSizeToFitWidth=YES;
    forBeginner3.textColor=[UIColor whiteColor];
    forBeginner3.text=@"for Intermediates";
    _30min3=[[UILabel alloc ]initWithFrame:CGRectMake(140, 30, 50, 20 )];
    _30min3.text=@"60min";
    _30min3.adjustsFontSizeToFitWidth=YES;
    _30min3.textColor=[UIColor whiteColor];
    _days3=[[UILabel alloc]initWithFrame:CGRectMake(190, 30, 50, 20)];
    _days3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days3.adjustsFontSizeToFitWidth=YES;
    _days3.text=@"/days,";
    _days3.textColor=[UIColor whiteColor];
   _5days3=[[UILabel alloc ]initWithFrame:CGRectMake(70, 50, 40, 20 )];
    _5days3.text=@"5days";
    _5days3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days3.adjustsFontSizeToFitWidth=YES;
    _5days3.textColor=[UIColor whiteColor];
    _week3=[[UILabel alloc]initWithFrame:CGRectMake(110, 50, 50, 20)];
    _week3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week3.adjustsFontSizeToFitWidth=YES;
    _week3.text=@"/week,";
    _week3.textColor=[UIColor whiteColor];
   gentlePace3=[[UILabel alloc]initWithFrame:CGRectMake(160, 50, 70, 20)];
    gentlePace3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace3.adjustsFontSizeToFitWidth=YES;
    gentlePace3.text=@"brisk pace";
    gentlePace3.textColor=[UIColor whiteColor];
    
    
    NSString*gold4=[[NSBundle mainBundle]pathForResource:@"hr_icon_tp_award_diamond_b" ofType:@"png" ];
    UIImage*goldImage4=[[UIImage alloc] initWithContentsOfFile:gold4];
   _goldImageView4=[[UIImageView alloc]initWithImage:goldImage4];
    _goldImageView4.frame=CGRectMake(20, 20, 25, 25);
    bronze4=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 70, 25)];
    bronze4.adjustsFontSizeToFitWidth=YES;
    bronze4.textColor=[UIColor whiteColor];
    bronze4.text=@"Diamond";
   forBeginner4=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 80, 20)];
    forBeginner4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner4.adjustsFontSizeToFitWidth=YES;
    forBeginner4.textColor=[UIColor whiteColor];
    forBeginner4.text=@"for Athletes";
    _30min4=[[UILabel alloc ]initWithFrame:CGRectMake(140, 30, 50, 20 )];
    _30min4.text=@"75min";
    _30min4.adjustsFontSizeToFitWidth=YES;
    _30min4.textColor=[UIColor whiteColor];
    _days4=[[UILabel alloc]initWithFrame:CGRectMake(190, 30, 50, 20)];
    _days4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days4.adjustsFontSizeToFitWidth=YES;
    _days4.text=@"/days,";
    _days4.textColor=[UIColor whiteColor];
    NSString*str=[[NSBundle mainBundle] pathForResource:@"hr_btn_wa_green_2" ofType:@"png"];
    UIImage*_image=[[UIImage alloc] initWithContentsOfFile:str];
    
    
    
    _5days4=[[UILabel alloc ]initWithFrame:CGRectMake(70, 50, 40, 20 )];
    _5days4.text=@"5days";
    _5days4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days4.adjustsFontSizeToFitWidth=YES;
    _5days4.textColor=[UIColor whiteColor];
    _week4=[[UILabel alloc]initWithFrame:CGRectMake(110, 50, 50, 20)];
    _week4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week4.adjustsFontSizeToFitWidth=YES;
    _week4.text=@"/week,";
    _week4.textColor=[UIColor whiteColor];
   gentlePace4=[[UILabel alloc]initWithFrame:CGRectMake(160, 50, 70, 20)];
    gentlePace4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace4.adjustsFontSizeToFitWidth=YES;
    gentlePace4.text=@"fast pace";
    gentlePace4.textColor=[UIColor whiteColor];
    
    
    
    greenButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    greenButton1.frame=CGRectMake(160, 70, 100, 35);
    [greenButton1 setImage:_image forState:UIControlStateNormal];
    label1=[[UILabel alloc] initWithFrame:CGRectMake(30, 2, 50, 30)];
    label1.textColor=[UIColor whiteColor];
    label1.text=@"Start";
    [greenButton1 addSubview:label1];
    [greenButton1 addTarget:self  action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    
    
    greenButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    greenButton2.frame=CGRectMake(160, 70, 100, 35);
    [greenButton2 setImage:_image forState:UIControlStateNormal];
    label2=[[UILabel alloc] initWithFrame:CGRectMake(30, 2, 50, 30)];
    label2.textColor=[UIColor whiteColor];
    label2.text=@"Start";
    [greenButton2 addSubview:label2];
    [greenButton2 addTarget:self  action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    
    greenButton3=[UIButton buttonWithType:UIButtonTypeCustom];
    greenButton3.frame=CGRectMake(160, 70, 100, 35);
    [greenButton3 setImage:_image forState:UIControlStateNormal];
    label3=[[UILabel alloc] initWithFrame:CGRectMake(30, 2, 50, 30)];
    label3.textColor=[UIColor whiteColor];
    label3.text=@"Start";
    [greenButton3 addSubview:label3];
    [greenButton3 addTarget:self  action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    
    greenButton4=[UIButton buttonWithType:UIButtonTypeCustom];
    greenButton4.frame=CGRectMake(160, 70, 100, 35);
    [greenButton4 setImage:_image forState:UIControlStateNormal];
    label4=[[UILabel alloc] initWithFrame:CGRectMake(30, 2, 50, 30)];
    label4.textColor=[UIColor whiteColor];
    label4.text=@"Start";
    [greenButton4 addSubview:label4];
    [greenButton4 addTarget:self  action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];

    NSString*str1=[[NSBundle mainBundle]pathForResource:@"hr_walk_program_bg_bronze" ofType:@"png" ];
    UIImage*image1=[[UIImage alloc] initWithContentsOfFile:str1];
    buttonBrown=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonBrown.frame=CGRectMake(40,180,240,80);
    [buttonBrown setImage:image1 forState:UIControlStateNormal];
    [buttonBrown addTarget:self action:@selector(Brown) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBrown];
    [buttonBrown addSubview:_goldImageView1];
    [buttonBrown  addSubview:bronze1];
    [buttonBrown addSubview:forBeginner1];
    [buttonBrown addSubview:_30min1];
    [buttonBrown addSubview:_days1];
    [buttonBrown addSubview:_5days1];
    [buttonBrown addSubview:_week1];
    [buttonBrown addSubview:gentlePace1];
       [buttonBrown addSubview:greenButton1];
    
    
    NSString*str2=[[NSBundle mainBundle]pathForResource:@"hr_walk_program_bg_silver" ofType:@"png" ];
    UIImage*image2=[[UIImage alloc] initWithContentsOfFile:str2];
    buttonGlay=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonGlay.frame=CGRectMake(40,250,240,80);
    [buttonGlay setImage:image2 forState:UIControlStateNormal];
    [buttonGlay addTarget:self action:@selector(Glay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonGlay];
    [buttonGlay addSubview:_goldImageView2];
    [buttonGlay addSubview:bronze2];
    [buttonGlay addSubview:forBeginner2];
    [buttonGlay addSubview:_30min2];
    [buttonGlay addSubview:_days2];
    [buttonGlay addSubview:_5days2];
    [buttonGlay addSubview:_week2];
    [buttonGlay addSubview:gentlePace2];
    [buttonGlay addSubview:greenButton2];
       [buttonGlay addSubview:greenButton2];
    
    NSString*str3=[[NSBundle mainBundle]pathForResource:@"hr_walk_program_bg_gold" ofType:@"png" ];
    UIImage*image3=[[UIImage alloc] initWithContentsOfFile:str3];
    buttonYellow=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonYellow.frame=CGRectMake(40,320,240,80);
    [buttonYellow setImage:image3 forState:UIControlStateNormal];
    [buttonYellow addTarget:self action:@selector(Yellow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonYellow];
    [buttonYellow addSubview:_goldImageView3];
    [buttonYellow addSubview:bronze3];
    [buttonYellow addSubview:forBeginner3];
    [buttonYellow addSubview:_30min3];
    [buttonYellow addSubview:_days3];
    [buttonYellow addSubview:_5days3];
    [buttonYellow addSubview:_week3];
    [buttonYellow addSubview:gentlePace3];
       [buttonYellow addSubview:greenButton3];
    
    
    NSString*str4=[[NSBundle mainBundle]pathForResource:@"hr_walk_program_bg_diamond" ofType:@"png" ];
    UIImage*image4=[[UIImage alloc] initWithContentsOfFile:str4];
    buttonBlue=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonBlue.frame=CGRectMake(40,390,240,80);
    [buttonBlue setImage:image4 forState:UIControlStateNormal];
    [buttonBlue addTarget:self action:@selector(Blue) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBlue];
    [buttonBlue addSubview:_goldImageView4];
    [buttonBlue addSubview:bronze4];
    [buttonBlue addSubview:forBeginner4];
    [buttonBlue addSubview:_30min4];
    [buttonBlue addSubview:_days4];
    [buttonBlue addSubview:_5days4];
    [buttonBlue addSubview:_week4];
    [buttonBlue addSubview:gentlePace4];
    [buttonBlue addSubview:greenButton4];
    greenButton1.hidden=YES;
    greenButton2.hidden=YES;
    greenButton3.hidden=YES;
    greenButton4.hidden=YES;
    [self.view bringSubviewToFront:buttonBlue];
    [self.view bringSubviewToFront:buttonYellow];
    [self.view bringSubviewToFront:buttonGlay];
     [self.view bringSubviewToFront:buttonBrown];
    
}
-(void)Brown
{
    buttonBrown.frame=CGRectMake(20,160,280,120);
    buttonGlay.frame=CGRectMake(40,250,240,80);
    buttonYellow.frame=CGRectMake(40,320,240,80);
    buttonBlue.frame=CGRectMake(40,390,240,80);
    
    
    _goldImageView1.frame=CGRectMake(30, 20, 25, 25);
      bronze1.frame=CGRectMake(55, 5, 60, 40);
    forBeginner1.frame=CGRectMake(120, 12, 100, 30);
    _30min1.frame=CGRectMake(55, 30, 40, 40);
    _days1.frame=CGRectMake(95, 37, 40, 30);
    _5days1.frame=CGRectMake(140, 30, 40, 40);
    _week1.frame=CGRectMake(180, 37, 40, 30);
    gentlePace1.frame=CGRectMake(55, 60, 70, 40);
    _30min1.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    bronze1.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    _5days1.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    gentlePace1.font=[UIFont fontWithName:@"Helvetica Neue" size:18];
    
    
    bronze2.frame=CGRectMake(50, 10, 70, 25);
    forBeginner2.frame=CGRectMake(50, 30, 80, 20);
    _30min2.frame=CGRectMake(140, 30, 50, 20 );
    _days2.frame=CGRectMake(190, 30, 50, 20);
    _5days2.frame=CGRectMake(70, 50, 40, 20 );
    _week2.frame=CGRectMake(110, 50, 50, 20);
    gentlePace2.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView2.frame=CGRectMake(20, 20, 25, 25);
    bronze2.adjustsFontSizeToFitWidth=YES;
    forBeginner2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner2.adjustsFontSizeToFitWidth=YES;
    _30min2.adjustsFontSizeToFitWidth=YES;
    _days2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days2.adjustsFontSizeToFitWidth=YES;
    _5days2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days2.adjustsFontSizeToFitWidth=YES;
    _week2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week2.adjustsFontSizeToFitWidth=YES;
    gentlePace2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace2.adjustsFontSizeToFitWidth=YES;

    bronze3.frame=CGRectMake(50, 10, 70, 25);
    forBeginner3.frame=CGRectMake(50, 30, 80, 20);
    _30min3.frame=CGRectMake(140, 30, 50, 20 );
    _days3.frame=CGRectMake(190, 30, 50, 20);
    _5days3.frame=CGRectMake(70, 50, 40, 20 );
    _week3.frame=CGRectMake(110, 50, 50, 20);
    gentlePace3.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView3.frame=CGRectMake(20, 20, 25, 25);
    bronze3.adjustsFontSizeToFitWidth=YES;
    forBeginner3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner3.adjustsFontSizeToFitWidth=YES;
    _30min3.adjustsFontSizeToFitWidth=YES;
    _days3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days3.adjustsFontSizeToFitWidth=YES;
    _5days3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days3.adjustsFontSizeToFitWidth=YES;
    _week3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week3.adjustsFontSizeToFitWidth=YES;
    gentlePace3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace3.adjustsFontSizeToFitWidth=YES;
    
    bronze4.frame=CGRectMake(50, 10, 70, 25);
    forBeginner4.frame=CGRectMake(50, 30, 80, 20);
    _30min4.frame=CGRectMake(140, 30, 50, 20 );
    _days4.frame=CGRectMake(190, 30, 50, 20);
    _5days4.frame=CGRectMake(70, 50, 40, 20 );
    _week4.frame=CGRectMake(110, 50, 50, 20);
    gentlePace4.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView4.frame=CGRectMake(20, 20, 25, 25);
    bronze4.adjustsFontSizeToFitWidth=YES;
    forBeginner4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner4.adjustsFontSizeToFitWidth=YES;
    _30min4.adjustsFontSizeToFitWidth=YES;
    _days4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days4.adjustsFontSizeToFitWidth=YES;
    _5days4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days4.adjustsFontSizeToFitWidth=YES;
    _week4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week4.adjustsFontSizeToFitWidth=YES;
    gentlePace4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace4.adjustsFontSizeToFitWidth=YES;
    

    
    
    greenButton1.hidden=NO;
    greenButton2.hidden=YES;
     greenButton3.hidden=YES;
     greenButton4.hidden=YES;
    [self.view bringSubviewToFront:buttonBlue];
    [self.view bringSubviewToFront:buttonYellow];
    [self.view bringSubviewToFront:buttonGlay];
    [self.view bringSubviewToFront:buttonBrown];
}
-(void)Glay
{
    buttonGlay.frame=CGRectMake(20, 230, 280, 120);
    buttonBrown.frame=CGRectMake(40,180,240,80);
    buttonYellow.frame=CGRectMake(40,320,240,80);
    buttonBlue.frame=CGRectMake(40,390,240,80);
    
    _goldImageView2.frame=CGRectMake(30, 20, 25, 25);
    bronze2.frame=CGRectMake(55, 5, 60, 40);
    forBeginner2.frame=CGRectMake(120, 12, 100, 30);
    _30min2.frame=CGRectMake(55, 30, 40, 40);
    _days2.frame=CGRectMake(95, 37, 40, 30);
    _5days2.frame=CGRectMake(140, 30, 40, 40);
    _week2.frame=CGRectMake(180, 37, 40, 30);
    gentlePace2.frame=CGRectMake(55, 60, 70, 40);
    _30min2.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    bronze2.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    _5days2.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    gentlePace2.font=[UIFont fontWithName:@"Helvetica Neue" size:18];

    
    
    bronze1.frame=CGRectMake(50, 10, 70, 25);
    forBeginner1.frame=CGRectMake(50, 30, 80, 20);
    _30min1.frame=CGRectMake(140, 30, 50, 20 );
    _days1.frame=CGRectMake(190, 30, 50, 20);
    _5days1.frame=CGRectMake(70, 50, 40, 20 );
    _week1.frame=CGRectMake(110, 50, 50, 20);
    gentlePace1.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView1.frame=CGRectMake(20, 20, 25, 25);
    bronze1.adjustsFontSizeToFitWidth=YES;
    forBeginner1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner1.adjustsFontSizeToFitWidth=YES;
    _30min1.adjustsFontSizeToFitWidth=YES;
    _days1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days1.adjustsFontSizeToFitWidth=YES;
    _5days1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days1.adjustsFontSizeToFitWidth=YES;
    _week1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week1.adjustsFontSizeToFitWidth=YES;
    gentlePace1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace1.adjustsFontSizeToFitWidth=YES;
    
    bronze3.frame=CGRectMake(50, 10, 70, 25);
    forBeginner3.frame=CGRectMake(50, 30, 80, 20);
    _30min3.frame=CGRectMake(140, 30, 50, 20 );
    _days3.frame=CGRectMake(190, 30, 50, 20);
    _5days3.frame=CGRectMake(70, 50, 40, 20 );
    _week3.frame=CGRectMake(110, 50, 50, 20);
    gentlePace3.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView3.frame=CGRectMake(20, 20, 25, 25);
    bronze3.adjustsFontSizeToFitWidth=YES;
    forBeginner3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner3.adjustsFontSizeToFitWidth=YES;
    _30min3.adjustsFontSizeToFitWidth=YES;
    _days3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days3.adjustsFontSizeToFitWidth=YES;
    _5days3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days3.adjustsFontSizeToFitWidth=YES;
    _week3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week3.adjustsFontSizeToFitWidth=YES;
    gentlePace3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace3.adjustsFontSizeToFitWidth=YES;
    
    bronze4.frame=CGRectMake(50, 10, 70, 25);
    forBeginner4.frame=CGRectMake(50, 30, 80, 20);
    _30min4.frame=CGRectMake(140, 30, 50, 20 );
    _days4.frame=CGRectMake(190, 30, 50, 20);
    _5days4.frame=CGRectMake(70, 50, 40, 20 );
    _week4.frame=CGRectMake(110, 50, 50, 20);
    gentlePace4.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView4.frame=CGRectMake(20, 20, 25, 25);
    bronze4.adjustsFontSizeToFitWidth=YES;
    forBeginner4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner4.adjustsFontSizeToFitWidth=YES;
    _30min4.adjustsFontSizeToFitWidth=YES;
    _days4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days4.adjustsFontSizeToFitWidth=YES;
    _5days4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days4.adjustsFontSizeToFitWidth=YES;
    _week4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week4.adjustsFontSizeToFitWidth=YES;
    gentlePace4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace4.adjustsFontSizeToFitWidth=YES;
    
    
    
    greenButton2.hidden=NO;
    greenButton1.hidden=YES;
  
    greenButton3.hidden=YES;
    greenButton4.hidden=YES;
    [self.view bringSubviewToFront:buttonBlue];
     [self.view bringSubviewToFront:buttonBrown];
    [self.view bringSubviewToFront:buttonYellow];
    [self.view bringSubviewToFront:buttonGlay];
   
}

-(void)Yellow
{
    buttonBrown.frame=CGRectMake(40,180,240,80);
    buttonGlay.frame=CGRectMake(40,250,240,80);
    buttonYellow.frame=CGRectMake(20,300,280,120);
    buttonBlue.frame=CGRectMake(40,390,240,80);
    _goldImageView3.frame=CGRectMake(30, 20, 25, 25);
    bronze3.frame=CGRectMake(55, 5, 60, 40);
    forBeginner3.frame=CGRectMake(120, 12, 100, 30);
    _30min3.frame=CGRectMake(55, 30, 40, 40);
    _days3.frame=CGRectMake(95, 37, 40, 30);
    _5days3.frame=CGRectMake(140, 30, 40, 40);
    _week3.frame=CGRectMake(180, 37, 40, 30);
    gentlePace3.frame=CGRectMake(55, 60, 70, 40);
    _30min3.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    bronze3.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    _5days3.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    gentlePace3.font=[UIFont fontWithName:@"Helvetica Neue" size:18];
    
    bronze2.frame=CGRectMake(50, 10, 70, 25);
    forBeginner2.frame=CGRectMake(50, 30, 80, 20);
    _30min2.frame=CGRectMake(140, 30, 50, 20 );
    _days2.frame=CGRectMake(190, 30, 50, 20);
    _5days2.frame=CGRectMake(70, 50, 40, 20 );
    _week2.frame=CGRectMake(110, 50, 50, 20);
    gentlePace2.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView2.frame=CGRectMake(20, 20, 25, 25);
    bronze2.adjustsFontSizeToFitWidth=YES;
    forBeginner2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner2.adjustsFontSizeToFitWidth=YES;
    _30min2.adjustsFontSizeToFitWidth=YES;
    _days2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days2.adjustsFontSizeToFitWidth=YES;
    _5days2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days2.adjustsFontSizeToFitWidth=YES;
    _week2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week2.adjustsFontSizeToFitWidth=YES;
    gentlePace2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace2.adjustsFontSizeToFitWidth=YES;
    
    bronze1.frame=CGRectMake(50, 10, 70, 25);
    forBeginner1.frame=CGRectMake(50, 30, 80, 20);
    _30min1.frame=CGRectMake(140, 30, 50, 20 );
    _days1.frame=CGRectMake(190, 30, 50, 20);
    _5days1.frame=CGRectMake(70, 50, 40, 20 );
    _week1.frame=CGRectMake(110, 50, 50, 20);
    gentlePace1.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView1.frame=CGRectMake(20, 20, 25, 25);
    bronze1.adjustsFontSizeToFitWidth=YES;
    forBeginner1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner1.adjustsFontSizeToFitWidth=YES;
    _30min1.adjustsFontSizeToFitWidth=YES;
    _days1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days1.adjustsFontSizeToFitWidth=YES;
    _5days1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days1.adjustsFontSizeToFitWidth=YES;
    _week1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week1.adjustsFontSizeToFitWidth=YES;
    gentlePace1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace1.adjustsFontSizeToFitWidth=YES;
    
    bronze4.frame=CGRectMake(50, 10, 70, 25);
    forBeginner4.frame=CGRectMake(50, 30, 80, 20);
    _30min4.frame=CGRectMake(140, 30, 50, 20 );
    _days4.frame=CGRectMake(190, 30, 50, 20);
    _5days4.frame=CGRectMake(70, 50, 40, 20 );
    _week4.frame=CGRectMake(110, 50, 50, 20);
    gentlePace4.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView4.frame=CGRectMake(20, 20, 25, 25);
    bronze4.adjustsFontSizeToFitWidth=YES;
    forBeginner4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner4.adjustsFontSizeToFitWidth=YES;
    _30min4.adjustsFontSizeToFitWidth=YES;
    _days4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days4.adjustsFontSizeToFitWidth=YES;
    _5days4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days4.adjustsFontSizeToFitWidth=YES;
    _week4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week4.adjustsFontSizeToFitWidth=YES;
    gentlePace4.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace4.adjustsFontSizeToFitWidth=YES;
    
    
    greenButton3.hidden=NO;
    greenButton2.hidden=YES;
    greenButton1.hidden=YES;
    greenButton4.hidden=YES;
    [self.view bringSubviewToFront:buttonBlue];
    [self.view bringSubviewToFront:buttonBrown];
    [self.view bringSubviewToFront:buttonGlay];
    [self.view bringSubviewToFront:buttonYellow];
}
-(void)Blue
{
    buttonBrown.frame=CGRectMake(40,180,240,80);
    buttonGlay.frame=CGRectMake(40,250,240,80);
    buttonYellow.frame=CGRectMake(40,320,240,80);
    buttonBlue.frame=CGRectMake(20,370,280,120);
    _goldImageView4.frame=CGRectMake(30, 20, 25, 25);
    bronze4.frame=CGRectMake(55, 5, 60, 40);
    forBeginner4.frame=CGRectMake(120, 12, 100, 30);
    _30min4.frame=CGRectMake(55, 30, 40, 40);
    _days4.frame=CGRectMake(95, 37, 40, 30);
    _5days4.frame=CGRectMake(140, 30, 40, 40);
    _week4.frame=CGRectMake(180, 37, 40, 30);
    gentlePace4.frame=CGRectMake(55, 60, 70, 40);
    _30min4.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    bronze4.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    _5days4.font=[UIFont fontWithName:@"Helvetica Neue" size:20];
    gentlePace4.font=[UIFont fontWithName:@"Helvetica Neue" size:18];
    
    
    bronze2.frame=CGRectMake(50, 10, 70, 25);
    forBeginner2.frame=CGRectMake(50, 30, 80, 20);
    _30min2.frame=CGRectMake(140, 30, 50, 20 );
    _days2.frame=CGRectMake(190, 30, 50, 20);
    _5days2.frame=CGRectMake(70, 50, 40, 20 );
    _week2.frame=CGRectMake(110, 50, 50, 20);
    gentlePace2.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView2.frame=CGRectMake(20, 20, 25, 25);
    bronze2.adjustsFontSizeToFitWidth=YES;
    forBeginner2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner2.adjustsFontSizeToFitWidth=YES;
    _30min2.adjustsFontSizeToFitWidth=YES;
    _days2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days2.adjustsFontSizeToFitWidth=YES;
    _5days2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days2.adjustsFontSizeToFitWidth=YES;
    _week2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week2.adjustsFontSizeToFitWidth=YES;
    gentlePace2.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace2.adjustsFontSizeToFitWidth=YES;
    
    bronze3.frame=CGRectMake(50, 10, 70, 25);
    forBeginner3.frame=CGRectMake(50, 30, 80, 20);
    _30min3.frame=CGRectMake(140, 30, 50, 20 );
    _days3.frame=CGRectMake(190, 30, 50, 20);
    _5days3.frame=CGRectMake(70, 50, 40, 20 );
    _week3.frame=CGRectMake(110, 50, 50, 20);
    gentlePace3.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView3.frame=CGRectMake(20, 20, 25, 25);
    bronze3.adjustsFontSizeToFitWidth=YES;
    forBeginner3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner3.adjustsFontSizeToFitWidth=YES;
    _30min3.adjustsFontSizeToFitWidth=YES;
    _days3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days3.adjustsFontSizeToFitWidth=YES;
    _5days3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days3.adjustsFontSizeToFitWidth=YES;
    _week3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week3.adjustsFontSizeToFitWidth=YES;
    gentlePace3.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace3.adjustsFontSizeToFitWidth=YES;
    
    bronze1.frame=CGRectMake(50, 10, 70, 25);
    forBeginner1.frame=CGRectMake(50, 30, 80, 20);
    _30min1.frame=CGRectMake(140, 30, 50, 20 );
    _days1.frame=CGRectMake(190, 30, 50, 20);
    _5days1.frame=CGRectMake(70, 50, 40, 20 );
    _week1.frame=CGRectMake(110, 50, 50, 20);
    gentlePace1.frame=CGRectMake(160, 50, 70, 20);
    _goldImageView1.frame=CGRectMake(20, 20, 25, 25);
    bronze1.adjustsFontSizeToFitWidth=YES;
    forBeginner1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    forBeginner1.adjustsFontSizeToFitWidth=YES;
    _30min1.adjustsFontSizeToFitWidth=YES;
    _days1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _days1.adjustsFontSizeToFitWidth=YES;
    _5days1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _5days1.adjustsFontSizeToFitWidth=YES;
    _week1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    _week1.adjustsFontSizeToFitWidth=YES;
    gentlePace1.font=[UIFont fontWithName:@"Helvetica Neue" size:14];
    gentlePace1.adjustsFontSizeToFitWidth=YES;
    
    greenButton4.hidden=NO;
    greenButton2.hidden=YES;
    greenButton3.hidden=YES;
    greenButton1.hidden=YES;

    [self.view bringSubviewToFront:buttonBrown];
    [self.view bringSubviewToFront:buttonGlay];
    [self.view bringSubviewToFront:buttonYellow];
    [self.view bringSubviewToFront:buttonBlue];
}

-(void)button1
{
    self.addView.hidden=NO;
      [self.view bringSubviewToFront:self.addView];
    imageView.hidden=NO;
     [self.view bringSubviewToFront:imageView];
}
-(void)addbuttonNO
{
    self.addView.hidden=YES;
    imageView.hidden=YES;
}
-(void)addbuttonYew
{
    
    self.nowDate=[NSDate date];
    
    CurrentWeeklyProgressViewController*current=[[CurrentWeeklyProgressViewController alloc]initWithNibName:@"CurrentWeeklyProgressViewController" bundle:nil];
    [self.navigationController pushViewController:current animated:YES];
    current.nowDate=self.nowDate;
}

-(IBAction)home:(id)sender
{
    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeView animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
