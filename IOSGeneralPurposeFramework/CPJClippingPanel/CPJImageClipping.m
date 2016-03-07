//
//  CPJImageClipping.m
//  IOSTestFramework
//
//  Created by shuaizhai on 11/27/15.
//  Copyright © 2015 com.shuaizhai. All rights reserved.
//

#import "CPJImageClipping.h"
#import "CPJClippingPanel.h"

#define BOUNDCE_DURATION 0.3f

@interface CPJImageClipping ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, assign)CGFloat rotaion;
@property (nonatomic, assign)CGPoint centerPoint;
@property (nonatomic, assign)CGPoint touchPoint;
 
@end

@implementation CPJImageClipping


- (void)viewDidLoad{
    [super viewDidLoad];
    self.networkStateHander = nil;
    //for test
    //
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.view.clipsToBounds = YES;
    
    self.view.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureAction:)];
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureAction:)];
    rotationGesture.delegate = self;
//    [self.view addGestureRecognizer:rotationGesture];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.clippingPanel show];
}




- (UIImage *)clippImage{
    CGRect squareFrame = self.clippingPanel.gridLayer.clippingRect;
    CGFloat scaleRatio = self.clippingPanel.imageView.frame.size.width / self.image.size.width;
//    CGFloat rotation = atan2(self.clippingPanel.imageView.transform.b, self.clippingPanel.imageView.transform.a);
    CGFloat x = (squareFrame.origin.x - self.clippingPanel.imageView.frame.origin.x) / scaleRatio;
    CGFloat y = (squareFrame.origin.y - self.clippingPanel.imageView.frame.origin.y) / scaleRatio;
    CGFloat w = squareFrame.size.width / scaleRatio;
    CGFloat h = squareFrame.size.width / scaleRatio;
//    w = w * cosf(rotation) - h * sinf(rotation);
//    h = w * sinf(rotation) + h * cosf(rotation);
    CGRect myImageRect = CGRectMake(x, y, w, h);
    CGImageRef imageRef = self.image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, myImageRect, subImageRef);
//    CGContextRotateCTM(context, rotation);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    w = w < self.clippingPanel.gridLayer.clippingRect.size.width ? self.clippingPanel.gridLayer.clippingRect.size.width : w;
    h = h < self.clippingPanel.gridLayer.clippingRect.size.height ? self.clippingPanel.gridLayer.clippingRect.size.height :h;
    smallImage = [CPJImageClipping scaleDown:smallImage withSize:CGSizeMake(w, h)];
    
    return smallImage;
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

#pragma mark - 手势操作
/**
 * 平移手势
 */
- (void)panGestureAction:(UIPanGestureRecognizer *)panGestureRecognizer{
    UIView *view = self.clippingPanel.imageView;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x , view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
    else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint newCenter = [self.clippingPanel handleBorderOverflow];
        [UIView animateWithDuration:BOUNDCE_DURATION animations:^{
            self.clippingPanel.imageView.center = newCenter; 
        }];

    }
}

/**
 * 放缩手势
 */
- (void)pinchGestureAction:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    UIView *view = self.clippingPanel.imageView;
    self.touchPoint = [pinchGestureRecognizer locationInView:self.view];
    CGPoint point = [pinchGestureRecognizer locationInView:self.view];
    if(pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat vectorX,vectorY;
        vectorX = (point.x - view.center.x)*pinchGestureRecognizer.scale;
        vectorY = (point.y - view.center.y)*pinchGestureRecognizer.scale;
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        
        [view setCenter:(CGPoint){(point.x - vectorX) , (point.y - vectorY)}];
        pinchGestureRecognizer.scale = 1;
    }else if(pinchGestureRecognizer.state == UIGestureRecognizerStateEnded){
        [self.clippingPanel handleScaleOverflowWithPoint:point];
        CGPoint newCenter = [self.clippingPanel handleBorderOverflow];
        self.clippingPanel.imageView.center = newCenter;
    }
}

/**
 * 旋转手势
 */
- (void)rotationGestureAction:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    UIView *view = self.clippingPanel.imageView;
    CGPoint point = [rotationGestureRecognizer locationInView:self.view];
    if(rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat vectorX,vectorY;
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        vectorX = (point.x - view.center.x) * cos(rotationGestureRecognizer.rotation) - (point.y - view.center.y) * sin(rotationGestureRecognizer.rotation);
        vectorY = (point.x - view.center.x) * sin(rotationGestureRecognizer.rotation) + (point.y - view.center.y) * cos(rotationGestureRecognizer.rotation);
        [view setCenter:(CGPoint){(point.x - vectorX) , (point.y - vectorY)}];
        rotationGestureRecognizer.rotation = 0;
    }else if(rotationGestureRecognizer.state == UIGestureRecognizerStateEnded){
        CGPoint newCenter = [self.clippingPanel handleBorderOverflow];
        [UIView animateWithDuration:BOUNDCE_DURATION animations:^{
            self.clippingPanel.imageView.center = newCenter;
        }];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

/**
 * 解决图片旋转的问题
 */
- (UIImage *)fixOrientation:(UIImage *)srcImg {
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - 懒加载

- (CPJClippingPanel *)clippingPanel{
    if(!_clippingPanel){
        _clippingPanel = [[CPJClippingPanel alloc] initWithFrame:self.view.bounds];
        [self.contentView addSubview:_clippingPanel];
    }
    return _clippingPanel;
}

- (void)setClippingRect:(CGRect)clippingRect{
    self.clippingPanel.gridLayer.clippingRect = clippingRect;
    [self.clippingPanel initializeImageViewSize];
}

- (CGRect)clippingRect{
    return self.clippingPanel.gridLayer.clippingRect;
}

- (void)setImage:(UIImage *)image{
    self.clippingPanel.imageView.image = [self fixOrientation:image];
    [self.clippingPanel initializeImageViewSize];
}

- (UIImage *)image{
    return self.clippingPanel.imageView.image;
}




@end
