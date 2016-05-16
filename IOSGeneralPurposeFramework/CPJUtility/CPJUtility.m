//
//  CPJUtility.m
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 4/12/16.
//  Copyright © 2016 com.shuaizhai. All rights reserved.
//

#import "CPJUtility.h"

@implementation CPJUtility

+ (void)createCornersWithView:(UIView *)view byRoundingCorners:(UIRectCorner)corner cornerRadii:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:corner
                                                         cornerRadii:size];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
