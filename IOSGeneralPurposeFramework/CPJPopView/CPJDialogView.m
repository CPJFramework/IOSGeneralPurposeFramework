//
//  CPJDialogView.m
//  CPJPopView
//
//  Created by shuaizhai on 2/29/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import "CPJDialogView.h"

#define CONFIRM_BUTTON_HEIGHT 30
#define CONFIRM_BUTTON_WIDTH  100

typedef void (^CancelBlock)();

@interface CPJDialogView ()

@property (nonatomic, copy) CancelBlock cancelBlock;

@end

@implementation CPJDialogView

- (UIButton *)cancelButton{
    if(!_cancelButton){
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_cancelButton];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}

- (void)configSubviewsWithText:(NSString *)text;{
    [super configSubviewsWithText:text];
    self.confirmButton.frame = CGRectMake(self.contentView.frame.size.width/2 - CONFIRM_BUTTON_WIDTH -5, self.contentView.frame.size.height - CONFIRM_BUTTON_HEIGHT - 10, CONFIRM_BUTTON_WIDTH, CONFIRM_BUTTON_HEIGHT);
    self.cancelButton.frame = CGRectMake(self.contentView.frame.size.width/2 + 5, self.contentView.frame.size.height - CONFIRM_BUTTON_HEIGHT - 10, CONFIRM_BUTTON_WIDTH, CONFIRM_BUTTON_HEIGHT);
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTintColor:[UIColor whiteColor]];
    self.confirmButton.layer.masksToBounds = YES;
    self.confirmButton.layer.cornerRadius = CONFIRM_BUTTON_HEIGHT/2;
    [self.confirmButton setBackgroundColor:[UIColor colorWithRed:251.0/255.0 green:90.0/255.0 blue:146.0/255.0 alpha:1]];
    
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTintColor:[UIColor colorWithRed:251.0/255.0 green:90.0/255.0 blue:146.0/255.0 alpha:1]];
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = CONFIRM_BUTTON_HEIGHT/2;
    self.cancelButton.layer.borderColor = [UIColor colorWithRed:251.0/255.0 green:90.0/255.0 blue:146.0/255.0 alpha:1].CGColor;
    self.cancelButton.layer.borderWidth = 1.0;
}

- (void)showInView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text withConfirm:(void (^)())confirm withCancel:(void (^)())cancel{
    [self showInView:view withTitle:title withText:text withConfirm:confirm];
    self.cancelBlock = cancel;
}

- (void)cancelButtonAction{
    [self hide];
    if(self.cancelBlock != nil)
        self.cancelBlock();
}

@end
