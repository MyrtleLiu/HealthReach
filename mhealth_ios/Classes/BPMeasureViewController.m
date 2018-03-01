//
//  BPMeasureViewController.m
//  mHealth
//
//  Created by gz dev team on 14年1月9日.
//
//

#import "MeasureTitleCustomCell.h"
#import "BPMeasureViewController.h"
#import "Utility.h"
#import "Constants.h"
#import "BloodPressure.h"
#import "DBHelper.h"
#import "NSNotificationCenter+MainThread.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "syncBP.h"

@interface BPMeasureViewController () <CBCentralManagerDelegate,CBPeripheralDelegate>

@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;
@property (strong ,nonatomic) CBCharacteristic *deviceChar;

@property NSString *deviceLocalName;
@property int scrollViewLastPosition;

@end

@implementation BPMeasureViewController

@synthesize dateLabel;
@synthesize dataList;

@synthesize deviceLocalName;

@synthesize scrollView;
@synthesize pageController;
@synthesize images;
@synthesize wholeScrollView;
@synthesize lightIntroView;

bool bpErrorLayoutShow=false;


// Some codes have comments "Outdated" only works for old 3.5 inch iPhone
// Delete them will not have any effect on work flow or 4.0 inch iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!iPad) {
        self = [super initWithNibName:@"BPMeasureViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"BPMeasureViewController_iphone4" bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    
    [super viewDidLoad];
     self.meaningAndsolutionVIew.hidden=YES;
    [self reloadViewText];
    [self slideshowInit];
    [self startScan];
    [self reloadDateLabel:[NSDate date]];

    // listener init
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"bpData" object:nil];
    
    // Outdated
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [[NSURL alloc]init];
    
    _array1=[[NSMutableArray alloc]initWithObjects:@" E-1",@" E-2",@" E-3",@" E-4", nil];
    if ([[Utility getLanguageCode]isEqualToString:@"cn"]){
        plistURL = [bundle URLForResource:@"measureSampleData_zh" withExtension:@"plist"];
    } else {
        plistURL = [bundle URLForResource:@"measureSampleData_en" withExtension:@"plist"];
    }
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    
    NSMutableArray *tmpDataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[dictionary count]; i++) {
        NSString *key = [[NSString alloc] initWithFormat:@"%i", i+1];
        NSDictionary *tmpDic = [dictionary objectForKey:key];
        [tmpDataArray addObject:tmpDic];
    }
    self.dataList = [tmpDataArray copy];
    self.deviceChar = nil;
    
    _checkTime=false;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.centralManager stopScan];
    
    NSThread *uploadThread = [[NSThread alloc]initWithTarget:self selector:@selector(uploadUnloadData) object:nil];
    [uploadThread start];
    
}

- (void)reloadDateLabel:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale;
    
    if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        [dateFormatter setDateFormat:@"yyyy年 M月 dd日 HH:mm"];
    } else {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm"];
    }
    
    [dateFormatter setLocale:locale];
    NSString *currentTimeStr = [dateFormatter stringFromDate:date];
    [dateLabel setText:currentTimeStr];
}

