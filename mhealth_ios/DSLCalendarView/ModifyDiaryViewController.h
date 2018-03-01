//
//  ModifyDiaryViewController.h
//  mHealth
//
//  Created by gz dev team on 14年3月27日.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Reachability.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface ModifyDiaryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray *array;
   IBOutlet UILabel *_hendLabel;
    UIView * backgoundView;
    UIView * datePickerView;
    UIView * dateDateCHickView;
    NSString * tempSUMTime;
    int theTImeQuent;
    int i;
    UIView *_theView;
    Reachability *rea;
    IBOutlet UILabel * healrhReachTextFont;
    UILabel * thebackTitlelabel;
    IBOutlet UIButton * doneBUTTON;
    IBOutlet UIButton * deleteBUTTON;
    NSString *theTaken;
    NSString*strTempTemp;
    
    
    UILabel *labelText_NOte;

    IBOutlet UILabel * frequencyTextFont;
    IBOutlet UILabel * perDayTextFont;
    IBOutlet UILabel * time1LabelTextFont;
    IBOutlet UILabel * time2LabelTextFont;
    IBOutlet UILabel * time3LabelTextFont;
    IBOutlet UILabel * time4LabelTextFont;
    IBOutlet UILabel * time5LabelTextFont;
    IBOutlet UILabel * time6LabelTextFont;
    
    IBOutlet UILabel * dosAgeTextFont;
    IBOutlet UILabel * beforeMealTextFont;
    IBOutlet UILabel * afterMealTextFont;
    IBOutlet UILabel * naTextFont;
    IBOutlet UILabel * frequencyTextFontText;
    IBOutlet UILabel * perDayTextFontText;
    IBOutlet UILabel * time111LabelTextFont;
    IBOutlet UILabel * time222LabelTextFont;
    IBOutlet UILabel * time333LabelTextFont;
    IBOutlet UILabel * time444LabelTextFont;
    IBOutlet UILabel * time555LabelTextFont;
    IBOutlet UILabel * time666LabelTextFont;
    IBOutlet UIButton * deleteMedicineTextFont;
    
    IBOutlet UILabel * titleOthersTextFont;
    IBOutlet UILabel * dateOthersTextFont;
    IBOutlet UILabel * startOthersTextFont;
    IBOutlet UILabel * endOthersTextFont;
    IBOutlet UILabel * noteOthersTextFont;
    
    
    
    IBOutlet UILabel * frequencyTextFont1111;
    IBOutlet UILabel * perDayTextFont1111;
    IBOutlet UILabel * time1LabelTextFont1111;
    IBOutlet UILabel * time2LabelTextFont2222;
    IBOutlet UILabel * time3LabelTextFont3333;
    IBOutlet UILabel * time4LabelTextFont4444;
    IBOutlet UILabel * time5LabelTextFont5555;
    IBOutlet UILabel * time6LabelTextFont6666;

    IBOutlet  UIImageView * _timechickImabe1;
    IBOutlet UIButton * _timechickButtonWhite1;
    IBOutlet  UIImageView * _timechickImabe11;
    IBOutlet UIButton * _timechickButtonWhite11;
    IBOutlet  UIImageView * _timechickImabe111;
    IBOutlet UIButton * _timechickButtonWhite111;
    
#pragma mark---第一个图
    IBOutlet UIView *_viewMeasurement;
    
   
    IBOutlet UIView *_littleMeasurementView;
    IBOutlet UILabel*clickLabel;
    IBOutlet UILabel*bPECGBG;
    IBOutlet UIImageView*bPECGBGImageView;
    IBOutlet UILabel*_timeLabel1;
    IBOutlet UILabel*_timeLabel2;
    IBOutlet UILabel*_timeLabel3;
    IBOutlet UILabel*_timeLabel4;
    IBOutlet UILabel*_timeLabel5;
    IBOutlet UILabel*_timeLabel6;
    
    IBOutlet UIView *timeView1;
    IBOutlet UIView *timeView2;
    IBOutlet UIView *timeView3;
    IBOutlet UIView *timeView4;
    IBOutlet UIView *timeView5;
    IBOutlet UIView *timeView6;
    IBOutlet UITableView *_timeTableView;
    NSString *tempSum_Url;
    
    
#pragma mark---第二个图
    IBOutlet UIScrollView*_backguandView;
    IBOutlet UIView *_viewMeation;
   
    IBOutlet UIView *medicationSecondView;
    IBOutlet UIView *photoView;
    IBOutlet UIImageView * photoImageVIew;
    
    UIImagePickerController* imagePickerController;
    
     NSString *imageBase64Str;
    
    IBOutlet  UIView * ___scrlowLAbel;
    IBOutlet UITextField*_dostextView;
    IBOutlet UITextField*_agetextView;
    IBOutlet UILabel * _timeClickLabel2;
    
    IBOutlet UILabel *medicine;
    IBOutlet UITableView*_secondTable;
    IBOutlet UIImageView *_imageViewTriangle;
    IBOutlet UIView *timeView111;
    IBOutlet UIView *timeView222;
    IBOutlet UIView *timeView333;
    IBOutlet UIView *timeView444;
    IBOutlet UIView *timeView555;
    IBOutlet UIView *timeView666;
    
    IBOutlet UILabel *timeLabel111;
    IBOutlet UILabel *timeLabel222;
    IBOutlet UILabel *timeLabel333;
    IBOutlet UILabel *timeLabel444;
    IBOutlet UILabel *timeLabel555;
    IBOutlet UILabel *timeLabel666;
    IBOutlet UIButton *medicinePictureChickButton;
    IBOutlet UILabel *medicinePictureTextFont;
    
    UIButton *_numberButton;
    NSMutableArray *timesArray;
    
    UIImage * ridaoOff;
    UIImage * ridaoOn;
    IBOutlet UIImageView * beforeMealButton;
    IBOutlet  UIImageView * afterMealButton;
    IBOutlet  UIImageView * naButton;
    IBOutlet  UILabel * _numberLabel;
    UIView*photoChickViewBlackGuandView;
