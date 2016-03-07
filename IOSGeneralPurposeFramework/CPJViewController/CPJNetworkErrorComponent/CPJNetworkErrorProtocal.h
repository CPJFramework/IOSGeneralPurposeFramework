//
//  CPJNetworkErrorProtocal.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 8/31/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#ifndef IOSGeneralPurposeFramework_CPJNetworkErrorProtocal_h
#define IOSGeneralPurposeFramework_CPJNetworkErrorProtocal_h
#import <UIKit/UIKit.h>
#import "CPJAbstractNetworking.h"
@protocol CPJNetworkErrorProtocol <NSObject>

- (void)handleNetworkError:(CPJAbstractNetworking *)networking withView:(UIView *)view;

- (void)hidenNetworkErrorView;

@end

#endif
