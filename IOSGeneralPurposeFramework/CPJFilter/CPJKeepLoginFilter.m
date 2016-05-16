//
//  CPJKeepLoginFilter.m
//  CPJFilter
//
//  Created by shuaizhai on 3/22/16.
//  Copyright © 2016 pcx. All rights reserved.
//

#import "CPJKeepLoginFilter.h"

@interface CPJKeepLoginFilter ()
@end

@implementation CPJKeepLoginFilter

- (void)needLoginWithCompletion:(void (^)(void))completion{
    id cla               = loginController;
    UIViewController *vc = nil;
    if([cla isKindOfClass:[NSString class]]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:self.storyboardName bundle:nil];
        vc = [storyboard instantiateViewControllerWithIdentifier:cla];
    }else{
        NSObject *object = [[cla alloc] init];
        if([object isKindOfClass:[UIViewController class]]){
            vc = [[cla alloc] init];
        }
    }
    
    NSAssert(vc!=nil, @"请设置LoginViewController。");
    if(![self hasLogin]){
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self setMainViewController:nvc];
    }
}

@end
