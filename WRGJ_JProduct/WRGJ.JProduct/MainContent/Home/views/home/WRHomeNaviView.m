//
//  WRHomeNaviView.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/9.
//

#import "WRHomeNaviView.h"
#import "WRHomeNaviItem.h"
#import <UIView+SDExtension.h>

#define magin 18

@interface WRHomeNaviView()

@property(nonatomic, strong)UIImageView *naviImageView;
@property(nonatomic, strong)WRHomeNaviItem *itemOne;
@property(nonatomic, strong)WRHomeNaviItem *itemTwo;
@property(nonatomic, strong)UITextField *wrTextField;
@property(nonatomic, strong)UIView *searchView;
@property(nonatomic, strong)UIView *searchBackView;
@property(nonatomic, strong)UIView *naviView;
@property(nonatomic, strong)UIButton *leftBtn;
@property(nonatomic, strong)UIButton *rightBtn;

@end

@implementation WRHomeNaviView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createNotice];
        [self createUIWithFrame:frame];
    }
    return self;
}

- (void)createNotice {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollViewDragValueChage:) name:@"scrollViewDragValueChage" object:nil];
}

- (void)scrollViewDragValueChage:(NSNotification *)notice {
    NSString *number = notice.object;
    NSLog(@"%@",number);
    CGFloat numerical = [number floatValue];
    CGFloat textWidth = (self.frame.size.width-magin*2)-numerical*2;
    CGFloat imageAlpha;
    CGFloat viewAlpha;
    if (numerical>=0 && numerical<=20) {
        textWidth = (self.frame.size.width-magin*2)-numerical*5;
        viewAlpha = numerical/50;
    }else if (numerical<0){
        textWidth = (self.frame.size.width-magin*2);
        viewAlpha = 0;
    }else {
        textWidth = (self.frame.size.width-magin*2)-100;
        viewAlpha = 1;
    }
    
    CGFloat searchY = kNavBarHeight;
    if (numerical>=0 && numerical<=44) {
        searchY = kNavBarHeight-numerical;
        imageAlpha = (25-numerical)/25;
    }else if (numerical < 0 ){
        imageAlpha = 1;
        searchY = kNavBarHeight;
    }else {
        searchY = kStatusBarHeight;
        imageAlpha = 0;
    }
    
    self.naviImageView.alpha = imageAlpha;
    self.wrTextField.frame = CGRectMake(magin, 7, textWidth, 30);
    self.searchView.frame = CGRectMake(0, searchY, self.frame.size.width, 44);
    self.searchBackView.frame = CGRectMake(0, searchY, textWidth+magin, 44);
    
    if (numerical<=0) {
        self.searchView.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:180.0/255.0 blue:108.0/255.0 alpha:0];
        self.naviView.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:180.0/255.0 blue:108.0/255.0 alpha:0];
    }else {
        self.searchView.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:180.0/255.0 blue:108.0/255.0 alpha:1];
        self.naviView.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:180.0/255.0 blue:108.0/255.0 alpha:1];
    }
    
    self.sd_height = kNavBarHeight;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"scrollViewDragValueChage" object:nil];
}

- (void)createUIWithFrame:(CGRect)frame {
    
//    self.backgroundColor = [UIColor orangeColor];
    
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, frame.size.width, 44)];
    self.searchView.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:180.0/255.0 blue:108.0/255.0 alpha:0];
    [self addSubview:self.searchView];
    
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, kNavBarHeight)];
    self.naviView.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:180.0/255.0 blue:108.0/255.0 alpha:0];
    [self addSubview:self.naviView];
    [self bringSubviewToFront:self.naviView];
    
    [self.naviView addSubview:self.naviImageView];
    [self.naviView addSubview:self.itemOne];
    [self.naviView addSubview:self.itemTwo];
    
    self.searchBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, frame.size.width, 44)];
    [self addSubview:self.searchBackView];
    [self.searchBackView addSubview:self.wrTextField];
}

- (UIImageView *)naviImageView {
    if (!_naviImageView) {
        _naviImageView = [[UIImageView alloc]init];
    }
    return _naviImageView;
}

-(void)setNaviImage:(UIImage *)naviImage {
    self.naviImageView.image = naviImage;
    CGFloat imageWdth = 40*naviImage.size.width/naviImage.size.height;
    self.naviImageView.frame = CGRectMake(15, kStatusBarHeight, imageWdth, 40);
}

- (WRHomeNaviItem *)itemOne {
    if (!_itemOne) {
        _itemOne = [[WRHomeNaviItem alloc]initWithFrame:CGRectMake(self.frame.size.width-60, kStatusBarHeight+6, 50, 30)];
        [_itemOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [_itemOne setImage:[UIImage imageNamed:@"bar_contact_icon"] forState:UIControlStateNormal];
        _itemOne.imageSize = CGSizeMake(16, 16);
        _itemOne.titleLabel.font = [UIFont systemFontOfSize:8];
    }
    return _itemOne;
}

- (WRHomeNaviItem *)itemTwo {
    if (!_itemTwo) {
        _itemTwo = [[WRHomeNaviItem alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.itemOne.frame)-50, CGRectGetMinY(self.itemOne.frame), 50, 30)];
        [_itemTwo setTitle:@"会员中心" forState:UIControlStateNormal];
        [_itemTwo setImage:[UIImage imageNamed:@"bar_members_icon"] forState:UIControlStateNormal];
        _itemTwo.imageSize = CGSizeMake(18, 18);
        _itemTwo.titleLabel.font = [UIFont systemFontOfSize:8];
    }
    return _itemTwo;
}

-(UITextField *)wrTextField {
    if (!_wrTextField) {
        _wrTextField = [[UITextField alloc]initWithFrame:CGRectMake(magin, 7, self.frame.size.width-magin*2, 30)];
        _wrTextField.layer.cornerRadius = 15;
        _wrTextField.layer.masksToBounds = YES;
        _wrTextField.backgroundColor = [UIColor whiteColor];
        _wrTextField.placeholder = @"五星级酒店的标准";
        _wrTextField.font = [UIFont systemFontOfSize:12];
        _wrTextField.textAlignment = NSTextAlignmentCenter;
        _wrTextField.enabled = NO;
        _wrTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
                
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
//        leftView.backgroundColor = [UIColor redColor];
        [leftView addSubview:self.leftBtn];
        _wrTextField.leftViewMode = UITextFieldViewModeAlways;
        _wrTextField.leftView = leftView;
        
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        [rightView addSubview:self.rightBtn];
        _wrTextField.rightViewMode = UITextFieldViewModeAlways;
        _wrTextField.rightView = rightView;
        
        
    }
    return _wrTextField;
}

-(UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(10, 0, 40, 30);
        [_leftBtn setTitle:@"上海" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = SmallFont;
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClcik:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (void)leftBtnClcik:(UIButton *)btn {
    NSLog(@"被点击了");
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(20, 0, 30, 30);
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"home_camera_icon"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnClcik:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (void)rightBtnClcik:(UIButton *)btn {
    
}
@end
