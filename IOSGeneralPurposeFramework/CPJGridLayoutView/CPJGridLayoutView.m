//
//  CPJGridLayoutView.m
//  CPJGridLayoutView
//
//  Created by shuaizhai on 3/8/16.
//  Copyright © 2016 shuaizhai. All rights reserved.
//

#import "CPJGridLayoutView.h"
#import "CPJGridView.h"

@interface CPJGridLayoutView ()



@end 

@implementation CPJGridLayoutView

- (instancetype)initWithMarginX:(CGFloat)mx withMarginY:(CGFloat)my withImageSize:(CGSize)size{
    if(self = [super init]){
        self.type = CPJGRID_TYPE_SIZE;
        self.marginX = mx;
        self.marginY = my;
        self.subViewsize    = size;
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (instancetype)initWithMarginX:(CGFloat)mx withMarginY:(CGFloat)my withQuantityOfEachRow:(NSInteger) quantity{
    if(self = [super init]){
        self.type = CPJGRID_TYPE_QUANTITY;
        self.marginX  = mx;
        self.marginY  = my;
        self.quantity = quantity;
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)layoutView{

    NSInteger count = self.subviews.count;
    for(int i = 0 ; i < count ; i++){
        UIView *view = self.subviews[i];
        CGPoint point = [self getPointWithIndex:i];
        view.frame = CGRectMake(point.x, point.y, self.subViewsize.width, self.subViewsize.height);
    }

}

- (void)LayoutViewWithAnimationWithComplete:(void (^)())complete{
    [self layoutViewWithIndex:0 withComplete:complete];
}

- (void)layoutViewWithIndex:(NSInteger)count withComplete:(void (^)())complete{
    __block NSInteger index = count;
    [UIView animateWithDuration:0.2 animations:^{
        for(int i = 0 ; i < self.quantity && index < self.subviews.count ; i++){
            UIView *view = self.subviews[index];
            CGPoint point = [self getPointWithIndex:index];
            view.frame = CGRectMake(point.x, point.y, self.subViewsize.width, self.subViewsize.height);

            index ++;
        }

    } completion:^(BOOL finished) {
        if(finished){
            if(index < self.subviews.count)
                [self layoutViewWithIndex:index withComplete:complete];
            else
                complete();
        }
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == self && [keyPath isEqualToString:@"frame"]){
        if(self.type == CPJGRID_TYPE_SIZE){
            self.quantity = (self.frame.size.width + self.marginX) / (self.subViewsize.width + self.marginX);
        }else if(self.type == CPJGRID_TYPE_QUANTITY){
            CGFloat width = (self.frame.size.width + self.marginX) / self.quantity;
            width = width - self.marginX;
            self.subViewsize = CGSizeMake(width, width);
        };
    }
    else{
        //  调用父类的方法
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (CGPoint)getPointWithIndex:(NSInteger)index{
    
    NSInteger row = 0, col = 0; // 行列
    self.quantity = self.quantity <= 0 ? 1 : self.quantity;
    col = index % self.quantity;
    row = index / self.quantity;
    
    return CGPointMake(col * (self.subViewsize.width + self.marginX), row * (self.marginY + self.subViewsize.height));
}



- (void)sizeToFit{
    CGPoint point = [self getPointWithIndex:self.subviews.count - 1];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.quantity * (self.subViewsize.width + self.marginX) - self.marginX, point.y + self.subViewsize.height);
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