-(void)reloadViewText
{
    
    
    [ TroubleShooting.titleLabel setTextColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[Utility getStringByKey:@"trouble_shoot" ]];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [TroubleShooting setAttributedTitle:str forState:UIControlStateNormal];

    
    [_uploadImage setHidden:TRUE];
    [_dontShowAgainLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16]];
    [_dontShowAgainLabel setText:[Utility getStringByKey:@"dont_show_again"]];
    
    [_showDetailStepsButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    [_showDetailStepsButton setTitle:[Utility getStringByKey:@"show_detail_step"] forState:UIControlStateNormal];
    
    //    [_startMeasureMentNowLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16]];
    [_startMeasurementNowLabel setText:[Utility getStringByKey:@"start_measurement_now"]];
    
    [self.TitleLabel setText:[Utility getStringByKey:@"bloodpressure"]];
    [self.TitleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [self.SYSLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:44]];
    [self.DIALabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:44]];
    [self.rateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:44]];
    
    [self.SYSTitleLabel setText:[Utility getStringByKey:@"sys_title"]];
    [self.SYSTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18]];
    [self.DIATitleLabel setText:[Utility getStringByKey:@"dia_title"]];
    [self.DIATitleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18]];
    [self.rateTitleLabel setText:[Utility getStringByKey:@"hr_title"]];
    [self.rateTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:18]];
    
    [self.SYSUnitNameLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:16]];
    [self.DIAUnitNameLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:16]];
    [self.rateUnitNameLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:16]];
    
    [self.statusLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16]];
    
    [self.buttonLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    
    [self.OKButton setTitle:[Utility getStringByKey:@"ok"] forState:UIControlStateNormal];
    [self.OKButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    
    [self.btn_OK setTitle:[Utility getStringByKey:@"ok"] forState:UIControlStateNormal];
    [self.btn_OK.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    
    
    [self.type setText:[Utility getStringByKey:@"Type"]];
    [self.type setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    
    [self.error_text_title setText:[Utility getStringByKey:@"error_text_title"]];

    
    [self.chickType setText:@" E-1"];
    [self.chickType setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21]];
      _errorScrollLayout.layer.cornerRadius = 12;//设置那个圆角的有多圆
    [self meaningAndSolutionTextSize:0];
}

-(void)meaningAndSolutionTextSize:(NSInteger)sender
{
    [self.meaning setText:[Utility getStringByKey:@"error_mean"]];
    [self.meaning setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    self.meaningText.frame=CGRectMake(25, 130, 275, 100);
    self.meaningText.numberOfLines=5;
    if (sender==0)
    {
        [self.meaningText setText:[Utility getStringByKey:@"Weak signal or pressure change suddenly."]];
    }
    else if (sender==1)
    {
        [self.meaningText setText:[Utility getStringByKey:@"External strong disturbance."]];
       
    }
    else if (sender==2)
    {
        [self.meaningText setText:[Utility getStringByKey:@"It appears error during the process of inflating."]];
      
    }
    else if (sender==3)
    {
        [self.meaningText setText:[Utility getStringByKey:@"Abnormal blood pressure."]];
      
    }
    
      [self.meaningText setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:16]];
    [self.meaningText sizeToFit];
    self.meaningText.frame=CGRectMake(25, 130, 275, self.meaningText.frame.size.height+5);
    
    
    self.solution.frame=CGRectMake(25, 130+self.meaningText.frame.size.height+10, 120, 25);
    [self.solution setText:[Utility getStringByKey:@"error_solution"]];
    [self.solution setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
 
    self.solutionText.frame=CGRectMake(25, 139+self.meaningText.frame.size.height+10+10, 275, 100);
    self.solutionText.numberOfLines=5;
    if (sender==0)
    {
        [self.solutionText setText:[Utility getStringByKey:@"Wrap the cuff properly and remeasure with correct way."]];
    }
    else if (sender==1)
    {
        [self.solutionText setText:[Utility getStringByKey:@"When near cell phone or other high radiant device, the measurement will be failed. Keep quite and no chatting when measure."]];
        
    }
    else if (sender==2)
    {
        [self.solutionText setText:[Utility getStringByKey:@"Wrap the cuff properly, make sure that the air plug is properly inserted in the unit and remeasure."]];
        
    }
    else if (sender==3)
    {
        [self.solutionText setText:[Utility getStringByKey:@"Repeat the measurement after relax for 30 mins, if get unusual readings for 3 times, please contact your doctor."]];
    }
    
    [self.solutionText setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:16]];
    [self.solutionText sizeToFit];
    self.solutionText.frame=CGRectMake(25,  139+self.meaningText.frame.size.height+25, 275, self.solutionText.frame.size.height+5);
    
    
}

- (IBAction)clickLeftButton:(id)sender
{
    
//    if(bpErrorLayoutShow){
//        self.meaningAndsolutionVIew.hidden=true;
//        
//        bpErrorLayoutShow=false;
//        
//    }else{
        BPViewController *bpView = [[BPViewController alloc]initWithNibName:@"BPViewController" bundle:nil];
        [self.navigationController pushViewController:bpView animated:YES];
        
        if (self.deviceChar != nil) {
            Byte *byteData = (Byte*)malloc(6);
            byteData[0] = 0xFD;
            byteData[1] = 0xFD;
            byteData[2] = 0xFA;
            byteData[3] = 0x60;
            byteData[4] = 0x0D;
            byteData[5] = 0x0A;
            NSData *data = [NSData dataWithBytes:byteData length:6];
            [self.discoveredPeripheral writeValue:data forCharacteristic:self.deviceChar type:CBCharacteristicWriteWithResponse];

        }
//  }
    
    
    
    
    
    
    
    
  }
- (IBAction)BackLeftButton:(id)sender
{
    
    if(bpErrorLayoutShow){
        self.meaningAndsolutionVIew.hidden=true;
        
        bpErrorLayoutShow=false;
        
    }else{
        BPViewController *bpView = [[BPViewController alloc]initWithNibName:@"BPViewController" bundle:nil];
        [self.navigationController pushViewController:bpView animated:YES];
        
        if (self.deviceChar != nil) {
            Byte *byteData = (Byte*)malloc(6);
            byteData[0] = 0xFD;
            byteData[1] = 0xFD;
            byteData[2] = 0xFA;
            byteData[3] = 0x60;
            byteData[4] = 0x0D;
            byteData[5] = 0x0A;
            NSData *data = [NSData dataWithBytes:byteData length:6];
            [self.discoveredPeripheral writeValue:data forCharacteristic:self.deviceChar type:CBCharacteristicWriteWithResponse];
        }
        
    }
    
    
}

- (IBAction)clickOkButton:(id)sender {
    Byte *byteData = (Byte*)malloc(6);
    byteData[0] = 0xFD;
    byteData[1] = 0xFD;
    byteData[2] = 0xFA;
    byteData[3] = 0x60;
    byteData[4] = 0x0D;
    byteData[5] = 0x0A;
    NSData *data = [NSData dataWithBytes:byteData length:6];
    [self.discoveredPeripheral writeValue:data forCharacteristic:self.deviceChar type:CBCharacteristicWriteWithResponse];
    
    BPViewController *bpView = [[BPViewController alloc]initWithNibName:@"BPViewController" bundle:nil];
    [self.navigationController pushViewController:bpView animated:YES];
}

#pragma mark -
#pragma mark Slideshow & Light intro

- (BOOL)isLightIntro
{
    if ([DBHelper isLightIntro:@"BP"]==1)
        return YES;
    else
        return NO;
}

- (IBAction)changeLightIntroButtonDown:(id)sender
{
    [DBHelper changeLightIntro:@"BP" status:0];
    self.lightIntroView.hidden = YES;
    self.wholeScrollView.hidden = NO;
}

- (IBAction)dontShowAgainTouchDown:(id)sender {
    if ([DBHelper isLightIntro:@"BP"])
    {
        self.checkBoxImageView.image = [UIImage imageNamed:@"00_checkbox_50_off.png"];
        [DBHelper changeLightIntro:@"BP" status:0];
    } else {
        self.checkBoxImageView.image = [UIImage imageNamed:@"00_checkbox_50_on.png"];
        [DBHelper changeLightIntro:@"BP" status:1];
    }
}

- (void)slideshowInit
{
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    pageController.numberOfPages = 3;
    pageController.currentPage = 0;
    
    NSString *languageCodeForFileName = [Utility getLanguageCode];
    self.images = [NSMutableArray arrayWithObjects: [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_BP_v2_1.png",languageCodeForFileName]],
                   [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_BP_v2_2.png",languageCodeForFileName]],
                   [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_BP_v2_3.png",languageCodeForFileName]], nil];

    
    
    [self setupPage:nil];
    
    self.dontShowAgainView.hidden = YES;
    TroubleShooting.hidden=YES;
    if ([self isLightIntro]){
        self.lightIntroView.hidden = NO;
        self.wholeScrollView.hidden = YES;
    } else {
        self.lightIntroView.hidden = YES;
        self.wholeScrollView.hidden = NO;
    }
}

- (void)setupPage:(id)sender
{
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.canCancelContentTouches = NO;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.directionalLockEnabled = NO;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    NSUInteger pages = 0;
    int originX = 0;
    for (UIImage *image in self.images){
        UIImageView *pImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 498)];
        pImageView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        [pImageView setImage:image];
        CGRect rect = self.scrollView.frame;
        rect.origin.x = originX;
        rect.origin.y = 30;
        rect.size.width = self.scrollView.frame.size.width;
        rect.size.height = self.scrollView.frame.size.height;
        pImageView.frame = rect;
        pImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:pImageView];
        originX += self.scrollView.frame.size.width;
        pages++;
    }
    [self.pageController addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    self.pageController.numberOfPages = pages;
    self.pageController.currentPage = 0;
    self.pageController.tag = 110;
    [self.scrollView setContentSize:CGSizeMake(originX, self.scrollView.bounds.size.height)];
}

- (void)changePage:(id)sender
{
    CGRect rect = self.scrollView.frame;
    rect.origin.x = self.pageController.currentPage * self.scrollView.frame.size.width;
    rect.origin.y = 0;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    self.pageController.currentPage = page;
    
    if (page == 2)
    {   self.dontShowAgainView.hidden = FALSE;
        TroubleShooting.hidden=NO;
    }
    else
    {
        self.dontShowAgainView.hidden = TRUE;
         TroubleShooting.hidden=YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_this {
    int currentPosition = scrollView_this.contentOffset.x;
    NSInteger totalPages = self.images.count;
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    self.pageController.currentPage = page;
    
    int scrollViewEnddingLocation = pageWidth * totalPages;
    
    // moving left
    if (self.scrollViewLastPosition - currentPosition > 25 ) {
        self.scrollViewLastPosition = currentPosition;
        if (page == totalPages - 1)
        {
            self.dontShowAgainView.hidden = TRUE;
         TroubleShooting.hidden=YES;
        }
    // moving right
    } else if (currentPosition - self.scrollViewLastPosition > 25) {
        self.scrollViewLastPosition = currentPosition;
    } else {
    // stand still
        if (page == totalPages - 1)
            if (currentPosition == scrollViewEnddingLocation)
            {
                self.dontShowAgainView.hidden=FALSE;
         TroubleShooting.hidden=NO;
            }
        
    }
}

#pragma mark -
#pragma mark Bluetooth setting up

-(void)startScan
{
    NSLog(@"into: %@",NSStringFromSelector(_cmd));
    self.centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString *state = nil;
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            state = @"Bluetooth State Unknown";
            break;
            
        case CBCentralManagerStateResetting:
            state = @"Bluetooth State Resetting";
            break;
            
        case CBCentralManagerStateUnsupported:
            state = @"Bluetooth Unsupported";
            break;
            
        case CBCentralManagerStateUnauthorized:
            state = @"Bluetooth Unauthorized";
            break;
            
        case CBCentralManagerStatePoweredOff:
        {
            state = @"Bluetooth Power Off";
            [self.centralManager stopScan];
        }
            break;
            
        case CBCentralManagerStatePoweredOn:
        {
            state = @"Bluetooth Power On";
            [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"Central manger state: %@",state);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    deviceLocalName = [advertisementData objectForKey:@"kCBAdvDataLocalName"];
    NSLog(@"Discovered %@ at %@", deviceLocalName, RSSI);
    
    if ([deviceLocalName isEqualToString:@"Bluetooth BP"]){
        self.discoveredPeripheral = peripheral;
        [self.centralManager connectPeripheral:self.discoveredPeripheral options:nil];
    }
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)aPeripheral
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [self.centralManager stopScan];
    [aPeripheral setDelegate:self];
    [aPeripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)aPeripheral error:(NSError *)error
{
    NSLog(@"Fail to connect to peripheral: %@ with error = %@", aPeripheral, [error localizedDescription]);
}

- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"into : %@",NSStringFromSelector(_cmd));
    
    if (error)
    {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
    }
    
    for (CBService *aService in aPeripheral.services)
    {
        NSLog(@"Service found with UUID: %@", aService.UUID);
        
        if ([aService.UUID isEqual:[CBUUID UUIDWithString:@"FFF0"]]){
            [aPeripheral discoverCharacteristics:nil forService:aService];
            return;
        }
    }
    
}

- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"into : %@",NSStringFromSelector(_cmd));
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFF0"]]) {
        for(CBCharacteristic *aChar in service.characteristics)
        {
            if([aChar.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]){
                [aPeripheral setNotifyValue:YES forCharacteristic:aChar];
                NSLog(@"FFF1 Charateristic Value: %@ ",aChar.value);
                break;
            }
        }
        
    }
}

- (void)peripheral:(CBPeripheral *)aPeripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"into : %@; charUUID = %@",NSStringFromSelector(_cmd),characteristic.UUID);
    if (error) {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
    
    if (characteristic.isNotifying){
        NSLog(@"Notification began on %@", characteristic);
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]){
        }
        
    }
}

