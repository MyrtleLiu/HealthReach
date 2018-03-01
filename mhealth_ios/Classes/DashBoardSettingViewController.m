//
//  DashBoardSettingViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-9-29.
//
//

#import "DashBoardSettingViewController.h"


#import "EditableTableController.h"

#import "Utility.h"

#import "DashboardObject.h"

#import "DashboardTableViewCell.h"

static CGFloat CellHeight = 50.0f;
static NSString *CellIdentifier = @"CellIdentifier";

NSInteger check1;
NSInteger check2;

//static NSInteger NumberOfItems = 7;
//static NSString *PlaceholderItem = @"com.alfiehanssen.item_placeholder";
//static NSString *Item = @"com.alfiehanssen.item_%i";

@interface DashBoardSettingViewController () <UITableViewDataSource, UITableViewDelegate, EditableTableControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) EditableTableController *editableTableController;
@property (nonatomic, strong) DashboardObject *itemBeingMoved;
@property (nonatomic, strong) DashboardObject *placeholderItem;

@end


@implementation DashBoardSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    
    if (!iPad) {
        self = [super initWithNibName:@"DashBoardSettingViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"DashBoardSettingViewController_iphone4" bundle:nibBundleOrNil];
        
        NSLog(@"iphone4...........1");
    }
    
    
    if (self) {
        // Custom initialization
        
        _itemBeingMoved = nil;
        _placeholderItem = [[DashboardObject alloc] initWithType:@" " sort:@"-1"];;
        _items = [NSMutableArray array];
        
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupDatasource];
    [self setupTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.moveTextView setText:[Utility getStringByKey:@"dashboard_sort"]];
    
    [self.doneBtn setTitle:[Utility getStringByKey:@"done"] forState:UIControlStateNormal];
    
    [_actionbar setText:[Utility getStringByKey:@"dashboard"]];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)saveSort:(id)sender{
   
    for(int i=0;i<[self.items count];i++){
        
        DashboardObject *item=[self.items objectAtIndex:i];
        
        
        NSLog(@"%@........%@.....%d",item.type,item.sort,i);
        
        if([item.type isEqualToString:@"BP"])[Utility saveBPSort:[NSString stringWithFormat:@"%d",i]];
        if([item.type isEqualToString:@"HR"])[Utility saveHRSort:[NSString stringWithFormat:@"%d",i]];
        if([item.type isEqualToString:@"BG"])[Utility saveBGSort:[NSString stringWithFormat:@"%d",i]];
        if([item.type isEqualToString:@"WEIGHT"])[Utility saveWeightSort:[NSString stringWithFormat:@"%d",i]];
        if([item.type isEqualToString:@"BMI"])[Utility saveBMISort:[NSString stringWithFormat:@"%d",i]];
        if([item.type isEqualToString:@"WALK"])[Utility saveWalkDurationSort:[NSString stringWithFormat:@"%d",i]];
        if([item.type isEqualToString:@"CALS"])[Utility saveCalsSort:[NSString stringWithFormat:@"%d",i]];
        
        
    }
    
    
    [self back];
   
}


#pragma mark - Setup

- (void)setupDatasource
{

    
    DashboardObject *bp=[[DashboardObject alloc] initWithType:@"BP" sort:[Utility getBPSort]];
    DashboardObject *hr=[[DashboardObject alloc] initWithType:@"HR" sort:[Utility getHRSort]];
    DashboardObject *bg=[[DashboardObject alloc] initWithType:@"BG" sort:[Utility getBGSort]];
    DashboardObject *weight=[[DashboardObject alloc] initWithType:@"WEIGHT" sort:[Utility getWeightSort]];
    DashboardObject *bmi=[[DashboardObject alloc] initWithType:@"BMI" sort:[Utility getBMISort]];
    DashboardObject *walk=[[DashboardObject alloc] initWithType:@"WALK" sort:[Utility getWalkDurationSort]];
    DashboardObject *cals=[[DashboardObject alloc] initWithType:@"CALS" sort:[Utility getCalsSort]];
    
    [_items addObject:bp];
    [_items addObject:hr];
    [_items addObject:bg];
    [_items addObject:weight];
    [_items addObject:bmi];
    [_items addObject:walk];
    [_items addObject:cals];
    
    _items=[[NSMutableArray alloc] initWithArray:[_items sortedArrayUsingSelector:@selector(compare:)]];
    
}

