//
//  CPJTableViewComponent.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 9/5/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CPJTableViewRefreshProtocal.h"
#import "M13OrderedDictionary.h"
#import "CPJAbstractSection.h"

@interface CPJTableViewComponent : NSObject

@property (nonatomic, strong)UITableView *view;
@property (nonatomic, strong)NSMutableArray *sections;
@property (nonatomic, strong)id<CPJTableViewRefreshProtocal> refreshComponent;

- (void)addSection:(CPJAbstractSection *)section;

+ (NSString *)getTableViewStringHashWithTalbeView:(UITableView *)tableView;

/**
 * 添加MJRefreshHeader,在action中调用MJRfresh的endRefreshing
 */
- (void)addRefreshHeaderComponentWithTarget:(id)target withRefreshAction:(SEL)action;

/**
 * 添加MJRefreshFooter,在action中调用MJRfresh的endRefreshing
 */
- (void)addRefreshFooterComponentWithTarget:(id)target withRefreshAction:(SEL)action;

- (void)reloadData;

/**
 * 重新建立索引
 */
- (void)generateIndexOfDataSource;

@end
