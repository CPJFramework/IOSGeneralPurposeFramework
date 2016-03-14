//
//  CPJImageButton.h
//  CPJImageButton
//
//  Created by shuaizhai on 3/4/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPJImageButton : UIImageView

@property (nonatomic, strong, nonnull)UIButton *button;

- (void)addTarget:(nullable id)target action:(nonnull SEL)action forControlEvents:(UIControlEvents)controlEvents;

- (void)setCornerRadius:(CGFloat)radius;

@end
