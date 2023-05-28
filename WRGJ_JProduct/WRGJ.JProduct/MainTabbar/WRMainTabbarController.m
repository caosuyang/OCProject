//
//  WRMainTabbarController.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/6.
//

#import "WRMainTabbarController.h"
#import "WRHomeVC.h"
#import "WRMineVC.h"
#import "WRWantBuyRecordVC.h"
#import "WRQuotationListVC.h"
@interface WRMainTabbarController ()<UITabBarDelegate,UITabBarControllerDelegate>
@property(nonatomic, strong)UIImageView *homeSelectImage;
@end

@implementation WRMainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    WRHomeVC *homeVC = [[WRHomeVC alloc]init];
    homeVC.title = @"首页";
    [self createVC:homeVC Title:@"首页" imageName:@"bar_icon_home_gray" selectImage:@""];
    UINavigationController *homeNavi = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    WRWantBuyRecordVC *recordVC = [[WRWantBuyRecordVC alloc]init];
    recordVC.title = @"求购记录";
    [self createVC:recordVC Title:@"求购记录" imageName:@"bar_icon_record_gray" selectImage:@"bar_icon_record"];
    UINavigationController *recordNavi = [[UINavigationController alloc]initWithRootViewController:recordVC];
    
    WRQuotationListVC *listVC = [[WRQuotationListVC alloc]init];
    listVC.title = @"报价单";
    [self createVC:listVC Title:@"报价单" imageName:@"bar_icon_quotation_gray" selectImage:@"bar_icon_quotation"];
    UINavigationController *listNavi = [[UINavigationController alloc]initWithRootViewController:listVC];
    
    WRMineVC *mineVC = [[WRMineVC alloc]init];
    mineVC.title = @"我的";
    [self createVC:mineVC Title:@"我的" imageName:@"bar_icon_mine_gray" selectImage:@"bar_icon_mine"];
    UINavigationController *mineNavi = [[UINavigationController alloc]initWithRootViewController:mineVC];

    [self setViewControllers:@[homeNavi,recordNavi,listNavi,mineNavi]];
    
    
    self.homeSelectImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 43,43)];
    self.homeSelectImage.image = [UIImage imageNamed:@"bar_icon_logo"];
    self.homeSelectImage.center = CGPointMake(kScreenWidth/8, 12);
    self.homeSelectImage.layer.cornerRadius = 21.5;
    self.homeSelectImage.layer.masksToBounds = YES;
    self.homeSelectImage.userInteractionEnabled = NO;
    [self.tabBar addSubview:self.homeSelectImage];
    
}

- (void)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName selectImage:(NSString *)selectImage{
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (@available(iOS 13.0, *)) {
        UITabBar *tabBar = [UITabBar appearance];
        [tabBar setUnselectedItemTintColor:[UIColor lightGrayColor]];
        [tabBar setTintColor:[UIColor colorWithRed:237.0/255.0 green:155.0/255.0 blue:54.0/255.0 alpha:1]];
    } else {
        UITabBarItem *tabBarItem = [UITabBarItem appearance];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]} forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:237.0/255.0 green:155.0/255.0 blue:54.0/255.0 alpha:1]}forState:UIControlStateSelected];
    }
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController API_AVAILABLE(ios(3.0)) {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex != 0) {
        [self.homeSelectImage removeFromSuperview];
    }else {
        tabBarController.title = @"";
        [self.tabBar addSubview:self.homeSelectImage];
        [self animationWithView:self.homeSelectImage];
    }
    [self animationWithIndex:tabBarController.selectedIndex];
}

- (void)animationWithView:(UIView *)view {
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.repeatCount= 1;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1];
    [[view layer] addAnimation:pulse forKey:nil];
}

- (void)animationWithIndex:(NSInteger)index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.repeatCount= 1;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

@end
