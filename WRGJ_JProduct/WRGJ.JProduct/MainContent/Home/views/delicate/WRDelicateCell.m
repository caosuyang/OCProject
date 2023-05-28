//
//  WRDelicateCell.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/12.
//

#import "WRDelicateCell.h"
#import "WRStarView.h"
#define magin 18

@interface WRDelicateCell()
@property(nonatomic, strong)UIImageView *titleImageView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *cerLabel;
@property(nonatomic, strong)WRStarView *starView;
@property(nonatomic, strong)UILabel *scoreLabel;
@property(nonatomic, strong)UIImageView *leftImageView;
@property(nonatomic, strong)UILabel *detailLabel;
@end

@implementation WRDelicateCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(magin, 15, kScreenWidth-2*magin, (kScreenWidth-4*magin-20)/3+0.2*kScreenWidth+56)];
    toolView.layer.cornerRadius = 10;
    toolView.backgroundColor = [UIColor whiteColor];
    toolView.layer.shadowColor = [UIColor blackColor].CGColor;
    toolView.layer.shadowOffset = CGSizeMake(1, 1);
    toolView.layer.shadowOpacity = 0.1f;
    toolView.layer.shadowRadius = 4;
    [self addSubview:toolView];

    [toolView addSubview:self.titleImageView];
    [toolView addSubview:self.titleLabel];
    [toolView addSubview:self.cerLabel];
    [toolView addSubview:self.starView];
    [toolView addSubview:self.scoreLabel];
    [toolView addSubview:self.leftImageView];
    [toolView addSubview:self.detailLabel];
    
    NSArray *imageArray = @[@"item_01.jpg",@"item_02.jpg",@"item_03.jpg"];
    CGFloat itemLength = (kScreenWidth-4*magin-20)/3;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(magin+i*(itemLength+10), CGRectGetMaxY(self.titleImageView.frame)+20, itemLength, itemLength)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        imageView.image = [UIImage imageNamed:imageArray[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [toolView addSubview:imageView];
    }
    
}

- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(magin, magin, 0.2*kScreenWidth, 0.2*kScreenWidth)];
        _titleImageView.image = [UIImage imageNamed:@"title_image.jpg"];
        _titleImageView.layer.cornerRadius = 5;
        _titleImageView.layer.masksToBounds = YES;
        _titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _titleImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
       CGFloat labelWidth = [[WRToolAction shareAction]adaptiveTextWidth:@"永华陶瓷有限公司" textFont:NormalFont];
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(self.titleImageView.frame)+10, CGRectGetMinY(self.titleImageView.frame), labelWidth, 0.06*kScreenWidth);
        _titleLabel.text = @"永华陶瓷有限公司";
        _titleLabel.font = NormalFont;
    }
    return _titleLabel;
}

- (UILabel *)cerLabel {
    if (!_cerLabel) {
        _cerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.85*kScreenWidth-3*magin, CGRectGetMinY(self.titleLabel.frame), 0.15*kScreenWidth, CGRectGetHeight(self.titleLabel.frame))];
        _cerLabel.text = @"已认证";
        _cerLabel.layer.masksToBounds = YES;
        _cerLabel.layer.cornerRadius = 5;
        _cerLabel.textColor = [UIColor colorWithRed:103.0/255.0 green:135.0/255.0 blue:161.0/255.0 alpha:1];
        _cerLabel.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        _cerLabel.font = [UIFont systemFontOfSize:0.03*kScreenWidth];
        _cerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cerLabel;
}

- (WRStarView *)starView {
    if (!_starView) {
        _starView = [[WRStarView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame)+8, 0.23*kScreenWidth, 0.05*kScreenWidth) numberOfStars:5 isVariable:NO];
        _starView.actualScore = 4.5;
        _starView.fullScore = 5;
        _starView.isContrainsHalfStar = YES;
    }
    return _starView;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.starView.frame)+5, CGRectGetMinY(self.starView.frame), 0.3*kScreenWidth, CGRectGetHeight(self.starView.frame))];
        _scoreLabel.text = @"4.5分";
        _scoreLabel.textColor = [UIColor colorWithRed:203.0/255.0 green:26.0/255.0 blue:32.0/255.0 alpha:1];
        _scoreLabel.font = [UIFont systemFontOfSize:0.03*kScreenWidth];
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _scoreLabel;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.starView.frame)+8, 0.04*kScreenWidth, 0.04*kScreenWidth)];
        _leftImageView.image = [UIImage imageNamed:@"location_icon"];
    }
    return _leftImageView;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+8, CGRectGetMinY(self.leftImageView.frame), 0.5*kScreenWidth, CGRectGetHeight(self.leftImageView.frame))];
        _detailLabel.text = @"距您约1.7km";
        _detailLabel.font = SmallFont;
        _detailLabel.textColor = [UIColor lightGrayColor];
    }
    return _detailLabel;
}

- (void)setTheRoundedCorners:(UIView *)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10,10)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}


@end
