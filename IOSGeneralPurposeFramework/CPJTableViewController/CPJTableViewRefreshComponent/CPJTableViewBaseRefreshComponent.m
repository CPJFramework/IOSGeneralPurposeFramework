//
//  CPJTableViewBaseRefreshComponent.m
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/25/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "CPJTableViewBaseRefreshComponent.h"
#import "MJRefresh.h"

@implementation CPJTableViewBaseRefreshComponent

- (MJRefreshHeader *)getMJRefreshHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    // 在此配置header的基本信息
    //
    return header;
}

- (MJRefreshFooter *)getMJRefreshFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action{
    MJRefreshFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    // 在此配置footer的基本信息 
    //
    return footer;
}

@end
