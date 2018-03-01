//
//  ChooseHistoryController.h
//  mHealth WatchKit Extension
//
//  Created by smartone_sn on 15/7/23.
//
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface ChooseHistoryController : WKInterfaceController


@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bpUpdateLabel;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *bgUpdateLabel;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *weightUpdateLabel;
@property(nonatomic, retain) IBOutlet WKInterfaceLabel *calsUpdateLabel;

@end
