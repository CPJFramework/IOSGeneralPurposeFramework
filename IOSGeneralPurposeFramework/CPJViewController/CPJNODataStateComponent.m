//
//  CPJNODataStateComponent.m
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 10/12/15.
//  Copyright © 2015 com.shuaizhai. All rights reserved.
//

#import "CPJNODataStateComponent.h"
#import "UIViewExt.h"

@implementation CPJNODataStateComponent

- (void)showNoDataStateImageViewWithView:(UIView *)view{
    self.noDataView.frame = view.frame;
    [self.noDataView removeFromSuperview];
    self.imageView.image = [UIImage imageNamed:@"meiyouxiaoxi.png"];
    self.imageView.size = self.imageView.image.size;
    self.imageView.center = view.center;
    
    [view addSubview:self.noDataView];
}

- (void)hidenNoDataStateImageView{
    [self.noDataView removeFromSuperview];
}

- (UIView *)noDataView{
    if(!_noDataView){
        _noDataView = [[UIView alloc] init];
        _noDataView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        [_noDataView addSubview:self.imageView];
    }
    return _noDataView;
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
        
    }
    return _imageView;
}

@end
