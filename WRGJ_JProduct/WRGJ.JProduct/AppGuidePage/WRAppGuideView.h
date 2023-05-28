//
//  WRAppGuideView.h
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WRAppGuideView : UIView

// 选中page的指示器颜色，默认白色
@property (nonatomic, strong) UIColor *currentColor;

// 其他状态下的指示器的颜色，默认
@property (nonatomic, strong) UIColor *nomalColor;

+ (instancetype)sharedWithImages:(NSArray *)imageNames;

@end
NS_ASSUME_NONNULL_END
