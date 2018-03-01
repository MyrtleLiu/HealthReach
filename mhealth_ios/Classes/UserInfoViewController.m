//
//  UserInfoViewController.m
//  mHealth
//
//  Created by sngz on 14-2-28.
//
//

#import "UserInfoViewController.h"
#import "HomeViewController.h"
#import "GlobalVariables.h"
#import "Constants.h"
//#import "DDXMLDocument.h"
#import "DDXMLElementAdditions.h"
#import "Utility.h"
#import "Weight.h"
#import "DBHelper.h"
#import "syncUtility.h"
#import "mHealth_iPhoneAppDelegate.h"
#import "TKAlertCenter.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

@synthesize weightTextField;
@synthesize heightTextField,circumferenceTextField;
@synthesize circumferencedisplayValueLabel;
@synthesize birthPicker;
@synthesize from;


@synthesize WeightTemValue;    //use lb for the unit
@synthesize CircuTemValue;    //use cm for the unit
@synthesize HeightTemValue;    //use cm for the unit




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    //self = [super initWithNibName:@"UserInfoViewController_iphone5" bundle:nibBundleOrNil];
    
    if (!iPad) {
        self = [super initWithNibName:@"UserInfoViewController_iphone5" bundle:nibBundleOrNil];
    }
    else
    {
        NSLog(@"3.5 inch");
        self = [super initWithNibName:@"UserInfoViewController" bundle:nibBundleOrNil];
    }
    
    return self;
}

//-(void)keyboardOnScreen:(NSNotification *)notification
//{
//    NSDictionary *info  = notification.userInfo;
//    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
//
//    CGRect rawFrame      = [value CGRectValue];
//    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
//
//    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
//}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    for (int i=0; i<[self.navigationController.viewControllers count]; i++) {
        
        UIViewController *view=[self.navigationController.viewControllers objectAtIndex:i];
        
        
        
        NSLog(@"111find home index...0...%d.....%@",i,[view class]);
        
//        if(session_id==NULL||login_id==NULL){
//            
//            if ([view isMemberOfClass:[HomeViewControllerFirst class]]) {
//                
//                homeIndex=i;
//                
//                NSLog(@"find home index..1....%d",homeIndex);
//            }
//            
//            
//        }
//        else{
//            if ([view isMemberOfClass:[HomeViewController class]]) {
//                
//                homeIndex=i;
//                
//                NSLog(@"find home index...2...%d",homeIndex);
//            }
//            
//        }
        
        
        
    }

    
    
    
    
    
    
    //    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
    _actionbar.font=[UIFont fontWithName:font65 size:18];
    [_actionbar setText:[Utility getStringByKey:@"personalinfo"]];
    [_topTitleText setText:[Utility getStringByKey:@"personalinfo_toptx"]];
    
    _topTitleText.font=[UIFont fontWithName:font65 size:15];
    _birthTtile.font=[UIFont fontWithName:font65 size:16];
    _genderTitle.font=[UIFont fontWithName:font65 size:16];
    _weightTitle.font=[UIFont fontWithName:font65 size:16];
    _heightTtile.font=[UIFont fontWithName:font65 size:16];
    _circumTtile.font=[UIFont fontWithName:font65 size:16];
    
    _birthValueLabel.font=[UIFont fontWithName:font65 size:18];
    _genderValueLabel.font=[UIFont fontWithName:font65 size:18];
    weightTextField.font=[UIFont fontWithName:font65 size:18];
    heightTextField.font=[UIFont fontWithName:font65 size:18];
    circumferenceTextField.font=[UIFont fontWithName:font65 size:18];
    
    _weightdisplayValueLabel.font=[UIFont fontWithName:font55 size:18];
    _heightdisplayValueLabel.font=[UIFont fontWithName:font55 size:18];
    circumferencedisplayValueLabel.font=[UIFont fontWithName:font55 size:18];
    
    _feet_textFile.font=[UIFont fontWithName:font65 size:18];
    _inch_textFile.font=[UIFont fontWithName:font65 size:18];
    
    [_birthTtile setText:[Utility getStringByKey:@"personalinfo_birthtitle"]];
    [_genderTitle setText:[Utility getStringByKey:@"personalinfo_gendertitle"]];
    [_weightTitle setText:[Utility getStringByKey:@"personalinfo_weighttitle"]];
    [_heightTtile setText:[Utility getStringByKey:@"personalinfo_heighttitle"]];
    [_circumTtile setText:[Utility getStringByKey:@"personalinfo_circum"]];
    
    [_okBtn setTitle:[Utility getStringByKey:@"done"] forState: normal];
    _okBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_cancelBtn setTitle:[Utility getStringByKey:@"cancel"] forState: normal];
    _cancelBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initYearPicker];
    [self fillTextFields];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setBool: true forKey: @"reallogin"];

    
    
}

