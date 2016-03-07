//
//  CPJTimeoutNetworkComponent.m
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 8/31/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import "CPJTimeoutNetworkComponent.h"
#import "UIViewExt.h"
@implementation CPJTimeoutNetworkComponent

- (void)handleNetworkError:(CPJAbstractNetworking *)networking withView:(UIView *)view{
    self.timeoutView.frame = view.bounds;
    self.timeoutView.top = 64;
    [self.timeoutView removeFromSuperview];
    self.timeoutImageView.image = [UIImage imageNamed:@"meiyouxiaoxi.png"];
    self.timeoutImageView.size = self.timeoutImageView.image.size;
    self.timeoutImageView.center = view.center;
    
    [view addSubview:self.timeoutView];
}

- (void)hidenNetworkErrorView{
    [self.timeoutView removeFromSuperview];
}

- (UIView *)timeoutView{
    if(!_timeoutView){
        _timeoutView = [[UIView alloc] init];
        _timeoutView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        [_timeoutView addSubview:self.timeoutImageView];
    }
    return _timeoutView;
}

- (UIImageView *)timeoutImageView{
    if(!_timeoutImageView){
        _timeoutImageView = [[UIImageView alloc] init];
        
    }
    return _timeoutImageView;
}

@end
