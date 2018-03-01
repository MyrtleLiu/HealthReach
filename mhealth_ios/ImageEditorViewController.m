//
//  ViewController.m
//  QuickContacts
//
//  Created by  on 11-12-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageEditorViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"

@interface ImageEditorViewController () {
    float cropWidth, cropHeight;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImage *originalImage;

@end


@implementation ImageEditorViewController

- (void)dealloc
{
    
    self.scrollView = nil;
    self.originalImage = nil;
    self.imageView = nil;
    self.completionHandler = nil;

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden=YES;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (id)initWithOriginalImage:(UIImage *)image cropWidth:(float)width cropHeight:(float)height
{
    self = [super init];
    if (self) {
        self.originalImage = image;
        cropWidth = width;
        cropHeight = height;
        
//        self.automaticallyAdjustsScrollViewInsets = NO;
//        
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        
//        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initBar];
    [self initScrollView];
    [self initMaskView];
    
    [self initImageView];
}

- (void)initBar
{
    
    self.navigationController.navigationBarHidden=NO;
    
    self.navigationItem.title = [Utility getStringByKey:@"Edit"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:[Utility getStringByKey:@"done"] style:UIBarButtonItemStyleDone target:self action:@selector(cropImage)];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:[Utility getStringByKey:@"Cancel"] style:UIBarButtonItemStyleDone target:self action:@selector(cancelEdit)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)initScrollView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    UIEdgeInsets edgeInsets;
    edgeInsets.top = (self.scrollView.frame.size.height - cropHeight) / 2-48;
    edgeInsets.left = (self.scrollView.frame.size.width - cropWidth) / 2;
    edgeInsets.right = edgeInsets.left;
    edgeInsets.bottom = edgeInsets.top+50;
    self.scrollView.contentInset = edgeInsets;
	self.scrollView.scrollIndicatorInsets = edgeInsets;
    
    float maxZoomScale = self.originalImage.size.width / cropWidth;
    if (maxZoomScale < 3) {
        maxZoomScale = 3;
    }
    [self.scrollView setMaximumZoomScale:maxZoomScale];
    [self.scrollView setMinimumZoomScale:1];
    [self.scrollView setZoomScale:maxZoomScale];
    [self.scrollView setZoomScale:1];
    
    [self.view addSubview:self.scrollView];
}

- (void)initMaskView
{
    CGRect maskViewFrame = CGRectMake(0, 0, self.scrollView.frame.size.width, (self.scrollView.frame.size.height - cropHeight) / 2);
    UIView *maskView = [[UIView alloc] initWithFrame:maskViewFrame];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    maskView.userInteractionEnabled = NO;
    [self.view addSubview:maskView];
    
    maskViewFrame = CGRectMake(0, maskViewFrame.origin.y + maskViewFrame.size.height, (self.scrollView.frame.size.width - cropWidth) / 2, cropHeight);
    maskView = [[UIView alloc] initWithFrame:maskViewFrame];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    maskView.userInteractionEnabled = NO;
    [self.view addSubview:maskView];
    
    maskViewFrame = CGRectMake(maskViewFrame.origin.x + maskViewFrame.size.width, maskViewFrame.origin.y, cropWidth, cropHeight);
    maskView = [[UIView alloc] initWithFrame:maskViewFrame];
    maskView.backgroundColor = [UIColor clearColor];
    maskView.layer.borderColor = [UIColor grayColor].CGColor;
    maskView.layer.borderWidth = 1;
    maskView.userInteractionEnabled = NO;
    [self.view addSubview:maskView];
    
    maskViewFrame = CGRectMake(maskViewFrame.origin.x + maskViewFrame.size.width, maskViewFrame.origin.y, (self.scrollView.frame.size.width - cropWidth) / 2, cropHeight);
    maskView = [[UIView alloc] initWithFrame:maskViewFrame];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    maskView.userInteractionEnabled = NO;
    [self.view addSubview:maskView];
    
    maskViewFrame = CGRectMake(0, maskViewFrame.origin.y + maskViewFrame.size.height, self.scrollView.frame.size.width, (self.scrollView.frame.size.height - cropHeight) / 2);
    maskView = [[UIView alloc] initWithFrame:maskViewFrame];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    maskView.userInteractionEnabled = NO;
    [self.view addSubview:maskView];
}

- (void)initImageView
{
    if (nil == self.originalImage) return;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    float width = self.originalImage.size.width;
    float height = self.originalImage.size.height;
    CGSize size;
    if (width / height > cropWidth / cropHeight) {
        size.height = cropHeight;
        size.width = width / height * size.height;
    } else {
        size.width = cropWidth;
        size.height = height / width * size.width;
    }
    
    self.scrollView.contentSize = size;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.imageView.image = self.originalImage;
    
    [self.scrollView scrollRectToVisible:CGRectMake((self.imageView.frame.size.width - cropWidth) / 2, (self.imageView.frame.size.height - cropHeight) / 2, cropWidth, cropHeight) animated:NO];
    
    [self.scrollView addSubview:self.imageView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.imageView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)cancelEdit
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)cropImage
{
    CGRect rect;
    rect.origin.x = self.scrollView.contentInset.left + self.scrollView.contentOffset.x;
    rect.origin.y = self.scrollView.contentInset.top + self.scrollView.contentOffset.y;
    rect.size = CGSizeMake(cropWidth, cropHeight);
    float scale = self.originalImage.size.width / self.scrollView.contentSize.width;
    rect.origin.x = rect.origin.x * scale;
    rect.origin.y = rect.origin.y * scale;
    rect.size.width = rect.size.width * scale;
    rect.size.height = rect.size.height * scale;
    
    UIImage *sourceImage = [self rotateImage:self.originalImage orientation:self.originalImage.imageOrientation];
    CGImageRef imageRef = CGImageCreateWithImageInRect(sourceImage.CGImage, rect);
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    self.completionHandler(cropImage);
}

- (UIImage *)rotateImage:(UIImage *)aImage orientation:(UIImageOrientation)orient
{
    CGImageRef imgRef = aImage.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGFloat scaleRatio = 1;
    
    CGFloat boundHeight;
    
    switch (orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            
            transform = CGAffineTransformIdentity;
            
            break;
            
            
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            break;
            
            
            
        case UIImageOrientationDown: //EXIF = 3
            
            transform = CGAffineTransformMakeTranslation(width, height);
            
            transform = CGAffineTransformRotate(transform, M_PI);
            
            break;
            
            
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            
            transform = CGAffineTransformMakeTranslation(0.0, height);
            
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            
            break;
            
            
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, width);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI /2.0);
            
            break;
            
            
            
        case UIImageOrientationLeft: //EXIF = 6
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(0.0, width);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI /2.0);
            
            break;
            
            
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
            
            
        case UIImageOrientationRight: //EXIF = 8
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
    }
    
    
    
    UIGraphicsBeginImageContext(bounds.size);
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        
        CGContextTranslateCTM(context, -height, 0);
        
    }
    
    else {
        
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        
        CGContextTranslateCTM(context, 0, -height);
        
    }
    
    
    
    CGContextConcatCTM(context, transform);
    
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return imageCopy;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
