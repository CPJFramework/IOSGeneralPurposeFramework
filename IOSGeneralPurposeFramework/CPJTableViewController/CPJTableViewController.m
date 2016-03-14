//
//  CPJTableViewController.m
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/21/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "CPJTableViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "MJRefresh.h"
#import "UIViewExt.h"

@interface CPJTableViewController ()



@end

@implementation CPJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewComponent.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initializeAdapterAndSetDatasource];
    [self registerCells];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    // 释放掉userInfo，因为userInfo可能会存在循环引用.
    //
    self.userInfo = nil;
    for(CPJTableViewComponent *component in self.tableViewComponentes.allValues){
        for(CPJAbstractSection *adapter in component.sections){
            for(int i=0 ; i<adapter.cellDict.count ; i++){
                CPJTableViewCell *cell = [component.view dequeueReusableCellWithIdentifier:[[adapter.cellDict allKeys] objectAtIndex:i]];
                cell.userInfo = nil;
                cell.model = nil;
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // viewDidDisappear后释放了userInfo，当view重新出现后应该更新cell中的userInfo
    //
    [self.tableViewComponent reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 在该方法中初始化并添加adapter;该方法要在子类中重载并给numberOfSection赋值
 */
- (void)initializeAdapterAndSetDatasource{
    [self addCPJTableViewComponent:self.tableViewComponent];
    [self.contentView addSubview:self.tableViewComponent.view];
}

- (void)registerCells{
    UITableView *tempTableView = [[UITableView alloc] init];
    for(CPJTableViewComponent *component in self.tableViewComponentes.allValues){
        for(CPJAbstractSection *adapter in component.sections){
            for(int i=0 ; i<adapter.cellDict.count ; i++){
                if(![[[adapter.cellDict allObjects] objectAtIndex:i] isKindOfClass:[UINib class]]){
                    [component.view registerClass:[[adapter.cellDict allObjects] objectAtIndex:i] forCellReuseIdentifier:[[adapter.cellDict allKeys] objectAtIndex:i]];
                    [tempTableView registerClass:[[adapter.cellDict allObjects] objectAtIndex:i] forCellReuseIdentifier:[[adapter.cellDict allKeys] objectAtIndex:i]];
                }
                else if(![[[adapter.cellDict allObjects] objectAtIndex:i] isKindOfClass:[CPJTableViewCell class]]){
                    [component.view registerNib:[[adapter.cellDict allObjects] objectAtIndex:i] forCellReuseIdentifier:[[adapter.cellDict allKeys] objectAtIndex:i]];
                    [tempTableView registerNib:[[adapter.cellDict allObjects] objectAtIndex:i] forCellReuseIdentifier:[[adapter.cellDict allKeys] objectAtIndex:i]];
                }
                CPJTableViewCell *cell = [tempTableView dequeueReusableCellWithIdentifier:[[adapter.cellDict allKeys] objectAtIndex:i]];
                [self.cellInstanceDic setObject:cell forKey:[[adapter.cellDict allKeys] objectAtIndex:i]];
            }
        }
    }
}

#pragma mark - 懒加载相关变量

- (NSMutableDictionary *)cellInstanceDic{
    if(!_cellInstanceDic){
        _cellInstanceDic = [NSMutableDictionary new];
    }
    return _cellInstanceDic;
}

- (CPJTableViewComponent *)tableViewComponent{
    if(!_tableViewComponent){
        _tableViewComponent = [[CPJTableViewComponent alloc] init];
        _tableViewComponent.view.frame = self.view.frame;
        self.view.backgroundColor = [UIColor whiteColor];
        _tableViewComponent.view.delegate = self;
        _tableViewComponent.view.dataSource = self;
    }
    return _tableViewComponent;
}

// 在sectionDic中tableView是key，sections是value
//
- (NSMutableDictionary *)tableViewComponentes{
    if(!_tableViewComponentes){
        _tableViewComponentes = [[NSMutableDictionary alloc] init];
    }
    return _tableViewComponentes;
}

- (void)addCPJTableViewComponent:(CPJTableViewComponent *)tableViewComponent{
    tableViewComponent.view.delegate = self;
    tableViewComponent.view.dataSource = self;
    [self.tableViewComponentes setObject:tableViewComponent forKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableViewComponent.view]];
}

// 重写父类中的处理错误方法
//
- (void)handleErrorNetworking:(CPJAbstractNetworking *)networking requestIdentifier:(NSString *)identifier;{
    [super handleErrorNetworking:networking requestIdentifier:identifier];
}

- (NSMutableDictionary *)userInfo{
    if(!_userInfo){
        _userInfo = [[NSMutableDictionary alloc] init];
    }
    return _userInfo;
}

#pragma mark - tableView delegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    return component.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    return [[component.sections objectAtIndex:section] sectionLength];
}

/**
 * 利用该方法向cell提供用户所需的信息，默认提供tableView、indexPath;
 */
- (void)setCellDictionary:(NSMutableDictionary *)userInfo{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    NSInteger section = indexPath.section >= component.sections.count ? component.sections.count-1:indexPath.section;
    NSInteger row = indexPath.row >= [[component.sections[section] dataSourceOfsection] count] ? [[component.sections[section] dataSourceOfsection] count] -1 :indexPath.row;
    CPJSectionDataSourceCache *cache = [component.sections[section] getSectionDataSourceCacheWithRow:row];
        
    CPJTableViewCell *cell = [self.cellInstanceDic objectForKey:cache.cellIdentifier];
    [cell prepareForReuse];
    id model = cache.data;
    [self.userInfo setObject:tableView forKey:@"tableView"];
    [self.userInfo setObject:indexPath forKey:@"indexPath"];
    [self setCellDictionary:self.userInfo];
    if([cell respondsToSelector:@selector(configCellHeightWithDataModel:withUserDictionary:)]){
        [cell configCellHeightWithDataModel:model withUserDictionary:self.userInfo];
    }else{
        [cell configCellWithDataModel:model withUserDictionary:self.userInfo];
    }
    return [cell sizeThatFits:cell.bounds.size].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    CPJSectionDataSourceCache *cache = [component.sections[indexPath.section] getSectionDataSourceCacheWithRow:indexPath.row];
    
    CPJTableViewCell *cell = (CPJTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cache.cellIdentifier];
    [cell prepareForReuse];
    if(cell == nil){
        cell = [[CPJTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"com.zhaishuai.cellIsNil"];
        cell.textLabel.text = [NSString stringWithFormat:@"section:%d row:%d cell is nil!",(int)indexPath.section,(int)indexPath.row];
    }else{
        id model = cache.data;
        [self.userInfo removeAllObjects];
        [self.userInfo setObject:tableView forKey:@"tableView"];
        [self.userInfo setObject:indexPath forKey:@"indexPath"];
        [self setCellDictionary:self.userInfo];
        [cell configCellWithDataModel:model withUserDictionary:self.userInfo];
    }
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    CPJAbstractSection *adapter = [component.sections objectAtIndex:section];
    return [adapter getHeaderViewWithTableView:tableView withSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    CPJAbstractSection *adapter = [component.sections objectAtIndex:section];
    return [adapter getFooterViewWithTableView:tableView withSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    CPJAbstractSection *adapter = [component.sections objectAtIndex:section];
    return [[adapter getHeaderViewWithTableView:tableView withSection:section] frame].size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    CPJAbstractSection *adapter = [component.sections objectAtIndex:section];
    return [[adapter getFooterViewWithTableView:tableView withSection:section] frame].size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CPJTableViewComponent *component = [self.tableViewComponentes objectForKey:[CPJTableViewComponent getTableViewStringHashWithTalbeView:tableView]];
    CPJSectionDataSourceCache *cache = [component.sections[indexPath.section] getSectionDataSourceCacheWithRow:indexPath.row];
    CPJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cache.cellIdentifier];
    id model = cache.data;
    NSAssert(cell != nil, @"cell 不能为nil");
    [self.userInfo removeAllObjects];
    [self.userInfo setObject:tableView forKey:@"tableView"];
    [self.userInfo setObject:indexPath forKey:@"indexPath"];
    [self setCellDictionary:self.userInfo];
    [cell cellDidSelectedWithModel:model withUserInfo:self.userInfo];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
