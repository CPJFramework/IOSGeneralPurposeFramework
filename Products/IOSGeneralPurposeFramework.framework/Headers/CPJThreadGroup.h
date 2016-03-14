//
//  CPJThreadGroup.h
//  IOSGeneralPurposeFramework
//
//  Created by richardzhai on 16/2/26.
//  Copyright © 2016年 com.shuaizhai. All rights reserved.
//
/**
 * 使用说明
 
 CPJThreadGroup *group = [CPJThreadGroup new];
 [group addTask:[CPJThreadTask createTask:^{
 sleep(2);
 NSLog(@"1 finished");
 }]];
 
 [group addTask:[CPJThreadTask createTask:^{
 sleep(5);
 NSLog(@"2 finished");
 }]];
 
 [group addTask:[CPJThreadTask createTask:^{
 sleep(7);
 NSLog(@"3 finished");
 }]];
 
 [group addTask:[CPJThreadTask createTask:^{
 sleep(10);
 NSLog(@"4 finished");
 }]];
 
 // DISPATCH_TIME_NOW 代表立马超时；DISPATCH_TIME_FOREVER 代表永远不超时
 //
 group.timeout = DISPATCH_TIME_NOW;
 [group start];
 
 */
#import <Foundation/Foundation.h>

typedef void (^ThreadTask)(void);

@class CPJThreadTask;

@interface CPJThreadGroup : NSObject

@property (nonatomic, assign)dispatch_time_t timeout;


- (void)addTask:(CPJThreadTask *)task;

- (void)removeTask:(CPJThreadTask *)task;

- (void)removeTaskAtIndex:(NSInteger)index;

- (void)removeAllObjects;

- (void)start;

@end


@interface CPJThreadTask : NSObject

@property (nonatomic, copy) ThreadTask threadTask;

+ (instancetype)createTask:(ThreadTask)task;

@end