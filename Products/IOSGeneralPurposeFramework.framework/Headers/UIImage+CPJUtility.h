//
//  UIImage+Utility.h
//  ScanFaceDemo
//
//  Created by zhaishuai on 5/12/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;
@interface UIImage (CPJUtility)

+ (CGFloat)getHeightWidthImage:(UIImage *)image withWidth:(CGFloat)width;
+ (CGFloat)getWidthWithImage:(UIImage *)image withHeight:(CGFloat)height;
+ (UIImage *)scaleFitHeight:(CGFloat)height withImage:(UIImage *)image;
+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;
+ (UIImage*)scaleFitWidth:(CGFloat)width withImage:(UIImage *)image;
- (UIImage*)scaleFitWidth:(CGFloat)width withHight:(CGFloat)height;

+ (NSData *)compressImageBeforeUploadWithImage:(UIImage *)img;
+ (NSData *)compressImageBeforeUploadWithAsset:(ALAsset *)asset;

+(UIImage *)compressImageWithImage:(UIImage *)image;
+(UIImage*)scaleDown:(UIImage*)img withSize:(CGSize)newSize;
@end
