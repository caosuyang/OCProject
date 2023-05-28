//
//  WRToolAction.h
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WRToolAction : NSObject



+ (instancetype)shareAction;
/**
 *      Label自适应
 */

- (CGFloat)adaptiveTextWidth:(NSString *)text textFont:(UIFont *)font;

- (CGFloat)adaptiveTextHeight:(NSString *)text textFont:(UIFont *)font textWidth:(CGFloat)width;



@end

NS_ASSUME_NONNULL_END
