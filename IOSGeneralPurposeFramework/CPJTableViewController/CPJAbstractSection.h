//
//  CPJCellAbstractAdapter.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/22/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPJSectionProtocol.h"
#import "CPJDataSource.h"
#import "M13OrderedDictionary.h"

@interface CPJSectionDataSourceCache : NSObject
// 存放数据源中的某条数据
//
@property (nonatomic, strong)id       data;
@property (nonatomic, strong)NSString *cellIdentifier;

@end

@interface CPJAbstractSection : NSObject<CPJSectionProtocol>

@property (nonatomic, strong)UIView                      *headerView;
@property (nonatomic, strong)UIView                      *footerView;
@property (nonatomic, strong, readonly)NSArray           *dataSourceOfsection;
@property (nonatomic, assign, readonly)NSInteger         sectionLength;
@property (nonatomic, strong)M13MutableOrderedDictionary *sectionDataSource;

/**
 * cellClass和cellNib只选择一个赋值，
 * 两个都赋值的话以cellClass为优先操作。
 * 详情见CPJTableViewController中的registerCells方法。
 */

@property (nonatomic, strong)M13MutableOrderedDictionary *cellDict;

/**
 * @breif 关联cell和section以及dataSource
 */
- (instancetype)initWithCellClass:(Class)objclass withDataSource:(CPJDataSource *)dataSource withCellID:(NSString *)cellID;

- (instancetype)initWithCellNibName:(NSString *)nibName withDataSource:(CPJDataSource *)dataSource withCellID:(NSString *)cellID;


/**
 * @breif 关联cell和section以及dataSource
 */
- (void)addCellWithCellClass:(Class)objclass withDataSource:(CPJDataSource *)dataSource withCellID:(NSString *)cellID;

- (void)addWithCellNibName:(NSString *)nibName withDataSource:(CPJDataSource *)dataSource withCellID:(NSString *)cellID;

- (void)addCellWithCellClass:(Class)objclass withCellID:(NSString *)cellID;

- (void)addWithCellNibName:(NSString *)nibName withCellID:(NSString *)cellID;

/**
 * 根据需要在子类中重写,根据indexPath和dataSource来选择使用相关cell
 */
- (CPJSectionDataSourceCache *)getSectionDataSourceCacheWithRow:(NSInteger)row;

/**
 * 建立数据索引:section中所有的dataSource长度的和的sectionLength，
 * 以及一个存有所有数据的sectionDataSource
 */
- (void)generateIndexOfDataSource;


/**
 * 自定义cellID和dataSource的关系
 */
- (void)configCellIDWithDataSource:(CPJSectionDataSourceCache *)cache withID:(NSString *)cellID;

/**
 * 返回keys，返回一个盛有cell ID的array。array中的key所对应的DataSource将会被添加进dataSourceOfSection。
 */
- (NSArray *)configDataSourceOfSection;



@end
