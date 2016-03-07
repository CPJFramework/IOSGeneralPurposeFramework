//
//  CPJBaseLoadingComponent.m
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/25/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "CPJBaseLoadingComponent.h"
#import "MBProgressHUD.h"
#import "CPJViewController.h"

@implementation CPJBaseLoadingComponent

- (void)showLoadingViewToVC:(CPJViewController *)viewController withTitle:(NSString *)title{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewController.loadingGlanceView animated:YES];
    hud.labelText = title;
}

- (void)showLoadingViewToUIVC:(UIViewController *)viewController withTitle:(NSString *)title{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    hud.labelText = title;
}

- (void)hideLoadingViewFromVC:(CPJViewController *)viewController{
    [MBProgressHUD hideAllHUDsForView:viewController.loadingGlanceView animated:YES];
}

- (void)hideLoadingViewFromUIVC:(UIViewController *)viewController{
    [MBProgressHUD hideAllHUDsForView:viewController.view animated:YES];
}

- (void)showGlanceViewToVC:(CPJViewController *)viewController withTitle:(NSString *)title withCallBack:(void (^)())callback;{
    [self showGlanceViewToVC:viewController withTitle:title withTime:1.5 withCallBack:callback];
}

- (void)showGlanceViewToVC:(CPJViewController *)viewController withTitle:(NSString *)title withTime:(NSInteger)time withCallBack:(void (^)())callback;{
    static BOOL isShowing= NO;
    if(isShowing)
        return;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewController.loadingGlanceView animated:YES];
    isShowing = YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:viewController.loadingGlanceView animated:YES];
        isShowing = NO;
        if(callback)
            callback();
    });
}

- (void)showGlanceViewToUIVC:(UIViewController *)viewController withTitle:(NSString *)title withCallBack:(void (^)())callback;{
    [self showGlanceViewToUIVC:viewController withTitle:title withTime:1.5 withCallBack:callback];
}

- (void)showGlanceViewToUIVC:(UIViewController *)viewController withTitle:(NSString *)title withTime:(NSInteger)time withCallBack:(void (^)())callback;{
    static BOOL isShowing= NO;
    if(isShowing)
        return;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    isShowing = YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:viewController.view animated:YES];
        isShowing = NO;
        if(callback)
            callback();
    });
}


@end
