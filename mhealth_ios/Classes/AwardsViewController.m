//
//  AwardsViewController.m
//  mHealth
//
//  Created by admin on 22/1/15.
//
//

#import "AwardsViewController.h"
#import "AwardsGoldViewController.h"
#import "AwardsTomatoTreeViewController.h"
#import "SyncGame.h"
#import "DBHelper.h"
#import "InTheTreeViewController.h"
#import "GlobalVariables.h"
#import "LearnMoreFirstViewController.h"


@interface AwardsViewController ()

@end

@implementation AwardsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"AwardsViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"AwardsViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
//    viewOfTP.hidden=NO;
//    viewOfCW.hidden=YES;

  
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    

    
    
//    NSString *FourtextMax=[[NSString alloc]initWithFormat:@"%ld",(unsigned long)self.plantArrayTP.count ];
//    trophyNumber.text=FourtextMax;
    
    
    
//    
//
    
    
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
        NSLog(@"is atcion--------------");
        goldNumber.text=@"2";
        bronzeNumber.text=@"2";
        silverNumber.text=@"3";

        diamondNumber.text=@"3";
            trophyNumber.text=@"1";
        if (iPad)
        {
            tableViewWithCW.frame=CGRectMake(25, 131, 270, 207);
        }
    }
    else
    {
        if (iPad)
        {
             tableViewWithCW.frame=CGRectMake(25, 131, 270, 232);
        }
//
    goldNumber.text=[SyncGame getMedalGold];
    bronzeNumber.text=[SyncGame getMedalBronze];
   silverNumber.text=[SyncGame getMedalSilver];
//    NSLog(@"test silver:%@",[SyncGame getMedalSilver]);
    diamondNumber.text=[SyncGame getMedalDiamond];
//    
    _plantArrayTP= [DBHelper getTrophyList];
        self.plantArrayT_D=[DBHelper getDiamondList];
        self.plantArrayT_G=[DBHelper getGoldList];
        self.plantArrayT_S=[DBHelper getSilverList];
        self.plantArrayT_B=[DBHelper getBronzeList];
    trophyNumber.text=[[NSString alloc]initWithFormat:@"%ld",(unsigned long)self.plantArrayTP.count ];
    [self SetCasualWalkContain];
    
    }

    if ([goldNumber.text intValue]>0) {
        imageViewx2.hidden=NO;
    }
    else
    {
        imageViewx2.hidden=YES;
    }
    if ([trophyNumber.text intValue]>0) {
        imageViewx0.hidden=NO;
    }
    else
    {
        imageViewx0.hidden=YES;
    }
    if ([diamondNumber.text intValue]>0) {
        imageViewx1.hidden=NO;
    }
    else
    {
        imageViewx1.hidden=YES;
    }
    if ([silverNumber.text intValue]>0) {
        imageViewx3.hidden=NO;
    }
    else
    {
        imageViewx3.hidden=YES;
    }
    if ([bronzeNumber.text intValue]>0) {
        imageViewx4.hidden=NO;
    }
    else
    {
        imageViewx4.hidden=YES;
    }
    
    

    
    

    
    [dataOnlyCW setText:[Utility getStringByKey:@"demo_data_only"]];
    [dataOnlyTP setText:[Utility getStringByKey:@"demo_data_only"]];
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
        [dataOnlyCW setHidden:false];
        [dataOnlyTP setHidden:false];
    }
    
 

    
    
    
    
  

