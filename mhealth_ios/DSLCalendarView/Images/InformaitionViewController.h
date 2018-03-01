//
//  InformaitionViewController.h
//  mHealth
//
//  Created by gz dev team on 14年3月25日.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface InformaitionViewController : BaseViewController
{
    IBOutlet UILabel*_label1;
    IBOutlet UILabel*_label2;
    IBOutlet UIView *aView;
    UILabel*_label3;
    UILabel*_label4;
    IBOutlet UILabel *hendLabelFont;
    IBOutlet UIButton *btn_edit;
}
@property(nonatomic,strong) NSMutableArray *medientID;
@property(nonatomic,strong) NSString *otherID;

@property(nonatomic,strong) NSString *str1;
@property(nonatomic,strong) NSString *str2;
@property(nonatomic,strong) NSString *str3;
@property(nonatomic,strong) NSString *str4;
@property(nonatomic,strong) NSString *imageStr;
@property(nonatomic,strong) NSString *strNote;


@property(nonatomic,strong) NSMutableArray *_turnArray;

@property(nonatomic,strong)NSMutableArray * docAgeArray;


@property(nonatomic,strong)NSString *dateDateStr;
@property(nonatomic,assign) int intemp;
@property(nonatomic,strong) NSMutableArray *_array;
@property(nonatomic,strong) NSMutableArray * _allArray;

@property(nonatomic,strong) NSString *_timeStart;
@property(nonatomic,strong) NSString *_timeEnd;

@property (nonatomic,strong)NSMutableArray * turntitleMedicationArray;
@property (nonatomic,strong)NSMutableArray * turntimesMedicationArray;
@property (nonatomic,strong)NSMutableArray * turnmedID;
@property (nonatomic,strong)NSMutableArray * turndosageMedicationArray;
@property (nonatomic,strong)NSMutableArray * turnMealMedicationArray;
@property (nonatomic,strong)NSMutableArray * turnImageStrMedicationArray;
@property (nonatomic,strong)NSMutableArray * turnNoteMedicationArray;

@property (nonatomic,strong)NSMutableArray * turnWalkingArray;

@property (nonatomic,assign)NSInteger medWitchID;


-(IBAction)Back:(id)sender;
-(IBAction)GoHome:(id)sender;
-(IBAction)addReminder:(id)sender;
@end
