#import "ATMainViewController.h"
/*
 =================================================================================== CHANGELOG ============================================================================================
 *** = live on the appstore
 **# = Done but not yet live on the appstore
 *## = Under Progress
 ### = Not started
 
 **# 1.0
 • Initial Release.
 
 *## 1.0.1
 • Improved Keyboard
 • ads
 =================================================================================== CHANGELOG ============================================================================================
 */

@implementation ATMainViewController

#pragma mark - Primary Funtions -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    self.view.frame = [[UIScreen mainScreen]bounds];
    
    shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.QCSharingDefaults"];
    
    horizontalScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    horizontalScrollView.contentSize = CGSizeMake(self.view.bounds.size.width*2, self.view.bounds.size.height);
    horizontalScrollView.bounces = NO;
    horizontalScrollView.delegate = self;
    horizontalScrollView.pagingEnabled = YES;
    horizontalScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    horizontalScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.01];
    [self.view addSubview:horizontalScrollView];
    
    demoWidget = [[UIView alloc]init];
    demoWidget.frame = CGRectMake(self.view.bounds.size.width, self.view.center.y-(354/2), self.view.bounds.size.width, 354);
    demoWidget.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    UILabel *TwitterPostLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, (demoWidget.bounds.size.width/2)-20, 40)];
    TwitterPostLabel.textColor =  [UIColor colorWithWhite:0.9 alpha:1];
    TwitterPostLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
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
    [demoWidget addSubview:TwitterPostLabel];
    UILabel *FacebookPostLabel = [[UILabel alloc]initWithFrame:CGRectMake((demoWidget.bounds.size.width/2)+10, 20, (demoWidget.bounds.size.width/2)-20, 40)];
    FacebookPostLabel.textColor =  [UIColor colorWithWhite:0.9 alpha:1];
    FacebookPostLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
    FacebookPostLabel.layer.cornerRadius = 5;
    FacebookPostLabel.clipsToBounds = YES;
    FacebookPostLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:[[NSString fontAwesomeIconStringForIconIdentifier:@"fa-facebook"] stringByAppendingString:[self stringByAddingSpace:@"Tap to Post" spaceCount:2 atIndex:0]]];
    [attrStr2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:18] range:NSMakeRange(0, 1)];
    [attrStr2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir" size:18] range:NSMakeRange(1, attrStr2.length-1)];
    FacebookPostLabel.attributedText = attrStr2;
    FacebookPostLabel.numberOfLines = 1;
    FacebookPostLabel.minimumScaleFactor = 0.5;
    FacebookPostLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    FacebookPostLabel.userInteractionEnabled = YES;
    [FacebookPostLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFacebook)]];
    [demoWidget addSubview:FacebookPostLabel];

    verticalScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    verticalScrollView.contentSize = self.view.bounds.size;
    verticalScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    verticalScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.01];
    [horizontalScrollView addSubview:verticalScrollView];
    
    UIImageView *TopBackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150 /*arbitrary*/)];
    TopBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    TopBackgroundView.image = [UIImage imageNamed:@"icon512x512.png"];
    TopBackgroundView.contentMode = UIViewContentModeScaleAspectFit;
    TopBackgroundView.clipsToBounds = YES;
    TopBackgroundView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    [verticalScrollView insertSubview:TopBackgroundView atIndex:0];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, TopBackgroundView.frame.origin.y + TopBackgroundView.bounds.size.height + 20, self.view.bounds.size.width, 40)];
    nameLabel.textColor =  [UIColor colorWithWhite:0.1 alpha:1];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attrStr3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@\nMade By Akhil Tolani",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] ,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
    [attrStr3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir" size:16] range:NSMakeRange(0, attrStr3.length-20)];
    [attrStr3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-LightOblique" size:8] range:NSMakeRange(attrStr3.length-20, 20)];
    nameLabel.attributedText = attrStr3;
    nameLabel.numberOfLines = 2;
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [verticalScrollView addSubview:nameLabel];
    
    InformationTable = [[UITableView alloc]initWithFrame:CGRectMake(0, nameLabel.frame.origin.y + nameLabel.bounds.size.height + 20, self.view.bounds.size.width, 250) style:UITableViewStylePlain];
    InformationTable.dataSource = self;
    InformationTable.delegate = self;
    InformationTable.backgroundColor = self.view.backgroundColor;
    InformationTable.rowHeight = 50;
    InformationTable.scrollEnabled = NO;
    InformationTable.userInteractionEnabled = NO;
    InformationTable.sectionHeaderHeight = 0;
    InformationTable.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [InformationTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [verticalScrollView addSubview:InformationTable];
    
    SignInButton = [[BFPaperButton alloc]initWithFrame:CGRectMake(20, InformationTable.frame.origin.y + InformationTable.bounds.size.height + 30, self.view.bounds.size.width - 40, 40)];
    [SignInButton setTitle:@"Setup Twitter Account" forState:UIControlStateNormal];
    SignInButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    SignInButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    SignInButton.tapCircleColor = [UIColor colorWithWhite:0 alpha:0.1];
    SignInButton.rippleFromTapLocation = YES;
    SignInButton.rippleBeyondBounds = NO;
    SignInButton.isRaised = NO;
    SignInButton.backgroundFadeColor = [UIColor clearColor];
    SignInButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    SignInButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [SignInButton setTitleColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
    [SignInButton addTarget:self action:@selector(setupTwitter:) forControlEvents:UIControlEventTouchUpInside];
    [verticalScrollView addSubview:SignInButton];
    
    SignInButtonFB = [[BFPaperButton alloc]initWithFrame:CGRectMake(20, SignInButton.frame.origin.y + SignInButton.bounds.size.height + 10, self.view.bounds.size.width - 40, 40)];
    [SignInButtonFB setTitle:@"Setup Facebook Account" forState:UIControlStateNormal];
    SignInButtonFB.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    SignInButtonFB.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    SignInButtonFB.tapCircleColor = [UIColor colorWithWhite:0 alpha:0.1];
    SignInButtonFB.rippleFromTapLocation = YES;
    SignInButtonFB.rippleBeyondBounds = NO;
    SignInButtonFB.isRaised = NO;
    SignInButtonFB.backgroundFadeColor = [UIColor clearColor];
    SignInButtonFB.titleLabel.textAlignment = NSTextAlignmentCenter;
    SignInButtonFB.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [SignInButtonFB setTitleColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
    [SignInButtonFB addTarget:self action:@selector(setupFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [verticalScrollView addSubview:SignInButtonFB];
    
    EmailButton = [[BFPaperButton alloc]initWithFrame:CGRectMake(20, SignInButtonFB.frame.origin.y + SignInButtonFB.bounds.size.height + 10, self.view.bounds.size.width - 40, 40)];
    [EmailButton setTitle:@"Contact Us" forState:UIControlStateNormal];
    EmailButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    EmailButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    EmailButton.tapCircleColor = [UIColor colorWithWhite:0 alpha:0.1];
    EmailButton.rippleFromTapLocation = YES;
    EmailButton.rippleBeyondBounds = NO;
    EmailButton.isRaised = NO;
    EmailButton.backgroundFadeColor = [UIColor clearColor];
    EmailButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    EmailButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [EmailButton setTitleColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
    [EmailButton addTarget:self action:@selector(mail) forControlEvents:UIControlEventTouchUpInside];
    [verticalScrollView addSubview:EmailButton];
    
    rateButton = [[BFPaperButton alloc]initWithFrame:CGRectMake(20, EmailButton.frame.origin.y + EmailButton.bounds.size.height + 10, self.view.bounds.size.width - 40, 40)];
    [rateButton setTitle:@"Rate On AppStore" forState:UIControlStateNormal];
    rateButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    rateButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    rateButton.tapCircleColor = [UIColor colorWithWhite:0 alpha:0.1];
    rateButton.rippleFromTapLocation = YES;
    rateButton.rippleBeyondBounds = NO;
    rateButton.isRaised = NO;
    rateButton.backgroundFadeColor = [UIColor clearColor];
    rateButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    rateButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [rateButton setTitleColor:[UIColor colorWithWhite:0.1 alpha:1] forState:UIControlStateNormal];
    [rateButton addTarget:self action:@selector(rateOnAppstore) forControlEvents:UIControlEventTouchUpInside];
    [verticalScrollView addSubview:rateButton];
}
#pragma mark - twitter & facebook -
- (void)setupTwitter:(BFPaperButton*)sender {
    ACAccountStore *account_Store = [[ACAccountStore alloc] init];
    ACAccountType *account_Type = [account_Store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account_Store requestAccessToAccountsWithType:account_Type options:nil completion:^(BOOL granted, NSError *error) {
        if (granted) {
            if(arrayOfAccounts.count != 0) {
                [arrayOfAccounts removeAllObjects];
            }
            arrayOfAccounts = [[NSMutableArray alloc]initWithArray:[account_Store accountsWithAccountType:account_Type]];
            
            if ([arrayOfAccounts count] > 1) /*show picker*/ {
                ACAccount *acct1;
                NSMutableArray *array = [[NSMutableArray alloc]init];
                for (int i = 0 ; i < [arrayOfAccounts count]; i++ ) {
                    acct1 = [[ACAccount alloc]init];
                    acct1 = [arrayOfAccounts objectAtIndex:i];
                    [array setObject:[NSString stringWithFormat:@"@%@",acct1.username] atIndexedSubscript:i];
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select your Twitter Account" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
                    for (int i = 0 ; i < [array count]; i++) {
                        [actionSheet addButtonWithTitle:[array objectAtIndex:i]];
                    }
                    [actionSheet showInView:self.view];
                });
            } else if([arrayOfAccounts count] == 1) /*only one available - use it without picker*/ {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    SCLAlertView *processingAlert = [[SCLAlertView alloc] init];
                    processingAlert.backgroundType = Shadow;
                    processingAlert.shouldDismissOnTapOutside = NO;
                    [processingAlert showInfo:self title:@"Please Wait" subTitle:@"Processing Your account. This should take less than a minute or two." closeButtonTitle:nil duration:0];
                    STTwitterAPI *twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
                    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
                        [twitter postFriendshipsCreateForScreenName:@"Saltb0xApps" orUserID:@"452130264" successBlock:^(NSDictionary *befriendedUser) {
                            [processingAlert hideView];
                            SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                            alert1.backgroundType = Shadow;
                            [alert1 addButton:@"Okay" actionBlock:nil];
                            [alert1 addButton:@"No" actionBlock:^{
                                [twitter postFriendshipsDestroyScreenName:@"Saltb0xApps" orUserID:@"452130264" successBlock:^(NSDictionary *unfollowedUser) {} errorBlock:^(NSError *error) {}];
                            }];
                            [alert1 showSuccess:self title:@"Success" subTitle:@"Twitter account is now setup. Would you like to follow the Quick Compose Team on twitter?" closeButtonTitle:nil duration:0];
                            [shared setObject:[NSKeyedArchiver archivedDataWithRootObject:[arrayOfAccounts objectAtIndex:0]] forKey:@"QCcurrentAccountTW"];
                            [shared synchronize];
                        } errorBlock:^(NSError *error) {
                            SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                            alert1.backgroundType = Shadow;
                            [alert1 showError:self title:@"Error" subTitle:[NSString stringWithFormat:@"Seems like you have an incorrect password setup. Please Launch Settings app > Twitter > @%@ > logout & login again.", ((ACAccount*)([arrayOfAccounts objectAtIndex:0])).username] closeButtonTitle:@"Okay" duration:0];
                        }];
                    } errorBlock:^(NSError *error) {
                        SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                        alert1.backgroundType = Shadow;
                        [alert1 showError:self title:@"Error" subTitle:[NSString stringWithFormat:@"%@",[error localizedDescription]] closeButtonTitle:@"Okay" duration:0];
                        
                    }];
                });
                
            } else /*no account found*/ {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                    alert1.backgroundType = Shadow;
                    [alert1 showError:self title:@"Error" subTitle:@"No Twitter account found. Please go to Settings app > Twitter & login there." closeButtonTitle:@"Okay" duration:0];
                });
            }
        } else /*permission denied*/ {
            dispatch_sync(dispatch_get_main_queue(), ^{
                SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                alert1.backgroundType = Shadow;
                [alert1 showError:self title:@"Error" subTitle:@"Permission Denied\nPlease go to Settings app > Twitter > Enable Quick Compose" closeButtonTitle:@"Okay" duration:0];
            });
        }
    }];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [actionSheet dismissWithClickedButtonIndex:-1 animated:YES];
    
    if(buttonIndex != actionSheet.cancelButtonIndex) {
        SCLAlertView *processingAlert = [[SCLAlertView alloc] init];
        processingAlert.backgroundType = Shadow;
        processingAlert.shouldDismissOnTapOutside = NO;
        [processingAlert showInfo:self title:@"Please Wait" subTitle:@"Processing Your account. This should take less than a minute or two." closeButtonTitle:nil duration:0];
        
        STTwitterAPI *twitter = [STTwitterAPI twitterAPIOSWithAccount:[arrayOfAccounts objectAtIndex:buttonIndex]];
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
            [twitter postFriendshipsCreateForScreenName:@"Saltb0xApps" orUserID:@"452130264" successBlock:^(NSDictionary *befriendedUser) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [processingAlert hideView];
                    SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                    alert1.backgroundType = Shadow;
                    [alert1 addButton:@"Okay" actionBlock:nil];
                    [alert1 addButton:@"No" actionBlock:^{
                        [twitter postFriendshipsDestroyScreenName:@"Saltb0xApps" orUserID:@"452130264" successBlock:^(NSDictionary *unfollowedUser) {} errorBlock:^(NSError *error) {}];
                    }];
                    [alert1 showSuccess:self title:@"Success" subTitle:@"Twitter account is now setup. Would you like to follow the Quick Compose Team on twitter?" closeButtonTitle:nil duration:0];
                    [shared setObject:[NSKeyedArchiver archivedDataWithRootObject:[arrayOfAccounts objectAtIndex:0]] forKey:@"QCcurrentAccountTW"];
                    [shared synchronize];
                    
                });
            } errorBlock:^(NSError *error) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [processingAlert hideView];
                    SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                    alert1.backgroundType = Shadow;
                    [alert1 showError:self title:@"Error" subTitle:[NSString stringWithFormat:@"Seems like you have an incorrect password setup. Please Launch Settings app > Twitter > @%@ > logout & login again.", ((ACAccount*)([arrayOfAccounts objectAtIndex:buttonIndex])).username] closeButtonTitle:@"Okay" duration:0];
                });
            }];
        } errorBlock:^(NSError *error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                alert1.backgroundType = Shadow;
                [alert1 showError:self title:@"Error" subTitle:[NSString stringWithFormat:@"%@",[error localizedDescription]] closeButtonTitle:@"Okay" duration:0];
            });
        }];
    }
}
- (void)setupFacebook:(BFPaperButton*)sender {
    ACAccountStore *account_Store = [[ACAccountStore alloc] init];
    ACAccountType *account_Type = [account_Store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    [account_Store requestAccessToAccountsWithType:account_Type options:@{ACFacebookAppIdKey:@"894257040612978", ACFacebookPermissionsKey:@[@"email"], ACFacebookAudienceKey:ACFacebookAudienceFriends} completion:^(BOOL granted, NSError *error) {
        if (granted) {
            [account_Store requestAccessToAccountsWithType:account_Type options:@{ACFacebookAppIdKey:@"894257040612978", ACFacebookPermissionsKey:@[@"publish_actions"], ACFacebookAudienceKey:ACFacebookAudienceFriends} completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    if([account_Store accountsWithAccountType:account_Type].count != 0) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            if(error == nil){
                                SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                                alert1.backgroundType = Shadow;
                                [alert1 showSuccess:self title:@"Success" subTitle:@"Facebook account is now setup, please set up the Quick Compose widget if you already haven't done it." closeButtonTitle:@"Okay" duration:0];
                                [shared setObject:[NSKeyedArchiver archivedDataWithRootObject:[[account_Store accountsWithAccountType:account_Type] objectAtIndex:0]] forKey:@"QCcurrentAccountFB"];
                                [shared synchronize];
                            } else {
                                SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                                alert1.backgroundType = Shadow;
                                [alert1 showError:self title:@"Error" subTitle:[NSString stringWithFormat:@"Home > Launch Settings app > Facebook > Login again - %@",error] closeButtonTitle:@"Okay" duration:0];
                            }
                        });
                    } else {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                            alert1.backgroundType = Shadow;
                            [alert1 showError:self title:@"Error" subTitle:@"No account found. Please go to Settings app > Facebook & login there" closeButtonTitle:@"Okay" duration:0];
                        });
                    }
                } else {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                        alert1.backgroundType = Shadow;
                        [alert1 showError:self title:@"Error" subTitle:@"Please Launch Settings app > Facebook > login & Enable Quick Compose then try setting up again" closeButtonTitle:@"Okay" duration:0];
                    });
                }
            }];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                SCLAlertView *alert1 = [[SCLAlertView alloc]init];
                alert1.backgroundType = Shadow;
                [alert1 showError:self title:@"Error" subTitle:@"Please Launch Settings app > Facebook > login & Enable Quick Compose then try setting up again" closeButtonTitle:@"Okay" duration:0];
            });
        }
    }];
}
- (void)showTwitter {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *sheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        SLComposeViewControllerCompletionHandler completionBlock = ^(SLComposeViewControllerResult result){
            [sheet dismissViewControllerAnimated:YES completion:Nil];
        };
        sheet.completionHandler = completionBlock;
        [self presentViewController:sheet animated:YES completion:Nil];
    }
}
- (void)showFacebook {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *sheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        SLComposeViewControllerCompletionHandler completionBlock = ^(SLComposeViewControllerResult result){
            [sheet dismissViewControllerAnimated:YES completion:Nil];
        };
        sheet.completionHandler = completionBlock;
        [self presentViewController:sheet animated:YES completion:Nil];
    }
}
#pragma mark - table -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return 5; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CYAN";
    UITableViewCell *cell = (UITableViewCell*)[InformationTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        cell.backgroundColor = [UIColor clearColor];
        UIView *idk = [[UIView alloc]init];
        idk.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = idk;
        [cell.textLabel setTextColor:[UIColor colorWithWhite:0.1 alpha:1]];
        [cell.textLabel setHighlightedTextColor:[UIColor colorWithWhite:0.1 alpha:1]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Avenir" size:15]];
    }
    if(indexPath.row == 0) {
        cell.textLabel.text = @"Bring down the notification center";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Switch to Today tab";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Tap 'Edit' on the bottom";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"Select 'Quick Compose' From the list";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"Setup Twitter & Facebook account below";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Secondary Functions -
int i = 1;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(scrollView == horizontalScrollView) {
        if(scrollView.contentOffset.x >= self.view.bounds.size.width) {
            if(i == 1) {
                [horizontalScrollView addSubview:demoWidget];
                i = 2;
            }
        } else {
            i = 1;
            [demoWidget removeFromSuperview];
        }
    }
}
- (void)mail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [controller setToRecipients:[NSArray arrayWithObject:@"Saltb0xApps@gmail.com"]];
        [controller setSubject:[NSString stringWithFormat:@"Help - %@ %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] ,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
        [controller setMailComposeDelegate:self];
        [controller setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        controller.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        UITextField *textField = [alert addTextField:@"What would you like to tell us?"];
        textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        [alert addButton:@"Okay" actionBlock:^(void) {
            [controller setMessageBody:[NSString stringWithFormat:@"%@\n\nDevice name: %@\niOS Version: %@\nDevice Model: %@\nLocale: %@\nTwitter Account Setup:%@\nFacebook Account Setup:%@\nWidget successfully setup:%@",
                                        textField.text,
                                        [UIDevice currentDevice].name,
                                        [UIDevice currentDevice].systemVersion,
                                        [UIDevice currentDevice].model,
                                        [[NSLocale currentLocale]objectForKey:NSLocaleCountryCode],
                                        ([shared objectForKey:@"QCcurrentAccountTW"] != nil)?@"Yes":@"Nope",
                                        ([shared objectForKey:@"QCcurrentAccountFB"] != nil)?@"Yes":@"Nope",
                                        ([shared boolForKey:@"QCsuccessLaunch"] == YES)?@"Yes":@"Nope"]
                                isHTML:NO];
            [self presentViewController:controller animated:YES completion:nil];
            [controller release];
        }];
        [alert showEdit:self title:@"Send us an Email" subTitle:@"Whether its a bug or a suggestion, we would love to hear from you. ^_^" closeButtonTitle:@"Cancel" duration:0.0f];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Unimportant Stuff -
- (void)rateOnAppstore {
    [[iRate sharedInstance] openRatingsPageInAppStore];
}
-(NSString*)stringByAddingSpace:(NSString*)stringToAddSpace spaceCount:(NSInteger)spaceCount atIndex:(NSInteger)index{
    NSString *result = [NSString stringWithFormat:@"%@%@",[@" " stringByPaddingToLength:spaceCount withString:@" " startingAtIndex:0],stringToAddSpace];
    return result;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(admobBannerView.superview == nil) {
        if(admobBannerView == nil) {
            admobBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait /*handles load in landscape too.*/ origin:CGPointMake(0, self.view.frame.origin.y-150 /*safety is important*/)];
            admobBannerView.adUnitID = @"ca-app-pub-9492696811948548/7669255710";
            admobBannerView.rootViewController = self;
            admobBannerView.delegate = self;
            admobBannerView.backgroundColor = self.view.backgroundColor;
            admobBannerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
            GADRequest *request = [[GADRequest alloc]init];
            request.testDevices = @[@"90f065ff5c3a5138d117122cd8b67d53"];
            [admobBannerView loadRequest:request];
        }
        [self.view addSubview:admobBannerView];
        [UIView animateWithDuration:0.15 animations:^{
            verticalScrollView.frame = CGRectMake(0, 0, verticalScrollView.bounds.size.width, self.view.bounds.size.height - admobBannerView.bounds.size.height);
            admobBannerView.frame = CGRectMake(0, self.view.bounds.size.height - admobBannerView.bounds.size.height, admobBannerView.bounds.size.width, admobBannerView.bounds.size.height);
        }];
    }
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    [UIView animateWithDuration:0.15 animations:^{
        verticalScrollView.frame = CGRectMake(0, 0, verticalScrollView.bounds.size.width, self.view.bounds.size.height);
        admobBannerView.frame = CGRectMake(0, self.view.bounds.size.height+150 /*safety is important*/, admobBannerView.bounds.size.width,  admobBannerView.bounds.size.height);
    } completion:^(BOOL finished) {
        [admobBannerView removeFromSuperview];
        [admobBannerView release];
        admobBannerView = nil;
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView { }
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [verticalScrollView setContentSize:CGSizeMake(self.view.bounds.size.width, rateButton.bounds.size.height + rateButton.frame.origin.y + 10)];
    [horizontalScrollView setContentSize:CGSizeMake(self.view.bounds.size.width*2, self.view.bounds.size.height)];
    if([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height){
        admobBannerView.adSize = kGADAdSizeSmartBannerPortrait;
    } else {
        admobBannerView.adSize = kGADAdSizeSmartBannerLandscape;
    }
    verticalScrollView.frame = CGRectMake(0, 0, verticalScrollView.bounds.size.width, self.view.bounds.size.height - admobBannerView.bounds.size.height);
    demoWidget.frame = CGRectMake(self.view.bounds.size.width, self.view.center.y-(354/2), self.view.bounds.size.width, 354);
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
- (void)didReceiveMemoryWarning{[super didReceiveMemoryWarning];}
- (void)dealloc { [super dealloc]; }
- (BOOL)canBecomeFirstResponder {return YES;}
- (BOOL)prefersStatusBarHidden {return YES;}
- (BOOL)shouldAutorotate{return YES;}
- (NSUInteger)supportedInterfaceOrientations{return UIInterfaceOrientationMaskAll;}
@end
