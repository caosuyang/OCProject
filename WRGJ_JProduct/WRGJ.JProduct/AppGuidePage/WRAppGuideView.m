//
//  WRAppGuideView.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/6.
//

#import "WRAppGuideView.h"

@interface WRAppGuideView()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *launchScrollView;

@property(nonatomic, strong)UIPageControl *page;

@end

@implementation WRAppGuideView
NSArray *images;
static WRAppGuideView *guideView = nil;

+ (instancetype)sharedWithImages:(NSArray *)imageNames {
    images = imageNames;
    guideView = [[WRAppGuideView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    guideView.backgroundColor = [UIColor whiteColor];
    return guideView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addObserver:self forKeyPath:@"currentColor" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"nomalColor" options:NSKeyValueObservingOptionNew context:nil];
        
        UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
        [window addSubview:self];
        [self createScrollView];
    }
    return self;
}

//创建scrollView
- (void)createScrollView {
    
    self.launchScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.launchScrollView.showsHorizontalScrollIndicator = NO;
    self.launchScrollView.bounces = NO;
    self.launchScrollView.pagingEnabled = YES;
    self.launchScrollView.delegate = self;
    self.launchScrollView.contentSize = CGSizeMake(kScreenWidth * images.count, kScreenHeight);
    [self addSubview:self.launchScrollView];
    
    NSLog(@"--images--%@",images);
    
    NSArray *titleArray = @[@"一站式采购",@"定制服务",@"平台保障"];
    NSArray *detailArray = @[@"10000+优质商品",@"200+直营店铺在线服务",@"16年企业平台保驾护航"];
    for (int i = 0; i < images.count ; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, 0.7*kScreenHeight)];
        imageView.image = [UIImage imageNamed:images[i]];
        imageView.contentMode = UIViewContentModeScaleToFill;
    
        //获取本地图片的size
//        CGSize imageSize = [UIImage imageNamed:images[i]].size;
//        imageView.frame = CGRectMake(i*kScreenWidth, 0, kScreenWidth, imageSize.height*kScreenWidth/imageSize.width);
        [self.launchScrollView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*kScreenWidth, CGRectGetMaxY(imageView.frame)+15, kScreenWidth, 40)];
        titleLabel.text = titleArray[i];
        titleLabel.textColor = [UIColor colorWithRed:82.0/255.0 green:141.0/255.0 blue:244.0/255.0 alpha:1];
        titleLabel.font = [UIFont boldSystemFontOfSize:0.06*kScreenWidth];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.launchScrollView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(i*kScreenWidth, CGRectGetMaxY(titleLabel.frame), kScreenWidth, 30)];
        detailLabel.text = detailArray[i];
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.font = [UIFont boldSystemFontOfSize:0.03*kScreenWidth];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        [self.launchScrollView addSubview:detailLabel];
        
        if (i == images.count - 1) {
            UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            enterBtn.frame = CGRectMake((i+0.25)*kScreenWidth, CGRectGetMaxY(detailLabel.frame)+0.05*kScreenWidth, 0.5*kScreenWidth, 0.1*kScreenWidth);
            [enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            enterBtn.layer.cornerRadius = 0.05*kScreenWidth;
            enterBtn.layer.masksToBounds = YES;
            [enterBtn setTitle:@"立即体验" forState:UIControlStateNormal];
            enterBtn.titleLabel.font = [UIFont systemFontOfSize:0.035*kScreenWidth];
            enterBtn.backgroundColor = [UIColor colorWithRed:194.0/255.0 green:164.0/255.0 blue:98.0/255.0 alpha:1];
            [self.launchScrollView addSubview:enterBtn];
        }
    }
    
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 0.15*kScreenWidth, kScreenWidth, 30)];
    self.page.numberOfPages = images.count;
    self.page.backgroundColor = [UIColor clearColor];
    self.page.currentPage = 0;
    self.page.defersCurrentPageDisplay = YES;
    [self addSubview:self.page];
    
}
//点击立即体验按钮--删除导图
- (void)enterBtnClick:(UIButton *)btn {
    [self hideGuidView];
}

-(void)hideGuidView{
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        strongSelf.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof (weakSelf) strongSelf = weakSelf;
            [strongSelf removeFromSuperview];
        });
    }];
}

#pragma mark - scrollView Delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    int cuttentIndex = (int)(scrollView.contentOffset.x + kScreenWidth/2)/kScreenWidth;
    if (cuttentIndex == images.count - 1) {
        if ([self isScrolltoLeft:scrollView]) {

        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.launchScrollView) {
        int cuttentIndex = (int)(scrollView.contentOffset.x + kScreenWidth/2)/kScreenWidth;
        self.page.currentPage = cuttentIndex;
    }
}

// 判断滚动方向
-(BOOL )isScrolltoLeft:(UIScrollView *) scrollView{
    //返回YES为向左反动，NO为右滚动
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        return YES;
    }else{
        return NO;
    }
}

// KVO监测值的变化
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"currentColor"]) {
        self.page.currentPageIndicatorTintColor = self.currentColor;
    }
    if ([keyPath isEqualToString:@"nomalColor"]) {
        self.page.pageIndicatorTintColor = self.nomalColor;
    }
}

@end
