//
//  AwardsTomatoTreeViewController.m
//  mHealth
//
//  Created by admin on 2/2/15.
//
//

#import "AwardsTomatoTreeViewController.h"
#import "GameObject.h"
#import "Utility.h"
#import "SyncGame.h"
#import "Constants.h"
#import "UIAlertController+Orientation.h"

@interface AwardsTomatoTreeViewController ()

@end

@implementation AwardsTomatoTreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"AwardsTomatoTreeViewController" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"AwardsTomatoTreeViewController3.5" bundle:nibBundleOrNil];
    }
    if (self) {
        
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    headLabelTextFont.font=[UIFont fontWithName:font65 size:18];
    [headLabelTextFont setText:[Utility getStringByKey:@"Awards"]];
    
    treeTextFont.font=[UIFont fontWithName:font65 size:15];
    forCasualWalkTextFont.font=[UIFont fontWithName:font55 size:12];

    plantnameTextFont.font=[UIFont fontWithName:font65 size:15];
    [plantnameTextFont setText:[Utility getStringByKey:@"Plant name"]];
    
    obtainingdateTextFont.font=[UIFont fontWithName:font65 size:15];
    [obtainingdateTextFont setText:[Utility getStringByKey:@"Obtaining date"]];
    
    strTempTemp = [[NSString alloc] initWithFormat:@"%@",[Utility getStringByKey:@"Awards"]];
    if ([strTempTemp isEqualToString:@"Awards"])
    {
    forCasualWalkTextFont.text=@"for Casual Walk";
        
    }
    else
    {
        forCasualWalkTextFont.text=@"隨意行的";

    }
    [ok_btn setTitle:[Utility getStringByKey:@"ok"] forState:UIControlStateNormal];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"self,indaxRow=%@",self.indaxROW);
    treetableView.allowsSelection=NO;
    treetableView.bounces=NO;
      strTempTemp = [[NSString alloc] initWithFormat:@"%@",[Utility getStringByKey:@"Awards"]];
    NSString *haveColorTomatoText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_07" ofType:@"png"];
    NSString *haveColorLemonText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_lemon_07" ofType:@"png"];
    NSString *haveColorOrangeText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_07" ofType:@"png"];
    
    NSString *dimColorTomatoText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_tomato_07_dim" ofType:@"png"];
    NSString *dimColorLemonText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_lemon_07_dim" ofType:@"png"];
    NSString *dimColorOrangeText=[[NSBundle mainBundle]pathForResource:@"07_cw_plant_orange_07_dim" ofType:@"png"];
    UIImage * imagePlant;
    if ([self.indaxROW isEqualToString:@"0"])
    {
        
        if ([strTempTemp isEqualToString:@"Awards"])
        {
            treeTextFont.text=@"Tomato tree";
        }
        else
        {
            treeTextFont.text=@"蕃茄樹";
        }
        
        plantArrayTreeLast=[[NSMutableArray alloc] init];
               for (int i=0; i<self.plantArrayCW.count; i++)
        {
            
            GameObject*cw=[self.plantArrayCW objectAtIndex:i];
            NSLog(@"~~~~~~~~~~~~~~~~~~");
            NSLog(@"cw.gameObject==%@",cw);
            NSLog(@"cw.gametype==%@",cw.gameType);
            NSLog(@"cw.plantType==%@",cw.plantType);
            NSLog(@"cw.plantname==%@",cw.plantName);
            NSLog(@"cw.progress==%@",cw.progress);
            NSLog(@"cw.status==%@",cw.status);
            NSLog(@"~~~~~~~~~~~~~~~~~~");
            if ([cw.plantType isEqualToString:@"T"])
            {
                //
                [plantArrayTreeLast addObject:cw];
            }
            
            
        }
        if (plantArrayTreeLast.count >0) {
            imagePlant=[[UIImage alloc]initWithContentsOfFile:haveColorTomatoText];
            treeImageView.image=imagePlant;
        }
        else
        {
            imagePlant=[[UIImage alloc]initWithContentsOfFile:dimColorTomatoText];
            treeImageView.image=imagePlant;
        }

    }
    else  if ([self.indaxROW isEqualToString:@"1"])
    {
        if ([strTempTemp isEqualToString:@"Awards"])
        {
            treeTextFont.text=@"Lemon tree";
        }
        else
        {
            treeTextFont.text=@"檸檬樹";
        }
        plantArrayTreeLast=[[NSMutableArray alloc] init];
        for (int i=0; i<self.plantArrayCW.count; i++)
        {
            
            GameObject*cw=[self.plantArrayCW objectAtIndex:i];
            NSLog(@"~~~~~~~~~~~~~~~~~~");
            NSLog(@"cw.gameObject==%@",cw);
            NSLog(@"cw.gametype==%@",cw.gameType);
            NSLog(@"cw.plantType==%@",cw.plantType);
            NSLog(@"cw.plantname==%@",cw.plantName);
            NSLog(@"cw.progress==%@",cw.progress);
            NSLog(@"cw.status==%@",cw.status);
            NSLog(@"~~~~~~~~~~~~~~~~~~");
            if ([cw.plantType isEqualToString:@"L"])
            {
                //
                [plantArrayTreeLast addObject:cw];
            }
            
            
        }
        if (plantArrayTreeLast.count >0) {
            imagePlant=[[UIImage alloc]initWithContentsOfFile:haveColorLemonText];
            treeImageView.image=imagePlant;
        }
        else
        {
            imagePlant=[[UIImage alloc]initWithContentsOfFile:dimColorLemonText];
            treeImageView.image=imagePlant;
        }
        


    }
    else  if ([self.indaxROW isEqualToString:@"2"])
    {
        if ([strTempTemp isEqualToString:@"Awards"])
        {
            treeTextFont.text=@"Orange tree";
        }
        else
        {
            treeTextFont.text=@"橙樹";
        }
        plantArrayTreeLast=[[NSMutableArray alloc] init];
        for (int i=0; i<self.plantArrayCW.count; i++)
        {
        
            
            GameObject*cw=[self.plantArrayCW objectAtIndex:i];
            NSLog(@"~~~~~~~~~~~~~~~~~~");
            NSLog(@"cw.gameObject==%@",cw);
            NSLog(@"cw.gametype==%@",cw.gameType);
            NSLog(@"cw.plantType==%@",cw.plantType);
            NSLog(@"cw.plantname==%@",cw.plantName);
            NSLog(@"cw.progress==%@",cw.progress);
            NSLog(@"cw.status==%@",cw.status);
            NSLog(@"~~~~~~~~~~~~~~~~~~");
            if ([cw.plantType isEqualToString:@"O"])
            {
                //
                [plantArrayTreeLast addObject:cw];
            }
            
            
        }
        if (plantArrayTreeLast.count >0) {
            imagePlant=[[UIImage alloc]initWithContentsOfFile:haveColorOrangeText];
            treeImageView.image=imagePlant;
        }
        else
        {
            imagePlant=[[UIImage alloc]initWithContentsOfFile:dimColorOrangeText];
            treeImageView.image=imagePlant;
        }
        


    }
    
