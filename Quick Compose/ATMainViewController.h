#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Accounts/Accounts.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <StoreKit/StoreKit.h>
#import <GoogleMobileAds/GADBannerView.h>
#import <GoogleMobileAds/GADBannerViewDelegate.h>

#import "BFPaperButton.h"
#import "UIColor+BFPaperColors.h"
#import "STTwitter.h"
#import "SCLAlertView.h"
#import "iRate.h"
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"

@interface ATMainViewController : UIViewController <SKRequestDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, GADBannerViewDelegate>
{
    UIView *demoWidget;
    UILabel *nameLabel;
    UITableView *InformationTable;
    UIScrollView *verticalScrollView;
    UIScrollView *horizontalScrollView;

    NSUserDefaults *shared;
    NSMutableArray *arrayOfAccounts;
    
    BFPaperButton *SignInButton;
    BFPaperButton *SignInButtonFB;
    BFPaperButton *EmailButton;
    BFPaperButton *rateButton;
    GADBannerView *admobBannerView;
}
@end

