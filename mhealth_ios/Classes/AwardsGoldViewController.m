//
//  AwardsGoldViewController.m
//  mHealth
//
//  Created by admin on 15/1/15.
//
//

#import "AwardsGoldViewController.h"
#import "GameObject.h"
#import "Utility.h"
#import "Constants.h"
#import "UIAlertController+Orientation.h"

@interface AwardsGoldViewController ()

@end

@implementation AwardsGoldViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"AwardsGoldViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"AwardsGoldViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}-(void)viewWillAppear:(BOOL)animated
{
    headLabelTextFont.font=[UIFont fontWithName:font65 size:18];
    [headLabelTextFont setText:[Utility getStringByKey:@"Awards"]];
    goldMedaisTextFont.font=[UIFont fontWithName:font65 size:15];
    forTrainingTrpgrammeTextFont.font=[UIFont fontWithName:font55 size:12];
    programmePeriodTextFont.font=[UIFont fontWithName:font65 size:12];
    dateTextFont.font=[UIFont fontWithName:font65 size:12];
    strTempTemp =[[ NSString alloc]initWithFormat:@"%@",[Utility getStringByKey:@"Awards"]];
    NSString * strSure1=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_btn_share_1" ofType:@"png"];
    NSString * strSure2=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_btn_share_ch_1" ofType:@"png"];
    
    if ([strTempTemp isEqualToString:@"Awards"])
    {
        
        
        if ([self.plantStr isEqualToString:@"T"]) {
            goldMedaisTextFont.text=@"Trophies";
        }
        else if ([self.plantStr isEqualToString:@"D"])
        {
            goldMedaisTextFont.text=@"Diamond Awards";
        }
        else if ([self.plantStr isEqualToString:@"G"])
        {
            goldMedaisTextFont.text=@"Gold Awards";
        }
        else if ([self.plantStr isEqualToString:@"S"])
        {
            goldMedaisTextFont.text=@"Silver Awards";
        }
        else if ([self.plantStr isEqualToString:@"B"])
        {
            goldMedaisTextFont.text=@"Bronze Awards";
        }
        
        forTrainingTrpgrammeTextFont.text=@"for Training Programme";
        programmePeriodTextFont.text=@"Programme period";
         shareImage=[[UIImage alloc] initWithContentsOfFile:strSure1];
    }
    else
    {
        
        
        if ([self.plantStr isEqualToString:@"T"]) {
            
            goldMedaisTextFont.text=@"獎盃";
        }
        else if ([self.plantStr isEqualToString:@"D"])
        {
            goldMedaisTextFont.text=@"鑽級獎項";
        }
        else if ([self.plantStr isEqualToString:@"G"])
        {
            goldMedaisTextFont.text=@"金級獎項";
        }
        else if ([self.plantStr isEqualToString:@"S"])
        {
            goldMedaisTextFont.text=@"銀級獎項";
        }
        else if ([self.plantStr isEqualToString:@"B"])
        {
            goldMedaisTextFont.text=@"銅級獎項";
        }

        
        forTrainingTrpgrammeTextFont.text=@"步行計劃的";
        programmePeriodTextFont.text=@"計劃時期";
         shareImage=[[UIImage alloc] initWithContentsOfFile:strSure2];
    }
    [ok_btn setTitle:[Utility getStringByKey:@"ok"] forState:UIControlStateNormal];}
