//
//  CPJNODataStateComponentProtocol.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 10/12/15.
//  Copyright © 2015 com.shuaizhai. All rights reserved.
//

#ifndef CPJNODataStateComponentProtocol_h
#define CPJNODataStateComponentProtocol_h

#import <UIKit/UIKit.h>

@protocol CPJNODataStateComponentProtocol <NSObject>

- (void)showNoDataStateImageViewWithView:(UIView *)view;

- (void)hidenNoDataStateImageView;

@end

#endif /* CPJNODataStateComponentProtocol_h */
