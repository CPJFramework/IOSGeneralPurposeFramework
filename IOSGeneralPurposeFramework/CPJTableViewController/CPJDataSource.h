//
//  CPJDataSource.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 8/28/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPJDataSource : NSObject
@property (nonatomic, strong)NSMutableArray *dataList;

- (instancetype)initWithArray:(NSArray *)array;

@end