-(void)initYearPicker{
    
    self.birthPicker= [[AFPickerView alloc] initWithFrame:CGRectMake(70, 50, 147, 172)];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
    
    
    NSInteger year=dateComponent.year;
    
    yearsData = [[NSMutableArray alloc] init];
    
    for (NSInteger i=(year-120); i<=year; i++) {
        
        [yearsData addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    
    
    self.birthPicker.dataSource = self;
    self.birthPicker.delegate = self;
    [self.birthPicker reloadData];
    if([_birthValueLabel.text isEqualToString:@""]||_birthValueLabel.text==nil){
        [self.birthPicker setSelectedRow:[yearsData count]-1];
    }
    else{
        NSInteger temp_int=year-[_birthValueLabel.text integerValue];
        NSLog(@"check the temp : %ld",(long)temp_int);
        [self.birthPicker setSelectedRow:120-temp_int];
    }
    [self.chooseBirthContentView addSubview:self.birthPicker];
    
    yearTmpValue=@"";
    
}

-(void)fillTextFields{
    
    
    self.birthValueLabel.text=[Utility getBirth];
    self.genderValueLabel.text=[[Utility getGender] isEqualToString:@"M"]?[Utility getStringByKey:@"male_unit"]:[Utility getStringByKey:@"female_unit"];
    
    
    
    
    self.weightdisplayValueLabel.text=[[Utility getWeightdisplay] isEqualToString:@"lb"]?[Utility getStringByKey:@"lb_unit"]:[Utility getStringByKey:@"kg_unit"];
    
    NSLog(@"[[Utility getWeight] floatValue][[Utility getWeight] floatValue][[Utility getWeight] floatValue][[Utility getWeight] floatValue] :%f",[[Utility getWeight] floatValue]);
    
    if([self.weightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"lb_unit"]]){
        WeightTemValue=[[Utility getWeight] floatValue];
    }
    else{
        WeightTemValue=[[Utility getWeight] floatValue]/2.2f;
    }
//    self.weightTextField.text=[Utility getWeight];
    self.weightTextField.text=[NSString stringWithFormat:@"%.1f",WeightTemValue] ;
    
    
    
    
    self.heightTextField.text=[Utility getHeight];

    self.heightdisplayValueLabel.text=[[Utility getHeightdisplay] isEqualToString:@"cm"]?[Utility getStringByKey:@"cm_unit"]:[Utility getStringByKey:@"feet_in_unit"];
    
    double temInt=[[Utility getHeight] doubleValue];
//    NSInteger temInt=[heightTextField.text integerValue];
    float height_inchs = temInt/2.54;

    int feet = (int) (height_inchs / 12);
//    int inch=(int)((int)height_inchs%12);

    int inch=temInt/2.54-feet*12;

    
    _feet_textFile.text=[NSString stringWithFormat:@"%d",feet];
    _inch_textFile.text=[NSString stringWithFormat:@"%d",inch];
    if([[Utility getHeightdisplay] isEqualToString:@"in"]){
        
        self.feet_in_view.hidden=false;
        self.heightTextField.hidden=true;
    }
    
    
    
    
    self.circumferenceTextField.text=[Utility getCircumference];

    //    self.circumferencedisplayValueLabel.text=[Utility getCircumferencedisplay];
    self.circumferencedisplayValueLabel.text=[[Utility getCircumferencedisplay] isEqualToString:@"cm"]?[Utility getStringByKey:@"cm_unit"]:[Utility getStringByKey:@"inch_unit"];
//    if([self.circumferencedisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"inch_unit"]]){
//        NSString *strTem=[Utility getCircumference];
//        float floTem=[strTem floatValue];
//        floTem=floTem*2.54;
//        self.circumferenceTextField.text=[NSString stringWithFormat:@"%.2f",floTem];
//    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rel{
    
    genderDropDown = nil;
    weightDropDown=nil;
    heightDropDown=nil;
    circumferenceDropDown=nil;
}

-(void)hideDropDown{
    
    
    if (genderDropDown) {
        
        [genderDropDown hideDropDown];
    }
    
    
    if (weightDropDown) {
        
        [weightDropDown hideDropDown];
    }
    
    if (heightDropDown) {
        
        [heightDropDown hideDropDown];
    }
    
    if (circumferenceDropDown) {
        
        [circumferenceDropDown hideDropDown];
    }
    
}

- (IBAction)hideChooseBirth:(id)sender{
    
    self.chooseBirthView.hidden=true;
}

- (IBAction)saveBirth:(id)sender{
    
    self.chooseBirthView.hidden=true;
    
    
    if (![yearTmpValue isEqualToString:@""]) {
        
        yearValue=[NSString stringWithFormat:@"%@",yearTmpValue];
        
        yearTmpValue=@"";
        
        self.birthValueLabel.text=yearValue;
    }
    
    
}

- (IBAction)showChooseBirth:(id)sender{
    NSLog(@"11111");
    self.chooseBirthView.hidden=false;
}

- (IBAction)chooseGender:(id)sender{
    
    [self backgroundTap:nil];
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:[Utility getStringByKey:@"male_unit"], [Utility getStringByKey:@"female_unit"],nil];
    if(genderDropDown == nil) {
        
        genderDropDown = [[NIDropDown alloc] init];
        [genderDropDown showDropDown:self.genderValueLabel width:279 height:80 data:arr];
        genderDropDown.delegate = self;
    }
    else {
        [self hideDropDown];
        [self rel];
    }
    
}

