#import "UIViewController+LegacyRotation.h"

@implementation UIViewController(LegacyRotation)

-(NSUInteger)supportedInterfaceOrientations
{


    return UIInterfaceOrientationLandscapeLeft;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

@end
