//
//  UIImage+Utility.m
//  ScanFaceDemo
//
//  Created by zhaishuai on 5/12/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "UIImage+CPJUtility.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <objc/runtime.h>

@implementation UIImage (CPJUtility)

+ (CGFloat)getHeightWidthImage:(UIImage *)image withWidth:(CGFloat)width{
    return width*(image.size.height/image.size.width);
}

+ (CGFloat)getWidthWithImage:(UIImage *)image withHeight:(CGFloat)height{
    return (height*image.size.width)/image.size.height;
}

+ (UIImage *)scaleFitHeight:(CGFloat)height withImage:(UIImage *)image{
    CGSize size;
    size.height = height;
    size.width = [self getWidthWithImage:image withHeight:height];
    return [self resizeImage:image withSize:size];
}

+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage*)scaleFitWidth:(CGFloat)width withImage:(UIImage *)image {
    CGSize size;
    size.width = width;
    size.height = [UIImage getHeightWidthImage:image withWidth:width];
    return [self resizeImage:image withSize:size];
}
- (UIImage*)scaleFitWidth:(CGFloat)width withHight:(CGFloat)height{
    CGSize size;
    size.width = width;
    size.height = height;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#define MIN_UPLOAD_WIDTH 640
#define MAX_UPLOAD_SIZE 400*1024
+ (NSData *)compressImageBeforeUploadWithAsset:(ALAsset *)asset{
    return [self compressImageBeforeUploadWithImage:[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]];
}

+ (NSData *)compressImageBeforeUploadWithImage:(UIImage *)img{
    @autoreleasepool {
        if (img.size.width >MIN_UPLOAD_WIDTH){
            img = [self scaleDown:img withSize:CGSizeMake(MIN_UPLOAD_WIDTH, img.size.height*MIN_UPLOAD_WIDTH/img.size.width)];
        }
        
        //NSLog(@"img.size.width=%f",img.size.width);
        //Compress the image
        CGFloat compression = 0.9f;
        CGFloat maxCompression = 0.1f;
        
        NSData *imageData = UIImageJPEGRepresentation(img, compression);
        
        while ([imageData length] > MAX_UPLOAD_SIZE && compression > maxCompression)
        {
            @autoreleasepool {
                compression -= 0.20;
                imageData = UIImageJPEGRepresentation(img, compression);
            }
            
        }
        
        
//        
        //NSLog(@"img.size.width=%f",[UIImage imageWithData:imageData].size.width);
        return imageData;
    }
}

+(UIImage *)compressImageWithImage:(UIImage *)image{
    NSData *data = [self compressImageBeforeUploadWithImage:image];
    return [UIImage imageWithData:data];
}

+(UIImage*)scaleDown:(UIImage*)img withSize:(CGSize)newSize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newSize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, newSize.width, newSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;

}

@end
