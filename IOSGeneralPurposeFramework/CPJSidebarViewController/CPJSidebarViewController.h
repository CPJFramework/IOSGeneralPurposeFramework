//
//  CPJSidebarViewController.h
//  CPJSidebarViewController
//
//  Created by shuaizhai on 3/2/16.
//  Copyright © 2016 shuaizhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPJSidebarDelegate <NSObject>

- (void)leftViewControllerOpened;

- (void)rightViewControllerOpened;

- (void)mainViewControllerOpened;

@end

@interface CPJSidebarViewController : UIViewController

@property (nonatomic)UIViewController* leftVC;                          //左侧面板控制器
@property (nonatomic)UIViewController* mainVC;                          //主面板控制器
@property (nonatomic)UIViewController* rightVC;                         //右侧面板控制器
@property (nonatomic, assign)CGFloat   speedRatio;                      //滑动速度系数，默认1.0
@property (nonatomic, assign)CGFloat   leftDistance;                    //左窗口打开的距离
@property (nonatomic, assign)CGFloat   rightDistance;                   //右窗口打开的距离
@property (nonatomic, assign)BOOL      leftScale;                       //向左滑动并且缩放
@property (nonatomic, assign)BOOL      rightScale;                      //向右滑动并且缩放
@property (nonatomic, weak)id          delegate;                        //代理

- (instancetype)initWithLeftVC:(UIViewController *)leftVC withMainVC:(UIViewController *)mainVC;

- (instancetype)initWithLeftVC:(UIViewController *)leftVC withMainVC:(UIViewController *)mainVC withRightVC:(UIViewController *)rightVC;

- (void)changeMainViewController:(UIViewController *)viewController;

@end
