//
//  CPJUtility.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 4/12/16.
//  Copyright © 2016 com.shuaizhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPJUtility : NSObject

+ (void)createCornersWithView:(UIView *)view byRoundingCorners:(UIRectCorner)corner cornerRadii:(CGSize)size;

@end