- (void) peripheral:(CBPeripheral *)aPeripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    self.meaningAndsolutionVIew.hidden=YES;
    NSLog(@"into : %@; Characteristic : %@",NSStringFromSelector(_cmd),characteristic.UUID);
    
    if (error)
    {
        NSLog(@"Error updating value for characteristic: %@ Charateristic:%@", [error localizedDescription], characteristic.UUID);
    } else {
        
        Byte *toByte = (Byte *)[characteristic.value bytes];
        [self.centralManager stopScan];
        
        if (
            ((toByte[0] == 253) && (toByte[1]==253) && (toByte[2]== 252)) ||
            ((toByte[0] == 253) && (toByte[1]==253) && (toByte[2]== 240))
            ) {
            for (CBService *aService in self.discoveredPeripheral.services){
                if ([aService.UUID isEqual:[CBUUID UUIDWithString:@"FFF0"]]){
                    for (CBCharacteristic *aChar in aService.characteristics){
                        if([aChar.UUID isEqual:[CBUUID UUIDWithString:@"FFF2"]]){
                            Byte *byteData = (Byte*)malloc(6);
                            byteData[0] = 0xFD;
                            byteData[1] = 0xFD;
                            byteData[2] = 0xFA;
                            byteData[3] = 0x60;
                            byteData[4] = 0x0D;
                            byteData[5] = 0x0A;
                            self.deviceChar = aChar;
                            // Enable below code will shutdown BP Device when the receiving work is done.
//                            NSData *data = [NSData dataWithBytes:byteData length:6];
//                            NSLog(@"data to write: %@",data);
//                            [self.discoveredPeripheral writeValue:data forCharacteristic:aChar type:CBCharacteristicWriteWithResponse];
                        }
                    }
                }
            }

            NSString *bp_PUL = [NSString stringWithFormat:@"%d",toByte[3]];
            NSString *bp_SYS = [NSString stringWithFormat:@"%d",toByte[4]];
            NSString *bp_DIA = [NSString stringWithFormat:@"%d",toByte[5]];
            NSString *bp_Year_1 = [NSString stringWithFormat:@"%d",toByte[6]];
            NSString *bp_Year_2 = [NSString stringWithFormat:@"%d",toByte[7]];
            NSString *bp_Month = [NSString stringWithFormat:@"%d",toByte[8]];
            NSString *bp_Day = [NSString stringWithFormat:@"%d",toByte[9]];
            NSString *bp_Hour = [NSString stringWithFormat:@"%d",toByte[10]];
            NSString *bp_Minute = [NSString stringWithFormat:@"%d",toByte[11]];
            if ([bp_Month length]==1) {
                bp_Month = [NSString stringWithFormat:@"0%@",bp_Month];
            }
            if ([bp_Day length]==1) {
                bp_Day = [NSString stringWithFormat:@"0%@",bp_Day];
            }
            if ([bp_Hour length]==1) {
                bp_Hour = [NSString stringWithFormat:@"0%@",bp_Hour];
            }
            if ([bp_Minute length]==1) {
                bp_Minute = [NSString stringWithFormat:@"0%@",bp_Minute];
            }
            
            NSString *bp_TimeStr = [[NSString alloc]initWithFormat:@"%@%@%@%@%@%@",bp_Year_1, bp_Year_2, bp_Month, bp_Day, bp_Hour, bp_Minute];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
            NSLog(@"%@...",bp_TimeStr);
            
            
            NSDate *bp_TimeNSDate;
            if(!_checkTime){
                 bp_TimeNSDate= [NSDate date];//[dateFormatter dateFromString:bp_TimeStr];
                _timData=bp_TimeNSDate;
                 _checkTime=true;
            }else{
                bp_TimeNSDate=_timData;
            }
            
            [self reloadDateLabel:bp_TimeNSDate];
            
            NSString *bp_senddingTimeStr = [[NSNumber numberWithLong:[bp_TimeNSDate timeIntervalSince1970]] stringValue];
            NSDictionary *resultDict = [NSDictionary dictionaryWithObjectsAndKeys:bp_SYS,@"sys",bp_DIA,@"dia",bp_PUL,@"pul",bp_senddingTimeStr,@"time",nil];
            NSLog(@"Sendding BP result:%@",resultDict);
            [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"bpData" object:resultDict];

            return;
        }
    }
}

