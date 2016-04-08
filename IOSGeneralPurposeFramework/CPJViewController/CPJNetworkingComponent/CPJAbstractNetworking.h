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
@interface CPJAbstractNetworking : NSObject

@property(nonatomic, strong)CPJDataSource  *_Nonnull dataSource;
@property(nonatomic, strong)NSError *_Nullable networkError;
@property(nonatomic, strong)NSDictionary *_Nonnull parameters;
@property(nonatomic, weak)id<CPJNetworkingProtocol> _Nullable delegate;

- (instancetype _Nonnull)initWithUrl:(NSString *_Nonnull)url withDataClass:(Class _Nonnull) cla withParameters:(NSDictionary *_Nonnull)param;

- (void)requestWithIdentifier:(NSString *_Nonnull)Identifier;

- (void)addProgress:(nullable void (^)(NSProgress * _Nonnull progress))downloadProgress;
- (void)addSuccess:(nullable void (^)(id _Nullable object))success;
- (void)addSuccessDict:(nullable void (^)(NSDictionary* _Nullable dict))success;
- (void)addFailure:(nullable void (^)(NSError * _Nullable error))failure;


@end

