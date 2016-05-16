//
//  CPJFilterProtocol.h
//  CPJFilter
//
//  Created by shuaizhai on 3/21/16.
//  Copyright © 2016 pcx. All rights reserved.
//

#ifndef CPJFilterProtocol_h
#define CPJFilterProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CPJADD_NEED_LOGIN_VC(ID, viewController)\
    ID:@[[viewController class], @YES],

#define CPJADD_NEED_LOGIN_STORYBOARD_VC(ID, viewControllerID)\
    ID:@[viewControllerID, @YES],

#define CPJADD_VC(ID, viewController)\
    ID:@[[viewController class], @NO],

#define CPJADD_STORYBOARD_VC(ID, viewControllerID)\
    ID:@[viewControllerID, @NO],

@protocol CPJFilterProtocol <NSObject>

/**
 *
 */
- (void)configViewControllerTable;

- (void)pushViewControllerWithID:(NSString *)viewControllerID withValueDict:(NSDictionary *)dict completion:(void (^)(id viewController))completion;

- (id)presentViewControllerWithID:(NSString *)viewControllerID withModalStyle:(UIModalTransitionStyle)style withValueDict:(NSDictionary *)dict;

- (BOOL)hasLogin;

- (void)needLogin;

- (void)needLoginWithCompletion:(void (^)(void))completion;

- (void)logout;

- (void)loginWithCompletion:(void (^)(BOOL loginSuccess))completion;

- (void)setLoginVCWithStoryBoardId:(NSString *)ID;

- (void)setLoginVCWithClass:(Class)cla;

- (void)setMainViewController:(UIViewController *)viewController;

- (void)needLoginWhenAppStartUp:(UIViewController *)viewController;

+ (UIViewController*) getTopMostViewController;

+ (UIViewController *) topViewController: (UIViewController *) controller;





@end


#endif /* CPJFilterProtocol_h */
