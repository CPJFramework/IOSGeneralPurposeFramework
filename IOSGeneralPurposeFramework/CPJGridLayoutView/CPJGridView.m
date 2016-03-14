//
//  CPJGridView.m
//  CPJGridLayoutView
//
//  Created by shuaizhai on 3/9/16.
//  Copyright © 2016 shuaizhai. All rights reserved.
//

#import "CPJGridView.h"
#import "CPJLibMacros.h"
#import "CPJGridLayoutView.h"
@interface CPJGridView ()

@property (nonatomic)UIImageView *imageView;
@property (nonatomic)UIButton    *deleteBtn;
@property (nonatomic)UIPanGestureRecognizer *panGestureRecognizer;
@end

@implementation CPJGridView

CPJPROPERTY_INITIALIZER(UIImageView, imageView)

- (instancetype)init{
    if(self = [super init]){
        [self initializer];
    }
    return self;
}

- (void)setDeleteBtnSize:(CGSize)deleteBtnSize{
    self.deleteBtn.frame = CGRectMake(0, 0, deleteBtnSize.width, deleteBtnSize.height);
    self.deleteBtn.center = CGPointMake(self.frame.size.width, 0);
}

- (void)initializer{
    self.deleteBtn = [UIButton new];
    self.userInteractionEnabled = YES;
    self.deleteBtnSize = CGSizeMake(20, 20);
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.deleteBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.deleteBtn.center = CGPointMake(self.frame.size.width - self.deleteBtn.frame.size.width/2, self.deleteBtn.frame.size.height/2);
    [self.deleteBtn setImage:[UIImage imageNamed:@"deleteImg"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.imageView];
    [self addSubview:self.deleteBtn];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    

}

- (void)setHideDeleteButton:(BOOL)hideDeleteButton{
    _hideDeleteButton = hideDeleteButton;
    self.deleteBtn.hidden = hideDeleteButton;
}

- (void)setEditMode:(BOOL)editMode{
    _editMode = editMode;
    if(editMode){
        [self addGestureRecognizer:self.panGestureRecognizer];
    }else{
        [self removeGestureRecognizer:self.panGestureRecognizer];
    }
}

- (void)setDeleteButtonImage:(UIImage *)deleteButtonImage{
    _deleteButtonImage = deleteButtonImage;
    [self.deleteBtn setImage:deleteButtonImage forState:UIControlStateNormal];
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender translationInView:self.superview.superview];
    static NSInteger currentIndex = 0, zIndex = 0;
    static CGPoint center;
    
    if(![self.superview isKindOfClass:[CPJGridLayoutView class]])
        return;
    CPJGridLayoutView *superView = (CPJGridLayoutView *)self.superview;
    
    int x = ceil( (point.x - (self.frame.size.width/2 + superView.marginX)) / (self.frame.size.width + superView.marginX) );
    int y = ceil( (point.y - (self.frame.size.height/2 + superView.marginY)) / (self.frame.size.height + superView.marginY) );
    NSLog(@"x distance is:%d   y distance is :%d", x, y);


    if(sender.state == UIGestureRecognizerStateBegan){
        zIndex = self.layer.zPosition;
        self.layer.zPosition = 1;
        currentIndex = [[NSMutableArray arrayWithArray:self.superview.subviews] indexOfObject:self];
        center = self.center;
        
        self.frame = CGRectMake(superView.frame.origin.x + self.frame.origin.x
                                , superView.frame.origin.y + self.frame.origin.y,
                                self.frame.size.width,
                                self.frame.size.height);
        

    }else if(sender.state == UIGestureRecognizerStateChanged){
        
        CGFloat x = center.x + point.x, y = center.y + point.y;
        
        x = x > superView.frame.size.width  ? superView.frame.size.width : x;
        y = y > superView.frame.size.height ? superView.frame.size.height : y;
        
        self.center = CGPointMake(x, y);
        


    }else if(sender.state == UIGestureRecognizerStateEnded){
        self.layer.zPosition = zIndex;
        NSInteger index = y*superView.quantity + x + currentIndex;
        index = index > superView.subviews.count ? superView.subviews.count - 1 : index;
        
        
        
        [self removeFromSuperview];
        [superView insertSubview:self atIndex:index];
        
        [UIView animateWithDuration:0.2 animations:^{
            [superView layoutView];
        }];
    }
    

}

- (void)deleteAction{
    if([self.delegate respondsToSelector:@selector(deleteGridViewAction:)]){
        UIView *superview = self.superview;
        __block NSInteger index = [[NSMutableArray arrayWithArray:self.superview.subviews] indexOfObject:self];
        [self removeFromSuperview];
        if([superview isKindOfClass:[CPJGridLayoutView class]]){
            [(CPJGridLayoutView *)superview LayoutViewWithAnimationWithComplete:^{
                [self.delegate deleteGridViewAction:index];
            }];
        }
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object ==self && [keyPath isEqualToString:@"frame"]){
        self.imageView.frame = self.bounds;
        self.deleteBtn.center = CGPointMake(self.frame.size.width - self.deleteBtn.frame.size.width/2, self.deleteBtn.frame.size.height/2);
    }
    else{
        //  调用父类的方法
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
