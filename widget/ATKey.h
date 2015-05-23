//
//  ATKey.h
//  Net Center
//
//  Created by Akhil Tolani on 22/12/14.
//  Copyright (c) 2014 Akhil Tolani. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kKeyShadowYOffset = 1.0;
static CGFloat kKeyPhoneTitleFontSize = 16.0;
static CGFloat kKeyLabelOffsetY = -1.5;
static CGFloat kKeyImageOffsetY = -0.5;

@interface ATKey : UIControl
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)keyWithImage:(UIImage*)image;
+ (instancetype)keyWithTitle:(NSString*)title;
@end
