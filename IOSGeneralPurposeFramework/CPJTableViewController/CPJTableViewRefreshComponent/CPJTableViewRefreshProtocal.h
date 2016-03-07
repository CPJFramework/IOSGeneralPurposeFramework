//
//  CPJTableViewRefreshProtocal.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/25/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#ifndef IOSGeneralPurposeModule_CPJTableViewRefreshProtocal_h
#define IOSGeneralPurposeModule_CPJTableViewRefreshProtocal_h
#import <UIKit/UIKit.h>
@class MJRefreshHeader;
@class MJRefreshFooter;
@protocol CPJTableViewRefreshProtocal <NSObject>

- (MJRefreshHeader *)getMJRefreshHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

- (MJRefreshFooter *)getMJRefreshFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end

#endif
