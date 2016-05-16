//
//  CPJFilter.h
//  CPJFilter
//
//  Created by shuaizhai on 3/21/16.
//  Copyright © 2016 pcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CPJFilterProtocol.h"


@interface CPJFilter : NSObject<CPJFilterProtocol>{
    id loginController;
}

@property (nonatomic)NSDictionary *viewControllerTable;

@property (nonatomic)NSString     *storyboardName;

@property (nonatomic, assign)BOOL loginSuccess;

+ (instancetype)shareInstance;

/**
 *  在子类中重写这个方法。
 *  - (void)configViewControllerTable{
 *      self.storyboardName = @"Main";
 *      self.viewControllerTable =
 *      @{
 *          CPJADD_VC(TempVieControllerID, TempViewController)
 *          CPJADD_NEED_LOGIN_STORYBOARD_VC(HViewControllerID, @"com.my")
 *       };
 *      [self setLoginVCWithClass:[LoginViewController class]];
 *     }
 */
- (void)configViewControllerTable;

/**
 * 注销方法，在子类中重写该方法。
 *- (void)logout{
 *      [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_id"];
 *      [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"user_name"];
 *      [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
 *      [self needLogin];
 * }
 */
- (void)logout;

/**
 * 登录方法，在子类中重写该方法.
 * - (void)loginWithCompletion:(void (^)(BOOL loginSuccess))completion{
 *      [super loginWithCompletion:completion];
 *      [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"user_id"];
 *      [[NSUserDefaults standardUserDefaults] setObject:@"jim" forKey:@"user_name"];
 *      [[NSUserDefaults standardUserDefaults] setObject:@"wer0ids0cojclvknj" forKey:@"token"];
 *      self.loginSuccess = YES;
 * }
 */
- (void)loginWithCompletion:(void (^)(BOOL loginSuccess))completion NS_REQUIRES_SUPER;

/**
 * 判断是否已经登录，在子类中重写.
 * - (BOOL)hasLogin{
 *      if([[[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"] isEqualToString:@""] || [[[NSUserDefaults standardUserDefaults] stringForKey:@"user_name"] isEqualToString:@""] || [[[NSUserDefaults standardUserDefaults] stringForKey:@"token"] isEqualToString:@""]){
 *      return NO;
 *      }
 *  return YES;
 *  }
 */
- (BOOL)hasLogin;

- (void)pushViewControllerWithID:(NSString *)viewControllerID withValueDict:(NSDictionary *)dict completion:(void (^)(id viewController))completion;

- (id)presentViewControllerWithID:(NSString *)viewControllerID withModalStyle:(UIModalTransitionStyle)style withValueDict:(NSDictionary *)dict;

- (void)needLogin;

- (void)needLoginWithCompletion:(void (^)(void))completion;

- (void)setLoginVCWithStoryBoardId:(NSString *)ID;

- (void)setLoginVCWithClass:(Class)cla;

- (void)setMainViewController:(UIViewController *)viewController;

/**
 * App启动后检查是否需要登录
 * 再AppDelegate中调用
 * - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 *      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[MyFilter shareInstance].storyboardName bundle:nil];
 *      UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"com.main"];
 *      [[MyFilter shareInstance] needLoginWhenAppStartUp:vc];
 *      return YES;
 *  }
 */
- (void)needLoginWhenAppStartUp:(UIViewController *)viewController;

+ (UIViewController*) getTopMostViewController;

+ (UIViewController *) topViewController: (UIViewController *) controller;

@end
