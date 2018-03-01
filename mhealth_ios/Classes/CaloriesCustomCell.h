//
//  CaloriesCustomCell.h
//  mHealth
//
//  Created by evanli on 16/7/14.
//
//

#import <UIKit/UIKit.h>
#import "HJManagedImageV.h"

@interface CaloriesCustomCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet HJManagedImageV *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantityLabel1;
@property (weak, nonatomic) IBOutlet UILabel *foodQuantityLabel2;
@property (weak, nonatomic) IBOutlet UILabel *foodCaloriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodCalsUnitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *quantityBackgroundImageView;
@property (weak, nonatomic) NSNumber *foodId;


@property (copy, nonatomic) NSNumber *foodIdNumber;
@property (copy, nonatomic) NSString *foodNameString;
@property (copy, nonatomic) NSString *foodUnitString;
@property (copy, nonatomic) NSString *foodQuantityString;
@property (copy, nonatomic) NSString *foodCaloriesString;
//@property (copy, nonatomic) UIImage *foodImage;
@property (copy, nonatomic) NSString *foodImageString;


- (IBAction)quantityPlus:(id)sender;
- (IBAction)quantityMinus:(id)sender;

@end