//
//  CPJBaseNetworkStateComponent.m
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/25/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "CPJBaseNetworkStateComponent.h"
#import "UIViewExt.h"
@implementation CPJBaseNetworkStateComponent

- (void)handleNoInternetStateWithView:(UIView *)view{
    self.noInternetView.frame = view.frame;
    [self.noInternetView removeFromSuperview];
    self.noInternetImageView.image = [UIImage imageNamed:@"normal.png"];
    self.noInternetImageView.size = self.noInternetImageView.image.size;
    self.noInternetImageView.center = view.center;

    [view addSubview:self.noInternetView];
}

- (void)handleReachableViaWiFiWithView:(UIView *)view{
    [self.noInternetView removeFromSuperview];
}

- (void)handleReachableViaWWANWithView:(UIView *)view{
    [self handleReachableViaWiFiWithView:view];
}

- (void)handleReachableViaOtherWithView:(UIView *)view{
    [self handleReachableViaWiFiWithView:view];
}

- (UIView *)noInternetView{
    if(!_noInternetView){
        _noInternetView = [[UIView alloc] init];
        _noInternetView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        [_noInternetView addSubview:self.noInternetImageView];
    }
    return _noInternetView;
}

- (UIImageView *)noInternetImageView{
    if(!_noInternetImageView){
        _noInternetImageView = [[UIImageView alloc] init];
    }
    return _noInternetImageView;
}

@end
