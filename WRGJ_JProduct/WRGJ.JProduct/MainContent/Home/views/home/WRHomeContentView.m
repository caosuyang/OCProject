//
//  WRHomeContentView.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/9.
//

#import "WRHomeContentView.h"
#import "WRHomeBannerView.h"
#import "WRClassificationView.h"
#import "CKSlideMenu.h"
#import "WRDelicateRCMCell.h"
#import "WRDelicateCell.h"
#define magin 18
@interface WRHomeContentView()<UITableViewDelegate, UITableViewDataSource,CKSlideMenuDelegate>
@property(nonatomic, strong)UIView *slidBody;
@property(nonatomic, assign)NSInteger currentIndex;
@end

@implementation WRHomeContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentIndex = 0;
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.wrTableView];
    }
    return self;
}

- (UITableView *)wrTableView {
    if (!_wrTableView) {
        _wrTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    }
    _wrTableView.delegate = self;
    _wrTableView.dataSource = self;
    _wrTableView.sectionHeaderHeight = 0;
    _wrTableView.sectionFooterHeight = 0;
    _wrTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _wrTableView.showsVerticalScrollIndicator = NO;
    return _wrTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 5;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }else {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    [self createCell:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void)createCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:246.0/255.0 alpha:1];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight+44+0.15*kScreenWidth)];
        imageView.image = [UIImage imageNamed:@"head_bg_image"];
        [cell.contentView addSubview:imageView];
        
        WRHomeBannerView *bannerView = [[WRHomeBannerView alloc]initWithFrame:CGRectMake(magin, kNavBarHeight+48, self.frame.size.width-2*magin, 0.4*kScreenWidth)];
        bannerView.layer.cornerRadius = 10;
        bannerView.layer.masksToBounds = YES;
        bannerView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:bannerView];
        
        UIView *noticeView = [[UIView alloc]initWithFrame:CGRectMake(magin, CGRectGetMaxY(bannerView.frame)+10, kScreenWidth-2*magin, 0.1*kScreenWidth)];
        noticeView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:238.0/255.0 blue:224.0/255.0 alpha:1];
        noticeView.layer.cornerRadius = 10;
        noticeView.layer.masksToBounds = YES;
        [cell.contentView addSubview:noticeView];
        
        UIImageView *hornImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.03*kScreenWidth, 0.02*kScreenWidth, 0.06*kScreenWidth, 0.06*kScreenWidth)];
        hornImage.image = [UIImage imageNamed:@"home_horn_icon"];
        [noticeView addSubview:hornImage];
        
        WRClassificationView *classificationView = [[WRClassificationView alloc]initWithFrame:CGRectMake(magin, CGRectGetMaxY(noticeView.frame)+10, kScreenWidth-2*magin, 0.5*kScreenWidth)];
        [cell.contentView addSubview:classificationView];
    }else if (indexPath.section == 1) {
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.15*kScreenWidth)];
        titleView.backgroundColor = [UIColor whiteColor];
        [self setTheRoundedCorners:titleView];
        [cell.contentView addSubview:titleView];

        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(magin, 0.06*kScreenWidth, 0.065*kScreenWidth, 0.065*kScreenWidth)];
        imageV.image = [UIImage imageNamed:@"home_supplier_title_icon"];
        [titleView addSubview:imageV];

        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageV.frame)+5, CGRectGetMinY(imageV.frame), 0.5*kScreenWidth, 0.065*kScreenWidth)];
        titleLabel.text = @"精选供应商";
        titleLabel.font = [UIFont systemFontOfSize:0.045*kScreenWidth];
        [titleView addSubview:titleLabel];
    }else {
        if (self.currentIndex == 0) {
            WRDelicateRCMCell *RCMCell = [[WRDelicateRCMCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth+30)];
            [cell.contentView addSubview:RCMCell];
        }else {
            WRDelicateCell *delicateCell = [[WRDelicateCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth+30)];
            [cell.contentView addSubview:delicateCell];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kScreenWidth+kNavBarHeight+80;
    }else if (indexPath.section == 1) {
        return 0.15*kScreenWidth;
    }else {
        if (self.currentIndex == 0) {
            return kScreenWidth+30;
        }else {
            return (kScreenWidth-4*magin-20)/3+0.2*kScreenWidth+74;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 0.1*kScreenWidth;
    }else {
        return 0.01;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    if (section == 2) {
        CKSlideMenu *slideMenu = [[CKSlideMenu alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1*kScreenWidth) titles:@[@"推荐",@"陶瓷",@"密胺",@"玻璃制品",@"不锈钢",@"厨房",@"等等"] controllers:nil];
        slideMenu.backgroundColor = [UIColor whiteColor];
        slideMenu.delegate = self;
        slideMenu.showLine = YES;
        slideMenu.indicatorStyle = SlideMenuIndicatorStyleStretch;
        slideMenu.selectedColor = [UIColor blackColor];
        slideMenu.unselectedColor = [UIColor grayColor];
        slideMenu.indicatorColor = [UIColor colorWithRed:253.0/255.0 green:184.0/255.0 blue:47.0/255.0 alpha:1];
        slideMenu.lazyLoad = YES;
        slideMenu.indicatorHeight = 5;
        slideMenu.indicatorOffsety = 5;
        slideMenu.font = [UIFont systemFontOfSize:0.04*kScreenWidth];
        slideMenu.currentIndex = self.currentIndex;
        [view addSubview:slideMenu];
    }
    return view;
}

- (void)menuSelectIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    self.currentIndex = index;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [self.wrTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)setTheRoundedCorners:(UIView *)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(20,20)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollViewDragValueChage" object:[NSString stringWithFormat:@"%f",offsetY]];
    
    CGFloat height = kStatusBarHeight;//height是正的就是向下偏移 正负代表了方向
    if (scrollView.contentOffset.y <= 0.1*kScreenWidth && scrollView.contentOffset.y >= 0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//有的介绍是 UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);但是我实验在项目中刷新会有点问题
    }
    else if (scrollView.contentOffset.y >= 0.1*kScreenWidth)
    {
        //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦 其实这个位置可以更大一些 只要你能确定顶部的高度
        scrollView.contentInset = UIEdgeInsetsMake(0.1*kScreenWidth+height, 0, 0, 0);
    }
}
@end
