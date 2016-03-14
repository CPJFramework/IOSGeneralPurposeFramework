//
//  CPJAlertView.m
//  CPJPopView
//
//  Created by shuaizhai on 2/29/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import "CPJAlertView.h"

#define CONFIRM_BUTTON_HEIGHT 30
#define CONFIRM_BUTTON_WIDTH  100
#define TITLE_LABEL_HEIGHT    30
#define TITLE_LABEL_WIDTH     CONTENTVIEW_WIDTH - 40
#define CONTENTVIEW_WIDTH     280
#define CONTENTVIEW_HEIGHT    self.contentViewHeight
#define FONT_SIZE             15

typedef void (^ConfirmBlock)();

@interface CPJAlertView ()

@property (nonatomic, copy)ConfirmBlock block;

@end

@implementation CPJAlertView

- (CPJPopViewAnimation *)contentViewAnimation{
    if(!_contentViewAnimation){
        _contentViewAnimation = [CPJPopViewAnimation new];
    }
    return _contentViewAnimation;
}

- (UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CONTENTVIEW_WIDTH, CONTENTVIEW_HEIGHT)];
        self.contentView.center = CGPointMake(self.center.x, self.center.y - self.frame.size.height/10);
        _contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.clipsToBounds = YES;
    }
    return _contentView;
}

- (UIButton *)confirmButton{
    if(!_confirmButton){
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (UILabel *)textLabel{
    if(!_textLabel){
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10 + TITLE_LABEL_HEIGHT, TITLE_LABEL_WIDTH, CONTENTVIEW_HEIGHT - 10 - TITLE_LABEL_HEIGHT - 10 - 10 - CONFIRM_BUTTON_HEIGHT)];
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor grayColor];
        _textLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
        [_contentView addSubview:_textLabel];
    }
    return _textLabel;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, TITLE_LABEL_WIDTH, TITLE_LABEL_HEIGHT)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [_contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)configSubviewsWithText:(NSString *)text{
    self.frame = [UIScreen mainScreen].bounds;
    
    CGFloat height = [self heightForText:text font:[UIFont systemFontOfSize:FONT_SIZE] withinWidth:TITLE_LABEL_WIDTH];
    self.contentViewHeight = 120 + height;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 10;
    self.confirmButton.frame = CGRectMake(self.contentView.frame.size.width/2 - CONFIRM_BUTTON_WIDTH/2, self.contentView.frame.size.height - CONFIRM_BUTTON_HEIGHT - 10, CONFIRM_BUTTON_WIDTH, CONFIRM_BUTTON_HEIGHT);
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTintColor:[UIColor whiteColor]];
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = CONFIRM_BUTTON_HEIGHT/2;
    [self.confirmButton setBackgroundColor:[UIColor colorWithRed:251.0/255.0 green:90.0/255.0 blue:146.0/255.0 alpha:1]];
}

- (void)showInView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text withConfirm:(void (^)())confirm{
    [self showInView:view];
    [self configSubviewsWithText:text];
    [self addSubview:self.contentView];
    [self.contentViewAnimation performAnimation:self.contentView];
    self.block = confirm;
    self.textLabel.text = text;
    self.titleLabel.text = title;
    
    
    
}

- (void)confirmAction{
    [self hide];
    if(self.block != nil)
        self.block();
}

- (CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, FLT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{NSFontAttributeName:font}
                                  context:nil];
    
    return rect.size.height;
}

@end
