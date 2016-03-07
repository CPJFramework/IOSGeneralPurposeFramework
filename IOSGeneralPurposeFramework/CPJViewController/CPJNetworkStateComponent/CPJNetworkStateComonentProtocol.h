//
//  CPJNetworkStateComonentProtocal.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/25/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#ifndef IOSGeneralPurposeModule_CPJNetworkStateComonentProtocol_h
#define IOSGeneralPurposeModule_CPJNetworkStateComonentProtocol_h
#import <UIKit/UIKit.h>

@protocol CPJNetworkStateComponentProtocol <NSObject>

/**
 * 处理无网络的情况
 */
- (void)handleNoInternetStateWithView:(UIView *)view;

/**
 * 处理wifi情况
 */
- (void)handleReachableViaWiFiWithView:(UIView *)view;

/**
 * 处理2G/3G网络环境的情况
 */
- (void)handleReachableViaWWANWithView:(UIView *)view;

/**
 * 其他环境连入互联网
 */
- (void)handleReachableViaOtherWithView:(UIView *)view;
@end

#endif
