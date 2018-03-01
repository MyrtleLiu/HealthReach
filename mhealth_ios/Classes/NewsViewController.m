//
//  MessagesBoxViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-10-8.
//
//

#import "NewsViewController.h"
#import "MessageTableViewCell.h"
#import "MessageObject.h"
#import "MJRefresh.h"
#import "syncMessage.h"
#import "webViewLinkViewController.h"

@interface NewsViewController (){

}
@end

@implementation NewsViewController
@synthesize message_list;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (!iPad) {
        self = [super initWithNibName:@"NewsViewController" bundle:nibBundleOrNil];
    }
    else
    {
        
        self = [super initWithNibName:@"NewsViewController_ipad" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.rowHeight = 70;
//    self.tableView.allowsSelectionDuringEditing = YES;
    
    
    self.message_list = [NSMutableArray arrayWithCapacity:0];
    
    self.message_list=[DBHelper loadNewsFromDB];
    
    NSLog(@"self.message_list.count :%lu",(unsigned long)self.message_list.count);
//    if(self.message_list.count==0){
//                [self performSelectorInBackground:@selector(newsActionR)  withObject:nil];
//    }
}


-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"come to viewWillAppear");

    self.message_list=NULL;
    //[self.tableView reloadData];
    self.message_list=[DBHelper loadNewsFromDB];
    [self.tableView reloadData];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *count = [defaults objectForKey:[NSString stringWithFormat:@"newsNotReadCount_%@",[GlobalVariables shareInstance].login_id]];
    if([count intValue]<0){
        count=@"0";
    }
    
    if([count isEqualToString:@"0"]){
        NSString *title=[Utility getStringByKey:@"News"];
        [_actionbarTitle setText:title];
    }else{
        NSString *title=[Utility getStringByKey:@"News"];
        title=[title stringByAppendingString:@"("];
        title=[title stringByAppendingString:count];
        title=[title stringByAppendingString:@")"];
        [_actionbarTitle setText:title];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"%lu...........",(unsigned long)[self.message_list count]);
    
    return [self.message_list count];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NewsTableViewCell";
    
    UINib *nib = [UINib nibWithNibName:@"NewsTableViewCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    MessageTableViewCell *cell = (MessageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
		
    }
	
	cell.accessoryType = UITableViewCellAccessoryNone;
	
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	
    
    
    MessageObject* item = [self.message_list objectAtIndex:indexPath.row];
    

    
   
    NSString *lanuage = [Utility getLanguageCode];
    
    if ([lanuage isEqualToString:@"en"]) {
        
        [cell.msg_title setText:item.ensummary];
        
    }else{
        
        [cell.msg_title setText:item.zhsummary];
    }
    
    [cell.msg_date setText:item.send_time];

    if (self.tableView.editing)
	{

        
        [cell setChecked:item.isChecked];
    }
    
    [cell setChecked:item.isChecked];
    
    NSLog(@"item.is_read :%@",item.is_read);
    [cell setBgGray:item.is_read];
    
	
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
	
    
     MessageObject* item = [self.message_list objectAtIndex:indexPath.row];
	 if (self.tableView.editing)
	{

        
		MessageTableViewCell *cell = (MessageTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        item.isChecked = !item.isChecked;
        
		[cell setChecked:item.isChecked];
        NSLog(@"1111");
        
        return;
	}
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"--------%@",item.messageid);
    [self itemClickSwitch:item.messageid : item.is_read];
    
    NSLog(@"click..2....%ld",(long)indexPath.row);
    
    
    
    
}






//- (void)newsActionR
//{
//    self.message_list=[syncMessage getAllNewsRecord];
//
//    [self.tableView reloadData];
//
//}

-(void)itemClickSwitch: (NSString *) messageid :(NSString *) is_read{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [DBHelper setNewsRead:messageid];
    NSLog(@"get the is_Read : %@",is_read);
    if([is_read isEqualToString:@"N"]){
        
        
        int temInt = [[defaults objectForKey:[NSString stringWithFormat:@"newsNotReadCount_%@",[GlobalVariables shareInstance].login_id]] intValue]-1;

        
        NSString *temStr=[NSString stringWithFormat:@" %d",temInt];
        
        [defaults setObject:temStr forKey:[NSString stringWithFormat:@"newsNotReadCount_%@",[GlobalVariables shareInstance].login_id]];
        [defaults synchronize];
        
    }
    
    
    
    
    
    
    
    
    
    
    
    NSString *lang;
    if ([[Utility getLanguageCode] isEqualToString:@"en"])
    {
        lang=@"en";
    }
    else{
        lang=@"zh";
    }
    NSString *session_id = [GlobalVariables shareInstance].session_id;
    NSString *login_id = [GlobalVariables shareInstance].login_id;
    NSString *link = [[NSString alloc]init];
    link = [link stringByAppendingString:[Constants getAPIBase2]];
    link = [link stringByAppendingString:@"healthMessage?login="];
    if (login_id)
        link = [link stringByAppendingString:login_id];
    link = [link stringByAppendingString:@"&action=GC"];
    link = [link stringByAppendingString:@"&sessionid="];
    if (session_id)
        link = [link stringByAppendingString:session_id];
    link = [link stringByAppendingString:@"&lang="];
    link = [link stringByAppendingString:lang];
    link = [link stringByAppendingString:@"&messageid="];
    link = [link stringByAppendingString:messageid];
    
    
    
    NSLog(@"rt url:%@",link);
    
    webViewLinkViewController *intent = [[webViewLinkViewController alloc] initWithNibName:@"webViewLinkViewController" bundle:nil];
    [intent setLink:link];
    [intent setMessageid:messageid];
    [self.navigationController pushViewController:intent animated:YES ];
}






@end
