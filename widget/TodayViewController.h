#import <UIKit/UIKit.h>
#import <NotificationCenter/NotificationCenter.h>
#import <Social/Social.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Accounts/Accounts.h>
#import <MessageUI/MessageUI.h>
#import <StoreKit/StoreKit.h>

#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"
#import "STTwitter.h"
#import "ATKeyboardView.h"

@interface TodayViewController : UIViewController <NCWidgetProviding, UITextViewDelegate>
{
    UILabel *TwitterPostLabel;
    UILabel *FacebookPostLabel;
    
    NSUserDefaults *shared;
    ATKeyboardView *keyboard;
}
- (void)hideKeyboardAndPost;
- (void)hideKeyboardOnly;
- (void)showError;
@property (nonatomic, retain) UITextView *statusLabel;
@property (nonatomic, retain) UILabel *counterLabel;
@end