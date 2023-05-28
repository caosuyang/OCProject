//
//  WRHomeNaviItem.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/9.
//

#import "WRHomeNaviItem.h"

@implementation WRHomeNaviItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect frame = contentRect;
    frame.origin.x = self.frame.size.width/2 - frame.size.width/2;
    frame.origin.y = self.frame.size.height/3*2;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height/3;
    return frame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect frame = contentRect;
    frame.origin.x = (self.frame.size.width-self.imageSize.width)/2;
    frame.origin.y = 0;
    frame.size.width = self.imageSize.width;
    frame.size.height = self.imageSize.height;
    return frame;
}

@end