#pragma mark -
#pragma mark Handle the received data

-(void) notificationHandler:(NSNotification *) notification
{
    self.wholeScrollView.hidden = YES;
    self.lightIntroView.hidden = YES;
    [self.statusLabel setText:[Utility getStringByKey:@"received_readings_and_uploading"]];
    NSDictionary *receiveDict = [notification object];
    [self.SYSLabel setText:[receiveDict objectForKey:@"sys"]];
    [self.DIALabel setText:[receiveDict objectForKey:@"dia"]];
    [self.rateLabel setText:[receiveDict objectForKey:@"pul"]];
    
    
    NSDictionary *SYSdict = [NSDictionary dictionaryWithObjectsAndKeys: @"mmHg", @"unit",
                                                                        [receiveDict objectForKey:@"sys"], @"value",
                                                                        @"sys", @"title", nil];
    NSDictionary *DIAdict = [NSDictionary dictionaryWithObjectsAndKeys: @"mmHg", @"unit",
                                                                        [receiveDict objectForKey:@"dia"], @"value",
                                                                        @"dia", @"title", nil];
    NSDictionary *PULDict = [NSDictionary dictionaryWithObjectsAndKeys: @"bpm", @"unit",
                                                                        [receiveDict objectForKey:@"pul"], @"value",
                                                                        @"pul", @"title", nil];
    NSDictionary *tableDict = [NSDictionary dictionaryWithObjectsAndKeys:SYSdict,@"1", DIAdict,@"2", PULDict,@"3", nil];
    
    [self performSelectorOnMainThread:@selector(tableReloadData) withObject:receiveDict waitUntilDone:NO];
    [self saveResult:receiveDict];
    
    // Outdated
    NSMutableArray *measureResultTableDataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[tableDict count]; i++) {
        NSString *key = [[NSString alloc] initWithFormat:@"%i",i+1];
        NSDictionary *tmpDic = [tableDict objectForKey:key];
        [measureResultTableDataArray addObject:tmpDic];
    }
    self.dataList = [measureResultTableDataArray copy];
}