//    NSLog(@"plantArrayTreeLast==%@",plantArrayTreeLast);
    
    
    NSString * strSure1=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_btn_share_1" ofType:@"png"];
    
    NSString * strSure2=[[NSBundle mainBundle] pathForResource:@"07_wa_awards_btn_share_ch_1" ofType:@"png"];
    if ([strTempTemp isEqualToString:@"Awards"]) {
        sureImage=[[UIImage alloc] initWithContentsOfFile:strSure1];
    }
    else
    {
        sureImage=[[UIImage alloc] initWithContentsOfFile:strSure2];
    }
    
    
//    int theSmar=0;
//    cellHeard=[[NSMutableArray alloc] init];
    
    
    

    newPlantArrayList=[[NSMutableArray alloc] init];
    

    
    
    
    
    
    int oldadate;
    for (int i=0; i<plantArrayTreeLast.count; i++)
    {

        GameObject *theGameObject=[plantArrayTreeLast objectAtIndex:i];
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

        
        
        
        
//        if (theSmar==0)
//        {
//            [cellHeard addObject:currentDateStr];
//            theSmar=dateInt;
//        }
//       else if (dateInt > theSmar)
//        {
//            [cellHeard addObject:currentDateStr];
//            theSmar=dateInt;
//        }
//        else
//        {
//               theSmar=dateInt;
//        }
//        NSLog(@"thesmar==%d",theSmar);
    }
    for(int i=0;i<newPlantArrayList.count;i++){
        GameObject *check=[newPlantArrayList objectAtIndex:i];
        NSLog(@"test here:%@",check.plantName);
    }
//    [treetableView reloadData];
    
    
    