- (IBAction)chooseWeightdisplay:(id)sender{
    
    [self backgroundTap:nil];
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:[Utility getStringByKey:@"lb_unit"], [Utility getStringByKey:@"kg_unit"],nil];
    if(weightDropDown == nil) {
        
        [self hideDropDown];
        
        weightDropDown = [[NIDropDown alloc] init];
        [weightDropDown showDropDown:self.weightdisplayValueLabel width:93 height:80 data:arr];
        weightDropDown.delegate = self;
        
        if([self.weightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"lb_unit"]]){
            WeightTemValue=[weightTextField.text floatValue];
        }
        else{
            WeightTemValue=[weightTextField.text floatValue]*2.2f;
        }
        weightDropDown.tag=1;
        
    }
    else {
        [self hideDropDown];
        [self rel];
    }
    
}
- (IBAction)chooseHeightdisplay:(id)sender{
    
    [self backgroundTap:nil];
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:[Utility getStringByKey:@"cm_unit"], [Utility getStringByKey:@"feet_in_unit"],nil];
    if(heightDropDown == nil) {
        
        [self hideDropDown];
        
        heightDropDown = [[NIDropDown alloc] init];
        [heightDropDown showDropDown:self.heightdisplayValueLabel width:93 height:80 data:arr];
        heightDropDown.delegate = self;
        
        
        if([self.weightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"cm_unit"]]){
            HeightTemValue=[heightTextField.text floatValue];
        }
        else{
            HeightTemValue=(([_feet_textFile.text floatValue]*12+[_inch_textFile.text floatValue])*2.54);
        }
        
        
        
        heightDropDown.tag=2;
    }
    else {
        [self hideDropDown];
        [self rel];
    }
    
    
    
}
- (IBAction)chooseCircumferencedisplay:(id)sender{
    
    [self backgroundTap:nil];
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:[Utility getStringByKey:@"cm_unit"], [Utility getStringByKey:@"inch_unit"],nil];
    if(circumferenceDropDown == nil) {
        
        [self hideDropDown];
        
        circumferenceDropDown = [[NIDropDown alloc] init];
        [circumferenceDropDown showDropDown:self.circumferencedisplayValueLabel width:93 height:80 data:arr];
        circumferenceDropDown.delegate = self;
        
        
        
        if([self.circumferencedisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"cm_unit"]]){
            CircuTemValue=[circumferenceTextField.text floatValue];
        }
        else{
            CircuTemValue=[circumferenceTextField.text floatValue]*2.54f;
        }
        
        circumferenceDropDown.tag=3;
    }
    else {
        [self hideDropDown];
        [self rel];
    }
    
}


- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    if(sender.tag==1){
        if([_weightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"lb_unit"]])
        {
            self.weightTextField.text=[NSString stringWithFormat:@"%.1f",WeightTemValue];
        }
        else{
            self.weightTextField.text=[NSString stringWithFormat:@"%.1f",WeightTemValue/2.2f];
        }
    }
    else if (sender.tag==2) {
        //        NSLog(@"Label is : %@",_heightdisplayValueLabel.text);
        //        int temInt=[heightTextField.text integerValue];
        //        float height_inchs = temInt/2.54f;
        //        int feet = (int) (height_inchs / 12);
        //        int inch=(int)((int)height_inchs%12);
        
        if([_heightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"cm_unit"]]){
            self.feet_in_view.hidden=true;
            self.heightTextField.hidden=false;
            
            //            feet=[_feet_textFile.text integerValue];
            //            inch=[_inch_textFile.text integerValue];
            //            heightTextField.text=[NSString stringWithFormat:@"%d",(int)((feet*12+inch)*2.54)];
            heightTextField.text=[NSString stringWithFormat:@"%.2f",HeightTemValue];
        }
        else{
            //            temInt=[heightTextField.text integerValue];
            //            height_inchs = temInt/2.54f;
            //            feet = (int) (height_inchs / 12);
            //            inch=(int)((int)height_inchs%12);
            //
            //            _feet_textFile.text=[NSString stringWithFormat:@"%d",feet];
            //            _inch_textFile.text=[NSString stringWithFormat:@"%d",inch];
            
            float temfloat=HeightTemValue/2.54;
            NSLog(@"temfloat :%f",temfloat);
            int feet = (int) (temfloat/ 12);
//            int inch=(int)((int)(temfloat/2.54f))%12;
            int inch=HeightTemValue/2.54-feet*12;

            
            _feet_textFile.text=[NSString stringWithFormat:@"%d",feet];
            _inch_textFile.text=[NSString stringWithFormat:@"%d",inch];
            
            
            self.feet_in_view.hidden=false;
            self.heightTextField.hidden=true;
        }
    }
    else if(sender.tag==3){
        if([self.circumferencedisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"cm_unit"]])
        {
            self.circumferenceTextField.text=[NSString stringWithFormat:@"%.2f",CircuTemValue];
        }
        else{
            self.circumferenceTextField.text=[NSString stringWithFormat:@"%.2f",CircuTemValue/2.54f];
        }
        
    }
    
}

- (IBAction)OKButton:(id)sender {
    
    BOOL checkToUpload=[self checkRange];
    if(checkToUpload){
        genderValue=[self.genderValueLabel.text isEqualToString:[Utility getStringByKey:@"male_unit"]]?@"M":@"F";
        
        weightValue= self.weightTextField.text;
        weightDisplayValue=[self.weightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"lb_unit"]]?@"lb":@"kg";
        if([weightDisplayValue isEqualToString:@"kg"]){
            float floatTem=[self.weightTextField.text floatValue] *2.2;
            weightValue=[NSString stringWithFormat:@"%.1f",floatTem];
        }

        heightValue=self.heightTextField.text;
        heightDisplayValue=[self.heightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"cm_unit"]]?@"cm":@"in";
        if([heightDisplayValue isEqualToString:@"in"]){
             HeightTemValue=(([_feet_textFile.text floatValue]*12+[_inch_textFile.text floatValue])*2.54);
            heightValue=[NSString stringWithFormat:@"%.2f",HeightTemValue];
            NSLog(@"上傳時:%@",heightValue);
        }
        
        
        
        circumferenceValue=self.circumferenceTextField.text;
        //    circumferenceDisplayValue=self.circumferencedisplayValueLabel.text;
        circumferenceDisplayValue=[self.circumferencedisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"cm_unit"]]?@"cm":@"in";
        NSLog(@"[self.circumferenceTextField.text floatValue] :%f",[self.circumferenceTextField.text floatValue]);
