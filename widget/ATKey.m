//
//  ATKey.m
//  Net Center
//
//  Created by Akhil Tolani on 22/12/14.
//  Copyright (c) 2014 Akhil Tolani. All rights reserved.
//

#import "ATKey.h"

@interface ATKey ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *shadowColor;
@end

@implementation ATKey
+ (instancetype)keyWithImage:(UIImage*)image {
    ATKey *key = [[self alloc] init];
    key.image = image;
    key.title = @"";
    [key updateState];
    return key;
}
+ (instancetype)keyWithTitle:(NSString*)title {
    ATKey *key = [[self alloc] init];
    key.title = title;
    [key updateState];
    return key;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateState];
}
- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateState];
}
- (void)updateState {
    self.label.textColor = [UIColor whiteColor];
    _imageView.image = [_imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _imageView.tintColor = [UIColor whiteColor];
    switch (self.state) {
        case UIControlStateHighlighted:
            self.color = [UIColor colorWithWhite:90/255.0 alpha:1.0];
            self.shadowColor = [UIColor clearColor];
            break;
            
        case UIControlStateNormal:
        default:
            if([self.title isEqualToString:@"Post"]) {
                self.color = [UIColor colorWithRed:41.0/255.0 green:128.0/255.0 blue:185.0/255.0 alpha:0.5];
            } else if ([self.title isEqualToString:@"Cancel"]) {
                self.color = [UIColor colorWithRed:192.0/255.0 green:57.0/255.0 blue:43.0/255.0 alpha:0.5];
            } else {
                self.color = [UIColor colorWithWhite:0 alpha:0.2];
            }
            self.shadowColor = [UIColor clearColor];
            break;
    }
    [self setNeedsDisplay];
}


- (UILabel*)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont fontWithName:@"Avenir" size:16];
        _label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:_label];
    }
    return _label;
}
- (UIImageView*)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imageView];
    }
    return _imageView;
}
- (void)setTitle:(NSString *)title {
    self.label.text = title;
    [self updateState];
}
- (NSString*)title {
    return self.label.text;
}
- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self updateState];
}
- (UIImage*)image {
    return self.imageView.image;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self updateState];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self updateState];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self updateState];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self updateState];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self drawKeyRect:rect
                color:self.color
           withShadow:self.shadowColor];
    
}
- (void)drawKeyRect:(CGRect)rect color:(UIColor*)color {
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4];
    [color setFill];
    [roundedRectanglePath fill];
}
- (void)drawKeyRect:(CGRect)rect color:(UIColor*)color withShadow:(UIColor*)shadowColor {
    CGRect keyRect = CGRectOffset(CGRectInset(rect, 0, kKeyShadowYOffset/2), 0, -kKeyShadowYOffset/2);
    if([self.title isEqualToString:@"Post"] || [self.title isEqualToString:@"Cancel"] || [self.title isEqualToString:@"space"] || [self.title isEqualToString:@"123"] || [self.title isEqualToString:@""]) {
        UIBezierPath* keyPath = [UIBezierPath bezierPathWithRoundedRect:keyRect cornerRadius:4];
        [color setFill];
        [keyPath fill];
    } else {
        UIBezierPath* keyPath = [UIBezierPath bezierPathWithRoundedRect:keyRect cornerRadius:0];
        [color setFill];
        [keyPath fill];
    }
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
    return UILayoutFittingExpandedSize;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectOffset(self.bounds, 0, kKeyLabelOffsetY);
    self.imageView.frame = CGRectOffset(self.bounds, 0, kKeyImageOffsetY);
    [self setNeedsDisplay];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(MAX(self.intrinsicContentSize.width, size.width), MAX(self.intrinsicContentSize.height, size.height));
}
- (CGSize)intrinsicContentSize {
    return CGSizeMake(20.0, 20.0);
}
@end
