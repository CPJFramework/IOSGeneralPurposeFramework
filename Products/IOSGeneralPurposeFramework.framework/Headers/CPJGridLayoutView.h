//
//  CPJGridLayoutView.h
//  CPJGridLayoutView
//
//  Created by shuaizhai on 3/8/16.
//  Copyright © 2016 shuaizhai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CPJGridLayoutView : UIView

enum CPJGridLayout {
    CPJGRID_TYPE_SIZE,
    CPJGRID_TYPE_QUANTITY
};

@property (nonatomic, assign)CGFloat            marginX;
@property (nonatomic, assign)CGFloat            marginY;
@property (nonatomic, assign)CGSize             subViewsize;
@property (nonatomic, assign)NSInteger          quantity;
@property (nonatomic, assign)enum CPJGridLayout type;

- (instancetype)initWithMarginX:(CGFloat)mx withMarginY:(CGFloat)my withImageSize:(CGSize)size;

- (instancetype)initWithMarginX:(CGFloat)mx withMarginY:(CGFloat)my withQuantityOfEachRow:(NSInteger) quantity;

/**
 * @brief 调用该方法实现布局
 */
- (void)layoutView;

- (void)LayoutViewWithAnimationWithComplete:(void (^)())complete;

/**
 * @brief 根据添加视图的序号计算出该视图左上角的坐标
 */
- (CGPoint)getPointWithIndex:(NSInteger)index;



@end