//        if([circumferenceDisplayValue isEqualToString:@"in"]){
//            float floatTem=[self.circumferenceTextField.text floatValue] /2.54;
//            circumferenceValue=[NSString stringWithFormat:@"%.2f",floatTem];
//        }
        
        NSString *session_id = [GlobalVariables shareInstance].session_id;
        NSString *login_id = [GlobalVariables shareInstance].login_id;
        NSString *url_string = [[NSString alloc]init];
        url_string = [url_string stringByAppendingString:[Constants getAPIBase2]];
        url_string = [url_string stringByAppendingString:@"healthUser?login="];
        url_string = [url_string stringByAppendingString:login_id];
        url_string = [url_string stringByAppendingString:@"&sessionid="];
        url_string = [url_string stringByAppendingString:session_id];
        
        url_string = [url_string stringByAppendingString:@"&action=U"];
        
        if (yearValue){
            url_string = [url_string stringByAppendingString:@"&birth="];
            url_string = [url_string stringByAppendingString:yearValue];
        }
        if (genderValue){
            url_string = [url_string stringByAppendingString:@"&gender="];
            url_string = [url_string stringByAppendingString:genderValue];
        }
        if (weightValue){
            url_string = [url_string stringByAppendingString:@"&weight="];
            
            url_string = [url_string stringByAppendingString:weightValue];
        }
        if (weightDisplayValue){
            url_string = [url_string stringByAppendingString:@"&weightdisplay="];
            url_string = [url_string stringByAppendingString:weightDisplayValue];
        }
        if (heightValue){
            url_string = [url_string stringByAppendingString:@"&height="];
            url_string = [url_string stringByAppendingString:heightValue];
        }
        if (heightDisplayValue){
            url_string = [url_string stringByAppendingString:@"&heightdisplay="];
            url_string = [url_string stringByAppendingString:heightDisplayValue];
        }
        if (circumferenceValue){
            url_string = [url_string stringByAppendingString:@"&circumference="];
            url_string = [url_string stringByAppendingString:circumferenceValue];
            
        }
        
        if (circumferenceDisplayValue){
            url_string = [url_string stringByAppendingString:@"&circumferencedisplay="];
            url_string = [url_string stringByAppendingString:circumferenceDisplayValue];
        }

        NSURL *request_url = [NSURL URLWithString:url_string];
        NSData *xmlData = [NSData dataWithContentsOfURL:request_url];
        if (xmlData){
            int isSucc = [syncUtility XMLHasError:xmlData];
            NSLog(@"is upload user infomation succ:%d",isSucc);
            
        }
        
        
        if (from!=nil&&[from isEqualToString:@"login"]) {
            
            [Utility updateFirstTimeLogin];
            
            
            HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
            
            [self.navigationController pushViewController:homeView animated:YES];
            
            int remove=-1;
            
            for (int i=0; i<[self.navigationController.viewControllers count]; i++) {
                
                UIViewController *tmp=[self.navigationController.viewControllers objectAtIndex:i];
                
                if ([tmp isKindOfClass:[UserInfoViewController class]]) {
                    
                    remove=i;
                    
                    break;
                }
                
            }
            
            
            
            if (remove!=-1) {
                
                NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
                
                [navigationArray removeObjectAtIndex:remove];
                self.navigationController.viewControllers = navigationArray;
                
            }
            
            
        }else{
            
            if (xmlData){
                int isSucc = [syncUtility XMLHasError:xmlData];
                NSLog(@"is upload user infomation succ:%d",isSucc);
                if(isSucc==0){
                    [self back];
                }
            }
            
        }
        
    }
    
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}

