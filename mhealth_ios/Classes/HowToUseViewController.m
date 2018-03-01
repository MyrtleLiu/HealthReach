//
//  HowToUseViewController.m
//  mHealth
//
//  Created by smartone_sn2 on 14-9-1.
//
//

#import "HowToUseViewController.h"
#import "Utility.h"

@interface HowToUseViewController ()

@end

@implementation HowToUseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
    
    
    
    if (!iPad) {
        self = [super initWithNibName:@"HowToUseViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"HowToUseViewController_ipad" bundle:nibBundleOrNil];
    }

    
    
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *lanuage = [Utility getLanguageCode];
    
    UIImage *imageBP,*imageBG,*imageWEIGHT,*imageCALENDAR,*imageWALK,*imageFOOD;
    if([lanuage isEqualToString: @"en"]){
        NSString *nboutBP=[[NSBundle mainBundle] pathForResource:@"vedioBP_en" ofType:@"png"];
        imageBP=[[UIImage alloc]initWithContentsOfFile:nboutBP];
        
        NSString *nboutBG=[[NSBundle mainBundle] pathForResource:@"vedioBG_en" ofType:@"png"];
        imageBG=[[UIImage alloc]initWithContentsOfFile:nboutBG];

        NSString *nboutWEIGHT=[[NSBundle mainBundle] pathForResource:@"vedioWEIGHT_en" ofType:@"png"];
        imageWEIGHT=[[UIImage alloc]initWithContentsOfFile:nboutWEIGHT];

        NSString *nboutCALENDAR=[[NSBundle mainBundle] pathForResource:@"vedioCALENDAR_en" ofType:@"png"];
        imageCALENDAR=[[UIImage alloc]initWithContentsOfFile:nboutCALENDAR];

        NSString *nboutWALK=[[NSBundle mainBundle] pathForResource:@"vedioWALK_en" ofType:@"png"];
        imageWALK=[[UIImage alloc]initWithContentsOfFile:nboutWALK];

        NSString *nboutFOOD=[[NSBundle mainBundle] pathForResource:@"vedioFOOD_en" ofType:@"png"];
        imageFOOD=[[UIImage alloc]initWithContentsOfFile:nboutFOOD];

        
    }
    else{
        
        NSString *nboutBP=[[NSBundle mainBundle] pathForResource:@"vedioBP_zh" ofType:@"png"];
        imageBP=[[UIImage alloc]initWithContentsOfFile:nboutBP];
        
        NSString *nboutBG=[[NSBundle mainBundle] pathForResource:@"vedioBG_zh" ofType:@"png"];
        imageBG=[[UIImage alloc]initWithContentsOfFile:nboutBG];
        
        NSString *nboutWEIGHT=[[NSBundle mainBundle] pathForResource:@"vedioWEIGHT_zh" ofType:@"png"];
        imageWEIGHT=[[UIImage alloc]initWithContentsOfFile:nboutWEIGHT];
        
        NSString *nboutCALENDAR=[[NSBundle mainBundle] pathForResource:@"vedioCALENDAR_zh" ofType:@"png"];
        imageCALENDAR=[[UIImage alloc]initWithContentsOfFile:nboutCALENDAR];
        
        NSString *nboutWALK=[[NSBundle mainBundle] pathForResource:@"vedioWALK_zh" ofType:@"png"];
        imageWALK=[[UIImage alloc]initWithContentsOfFile:nboutWALK];
        
        NSString *nboutFOOD=[[NSBundle mainBundle] pathForResource:@"vedioFOOD_zh" ofType:@"png"];
        imageFOOD=[[UIImage alloc]initWithContentsOfFile:nboutFOOD];
        
    }
    [_vedioBP setImage:imageBP forState:UIControlStateNormal];
    [_vedioBG setImage:imageBG forState:UIControlStateNormal];
    [_vedioWEIGHT setImage:imageWEIGHT forState:UIControlStateNormal];
    [_vedioCALENDAR setImage:imageCALENDAR forState:UIControlStateNormal];
    [_vedioWALK setImage:imageWALK forState:UIControlStateNormal];
    [_vedioFOOD setImage:imageFOOD forState:UIControlStateNormal];



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    _bptx.font=[UIFont fontWithName:font65 size:15];
    _bgtx.font=[UIFont fontWithName:font65 size:15];
    _ecgtx.font=[UIFont fontWithName:font65 size:15];
    _weighttx.font=[UIFont fontWithName:font65 size:15];
    _calendartx.font=[UIFont fontWithName:font65 size:15];
    _walktx.font=[UIFont fontWithName:font65 size:15];
    _caltx.font=[UIFont fontWithName:font65 size:15];
    
    self.actionbar.font =[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18];
    [_actionbar setText:[Utility getStringByKey:@"How to use"]];
    
    [_bptx setText:[Utility getStringByKey:@"howuse_bp"]];
    [_bgtx setText:[Utility getStringByKey:@"howuse_bg"]];
    [_ecgtx setText:[Utility getStringByKey:@"howuse_ecg"]];
    [_weighttx setText:[Utility getStringByKey:@"howuse_weight"]];
    [_calendartx setText:[Utility getStringByKey:@"howuse_calendar"]];
    [_walktx setText:[Utility getStringByKey:@"howuse_walk"]];
    [_caltx setText:[Utility getStringByKey:@"howuse_cal"]];

    
    
}







-(IBAction)howToUseBP:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/bp_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/bp_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
}

-(IBAction)howToUseBG:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/bg_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/bg_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
}

-(IBAction)howToUseECG:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/ecg_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/ecg_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
}

-(IBAction)howToUseWEIGHT:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/weight_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/weight_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
}


-(IBAction)howToUseWALK:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/walkforhealth_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/walkforhealth_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
}

-(IBAction)howToUseCAL:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/caloriereckoner_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/caloriereckoner_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
}





-(IBAction)howToUseCALENDER:(id)sender{
    NSString *link;
    NSString *lanuage = [Utility getLanguageCode];
    if([lanuage isEqualToString: @"en"])
        link=@"http://www.healthreach.com.hk/dl/data/mhealth/app/video/calendar_iphone_en.3gp";
    else
        link= @"http://www.healthreach.com.hk/dl/data/mhealth/app/video/calendar_iphone_zh.3gp";
    //    NSLog(@"@....test in about" , link);
    NSLog(@"%@....test in about",link);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:link]];
    
}



@end
