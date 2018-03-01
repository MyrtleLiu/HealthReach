//
//  InTheTreeViewController.m
//  mHealth
//
//  Created by admin on 11/2/15.
//
//

#import "InTheTreeViewController.h"
#import "Utility.h"
@interface InTheTreeViewController ()

@end

@implementation InTheTreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"InTheTreeViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"InTheTreeViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        heardTextFont.text=[Utility getStringByKey:@"Awards"];
    strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"Done"]];
    
    UILabel *theLittleTextFont2=[[UILabel alloc]init];
    theLittleTextFont2.textColor=[UIColor colorWithRed:85/255.0 green:102/255.0 blue:105/255.0 alpha:1];
    theLittleTextFont2.backgroundColor=[UIColor clearColor];
    
    theLittleLAbelTextFont.font=[UIFont fontWithName:font65 size:19];
    theLittleTextFont2.font=[UIFont fontWithName:font65 size:15];
    theLittleLAbelTextFont.textColor=[UIColor colorWithRed:86/255.0 green:103/255.0 blue:104/255.0 alpha:1];
    NSString *strBunle=[[NSBundle mainBundle] pathForResource:@"dot" ofType:@"png"];
    UIImage *imageDot=[[UIImage alloc]initWithContentsOfFile:strBunle];
    UIImageView * imageViewDot1=[[UIImageView alloc]initWithImage:imageDot];
    UIImageView * imageViewDot2=[[UIImageView alloc]initWithImage:imageDot];

     [ok_btn setTitle:[Utility getStringByKey:@"btn_ok"] forState:UIControlStateNormal];
    if ([strTempTemp isEqualToString:@"Done"])
    {
    
        
        if (self.theviewINT==1) {
            gamerulesTextFont.text=@"How it works";
            theLittleLAbelTextFont.text=@"    Get a medal every time you complete a Training Programme.\n\n    Get 10 medals consecutively to win a trophy and a HK$100 health products coupon.\n\nStart now and get your first medal!";

                theLittleLAbelTextFont.frame=CGRectMake(12,50, 256, 230);
                imageViewDot1.frame=CGRectMake(15, 64, 5, 5);
                imageViewDot2.frame=CGRectMake(15, 140  , 5, 5);
           
            [backbackBroundVIew addSubview:imageViewDot1];
            [backbackBroundVIew addSubview:imageViewDot2];
            
            imageViewDot1.frame=CGRectMake(15, 64, 5, 5);
            imageViewDot2.frame=CGRectMake(15, 140  , 5, 5);
            
            
            theLittleTextFont2.text=@"The health products coupon is offered by Conected Health Limited.";
            theLittleTextFont2.frame=CGRectMake(12, 50+190+35+55, 256, 60);
            
            if (iPad) {
                
                theLittleTextFont2.frame=CGRectMake(12, 50+190+35, 256, 60);
            }
            
            theLittleTextFont2.numberOfLines=3;
        }
        else
        {
        gamerulesTextFont.text=@"How it works";
//        theLittleLAbelTextFont.text=@"Walk towards a better life! Select your favourite plant and make it flower! There are six stages for each plant. You only need to walk 30 minutes and 80 steps per minute to provide adequate nutrients. The plant can only move up one stage a day.You have to provide nutrients at least once a week. Otherwise, your plant will regress to the previous stage.";
            theLittleLAbelTextFont.text=@"Transform the energy from walking to help your plant grow by walking 30 minutes a day with 80 steps per minute.\n\nStart building a good walking habit now and have fun.\n\n";
            theLittleTextFont2.text=@"Each plant has 6 stages of growth and it can only grow once a day. Walk at least once a week or else it will regress to the previous stage.";
       theLittleLAbelTextFont.frame=CGRectMake(12,50, 256, 190);
            theLittleTextFont2.frame=CGRectMake(12, 50+190, 256, 60);
            theLittleTextFont2.numberOfLines=5;
            
            
            
            
            [backbackBroundVIew setBackgroundColor:[UIColor colorWithRed:238/255.0f green:242/255.0f blue:233/255.0f alpha:1.0f]];
            [gamerulesTextFont setTextColor:[UIColor colorWithRed:80/255.0f green:150/255.0f blue:40/255.0f alpha:1.0f]];

                theLittleLAbelTextFont.frame=CGRectMake(12,50, 256, 200);
                theLittleTextFont2.frame=CGRectMake(12, 50+190, 256, 60);
                theLittleTextFont2.numberOfLines=5;
            
   
        }
    }
    else
    {
        
        if (self.theviewINT==1)
        {
            gamerulesTextFont.text=@"簡介";

                theLittleLAbelTextFont.frame=CGRectMake(12,50, 256, 190);
                imageViewDot1.frame=CGRectMake(15, 72, 5, 5);
                imageViewDot2.frame=CGRectMake(15, 129, 5, 5);
               
                theLittleLAbelTextFont.text=@"    每完成⼀個「步⾏計劃」,你將獲取⼀面獎牌。\n\n     連續完成10個「步行計劃」,   你將獲得⼀個獎盃及HK$100健康產品禮券。\n\n⽴即開始並獲取你嘅⾸面獎牌!";
                
                [backbackBroundVIew addSubview:imageViewDot1];
                [backbackBroundVIew addSubview:imageViewDot2];
            
            imageViewDot1.frame=CGRectMake(15, 72, 5, 5);
            imageViewDot2.frame=CGRectMake(15, 129, 5, 5);
            
            
            theLittleTextFont2.text=@"健康產品禮券由Connected Health Limited提供";
            theLittleTextFont2.frame=CGRectMake(12, 50+190+90, 256, 60);
            
            if (iPad) {
                
                theLittleTextFont2.frame=CGRectMake(12, 50+190+35, 256, 60);
            }
            
            theLittleTextFont2.numberOfLines=3;
        }
        else
        {
        gamerulesTextFont.text=@"簡介";
            //        theLittleLAbelTextFont.text=@"步出更美好人生！選擇一盆你喜愛的植物，並培植它開出花朵！每棵植物均有6個階段，你只須要以每分鐘80步的步速，步行30分鐘就能為它提供成長所需的足夠營養。植物每天只會成長一次。你每星期至少要為它提供一次營養。否則，你的植物將退化至前一個階段。";
       
            
            theLittleLAbelTextFont.text=@"將步行轉化為能量,以每日每分鐘80步嘅步速步行30分鐘,就足夠培植你嘅植物成長。\n\n⽴即建立良好步行習慣,享受箇中樂趣!\n\n";
   
            theLittleTextFont2.text=@"每棵植物都有6個成長階段,⽽每日只可成⾧⼀次。每星期必須⾄少步⾏⼀次,不然植物將退化至前一個成長階段。";

            
                theLittleLAbelTextFont.frame=CGRectMake(12,50, 256, 150);
                theLittleTextFont2.frame=CGRectMake(12, 50+140, 256, 60);
                theLittleTextFont2.numberOfLines=5;
            
             [backbackBroundVIew setBackgroundColor:[UIColor colorWithRed:238/255.0f green:242/255.0f blue:233/255.0f alpha:1.0f]];
            [gamerulesTextFont setTextColor:[UIColor colorWithRed:80/255.0f green:150/255.0f blue:40/255.0f alpha:1.0f]];
        }
    }
    theLittleTextFont2.textAlignment=NSTextAlignmentLeft;
    [backbackBroundVIew addSubview:theLittleTextFont2];
    
    

      // Do any additional setup after loading the view from its nib.
}
-(IBAction)isOK:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    
    
//    if (self.theviewINT!=1){
//        2
//    }
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
