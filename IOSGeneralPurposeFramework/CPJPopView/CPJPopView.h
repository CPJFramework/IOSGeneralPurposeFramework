//
//  CPJPopView.h
//  CPJPopView
//
//  Created by shuaizhai on 2/29/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPJPopViewProtocol.h"

@interface CPJPopViewAnimation : NSObject

/**
 * 在子类中重写该方法
 * @brief 执行view的动画
 * @param view：需要动画表现的视图（是视图本身的动画而不是在视图中绘制动画）
 */
- (void)performAnimation:(UIView *)view;

@end

@interface CPJPopView : UIView <CPJPopViewProtocol>

@property (nonatomic) CPJPopViewAnimation *appearAnimation;
@property (nonatomic) CPJPopViewAnimation *disapperAnimation;

@end