#pragma mark---第三个图
  
     IBOutlet UIScrollView *__scrollView;
    IBOutlet UIView *_viewOther;
    IBOutlet UITextField*_textViewTitle;
    IBOutlet UILabel *_dateLabel;
    IBOutlet UITextView*_textViewNote;
    IBOutlet UILabel *_labelStar;
    IBOutlet UILabel *_labelEnd;
    
#pragma mark -- 第四个图
    IBOutlet UITableView *walkTableChilk;
    IBOutlet UIView * _viewWalking;
    IBOutlet UILabel*clickLabel1111;
    IBOutlet UILabel*_timeLabel1111;
    IBOutlet UILabel*_timeLabel2222;
    IBOutlet UILabel*_timeLabel3333;
    IBOutlet UILabel*_timeLabel4444;
    IBOutlet UILabel*_timeLabel5555;
    IBOutlet UILabel*_timeLabel6666;
    
    IBOutlet UIView *timeView1111;
    IBOutlet UIView *timeView2222;
    IBOutlet UIView *timeView3333;
    IBOutlet UIView *timeView4444;
    IBOutlet UIView *timeView5555;
    IBOutlet UIView *timeView6666;

    
}
@property (nonatomic,assign)int intemp;
@property (nonatomic,strong)NSString*hendStr;
@property (nonatomic,strong)NSString*sevenDateStr;
@property (nonatomic,strong)NSString*dataStr;
@property (nonatomic,strong)NSMutableArray*_turnArray;
@property (nonatomic,strong)NSMutableArray*_allArray;
//Measurement :
@property (nonatomic,assign)NSInteger medWitchID;
@property (nonatomic,strong)NSString *bpBgECG;
@property (nonatomic,strong)NSString *bECPText;
@property (nonatomic,strong)NSMutableArray *timeBEBTIme;

@property (nonatomic,strong)NSString * turntitleMedicationText;
@property (nonatomic,strong)NSString * turntimesMedicationText;
@property (nonatomic,strong)NSString * turnmedIDText;
@property (nonatomic,strong)NSString * turndosageMedicationText;
@property (nonatomic,strong)NSString * turnMealMedicationText;

@property (nonatomic,strong)NSMutableArray * turntitleMedicationArray;
@property (nonatomic,strong)NSMutableArray * turntimesMedicationArray;
@property (nonatomic,strong)NSMutableArray * turnmedID;
@property (nonatomic,strong)NSMutableArray * turndosageMedicationArray;
@property (nonatomic,strong)NSMutableArray * turnMealMedicationArray;
@property (nonatomic,strong)UIImage *       medicationImage;
@property (nonatomic,strong)NSMutableArray * turnNoteMedicationArray;
@property (nonatomic,strong)NSString * turnNoteMedicationText;



// Other :
@property (nonatomic,strong)NSString * turnOtherTitle;
@property (nonatomic,strong)NSString * turnOtherNote;
@property (nonatomic,strong)NSString * turnOtherStartTime;
@property (nonatomic,strong)NSString * turnOtherEndTime;
@property (nonatomic,strong)NSString * turnOtherID;
@property (nonatomic,strong)NSString * turnOtherDateDate;

@property (nonatomic,strong)NSMutableArray * turnWalkingArray;


-(IBAction)Back:(id)sender;
-(IBAction)GOHOME:(id)sender;
#pragma mark---第一个图
-(IBAction)chilkTimeButton:(id)sender;
-(IBAction)timeButton1:(id)sender;
-(IBAction)timeButton2:(id)sender;
-(IBAction)timeButton3:(id)sender;
-(IBAction)timeButton4:(id)sender;
-(IBAction)timeButton5:(id)sender;
-(IBAction)timeButton6:(id)sender;


#pragma mark---第二个图

-(IBAction)before:(id)sender;
-(IBAction)after:(id)sender;
-(IBAction)na:(id)sender;
@property(nonatomic,strong) NSString *imageStr;
@property (nonatomic,strong)NSMutableArray * turnImageStrMedicationArray;
@property(nonatomic,strong) UITextView *medication_Note_TextView;

-(IBAction)medicinePhotoClick:(id)sender;
-(IBAction)deletePhoto:(id)sender;

@property (nonatomic,strong)NSString *banMEAL;




-(IBAction)timeClick:(id)sender;

-(IBAction)timeBUtton111:(id)sender;
-(IBAction)timeBUtton222:(id)sender;
-(IBAction)timeBUtton333:(id)sender;
-(IBAction)timeBUtton444:(id)sender;
-(IBAction)timeBUtton555:(id)sender;
-(IBAction)timeBUtton666:(id)sender;
-(IBAction)DeleteMadicn:(id)sender;
#pragma mark---第三个图
-(IBAction)timeButtonStart:(id)sender;
-(IBAction)timeButtonEnd:(id)sende;



#pragma mark---第four个图

-(IBAction)timeClick1111:(id)sender;
-(IBAction)timeBUtton1111:(id)sender;
-(IBAction)timeBUtton2222:(id)sender;
-(IBAction)timeBUtton3333:(id)sender;
-(IBAction)timeBUtton4444:(id)sender;
-(IBAction)timeBUtton5555:(id)sender;
-(IBAction)timeBUtton6666:(id)sender;


-(IBAction)Done:(id)sender;
-(IBAction)Deletes:(id)sender;
-(IBAction)chickDataDateINOthers:(id)sender;
@end
