//
//  CPJLoadingComponentProtocal.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/25/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#ifndef IOSGeneralPurposeModule_CPJLoadingComponentProtocal_h
#define IOSGeneralPurposeModule_CPJLoadingComponentProtocal_h
#import <UIKit/UIKit.h>
//#import "CPJViewController.h"
@class CPJViewController;
@protocol CPJLoadingComponentProtocal <NSObject>

- (void)showLoadingViewToVC:(CPJViewController *)view withTitle:(NSString *)title;
- (void)showLoadingViewToUIVC:(UIViewController *)view withTitle:(NSString *)title;

- (void)hideLoadingViewFromVC:(CPJViewController *)view;
- (void)hideLoadingViewFromUIVC:(UIViewController *)view;

/**
 * 闪屏提示
 */
- (void)showGlanceViewToVC:(CPJViewController *)view withTitle:(NSString *)title withCallBack:(void (^)())callback;

- (void)showGlanceViewToUIVC:(UIViewController *)view withTitle:(NSString *)title withCallBack:(void (^)())callback;

/**
 * 闪屏提示
 */
- (void)showGlanceViewToVC:(CPJViewController *)view withTitle:(NSString *)title withTime:(NSInteger)time withCallBack:(void (^)())callback;

- (void)showGlanceViewToUIVC:(UIViewController *)view withTitle:(NSString *)title withTime:(NSInteger)time withCallBack:(void (^)())callback;

@end

#endif
