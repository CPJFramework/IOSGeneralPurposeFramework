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

/**
 * 计算label的高度
 */
- (CGFloat)heightForLabel:(UILabel *)label;
/**
 * 计算文本的高度
 */
- (CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width;
/**
 * 在子类中重载。例如:return 50;
 */
- (CGFloat)cellHeight;

- (void)setCellHeight:(CGFloat)height;
@end

@interface CPJTableViewCell : UITableViewCell<CPJTableViewCellProtocol>

@property (nonatomic, weak)id           model;
@property (nonatomic, strong)UIView     *splitLineView;    //分割线
@property (nonatomic, copy)NSDictionary *userInfo;


/**
 * 使用数据模型配置cell的界面，该方法需要在子类中重载
 */


@end
