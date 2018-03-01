//
//  CalsHistoryDetailViewController.m
//  mHealth
//
//  Created by smartone_sn3 on 9/2/14.
//
//

#import "CalsHistoryDetailViewController.h"
#import "CalsHistoryDetailCustomCell.h"
#import "Utility.h"
#import "HJMOFileCache.h"
#import "NSNotificationCenter+MainThread.h"
#import "syncCalories.h"
#import "CalsHistoryViewController.h"
#import "GlobalVariables.h"
#import "CalsViewController.h"

#define IMAGEURL @"http://www.healthreach.hk/foodlist/image/"

@interface CalsHistoryDetailViewController ()

@end

@implementation CalsHistoryDetailViewController

@synthesize imgMan;
@synthesize sectionList;
@synthesize dataDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"CalsHistoryDetailViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"CalsHistoryDetailViewController_iphone4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadViewTexts];
    NSDictionary *foodHistoryDict = [GlobalVariables shareInstance].foodHistoryDict;
    
    
    self.totalCaloriesLabel.text = [NSString stringWithFormat:@"%d",[[foodHistoryDict objectForKey:@"totalCalories"]intValue]];
    
    self.dataDict = [syncCalories parseFoodHistoryRecord:[foodHistoryDict objectForKey:@"record_detail"]];
    self.sectionList = [self.dataDict allKeys];
    NSString *dateString = [Utility extractDateString:[foodHistoryDict objectForKey:@"recordTime"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString = [Utility extractTimeString:[foodHistoryDict objectForKey:@"recordTime"] oldDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    [self.dateLabel setText:[NSString stringWithFormat:@"%@ %@",dateString,timeString]];
    [self sortSectionList];
    [self.tableView reloadData];
    //Initiate async picture download
    self.imgMan = [[HJObjManager alloc]init];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/foodImages/"] ;
	HJMOFileCache* fileCache = [[HJMOFileCache alloc] initWithRootPath:cacheDirectory];
	self.imgMan.fileCache = fileCache;

}

- (void)reloadViewTexts{
    [_calsTitleLabel setText:[Utility getStringByKey:@"home_title_cals"]];
    [_calsTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [_dateLabel setFont:[UIFont fontWithName:font65 size:18]];
    
    [_totalCaloriesLabel setFont:[UIFont fontWithName:font57 size:40]];
    
    [_totalCaloriesUnitLabel setText:[Utility getStringByKey:@"total_calories_cal"]];
    [_totalCaloriesUnitLabel setFont:[UIFont fontWithName:font77 size:12]];
    
    [_exportButton setTitle:[Utility getStringByKey:@"export"] forState:UIControlStateNormal];
    [_deleteButton setTitle:[Utility getStringByKey:@"delete"] forState:UIControlStateNormal];
}

- (void)sortSectionList {
    NSMutableArray *sortedArray = [[NSMutableArray alloc]init];
    if ([self.sectionList indexOfObject:@"Seasonal"] < [sectionList count])
        [sortedArray addObject:@"Seasonal"];
    if ([self.sectionList indexOfObject:@"Breakfast"] < [sectionList count])
        [sortedArray addObject:@"Breakfast"];
    if ([self.sectionList indexOfObject:@"Lunch"] < [sectionList count])
        [sortedArray addObject:@"Lunch"];
    if ([self.sectionList indexOfObject:@"Afternoon tea/ Snack"] < [sectionList count])
        [sortedArray addObject:@"Afternoon tea/ Snack"];
    if ([self.sectionList indexOfObject:@"Dinner"] < [sectionList count])
        [sortedArray addObject:@"Dinner"];
    
    self.sectionList = sortedArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sectionCounts = 0;

    sectionCounts = [self.sectionList count];
    
    return sectionCounts;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [self.sectionList objectAtIndex:section];
    
    NSArray *tmp=[self.dataDict objectForKey:key];
    
    NSInteger result=[tmp count];
    
	return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [self.sectionList objectAtIndex:section];
    NSArray *foodRecords = [self.dataDict objectForKey:key];

    UINib *nib = [UINib nibWithNibName:@"CalsHistoryDetailCustomCell" bundle:nil];
    static NSString *calsCustomCellIdentifier = @"CalsHistoryDetailCustomCellIdentifier";
    [tableView registerNib:nib forCellReuseIdentifier:calsCustomCellIdentifier];
    CalsHistoryDetailCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:calsCustomCellIdentifier];
    
    if (row < [foodRecords count])
    {
        FoodEntry *rowData = [foodRecords objectAtIndex:row];

        if ([[Utility getLanguageCode]isEqualToString:@"en"]){
            cell.foodNameString = [rowData getName_en];
            cell.foodUnitString = [rowData getQuantityUnit_en];
        } else {
            cell.foodNameString = [rowData getName_zh];
            cell.foodUnitString = [rowData getQuantityUnit_zh];
        }
        
//        cell.foodIdNumber = [rowData objectForKey:@"foodId"];
        cell.foodQuantityString = [NSString stringWithFormat:@"%d",[[rowData getQuantity]intValue]];
        cell.foodCaloriesString = [NSString stringWithFormat:@"%d",[[rowData getFoodCalories]intValue]];
        
        NSString *foodImagePlistPath = [[NSBundle mainBundle]pathForResource:@"old_foodImage" ofType:@"plist"];
        NSDictionary *foodImageDict = [[NSDictionary alloc]initWithContentsOfFile:foodImagePlistPath];
        NSString *foodImageFileName = [foodImageDict objectForKey:[rowData getName_en]];
        if ([foodImageFileName length] <= 0)
            foodImageFileName = [rowData getFoodImageFileName];
        NSLog(@"!!foodImage:%@",[rowData getFoodImageFileName]);
        cell.foodImageView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,foodImageFileName]];
        [self.imgMan manage:cell.foodImageView];

    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionList objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,0,200,25)];
    [titleLabel setText:[Utility getStringByKey:[self.sectionList objectAtIndex:section]]];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-BdCn" size:18]];
    [headerView addSubview:titleLabel];
    [titleLabel setTextColor:[UIColor colorWithRed:0.27f green:0.44f blue:0.78f alpha:1.0f]];
    return headerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteButtonDown:(id)sender {
    
    NSDictionary *foodHistoryDict = [GlobalVariables shareInstance].foodHistoryDict;
    [syncCalories deleteFoodDetail:[foodHistoryDict objectForKey:@"recordTime"]];
    CalsHistoryViewController *calsHistoryView = [[CalsHistoryViewController alloc]initWithNibName:@"CalsHistoryViewController" bundle:nil];
    [self.navigationController pushViewController:calsHistoryView animated:YES];

}

- (IBAction)exportRecordDetail:(id)sender {
    
    for (NSString *key in self.dataDict){
        for (FoodEntry *eachEntry in self.dataDict[key]){
            [DBHelper addFoodRecord:eachEntry];
        }
    }
    [GlobalVariables shareInstance].caloriesTotal = self.totalCaloriesLabel.text;
    CalsViewController *calsView = [[CalsViewController alloc]initWithNibName:@"CalsViewController" bundle:nil];
    [self.navigationController pushViewController:calsView animated:YES];
}

- (IBAction)toFoodHistoryView:(id)sender {
    CalsHistoryViewController *calsHistoryView = [[CalsHistoryViewController alloc]initWithNibName:@"CalsHistoryViewController" bundle:nil];
    [self.navigationController pushViewController:calsHistoryView animated:YES];
}

@end
