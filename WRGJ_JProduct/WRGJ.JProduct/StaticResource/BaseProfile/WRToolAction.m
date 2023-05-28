//
//  WRToolAction.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/12.
//

#import "WRToolAction.h"

@implementation WRToolAction

static WRToolAction *shareAction = nil;
+ (instancetype)shareAction{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareAction = [[self alloc] init];
    });
    return shareAction;
}

/**
 *      Label自适应
 */
- (CGFloat)adaptiveTextWidth:(NSString *)text textFont:(UIFont *)font {
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil]];
    CGFloat width = size.width;
    return width;
}

- (CGFloat)adaptiveTextHeight:(NSString *)text textFont:(UIFont *)font textWidth:(CGFloat)width {
    NSDictionary *dic = @{NSFontAttributeName: font};
    CGFloat height = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}



@end
