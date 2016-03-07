//
//  CPJTableViewController.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/21/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "CPJViewController.h"
#import "CPJAbstractSection.h"
#import "CPJTableViewCell.h"
#import "M13OrderedDictionary.h"
#import "CPJDataSource.h"
#import "CPJTableViewComponent.h"
@interface CPJTableViewController : CPJViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)CPJTableViewComponent *tableViewComponent;
@property (nonatomic, strong)NSMutableDictionary *tableViewComponentes;

@property (nonatomic, strong)NSMutableDictionary *userInfo;
@property (nonatomic, strong)NSMutableDictionary *cellInstanceDic;

/**
 * 在子类中重写(必须),初始化Adapter和配置dataSource
 */
- (void)initializeAdapterAndSetDatasource;

/**
 * 利用该方法向cell提供用户所需的信息，默认提供tableView、indexPath;
 */
- (void)setCellDictionary:(NSMutableDictionary *)userInfo;

/**
 * 在section字典中添加CPJTableViewComponent。
 * tableViewComponent作为值，tableViewComponent.view作为键。
 */
- (void)addCPJTableViewComponent:(CPJTableViewComponent *)tableViewComponent;


@end
