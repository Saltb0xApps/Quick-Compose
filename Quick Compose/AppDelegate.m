#import "AppDelegate.h"

@implementation AppDelegate
@synthesize window = window;
@synthesize mainViewController = mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.mainViewController = [[[ATMainViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    self.window.rootViewController = self.mainViewController;
    self.window.layer.cornerRadius = 7.5;
    self.window.clipsToBounds = YES;
    [self.window makeKeyAndVisible];
    return YES;
}
+ (void)initialize {
    [iRate sharedInstance].daysUntilPrompt = 2;
    [iRate sharedInstance].usesUntilPrompt = 5;
}
- (void)dealloc {
    [window release];
    [ATMainViewController release];
    [super dealloc];
}
@end