- (void)viewDidLoad
{
    [super viewDidLoad];
     trophyTableView.allowsSelection=NO;
     trophyTableView.bounces=NO;
     awardsTableView.allowsSelection=NO;
     awardsTableView.bounces=NO;
    if ([self.plantStr isEqualToString:@"T"]) {
        trophyTableView.hidden=NO;
        awardsTableView.hidden=YES;
        
    }
    else
    {
        trophyTableView.hidden=YES;
        awardsTableView.hidden=NO;
    }
    NSString * awardsImageStrTrophy=[[NSBundle mainBundle]pathForResource:@"07_tr_award_trophy_10" ofType:@"png"];
    
       NSString * awardsImageStrDiamond=[[NSBundle mainBundle]pathForResource:@"07_tr_award_diamond_hr" ofType:@"png"];
       NSString * awardsImageStrGold=[[NSBundle mainBundle]pathForResource:@"07_tr_award_gold_hr" ofType:@"png"];
       NSString * awardsImageStrSilver=[[NSBundle mainBundle]pathForResource:@"07_tr_award_silver_hr" ofType:@"png"];
       NSString * awardsImageStrBronze=[[NSBundle mainBundle]pathForResource:@"07_tr_award_bronze_hr" ofType:@"png"];
    UIImage * imageAwards;
    if ([self.plantStr isEqualToString:@"T"]) {
        imageAwards=[[UIImage alloc]initWithContentsOfFile:awardsImageStrTrophy];
    }
    else if ([self.plantStr isEqualToString:@"D"])
    {
         imageAwards=[[UIImage alloc]initWithContentsOfFile:awardsImageStrDiamond];
    }
    else if ([self.plantStr isEqualToString:@"G"])
    {
        imageAwards=[[UIImage alloc]initWithContentsOfFile:awardsImageStrGold];
    }
    else if ([self.plantStr isEqualToString:@"S"])
    {
        imageAwards=[[UIImage alloc]initWithContentsOfFile:awardsImageStrSilver];
    }
    else if ([self.plantStr isEqualToString:@"B"])
    {
        imageAwards=[[UIImage alloc]initWithContentsOfFile:awardsImageStrBronze];
    }
    
    awardsImageView.image=imageAwards;
    
    int oldadate;
    NSLog(@"self.plantArrayTP22222222==%@",self.plantArrayTP);
     newPlantArrayList=[[NSMutableArray alloc] init];
    for (int i=0; i<self.plantArrayTP.count; i++)
    {
        NSLog(@"----------------");
        GameObject *theGameObject=[self.plantArrayTP objectAtIndex:i];
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:[theGameObject getStartDate]];
        NSDateFormatter* dateFormat0000 = [[NSDateFormatter alloc] init];
        [dateFormat0000 setDateFormat:@"yyyy"];
        NSString *currentDateStr = [dateFormat0000 stringFromDate:date];
        
        int dateInt=[currentDateStr intValue];
        
        //        NSLog(@"println-%d:%d",i,dateInt);
        
        if(i==0){
            
            GameObject *titleobj=[[GameObject alloc] initGameObject:@"" plantType:@"title" plantName:[NSString stringWithFormat:@"%d", dateInt] status:@"" progress:@"" theMSG:@""];
            [newPlantArrayList addObject:titleobj];
            
            oldadate=dateInt;
        }
        else if(dateInt>oldadate){
            GameObject *titleobj=[[GameObject alloc] initGameObject:@"" plantType:@"title" plantName:[NSString stringWithFormat:@"%d", dateInt] status:@"" progress:@"" theMSG:@""];
            [newPlantArrayList addObject:titleobj];
        }
        [newPlantArrayList addObject:theGameObject];
        oldadate=dateInt;
        

    }
    for(int i=0;i<newPlantArrayList.count;i++){
        GameObject *check=[newPlantArrayList objectAtIndex:i];
        NSLog(@"test here:%@",check.calories);
    }
    //    [treetableView reloadData];
    
    


    // Do any additional setup after loading the view from its nib.
}
-(IBAction)thisOK:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellIdentifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSLog(@"theGameObject1:%lu",(unsigned long)newPlantArrayList.count);
    
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
    
    GameObject *theGameObject=[newPlantArrayList objectAtIndex:indexPath.row];
    NSLog(@"theGameObject:%@",theGameObject.plantType);
    
    
    
    
    if([theGameObject.plantType isEqualToString:@"title"]){
        
        
        UILabel * theTreeName=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 30)];
        theTreeName.text=theGameObject.plantName;
        theTreeName.backgroundColor=[UIColor clearColor];
        theTreeName.textAlignment=NSTextAlignmentLeft;
        theTreeName.font=[UIFont fontWithName:font65 size:15];
        theTreeName.textColor=[UIColor colorWithRed:74/255.0 green:107/255.0 blue:124/255.0 alpha:1];
        
        [cell.contentView addSubview:theTreeName];
        
        
        
    }
    else{
//        UILabel * theTreeName=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 100, 21)];
//        theTreeName.text=theGameObject.plantName;
//        theTreeName.backgroundColor=[UIColor clearColor];
//        theTreeName.textAlignment=NSTextAlignmentLeft;
//        theTreeName.font=[UIFont fontWithName:font65 size:17];
//        theTreeName.textColor=[UIColor colorWithRed:38/255.0 green:83/255.0 blue:49/255.0 alpha:1];
//        
//        [cell.contentView addSubview:theTreeName];
        
        UILabel * theTreeDate=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 60, 21)];
        NSDate *date=[NSDate dateWithTimeIntervalSince1970:[theGameObject getStartDate]];
        NSDateFormatter* dateFormat0000 = [[NSDateFormatter alloc] init];
        
        if ([strTempTemp isEqualToString:@"Awards"])
        {
            NSLocale *en_Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-Hans"];
            [dateFormat0000 setDateFormat:@"d-MMM"];
            [dateFormat0000 setLocale:en_Locale];
        }
        else
        {
            [dateFormat0000 setDateFormat:@"MMM-d"];
            NSLocale *zh_Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
            [dateFormat0000 setLocale:zh_Locale];
        }
        NSString *currentDateStr = [dateFormat0000 stringFromDate:date];
        NSLog(@"%@",currentDateStr);
        
        theTreeDate.text=currentDateStr;
        theTreeDate.backgroundColor=[UIColor clearColor];
        theTreeDate.textAlignment=NSTextAlignmentCenter;
        theTreeDate.font=[UIFont fontWithName:font65 size:17];
        theTreeDate.textColor=[UIColor colorWithRed:74/255.0 green:107/255.0 blue:124/255.0 alpha:1];
        
        [cell.contentView addSubview:theTreeDate];
        
      if ([self.plantStr isEqualToString:@"T"])
      {
        UIButton * shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.tag=indexPath.row;
        shareButton.frame=CGRectMake(230, 5, 80, 30);
        [shareButton setImage:shareImage forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(theShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:shareButton];
      }
        //-------------------------------------------------------------------------------------
        
        //        UILabel * distanceLabelTextFont=[[UILabel alloc] initWithFrame:CGRectMake(50, 26, 55, 21)];
        //        distanceLabelTextFont.backgroundColor=[UIColor clearColor];
        //        NSString * distanceLabelTextFontStr=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"distance_label"]];
        //        distanceLabelTextFont.text=distanceLabelTextFontStr;
        //        distanceLabelTextFont.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        //        distanceLabelTextFont.textAlignment=NSTextAlignmentCenter;
        //        distanceLabelTextFont.font=[UIFont fontWithName:font67 size:14];
        //        [cell.contentView addSubview:distanceLabelTextFont];
        //
        //        UILabel * stepsLabelTextFont=[[UILabel alloc] initWithFrame:CGRectMake(50+55, 26, 55, 21)];
        //        stepsLabelTextFont.backgroundColor=[UIColor clearColor];
        //        NSString * stepsLabelTextFontStr=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"step_label"]];
        //        stepsLabelTextFont.text=stepsLabelTextFontStr;
        //        stepsLabelTextFont.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        //        stepsLabelTextFont.textAlignment=NSTextAlignmentCenter;
        //        stepsLabelTextFont.font=[UIFont fontWithName:font67 size:14];
        //        [cell.contentView addSubview:stepsLabelTextFont];
        //
        //        UILabel * caloriesLabelTextFont=[[UILabel alloc] initWithFrame:CGRectMake(50+55+55, 26, 55, 21)];
        //        caloriesLabelTextFont.backgroundColor=[UIColor clearColor];
        //        NSString * caloriesLabelTextFontStr=[[NSString alloc]initWithFormat:@"%@:",[Utility getStringByKey:@"cal_label"]];
        //        caloriesLabelTextFont.text=caloriesLabelTextFontStr;
        //        caloriesLabelTextFont.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        //        caloriesLabelTextFont.textAlignment=NSTextAlignmentCenter;
        //        caloriesLabelTextFont.font=[UIFont fontWithName:font67 size:14];
        //        [cell.contentView addSubview:caloriesLabelTextFont];
        // ------------------------------------------
        
        UILabel *distanceText=[[UILabel alloc]initWithFrame:CGRectMake(30, 26,35,21)];
        distanceText.textAlignment=NSTextAlignmentRight;
        distanceText.backgroundColor=[UIColor clearColor];
        float disINt=[theGameObject.distance floatValue]/1000;
        NSString *disStr=[[NSString alloc]initWithFormat:@"%g",disINt ];
        distanceText.text=disStr;
        distanceText.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        distanceText.font=[UIFont fontWithName:font77 size:16];
        [cell.contentView addSubview:distanceText];
        
        UILabel *stepsText=[[UILabel alloc]initWithFrame:CGRectMake(30+55, 26,55,21)];
        stepsText.textAlignment=NSTextAlignmentRight;
        stepsText.backgroundColor=[UIColor clearColor];
        stepsText.text=theGameObject.steps;
        stepsText.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        stepsText.font=[UIFont fontWithName:font77 size:16];
        [cell.contentView addSubview:stepsText];
        
        UILabel *caloriesText=[[UILabel alloc]initWithFrame:CGRectMake(30+55+55+3+8+15, 26,35,21)];
        caloriesText.textAlignment=NSTextAlignmentRight;
        caloriesText.backgroundColor=[UIColor clearColor];
        caloriesText.text=theGameObject.calories;
        caloriesText.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        caloriesText.font=[UIFont fontWithName:font77 size:16];
        [cell.contentView addSubview:caloriesText];
        
        
        //------------------------------------------
        
        UILabel *distanceTextUnit=[[UILabel alloc]initWithFrame:CGRectMake(30+35, 26,25,21)];
        distanceTextUnit.textAlignment=NSTextAlignmentCenter;
        distanceTextUnit.backgroundColor=[UIColor clearColor];
        distanceTextUnit.text=[Utility getStringByKey:@"km_unit"];
        distanceTextUnit.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        distanceTextUnit.font=[UIFont fontWithName:font67 size:12];
        [cell.contentView addSubview:distanceTextUnit];
        
        
        UILabel *stepsTextUnit=[[UILabel alloc]initWithFrame:CGRectMake(30+35+58+8+15, 26,25,21)];
        stepsTextUnit.textAlignment=NSTextAlignmentCenter;
        stepsTextUnit.backgroundColor=[UIColor clearColor];
        stepsTextUnit.text=[Utility getStringByKey:@"step_unit"];
        stepsTextUnit.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        stepsTextUnit.font=[UIFont fontWithName:font67 size:12];
        [cell.contentView addSubview:stepsTextUnit];
        
        
        UILabel *caloriesTextUnit=[[UILabel alloc]initWithFrame:CGRectMake(30+55+55+35+3+8+15, 26,25,21)];
        caloriesTextUnit.textAlignment=NSTextAlignmentCenter;
        caloriesTextUnit.backgroundColor=[UIColor clearColor];
        caloriesTextUnit.text=[Utility getStringByKey:@"total_calories_cal"];
        caloriesTextUnit.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        caloriesTextUnit.font=[UIFont fontWithName:font67 size:12];
        [cell.contentView addSubview:caloriesTextUnit];
        
        
        
        
        //-------------------------------------------------------------------------------------
        
    }
    
    
    
    
    
    
    
    
    
    // GameObject *theGameObject=[plantArrayTreeLast objectAtIndex:indexPath.row];
    //    UILabel * theTreeName=[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 100, 30)];
    //    theTreeName.text=theGameObject.plantName;
    //    theTreeName.backgroundColor=[UIColor clearColor];
    //    theTreeName.textAlignment=NSTextAlignmentLeft;
    //    theTreeName.font=[UIFont fontWithName:font65 size:12];
    //    theTreeName.textColor=[UIColor colorWithRed:38/255.0 green:83/255.0 blue:49/255.0 alpha:1];
    //
    //    [cell.contentView addSubview:theTreeName];
    //
    //    UILabel * theTreeDate=[[UILabel alloc]initWithFrame:CGRectMake(140, 10, 60, 30)];
    //       NSDate *date=[NSDate dateWithTimeIntervalSince1970:[theGameObject getStartDate]];
    //    NSDateFormatter* dateFormat0000 = [[NSDateFormatter alloc] init];
    //    [dateFormat0000 setDateFormat:@"d-MMM"];
    //    NSLocale *en_Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-Hans"];
    //    [dateFormat0000 setLocale:en_Locale];
    //    //    NSLocale *zh_Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    //    //    [dateFormat0000 setLocale:zh_Locale];
    //    NSString *currentDateStr = [dateFormat0000 stringFromDate:date];
    //    NSLog(@"%@",currentDateStr);
    //
    //    theTreeDate.text=currentDateStr;
    //    theTreeDate.backgroundColor=[UIColor clearColor];
    //    theTreeDate.textAlignment=NSTextAlignmentCenter;
    //    theTreeDate.font=[UIFont fontWithName:font65 size:12];
    //    theTreeDate.textColor=[UIColor colorWithRed:38/255.0 green:83/255.0 blue:49/255.0 alpha:1];
    //
    //    [cell.contentView addSubview:theTreeDate];
    //
    //
    //    UIButton * shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
    //    shareButton.tag=indexPath.row;
    //    shareButton.frame=CGRectMake(210, 5, 80, 30);
    //    [shareButton setImage:sureImage forState:UIControlStateNormal];
    //    [shareButton addTarget:self action:@selector(theShareButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [cell.contentView addSubview:shareButton];
    
    
    return cell;
}

-(void)theShareButton:(UIButton*)sender
{
    NSLog(@"sender.tAG==%ld",(long)sender.tag);
    NSLog(@"sender.tAG==%ld",(long)sender.tag);
    //fb share
    
    GameObject *theGameObject=[newPlantArrayList objectAtIndex:sender.tag];
    
    NSString *contStr=[Constants getAPIBase1];
    
    
    NSString* keyStr=[theGameObject.fb_key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *lang=@"en";
    
    if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
        
        lang=@"zh";
    }
    
    NSString *urlStr=[[NSString alloc]initWithFormat:@"%@wmc/jsp/mhealth/fb_share.jsp?key=%@&lang=%@",contStr,keyStr,lang];
    
    //fb share
    // NSString *texttoshare = @"http://www.google.com"; //this is your text string to share
    //UIImage *imagetoshare = _img; //this is your image to share
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    NSArray *activityItems = @[url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    //activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypeMessage];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return newPlantArrayList.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameObject *theGameObject=[newPlantArrayList objectAtIndex:indexPath.row];
    NSLog(@"theGameObject:%@",theGameObject.plantType);
    if([theGameObject.plantType isEqualToString:@"title"]){
        return 25;
    }else{
        //return 40;
        return 60;
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
