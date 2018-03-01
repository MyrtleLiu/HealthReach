//
//  WeightMeasureViewController.m
//  mHealth
//
//  Created by sngz on 14-2-24.
//
//

#import "WeightMeasureViewController.h"
#import "WeightViewController.h"
#import "HomeViewController.h"
#import "Utility.h"
#import "Constants.h"
#import "GlobalVariables.h"
#import "Weight.h"
#import "DBHelper.h"
#import "WeightResultViewController.h"
#import "syncWeight.h"
#import "NSNotificationCenter+MainThread.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "syncUtility.h"

@interface WeightMeasureViewController () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;

@property NSString *deviceLocalName;
@property int scrollViewLastPosition;

@end

@implementation WeightMeasureViewController

@synthesize dateLabel;
@synthesize weightValueLabel;
@synthesize bmiValueLabel;

@synthesize deviceLocalName;
// out of date
@synthesize weightPicker;

@synthesize scrollView;
@synthesize pageController;
@synthesize images;
@synthesize stepByStepView;
@synthesize lightIntroView;
@synthesize checkBoxImageView;


NSMutableArray * _errorArray;
bool weightErrorLayoutShow=false;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!iPad) {
        self = [super initWithNibName:@"WeightMeasureViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"WeightMeasureViewController_iphone4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadViewText];
    
    [self startScan];
    [self reloadDateLabel:[NSDate date]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationHandler:) name:@"weightData" object:nil];
    
    // out of date
    NSMutableArray *arrayContents = [[NSMutableArray alloc]init];
    for (int i=80;i<220;i++){
        NSString *arrayContent = [NSString stringWithFormat:@"%d",i];
        [arrayContents addObject:arrayContent];
    }
    pickerArray = [arrayContents copy];
    [weightPicker selectRow:50 inComponent:0 animated:NO];

    [self slideshowInit];
    
    
    
    
    
    
    
    
    //Vaycent error part
    _errorArray=[[NSMutableArray alloc]initWithObjects:@"  Lo",@"  oL",nil];
    
    
    
    [ _troubleShoot.titleLabel setTextColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[Utility getStringByKey:@"trouble_shoot" ]];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [_troubleShoot setAttributedTitle:str forState:UIControlStateNormal];
    [_errorOkBtn setTitle:[Utility getStringByKey:@"ok" ] forState:UIControlStateNormal];
    [_errorType setText:[Utility getStringByKey:@"Type"]];
    [_errorTitle setText:[Utility getStringByKey:@"error_text_title"]];
    
    [_meanTitle setText:[Utility getStringByKey:@"error_mean"]];
    [_meanText setText:[Utility getStringByKey:@"error_weight_Lo_mean"]];
    
    [_solutionTitle setText:[Utility getStringByKey:@"error_solution"]];
    [_solutionText setText:[Utility getStringByKey:@"error_weight_Lo_solution"]];
    
    //
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
    self.images = [NSMutableArray arrayWithObjects: [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_Weight_v1_1.png",languageCodeForFileName]],
                   [UIImage imageNamed:[NSString stringWithFormat:@"%@_measurement_Weight_v1_2.png",languageCodeForFileName]], nil];

    
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
    if ([DBHelper isLightIntro:@"WEIGHT"]==1)
        return YES;
    else
        return NO;
}

- (IBAction)showStepByStepButtonDown:(id)sender {
    [DBHelper changeLightIntro:@"WEIGHT" status:0];
    self.lightIntroView.hidden = YES;
    self.stepByStepView.hidden = NO;
}


