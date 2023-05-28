//
//  WRHomeBannerView.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/11.
//

#import "WRHomeBannerView.h"
#import <SDCycleScrollView.h>

@interface WRHomeBannerView()<SDCycleScrollViewDelegate>
@property(nonatomic, strong)SDCycleScrollView *cycleScrollView;
@end

@implementation WRHomeBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleScrollView];
    }
    return self;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _cycleScrollView.localizationImageNamesGroup = @[@"banner_01.jpg",@"banner_01.jpg"];
    }
    return _cycleScrollView;
}


@end
