//
//  CPJTableViewCell.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/22/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPJTableViewCellProtocol <NSObject>

@optional

- (void)configCellHeightWithDataModel:(id)model withUserDictionary:(NSDictionary *)userInfo;

@required

- (void)configCellWithDataModel:(id)model withUserDictionary:(NSDictionary *)userInfo;

- (void)cellDidSelectedWithModel:(id)model withUserInfo:(NSDictionary *)userInfo;

@end

@interface CPJTableViewCell : UITableViewCell<CPJTableViewCellProtocol>

@property (nonatomic, copy)NSDictionary *userInfo;
@property (nonatomic, weak)id model;

/**
 * 使用数据模型配置cell的界面，该方法需要在子类中重载
 */


@end
