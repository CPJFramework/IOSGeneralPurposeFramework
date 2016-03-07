//
//  CPJTimeoutNetworkComponent.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 8/31/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPJNetworkErrorProtocal.h"
@interface CPJTimeoutNetworkComponent : NSObject<CPJNetworkErrorProtocol>

@property (nonatomic, strong)UIView *timeoutView;
@property (nonatomic, strong)UIImageView *timeoutImageView;

@end
