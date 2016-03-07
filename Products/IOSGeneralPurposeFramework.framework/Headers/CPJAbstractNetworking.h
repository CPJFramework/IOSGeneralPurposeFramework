//
//  CPJAbstractNetworking.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 8/28/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPJNetworkingProtocol.h"
#import "CPJDataSource.h"
@interface CPJAbstractNetworking : NSObject<CPJNetworkingProtocol>

@property(nonatomic, strong)CPJDataSource *dataSource;
@property(nonatomic, strong)NSError *networkError;

@end
