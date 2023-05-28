//
//  WRRequestAction.m
//  WRGJ.JProduct
//
//  Created by G G on 2020/11/9.
//

#import "WRRequestAction.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>

@implementation WRRequestAction

static id _action = nil;
+ (instancetype)sharedAction {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _action = [super allocWithZone:zone];
    });
    return _action;
}

//设置请求头
- (void)setRequestHeader:(AFHTTPSessionManager *)manager {
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}
//设置响应
- (void)setResponseHeader:(AFHTTPSessionManager *)manager {
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml",@"text/plain",@"application/rdf+xml",@"text/html",@"text/javascript", nil];
}
//打印参数请求方式
- (void)myParametes:(id)parametes withMethod:(NSString *)method  {
    if (parametes) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:parametes options:NSJSONWritingPrettyPrinted error:nil];
        NSString * parametesStr= [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"__参数__%@",parametesStr);
        NSLog(@"__方式__%@",method);
    }
}
//打印数据
- (void)myData:(id)_data {
    if (_data) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:_data options:NSJSONWritingPrettyPrinted error:nil];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"___data___%@",str);
    }
}
/**
 *  Get请求
 */
- (void)GetReqeustWithURL:(NSString *)url withParametes:(id)parametes valueBlock:(returnValue)value showInView:(BOOL)isShow {
    
    [self myParametes:parametes withMethod:@"Get"];
    __block UIView *myView;
    if (isShow) {
        myView = [self currentView];
    }
    if (myView) {
        [MBProgressHUD showHUDAddedTo:myView animated:YES];
    }
    self.value = value;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setRequestHeader:manager];
    [self setResponseHeader:manager];
    AFJSONResponseSerializer *jsonSer =(AFJSONResponseSerializer*) manager.responseSerializer;
    jsonSer.removesKeysWithNullValues = YES;
    manager.requestSerializer.timeoutInterval = 30;
    NSString * urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"__链接__%@",urlStr);
    __weak typeof (self) weakSelf = self;
    [manager GET:urlStr parameters:parametes progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [strongSelf myData:responseObject];
        if (myView) {
            [MBProgressHUD hideHUDForView:myView animated:YES];
        }
        if (value) {
            NSError *error;
            BOOL isOk;
            if ([responseObject[@"header"][@"returnCode"] integerValue] == 0 ) {
                isOk = YES;
            }else {
                isOk = NO;
            }
            value(responseObject,isOk,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (myView) {
            [MBProgressHUD hideHUDForView:myView animated:YES];
        }
        if (value) {
            value(@{},NO,error);
        }
    }];
}
/**
 *  P0ST请求
*/
- (void)PostReqeustWithURL:(NSString *)url withParametes:(id)parametes valueBlock:(returnValue)value showInView:(BOOL)isShow {
    
    [self myParametes:parametes withMethod:@"Post"];
    __block UIView *myView;
    if (isShow) {
        myView = [self currentView];
    }
    if (myView) {
        [MBProgressHUD showHUDAddedTo:myView animated:YES];
    }
    self.value = value;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setRequestHeader:manager];
    [self setResponseHeader:manager];
    AFJSONResponseSerializer *jsonSer =(AFJSONResponseSerializer*) manager.responseSerializer;
    jsonSer.removesKeysWithNullValues = YES;
    manager.requestSerializer.timeoutInterval = 30;
    NSString * urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
     NSLog(@"__链接__%@",urlStr);
    __weak typeof (self) weakSelf = self;
    [manager POST:urlStr parameters:parametes progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [strongSelf myData:responseObject];
        if (myView) {
            [MBProgressHUD hideHUDForView:myView animated:YES];
        }
        if (value) {
            NSError *error;
            BOOL isOk;
            if ([responseObject[@"header"][@"returnCode"] integerValue] == 0) {
                isOk = YES;
            }else {
                isOk = NO;
            }
            value(responseObject,isOk,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (myView) {
            [MBProgressHUD hideHUDForView:myView animated:YES];
        }
        if (value) {
            if (value) {
                value(@{},NO,error);
            }
        }
    }];
    
}

/**
 *  提交文件
*/
- (void)PostFormDataWithURL:(NSString *)url withParametes:(id)parametes valueBlock:(returnValue)value showInView:(BOOL)isShow {
    
}
//获取当前页面的view
-(UIView *)currentView {
    return [self takeCurrentViewContorller].view;
}
//获取当前控制器
- (UIViewController *)takeCurrentViewContorller {
    UIViewController* currentViewController = [self takeRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                currentViewController = ((UINavigationController *)currentViewController).visibleViewController;
            } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
                currentViewController = ((UITabBarController* )currentViewController).selectedViewController;
            } else {
                break;
            }
        }
    }
    return currentViewController;
}
//获取当前根控制器
- (UIViewController *)takeRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

@end
