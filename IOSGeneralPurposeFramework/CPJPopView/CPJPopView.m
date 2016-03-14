//
//  CPJPopView.m
//  CPJPopView
//
//  Created by shuaizhai on 2/29/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import "CPJPopView.h"

@interface CPJDisapperAnimation : CPJPopViewAnimation

@end

@implementation CPJDisapperAnimation

- (void)performAnimation:(UIView *)view{
    view.alpha = 1.0;
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
    
}

@end

@implementation CPJPopViewAnimation

- (void)performAnimation:(UIView *)view{
    view.alpha = 0.1;
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 1.0;
    }];
}

@end

@interface CPJPopView ()

@end

@implementation CPJPopView

- (void)showInView:(UIView *)view{
    [view addSubview:self];
    [self.animation performAnimation:self];
}

- (void)hide{
    [self.disapperAnimation performAnimation:self];
}

- (CPJPopViewAnimation *)animation{
    if(!_appearAnimation){
        _appearAnimation = [CPJPopViewAnimation new];
    }
    return _appearAnimation;
}

- (CPJPopViewAnimation *)disapperAnimation{
    if(!_disapperAnimation){
        _disapperAnimation = [CPJDisapperAnimation new];
    }
    return _disapperAnimation;
}

@end





