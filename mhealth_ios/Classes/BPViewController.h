//
//  BPViewController.h
//  mHealth
//
//  Created by gz dev team on 14年1月9日.
//
//

#import <UIKit/UIKit.h>

#import "HomeViewController.h"
#import "BPMeasureViewController.h"
#import "MeasureTitleCustomCell.h"
#import "BPHistoryViewController.h"
#import "BaseViewController.h"

@interface BPViewController : BaseViewController

@property(nonatomic, retain) IBOutlet UILabel *measureUILabel;
@property(nonatomic, retain) IBOutlet UILabel *historyUILabel;
@property(nonatomic, retain) IBOutlet UILabel *bloodpressureUILabel;

@end