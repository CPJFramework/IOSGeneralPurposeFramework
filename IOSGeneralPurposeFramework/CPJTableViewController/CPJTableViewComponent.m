//
//  CPJTableViewComponent.m
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 9/5/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import "CPJTableViewComponent.h"
#import "TPKeyboardAvoidingTableView.h"
#import "CPJAbstractSection.h"
#import "CPJTableViewRefreshComponent/CPJTableViewBaseRefreshComponent.h"
#import "MJRefresh.h"

@implementation CPJTableViewComponent

- (UITableView *)view{
    if(!_view){
        _view = [[TPKeyboardAvoidingTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _view;
}

- (void)addSection:(CPJAbstractSection *)section{
    [self.sections addObject:section];
}

+ (NSString *)getTableViewStringHashWithTalbeView:(UITableView *)tableView{
    return [NSString stringWithFormat:@"%lu", (unsigned long)[tableView hash]];
}

- (NSMutableArray *)sections{
    if(!_sections){
        _sections = [[NSMutableArray alloc] init];
    }
    return _sections;
}

- (id<CPJTableViewRefreshProtocal>)refreshComponent{
    if(!_refreshComponent){
        _refreshComponent = [[CPJTableViewBaseRefreshComponent alloc] init];
    }
    return _refreshComponent;
}

/**
 * 添加MJRefreshHeader
 */
- (void)addRefreshHeaderComponentWithTarget:(id)target withRefreshAction:(SEL)action{
    self.view.header = [self.refreshComponent getMJRefreshHeaderWithRefreshingTarget:target refreshingAction:action];
}

/**
 * 添加MJRefreshFooter
 */
- (void)addRefreshFooterComponentWithTarget:(id)target withRefreshAction:(SEL)action{
    self.view.footer = [self.refreshComponent getMJRefreshFooterWithRefreshingTarget:target refreshingAction:action];
}

- (void)generateIndexOfDataSource{
    for(CPJAbstractSection *section in self.sections){
        [section generateIndexOfDataSource];
    }
}

- (void)reloadData{
    for(CPJAbstractSection *section in self.sections){
        [section generateIndexOfDataSource];
    }
    [self.view reloadData];
}


@end
