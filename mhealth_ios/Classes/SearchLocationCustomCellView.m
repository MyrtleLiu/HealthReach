//
//  SearchLocationCustomCellView.m
//  mHealth
//
//  Created by evan_li on 10/21/14.
//
//

#import "SearchLocationCustomCellView.h"

@interface SearchLocationCustomCellView ()

@end

@implementation SearchLocationCustomCellView

@synthesize contentLabel;
@synthesize contentString;
@synthesize referenceString;

- (void)setContentString:(NSString *)contentString_new
{
    if (![contentLabel.text isEqualToString:contentString_new]) {
        contentString = contentString_new;
        [self.contentLabel setText:contentString];
    }
}

- (NSString *)getContentString
{
    return contentString;
}

- (void)setReferenceString:(NSString *)referenceString_new
{
    referenceString = referenceString_new;
}

@end
