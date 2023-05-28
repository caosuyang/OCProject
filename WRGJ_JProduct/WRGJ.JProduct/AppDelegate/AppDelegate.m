//
//  AppDelegate.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/6.
//

#import "AppDelegate.h"
#import "WRMainTabbarController.h"
#import "WRAppGuideView.h"

#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    WRMainTabbarController *mainTabbar = [[WRMainTabbarController alloc]init];
    [self.window setRootViewController:mainTabbar];
    [self.window makeKeyAndVisible];
    
    WRAppGuideView *guideView = [WRAppGuideView sharedWithImages:@[@"guide_image_one",@"guide_image_two",@"guide_image_three"]];
    guideView.currentColor = [UIColor colorWithRed:194.0/255.0 green:164.0/255.0 blue:98.0/255.0 alpha:1];
    guideView.nomalColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:231.0/255.0 alpha:1];
    
    return YES;
}

@end