//    tableViewWithCW.bounces=NO;
//
//    
//    NSString*rightStr=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_arrow" ofType:@"png"];
//    rightarrow=[[UIImage alloc]initWithContentsOfFile:rightStr];
    
                                    
    // Do any additional setup after loading the view from its nib.
    
    
    //vaycent here
    NSString *strtpON=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_tr_on" ofType:@"png"];
    NSString *strtpOFF=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_tr_off" ofType:@"png"];
    NSString *strcwON=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_cw_on" ofType:@"png"];
    NSString *strcwOFF=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_cw_off" ofType:@"png"];
    NSLog(@"strtpON=%@strtpON=%@strcwON=%@strtpON=%@",strtpON,strtpOFF,strcwON,strcwOFF);
    tpButtonImage=[[UIImage alloc] initWithContentsOfFile:strtpON];
    cwButtonImage=[[UIImage alloc]initWithContentsOfFile:strcwOFF];
    
    
    
    if(_checkTab==1)//casual walk
    {
        NSString *strtpON=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_tr_on" ofType:@"png"];
        NSString *strtpOFF=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_tr_off" ofType:@"png"];
        NSString *strcwON=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_cw_on" ofType:@"png"];
        NSString *strcwOFF=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_cw_off" ofType:@"png"];
        NSLog(@"strtpON=%@strtpON=%@strcwON=%@strtpON=%@",strtpON,strtpOFF,strcwON,strcwOFF);
        tpButtonImage=[[UIImage alloc] initWithContentsOfFile:strtpOFF];
        cwButtonImage=[[UIImage alloc]initWithContentsOfFile:strcwON];
        [buttonTP setImage:tpButtonImage forState:UIControlStateNormal];
        [buttonCW setImage:cwButtonImage forState:UIControlStateNormal];
        
    }else{
        [buttonTP setImage:tpButtonImage forState:UIControlStateNormal];
        [buttonCW setImage:cwButtonImage forState:UIControlStateNormal];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [buttonTPLabelTextFont setText:[Utility getStringByKey:@"w_train_title"]];
    [buttonCWLabelTextFont setText:[Utility getStringByKey:@"w_walk_title"]];
    NSString *xtrophy=[[NSString alloc] initWithFormat:@"%@ x",[Utility getStringByKey:@"w_trophy_title"]];
    [trophyTextFont setText:xtrophy];
    NSString *xdiamond=[[NSString alloc]initWithFormat:@"%@ x",[Utility getStringByKey:@"w_diamond_title"]];
    [diamondTextFont setText:xdiamond];
    NSString *xgold=[[NSString alloc] initWithFormat:@"%@ x",[Utility getStringByKey:@"w_gold_title"]];
    [goldTextFont setText:xgold];
    NSString *xsilver=[[NSString alloc] initWithFormat:@"%@ x",[Utility getStringByKey:@"w_silver_title"]];
    [silverTextFont setText:xsilver];
    NSString *xbronze=[[NSString alloc] initWithFormat:@"%@ x",[Utility getStringByKey:@"w_bronze_title"]];
    [bronzeTextFont setText:xbronze];
    [headLabelTextFont setText:[Utility getStringByKey:@"Awards"]];
    
    
    
    
    
    
    
    
    
    
    
    //
    //    [trophyTextFont sizeToFit];
    //    trophyNumber.frame=CGRectMake(137+trophyTextFont.frame.size.width, 161, 55, 37);
    //    [trophyNumber sizeToFit];
    //    imageViewx0.frame=CGRectMake(137+trophyTextFont.frame.size.width+trophyNumber.frame.size.width+5, 171, 10, 20);
    //
    //        [diamondTextFont sizeToFit];
    //    diamondNumber.frame=CGRectMake(9+diamondTextFont.frame.size.width, 268, 63, 37);
    //    [diamondNumber sizeToFit];
    //   imageViewx1.frame=CGRectMake(9+diamondTextFont.frame.size.width+diamondNumber.frame.size.width+5, 279, 10, 20);
    //    [goldTextFont sizeToFit];
    //    goldNumber.frame=CGRectMake(180+goldTextFont.frame.size.width, 268, 63, 37);
    //    [goldNumber sizeToFit];
    //    imageViewx2.frame=CGRectMake(180+goldTextFont.frame.size.width+goldNumber.frame.size.width+5, 279,10 , 20);
    //
    //    [silverTextFont sizeToFit];
    //    silverNumber.frame=CGRectMake(9+silverTextFont.frame.size.width, 365, 63, 37);
    //    [silverNumber sizeToFit];
    //    imageViewx3.frame=CGRectMake(9+silverTextFont.frame.size.width+silverNumber.frame.size.width+5, 376, 10, 20);
    //      [bronzeTextFont sizeToFit];
    //    bronzeNumber.frame=CGRectMake(180+bronzeTextFont.frame.size.width, 365, 63, 37);
    //    [bronzeNumber sizeToFit];
    //   imageViewx4.frame=CGRectMake(180+bronzeNumber.frame.size.width+bronzeTextFont.frame.size.width+5, 376, 10, 20);
    
    //    imageViewx1.hidden=YES;
    //     imageViewx2.hidden=YES;
    //     imageViewx3.hidden=YES;
    //     imageViewx4.hidden=YES;
    
    
    headLabelTextFont.font=[UIFont fontWithName:font65 size:18];
    buttonCWLabelTextFont.font=[UIFont fontWithName:font65 size:15];
    buttonTPLabelTextFont.font=[UIFont fontWithName:font65 size:15];
    buttonTPLabelTextFont.textColor=[UIColor whiteColor];
    buttonCWLabelTextFont.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    theCWlongLabelTextFont.font=[UIFont fontWithName:font65 size:12];
    theLongLabelTextFont1.font=[UIFont fontWithName:font65 size:12];
    theLongLabelTextFont2.font=[UIFont fontWithName:font65 size:18];
    cashCouponTextFont.font=[UIFont fontWithName:font65 size:18];
    
    theCWlongLabelTextFont.textColor=[UIColor colorWithRed:74/255.0 green:94/255.0 blue:74/255.0 alpha:1];
    theLongLabelTextFont1.textColor=[UIColor colorWithRed:100/255.0 green:60/255.0 blue:40/255.0 alpha:1];
    theLongLabelTextFont2.textColor=[UIColor colorWithRed:100/255.0 green:60/255.0 blue:40/255.0 alpha:1];
    cashCouponTextFont.textColor=[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    
    
    theCWlongLabelTextFont.text=[Utility getStringByKey:@"award_cw_detail_tx"];
    
    
    trophyTextFont.font=[UIFont fontWithName:font65 size:14];
    trophyNumber.font=[UIFont fontWithName:font65 size:32];
    diamondTextFont.font=[UIFont fontWithName:font65 size:14];
    diamondNumber.font=[UIFont fontWithName:font65 size:32];
    goldTextFont.font=[UIFont fontWithName:font65 size:14];
    goldNumber.font=[UIFont fontWithName:font65 size:32];
    silverTextFont.font=[UIFont fontWithName:font65 size:14];
    silverNumber.font=[UIFont fontWithName:font65 size:32];
    bronzeTextFont.font=[UIFont fontWithName:font65 size:14];
    bronzeNumber.font=[UIFont fontWithName:font65 size:32];
    
    howmanyTomatoTree=0;
    howmanyLemonTree=0;
    howmanyAppleTree=0;
    howmanyOrangeTree=0;
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(load_Medal_Trophy_Plant) object:nil];
    [thread start];
    
    strTempTemp =[[NSString alloc]initWithString:[Utility getStringByKey:@"Done"]];
    if ([strTempTemp isEqualToString:@"Done"]) {
        
        theCWlongLabelTextFont.text=@"The energy from your Casual Walk will transform into nutrients for the plant of your choice and make it grow. Start walking now and enjoy.";
        //
        
        //     theCWlongLabelTextFont.text=@"?";
        
        theLongLabelTextFont1.text=@"Get 10 medals to win a trophy and get a HK$100 health products coupon.";
        
        
        
        
        
        
        
        theLongLabelTextFont1.frame=CGRectMake(25, 17, 270, 60);
        //        theLongLabelTextFont1.frame=CGRectMake(25, 17, 270, 40);
        //        theLongLabelTextFont1.text=@"Get 10  medals in 10 weeks to win";
        //        theLongLabelTextFont2.frame=CGRectMake(46, 42, 122, 21);
        //        theLongLabelTextFont2.text=@"a vitual trophy for   ";
        //        cashCouponTextFont.frame=CGRectMake(167, 42, 91, 21);
        //        cashCouponTextFont.text=@"cash coupon";
        //        _gantanhao.frame=CGRectMake(261, 42, 15, 21);
        theLongLabelTextFont2.hidden=YES;
        cashCouponTextFont.hidden=YES;
        _gantanhao.hidden=YES;
        
        [detailsofTP setTitle:[Utility getStringByKey:@"detail_btn_tx"] forState:UIControlStateNormal];
        
        [detailsofCW setTitle:[Utility getStringByKey:@"detail_btn_tx" ] forState:UIControlStateNormal];
        
        
        
        
    }
    else
    {
        theCWlongLabelTextFont.text=@"你喺「隨意⾏」步行所消秏嘅能量將轉化為養分,助你揀選嘅植物茁壯成長。開始並享受步⾏嘅樂趣吧!";
        //
        theLongLabelTextFont1.text=@"獲取10面獎牌就可以得到獎盃，仲有HK$100健康產品優惠券！";
        
        
        //    theCWlongLabelTextFont.text=@"?";
        
        //   theLongLabelTextFont1.text=@"?";
        
        
        
        
        theLongLabelTextFont1.frame=CGRectMake(25, 17, 270, 60);
        //        theLongLabelTextFont1.text=@"在10週內獲得10枚獎牌";
        //        theLongLabelTextFont2.text=@"贏得虛擬獎盃和";
        //        cashCouponTextFont.text=@"現金卷";
        //        theLongLabelTextFont1.frame=CGRectMake(25, 17, 270, 40);
        //        theLongLabelTextFont2.frame=CGRectMake(76, 42, 122, 21);
        //        cashCouponTextFont.frame=CGRectMake(165, 42, 91, 21);
        //        _gantanhao.frame=CGRectMake(236, 42, 15, 21);
        theLongLabelTextFont2.hidden=YES;
        cashCouponTextFont.hidden=YES;
        _gantanhao.hidden=YES;
        [detailsofCW setTitle:[Utility getStringByKey:@"detail_btn_tx"] forState:UIControlStateNormal];
        [detailsofTP setTitle:[Utility getStringByKey:@"detail_btn_tx"] forState:UIControlStateNormal];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString*cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellIdentifier];
    }
    
    else
    {
        cell=nil;
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        UIImageView*tomatoImageView=[[UIImageView alloc]initWithImage:tomatoBlackImage];
        tomatoImageView.frame=CGRectMake(10, 9, 60, 60);
        [cell.contentView addSubview:tomatoImageView];
        
        UILabel * tomatoTree=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 80, 60)];
        if ([strTempTemp isEqualToString:@"Done"]) {
            tomatoTree.text=@"Tomato tree";
        }
        else
        {
              tomatoTree.text=@"蕃茄樹";
        }
        tomatoTree.numberOfLines=2;
        tomatoTree.font=[UIFont fontWithName:font65 size:16];
        tomatoTree.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:tomatoTree];
        
        UILabel *x=[[UILabel alloc]initWithFrame:CGRectMake(160, 35, 15, 20)];
        x.text=@"x";
        x.font=[UIFont fontWithName:font55 size:15];
        x.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:x];
        UILabel *numberTree=[[UILabel alloc]initWithFrame:CGRectMake(180, 20, 60, 60)];
        NSString * numberTurnText=[[NSString alloc] initWithFormat:@"%d",howmanyTomatoTree];
        numberTree.textAlignment=NSTextAlignmentRight;
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
                numberTree.text=@"3";
        }
        else
        {
                numberTree.text=numberTurnText;
        }
    
        numberTree.font=[UIFont fontWithName:font65 size:32];
        numberTree.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:numberTree];
        
        UIImageView *imageViewarrow=[[UIImageView alloc]initWithImage:rightarrow];
        imageViewarrow.frame=CGRectMake(250, 30,15, 30);
        [cell.contentView addSubview:imageViewarrow];
        
         if([numberTree.text isEqualToString:@"0"])
            imageViewarrow.hidden=true;
        else
            imageViewarrow.hidden=false;
        
    }
    if (indexPath.row==1) {
        UIImageView*lemonImageView=[[UIImageView alloc]initWithImage:lemonBlackImage];
        lemonImageView.frame=CGRectMake(10, 9, 60, 60);
        [cell.contentView addSubview:lemonImageView];
        
        UILabel * lemonTree=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 80, 60)];
        if ([strTempTemp isEqualToString:@"Done"]) {
            lemonTree.text=@"Lemon tree";
        }
        else
        {
            lemonTree.text=@"檸檬樹";
        }
        lemonTree.numberOfLines=2;
        lemonTree.font=[UIFont fontWithName:font65 size:16];
        lemonTree.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:lemonTree];
        
        UILabel *x=[[UILabel alloc]initWithFrame:CGRectMake(160, 35, 15, 20)];
        x.text=@"x";
        x.backgroundColor=[UIColor clearColor];
        x.font=[UIFont fontWithName:font55 size:15];
        [cell.contentView addSubview:x];
        UILabel *numberTree=[[UILabel alloc]initWithFrame:CGRectMake(180, 20, 60, 60)];
        NSString * numberTurnText=[[NSString alloc] initWithFormat:@"%d",howmanyLemonTree];
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
            numberTree.text=@"3";
        }
        else
        {
            numberTree.text=numberTurnText;
        }
        
        numberTree.textAlignment=NSTextAlignmentRight;
        numberTree.font=[UIFont fontWithName:font65 size:32];
        numberTree.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:numberTree];
        
        UIImageView *imageViewarrow=[[UIImageView alloc]initWithImage:rightarrow];
        imageViewarrow.frame=CGRectMake(250, 30, 15, 30);
        [cell.contentView addSubview:imageViewarrow];
        
        
          if([numberTree.text isEqualToString:@"0"])
            imageViewarrow.hidden=true;
        else
            imageViewarrow.hidden=false;
        
        
    }
    if (indexPath.row==2) {
        UIImageView*orangeImageView=[[UIImageView alloc]initWithImage:orangeBlackImage];
        orangeImageView.frame=CGRectMake(10, 9, 60, 60);
        [cell.contentView addSubview:orangeImageView];
        
        UILabel * orangeTree=[[UILabel alloc]initWithFrame:CGRectMake(90, 20, 80, 60)];
        if ([strTempTemp isEqualToString:@"Done"]) {
            orangeTree.text=@"Orange tree";
        }
        else
        {
           orangeTree.text=@"橙樹";
        }
        orangeTree.font=[UIFont fontWithName:font65 size:16];
        orangeTree.numberOfLines=2;
        orangeTree.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:orangeTree];
        
        UILabel *x=[[UILabel alloc]initWithFrame:CGRectMake(160, 35, 15, 20)];
        x.text=@"x";
        x.backgroundColor=[UIColor clearColor];
        x.font=[UIFont fontWithName:font55 size:15];
        [cell.contentView addSubview:x];
        UILabel *numberTree=[[UILabel alloc]initWithFrame:CGRectMake(180, 20, 60, 60)];
        NSString * numberTurnText=[[NSString alloc] initWithFormat:@"%d",howmanyOrangeTree];
        
    
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
            numberTree.text=@"3";
        }
        else
        {
            numberTree.text=numberTurnText;
        }
        
        numberTree.font=[UIFont fontWithName:font65 size:32];
        numberTree.backgroundColor=[UIColor clearColor];
            numberTree.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:numberTree];
        
        UIImageView *imageViewarrow=[[UIImageView alloc]initWithImage:rightarrow];
        imageViewarrow.frame=CGRectMake(250, 30, 15, 30);
        [cell.contentView addSubview:imageViewarrow];
        
        
        if([numberTree.text isEqualToString:@"0"])
            imageViewarrow.hidden=true;
        else
            imageViewarrow.hidden=false;

        
    }
    
    
    
    
    
    
    
    
    
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"[GlobalVariables shareInstance].session_id=%@",[GlobalVariables shareInstance].session_id);
    NSLog(@"[GlobalVariables shareInstance].login_id=%@",[GlobalVariables shareInstance].login_id);
    
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
        NSLog(@"is atcion");
        
        LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
        [historyView setType:@"walk"];
        [self.navigationController pushViewController:historyView animated:YES ];
        
        
    }
    else
    {
        NSLog(@"YES---");
        AwardsTomatoTreeViewController*award=[[AwardsTomatoTreeViewController alloc] initWithNibName:@"AwardsTomatoTreeViewController" bundle:nil];
        NSString *indexPathStr=[[NSString alloc]initWithFormat:@"%ld",(long)indexPath.row];
        
        award.indaxROW=indexPathStr;
        if (indexPath.row==0)
        {
            if (howmanyTomatoTree>0) {
                award.plantArrayCW=[[NSMutableArray alloc]initWithArray:self.plantArrayCW];
                [self.navigationController pushViewController:award animated:YES];
                
            }
            else
            {
                NSLog(@"Tomato is zero ,I'm sorry");
            }
            
            
        }
        else if (indexPath.row==1)
        {
            if (howmanyLemonTree>0) {
                award.plantArrayCW=[[NSMutableArray alloc]initWithArray:self.plantArrayCW];
                [self.navigationController pushViewController:award animated:YES];
                
            }
            else
            {
                NSLog(@"Lemon is zero ,I'm sorry");
            }
            
        }
        else
        {
            
            if (howmanyOrangeTree>0) {
                award.plantArrayCW=[[NSMutableArray alloc]initWithArray:self.plantArrayCW];
                [self.navigationController pushViewController:award animated:YES];
                
            }
            else
            {
                NSLog(@"Orange is zero ,I'm sorry");
            }
        }
    }
    
}
-(IBAction)toTPVIew:(id)sender
{
    NSString *strtpON=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_tr_on" ofType:@"png"];
    NSString *strtpOFF=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_tr_off" ofType:@"png"];
    NSString *strcwON=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_cw_on" ofType:@"png"];
    NSString *strcwOFF=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_cw_off" ofType:@"png"];
    NSLog(@"strtpON=%@strtpON=%@strcwON=%@strtpON=%@",strtpON,strtpOFF,strcwON,strcwOFF);
    tpButtonImage=[[UIImage alloc] initWithContentsOfFile:strtpON];
    cwButtonImage=[[UIImage alloc]initWithContentsOfFile:strcwOFF];
    [buttonTP setImage:tpButtonImage forState:UIControlStateNormal];
    [buttonCW setImage:cwButtonImage forState:UIControlStateNormal];
    
    viewOfTP.hidden=NO;
    viewOfCW.hidden=YES;
    buttonTPLabelTextFont.textColor=[UIColor whiteColor];

    buttonCWLabelTextFont.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];

}
-(IBAction)toCWVIew:(id)sender
{
    NSString *strtpON=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_tr_on" ofType:@"png"];
    NSString *strtpOFF=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_tr_off" ofType:@"png"];
    NSString *strcwON=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_cw_on" ofType:@"png"];
    NSString *strcwOFF=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_header_cw_off" ofType:@"png"];
    NSLog(@"strtpON=%@strtpON=%@strcwON=%@strtpON=%@",strtpON,strtpOFF,strcwON,strcwOFF);
    tpButtonImage=[[UIImage alloc] initWithContentsOfFile:strtpOFF];
    cwButtonImage=[[UIImage alloc]initWithContentsOfFile:strcwON];
    [buttonTP setImage:tpButtonImage forState:UIControlStateNormal];
     [buttonCW setImage:cwButtonImage forState:UIControlStateNormal];
    
    
    viewOfTP.hidden=YES;
    viewOfCW.hidden=NO;
    buttonCWLabelTextFont.textColor=[UIColor whiteColor];
    buttonTPLabelTextFont.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    
}
-(IBAction)toTrophyButton:(id)sender
{
    
    
    
    if ([trophyNumber.text intValue]>0)
    {
        NSLog(@"[GlobalVariables shareInstance].session_id=%@",[GlobalVariables shareInstance].session_id);
        NSLog(@"[GlobalVariables shareInstance].login_id=%@",[GlobalVariables shareInstance].login_id);
        
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
            NSLog(@"is atcion");
            
            LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
            [historyView setType:@"walk"];
            [self.navigationController pushViewController:historyView animated:YES ];
            
            
        }
        else
        {
            AwardsGoldViewController *awarsG=[[AwardsGoldViewController alloc]initWithNibName:@"AwardsGoldViewController" bundle:nil];
            awarsG.plantArrayTP=[[NSMutableArray alloc]initWithArray:self.plantArrayTP];
            awarsG.plantStr=@"T";
            [self.navigationController pushViewController:awarsG animated:YES];
        }

    }
    NSLog(@"trophyNumber.text=%@",trophyNumber.text);
  }