- (IBAction)dontShowAgainButtonDown:(id)sender {
    if ([DBHelper isLightIntro:@"WEIGHT"])
    {
        self.checkBoxImageView.image = [UIImage imageNamed:@"00_checkbox_50_off.png"];
        [DBHelper changeLightIntro:@"WEIGHT" status:0];
    } else {
        self.checkBoxImageView.image = [UIImage imageNamed:@"00_checkbox_50_on.png"];
        [DBHelper changeLightIntro:@"WEIGHT" status:1];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGFloat pageWith = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    
    if (page == 1){
        self.dontShowAgainView.hidden = FALSE;
        _troubleShoot.hidden=false;
    }
    else{
        self.dontShowAgainView.hidden = TRUE;
        _troubleShoot.hidden=TRUE;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWith = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    self.pageController.currentPage = page;
    
    if (page == 1){
        self.dontShowAgainView.hidden = FALSE;
        _troubleShoot.hidden=false;
    }
    else{
        self.dontShowAgainView.hidden = TRUE;
        _troubleShoot.hidden=TRUE;
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
                _troubleShoot.hidden=false;
            }
        
        
    }
}

#pragma mark -

-(void) notificationHandler:(NSNotification *) notification
{
    
   weightErrorLayoutShow=false;
    [self.statusLabel setText:[Utility getStringByKey:@"received_readings_and_uploading"]];
    self.stepByStepView.hidden = TRUE;
    _errorLayout.hidden=true;
    self.lightIntroView.hidden = TRUE;
    NSDictionary *receiveDict = [notification object];
    NSLog(@"!!weight receiveDict:%@",receiveDict);

    
    float weightValue = [[receiveDict objectForKey:@"weight"] floatValue];
    float heightValue = [[Utility getNewestHeight]floatValue];
    float bmiValue = round(weightValue/heightValue/heightValue*100000)/10;
    NSString *bmiStr = [NSString stringWithFormat:@"%f",bmiValue];
    bmiStr = [Utility getRoundFloatNSString:bmiStr maximumFractionDigits:1];
    [self.bmiValueLabel setText:bmiStr];
    
    float weightValue_lbs = weightValue * 2.2065;
    NSString *weightValue_lbs_nsstring = [NSString stringWithFormat:@"%f",weightValue_lbs];
    weightValue_lbs_nsstring = [Utility getRoundFloatNSString:weightValue_lbs_nsstring maximumFractionDigits:2];
    
    
    NSString *weightTime_nsstring = [receiveDict objectForKey:@"time"];
    long  weightTime_long = (long)[weightTime_nsstring longLongValue];
    Weight *weightRecord = [[Weight alloc]initWithWeight:weightValue_lbs_nsstring bmi:bmiStr time:weightTime_long status:1 missprevious:0];
    
    
    weightRecord.weight=[DBHelper encryptionString:weightRecord.weight];
    weightRecord.bmi=[DBHelper encryptionString:weightRecord.bmi];


    
    
    
    [DBHelper addWeightRecord:weightRecord];
    
    [self.weightValueLabel setText:[Utility transeferWeightValue:[NSString stringWithFormat:@"%0.1f",weightValue_lbs]precision:1]];
}

- (void)uploadUnloadData
{
    [syncWeight uploadData];
    [syncWeight syncWeightMonthAndWeekData];
    NSString *weightValue = self.weightValueLabel.text;
    if (!([weightValue rangeOfString:@"-"].length > 0)) {
        [syncUtility updatePersonalInfo:self.weightValueLabel.text];
    }
}

- (void)reloadDateLabel:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale;
    
    if ([[Utility getLanguageCode] isEqualToString:@"cn"]){
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        [dateFormatter setDateFormat:@" yyyy年 M月 dd日 HH:mm"];
    } else {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setDateFormat:@" dd MMM yyyy HH:mm"];
    }
    
    [dateFormatter setLocale:locale];
    NSString *currentTimeStr = [dateFormatter stringFromDate:date];
    [dateLabel setText:currentTimeStr];
}