- (void)setupTableView
{
    self.tableView.estimatedRowHeight = CellHeight;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.editableTableController = [[EditableTableController alloc] initWithTableView:self.tableView];
    self.editableTableController.delegate = self;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (iPad) {
        
        //NSLog(@"iphone4...........2");
        
        return 45;
        
        
    }
    
    return CellHeight;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *DashboardCellIdentifier = @"DashboardCellIdentifier";
   
    UINib *nib = [UINib nibWithNibName:@"DashboardTableViewCell" bundle:nil];
    
    if (iPad) {
        
        nib = [UINib nibWithNibName:@"DashboardTableViewCell_iphone4" bundle:nil];
        
         //NSLog(@"iphone4...........3");
    }
    
    [tableView registerNib:nib forCellReuseIdentifier:DashboardCellIdentifier];
    
    DashboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DashboardCellIdentifier];

    
    DashboardObject *item=[self.items objectAtIndex:indexPath.row];
    
    
    NSString *type_str = item.type;
    
    if([type_str isEqualToString:@"BP"]){
        
        cell.type.text=[Utility getStringByKey:@"preset_bp"];
        cell.img_bg.image=[UIImage imageNamed:@"dashboard_edit_step_2_BP.jpg"];
        
        
    }else if ([type_str isEqualToString:@"HR"]){
        
        cell.type.text=[Utility getStringByKey:@"heart_rate"];
        cell.img_bg.image=[UIImage imageNamed:@"dashboard_edit_step_2_HR.jpg"];

        
        
    }else if ([type_str isEqualToString:@"BG"]){
        
        cell.type.text=[Utility getStringByKey:@"preset_bg"];
        cell.img_bg.image=[UIImage imageNamed:@"dashboard_edit_step_2_BG.jpg"];

        
    }else if ([type_str isEqualToString:@"WEIGHT"]){
        
        cell.type.text=[Utility getStringByKey:@"personalinfo_weighttitle"];
        cell.img_bg.image=[UIImage imageNamed:@"dashboard_edit_step_2_WE.jpg"];

        
        
    }else if ([type_str isEqualToString:@"BMI"]){
        
        cell.type.text=[Utility getStringByKey:@"composite_bmi"];
        cell.img_bg.image=[UIImage imageNamed:@"dashboard_edit_step_2_BMI.jpg"];

        
        
    }else if ([type_str isEqualToString:@"WALK"]){
        
        cell.type.text=[Utility getStringByKey:@"composite_walk"];
        cell.img_bg.image=[UIImage imageNamed:@"dashboard_edit_step_2_WD.jpg"];

        
    }else if ([type_str isEqualToString:@"CALS"]){
        
        cell.type.text=[Utility getStringByKey:@"composite_cal"];
        cell.img_bg.image=[UIImage imageNamed:@"dashboard_edit_step_2_CALORIE.jpg"];

    }
    
    
    
    return cell;
}

#pragma mark - EditableTableViewDelegate

- (void)editableTableController:(EditableTableController *)controller willBeginMovingCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    self.itemBeingMoved = [self.items objectAtIndex:indexPath.row];
    //[self.items replaceObjectAtIndex:indexPath.row withObject:self.placeholderItem];
    
    [self.tableView endUpdates];
}

- (void)editableTableController:(EditableTableController *)controller movedCellWithInitialIndexPath:(NSIndexPath *)initialIndexPath fromAboveIndexPath:(NSIndexPath *)fromIndexPath toAboveIndexPath:(NSIndexPath *)toIndexPath
{
//    NSLog(@"11111111");
    
    
    [self.tableView beginUpdates];
//    NSLog(@"2222222");

    [self.tableView moveRowAtIndexPath:toIndexPath toIndexPath:fromIndexPath];
    
    NSString *item = [self.items objectAtIndex:toIndexPath.row];
    check1=toIndexPath.row;
//    NSLog(@"333333333 %d",toIndexPath.row);

    [self.items removeObjectAtIndex:toIndexPath.row];
    
    
//    NSLog(@"4444444");

    if (fromIndexPath.row == [self.items count])
    {
        [self.items addObject:item];
    }
    else
    {
        [self.items insertObject:item atIndex:fromIndexPath.row];
    }
//    NSLog(@"5555555");

    [self.tableView endUpdates];
    
    
    
}

- (BOOL)editableTableController:(EditableTableController *)controller shouldMoveCellFromInitialIndexPath:(NSIndexPath *)initialIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath withSuperviewLocation:(CGPoint)location
{
//    CGRect exampleRect = (CGRect){0, 0, self.view.bounds.size.width, 44.0f};
//    if (CGRectContainsPoint(exampleRect, location))
//    {
//        [self.tableView beginUpdates];
//        
//        [self.tableView deleteRowsAtIndexPaths:@[proposedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
//        
//        [self.items removeObjectAtIndex:proposedIndexPath.row];
//        
//        [self.tableView endUpdates];
//        
//        self.itemBeingMoved = nil;
//        
//        return NO;
//    }
    return YES;
}

- (void)editableTableController:(EditableTableController *)controller didMoveCellFromInitialIndexPath:(NSIndexPath *)initialIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
    
    
    
//    [self.items replaceObjectAtIndex:toIndexPath.row withObject:self.itemBeingMoved];
    

    NSLog(@"%@......",self.itemBeingMoved.type);
//    NSLog(@"---------index :%d",toIndexPath.row);
    check2=toIndexPath.row;
    
    NSLog(@"check %ld,%ld",(long)check1,(long)check2);
    
    
    if(check1==check2){
        
        NSInteger theIndext=[self.items indexOfObject:self.itemBeingMoved];
        
        NSLog(@"sort......%ld",(long)theIndext);
        
        if(theIndext==check1){
            
            [self.items replaceObjectAtIndex:toIndexPath.row withObject:self.itemBeingMoved];
            
            
            [self.tableView reloadRowsAtIndexPaths:@[toIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            self.itemBeingMoved = nil;
        }
        
        
    }
    
    
}


@end
