//
//  MessagesBoxViewController.m
//  mHealth
//
//  Created by smartone_sn on 14-10-8.
//
//

#import "MessagesBoxViewController.h"
#import "MessageTableViewCell.h"
#import "MessageObject.h"
#import "MJRefresh.h"
#import "syncMessage.h"
#import "webViewLinkViewController.h"

@interface MessagesBoxViewController (){
    NSString  *max_id;
    NSString  *min_id;
}

@end

@implementation MessagesBoxViewController

@synthesize message_list;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (!iPad) {
        self = [super initWithNibName:@"MessagesBoxViewController" bundle:nibBundleOrNil];
    }
    else
    {
        
        self = [super initWithNibName:@"MessagesBoxViewController_ipad" bundle:nibBundleOrNil];
    }
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

       [_managerMsg_btn setTitle:[Utility getStringByKey:@"manage_message"] forState: normal];
    _managerMsg_btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_delMsg_btn setTitle:[Utility getStringByKey:@"delete"] forState: normal];
    _delMsg_btn.titleLabel.textAlignment=NSTextAlignmentCenter;

    
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.rowHeight = 70;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    
    self.message_list = [NSMutableArray arrayWithCapacity:0];
//    for (int i=0; i<50; i++) {
//        MessageObject *item = [[MessageObject alloc] init];
//        item.ensummary = [NSString stringWithFormat:@"%d...............",i];
//        item.isChecked = NO;
//        [self.message_list addObject:item];
//        
//    }
    
    [self setupRefresh];

    
    self.message_list=[DBHelper loadMessageFromDB];
    NSLog(@"self.message_list.count :%lu",(unsigned long)self.message_list.count);
    if(self.message_list.count==0){
        _act.hidden=false;
        [_act startAnimating];
        [self performSelectorInBackground:@selector(messageBoxActionR)  withObject:nil];
    }
    else{
        _act.hidden=true;
        
        if(message_list.count>0){
            MessageObject *temObj=[message_list objectAtIndex:message_list.count-1];
            min_id=temObj.messageid;
            temObj=[message_list objectAtIndex:0];
            max_id= temObj.messageid;
            
        }
        else{
            max_id=@"0";
            min_id=@"0";
        }
        
        
        
        
       
//        for(int i=0;i<self.message_list.count;i++){
//            MessageObject *objcheck=[self.message_list objectAtIndex:i];
//            int checkMax=[max_id integerValue];
//            int checkMin=[min_id integerValue];
//            if([objcheck.messageid integerValue]>checkMax)
//                max_id=objcheck.messageid;
//            if([objcheck.messageid integerValue]<checkMin)
//                min_id=objcheck.messageid;
//            
//        }
        NSLog(@"maxid :%@",max_id);
        NSLog(@"minid :%@",min_id);
    }
    
    
   

   
    //    [syncMessage getActionMessageRecord :@"RU" : @"4"];
    
   

}


-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"come to viewWillAppear");

    self.message_list=NULL;
    //[self.tableView reloadData];
    self.message_list=[DBHelper loadMessageFromDB];
    [self.tableView reloadData];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *count = [defaults objectForKey:[NSString stringWithFormat:@"messageNotReadCount_%@",[GlobalVariables shareInstance].login_id]];
    if([count intValue]<0){
        count=@"0";
    }
    
    if([count isEqualToString:@"0"]){
        NSString *title=[Utility getStringByKey:@"message"];
        [_actionbarTitle setText:title];
 
    }else{
        NSString *title=[Utility getStringByKey:@"message"];
        title=[title stringByAppendingString:@"("];
        title=[title stringByAppendingString:count];
        title=[title stringByAppendingString:@")"];
        [_actionbarTitle setText:title];

    }
    
   
    if (iPad) {
        self.managerMsgView.frame=CGRectMake(0,416,320,64);
        self.editMsgListView.frame=CGRectMake(0,416,320,64);
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
    
    static NSString *CellIdentifier = @"MessageTableViewCell";
    
    UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    
    MessageTableViewCell *cell = (MessageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
		
    }
	
	cell.accessoryType = UITableViewCellAccessoryNone;
	
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
    MessageObject* item = [self.message_list objectAtIndex:indexPath.row];
    
    if(item.enicon!=nil&&item.zhicon!=nil&&![item.enicon isEqualToString:@""]&&![item.zhicon isEqualToString:@""]){
        
        NSData *data = [[NSData alloc]initWithBase64EncodedString:item.enicon options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        UIImage *image= [UIImage imageWithData:data];
        
        cell.msg_img.image=image;
    }
    else{
        
        cell.msg_img.image=[UIImage imageNamed:@"healthreach_apps_logo_en_1024"];;
    }
    
   
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
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        
        return;
	}
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self itemClickSwitch:item.messageid : item.is_read];
    
    
    
    
    
}


#pragma mark -
#pragma mark pull to refresh.

- (void)setupRefresh
{
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];

    //[self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];

    //[self.tableView headerBeginRefreshing];

    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];

//    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
//    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
//    self.tableView.headerRefreshingText = @"正在刷新中...";
//    
//    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    self.tableView.footerRefreshingText = @"正在加载中...";
    
    self.tableView.headerPullToRefreshText = @"";
    self.tableView.headerReleaseToRefreshText = @"";
    self.tableView.headerRefreshingText = @"";
    
    self.tableView.footerPullToRefreshText = @"";
    self.tableView.footerReleaseToRefreshText = @"";
    self.tableView.footerRefreshingText = @"";
}

