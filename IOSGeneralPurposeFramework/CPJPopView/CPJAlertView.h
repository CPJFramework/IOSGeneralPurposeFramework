//
//  CPJAlertView.h
//  CPJPopView
//
//  Created by shuaizhai on 2/29/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPJPopView.h"

@interface CPJAlertView : CPJPopView

@property (nonatomic) UIView              *contentView;
@property (nonatomic) UILabel             *textLabel;
@property (nonatomic) UILabel             *titleLabel;
@property (nonatomic) UIButton            *confirmButton;
@property (nonatomic) CPJPopViewAnimation *contentViewAnimation;
@property (nonatomic) CGFloat             contentViewHeight;

/**
 * @brief 在该方法中配置界面，子类根据需要重写该方法。
 * @param text代表提示框显示的文字内容
 */
- (void)configSubviewsWithText:(NSString *)text;

- (void)showInView:(UIView *) view withTitle:(NSString *)title withText:(NSString *)text withConfirm:(void (^)())confirm;

@end