-(IBAction)toDiamondButton:(id)sender
{
    if ([diamondNumber.text intValue]>0) {
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
            NSLog(@"is atcion");
            
            LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
            [historyView setType:@"walk"];
            [self.navigationController pushViewController:historyView animated:YES ];
            
            
        }
        else{
            
            AwardsGoldViewController *awarsG=[[AwardsGoldViewController alloc]initWithNibName:@"AwardsGoldViewController" bundle:nil];
              awarsG.plantArrayTP=[[NSMutableArray alloc]initWithArray:self.plantArrayT_D];
            awarsG.plantStr=@"D";
            [self.navigationController pushViewController:awarsG animated:YES];
        }

    }
    NSLog(@"diamondNumber.text =%@",diamondNumber.text );
    
    
    
    
}
-(IBAction)toGoldButton:(id)sender
{
    if ([goldNumber.text intValue]>0) {
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
            NSLog(@"is atcion");
            
            LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
            [historyView setType:@"walk"];
            [self.navigationController pushViewController:historyView animated:YES ];
            
            
        }
        else{
            AwardsGoldViewController *awarsG=[[AwardsGoldViewController alloc]initWithNibName:@"AwardsGoldViewController" bundle:nil];
                   awarsG.plantArrayTP=[[NSMutableArray alloc]initWithArray:self.plantArrayT_G];
            awarsG.plantStr=@"G";
            [self.navigationController pushViewController:awarsG animated:YES];
            
        }
    }
    NSLog(@"[goldNumber.text intValue]=%d",[goldNumber.text intValue]);
  
}
-(IBAction)detailsTP:(id)sender
{
    InTheTreeViewController*intheT=[[InTheTreeViewController alloc]initWithNibName:@"InTheTreeViewController" bundle:nil];
    intheT.theviewINT=1;
    intheT.hendviewINT=2;
    [self.navigationController pushViewController:intheT animated:NO];
    
}
-(IBAction)detailsCW:(id)sender
{
    InTheTreeViewController*intheT=[[InTheTreeViewController alloc]initWithNibName:@"InTheTreeViewController" bundle:nil];
    intheT.theviewINT=2;
     intheT.hendviewINT=2;
    [self.navigationController pushViewController:intheT animated:NO];
}
-(IBAction)toSilverButton:(id)sender
{
    if ([silverNumber.text intValue]>0) {
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
            NSLog(@"is atcion");
            
            LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
            [historyView setType:@"walk"];
            [self.navigationController pushViewController:historyView animated:YES ];
            
            
        }
        else{
            AwardsGoldViewController *awarsG=[[AwardsGoldViewController alloc]initWithNibName:@"AwardsGoldViewController" bundle:nil];
                   awarsG.plantArrayTP=[[NSMutableArray alloc]initWithArray:self.plantArrayT_S];
            awarsG.plantStr=@"S";
            [self.navigationController pushViewController:awarsG animated:YES];
        }

    }
    NSLog(@"[silverNumber.text intValue]=%d",[silverNumber.text intValue]);
}
-(IBAction)toBronzeButton:(id)sender
{
    if ([bronzeNumber.text intValue]>0) {
        if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
            NSLog(@"is atcion");
            
            LearnMoreFirstViewController *historyView = [[LearnMoreFirstViewController alloc] initWithNibName:@"LearnMoreFirstViewController" bundle:nil];
            [historyView setType:@"walk"];
            [self.navigationController pushViewController:historyView animated:YES ];
            
            
        }
        else{
            AwardsGoldViewController *awarsG=[[AwardsGoldViewController alloc]initWithNibName:@"AwardsGoldViewController" bundle:nil];
                   awarsG.plantArrayTP=[[NSMutableArray alloc]initWithArray:self.plantArrayT_B];
            awarsG.plantStr=@"B";
            [self.navigationController pushViewController:awarsG animated:YES];
            
        }

    }
    NSLog(@"[bronzeNumber.text intValue]=%d",[bronzeNumber.text intValue]);
 }
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.

}



