//
//  AddReminderViewController.h
//  mHealth
//
//  Created by gz dev team on 14年3月18日.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Reachability.h"
#import "MR_ListViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface AddReminderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    Reachability*rea;//网络判断
    int theTImeQuent;
    MR_ListViewController *mR_List;
    UILabel * thebackTitlelabel;
    NSString *theTaken;
    NSMutableArray * _array;
    NSMutableArray * _array2;
    UITableView * _tableView;
    NSMutableArray * allArrayDairy;
    NSString*tempsum1;
    NSString*tempsum2;
    NSString *tempsum3;
    NSString *tempsum4;
    NSString *tempSum_Url;
       UIView *_theView;
    IBOutlet UIView *chickView;
    IBOutlet UILabel *_clickLabel;
    IBOutlet UIView *_measurementView;
    IBOutlet UITableView * _tableView2;
    IBOutlet UILabel *numberLabel;
    
    IBOutlet UILabel *hendTextFont;
    IBOutlet UILabel *addHendTextFont;
    IBOutlet UILabel * _dateLabel;
    IBOutlet UILabel * TypeTextFont;
    IBOutlet UILabel * bpTextFont;
    IBOutlet UILabel * ecgTextFont;
    IBOutlet UILabel * bgTextFont;
    IBOutlet UILabel * frequencyTextFont;
    IBOutlet UILabel * perDayTextFont;
    IBOutlet UILabel * time1TextFont;
    IBOutlet UILabel * time2TextFont;
    IBOutlet UILabel * time3TextFont;
    IBOutlet UILabel * time5TextFont;
    IBOutlet UILabel * time4TextFont;
    IBOutlet UILabel * time6TextFont;
    UIView *photoChickViewBlackGuandView;
    IBOutlet UIButton *medicinePictureChickButton;
    IBOutlet UILabel *medicinePictureTextFont;
    UIImagePickerController* imagePickerController;
    NSString *imageBase64Str;
    
    
    
    
    
    IBOutlet UILabel *medicineTextFont;
    IBOutlet UILabel *dosageTextFont;
    IBOutlet UILabel *beforeMealTextFont;
    IBOutlet UILabel *afterMealTextFont;
    IBOutlet UILabel *nAAtextFont;
    IBOutlet UILabel *frequencyTextFontText;
    IBOutlet UILabel *perdayTextFontText;
    IBOutlet UILabel * time111TextFont;
    IBOutlet UILabel * time222TextFont;
    IBOutlet UILabel * time333TextFont;
    IBOutlet UILabel * time555TextFont;
    IBOutlet UILabel * time444TextFont;
    IBOutlet UILabel * time666TextFont;
    
    IBOutlet UILabel *titleOtherTextFont;
    IBOutlet UILabel *dataOtherTextFont;
    IBOutlet UILabel *startOtherTextFont;
    IBOutlet UILabel *endOtherTextFont;
    IBOutlet UILabel *noteOtherTextFont;
    
    
    NSURL* imageurlSucc ;
    IBOutlet UIButton *doneButtonFontText;
    IBOutlet UIButton *celeleButtonTextFont;
    
    
    
    
    IBOutlet UILabel *frequencyTextFontText1111;
    IBOutlet UILabel *perdayTextFontText1111;
    IBOutlet UILabel * time1111TextFont;
    IBOutlet UILabel * time2222TextFont;
    IBOutlet UILabel * time3333TextFont;
    IBOutlet UILabel * time5555TextFont;
    IBOutlet UILabel * time4444TextFont;
    IBOutlet UILabel * time6666TextFont;
    
    
    
    
    IBOutlet UIButton *_buttonBP;
    IBOutlet UIButton *_buttonECG;
    IBOutlet UIButton *_buttonBG;
    UIImage*_imageBPOn;
    UIImage*_imageBPOff;
    UIImage*_imageECGOn;
    UIImage*_imageECGOff;
    UIImage*_imageBGOn;
    UIImage*_imageBGOff;
    
    
    
#pragma mark -- Time1～Time6 的View
    IBOutlet UIImageView * imageimageBack;
    IBOutlet UIView *_time1;
    IBOutlet UIView *_time2;
    IBOutlet UIView *_time3;
    IBOutlet UIView *_time4;
    IBOutlet UIView *_time5;
    IBOutlet UIView *_time6;
    
