//
//  CPJNODataStateComponent.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 10/12/15.
//  Copyright © 2015 com.shuaizhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPJNODataStateComponentProtocol.h"

@interface CPJNODataStateComponent : NSObject<CPJNODataStateComponentProtocol>

@property (nonatomic, strong)UIView *noDataView;
@property (nonatomic, strong)UIImageView *imageView;

@end
