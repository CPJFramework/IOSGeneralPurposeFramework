//
//  CPJFilter.m
//  CPJFilter
//
//  Created by shuaizhai on 3/21/16.
//  Copyright © 2016 pcx. All rights reserved.
//

#import "CPJFilter.h"


typedef void (^LoginCompletion)(BOOL);
typedef void (^FinishAnimation)(id);

@interface CPJFilter (){
    LoginCompletion loginCompletion;
    NSString        *vcID;
    NSDictionary    *vcDict;
    BOOL            pushType;
    UINavigationController *vcPvc;
    FinishAnimation finishAnimationCompletion;
    
}



@end

@implementation CPJFilter

+ (instancetype)shareInstance{
    static CPJFilter *filter;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        filter = [[[self class] alloc] init];
        filter.storyboardName = @"Main";
        [filter configViewControllerTable];
    });
    return filter;
}

// overwrite
//
- (void)configViewControllerTable{

}

// overwrite
//
- (BOOL)hasLogin{
    
    return NO;
}

// overwrite
//
- (void)loginWithCompletion:(void (^)(BOOL))completion{
    loginCompletion = completion;

}

- (void)setLoginSuccess:(BOOL)loginSuccess{
    _loginSuccess = loginSuccess;
    if(loginCompletion){
        
        if(loginSuccess){
            if(vcID!=nil){
                if(pushType){
                    [self pushViewControllerWithID:vcID withParentVC:vcPvc withValueDict:vcDict completion:finishAnimationCompletion];
                    vcID = nil;
                }else{
                    [self presentViewControllerWithID:vcID withParentVC:vcPvc withStyle:UIModalTransitionStyleCoverVertical withValueDict:vcDict completion:finishAnimationCompletion];
                    vcID = nil;
                }
            }
        }
        loginCompletion(loginSuccess);
    }
}

// overwrite
//
- (void)logout{
    
}

- (void)needLogin{
    [self needLoginWithCompletion:nil];
}

- (void)needLoginWithCompletion:(void (^)(void))completion{
    UINavigationController *pvc = (UINavigationController *)[CPJFilter getTopMostViewController];
    id cla               = loginController;
    UIViewController *vc = nil;
    if([cla isKindOfClass:[NSString class]]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:self.storyboardName bundle:nil];
        vc = [storyboard instantiateViewControllerWithIdentifier:cla];
    }else{
        NSObject *object = [[cla alloc] init];
        if([object isKindOfClass:[UIViewController class]]){
            vc = [[cla alloc] init];
        }
    }
    NSAssert(vc!=nil, @"请设置LoginViewController。");
    if(![self hasLogin]){
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [pvc.visibleViewController presentViewController:nvc animated:YES completion:completion];
    }
}

- (void)setLoginVCWithClass:(Class)cla{
    loginController = cla;
}

- (void)setLoginVCWithStoryBoardId:(NSString *)ID{
    loginController = ID;
}

- (void)needLoginWhenAppStartUp:(UIViewController *)viewController{
    if(![self hasLogin])
        [self needLogin];
    else{
        [self setMainViewController:viewController];
    }
}

- (void)pushViewControllerWithID:(NSString *)viewControllerID withParentVC:(UINavigationController *)pvc withValueDict:(NSDictionary *)dict completion:(void (^)(id))completion{
    
    NSArray *array = [self.viewControllerTable objectForKey:viewControllerID];
    NSAssert(array.count == 2, @"configViewControllerTable发生错误！正确方式如：@[[TempViewController class],@YES]");
    NSAssert(![[array firstObject] isKindOfClass:[NSNumber class]], @"configViewControllerTable发生错误！正确方式如：@[[TempViewController class],@YES]");
    BOOL needCheckLogin  = [[array lastObject] boolValue];
    
    UIViewController *vc = [self createViewControllerWithID:viewControllerID withValueDict:dict];
    if(needCheckLogin && ![self hasLogin]){
        [self needLogin];
        vcID = viewControllerID;
        vcDict = dict;
        finishAnimationCompletion = completion;
        pushType = YES;
        vcPvc = pvc;
        return;
    }
    [pvc pushViewController:vc animated:YES];
    if(completion!=nil){
        completion(vc);
    }
}

