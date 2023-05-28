//
//  WRHomeVC.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/6.
//

#import "WRHomeVC.h"
#import "WRHomeNaviView.h"
#import "WRHomeContentView.h"
@interface WRHomeVC ()

@end

@implementation WRHomeVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    NSDictionary *mydic = @{
        @"areaCode" :@"上海",
        @"auth" :@"",
        @"cityCode":@"",
        @"contact":@"",
        @"id":@"0",
    };
    
    if (mydic) {
        [[WRRequestAction sharedAction]PostReqeustWithURL:@"http://test.jpwanrun.com/mcht/rest/dealer/queryAllDealer" withParametes:mydic valueBlock:^(NSDictionary * _Nonnull data, BOOL isSuccess, NSError * _Nonnull error) {
                
        } showInView:YES];
    }
    
}

- (void)initUI {
    
    WRHomeContentView *contentView = [[WRHomeContentView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight)];
    [self.view addSubview:contentView];
    
    if (@available(iOS 11.0, *)) {
        contentView.wrTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    WRHomeNaviView *naviView = [[WRHomeNaviView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight+44)];
    naviView.naviImage = [UIImage imageNamed:@"preferential_image"];
    [self.view addSubview:naviView];
        
}


@end
