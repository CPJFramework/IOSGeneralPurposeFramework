//
//  CPJAbstractNetworking.m
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 8/28/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import "CPJAbstractNetworking.h"

@implementation CPJAbstractNetworking

/**
 * 在子类中调用
 */
- (void)requestWithIdentifier:(NSString *)Identifier withCallback:(void (^)())callback{

}

- (CPJDataSource *)dataSource{
    if(!_dataSource){
        _dataSource = [[CPJDataSource alloc] init];
    }
    return _dataSource;
}

@end