- (void)pushViewControllerWithID:(NSString *)viewControllerID withValueDict:(NSDictionary *)dict completion:(void (^)(id))completion{
    vcID = nil;
    UINavigationController *pvc = (UINavigationController *)[CPJFilter getTopMostViewController];
    [self pushViewControllerWithID:viewControllerID withParentVC:pvc withValueDict:dict completion:completion];
}

- (id)presentViewControllerWithID:(NSString *)viewControllerID withParentVC:(UINavigationController *)pvc withStyle:(UIModalTransitionStyle)style withValueDict:(NSDictionary *)dict completion:(void (^)(id viewController))completion{
    NSArray *array = [self.viewControllerTable objectForKey:viewControllerID];
    NSAssert(array.count == 2, @"configViewControllerTable发生错误！正确方式如：@[[TempViewController class],@YES]");
    NSAssert(![[array firstObject] isKindOfClass:[NSNumber class]], @"configViewControllerTable发生错误！正确方式如：@[[TempViewController class],@YES]");
    BOOL needCheckLogin  = [[array lastObject] boolValue];
    
    UIViewController *vc = [self createViewControllerWithID:viewControllerID withValueDict:dict];
    if(needCheckLogin && ![self hasLogin]){
        [self needLogin];
//        vcID = viewControllerID;
//        vcDict = dict;
//        finishAnimationCompletion = completion;
//        pushType = NO;
//        vcPvc = pvc;
        return nil;
    }
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalTransitionStyle = style;
    [pvc.topViewController presentViewController:nav animated:YES completion:nil];
    if(completion!=nil){
        completion(vc);
    }
    return vc;
}

- (id)presentViewControllerWithID:(NSString *)viewControllerID withModalStyle:(UIModalTransitionStyle)style withValueDict:(NSDictionary *)dict{
    vcID = nil;
    UINavigationController *pvc = (UINavigationController *)[CPJFilter getTopMostViewController];
    return [self presentViewControllerWithID:viewControllerID withParentVC:pvc withStyle:style withValueDict:dict completion:nil];
}

- (void)setMainViewController:(UIViewController *)viewController{
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[[UIApplication sharedApplication] delegate] setWindow:window];
    window.rootViewController = viewController;
    [window makeKeyAndVisible];
}

- (id)createViewControllerWithID:(NSString *)viewControllerID withValueDict:(NSDictionary *)dict{
    
    NSArray *array = [self.viewControllerTable objectForKey:viewControllerID];
    id cla               = [array firstObject];
    UIViewController *vc = nil;
    if([cla isKindOfClass:[NSString class]]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:self.storyboardName bundle:nil];
        vc = [storyboard instantiateViewControllerWithIdentifier:cla];
    }else{
        NSObject *object = [[cla alloc] init];
        if([object isKindOfClass:[UIViewController class]]){
            vc = [[cla alloc] init];
        }
    }
    return vc;
}


+ (UIViewController*) getTopMostViewController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    for (UIView *subView in [window subviews])
    {
        UIResponder *responder = [subView nextResponder];
        
        //added this block of code for iOS 8 which puts a UITransitionView in between the UIWindow and the UILayoutContainerView
        if ([responder isEqual:window])
        {
            //this is a UITransitionView
            if ([[subView subviews] count])
            {
                UIView *subSubView = [subView subviews][0]; //this should be the UILayoutContainerView
                responder = [subSubView nextResponder];
            }
        }
        
        if([responder isKindOfClass:[UIViewController class]]) {
            return [self topViewController: (UIViewController *) responder];
        }
    }
    
    return nil;
}

+ (UIWindow *) getNormalLevelWindow{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    return window;
}

+ (UIViewController *) topViewController: (UIViewController *) controller
{
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}

@end
