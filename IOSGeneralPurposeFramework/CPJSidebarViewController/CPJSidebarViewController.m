//
//  CPJSidebarViewController.m
//  CPJSidebarViewController
//
//  Created by shuaizhai on 3/2/16.
//  Copyright © 2016 shuaizhai. All rights reserved.
//

#import "CPJSidebarViewController.h"

#define RATIOFORSCALE 600
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CPJSidebarViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic)UIButton *maskBtn;

@end

@implementation CPJSidebarViewController

- (instancetype)initWithLeftVC:(UIViewController *)leftVC withMainVC:(UIViewController *)mainVC{
    
    if(self = [super init]){
        self.view.backgroundColor = [UIColor whiteColor];
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        self.speedRatio = 1.0;
        self.leftDistance = 150;
        self.rightDistance = self.leftDistance;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self.view addGestureRecognizer:panGesture];
        [self addChildViewController:leftVC];
        leftVC.view.frame = self.view.frame;
        [self.view addSubview:leftVC.view];
        
        [self addChildViewController:self.mainVC];
        mainVC.view.frame = self.view.frame;
        [self.view addSubview:self.mainVC.view];
        self.mainVC.view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (instancetype)initWithLeftVC:(UIViewController *)leftVC withMainVC:(UIViewController *)mainVC withRightVC:(UIViewController *)rightVC{
    if(self = [self initWithLeftVC:leftVC withMainVC:mainVC]){
        self.rightVC = rightVC;
        [self addChildViewController:rightVC];
        [self.view addSubview:self.rightVC.view];
        self.rightVC.view.backgroundColor = [UIColor blueColor];
        [self.mainVC.view bringSubviewToFront:self.rightVC.view];
    }
    return self;
}

- (void)initializer{
    
}

- (UIButton *)maskBtn{
    if(!_maskBtn){
        _maskBtn = [[UIButton alloc] init];
        [_maskBtn addTarget:self action:@selector(maskBtnAvtion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskBtn;
}

- (void)maskBtnAvtion{
    [self performOpenMainViewAnimation];
}

- (void)panAction:(UIPanGestureRecognizer *)sender{
    
    CGPoint point = [sender translationInView:self.view];
    CGFloat px = self.mainVC.view.center.x + point.x;             //当前横坐标
    if(sender.state == UIGestureRecognizerStateBegan){

    }else if(sender.state == UIGestureRecognizerStateChanged){
        
        if(px >= SCREEN_WIDTH/2){                                 //向右滑动
            if(self.leftVC){
                self.leftVC.view.hidden = NO;
                self.rightVC.view.hidden = YES;
                [self slideAnimationWithPoint:point];
            }
        }else{                                                    //向左滑动
            if(self.rightVC){
                self.leftVC.view.hidden = YES;
                self.rightVC.view.hidden = NO;
                [self slideAnimationWithPoint:point];
            }
        }
        
        
    }else if(sender.state == UIGestureRecognizerStateEnded){
        
        if(px >= SCREEN_WIDTH/2){                                 //向右滑动
            CGFloat midX = ((SCREEN_WIDTH + self.leftDistance)*0.5);
            if(px < midX){
                [self performOpenMainViewAnimation];
            }else{
                [self performOpenLeftViewAnimation];
            }
        }else{                                                    //向左滑动
            CGFloat midX = ((SCREEN_WIDTH - self.leftDistance)*0.5);
            if(px > midX){
                [self performOpenMainViewAnimation];
            }else{
                [self performOpenRightViewAnimation];
            }
        }

    }
    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (void)performOpenLeftViewAnimation{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat scaleRatio = [self getScaleRatio:CGPointMake(SCREEN_WIDTH/2 + self.leftDistance - self.mainVC.view.center.x, 0)];
        self.mainVC.view.transform	= CGAffineTransformScale(CGAffineTransformIdentity,scaleRatio,scaleRatio);
        self.mainVC.view.center		= CGPointMake(((SCREEN_WIDTH/2 + self.leftDistance)), self.mainVC.view.center.y);
    } completion:^(BOOL finished) {
        self.maskBtn.frame = self.mainVC.view.bounds;
        [self.mainVC.view addSubview:self.maskBtn];
        if([self.delegate respondsToSelector:@selector(leftViewControllerOpened)]){
            [self.delegate leftViewControllerOpened];
        }
    }];
}

- (void)performOpenMainViewAnimation{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.mainVC.view.transform	= CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        self.mainVC.view.center		= CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    } completion:^(BOOL finished) {
        [self.maskBtn removeFromSuperview];
        self.leftVC.view.hidden = YES;
        if([self.delegate respondsToSelector:@selector(mainViewControllerOpened)]){
            [self.delegate mainViewControllerOpened];
        }
    }];
}

- (void)performOpenRightViewAnimation{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat scaleRatio = [self getScaleRatio:CGPointMake(SCREEN_WIDTH/2 - self.rightDistance - self.mainVC.view.center.x, 0)];
        self.mainVC.view.transform	= CGAffineTransformScale(CGAffineTransformIdentity,scaleRatio, scaleRatio);
        self.mainVC.view.center		= CGPointMake(((SCREEN_WIDTH/2 - self.rightDistance)), self.mainVC.view.center.y);
    } completion:^(BOOL finished) {
        self.maskBtn.frame = self.mainVC.view.bounds;
        [self.mainVC.view addSubview:self.maskBtn];
        if([self.delegate respondsToSelector:@selector(rightViewControllerOpened)]){
            [self.delegate rightViewControllerOpened];
        }
    }];
}