- (void)load_Medal_Trophy_Plant{
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
        NSLog(@"is atcion--------------");
          [self SetCasualWalkContain];
        
    }
    else
    {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *loadfromDB=[defaults objectForKey:[NSString stringWithFormat:@"award_load_from_db_%@",[GlobalVariables shareInstance].login_id]];
    
    
    //GameObject *checkGameObj= [SyncGame getPlantProgress];
    //NSString *strTem=[checkGameObj progress];
    //NSString *type=[checkGameObj plantType];
    //int progress=[strTem intValue];
    
    
      
        //if(progress==0&&(type==NULL||[type isEqualToString:@""])){
            
        //    loadfromDB=@"false";
        //}
        
    
    
        
    //loadfromDB=@"false";

 
    if(loadfromDB==nil||[loadfromDB isEqualToString:@""]||[loadfromDB isEqualToString:@"false"])
    {
        
        NSLog(@"==============-=-=---=-============");
        BOOL check1=[SyncGame getMedal];
        
        BOOL check2= [SyncGame syncPlantList];
        
        BOOL check3=[SyncGame syncTrophyList];
        
        BOOL check4_1=[SyncGame syncBronzeList];
        BOOL check4_2=[SyncGame syncSilverList];
        BOOL check4_3=[SyncGame syncGoldList];
        BOOL check4_4=[SyncGame syncDiamondList];
        
        if(check1&&check2&&check3&&check4_1&&check4_2&&check4_3&&check4_4){
            
            goldNumber.text=[SyncGame getMedalGold];
            bronzeNumber.text=[SyncGame getMedalBronze];
            silverNumber.text=[SyncGame getMedalSilver];
            diamondNumber.text=[SyncGame getMedalDiamond];
            
            
            _plantArrayTP= [DBHelper getTrophyList];
            self.plantArrayT_D=[DBHelper getDiamondList];
            self.plantArrayT_G=[DBHelper getGoldList];
            self.plantArrayT_S=[DBHelper getSilverList];
            self.plantArrayT_B=[DBHelper getBronzeList];
            
            trophyNumber.text=[[NSString alloc]initWithFormat:@"%ld",(unsigned long)self.plantArrayTP.count ];
            
            [self SetCasualWalkContain];
            
            [defaults setObject:@"true" forKey:[NSString stringWithFormat:@"award_load_from_db_%@",[GlobalVariables shareInstance].login_id]];
            [defaults synchronize];
            
        }
       
        
        
        

        
    }
    else{
        goldNumber.text=[SyncGame getMedalGold];
        bronzeNumber.text=[SyncGame getMedalBronze];
        silverNumber.text=[SyncGame getMedalSilver];
        diamondNumber.text=[SyncGame getMedalDiamond];
        
        _plantArrayTP= [DBHelper getTrophyList];
        
        self.plantArrayT_D=[DBHelper getDiamondList];
        self.plantArrayT_G=[DBHelper getGoldList];
        self.plantArrayT_S=[DBHelper getSilverList];
        self.plantArrayT_B=[DBHelper getBronzeList];
        
        trophyNumber.text=[[NSString alloc]initWithFormat:@"%ld",(unsigned long)self.plantArrayTP.count ];
        
        [self SetCasualWalkContain];

    }
    
    }
    if ([goldNumber.text intValue]>0) {
        imageViewx2.hidden=NO;
    }
    else
    {
        imageViewx2.hidden=YES;
    }
    if ([trophyNumber.text intValue]>0) {
        imageViewx0.hidden=NO;
    }
    else
    {
        imageViewx0.hidden=YES;
    }
    if ([diamondNumber.text intValue]>0) {
        imageViewx1.hidden=NO;
    }
    else
    {
        imageViewx1.hidden=YES;
    }
    if ([silverNumber.text intValue]>0) {
        imageViewx3.hidden=NO;
    }
    else
    {
        imageViewx3.hidden=YES;
    }
    if ([bronzeNumber.text intValue]>0) {
        imageViewx4.hidden=NO;
    }
    else
    {
        imageViewx4.hidden=YES;
    }
    
    

   
}