-(void)reloadViewText{
    [_uploadImage setHidden:TRUE];
    [_dontShowAgainLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16]];
    [_dontShowAgainLabel setText:[Utility getStringByKey:@"dont_show_again"]];
    
    [_showDetailStepsButton setTitle:[Utility getStringByKey:@"show_detail_step"] forState:UIControlStateNormal];
    [_showDetailStepsButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    //    [_startMeasureMentNowLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16]];
    [_startMeasurementNowLabel setText:[Utility getStringByKey:@"start_measurement_now"]];
    
    
    [_weight_title setText:[Utility getStringByKey:@"home_title_Weight"]];
    [_weight_title setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    
    [self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:18]];
    [self.weightValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:66]];
    [self.weightUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:20]];
    [self.weightUnitLabel setText:[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"]];

    [self.bmiValueLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:66]];
    [self.bmiUnitLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:20]];
    [self.statusLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Md" size:16]];
    [self.OKButton setTitle:[Utility getStringByKey:@"ok"] forState:UIControlStateNormal];
    [self.OKButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:17]];
    
    [_weight_unit setText:[Utility getStringByKey:@"weight_unit"]];
    [_add_weight_title setText:[Utility getStringByKey:@"add_weight_title"]];
    [_ok setText:[Utility getStringByKey:@"ok"]];
    [_cancel setText:[Utility getStringByKey:@"cancel"]];
    
//    [self.showStepByStepButton.titleLabel setFont]
    
    [ _troubleShoot.titleLabel setTextColor:[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1]];

}

#pragma mark -
#pragma mark Bluetooth

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
            [self.centralManager scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
            NSLog(@"Scanning started");
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
    
    if ([deviceLocalName isEqualToString:@"WS681BLE"]){
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
        //        [self cleanup:aPeripheral];
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
            if([aChar.UUID isEqual:[CBUUID UUIDWithString:@"FFF4"]]){
                [aPeripheral setNotifyValue:YES forCharacteristic:aChar];
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
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF4"]]){
        }
        
    }
}

- (void) peripheral:(CBPeripheral *)aPeripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    NSLog(@"into : %@; Characteristic : %@",NSStringFromSelector(_cmd),characteristic.UUID);
    
    if (error)
    {
        NSLog(@"Error updating value for characteristic: %@ Charateristic:%@", [error localizedDescription], characteristic.UUID);
    } else {
        
        Byte *toByte = (Byte *)[characteristic.value bytes];
        [self.centralManager stopScan];
            for (int i=0;i<=[characteristic.value length];i++){
                NSLog(@"!!toByte[%d]:%hhu",i,toByte[i]);
            }
        int weightValue_kg10 = ((toByte[1]-((toByte[1]>>6)<<6))<<8) + toByte[2];
        float weightValue_kg = weightValue_kg10*1.0f/10.0f;
        float weightValue_lbs = 2.2065 * weightValue_kg;
        NSString *weightValue_nsstring = [NSString stringWithFormat:@"%f",weightValue_kg];
        weightValue_nsstring = [Utility getRoundFloatNSString:weightValue_nsstring maximumFractionDigits:1];
        NSString *weightValueLBS_nsstring = [NSString stringWithFormat:@"%f",weightValue_lbs];
        weightValueLBS_nsstring = [Utility getRoundFloatNSString:weightValueLBS_nsstring maximumFractionDigits:0];
        NSLog(@"!!weightValue_nsstring:%@",weightValue_nsstring);
    
        NSDate *currentTime_nsdate = [[NSDate alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"dd MM yyyy HH:mm"];
        NSString *currentTime_nsstring = [dateFormatter stringFromDate:currentTime_nsdate];
        currentTime_nsdate = [dateFormatter dateFromString:currentTime_nsstring];
        currentTime_nsstring = [[NSNumber numberWithLong:[currentTime_nsdate timeIntervalSince1970]]stringValue];
        NSDictionary *resultDict = [NSDictionary dictionaryWithObjectsAndKeys:weightValue_nsstring,@"weight",
                                                                            currentTime_nsstring,@"time",nil];
        
//        [syncUtility updatePersonalInfo:weightValueLBS_nsstring];
        [[NSNotificationCenter defaultCenter] postMainThreadNotificationWithName:@"weightData" object:resultDict];

        return;
    }
}