-(void)saveResult:(NSDictionary *)sendDict
{
    long bp_timeLong = (long)[sendDict objectForKey:@"time"];
    BloodPressure *bpRecord = [[BloodPressure alloc]initWithSys:[sendDict objectForKey:@"sys"] time:bp_timeLong dia:[sendDict objectForKey:@"dia"] heartrate:[sendDict objectForKey:@"pul"] status:1 missprevious:1];
    NSLog(@"bpRecord sys:%@, dia:%@ time:%ld",[bpRecord sys],[bpRecord dia],[bpRecord getRecordtime]);
    
    bpRecord.sys=[DBHelper encryptionString:bpRecord.sys];
    bpRecord.dia=[DBHelper encryptionString:bpRecord.dia];
    bpRecord.heartrate=[DBHelper encryptionString:bpRecord.heartrate];
    
    [DBHelper addBPRecord:bpRecord];
}

- (void)uploadUnloadData
{
    NSMutableArray *uploadBPNotUploadArray = [DBHelper getBPNotUpload];
    [syncBP uploadBPNotUpload:uploadBPNotUploadArray];
    [syncBP syncBPMonthAndWeekData];
}

#pragma mark -
#pragma mark Outdated codes
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexpath=%@",indexPath);
    NSLog(@"indexpath.row=%ld",(long)indexPath.row);
    NSLog(@"array1==%@",_array1);
    if (tableView==self.tableViewErrerType)
    {
        
        self.tableViewErrerType.hidden=YES;
        self.chickType.text=[_array1 objectAtIndex:indexPath.row];
        [self meaningAndSolutionTextSize:indexPath.row];
        
        
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableViewErrerType) {
        return 4;
    }
    else
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableViewErrerType) {
        return 30;
    }
    else
    return 90.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableViewErrerType)
    {
        static NSString*cellIdentifier=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        else
        {
            cell.textLabel.text=nil;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *str=[NSString new];;
        
       
            str =[_array1 objectAtIndex:indexPath.row];
            cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:21];
        
        
        cell.textLabel.text=str;
        
        return cell;

    }
    else
    {
    static NSString *MeasureTitleCustomCellIdentifier = @"MeasureTitleCustomCellIdentifier";
    
    UINib *nib = [UINib nibWithNibName:@"MeasureTitleCustomCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:MeasureTitleCustomCellIdentifier];
    
    MeasureTitleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:MeasureTitleCustomCellIdentifier];
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.dataList objectAtIndex:row];
    
    cell.titleString = [rowData objectForKey:@"title"];
    cell.valueString = [rowData objectForKey:@"value"];
    cell.unitString = [rowData objectForKey:@"unit"];
         return cell;
    }
    
    
}
-(IBAction)chickType:(id)sender
{
    if (self.tableViewErrerType.hidden==YES)
    {
        self.tableViewErrerType.hidden=NO;
    }
    else
    {
        self.tableViewErrerType.hidden=YES;
    }
}

-(void)delayokokokThread{
    self.meaningAndsolutionVIew.hidden=YES;
    bpErrorLayoutShow=false;
    [_btn_OK setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p5.png"] forState:UIControlStateNormal];
}
-(IBAction)okokok:(id)sender
{
    
    [_btn_OK setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    
    [self performSelector:@selector(delayokokokThread) withObject:nil afterDelay:0.1];

    
    
}
-(IBAction)Trouble_Shooting:(id)sender
{
    self.meaningAndsolutionVIew.hidden=NO;
    bpErrorLayoutShow=true;
}
-(void)tableReloadData
{
    [self.ResultTableView reloadData];
}

@end
