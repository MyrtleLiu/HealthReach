//
//  BaseNavigationController.m
//  mHealth
//
//  Created by smartone_sn on 14-2-18.
//
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

@synthesize transitioning = _transitioning;
@synthesize stack = _stack;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.delegate = self;
    self.stack = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            void (^codeBlock)(void) = [^{
                [super popViewControllerAnimated:animated];
            } copy];
            [self.stack addObject:codeBlock];
            
            // We cannot show what viewcontroller is currently animated now
            return nil;
        } else {
            return [super popViewControllerAnimated:animated];
        }
    }
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            void (^codeBlock)(void) = [^{
                [super popToRootViewControllerAnimated:animated];
            } copy];
            [self.stack addObject:codeBlock];
            
            // We cannot show what viewcontroller is currently animated now
            return nil;
        } else {
            return [super popToRootViewControllerAnimated:animated];
        }
    }
}

- (NSArray*) popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            void (^codeBlock)(void) = [^{
                [super popToViewController:viewController animated:animated];
            } copy];
            [self.stack addObject:codeBlock];
            
            // We cannot show what viewcontroller is currently animated now
            return nil;
        } else {
            return [super popToViewController:viewController animated:animated];
        }
    }
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            // Copy block so its no longer on the (real software) stack
            void (^codeBlock)(void) = [^{
                [super setViewControllers:viewControllers animated:animated];
            } copy];
            
            // Add to the stack list and then release
            [self.stack addObject:codeBlock];
        } else {
            [super setViewControllers:viewControllers animated:animated];
        }
    }
}

- (void) pushCodeBlock:(void (^)())codeBlock{
    @synchronized(self.stack) {
        [self.stack addObject:[codeBlock copy]];
        
        if (!self.transitioning)
            [self runNextBlock];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    @synchronized(self.stack) {
        if (self.transitioning) {
            void (^codeBlock)(void) = [^{
                [super pushViewController:viewController animated:animated];
            } copy];
            [self.stack addObject:codeBlock];
        } else {
            [super pushViewController:viewController animated:animated];
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    @synchronized (self.stack) {
        self.transitioning = true;
        id <UIViewControllerTransitionCoordinator> transitionCoordinator = navigationController.topViewController.transitionCoordinator;
        [transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id <UIViewControllerTransitionCoordinatorContext> context) {
            if ([context isCancelled]) {
                @synchronized (self.stack) {
                    self.transitioning = false;
                }
            }
        }];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    @synchronized(self.stack) {
        self.transitioning = false;
        
        [self runNextBlock];
    }
}

- (void) runNextBlock {
    if (self.stack.count == 0)
        return;
    
    void (^codeBlock)(void) = [self.stack objectAtIndex:0];
    
    // Execute block, then remove it from the stack (which will dealloc)
    codeBlock();
    
    [self.stack removeObjectAtIndex:0];
}

@end
