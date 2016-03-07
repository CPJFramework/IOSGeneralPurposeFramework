//
//  CPJDataSource.m
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 8/28/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import "CPJDataSource.h"

@implementation CPJDataSource

- (instancetype)initWithArray:(NSArray *)array{
    if(self = [super init]){
        self.dataList = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (NSMutableArray *)dataList{
    if(!_dataList){
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}

@end
