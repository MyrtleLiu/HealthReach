//
//  MenuViewController.h
//  mHealth
//
//  Created by smartone_sn on 14-2-20.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MenuViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>{
    
    UITableView *menuTableView; 
}

@property (strong, nonatomic) IBOutlet UITableView *menuTableView;

@end
