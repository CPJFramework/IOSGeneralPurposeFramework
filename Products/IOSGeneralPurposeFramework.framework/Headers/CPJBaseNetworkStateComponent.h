//
//  CPJBaseNetworkStateComponent.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/25/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPJNetworkStateComonentProtocol.h"

@interface CPJBaseNetworkStateComponent : NSObject<CPJNetworkStateComponentProtocol>

@property (nonatomic, strong)UIView *noInternetView;
@property (nonatomic, strong)UIImageView *noInternetImageView;

@end
