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
#import "Utility.h"
#import "LearnMoreFirstViewController.h"
@interface StartingFromBronzeViewController ()

@end

@implementation StartingFromBronzeViewController


int textFontSize=13;
int chooseTextFontSize=15;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (iPad) {
        
        
        self = [super initWithNibName:@"StartingFromBronzeViewController_ipad" bundle:nibBundleOrNil];
        
    }
    else{
        self =  [super initWithNibName:@"StartingFromBronzeViewController" bundle:nibBundleOrNil];
    }
    
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([[Utility getLanguageCode] isEqualToString:@"cn"]){
        
        textFontSize=13;
        chooseTextFontSize=15;
        
        
        NSLog(@"cn font size.....");
    }

    
    NSString *gold1=[[NSBundle mainBundle]pathForResource:@"07_tr_award_bronze_hr" ofType:@"png" ];
    UIImage *goldImage1=[[UIImage alloc] initWithContentsOfFile:gold1];
    _goldImageView1=[[UIImageView alloc]initWithImage:goldImage1];
    _goldImageView1.frame=CGRectMake(20, 20, 15, 15);
   
    bronze1=[[UILabel alloc] initWithFrame:CGRectMake(45, 17, 70, 25)];
    bronze1.textColor=[UIColor whiteColor];
    
    
    forBeginner1=[[UILabel alloc]initWithFrame:CGRectMake(45, 40, 180, 20)];
    forBeginner1.textColor=[UIColor whiteColor];
    

    
    _5days1=[[UILabel alloc ]initWithFrame:CGRectMake(45, 50, 140, 20 )];
    
    _5days1.textColor=[UIColor whiteColor];


    
    NSString*gold2=[[NSBundle mainBundle]pathForResource:@"07_tr_award_silver_hr" ofType:@"png" ];
    UIImage*goldImage2=[[UIImage alloc] initWithContentsOfFile:gold2];
    _goldImageView2=[[UIImageView alloc]initWithImage:goldImage2];
    _goldImageView2.frame=CGRectMake(20, 20, 15, 15);
    
    
    bronze2=[[UILabel alloc] initWithFrame:CGRectMake(45, 17, 70, 25)];
    bronze2.adjustsFontSizeToFitWidth=YES;
    bronze2.textColor=[UIColor whiteColor];
    
   
    forBeginner2=[[UILabel alloc]initWithFrame:CGRectMake(45, 35, 140, 20)];
    forBeginner2.textColor=[UIColor whiteColor];

    _5days2=[[UILabel alloc ]initWithFrame:CGRectMake(45, 50, 140, 20)];
    
    _5days2.textColor=[UIColor whiteColor];

    
    NSString* gold3=[[NSBundle mainBundle]pathForResource:@"07_tr_award_gold_hr" ofType:@"png" ];
    UIImage*goldImage3=[[UIImage alloc] initWithContentsOfFile:gold3];
    _goldImageView3=[[UIImageView alloc]initWithImage:goldImage3];
    _goldImageView3.frame=CGRectMake(20, 20, 25, 25);
    
    bronze3=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 70, 25)];
    bronze3.adjustsFontSizeToFitWidth=YES;
    bronze3.textColor=[UIColor whiteColor];
    
    
    forBeginner3=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 80, 20)];
    forBeginner3.textColor=[UIColor whiteColor];
    
    
    _5days3=[[UILabel alloc ]initWithFrame:CGRectMake(70, 50, 40, 20 )];
    
    _5days3.textColor=[UIColor whiteColor];
   
    
    
    NSString*gold4=[[NSBundle mainBundle]pathForResource:@"07_tr_award_diamond_hr" ofType:@"png" ];
    UIImage*goldImage4=[[UIImage alloc] initWithContentsOfFile:gold4];
    _goldImageView4=[[UIImageView alloc]initWithImage:goldImage4];
    _goldImageView4.frame=CGRectMake(20, 20, 25, 25);
   
    bronze4=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 70, 25)];
    bronze4.adjustsFontSizeToFitWidth=YES;
    bronze4.textColor=[UIColor whiteColor];
    
   
    forBeginner4=[[UILabel alloc]initWithFrame:CGRectMake(50, 30, 80, 20)];
    forBeginner4.textColor=[UIColor whiteColor];
    
    
    
    _5days4=[[UILabel alloc ]initWithFrame:CGRectMake(70, 50, 40, 20 )];
    
    _5days4.textColor=[UIColor whiteColor];
    
    
    
    
    NSString *str=[[NSBundle mainBundle] pathForResource:@"07_tr_btn_index_start" ofType:@"png"];
    UIImage *_image=[[UIImage alloc] initWithContentsOfFile:str];

    greenButton4=[UIButton buttonWithType:UIButtonTypeCustom];
    greenButton4.frame=CGRectMake(165, 70, 100, 29);
    greenButton4.tag=4;
    [greenButton4 setBackgroundImage:_image forState:UIControlStateNormal];
    
    greenButton4.titleLabel.textColor=[UIColor whiteColor];
    
    
    [greenButton4 addTarget:self  action:@selector(startTraining:) forControlEvents:UIControlEventTouchUpInside];
    
    
    greenButton3=[UIButton buttonWithType:UIButtonTypeCustom];
    greenButton3.frame=CGRectMake(165, 70, 100, 29);
    greenButton3.tag=3;
    [greenButton3 setBackgroundImage:_image forState:UIControlStateNormal];
    
    greenButton3.titleLabel.textColor=[UIColor whiteColor];
    
    
    [greenButton3 addTarget:self  action:@selector(startTraining:) forControlEvents:UIControlEventTouchUpInside];
    
    greenButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    greenButton2.frame=CGRectMake(165, 70, 100, 29);
    greenButton2.tag=2;
    [greenButton2 setBackgroundImage:_image forState:UIControlStateNormal];
    
    greenButton2.titleLabel.textColor=[UIColor whiteColor];
    
    
    [greenButton2 addTarget:self  action:@selector(startTraining:) forControlEvents:UIControlEventTouchUpInside];
    
    greenButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    greenButton1.frame=CGRectMake(165, 70, 100, 29);
    greenButton1.tag=1;
    [greenButton1 setBackgroundImage:_image forState:UIControlStateNormal];
    
    greenButton1.titleLabel.textColor=[UIColor whiteColor];

    [greenButton1 addTarget:self  action:@selector(startTraining:) forControlEvents:UIControlEventTouchUpInside];

    NSString*str1=[[NSBundle mainBundle]pathForResource:@"07_tr_btn_index_bronze" ofType:@"png" ];
    UIImage*image1=[[UIImage alloc] initWithContentsOfFile:str1];
    buttonBrown=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonBrown.frame=CGRectMake(40,390,240,80);//CGRectMake(40,180,240,80);
    [buttonBrown setImage:image1 forState:UIControlStateNormal];
    [buttonBrown addTarget:self action:@selector(chooseTheBronze) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBrown];
    [buttonBrown addSubview:_goldImageView1];
    [buttonBrown  addSubview:bronze1];
    [buttonBrown addSubview:forBeginner1];
    
    [buttonBrown addSubview:_5days1];
    
    [buttonBrown addSubview:greenButton1];
    
    
    NSString*str2=[[NSBundle mainBundle]pathForResource:@"07_tr_btn_index_silver" ofType:@"png" ];
    UIImage*image2=[[UIImage alloc] initWithContentsOfFile:str2];
    buttonGlay=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonGlay.frame=CGRectMake(40,320,240,80);//CGRectMake(40,250,240,80);
    [buttonGlay setImage:image2 forState:UIControlStateNormal];
    [buttonGlay addTarget:self action:@selector(chooseTheSilver) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonGlay];
    [buttonGlay addSubview:_goldImageView2];
    [buttonGlay addSubview:bronze2];
    [buttonGlay addSubview:forBeginner2];
    
    [buttonGlay addSubview:_5days2];
    
    [buttonGlay addSubview:greenButton2];
        
    NSString*str3=[[NSBundle mainBundle]pathForResource:@"07_tr_btn_index_good" ofType:@"png" ];
    UIImage*image3=[[UIImage alloc] initWithContentsOfFile:str3];
    buttonYellow=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonYellow.frame=CGRectMake(40,250,240,80);//CGRectMake(40,320,240,80);
    [buttonYellow setImage:image3 forState:UIControlStateNormal];
    [buttonYellow addTarget:self action:@selector(chooseTheGold) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonYellow];
    [buttonYellow addSubview:_goldImageView3];
    [buttonYellow addSubview:bronze3];
    [buttonYellow addSubview:forBeginner3];
    
    [buttonYellow addSubview:_5days3];
    
    [buttonYellow addSubview:greenButton3];
    
    
    NSString*str4=[[NSBundle mainBundle]pathForResource:@"07_tr_btn_index_diamond" ofType:@"png" ];
    UIImage*image4=[[UIImage alloc] initWithContentsOfFile:str4];
    buttonBlue=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonBlue.frame=CGRectMake(40,180,240,80);//CGRectMake(40,390,240,80);
    [buttonBlue setImage:image4 forState:UIControlStateNormal];
    [buttonBlue addTarget:self action:@selector(chooseTheDiamond) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBlue];
    [buttonBlue addSubview:_goldImageView4];
    [buttonBlue addSubview:bronze4];
    [buttonBlue addSubview:forBeginner4];
    
    [buttonBlue addSubview:_5days4];
    
    [buttonBlue addSubview:greenButton4];
    
    greenButton1.titleLabel.font=[UIFont fontWithName:font55 size:14];
    greenButton2.titleLabel.font=[UIFont fontWithName:font55 size:14];
    greenButton3.titleLabel.font=[UIFont fontWithName:font55 size:14];
    greenButton4.titleLabel.font=[UIFont fontWithName:font55 size:14];
    
    greenButton1.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    greenButton2.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    greenButton3.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    greenButton4.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    
    greenButton1.hidden=YES;
    greenButton2.hidden=YES;
    greenButton3.hidden=YES;
    greenButton4.hidden=YES;

    [self chooseTheBronze];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    self.actionTitle.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    
    [self.actionTitle setText:[Utility getStringByKey:@"w_train_title"]];
    
    [greenButton1 setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
    
    [greenButton2 setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
    [greenButton3 setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
    [greenButton4 setTitle:[Utility getStringByKey:@"tr_start"] forState:UIControlStateNormal];
    
    textLable.text=[Utility getStringByKey:@"tr_choose"];
    
    _5days4.text=[Utility getStringByKey:@"tr_days"];
    forBeginner4.text=[Utility getStringByKey:@"d_text_1"];
    bronze4.text=[Utility getStringByKey:@"w_diamond_title"];
    
    _5days3.text=[Utility getStringByKey:@"tr_days"];
    forBeginner3.text=[Utility getStringByKey:@"g_text_1"];
    bronze3.text=[Utility getStringByKey:@"w_gold_title"];
    
    _5days2.text=[Utility getStringByKey:@"tr_days"];
    forBeginner2.text=[Utility getStringByKey:@"s_text_1"];
    bronze2.text=[Utility getStringByKey:@"w_silver_title"];
    
    
    _5days1.text=[Utility getStringByKey:@"tr_days"];
    forBeginner1.text=[Utility getStringByKey:@"b_text_1"];
    bronze1.text=[Utility getStringByKey:@"w_bronze_title"];
    
    
    
     if (iPad) {
         _iphone4bg.frame=CGRectMake(0, 0, 297, 410);
     }

    
}

-(void)chooseTheDiamond
{
    buttonBrown.frame=CGRectMake(40,370,240,106);//CGRectMake(20,160,280,120);
    buttonGlay.frame=CGRectMake(40,300,240,106);//CGRectMake(40,250,240,80);
    buttonYellow.frame=CGRectMake(40,230,240,106);//CGRectMake(40,320,240,80);
    buttonBlue.frame=CGRectMake(20,140,275,122);//CGRectMake(40,390,240,80);
    if (iPad) {   //iphone4
        buttonBrown.frame=CGRectMake(40,355,240,106);//CGRectMake(20,160,280,120);
        buttonGlay.frame=CGRectMake(40,285,240,106);//CGRectMake(40,250,240,80);
        buttonYellow.frame=CGRectMake(40,215,240,106);//CGRectMake(40,320,240,80);
        buttonBlue.frame=CGRectMake(20,125,275,122);//CGRectMake(40,390,240,80);
    }
    
    
    bronze3.frame=CGRectMake(45, 14, 70, 25);
    bronze3.font=[UIFont fontWithName:font76 size:18];
    forBeginner3.frame=CGRectMake(45, 40, 180, 20);
    
    _5days3.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView3.frame=CGRectMake(20, 20, 15, 15);
    bronze3.adjustsFontSizeToFitWidth=YES;
    forBeginner3.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days3.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    bronze2.frame=CGRectMake(45, 14, 70, 25);
    bronze2.font=[UIFont fontWithName:font76 size:18];
    forBeginner2.frame=CGRectMake(45, 40, 180, 20);
    
    _5days2.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView2.frame=CGRectMake(20, 20, 15, 15);
    bronze2.adjustsFontSizeToFitWidth=YES;
    forBeginner2.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days2.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    
    bronze1.frame=CGRectMake(45, 14, 70, 25);
    bronze1.font=[UIFont fontWithName:font76 size:18];
    forBeginner1.frame=CGRectMake(45, 40, 180, 20);
    
    _5days1.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView1.frame=CGRectMake(20, 20, 15, 15);
    bronze1.adjustsFontSizeToFitWidth=YES;
    forBeginner1.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days1.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    
    
    
    
    bronze4.frame=CGRectMake(45, 10, 70, 25);
    forBeginner4.frame=CGRectMake(45, 40, 230, 20);
    
    _5days4.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView4.frame=CGRectMake(20, 20, 15, 15);
    
    bronze4.font=[UIFont fontWithName:font76 size:22];
    forBeginner4.font=[UIFont fontWithName:font56 size:chooseTextFontSize];
    
    _5days4.font=[UIFont fontWithName:font56 size:chooseTextFontSize];
    
    
    greenButton4.hidden=NO;
    greenButton3.hidden=YES;
     greenButton2.hidden=YES;
     greenButton1.hidden=YES;
    
    
    
    [self.view bringSubviewToFront:buttonBrown];
    
    [self.view bringSubviewToFront:buttonGlay];
    
    [self.view bringSubviewToFront:buttonYellow];
    
    [self.view bringSubviewToFront:buttonBlue];
}

-(void)chooseTheGold
{
   
    buttonGlay.frame=CGRectMake(40,300,240,106);//CGRectMake(20, 230, 280, 120);
    buttonBrown.frame=CGRectMake(40,370,240,106);//CGRectMake(40,180,240,80);
    buttonYellow.frame=CGRectMake(20, 210, 275, 122);//CGRectMake(40,320,240,80);
    buttonBlue.frame=CGRectMake(40,160,240,106);//CGRectMake(40,390,240,80);
    if (iPad) {   //iphone4
        buttonGlay.frame=CGRectMake(40,285,240,106);//CGRectMake(20, 230, 280, 120);
        buttonBrown.frame=CGRectMake(40,355,240,106);//CGRectMake(40,180,240,80);
        buttonYellow.frame=CGRectMake(20, 195, 275, 122);//CGRectMake(40,320,240,80);
        buttonBlue.frame=CGRectMake(40,145,240,106);//CGRectMake(40,390,240,80);
    }

    
    
    bronze4.frame=CGRectMake(45, 14, 70, 25);
    bronze4.font=[UIFont fontWithName:font76 size:18];
    forBeginner4.frame=CGRectMake(45, 40, 180, 20);
    
    _5days4.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView4.frame=CGRectMake(20, 20, 15, 15);
    bronze4.adjustsFontSizeToFitWidth=YES;
    forBeginner4.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days4.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    bronze2.frame=CGRectMake(45, 14, 70, 25);
    bronze2.font=[UIFont fontWithName:font76 size:18];
    forBeginner2.frame=CGRectMake(45, 40, 180, 20);
    
    _5days2.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView2.frame=CGRectMake(20, 20, 15, 15);
    bronze2.adjustsFontSizeToFitWidth=YES;
    forBeginner2.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days2.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    
    bronze1.frame=CGRectMake(45, 14, 70, 25);
    bronze1.font=[UIFont fontWithName:font76 size:18];
    forBeginner1.frame=CGRectMake(45, 40, 180, 20);
    
    _5days1.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView1.frame=CGRectMake(20, 20, 15, 15);
    bronze1.adjustsFontSizeToFitWidth=YES;
    forBeginner1.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days1.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    
    

    
    bronze3.frame=CGRectMake(45, 14, 70, 25);
    forBeginner3.frame=CGRectMake(45, 40, 230, 20);
    
    _5days3.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView3.frame=CGRectMake(20, 20, 15, 15);
    bronze3.adjustsFontSizeToFitWidth=YES;
    bronze3.font=[UIFont fontWithName:font76 size:22];
    forBeginner3.font=[UIFont fontWithName:font56 size:chooseTextFontSize];
    
    _5days3.font=[UIFont fontWithName:font56 size:chooseTextFontSize];
    
    
    
    
    greenButton2.hidden=YES;
    greenButton1.hidden=YES;
  
    greenButton3.hidden=NO;
    greenButton4.hidden=YES;
    
    [self.view bringSubviewToFront:buttonBlue];
    
    [self.view bringSubviewToFront:buttonBrown];
    
    
    
    [self.view bringSubviewToFront:buttonGlay];
    
    [self.view bringSubviewToFront:buttonYellow];
   
}

-(void)chooseTheSilver
{
    buttonBrown.frame=CGRectMake(40,370,240,106);//CGRectMake(40,180,240,80);
    buttonGlay.frame=CGRectMake(20,280,275,122);//CGRectMake(40,250,240,80);
    buttonYellow.frame=CGRectMake(40,230,240,106);//CGRectMake(20,300,280,120);
    buttonBlue.frame=CGRectMake(40,160,240,106);//CGRectMake(40,390,240,80);
    if (iPad) {   //iphone4
        buttonBrown.frame=CGRectMake(40,355,240,106);//CGRectMake(40,180,240,80);
        buttonGlay.frame=CGRectMake(20,265,275,122);//CGRectMake(40,250,240,80);
        buttonYellow.frame=CGRectMake(40,215,240,106);//CGRectMake(20,300,280,120);
        buttonBlue.frame=CGRectMake(40,145,240,106);//CGRectMake(40,390,240,80);
    }

    
    
    bronze4.frame=CGRectMake(45, 14, 70, 25);
    bronze4.font=[UIFont fontWithName:font76 size:18];
    forBeginner4.frame=CGRectMake(45, 40, 180, 20);
    
    _5days4.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView4.frame=CGRectMake(20, 20, 15, 15);
    bronze4.adjustsFontSizeToFitWidth=YES;
    forBeginner4.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days4.font=[UIFont fontWithName:font56 size:textFontSize];
    

    
    bronze3.frame=CGRectMake(45, 14, 70, 25);
    bronze3.font=[UIFont fontWithName:font76 size:18];
    forBeginner3.frame=CGRectMake(45, 40, 180, 20);
    
    _5days3.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView3.frame=CGRectMake(20, 20, 15, 15);
    bronze3.adjustsFontSizeToFitWidth=YES;
    forBeginner3.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days3.font=[UIFont fontWithName:font56 size:textFontSize];

    
    bronze1.frame=CGRectMake(45, 14, 70, 25);
    bronze1.font=[UIFont fontWithName:font76 size:18];
    forBeginner1.frame=CGRectMake(45, 40, 180, 20);
   
     _5days1.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView1.frame=CGRectMake(20, 20, 15, 15);
    bronze1.adjustsFontSizeToFitWidth=YES;
    forBeginner1.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days1.font=[UIFont fontWithName:font56 size:textFontSize];


    
    
    
    
    bronze2.frame=CGRectMake(45, 14, 70, 25);
    forBeginner2.frame=CGRectMake(45, 40, 230, 20);
    
    _5days2.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView2.frame=CGRectMake(20, 20, 15, 15);
    bronze2.adjustsFontSizeToFitWidth=YES;
    bronze2.font=[UIFont fontWithName:font76 size:22];
    forBeginner2.font=[UIFont fontWithName:font56 size:chooseTextFontSize];
    
    _5days2.font=[UIFont fontWithName:font56 size:chooseTextFontSize];
    
    
    
    
    greenButton3.hidden=YES;
    greenButton2.hidden=NO;
    greenButton1.hidden=YES;
    greenButton4.hidden=YES;
    [self.view bringSubviewToFront:buttonBlue];
    [self.view bringSubviewToFront:buttonBrown];
    
    [self.view bringSubviewToFront:buttonYellow];
    
    [self.view bringSubviewToFront:buttonGlay];
}
-(void)chooseTheBronze
{
    buttonBrown.frame=CGRectMake(20,350,275,122);//CGRectMake(40,180,240,80);
    buttonGlay.frame=CGRectMake(40,300,240,106);//CGRectMake(40,250,240,80);
    buttonYellow.frame=CGRectMake(40,230,240,106);//CGRectMake(40,320,240,80);
    buttonBlue.frame=CGRectMake(40,160,240,106);//CGRectMake(20,370,280,120);
    if (iPad) {   //iphone4
        buttonBrown.frame=CGRectMake(20,335,275,122);//CGRectMake(40,180,240,80);
        buttonGlay.frame=CGRectMake(40,285,240,106);//CGRectMake(40,250,240,80);
        buttonYellow.frame=CGRectMake(40,215,240,106);//CGRectMake(40,320,240,80);
        buttonBlue.frame=CGRectMake(40,145,240,106);//CGRectMake(20,370,280,120);
    }

    
    
    bronze4.frame=CGRectMake(45, 14, 70, 25);
    bronze4.font=[UIFont fontWithName:font76 size:18];
    forBeginner4.frame=CGRectMake(45, 40, 180, 20);
    
    _5days4.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView4.frame=CGRectMake(20, 20, 15, 15);
    bronze4.adjustsFontSizeToFitWidth=YES;
    forBeginner4.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days4.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    bronze2.frame=CGRectMake(45, 14, 70, 25);
    bronze2.font=[UIFont fontWithName:font76 size:18];
    forBeginner2.frame=CGRectMake(45, 40, 180, 20);
    
    _5days2.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView2.frame=CGRectMake(20, 20, 15, 15);
    bronze2.adjustsFontSizeToFitWidth=YES;
    forBeginner2.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days2.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    
    bronze3.frame=CGRectMake(45, 14, 70, 25);
    bronze3.font=[UIFont fontWithName:font76 size:18];
    forBeginner3.frame=CGRectMake(45, 40, 180, 20);
    
    _5days3.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView3.frame=CGRectMake(20, 20, 15, 15);
    bronze3.adjustsFontSizeToFitWidth=YES;
    forBeginner3.font=[UIFont fontWithName:font56 size:textFontSize];
    
    _5days3.font=[UIFont fontWithName:font56 size:textFontSize];
    
    
    
    
    bronze1.frame=CGRectMake(45, 11, 70, 25);
    forBeginner1.frame=CGRectMake(45, 40, 220, 20);
    
     _5days1.frame=CGRectMake(45, 55, 140, 20 );
    
    _goldImageView1.frame=CGRectMake(20, 20, 15, 15);
    bronze1.adjustsFontSizeToFitWidth=YES;
    bronze1.font=[UIFont fontWithName:font76 size:22];
    forBeginner1.font=[UIFont fontWithName:font56 size:chooseTextFontSize];
    
    _5days1.font=[UIFont fontWithName:font56 size:chooseTextFontSize];

    
    NSLog(@"font size....%d,%d",textFontSize,chooseTextFontSize);
    
    greenButton4.hidden=YES;
    greenButton2.hidden=YES;
    greenButton3.hidden=YES;
    greenButton1.hidden=NO;

    
    
    [self.view bringSubviewToFront:buttonBlue];
    [self.view bringSubviewToFront:buttonYellow];
    [self.view bringSubviewToFront:buttonGlay];
    [self.view bringSubviewToFront:buttonBrown];

}

-(void)startTraining:(id)sender
{
    
     NSString*  strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"Done"]];

    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification *notification in notifications )
    {
        @try {
            
            if([[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp1"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp2"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp3"]||[[notification.userInfo objectForKey:@"title"] isEqualToString:@"tp4"])
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                
                
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    }
    GameObject *oldDBTP=  [DBHelper getTrophyProgress];
    NSString *oldprogress=[oldDBTP progress];
    int oldprogressINT=[oldprogress intValue];
    NSLog(@"%d",oldprogressINT);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    long nowTrainningtime= [[NSDate date] timeIntervalSince1970];
    NSString *oldDay1970=[[NSString alloc]initWithFormat:@"%ld",nowTrainningtime ];
    [defaults setObject:oldDay1970 forKey:@"Frist training time"];
    [defaults synchronize];

    

  
    if (oldprogressINT<5) {
        //前四次
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
        NSLog(@"%@", strDate);
        
        NSString *strTemp=[[NSString alloc]initWithFormat:@"%@ 9:00:00",strDate];
        
        
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date2 = [dateFormatter2 dateFromString:strTemp];
        NSLog(@"%@", date2);
        
        
        
        NSTimeInterval secondsPerDay2 = (24*60*60)*2;
        NSDate *tomorrow2 = [date2 dateByAddingTimeInterval:secondsPerDay2];
        NSDictionary*  dic=[[NSDictionary alloc]initWithObjectsAndKeys: @"tp2",@"title",nil];
        NSString *name2;
        if ([strTempTemp isEqualToString:@"Done"])
        {
            name2=@"Make a move and continue the Training Programme today or the medal count towards winning a trophy will be reset to 0.";
        }
        else
        {
            name2=@"今日就動起來,繼續你嘅「步⾏計劃」,不然,獎牌數⽬就會被重設至零,⽽你將須要從新累積獎牌以得到獎盃。";
        }
        
      
 
            [self resetClock:tomorrow2 timeNAme:name2 userInfo:dic];

    }
    if (oldprogressINT>4&&oldprogressINT<10) {
        //後五次
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
        NSLog(@"%@", strDate);
        
        NSString *strTemp=[[NSString alloc]initWithFormat:@"%@ 9:00:00",strDate];
        
        
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date2 = [dateFormatter2 dateFromString:strTemp];
        NSLog(@"%@", date2);
        
        
        
        NSTimeInterval secondsPerDay2 = (24*60*60)*2;
        NSDate *tomorrow2 = [date2 dateByAddingTimeInterval:secondsPerDay2];
        NSDictionary*  dic=[[NSDictionary alloc]initWithObjectsAndKeys: @"tp3",@"title",nil];
        NSString *name3;
        if ([strTempTemp isEqualToString:@"Done"])
        {
            name3=@"You are more than halfway to getting your trophy, don’t give up noCw and continue your training programme today.";
        }
        else
        {
            name3=@"你已完成超過一半獲取獎盃所需嘅路程,不要現在放棄,繼續你嘅「步行計劃」。";
        }
        
      
        
                    [self resetClock:tomorrow2 timeNAme:name3 userInfo:dic];

    }
    
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    if(session_id==NULL||login_id==NULL){
        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
        [historyView setType:@"walk"];
        [self.navigationController pushViewController:historyView animated:YES ];

    }
    else{
        //    self.addView.hidden=NO;
        //      [self.view bringSubviewToFront:self.addView];
        //    imageView.hidden=NO;
        //     [self.view bringSubviewToFront:imageView];
        //
        NSInteger tag = [(UIButton *)sender tag];
        
        
//        NSLog(@"click....%d",tag);
        
        TrainingRecord *record=[[TrainingRecord alloc] init];
        
        [record setLevel:tag];
        [                                                                                                                                                                                                                                                                                                                                                                                                                                                           record setRecordtime:[[NSDate date] timeIntervalSince1970]];
        [record setStarttime:[[NSDate date] timeIntervalSince1970]];
        [record setStatus:2];
        
        [SyncWalking addTrainRcord:record];
        
        CurrentWeeklyProgressViewController*current=[[CurrentWeeklyProgressViewController alloc]initWithNibName:@"CurrentWeeklyProgressViewController" bundle:nil];
        
//        [current setHideWaitView];
        
        [self.navigationController pushViewController:current animated:YES];

    }
    
//    NSLog(@"click....%ld",(long)tag);
    
    
    
}

//-(void)addbuttonNO
//{
//    self.addView.hidden=YES;
//    imageView.hidden=YES;
//}
//-(void)addbuttonYew
//{
//
//    
//   
//}

- (void)resetClock:(NSDate*)date timeNAme:(NSString*)name userInfo:(NSDictionary*)dic
{
    
    
    UILocalNotification *notification = [[UILocalNotification alloc] init] ;
    //设置時間
    NSLog(@"%@      %@    %@",date,[NSDate date],name);
    NSDate *pushDate = date ;
    if (notification != nil)
    {
        // 设置推送时间
        notification.fireDate = pushDate;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        //  notification.repeatInterval = kCFCalendarUnitDay;
        notification.repeatInterval = 0;
        // 推送声音
        notification.soundName =@"oldphone-mono-30s.caf";
        // 推送内容
        notification.alertBody =name;
        
        
        
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 0;
        
        
        
        //设置userinfo 方便在之后需要撤销的时候使用
        //  NSDictionary *info = [NSDictionary dictionaryWithObject:name forKey:@"id"];
        //NSLog(@"info=%@",info);
        
        
        
        
        notification.userInfo = dic;
        
        //添加推送到UIApplication
        //[[UIApplication sharedApplication] scheduleLocalNotification:notification];
        //这句真的特别特别重要。如果不加这一句，通知到时间了，发现顶部通知栏提示的地方有了，然后你通过通知栏进去，然后你发现通知栏里边还有这个提示
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
        
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
