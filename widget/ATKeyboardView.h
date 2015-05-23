#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import "ATKey.h"
@interface ATKeyboardView : UIView
{
    UIView *mainView;
    
    NSTimer *deleteTimer;
    
    int currentStyle;
}
@property (nonatomic, strong) ATKey *nextKeyboardButton;
@property (nonatomic, strong) ATKey *shiftButton;
@property (nonatomic, strong) ATKey *spaceButton;
@property (nonatomic, strong) ATKey *returnButton;
@property (nonatomic, strong) ATKey *deleteButton;

typedef struct {
    CGSize keySize;
    
    CGRect leftShiftButtonFrame;
    CGRect deleteButtonFrame;
    
    CGRect nextKeyboardButtonFrame;
    CGRect spaceButtonFrame;
    CGRect returnButtonFrame;
    
    CGFloat cornerRadius;
    
    CGPoint RowAndColumnMargins;
    
} PhoneKeyboardMetrics;

PhoneKeyboardMetrics getPhoneLinearKeyboardMetrics(CGFloat keyboardWidth, CGFloat keyboardHeight);
@end
