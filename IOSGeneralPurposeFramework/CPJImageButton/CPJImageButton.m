//
//  CPJImageButton.m
//  CPJImageButton
//
//  Created by shuaizhai on 3/4/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import "CPJImageButton.h"

@implementation CPJImageButton

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initialize];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image{
    if(self = [super initWithImage:image]){
        [self initialize];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage{
    if(self = [super initWithImage:image highlightedImage:highlightedImage]){
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.userInteractionEnabled = YES;
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:self.button];
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setCornerRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)addTarget:(nullable id)target action:(nonnull SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object ==self && [keyPath isEqualToString:@"frame"]){
        self.button.frame = self.bounds;
    }
    else{
        //  调用父类的方法
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (UIButton *)button{
    if(!_button){
        _button = [[UIButton alloc] initWithFrame:self.bounds];
    }
    return _button;
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
