//
//  WRRequestAction.h
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^returnValue)(NSDictionary *data, BOOL isSuccess, NSError *error);

@interface WRRequestAction : NSObject

@property(nonatomic, copy)returnValue value;

//单例
+ (instancetype)sharedAction;

//Get请求
- (void)GetReqeustWithURL:(NSString *)url withParametes:(id)parametes valueBlock:(returnValue)value showInView:(BOOL)isShow;

//Post请求
- (void)PostReqeustWithURL:(NSString *)url withParametes:(id)parametes valueBlock:(returnValue)value showInView:(BOOL)isShow;

//PostFormData请求
- (void)PostFormDataWithURL:(NSString *)url withParametes:(id)parametes valueBlock:(returnValue)value showInView:(BOOL)isShow;


@end

NS_ASSUME_NONNULL_END