#pragma mark -- Time1～Time6 的lebel
    IBOutlet UILabel *_timeLabel1;
    IBOutlet UILabel *_timeLabel2;
    IBOutlet UILabel *_timeLabel3;
    IBOutlet UILabel *_timeLabel4;
    IBOutlet UILabel *_timeLabel5;
    IBOutlet UILabel *_timeLabel6;
    
    
    NSString*  strTempTemp;
    
    IBOutlet UIView*medicationView;
    IBOutlet UITextField*_dostextView;
    IBOutlet UITextField*_agetextView;
    IBOutlet UILabel * _dateLabel111;
    IBOutlet UITableView*_secondTable;
    IBOutlet UIImageView *_imageViewTriangle;
    IBOutlet UILabel *_buttonOne;
    IBOutlet UIScrollView*_backguandView;
    
    IBOutlet UIView *_time111;
    IBOutlet UIView *_time222;
    IBOutlet UIView *_time333;
    IBOutlet UIView *_time444;
    IBOutlet UIView *_time555;
    IBOutlet UIView *_time666;
    
    IBOutlet UILabel *_timeLabel111;
    IBOutlet UILabel *_timeLabel222;
    IBOutlet UILabel *_timeLabel333;
    IBOutlet UILabel *_timeLabel444;
    IBOutlet UILabel *_timeLabel555;
    IBOutlet UILabel *_timeLabel666;
    
    UIImage * ridaoOff;
    UIImage * ridaoOn;
    IBOutlet UIImageView * beforeMealButton;
    IBOutlet  UIImageView * afterMealButton;
    IBOutlet  UIImageView * naButton;
    
    
    
    
    
    
    IBOutlet UIView *adHocView;
    IBOutlet UITextView *_textView;
    IBOutlet UITextField *_textField;
    IBOutlet UILabel *_labelStart;
    IBOutlet UILabel *_labelEnd;
    IBOutlet UIScrollView *__scrollView;
    
    
    
    IBOutlet UIView *walkView;
    IBOutlet UITableView * threeTable;
    IBOutlet UILabel * walkTime;
    IBOutlet UIView *_time1111;
    IBOutlet UIView *_time2222;
    IBOutlet UIView *_time3333;
    IBOutlet UIView *_time4444;
    IBOutlet UIView *_time5555;
    IBOutlet UIView *_time6666;
    
    IBOutlet UILabel *timeLabel1111;
    IBOutlet UILabel *timeLabel2222;
    IBOutlet UILabel *timeLabel3333;
    IBOutlet UILabel *timeLabel4444;
    IBOutlet UILabel *timeLabel5555;
    IBOutlet UILabel *timeLabel6666;
    
    
    
    UILabel *labelText_NOte;    
    
    
    int i;
    
    int y;
    
    int k;
    
    UIView * backgoundView;
    UIView * datePickerView;
    UIView * dateDateCHickView;
    
    
  IBOutlet  UIImageView * _timechickImabe1;
   IBOutlet UIButton * _timechickButtonWhite1;
    IBOutlet  UIImageView * _timechickImabe11;
    IBOutlet UIButton * _timechickButtonWhite11;
    IBOutlet  UIImageView * _timechickImabe111;
    IBOutlet UIButton * _timechickButtonWhite111;
    //
    
    IBOutlet UIView *medicationSecondView;
    IBOutlet UIView *photoView;
    IBOutlet UIImageView * photoImageVIew;
    UIImageView *bigImageView;
    UIView *bbbbbbbbview;
    UIImageView *smoreimageView ;
}
@property(nonatomic,strong) UITextView *medication_Note_TextView;
@property(nonatomic,strong)NSMutableArray * timeBloodMutableArray;
@property(nonatomic,strong)NSMutableArray * timeECGMutableArray;
@property(nonatomic,strong)NSMutableArray * timeGlucoseMutableArray;

@property(nonatomic,strong)NSMutableArray * idBloodMutbaleArray;
@property(nonatomic,strong)NSMutableArray * idECGMutableArray;
@property(nonatomic,strong)NSMutableArray * idGlucoseMutableArray;
@property(nonatomic,strong)NSMutableArray * idWalkingMutableArray;
@property (nonatomic,strong)NSMutableArray *timeWalkMutableArray;

@property (nonatomic,strong)NSMutableArray*_arrayInformation;
@property (nonatomic,assign) int intemp;
@property (nonatomic,strong)NSString *sevenDateStr;
@property (nonatomic,strong)NSString *dateDateStr;
@property (nonatomic,strong)NSString *typeStr;


-(IBAction)medicinePhotoClick:(id)sender;
-(IBAction)deletePhoto:(id)sender;

-(IBAction)BacktoCalendar:(id)sender;
-(IBAction)Done:(id)sender;
-(IBAction)number:(id)sender;

-(IBAction)Click:(id)sender;
-(IBAction)Delete:(id)sender;

-(IBAction)buttonBP:(id)sender;
-(IBAction)buttonECG:(id)sender;
-(IBAction)buttonBG:(id)sender;

-(IBAction)timeBUtton1:(id)sender;
-(IBAction)timeBUtton2:(id)sender;
-(IBAction)timeBUtton3:(id)sender;
-(IBAction)timeBUtton4:(id)sender;
-(IBAction)timeBUtton5:(id)sender;
-(IBAction)timeBUtton6:(id)sender;


@property(nonatomic,assign)NSInteger mediationidCOnt;

@property(nonatomic,strong)NSString *banMEAL;
-(IBAction)BeforeMeal:(id)sender;
-(IBAction)AfterMeal:(id)sender;
-(IBAction)NA:(id)sender;


-(IBAction)timeClick:(id)sender;
-(IBAction)WalkTimeClick:(id)sender;




-(IBAction)timeBUtton111:(id)sender;
-(IBAction)timeBUtton222:(id)sender;
-(IBAction)timeBUtton333:(id)sender;
-(IBAction)timeBUtton444:(id)sender;
-(IBAction)timeBUtton555:(id)sender;
-(IBAction)timeBUtton666:(id)sender;



-(IBAction)ButtonStart:(id)sender;
-(IBAction)ButtonEnd:(id)sender;
-(IBAction)chickDataDateINOthers:(id)sender;


-(IBAction)timeBUtton1111:(id)sender;
-(IBAction)timeBUtton2222:(id)sender;
-(IBAction)timeBUtton3333:(id)sender;
-(IBAction)timeBUtton4444:(id)sender;
-(IBAction)timeBUtton5555:(id)sender;
-(IBAction)timeBUtton6666:(id)sender;


@end
