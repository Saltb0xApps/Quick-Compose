#import "TodayViewController.h"
@implementation UITextView (ATWidget)
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}
@end
@implementation TodayViewController
@synthesize statusLabel;
@synthesize counterLabel;
int network = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, 80);
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.QCSharingDefaults"];
    if([shared objectForKey:@"QCcurrentAccountTW"] != nil) {
        TwitterPostLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,
                                                                    20,
                                                                    ([shared objectForKey:@"QCcurrentAccountFB"] != nil)?(self.view.bounds.size.width/2)-20:self.view.bounds.size.width-20,
                                                                    40)];
        TwitterPostLabel.textColor =  [UIColor colorWithWhite:0.9 alpha:1];
        TwitterPostLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        TwitterPostLabel.textAlignment = NSTextAlignmentCenter;
        TwitterPostLabel.layer.cornerRadius = 5;
        TwitterPostLabel.clipsToBounds = YES;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[[NSString fontAwesomeIconStringForIconIdentifier:@"fa-twitter"] stringByAppendingString:[self stringByAddingSpace:@"Tap to Tweet" spaceCount:2 atIndex:0]]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:18] range:NSMakeRange(0, 1)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir" size:18] range:NSMakeRange(1, attrStr.length-1)];
        TwitterPostLabel.attributedText = attrStr;
        TwitterPostLabel.numberOfLines = 1;
        TwitterPostLabel.minimumScaleFactor = 0.5;
        TwitterPostLabel.userInteractionEnabled = YES;
        TwitterPostLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [TwitterPostLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTwitter)]];
        [self.view addSubview:TwitterPostLabel];
    }
    if([shared objectForKey:@"QCcurrentAccountFB"] != nil) {
        FacebookPostLabel = [[UILabel alloc]initWithFrame:CGRectMake(([shared objectForKey:@"QCcurrentAccountTW"] != nil)?((self.view.bounds.size.width/2)+10):10,
                                                                     20,
                                                                     ([shared objectForKey:@"QCcurrentAccountTW"] != nil)?((self.view.bounds.size.width/2)-20):self.view.bounds.size.width-20,
                                                                     40)];
        FacebookPostLabel.textColor =  [UIColor colorWithWhite:0.9 alpha:1];
        FacebookPostLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        FacebookPostLabel.layer.cornerRadius = 5;
        FacebookPostLabel.clipsToBounds = YES;
        FacebookPostLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[[NSString fontAwesomeIconStringForIconIdentifier:@"fa-facebook"] stringByAppendingString:[self stringByAddingSpace:@"Tap to Post" spaceCount:2 atIndex:0]]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:18] range:NSMakeRange(0, 1)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir" size:18] range:NSMakeRange(1, attrStr.length-1)];
        FacebookPostLabel.attributedText = attrStr;
        FacebookPostLabel.numberOfLines = 1;
        FacebookPostLabel.minimumScaleFactor = 0.5;
        FacebookPostLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        FacebookPostLabel.userInteractionEnabled = YES;
        [FacebookPostLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFacebook)]];
        [self.view addSubview:FacebookPostLabel];
    }
    
    if([shared objectForKey:@"QCcurrentAccountFB"] == nil && [shared objectForKey:@"QCcurrentAccountTW"] == nil) {
        [[self.view viewWithTag:0246123] removeFromSuperview];
        
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
        errorLabel.text = @"Please setup Twitter & Facebook account from the Quick Compose app first.";
        errorLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        errorLabel.textAlignment = NSTextAlignmentCenter;
        errorLabel.textColor = [UIColor whiteColor];
        errorLabel.numberOfLines = 2;
        errorLabel.tag = 0246123;
        errorLabel.font = [UIFont fontWithName:@"Avenir" size:12];
        errorLabel.userInteractionEnabled = YES;
        [self.view addSubview:errorLabel];
    }
}
- (void)showError {
    [[self.view viewWithTag:0246123] removeFromSuperview];
    
    UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    errorLabel.text = @"Error Posting. Please try again later.";
    errorLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
    errorLabel.textAlignment = NSTextAlignmentCenter;
    errorLabel.textColor = [UIColor whiteColor];
    errorLabel.numberOfLines = 2;
    errorLabel.tag = 0246123;
    errorLabel.font = [UIFont fontWithName:@"Avenir" size:12];
    errorLabel.userInteractionEnabled = YES;
    [self.view addSubview:errorLabel];
}
- (void)showTwitter {
    network = 1;
    [UIView animateWithDuration:0.15 animations:^{
        FacebookPostLabel.alpha = 0;
        TwitterPostLabel.alpha = 0;
        [keyboard removeFromSuperview];
    } completion:^(BOOL finished) {
        self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, 265);
        keyboard = nil;
        keyboard = [[ATKeyboardView alloc]initWithFrame:CGRectMake(0, self.preferredContentSize.height, self.view.bounds.size.width, 159)];
        keyboard.center = CGPointMake(self.view.center.x, keyboard.center.y);
        keyboard.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [self.view addSubview:keyboard];
        [UIView animateWithDuration:0.15 delay:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
            keyboard.frame = CGRectMake(keyboard.frame.origin.x, self.preferredContentSize.height-159, self.view.bounds.size.width, 159);
        } completion:^(BOOL finished) {
            [statusLabel removeFromSuperview];
            statusLabel.delegate = nil;
            statusLabel = nil;
            
            statusLabel = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, self.preferredContentSize.height - keyboard.bounds.size.height - 20)];
            statusLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
            statusLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.05];
            statusLabel.font = [UIFont fontWithName:@"Avenir-Light" size:15];
            statusLabel.text = @"Start typing & tap 'Post' when finished.";
            statusLabel.alpha = 0;
            statusLabel.autocapitalizationType = UITextAutocapitalizationTypeSentences;
            statusLabel.autocorrectionType = UITextAutocorrectionTypeYes;
            statusLabel.layer.cornerRadius = 3;
            statusLabel.delegate = self;
            statusLabel.clipsToBounds = YES;
            [statusLabel setTintColor:[UIColor whiteColor]];
            [self.view addSubview:statusLabel];
            [statusLabel becomeFirstResponder];
            counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusLabel.frame.origin.x + statusLabel.bounds.size.width-30, statusLabel.frame.origin.x + statusLabel.bounds.size.height-20, 30, 20)];
            counterLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
            counterLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.05];
            counterLabel.textAlignment = NSTextAlignmentCenter;
            counterLabel.font = [UIFont fontWithName:@"Avenir-Light" size:8];
            counterLabel.text = @"0";
            [self.view addSubview:counterLabel];
            [UIView animateWithDuration:0.25 animations:^{
                statusLabel.alpha = 1;
            }];
        }];

    }];
}
- (void)showFacebook {
    network = 2;
    [UIView animateWithDuration:0.15 animations:^{
        FacebookPostLabel.alpha = 0;
        TwitterPostLabel.alpha = 0;
        [keyboard removeFromSuperview];
    } completion:^(BOOL finished) {
        self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, 265);
        
        keyboard = nil;
        keyboard = [[ATKeyboardView alloc]initWithFrame:CGRectMake(0, self.preferredContentSize.height, self.view.bounds.size.width, 159)];
        keyboard.center = CGPointMake(self.view.center.x, keyboard.center.y);
        keyboard.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [self.view addSubview:keyboard];
        [UIView animateWithDuration:0.15 delay:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
            keyboard.frame = CGRectMake(keyboard.frame.origin.x, self.preferredContentSize.height-159, self.view.bounds.size.width, 159);
        } completion:^(BOOL finished) {
            [statusLabel removeFromSuperview];
            statusLabel.delegate = nil;
            statusLabel = nil;
            
            statusLabel = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, self.preferredContentSize.height - keyboard.bounds.size.height - 20)];
            statusLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
            statusLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.05];
            statusLabel.font = [UIFont fontWithName:@"Avenir-Light" size:15];
            statusLabel.text = @"Start typing & tap 'Post' when finished.";
            statusLabel.alpha = 0;
            statusLabel.dataDetectorTypes = UIDataDetectorTypeNone;
            statusLabel.delegate = self;
            statusLabel.autocapitalizationType = UITextAutocapitalizationTypeSentences;
            statusLabel.autocorrectionType = UITextAutocorrectionTypeYes;
            statusLabel.layer.cornerRadius = 3;
            statusLabel.clipsToBounds = YES;
            statusLabel.tintColor = [UIColor whiteColor];
            [self.view addSubview:statusLabel];
            [statusLabel becomeFirstResponder];
            counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(statusLabel.frame.origin.x + statusLabel.bounds.size.width-30, statusLabel.frame.origin.x + statusLabel.bounds.size.height-20, 30, 20)];
            counterLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
            counterLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.05];
            counterLabel.font = [UIFont fontWithName:@"Avenir-Light" size:8];
            counterLabel.text = @"0";
            counterLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:counterLabel];
            [UIView animateWithDuration:0.25 animations:^{
                statusLabel.alpha = 1;
            }];
        }];
    }];
}
- (void)hideKeyboardAndPost {
    if(network == 1) {
        /*post to twitter*/
        ACAccount* twitterAccount = [NSKeyedUnarchiver unarchiveObjectWithData:[shared objectForKey:@"QCcurrentAccountTW"]];
        STTwitterAPI *twitter = [STTwitterAPI twitterAPIOSWithAccount:twitterAccount];
        [twitter postStatusUpdate:statusLabel.text inReplyToStatusID:nil latitude:nil longitude:nil placeID:nil displayCoordinates:nil trimUser:nil successBlock:^(NSDictionary *status) {
            [self hideKeyboardOnly];
        } errorBlock:^(NSError *error) {
            [self hideKeyboardOnly];
            [self showError];
        }];
    } else if (network == 2) {
        /*post to facebook*/
        ACAccountStore *account_Store = [[ACAccountStore alloc] init];
        ACAccountType *account_Type = [account_Store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
        ACAccount *facebookAccount = [[ACAccount alloc] init];
        facebookAccount = [NSKeyedUnarchiver unarchiveObjectWithData:[shared objectForKey:@"QCcurrentAccountFB"]];
        [account_Store requestAccessToAccountsWithType:account_Type options:@{ACFacebookAppIdKey:@"894257040612978", ACFacebookPermissionsKey:@[@"publish_actions"], ACFacebookAudienceKey:ACFacebookAudienceFriends} completion:^(BOOL granted, NSError *error) {
            [account_Store renewCredentialsForAccount:facebookAccount completion:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *parameters = @{@"message": statusLabel.text, @"access_token": facebookAccount.credential.oauthToken};
                NSURL *feedURL = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
                SLRequest *feedRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodPOST URL:feedURL parameters:parameters];
                [feedRequest setAccount:facebookAccount];
                [feedRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self hideKeyboardOnly];
                        if(error) {
                            [self showError];
                        }
                    });
                }];
            });
        }];
    }
}
- (void)hideKeyboardOnly {
    [UIView animateWithDuration:0.15 delay:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^{
        keyboard.frame = CGRectMake(keyboard.frame.origin.x, self.preferredContentSize.height, self.view.bounds.size.width, 159);
    } completion:^(BOOL finished) {
        [keyboard removeFromSuperview];
        keyboard = nil;
        self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, 80);
        [UIView animateWithDuration:0.15 animations:^{
            FacebookPostLabel.alpha = 1;
            TwitterPostLabel.alpha = 1;
            statusLabel.alpha = 0;
            counterLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [statusLabel removeFromSuperview];
            statusLabel.delegate = nil;
            statusLabel = nil;
            [counterLabel removeFromSuperview];
            counterLabel = nil;
        }];
    }];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    shared = nil;
    [FacebookPostLabel removeFromSuperview];
    [TwitterPostLabel removeFromSuperview];
    FacebookPostLabel = nil;
    TwitterPostLabel = nil;
    [keyboard removeFromSuperview];
    keyboard = nil;
    [[self.view viewWithTag:0246123] removeFromSuperview];
    [statusLabel removeFromSuperview];
    statusLabel = nil;
    [counterLabel removeFromSuperview];
    counterLabel = nil;
}
#define MAX_LENGTH 140
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"##");
    if(network == 1) {
        NSUInteger newLength = (textView.text.length - range.length) + text.length;
        if(newLength <= MAX_LENGTH) {
            return YES;
        } else {
            NSUInteger emptySpace = MAX_LENGTH - (textView.text.length - range.length);
            textView.text = [[[textView.text substringToIndex:range.location] stringByAppendingString:[text substringToIndex:emptySpace]] stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
            return NO;
        }
    } else {
        return YES;
    }
}


#pragma mark - useless stuff
-(NSString*)stringByAddingSpace:(NSString*)stringToAddSpace spaceCount:(NSInteger)spaceCount atIndex:(NSInteger)index{
    NSString *result = [NSString stringWithFormat:@"%@%@",[@" " stringByPaddingToLength:spaceCount withString:@" " startingAtIndex:0],stringToAddSpace];
    return result;
}
- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets { return UIEdgeInsetsMake(0, 0, 0, 0); }
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler { completionHandler(NCUpdateResultNoData); }
@end