#pragma mark -
#pragma mark Util

- (IBAction)toWeightView:(id)sender {
    
//    if(weightErrorLayoutShow){
//        _errorLayout.hidden=true;
//        stepByStepView.hidden=false;
//        weightErrorLayoutShow=false;
//    }else{
    
    
           WeightViewController *weightView = [[WeightViewController alloc]initWithNibName:@"WeightViewController" bundle:nil];
        
        [self.navigationController pushViewController:weightView animated:YES];

 //   }
    
    
}

- (IBAction)backtoWeightView:(id)sender
{
        if(weightErrorLayoutShow){
            _errorLayout.hidden=true;
            stepByStepView.hidden=false;
            weightErrorLayoutShow=false;
        }else{
    WeightViewController *weightView = [[WeightViewController alloc]initWithNibName:@"WeightViewController" bundle:nil];
    
    [self.navigationController pushViewController:weightView animated:YES];
    
       }
    
}
- (IBAction)toHome:(id)sender {
    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeView animated:YES];
}

-(NSString *)calcBMI:(NSString *)weightStr {
    
    float weightValue = [weightStr intValue];
    float heightValue = [[Utility getNewestHeight]intValue];
    float bmiValue = round(weightValue*0.4536/heightValue/heightValue*100000)/10;
    NSString *bmiStr = [NSString stringWithFormat:@"%.1f",bmiValue];
    return bmiStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.centralManager stopScan];
    NSThread *uploadThread = [[NSThread alloc]initWithTarget:self selector:@selector(uploadUnloadData) object:nil];
    [uploadThread start];
    
}

// out of date
- (IBAction)clickOkButton:(id)sender {
    NSInteger row = [weightPicker selectedRowInComponent:0];
    NSString *weightStr = [pickerArray objectAtIndex:row];
    NSString *bmiStr = [self calcBMI:weightStr];
    
    
    long currentDateLong = [[NSDate date]timeIntervalSince1970]-10000;
    
    Weight *weightRecord = [[Weight alloc]initWithWeight:weightStr bmi:bmiStr time:currentDateLong status:1 missprevious:0];
    [DBHelper addWeightRecord:weightRecord];
    
    NSThread *uploadThread = [[NSThread alloc]initWithTarget:self selector:@selector(uploadUnloadData) object:nil];
    [uploadThread start];
    
    WeightResultViewController *weightResultView = [[WeightResultViewController alloc]initWithNibName:@"WeightResultViewController" bundle:nil];
    [self.navigationController pushViewController:weightResultView animated:YES];

}



- (IBAction)clickCancelButton:(id)sender {
    WeightViewController *weightView = [[WeightViewController alloc]initWithNibName:@"WeightViewController" bundle:nil];
    
    [self.navigationController pushViewController:weightView animated:YES];

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}














//error part
- (IBAction)troubleShootClick:(id)sender {
    _errorLayout.hidden=false;
    stepByStepView.hidden=true;
    weightErrorLayoutShow=true;
}
- (IBAction)errorOkBtnClick:(id)sender {
    
    
    [_errorOkBtn setBackgroundImage:[UIImage imageNamed:@"btn_green_p2_effect.png"] forState:UIControlStateNormal];
    
    [self performSelector:@selector(delayerrorOkBtnClickThread) withObject:nil afterDelay:0.1];
    
    
    
   
}
-(void)delayerrorOkBtnClickThread{
    _errorLayout.hidden=true;
    stepByStepView.hidden=false;
    weightErrorLayoutShow=false;
    
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
            [_meanText setText:[Utility getStringByKey:@"error_weight_Lo_mean"]];
            [_solutionText setText:[Utility getStringByKey:@"error_weight_Lo_solution"]];
            break;
        case 1:
            [_meanText setText:[Utility getStringByKey:@"error_weight_oL_mean"]];
            [_solutionText setText:[Utility getStringByKey:@"error_weight_oL_solution"]];
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
