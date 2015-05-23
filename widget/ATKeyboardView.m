#import "TodayViewController.h"
#import "ATKeyboardView.h"

@interface UIView (lulz)
- (UIViewController*)parentViewController;
@end
@implementation UIView (lulz)
- (UIViewController*)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]]) {
        responder = [responder nextResponder];
    }
    return (UIViewController*)responder;
}
@end

@implementation ATKeyboardView
#define bottomMargin    3.0

PhoneKeyboardMetrics getPhoneLinearKeyboardMetrics(CGFloat keyboardWidth, CGFloat keyboardHeight) {
    CGFloat keyHeight = 38.5;
    CGFloat letterKeyWidth = (keyboardWidth/10);
    
    CGFloat nextKeyboardButtonWidth = 34;
    CGFloat returnButtonWidth = 74;
    CGFloat deleteButtonWidth = 36;
    
    PhoneKeyboardMetrics metrics = {
        
        .nextKeyboardButtonFrame = {
            0,
            keyboardHeight - bottomMargin - keyHeight + 2,
            nextKeyboardButtonWidth,
            keyHeight
        },
        
        .returnButtonFrame = {
            keyboardWidth - returnButtonWidth,
            keyboardHeight - bottomMargin - keyHeight + 2,
            returnButtonWidth,
            keyHeight
        },
        
        .spaceButtonFrame = {
            nextKeyboardButtonWidth + 4,
            keyboardHeight - bottomMargin - keyHeight + 2,
            keyboardWidth - (nextKeyboardButtonWidth + returnButtonWidth) - 8,
            keyHeight
        },
        
        .deleteButtonFrame = {
            keyboardWidth - deleteButtonWidth,
            keyboardHeight - (bottomMargin + keyHeight + keyHeight),
            deleteButtonWidth,
            keyHeight
        },
        
        .leftShiftButtonFrame = {
            0,
            keyboardHeight - (bottomMargin + keyHeight + keyHeight),
            deleteButtonWidth,
            keyHeight
        },
        
        .keySize = {
            letterKeyWidth,
            keyHeight
        },
        .RowAndColumnMargins = {
            1,
            0
        },
        .cornerRadius = 5.0,
        
    };
    return metrics;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        currentStyle = 1;
        [UIView animateWithDuration:0 animations:^{
            [self layoutViewForSize:CGSizeMake(self.bounds.size.width, 159) style:currentStyle]; /*animating somehow reduces some jerkiness*/
        } completion:nil];
    }
    return self;
}
- (void)layoutViewForSize:(CGSize)size style:(int)style {
    currentStyle = style;

    for(ATKey *key in self.subviews) {
        if ([key isKindOfClass:[ATKey class]]) {
            if(key.tag == 6401 || key.tag == 6402 || key.tag == 6403) {
                [key removeFromSuperview];
                [key release];
                key = nil;
            }
        }
    }

    
    NSArray *PrimaryCharactersRow1 = [NSArray arrayWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P", nil];
    NSArray *PrimaryCharactersRow2 = [NSArray arrayWithObjects:@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L", nil];
    NSArray *PrimaryCharactersRow3 = [NSArray arrayWithObjects:@"Z",@"X",@"C",@"V",@"B",@"N",@"M", nil];
    NSArray *SecondaryCharactersRow1 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0", nil];
    NSArray *SecondaryCharactersRow2 = [NSArray arrayWithObjects:@"!",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@".", nil];
    NSArray *SecondaryCharactersRow3 = [NSArray arrayWithObjects:@"-",@"?",@"+",@"=",@":",@"/",@",", nil];
    NSArray *TertiaryCharactersRow1 = [NSArray arrayWithObjects:@"(",@")",@"[",@"]",@"{",@"}",@";",@"\"",@"'",@"•", nil];
    NSArray *TertiaryCharactersRow2 = [NSArray arrayWithObjects:@"_",@"|",@"<",@">",@"%",@"^",@"&",@"*",@".", nil];
    NSArray *TertiaryCharactersRow3 = [NSArray arrayWithObjects:@"-",@"?",@"+",@"=",@":",@"/",@",", nil];
    
    for(NSString *string in (currentStyle == 1)?PrimaryCharactersRow1:(currentStyle == 2)?SecondaryCharactersRow1:TertiaryCharactersRow1){
        ATKey *key = [ATKey keyWithTitle:[NSString stringWithFormat:@"%@",string]];
        key.tag = 6401;
        [key addTarget:self action:@selector(keyTapped:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:key];
    }
    for(NSString *string in (currentStyle == 1)?PrimaryCharactersRow2:(currentStyle == 2)?SecondaryCharactersRow2:TertiaryCharactersRow2){
        ATKey *key = [ATKey keyWithTitle:[NSString stringWithFormat:@"%@",string]];
        key.tag = 6402;
        [key addTarget:self action:@selector(keyTapped:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:key];
    }
    for(NSString *string in (currentStyle == 1)?PrimaryCharactersRow3:(currentStyle == 2)?SecondaryCharactersRow3:TertiaryCharactersRow3){
        ATKey *key = [ATKey keyWithTitle:[NSString stringWithFormat:@"%@",string]];
        key.tag = 6403;
        [key addTarget:self action:@selector(keyTapped:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:key];
    }
    
    PhoneKeyboardMetrics phoneKeyboardMetrics = getPhoneLinearKeyboardMetrics(size.width, size.height);
    self.deleteButton.frame = phoneKeyboardMetrics.deleteButtonFrame;
    self.nextKeyboardButton.frame = phoneKeyboardMetrics.nextKeyboardButtonFrame;
    self.spaceButton.frame = phoneKeyboardMetrics.spaceButtonFrame;
    self.shiftButton.frame = phoneKeyboardMetrics.leftShiftButtonFrame;
    self.returnButton.frame = phoneKeyboardMetrics.returnButtonFrame;

    int i1 = 0;
    int i2 = 0;
    int i3 = 0;
    for (ATKey *key in self.subviews) {
        if ([key isKindOfClass:[ATKey class]]) {
            if(key.tag == 6401 /*Row 1*/) {
                key.frame = CGRectMake(((phoneKeyboardMetrics.keySize.width+phoneKeyboardMetrics.RowAndColumnMargins.y)*i1),
                                       0,
                                       phoneKeyboardMetrics.keySize.width,
                                       phoneKeyboardMetrics.keySize.height);
                i1++;
            } else if (key.tag == 6402 /*Row 2*/) {
                key.frame = CGRectMake((((phoneKeyboardMetrics.keySize.width + phoneKeyboardMetrics.RowAndColumnMargins.y)/2) + ((phoneKeyboardMetrics.keySize.width + phoneKeyboardMetrics.RowAndColumnMargins.y)*i2)),
                                       phoneKeyboardMetrics.keySize.height + phoneKeyboardMetrics.RowAndColumnMargins.x,
                                       phoneKeyboardMetrics.keySize.width,
                                       phoneKeyboardMetrics.keySize.height);
                i2++;
            } else if (key.tag == 6403 /*Row 3*/) {
                key.frame = CGRectMake(((phoneKeyboardMetrics.keySize.width + (phoneKeyboardMetrics.keySize.width/2)) + (phoneKeyboardMetrics.RowAndColumnMargins.y*1.5) + ((phoneKeyboardMetrics.keySize.width + phoneKeyboardMetrics.RowAndColumnMargins.y)*i3)),
                                       (phoneKeyboardMetrics.keySize.height)*2 + (phoneKeyboardMetrics.RowAndColumnMargins.x)*2,
                                       phoneKeyboardMetrics.keySize.width,
                                       phoneKeyboardMetrics.keySize.height);
                i3++;
            }
        }
    }
}
- (ATKey*)nextKeyboardButton {
    if (!_nextKeyboardButton) {
       _nextKeyboardButton = [ATKey keyWithTitle:@"123"];
        [_nextKeyboardButton addTarget:self action:@selector(switchKeyboardStyle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextKeyboardButton];
    }
    return _nextKeyboardButton;
}
- (ATKey*)returnButton {
    if (!_returnButton) {
        _returnButton = [ATKey keyWithTitle:@"Cancel"];
        [_returnButton addTarget:self action:@selector(returnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_returnButton];
    }
    return _returnButton;
}
- (ATKey*)spaceButton {
    if (!_spaceButton) {
        _spaceButton = [ATKey keyWithTitle:@"space"];
        [_spaceButton addTarget:self action:@selector(spaceButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_spaceButton];
    }
    return _spaceButton;
}
- (ATKey*)shiftButton {
    if (!_shiftButton) {
        UIImage *image = [[UIImage imageNamed:@"shift_landscape"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _shiftButton = [ATKey keyWithImage:image];
        [self addSubview:_shiftButton];
    }
    return _shiftButton;
}
- (ATKey*)deleteButton {
    if (!_deleteButton) {
        UIImage *image = [[UIImage imageNamed:@"delete_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _deleteButton = [ATKey keyWithImage:image];
        [_deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [_deleteButton addTarget:self action:@selector(deleteButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton addTarget:self action:@selector(deleteButtonReleased:) forControlEvents:UIControlEventTouchUpOutside];
        [self addSubview:_deleteButton];
    }
    return _deleteButton;
}
- (void)deleteBackward {
    NSString *prevText = [(TodayViewController*)self.parentViewController statusLabel].text;
    if([prevText isEqualToString:@"Start typing & tap 'Post' when finished."]) {
        [(TodayViewController*)self.parentViewController statusLabel].text = @"";
        _returnButton.title = @"Cancel";
    } else {
        if(prevText.length != 0) {
            [(TodayViewController*)self.parentViewController statusLabel].text = [prevText stringByReplacingCharactersInRange:NSMakeRange(prevText.length-1, 1) withString:@""];
        }
        if([(TodayViewController*)self.parentViewController statusLabel].text.length == 0) {
            _returnButton.title = @"Cancel";
        } else {
            _returnButton.title = @"Post";
        }
    }
    [(TodayViewController*)self.parentViewController counterLabel].text = [NSString stringWithFormat:@"%lu",(unsigned long)[(TodayViewController*)self.parentViewController statusLabel].text.length];
}
- (void)insertText:(NSString*)text {
    NSString *prevText = [(TodayViewController*)self.parentViewController statusLabel].text;
    if(prevText.length == 0) {
        [(TodayViewController*)self.parentViewController statusLabel].text = [[prevText stringByAppendingString:text] uppercaseString];
    } else {
        [(TodayViewController*)self.parentViewController statusLabel].text = [prevText stringByAppendingString:text];
    }
    [(TodayViewController*)self.parentViewController counterLabel].text = [NSString stringWithFormat:@"%lu",(unsigned long)[(TodayViewController*)self.parentViewController statusLabel].text.length];
}
- (void)keyTapped:(ATKey*)sender {
    if([[(TodayViewController*)self.parentViewController statusLabel].text isEqualToString:@"Start typing & tap 'Post' when finished."]) {
        [(TodayViewController*)self.parentViewController statusLabel].text = @"";
        _returnButton.title = @"Cancel";
    } else {
        _returnButton.title = @"Post";
    }
    if([self.shiftButton isHighlighted]) {
        [self insertText:[sender.title uppercaseString]];
    } else {
        [self insertText:[sender.title lowercaseString]];
    }
}
- (void)returnButtonTapped:(id)sender {
    if([(TodayViewController*)self.parentViewController statusLabel].text.length != 0 && ![[(TodayViewController*)self.parentViewController statusLabel].text isEqualToString:@"Start typing & tap 'Post' when finished."]) {
        [(TodayViewController*)self.parentViewController hideKeyboardAndPost];
    } else {
        [(TodayViewController*)self.parentViewController hideKeyboardOnly];
    }
}
- (void)spaceButtonTapped:(id)sender {
    if([[(TodayViewController*)self.parentViewController statusLabel].text isEqualToString:@"Start typing & tap 'Post' when finished."]) {
        [(TodayViewController*)self.parentViewController statusLabel].text = @"";
        _returnButton.title = @"Cancel";
    }
    [self insertText:@" "];
    _returnButton.title = @"Post";
    [(TodayViewController*)self.parentViewController counterLabel].text = [NSString stringWithFormat:@"%lu",(unsigned long)[(TodayViewController*)self.parentViewController statusLabel].text.length];

}
- (void)deleteButtonTapped:(id)sender {
    [self deleteBackward];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(deleteTimerFireMethod:) userInfo:nil repeats:YES];
    deleteTimer = timer;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        if (timer == deleteTimer) {
            [deleteTimer fire];
        }
    });
}
- (void)deleteTimerFireMethod:(NSTimer *)timer {
    if (self.deleteButton.highlighted) {
        [self deleteBackward];
    } else {
        [timer invalidate];
        deleteTimer = nil;
    }
}
- (void)deleteButtonReleased:(id)sender {
    [deleteTimer invalidate];
    deleteTimer = nil;
}
- (void)switchKeyboardStyle {
    if(currentStyle == 1) {
        currentStyle = 2;
    } else if (currentStyle == 2) {
        currentStyle = 3;
    } else if (currentStyle == 3) {
        currentStyle = 1;
    }
    
    [self layoutViewForSize:CGSizeMake(self.bounds.size.width, 159) style:currentStyle];
}
@end