//    NSLog(@" plantArrayTreeLast.count=%lu", (unsigned long)plantArrayTreeLast.count);
//    NSLog(@"cellHeard.count=%lu=",(unsigned long)cellHeard.count);
    
    // Do any additional setup after loading the view from its nib.
}




//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
////    return cellHeard.count;
//    return newPlantArrayList.count;
//}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    NSString *sectionTitle=[self tableView:tableView titleForHeaderInSection:section];
//    
//    UIView * hendView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 320, 20)];
//    label.font=[UIFont fontWithName:font65 size:10];
//    label.text=sectionTitle;
//    label.textColor=[UIColor colorWithRed:142/255.0 green:178/255.0 blue:149/255.0 alpha:1];
//    label.backgroundColor=[UIColor clearColor];
//    [hendView addSubview:label];
//    
//    return hendView;
//    
//}
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
        theTreeName.textColor=[UIColor colorWithRed:38/255.0 green:83/255.0 blue:49/255.0 alpha:1];
        
        [cell.contentView addSubview:theTreeName];
        
        

    }
    else{
        UILabel * theTreeName=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 100, 21)];
        theTreeName.text=theGameObject.plantName;
        theTreeName.backgroundColor=[UIColor clearColor];
        theTreeName.textAlignment=NSTextAlignmentLeft;
        theTreeName.font=[UIFont fontWithName:font65 size:17];
        theTreeName.textColor=[UIColor colorWithRed:38/255.0 green:83/255.0 blue:49/255.0 alpha:1];
        
        [cell.contentView addSubview:theTreeName];
        
        UILabel * theTreeDate=[[UILabel alloc]initWithFrame:CGRectMake(140, 5, 60, 21)];
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
        theTreeDate.textColor=[UIColor colorWithRed:38/255.0 green:83/255.0 blue:49/255.0 alpha:1];
        
        [cell.contentView addSubview:theTreeDate];
        
        
        UIButton * shareButton=[UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.tag=indexPath.row;
        shareButton.frame=CGRectMake(230, 5, 80, 30);
        [shareButton setImage:sureImage forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(theShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:shareButton];
        
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
        distanceText.textAlignment=NSTextAlignmentCenter;
        distanceText.backgroundColor=[UIColor clearColor];
        float disINt=[theGameObject.distance floatValue]/1000;
        NSString *disStr=[[NSString alloc]initWithFormat:@"%g",disINt ];
        distanceText.text=disStr;
        distanceText.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        distanceText.font=[UIFont fontWithName:font77 size:16];
        [cell.contentView addSubview:distanceText];
        
        
        
        
        UILabel *stepsText=[[UILabel alloc]initWithFrame:CGRectMake(30+55, 26,55,21)];
        stepsText.textAlignment=NSTextAlignmentCenter;
        stepsText.backgroundColor=[UIColor clearColor];
        stepsText.text=theGameObject.steps;
        stepsText.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        stepsText.font=[UIFont fontWithName:font77 size:16];
        [cell.contentView addSubview:stepsText];
        
        UILabel *caloriesText=[[UILabel alloc]initWithFrame:CGRectMake(30+55+55+3+8, 26,35,21)];
        caloriesText.textAlignment=NSTextAlignmentCenter;
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
        
        
        UILabel *stepsTextUnit=[[UILabel alloc]initWithFrame:CGRectMake(30+35+58+8, 26,25,21)];
        stepsTextUnit.textAlignment=NSTextAlignmentCenter;
        stepsTextUnit.backgroundColor=[UIColor clearColor];
        stepsTextUnit.text=[Utility getStringByKey:@"step_unit"];
        stepsTextUnit.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        stepsTextUnit.font=[UIFont fontWithName:font67 size:12];
        [cell.contentView addSubview:stepsTextUnit];
        
        
        UILabel *caloriesTextUnit=[[UILabel alloc]initWithFrame:CGRectMake(30+55+55+35+3+8, 26,25,21)];
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
    
    //UIImage *image = [UIImage imageNamed:@"healthreach_apps_logo_en_120.png"];
    
    NSArray *activityItems = @[url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    //activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypeMessage];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];

}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
////    return [cellHeard objectAtIndex:section];
//    return [newPlantArrayList objectAtIndex:section];
//    
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@" plantArrayTreeLast.count=%lu", (unsigned long)plantArrayTreeLast.count);
//    NSLog(@"cellHeard.count=%lu=",(unsigned long)cellHeard);
//    return plantArrayTreeLast.count;
    return newPlantArrayList.count;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20;
//}
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
-(IBAction)thisOK:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
