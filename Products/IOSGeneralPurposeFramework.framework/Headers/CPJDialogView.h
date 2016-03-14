//
//  CPJDialogView.h
//  CPJPopView
//
//  Created by shuaizhai on 2/29/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import "CPJAlertView.h"

@interface CPJDialogView : CPJAlertView

@property (nonatomic) UIButton *cancelButton;

- (void)showInView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text withConfirm:(void (^)())confirm withCancel:(void (^)())cancel;

@end
