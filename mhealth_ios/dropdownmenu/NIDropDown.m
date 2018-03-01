//
//  NIDropDown.m
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"

@interface NIDropDown (){
    
    CGFloat theWidth;
    CGFloat theHeight;

}
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UILabel *theLabel;
@property(nonatomic, retain) NSArray *list;
@end

@implementation NIDropDown
@synthesize table;
@synthesize theLabel;
@synthesize list;
@synthesize delegate;


- (id) init{
	if(!(self = [super initWithFrame:CGRectMake(0, 0, 100, 100)])) return nil;
	
	return self;
	
}

- (id)showDropDown:(UILabel *)lable width:(CGFloat)thewidth height:(CGFloat)height data:(NSArray *)arr {

    
    theLabel = lable;
    //self = [self init];
    if (self) {
        // Initialization code
        CGRect btn = theLabel.frame;
        
        theWidth=thewidth;
        theHeight=height;
        
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height+2, thewidth, 0);
        self.list = [NSArray arrayWithArray:arr];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, thewidth, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height+2, thewidth, height);
        table.frame = CGRectMake(0, 0, thewidth, height);
        [UIView commitAnimations];
        
        [theLabel.superview addSubview:self];
        [self addSubview:table];
    }
    return self;
}

-(void)hideDropDown{
    CGRect btn = theLabel.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, theWidth, 0);
    table.frame = CGRectMake(0, 0, theWidth, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}   


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text =[list objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor=[UIColor grayColor];;
    
//    UIView * v = [[UIView alloc] init];
//    v.backgroundColor = [UIColor grayColor];
//    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown];
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    
    theLabel.text=c.textLabel.text;
    
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate niDropDownDelegateMethod:self];   
}

-(void)dealloc {
//    [super dealloc];
//    [table release];
//    [self release];
}

@end