- (void)slideAnimationWithPoint:(CGPoint)point{
    
    CGFloat scaleRatio = [self getScaleRatio:point];
    self.mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleRatio, scaleRatio) ;
    self.mainVC.view.center = CGPointMake(self.mainVC.view.center.x + point.x * self.speedRatio, self.mainVC.view.center.y);
    
}

- (CGFloat)getScaleRatio:(CGPoint)point{
    CGFloat px = self.mainVC.view.center.x + point.x;                                   //当前横坐标
    
    if(px >= SCREEN_WIDTH/2){                                                           //向右滑动
        if(!self.rightScale){
            return 1.0;
        }
        CGFloat scale = 1.0 - (px-SCREEN_WIDTH/2)/RATIOFORSCALE;
        if(scale > 1.0){
            scale = 1.0;
        }
        return scale;
    }else{                                                                              //向左滑动
        if(!self.leftScale){
            return 1.0;
        }
        CGFloat scale = 1.0 - (SCREEN_WIDTH/2 - px)/RATIOFORSCALE;
        if(scale > 1.0){
            scale = 1.0;
        }
        return scale;
        
    }
    
    return 1.0;
}

- (void)changeMainViewController:(UIViewController *)viewController{
    [UIView animateWithDuration:0.2 animations:^{
        self.mainVC.view.alpha = 0;
        self.mainVC.view.frame = CGRectMake(SCREEN_WIDTH, self.mainVC.view.frame.origin.y, self.mainVC.view.frame.size.width, self.mainVC.view.frame.size.height);
    } completion:^(BOOL finished) {
        viewController.view.frame = self.mainVC.view.frame;
        viewController.view.alpha = 0.0;
        [self.mainVC removeFromParentViewController];
        [self.mainVC.view removeFromSuperview];
        self.mainVC = viewController;
        [self addChildViewController:self.mainVC];
        [self.view addSubview:self.mainVC.view];
        
        
        [UIView animateWithDuration:0.4 animations:^{
            self.mainVC.view.frame = self.view.frame;
            self.mainVC.view.center		= CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
            self.mainVC.view.alpha      = 1.0;
        } completion:^(BOOL finished) {
            [self.maskBtn removeFromSuperview];
            self.leftVC.view.hidden = YES;
            if([self.delegate respondsToSelector:@selector(mainViewControllerOpened)]){
                [self.delegate mainViewControllerOpened];
            }
        }];
        
    }];
}

#pragma mark - 手势代理

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        NSLog(@"pinchGesture");
        [self.view addGestureRecognizer: gestureRecognizer];
    }
    //etc
    return YES;
}

@end
