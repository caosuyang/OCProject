//
//  WPchAction.h
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/9.
//

#ifndef WPchAction_h
#define WPchAction_h


#import "WRRequestAction.h"
#import <UIKit/UIKit.h>
#import "WRToolAction.h"


#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
/**
 * 适配机型
 */
#define isIphoneX_XS (kScreenHeight >= 375.f && kScreenHeight >= 812.f ? YES : NO)

#define isIphoneXR_XSMax (kScreenHeight >= 414.f && kScreenHeight >= 896.f ? YES : NO)

#define isFullScreen (isIphoneX_XS || isIphoneXR_XSMax)

#define kStatusBarHeight (isFullScreen ?44.0f: 20.0f)//状态栏高度

#define kNavBarHeight (isFullScreen ?88.f : 64.f)

#define kTabBarHeight (isFullScreen ?83.0f: 49.0f)//tabar高度
/**
 *      字体大小
 */
#define LargeFont [UIFont systemFontOfSize:0.05*kScreenWidth]
#define BoldLargeFont [UIFont fontWithName:@"Helvetica-Bold" size:0.08*kScreenWidth]

#define BigFont [UIFont systemFontOfSize:0.05*kScreenWidth]
#define BoldBigFont [UIFont fontWithName:@"Helvetica-Bold" size:0.05*kScreenWidth]

#define NormalFont [UIFont systemFontOfSize:0.040*kScreenWidth]
#define BoldNormalFont [UIFont fontWithName:@"Helvetica-Bold" size:0.04*kScreenWidth]

#define SmallFont [UIFont systemFontOfSize:0.035*kScreenWidth]
#define BoldSmallFont [UIFont fontWithName:@"Helvetica-Bold" size:0.035*kScreenWidth]

#endif /* WPchAction_h */
