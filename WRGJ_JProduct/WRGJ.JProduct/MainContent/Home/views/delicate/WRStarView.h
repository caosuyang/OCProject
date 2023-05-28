//
//  WRStarView.h
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol WRStarViewDelegate <NSObject>

- (void)didChangeStar;

@end

@interface WRStarView : UIView

@property (nonatomic, assign) CGFloat fullScore; //评分的满分值，默认为1
@property (nonatomic, assign) CGFloat actualScore; //评分的实际分数，默认为1
@property (nonatomic, assign) BOOL isContrainsHalfStar; //是否包含半颗星，默认为NO
@property (nonatomic, weak) id<WRStarViewDelegate> delegate;

//下面这个函数中的参数numberOfStars是我们总共的星级数,满分是几颗星，isVariable代表是否可以修改星级
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars isVariable:(BOOL)isVariable;

@end

NS_ASSUME_NONNULL_END