-(void)SetCasualWalkContain{
    
    if ([GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
        NSLog(@"is atcion--------------");
      
        
    }
    else
    {
    _plantArrayCW= [DBHelper getPlantList];
    }
    howmanyTomatoTree=0;
    howmanyAppleTree=0;
    howmanyLemonTree=0;
    howmanyOrangeTree=0;
    
    
    for (int thelajEveryone=0; thelajEveryone<self.plantArrayCW.count; thelajEveryone++)
    {
        GameObject*cw=[self.plantArrayCW objectAtIndex:thelajEveryone];
        NSLog(@"~~~~~~~~~~~~~~~~~~");
        NSLog(@"cw.gameObject==%@",cw);
        NSLog(@"cw.gametype==%@",cw.gameType);
        NSLog(@"cw.plantType==%@",cw.plantType);
        NSLog(@"cw.plantname==%@",cw.plantName);
        NSLog(@"cw.progress==%@",cw.progress);
        NSLog(@"cw.status==%@",cw.status);
        NSLog(@"~~~~~~~~~~~~~~~~~~");
        if ([cw.plantType isEqualToString:@"T"]) {
            //
            howmanyTomatoTree++;
        }
        else if ([cw.plantType isEqualToString:@"A"])
        {
            howmanyAppleTree++;
        }
        else if ([cw.plantType isEqualToString:@"L"])
        {
            howmanyLemonTree++;
        }
        else if ([cw.plantType isEqualToString:@"O"])
        {
            howmanyOrangeTree++;
        }
    }
    
    NSLog(@" howmanyTomatoTree=%d;howmanyLemonTree=%d,howmanyAppleTree=%d,howmanyOrangeTree=%d",howmanyTomatoTree,howmanyLemonTree,howmanyAppleTree,howmanyOrangeTree);
    NSString *haveColorTomatoText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_07" ofType:@"png"];
    NSString *haveColorLemonText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_lemon_07" ofType:@"png"];
    NSString *haveColorOrangeText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_07" ofType:@"png"];
    
    NSString *dimColorTomatoText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_07_dim" ofType:@"png"];
    NSString *dimColorLemonText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_lemon_07_dim" ofType:@"png"];
    NSString *dimColorOrangeText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_07_dim" ofType:@"png"];
    if (howmanyTomatoTree>0||[GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
        tomatoBlackImage=[[UIImage alloc]initWithContentsOfFile:haveColorTomatoText];
    }
    else
    {
        tomatoBlackImage=[[UIImage alloc]initWithContentsOfFile:dimColorTomatoText];
    }
    
    if (howmanyLemonTree>0||[GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
        lemonBlackImage=[[UIImage alloc]initWithContentsOfFile:haveColorLemonText];
    }
    else
    {
        lemonBlackImage=[[UIImage alloc]initWithContentsOfFile:dimColorLemonText];
    }
    
    if (howmanyOrangeTree>0||[GlobalVariables shareInstance].session_id==NULL||[GlobalVariables shareInstance].login_id==NULL) {
        orangeBlackImage=[[UIImage alloc]initWithContentsOfFile:haveColorOrangeText];
    }
    else
    {
        orangeBlackImage=[[UIImage alloc]initWithContentsOfFile:dimColorOrangeText];
    }
    tableViewWithCW.bounces=NO;
    
    
    NSString*rightStr=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_arrow" ofType:@"png"];
    rightarrow=[[UIImage alloc]initWithContentsOfFile:rightStr];

    
    [tableViewWithCW reloadData];

}




@end
