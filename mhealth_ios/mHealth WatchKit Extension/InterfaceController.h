//
//  InterfaceController.h
//  mHealth WatchKit Extension
//
//  Created by smartone_sn on 15/7/23.
//
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController


@property(nonatomic, retain) IBOutlet WKInterfaceGroup *loginView;

@property(nonatomic, retain) IBOutlet WKInterfaceGroup *groupView1;
@property(nonatomic, retain) IBOutlet WKInterfaceGroup *groupView2;

@end