-(IBAction)backgroundTap:(id)sender{
    [weightTextField resignFirstResponder];
    [heightTextField resignFirstResponder];
    [circumferenceTextField resignFirstResponder];
    
    [_feet_textFile resignFirstResponder];
    [_inch_textFile resignFirstResponder];
}

- (IBAction)cancelButtonDown:(id)sender {
    HomeViewController *homeView = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:homeView animated:YES];
}

#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
    
    return [yearsData count];
    
}




- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{
    
    
    
    return [yearsData objectAtIndex:row];
    
    
    
}




#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row
{
    
    
    
    yearTmpValue=[yearsData objectAtIndex:row];
    
    
}


NSInteger prewTag ;
float prewMoveY;

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    int theMoveValue=64;
    CGRect textFrame =  textField.frame;
    float textY = textFrame.origin.y+textFrame.size.height;
    float bottomY = self.view.frame.size.height-textY;
    
    //NSLog(@"%f..............y",bottomY);
    
    if(bottomY>=216+theMoveValue)
    {
        prewTag = -1;
        return;
    }
    prewTag = textField.tag;
    float moveY = 216+theMoveValue-bottomY;
    prewMoveY = moveY;
    
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y -=moveY;
    frame.size.height +=moveY;
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}


-(void) textFieldDidEndEditing:(UITextField *)textField
{
    if(prewTag == -1)
    {
        return;
    }
    float moveY ;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    if(prewTag == textField.tag)
    {
        moveY =  prewMoveY;
        frame.origin.y +=moveY;
        frame.size. height -=moveY;
        self.view.frame = frame;
    }
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
    
}

-(BOOL)checkRange{
    BOOL result;
    result=true;
    if([self.birthValueLabel.text isEqualToString:@""]){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_birth"]];result=false;
    }
    else if([self.genderValueLabel.text isEqualToString:@""]){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_gender"]];result=false;
    }
    else if([self.weightTextField.text isEqualToString:@""]){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_weight"]];result=false;
    }
    else if([self.heightTextField.text isEqualToString:@""]){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_height"]];result=false;
    }
    else if([self.circumferenceTextField.text isEqualToString:@""]){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_circumference"]];result=false;
    }
    else if([self.feet_textFile.text isEqualToString:@""]){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_height"]];result=false;
    }
    else if([self.inch_textFile.text isEqualToString:@""]){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_height"]];result=false;
    }
    //--------------------------
    
    if([self.weightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"lb_unit"]])
    {
        if([self.weightTextField.text integerValue]>300||[self.weightTextField.text integerValue]<10){
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_weight"]];result=false;
        }
    }
    else{
        if([self.weightTextField.text floatValue]>136.1||[self.weightTextField.text floatValue]<22){
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_weight"]];result=false;
        }
        
    }
    //----
    
    if([self.circumferencedisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"cm_unit"]])
    {
        if([self.circumferenceTextField.text integerValue]>127||[self.circumferenceTextField.text integerValue]<51){
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_circumference"]];result=false;
        }
    }
    else{
        if([self.circumferenceTextField.text floatValue]>50||[self.circumferenceTextField.text floatValue]<20){
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_circumference"]];result=false;
        }
        
    }
    //-------
    
    if([self.heightdisplayValueLabel.text isEqualToString:[Utility getStringByKey:@"cm_unit"]])
    {
        if([self.heightTextField.text integerValue]>260||[self.heightTextField.text integerValue]<60){
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_height"]];result=false;
        }
    }
    else{
        if([self.feet_textFile.text floatValue]>8||[self.heightTextField.text floatValue]<2||([self.feet_textFile.text floatValue]==8&&[self.inch_textFile.text floatValue]==8)){
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[Utility getStringByKey:@"info_error_height"]];result=false;
        }
        
    }
    
    
    return result;
}


@end
