//
//  BGMeasureViewController.m
//  mHealth
//
//  Created by sngz on 14-3-27.
//
//

#import "BGViewController.h"
#import "BGMeasureViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "syncBG.h"
#import "NSNotificationCenter+MainThread.h"
#import "BloodGlucose.h"
#import "DBHelper.h"
#import "Utility.h"
#import "TKAlertCenter.h"

@interface BGMeasureViewController () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) NSMutableArray *deviceList;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;

@property (strong, nonatomic) NSString *status;

@property long bgDate_long;
@property NSMutableDictionary *uploadBGDict;
@property NSString *deviceLocalName;
@property NSTimer *glucoseTimer;

@property int scrollViewLastPosition;

@end

@implementation BGMeasureViewController

    @synthesize deviceLocalName;
    @synthesize deviceList;
    @synthesize glucoseTimer;
    @synthesize uploadBGDict;

    @synthesize currentTimeLabel;
    @synthesize BGValueLabel;
    
    @synthesize scrollView;
    @synthesize pageController;
    @synthesize images;
    @synthesize stepByStepView;
    @synthesize lightIntroView;
    @synthesize checkBoxImageView;

    bool allowWriteAgain;

    NSMutableArray * _errorArray;
    bool errorLayoutShow=false;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"BGMeasureViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"BGMeasureViewController_iphone4" bundle:nibBundleOrNil];
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadViewText];
    
    self.uploadFinishImageView.hidden = TRUE;
    self.statusLabel.hidden = TRUE;
    
    [self startScan];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date=[dateFormatter dateFromString:@"1900-01-01 00:00"];
    uploadBGDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:date,@"time",@"0",@"value", nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"bgData" object:nil];
    
    [self slideshowInit];
    
    
    
    
    
    //Vaycent error part
    _errorArray=[[NSMutableArray alloc]initWithObjects:@"  E- 1",@"  E- 2",@"  E- 3",@"  E- 4",@"  E- 5",@"  E- 6",@"  E- 7",@"  E- 8",@"  E- 9",@"  E- 10",nil];

    
    
    
       
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[Utility getStringByKey:@"trouble_shoot" ]];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [_troubleShoot setAttributedTitle:str forState:UIControlStateNormal];
    [_errorOkBtn setTitle:[Utility getStringByKey:@"ok" ] forState:UIControlStateNormal];
    [_errorType setText:[Utility getStringByKey:@"Type"]];
    [_errorTitle setText:[Utility getStringByKey:@"error_text_title"]];

    [_meanTitle setText:[Utility getStringByKey:@"error_mean"]];
    [_meanText setText:[Utility getStringByKey:@"error_bg_mean1"]];

    [_solutionTitle setText:[Utility getStringByKey:@"error_solution"]];
    [_solutionText setText:[Utility getStringByKey:@"error_bg_solution1"]];

    
    _errorScrollLayout.layer.cornerRadius = 12;//设置那个圆角的有多圆
    [_meanTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_solutionTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];

    
    _meanText.frame=CGRectMake(25, 138, 271, 300);
    _meanText.numberOfLines=10;
    _solutionText.frame=CGRectMake(25, 138, 271, 300);
    _solutionText.numberOfLines=10;
    _solutionTitle.frame=CGRectMake(25, 138, 271, 300);
    _solutionTitle.numberOfLines=10;
    
    [_meanText sizeToFit];
    [_solutionTitle sizeToFit];
    [_solutionText sizeToFit];
    
    _meanText.frame=CGRectMake(25, 131, 271, _meanText.frame.size.height+5);
    _solutionTitle.frame=CGRectMake(25, _meanText.frame.origin.y+_meanText.frame.size.height+20, 271, _solutionTitle.frame.size.height);
    _solutionText.frame=CGRectMake(25, _solutionTitle.frame.origin.y+ _solutionTitle.frame.size.height, 271, _solutionText.frame.size.height);

    
    

    
    
}

#pragma mark -
#pragma mark Intro SlideShow

