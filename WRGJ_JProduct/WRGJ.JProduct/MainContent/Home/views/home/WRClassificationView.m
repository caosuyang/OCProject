//
//  WRClassificationView.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/11.
//

#import "WRClassificationView.h"

@implementation WRClassificationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIWithFrame:frame];
    }
    return self;
}

- (void)createUIWithFrame:(CGRect)frame {
    
    NSArray *imageArray = @[@"home_spelllist_icon",@"home_goods_icon",@"home_livefor_icon",@"home_vr_icon"];
    NSArray *titleArray = @[@"拼单求购",@"商品分类",@"直播抢购",@"VR逛万润"];
    NSArray *detailArray = @[@"采购，如此简单",@"一站式解决方案",@"一大波好物来袭",@"身临其境逛市场"];
    CGFloat itemWith = (frame.size.width-10)/2;
    CGFloat itemHeight = (frame.size.height-10)/2;
    for (int i = 0; i < imageArray.count; i++) {
        int col = i%2;
        int row = i/2;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(col*(itemWith+10), row*(itemHeight+10), itemWith, itemHeight)];
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.05*itemWith, 0.2*itemHeight, 0.6*itemHeight, 0.6*itemHeight)];
        titleImage.image = [UIImage imageNamed:imageArray[i]];
        [view addSubview:titleImage];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleImage.frame)+5, CGRectGetMinY(titleImage.frame), 0.9*itemWith-0.2*itemHeight-5, 0.3*itemHeight)];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont boldSystemFontOfSize:0.04*kScreenWidth];
        [view addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(titleLabel.frame), 0.3*itemHeight)];
        detailLabel.text = detailArray[i];
        detailLabel.font = [UIFont systemFontOfSize:0.03*kScreenWidth];
        detailLabel.textColor = [UIColor lightGrayColor];
        [view addSubview:detailLabel];
        
    }
    
}

@end
