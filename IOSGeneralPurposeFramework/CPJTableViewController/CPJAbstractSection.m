//
//  CPJCellAbstractAdapter.m
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/22/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "CPJAbstractSection.h"

@implementation CPJSectionDataSourceCache

@end


@interface CPJAbstractSection ()

@property (nonatomic, strong)NSMutableArray *index;

@end

@implementation CPJAbstractSection{
    NSMutableArray *dataSourceOfSection;
}

- (instancetype)initWithCellClass:(Class)objclass withDataSource:(CPJDataSource *)dataSource withCellID:(NSString *)cellID{
    self = [super init];
    if(self){
        [self.cellDict addObject:objclass pairedWithKey:cellID];
        [self.sectionDataSource addObject:dataSource pairedWithKey:cellID];
    }
    return self;
}

- (instancetype)initWithCellNibName:(NSString *)nibName withDataSource:(CPJDataSource *)dataSource withCellID:(NSString *)cellID{
    self = [super init];
    if(self){
        [self.cellDict addObject:[UINib nibWithNibName:nibName bundle:nil] pairedWithKey:cellID];
        [self.sectionDataSource addObject:dataSource pairedWithKey:cellID];
    }
    return self;
}

- (BOOL)shouldUseCellWithIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
}

- (instancetype)init{
    self = [super init];
    if(self){
        [self configAdapter];
    }
    return self;
}

- (void)addCellWithCellClass:(Class)objclass withDataSource:(CPJDataSource *)dataSource withCellID:(NSString *)cellID{
    [self.cellDict addObject:objclass pairedWithKey:cellID];
    [self.sectionDataSource addObject:dataSource pairedWithKey:cellID];
}

- (void)addWithCellNibName:(NSString *)nibName withDataSource:(CPJDataSource *)dataSource withCellID:(NSString *)cellID{
    [self.cellDict addObject:[UINib nibWithNibName:nibName bundle:nil] pairedWithKey:cellID];
    [self.sectionDataSource addObject:dataSource pairedWithKey:cellID];
}

/**
 * 在子类中重写，在此加载cellClass或cellNib 必须重载
 */
- (void)configAdapter{
    
}

/**
 * 根据需要在子类中重写,根据indexPath和dataSource来选择使用相关cell
 */

- (CPJSectionDataSourceCache *)getSectionDataSourceCacheWithRow:(NSInteger)row{
    if(row >= dataSourceOfSection.count){
        return [dataSourceOfSection lastObject];
    }
    return [dataSourceOfSection objectAtIndex:row];
}

- (M13MutableOrderedDictionary *)cellDict{
    if(!_cellDict){
        _cellDict = [M13MutableOrderedDictionary new];
    }
    return _cellDict;
}

- (M13MutableOrderedDictionary *)sectionDataSource{
    if(!_sectionDataSource){
        _sectionDataSource = [[M13MutableOrderedDictionary alloc] init];
    }
    return _sectionDataSource;
}

// 自定义cellID和dataSource的关系。
//
- (void)configCellIDWithDataSource:(CPJSectionDataSourceCache *)cache withID:(NSString *)cellID{
    cache.cellIdentifier = cellID;
}

// 返回keys，返回一个盛有cell ID的array。array中的key所对应的DataSource将会被添加进dataSourceOfSection。
//
- (NSArray *)configDataSourceOfSection{
    return [self.sectionDataSource allKeys];
}

- (void)generateIndexOfDataSource{
    dataSourceOfSection = [NSMutableArray new];
    for (NSString *key in [self configDataSourceOfSection]){
        for(id data in [[self.sectionDataSource objectForKey:key] dataList]){
            CPJSectionDataSourceCache *cache = [CPJSectionDataSourceCache new];
            cache.data = data;
            [self configCellIDWithDataSource:cache withID:key];
            [dataSourceOfSection addObject:cache];
        }
    }
}


- (NSArray *)dataSourceOfsection{
    return dataSourceOfSection;
}

- (NSInteger)sectionLength{
    return dataSourceOfSection.count;
}

- (NSMutableArray *)index{
    if(!_index){
        _index = [NSMutableArray new];
    }
    return _index;
}

- (UIView *)getHeaderViewWithTableView:(UITableView *)tableView withSection:(NSInteger)section{
    if(!_headerView){
        [self initializeHeaderViewWithTableView:tableView withSection:section];
    }
    return self.headerView;
}

- (UIView *)getFooterViewWithTableView:(UITableView *)tableView withSection:(NSInteger)section{
    if(!_footerView){
        [self initializeFooterViewWithTableView:tableView withSection:section];
    }
    return self.footerView;
}

- (void)initializeHeaderViewWithTableView:(UITableView *)tableView withSection:(NSInteger)section{

}

- (void)initializeFooterViewWithTableView:(UITableView *)tableView withSection:(NSInteger)section{

}

- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}

- (UIView *)footerView{
    if(!_footerView){
        _footerView = [[UIView alloc] init];
    }
    return _footerView;
}

@end