- (void)headerRereshing
{
//    add data
//    for (int i = 0; i<5; i++) {
//        [self.fakeData insertObject:MJRandomData atIndex:0];
//    }
//    
//
//
//
    
    NSThread *threadForCalories = [[NSThread alloc]initWithTarget:self selector:@selector(actionRU) object:nil];
    [threadForCalories start];

    
   
    
    
    
}

- (void)footerRereshing
{
//    add data
//    for (int i = 0; i<5; i++) {
//        [self.fakeData addObject:MJRandomData];
//    }
//    
//
    NSThread *threadForCalories = [[NSThread alloc]initWithTarget:self selector:@selector(actionRP) object:nil];
    [threadForCalories start];

    
    
}


- (IBAction)managerMsg:(id)sender{
    
    self.managerMsgView.hidden=true;
    self.editMsgListView.hidden=false;
    
    [self.tableView setEditing:true animated:true];
    
    [self.tableView reloadData];
    
    [self.tableView setNeedsDisplay];
    
}
- (IBAction)delMsg:(id)sender{
    
    NSThread *threadForCalories = [[NSThread alloc]initWithTarget:self selector:@selector(actionD) object:nil];
    [threadForCalories start];
    
    
}
- (IBAction)forwardMsg:(id)sender{
    
    
    self.managerMsgView.hidden=false;
    self.editMsgListView.hidden=true;
    
    [self.tableView setEditing:false animated:false];
    [self.tableView reloadData];
}

- (void)messageBoxActionR
{
    self.message_list=[syncMessage getAllMessageRecord];

    [self.tableView reloadData];
    [_act stopAnimating];
    _act.hidden=true;
    
    if(message_list.count>0){
        MessageObject *temObj=[message_list objectAtIndex:message_list.count-1];
        min_id=temObj.messageid;
        temObj=[message_list objectAtIndex:0];
        max_id= temObj.messageid;

    }
    else{
        max_id=@"0";
        min_id=@"0";
    }
    
//    for(int i=0;i<self.message_list.count;i++){
//        MessageObject *objcheck=[self.message_list objectAtIndex:i];
//        int checkMax=[max_id integerValue];
//        int checkMin=[min_id integerValue];
//        if([objcheck.messageid integerValue]>checkMax)
//            max_id=objcheck.messageid;
//        if([objcheck.messageid integerValue]<checkMin)
//            min_id=objcheck.messageid;
//
//    }
    NSLog(@"maxid :%@",max_id);
    NSLog(@"minid :%@",min_id);

}

-(void)itemClickSwitch: (NSString *) messageid :(NSString *) is_read{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [DBHelper setMessageRead:messageid];
    NSLog(@"get the is_Read : %@",is_read);
    if([is_read isEqualToString:@"N"]){
        int temInt = [[defaults objectForKey:[NSString stringWithFormat:@"messageNotReadCount_%@",[GlobalVariables shareInstance].login_id]] intValue]-1;
        NSString *temStr=[NSString stringWithFormat:@" %d",temInt];
        
        [defaults setObject:temStr forKey:[NSString stringWithFormat:@"messageNotReadCount_%@",[GlobalVariables shareInstance].login_id]];
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


-(void)actionRU{
    BOOL check=false;
    check =[syncMessage getActionMessageRecord :@"RU" : max_id];
    self.message_list=NULL;
    self.message_list=[DBHelper loadMessageFromDB];
    if(check){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            [self.tableView headerEndRefreshing];
        });
    }
    
//    for(int i=0;i<self.message_list.count;i++){
//        MessageObject *objcheck=[self.message_list objectAtIndex:i];
//        int checkMax=[max_id integerValue];
//        int checkMin=[min_id integerValue];
//        if([objcheck.messageid integerValue]>checkMax)
//            max_id=objcheck.messageid;
//        if([objcheck.messageid integerValue]<checkMin)
//            min_id=objcheck.messageid;
//        
//    }
    NSLog(@"maxid :%@",max_id);
    NSLog(@"minid :%@",min_id);
    
    
    
}

-(void)actionRP{
    BOOL check=false;
    check =[syncMessage getActionMessageRecord :@"RP" : min_id];
    self.message_list=NULL;
    self.message_list=[DBHelper loadMessageFromDB];
    if(check){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            [self.tableView footerEndRefreshing];
        });
        
    }
    
//    for(int i=0;i<self.message_list.count;i++){
//        MessageObject *objcheck=[self.message_list objectAtIndex:i];
//        int checkMax=[max_id integerValue];
//        int checkMin=[min_id integerValue];
//        if([objcheck.messageid integerValue]>checkMax)
//            max_id=objcheck.messageid;
//        if([objcheck.messageid integerValue]<checkMin)
//            min_id=objcheck.messageid;
//        
//    }
    NSLog(@"maxid :%@",max_id);
    NSLog(@"minid :%@",min_id);

}

-(void)actionD{
    
    
    _act.hidden=false;
    [_act startAnimating];
    
    for(int i=0;i<self.message_list.count;i++){
        MessageObject* item = [self.message_list objectAtIndex:i];
        if(item.isChecked)
            [syncMessage deleteMessageRecord :item.messageid];


    }
        [_act stopAnimating];
        _act.hidden=true;
        self.message_list=NULL;
        self.message_list=[DBHelper loadMessageFromDB];
    
        self.managerMsgView.hidden=false;
        self.editMsgListView.hidden=true;
        
        [self.tableView setEditing:false animated:false];
        
        [self.tableView reloadData];

    
   
}



@end
