//
//  CPJCellAdapterProtocol.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/22/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#ifndef IOSGeneralPurposeModule_CPJCellAdapterProtocol_h
#define IOSGeneralPurposeModule_CPJCellAdapterProtocol_h

#import <UIKit/UIKit.h>

@protocol CPJSectionProtocol <NSObject>

@optional

/**
 * 初始化headerView。根据需要在子类中重写，注意View默认的frame为zero。
 */
- (void)initializeHeaderViewWithTableView:(UITableView *)tableView withSection:(NSInteger)section;

/**
 * 初始化footerView。根据需要在子类中重写，注意View默认的frame为zero。
 */
- (void)initializeFooterViewWithTableView:(UITableView *)tableView withSection:(NSInteger)section;

/**
 * 获取headerView，在子类中重写可以根据section来调整headerView
 */
- (UIView *)getHeaderViewWithTableView:(UITableView *)tableView withSection:(NSInteger)section;

/**
 * 获取footerView，在子类中重写可以根据section来调整footerView
 */
- (UIView *)getFooterViewWithTableView:(UITableView *)tableView withSection:(NSInteger)section;





@end

#endif