- (void)slideshowInit {
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    pageController.numberOfPages = 3;
    pageController.currentPage = 0;
    
    NSString *languageCodeForFileName = [Utility getLanguageCode];
    self.images = [NSMutableArray arrayWithObjects: [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_BG_v2_1.png",languageCodeForFileName]],
                                                    [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_BG_v2_2.png",languageCodeForFileName]],
                                                    [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_BG_v2_3.png",languageCodeForFileName]],
                                                    [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_BG_v2_4.png",languageCodeForFileName]],
                                                    [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_BG_v2_5.png",languageCodeForFileName]],nil];
    [self setupPage:nil];
    
    self.dontShowAgainView.hidden = YES;
    _troubleShoot.hidden=true;
    if ([self isLightIntro]){
        self.lightIntroView.hidden = NO;
        self.stepByStepView.hidden = YES;
    } else {
        self.lightIntroView.hidden = YES;
        self.stepByStepView.hidden = NO;
    }
}

- (BOOL)isLightIntro{
    if ([DBHelper isLightIntro:@"BG"]==1)
        return YES;
    else
        return NO;
}

- (IBAction)showStepByStepButtonDown:(id)sender {
    [DBHelper changeLightIntro:@"BG" status:0];
    self.lightIntroView.hidden = YES;
    self.stepByStepView.hidden = NO;
}


- (IBAction)dontShowAgainButtonDown:(id)sender {
    if ([DBHelper isLightIntro:@"BG"])
    {
        self.checkBoxImageView.image = [UIImage imageNamed:@"00_checkbox_50_off.png"];
        [DBHelper changeLightIntro:@"BG" status:0];
    } else {
        self.checkBoxImageView.image = [UIImage imageNamed:@"00_checkbox_50_on.png"];
        [DBHelper changeLightIntro:@"BG" status:1];
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

    if (page == 4){
        self.dontShowAgainView.hidden = FALSE;
        _troubleShoot.hidden=false;

    }
    else{
        self.dontShowAgainView.hidden = TRUE;
        _troubleShoot.hidden=true;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_this {
    int currentPosition = scrollView_this.contentOffset.x;
    NSInteger totalPages = self.images.count;
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    self.pageController.currentPage = page;

    int scrollViewEnddingLocation = pageWidth * totalPages;
    
    if (self.scrollViewLastPosition - currentPosition > 25 ) {
        self.scrollViewLastPosition = currentPosition;
        if (page == totalPages - 1){
            self.dontShowAgainView.hidden = TRUE;
            _troubleShoot.hidden=true;
        }
        
    } else if (currentPosition - self.scrollViewLastPosition > 25) {
        self.scrollViewLastPosition = currentPosition;
    } else {
        if (page == totalPages - 1)
            if (currentPosition == scrollViewEnddingLocation){
                self.dontShowAgainView.hidden=FALSE;
                self.dontShowAgainView.hidden = false;
            }
        
        
    }
}

#pragma mark -

- (void)reloadViewText {
    
    [_dontShowAgainLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16]];
    [_dontShowAgainLabel setText:[Utility getStringByKey:@"dont_show_again"]];
    
    [_showStepByStepButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    [_showStepByStepButton setTitle:[Utility getStringByKey:@"show_detail_step"] forState:UIControlStateNormal];
    
    [_startMeasureMentNowLabel setText:[Utility getStringByKey:@"start_measurement_now"]];
    
    [_bgTitleLabel setText:[Utility getStringByKey:@"bloodglucose"]];
    [_bgTitleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [self.currentTimeLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    [self.BGValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:88]];
    [_unitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:16]];
    
    [_statusLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16]];
    [self.okButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    [self.okButton setTitle:[Utility getStringByKey:@"ok"] forState:UIControlStateNormal];
    
    // dateLabel init
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale;
    if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        [dateFormatter setDateFormat:@"dd M月 yyyy年 HH:mm"];
    } else {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat:@"dd MMM yyyy HH:mm"];
    }
    
    NSString *currentTimeStr = [dateFormatter stringFromDate:[NSDate date]];
    [currentTimeLabel setText:currentTimeStr];
    
    [_fastingLabel setFont:[UIFont fontWithName:font65 size:17]];
    [_fastingLabel setText:[Utility getStringByKey:@"fasting"]];
    
    [_beforeMealLabel setFont:[UIFont fontWithName:font65 size:17]];
    [_beforeMealLabel setText:[Utility getStringByKey:@"before_meal"]];
    
    [_afterMealLabel setFont:[UIFont fontWithName:font65 size:17]];
    [_afterMealLabel setText:[Utility getStringByKey:@"after_meal"]];
    
    [_notSpecifiedLabel setFont:[UIFont fontWithName:font65 size:17]];
    [_notSpecifiedLabel setText:[Utility getStringByKey:@"not_specified"]];
    
//    [_notSpecifiedLabel setFont:[UIFont fontWithName:font65 size:17]];
//    [_notSpecifiedLabel setText:[Utility getStringByKey:@"not_specified"]];

    
    [ _troubleShoot.titleLabel setTextColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1]];
    //

}

-(void)viewWillDisappear:(BOOL)animated{
    [self.centralManager stopScan];
    
    NSThread *uploadThread = [[NSThread alloc]initWithTarget:self selector:@selector(uploadUnloadData) object:nil];
    [uploadThread start];

}

-(void) notificationHandler:(NSNotification *) notification
{
    
    errorLayoutShow=false;
    self.stepByStepView.hidden = TRUE;
    _errorLayout.hidden=true;
    self.lightIntroView.hidden = TRUE;
    [self.statusLabel setText:[Utility getStringByKey:@"received_readings_and_uploading"]];

    NSDictionary *receiveDict = [notification object];
    NSString *dateString = [receiveDict objectForKey:@"time"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *bgDate = [dateFormatter dateFromString:dateString];
    
    
    
    
    dateString=[dateFormatter stringFromDate:bgDate];
    long currentDate_long = [bgDate timeIntervalSince1970];
    
    
    
    
//    if (self.bgDate_long < currentDate_long) {
        self.bgDate_long = currentDate_long;
        [uploadBGDict setValue:dateString forKey:@"time"];
        [uploadBGDict setValue:[receiveDict objectForKey:@"value"] forKey:@"value"];
        
        [self performSelectorOnMainThread:@selector(refreshTable) withObject:nil waitUntilDone:NO];
//    }

}

- (void)uploadUnloadData
{
    NSMutableArray *uploadBGNotUploadArray = [DBHelper getBGNotUpload];
    [syncBG uploadBGNotUpload:uploadBGNotUploadArray];
    [syncBG syncBGMonthAndWeekData];
    
    
    
}

- (void)refreshTable
{
    NSString *timeString = [NSString stringWithFormat:@"%@ %@",
                         [Utility extractDateString:[uploadBGDict objectForKey:@"time"] oldDateFormatter:@"yyyy-MM-dd HH:mm"],
                         [Utility extractTimeString:[uploadBGDict objectForKey:@"time"] oldDateFormatter:@"yyyy-MM-dd HH:mm"]];
    
    NSLog(@"vaycent test 333:%@",[uploadBGDict objectForKey:@"value"]);
    NSString *bgValue = [uploadBGDict objectForKey:@"value"];
    [self.currentTimeLabel setText:timeString];
    [self.BGValueLabel setText:bgValue];
}

- (void)saveRecordToDB {
    BloodGlucose *bgRecord = [[BloodGlucose alloc]initWithBG:[uploadBGDict objectForKey:@"value"] time:self.bgDate_long status:1 missprevious:1 type:self.status];
    bgRecord.bg=[DBHelper encryptionString:bgRecord.bg];
    [DBHelper addBGRecord:bgRecord];
    
//    NSThread *uploadThread = [[NSThread alloc]initWithTarget:self selector:@selector(uploadUnloadData) object:nil];
//    [uploadThread start];
}

- (IBAction)okButtonDown:(id)sender {
    if (self.selectView.hidden == FALSE) {
        if ([self.status isEqualToString:@""]||_status==nil) {
            //choose_one
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"choose_one"]];

//            NSLog(@"1111");
        } else {
//            NSLog(@"2222");

            [self saveRecordToDB];
            self.selectView.hidden = TRUE;
            self.statusLabel.hidden = FALSE;
//            self.uploadFinishImageView.hidden = FALSE;
        }
    } else {
        [self toBGView:self.okButton];
    }
}

- (IBAction)fastingButtonDown:(id)sender {
    [self.fastingCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_on.png"] forState:UIControlStateNormal];
    [self.afterMealCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.beforeMealCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.notSpecifiedCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    self.status = @"F";
}

- (IBAction)beforeMealButtonDown:(id)sender {
    [self.fastingCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.afterMealCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.beforeMealCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_on.png"] forState:UIControlStateNormal];
    [self.notSpecifiedCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    self.status = @"B";
}

- (IBAction)afterButtonDown:(id)sender {
    [self.fastingCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.afterMealCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_on.png"] forState:UIControlStateNormal];
    [self.beforeMealCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.notSpecifiedCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    self.status = @"A";
}

- (IBAction)notSpecifiedButtonDown:(id)sender {
    [self.fastingCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.afterMealCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.beforeMealCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_off.png"] forState:UIControlStateNormal];
    [self.notSpecifiedCheckBox setBackgroundImage:[UIImage imageNamed:@"00_checkbox_50_on.png"] forState:UIControlStateNormal];
    self.status = @"U";
}

- (IBAction)toBGView:(id)sender {
//    if(errorLayoutShow){
//        _errorLayout.hidden=true;
//        stepByStepView.hidden=false;
//        errorLayoutShow=false;
//    }
  //  else{
        BGViewController *bgView = [[BGViewController alloc]initWithNibName:@"BGViewController" bundle:nil];
        [self.navigationController pushViewController:bgView animated:YES];

 //   }

    
}

- (IBAction)BacktoBGView:(id)sender {
        if(errorLayoutShow){
            _errorLayout.hidden=true;
            stepByStepView.hidden=false;
            errorLayoutShow=false;
        }
      else{
    BGViewController *bgView = [[BGViewController alloc]initWithNibName:@"BGViewController" bundle:nil];
    [self.navigationController pushViewController:bgView animated:YES];
    
       }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startScan
{
    NSLog(@"into : %@",NSStringFromSelector(_cmd));
    
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
//            NSArray *BGUUIDArray = @[[CBUUID UUIDWithString:@"1808"],[CBUUID UUIDWithString:CBUUIDGenericAccessProfileString],[CBUUID UUIDWithString:@"fff0"]];
//            [self.centralManager scanForPeripheralsWithServices:BGUUIDArray options:nil];
            [self.centralManager scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
        }
            break;
            
        default:
            break;
    }
    
    NSLog(@"Central manger state: %@",state);
    
}

- (void)centralManager:(CBPeripheralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"into : %@",NSStringFromSelector(_cmd));
    deviceLocalName = [advertisementData objectForKey:@"kCBAdvDataLocalName"];
    NSLog(@"Discovered %@ at %@", deviceLocalName, RSSI);
    
//    if (![deviceList containsObject:peripheral] && [deviceLocalName isEqualToString:@"IDTGlucoseJacket"]){
//        self.discoveredPeripheral = peripheral;
//        [deviceList addObject:peripheral];
//    }
    
    if ([deviceLocalName isEqualToString:@"IDTGlucoseJacket"]) {
        self.discoveredPeripheral = peripheral;
        [self.centralManager connectPeripheral:self.discoveredPeripheral options:nil];
        
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)aPeripheral
{
    NSLog(@"into : %@",NSStringFromSelector(_cmd));
    
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
        //        [self cleanup:aPeripheral];
    }
    
    for (CBService *aService in aPeripheral.services)
    {
        NSLog(@"Service found with UUID: %@", aService.UUID);
    }
    for (CBService *aService in aPeripheral.services)
    {
        if ([aService.UUID isEqual:[CBUUID UUIDWithString:@"1808"]]){
//        if (![aService.UUID isEqual:[CBUUID UUIDWithString:@"180a"]] && ![aService.UUID isEqual:[CBUUID UUIDWithString:@"fff0"]]){
            [aPeripheral discoverCharacteristics:nil forService:aService];
            return;
        }
    }
    
}

- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"into : %@",NSStringFromSelector(_cmd));
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"1808"]]) {
        for(CBCharacteristic *aChar in service.characteristics)
        {
            NSLog(@"!!found char.UUID:%@",aChar.UUID);
            if([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A18"]]){
                [aPeripheral setNotifyValue:YES forCharacteristic:aChar];
                NSLog(@"2A18 Charateristic Value: %@ ",aChar.value);
                break;
            }
        }
        for(CBCharacteristic *aChar in service.characteristics)
        {
            if([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A52"]]){
                [aPeripheral setNotifyValue:YES forCharacteristic:aChar];
                break;
            }
        }
    } else if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFF0"]]) {

        for(CBCharacteristic *aChar in service.characteristics)
        {
            NSLog(@"!!found char.UUID:%@",aChar.UUID);
            if([aChar.UUID isEqual:[CBUUID UUIDWithString:@"fff1"]]){
                [aPeripheral setNotifyValue:YES forCharacteristic:aChar];
                NSLog(@"2A18 Charateristic Value: %@ ",aChar.value);
                break;
            }
        }
        for(CBCharacteristic *aChar in service.characteristics)
        {
            NSLog(@"!!found char.UUID:%@",aChar.UUID);
            if([aChar.UUID isEqual:[CBUUID UUIDWithString:@"fff2"]]){
                [aPeripheral setNotifyValue:YES forCharacteristic:aChar];
                NSLog(@"2A18 Charateristic Value: %@ ",aChar.value);
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
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A18"]]){
            glucoseTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        }
        
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%@; charUUID = %@", NSStringFromSelector(_cmd),characteristic.UUID);
    NSLog(@"error: %@",error);
}

- (void) peripheral:(CBPeripheral *)aPeripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"into : %@; Characteristic : %@",NSStringFromSelector(_cmd),characteristic.UUID);
    
    if (error)
    {
        NSLog(@"Error updating value for characteristic: %@ Charateristic:%@", [error localizedDescription], characteristic.UUID);
    }
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A52"]])
    {
        NSData *dataValue = characteristic.value;
        NSInteger len = [dataValue length];
        Byte *byteValue = (Byte*)malloc(len);
        memcpy(byteValue, [dataValue bytes], len);
        int value = byteValue[3];
        NSLog(@"%d",value);
        if (value == 1)
            return;
        
        if (!allowWriteAgain)
            return;
        allowWriteAgain = NO;
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            Byte *byteData = (Byte*)malloc(2);
            byteData[0] = 0x01;
            byteData[1] = 0x01;
            NSData *data = [NSData dataWithBytes:byteData length:2];
            NSLog(@"data to write: %@",data);
            [self.discoveredPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        });
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A18"]])
    {
        NSLog(@"2A18 data: %@",characteristic.value);
        
        NSData *data =characteristic.value;
        
        
        
        
        
        
        
        
        NSInteger len = [data length];
        Byte *byteData = (Byte*)malloc(len);
        memcpy(byteData, [data bytes], len);
        int year,month,day,hour,minute;
        year = (byteData[3]+(byteData[4]<<8));
        month = byteData[5];
        day = byteData[6];
        hour = byteData[7];
        minute = byteData[8];
//        NSString *bgDateStringBuffer = [NSString stringWithFormat:@"%04i-%02i-%02i %02i:%02i",year,month,day,hour,minute];
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyy-MM-dd HH:mm"];
        
        
        
       NSString *bgDateStringBuffer=[formatter stringFromDate:[NSDate date]];
        
        
        
        
        
        
        NSLog(@"!!bgDateStringBuffer:%@",bgDateStringBuffer);
        NSLog(@"bgDate:%@",bgDateStringBuffer);
        int value = byteData[10];
        float result = value/18.0;
        
        
        NSLog(@"vaycent test result:%f",result);
        
        NSString *bgResult = [NSString stringWithFormat:@"%.1f",result];
        
        //bgResult=[bgResult substringWithRange:NSMakeRange(0,bgResult.length-1)];

        
        
        //NSLog(@"test again:%@",bgResult);
        
        
        NSDictionary *bgDataDict = [NSDictionary dictionaryWithObjectsAndKeys:bgDateStringBuffer,@"time",bgResult,@"value", nil];
        NSLog(@"bgDataDict:%@",bgDataDict);
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"bgData" object:bgDataDict];
    }
    
}

- (void)timerFired:(NSTimer*) timer
{
    //glucose test
    //    allowDisplay = YES;
    //    allowWriteAgain = YES;
    for (CBService *aService in self.discoveredPeripheral.services){
        if ([aService.UUID isEqual:[CBUUID UUIDWithString:@"1808"]]){
            for (CBCharacteristic *aChar in aService.characteristics){
                if([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A52"]]){
                    Byte *byteData = (Byte*)malloc(2);
//                    byteData[0] = 0x01;
//                    byteData[1] = 0x01;
                    byteData[0] = 0xf2;
//                    byteData[1] = 0xf3;
                    byteData[1] = 0xf7;  //紀錄一條或者全部record

                    NSData *data = [NSData dataWithBytes:byteData length:2];
                    NSLog(@"data to write: %@",data);
                    [self.discoveredPeripheral writeValue:data forCharacteristic:aChar type:CBCharacteristicWriteWithResponse];
                    break;
                }
            }
        }
    }
}




//error part
- (IBAction)troubleShootClick:(id)sender {
    _errorLayout.hidden=false;
    stepByStepView.hidden=true;
    errorLayoutShow=true;
}
- (IBAction)errorOkBtnClick:(id)sender {
    
    
    [_errorOkBtn setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    [self performSelector:@selector(delayerrorOkBtnClickThread) withObject:nil afterDelay:0.1];
    
    
}
-(void)delayerrorOkBtnClickThread{
    _errorLayout.hidden=true;
    stepByStepView.hidden=false;
    errorLayoutShow=false;
    [_errorOkBtn setBackgroundImage:[UIImage imageNamed:@"00_btn_green_p5.png"] forState:UIControlStateNormal];

}
- (IBAction)errorTextSelectClick:(id)sender {
    if(_errorSelectLayout.hidden==true)
        _errorSelectLayout.hidden=false;
    else
        _errorSelectLayout.hidden=true;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _errorArray.count;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

    str =[_errorArray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:17];
    cell.textLabel.text=str;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    //select the item effect
    NSString *str=[NSString stringWithFormat:@" %@",[_errorArray objectAtIndex:indexPath.row]];
    _errorArrayText.text=str;
    NSLog(@"error:%@",str);
    
    switch (indexPath.row){
        case 0:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean1"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution1"]];
            break;
        case 1:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean2"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution2"]];
            break;
        case 2:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean3"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution3"]];
            break;
        case 3:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean4"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution4"]];
            break;
        case 4:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean5"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution5"]];
            break;
        case 5:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean6"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution6"]];
            break;
        case 6:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean7"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution7"]];
            break;
        case 7:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean8"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution8"]];
            break;
        case 8:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean9"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution9"]];
            break;
        case 9:
            [_meanText setText:[Utility getStringByKey:@"error_bg_mean10"]];
            [_solutionText setText:[Utility getStringByKey:@"error_bg_solution10"]];
            break;
    }
    
    
    _meanText.frame=CGRectMake(25, 138, 271, 300);
    _meanText.numberOfLines=10;
    _solutionText.frame=CGRectMake(25, 138, 271, 300);
    _solutionText.numberOfLines=10;
    _solutionTitle.frame=CGRectMake(25, 138, 271, 300);
    _solutionTitle.numberOfLines=10;
    
    [_meanText sizeToFit];
    [_solutionTitle sizeToFit];
    [_solutionText sizeToFit];
    
    _meanText.frame=CGRectMake(25, 131, 271, _meanText.frame.size.height+5);
    _solutionTitle.frame=CGRectMake(25, _meanText.frame.origin.y+_meanText.frame.size.height+20, 271, _solutionTitle.frame.size.height);
    _solutionText.frame=CGRectMake(25, _solutionTitle.frame.origin.y+ _solutionTitle.frame.size.height, 271, _solutionText.frame.size.height);

    _errorSelectLayout.hidden=true;

}









@end
