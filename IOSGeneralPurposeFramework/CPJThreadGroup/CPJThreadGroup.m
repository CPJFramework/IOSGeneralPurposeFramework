//
//  CPJThreadGroup.m
//  IOSGeneralPurposeFramework
//
//  Created by richardzhai on 16/2/26.
//  Copyright © 2016年 com.shuaizhai. All rights reserved.
//

#import "CPJThreadGroup.h"

@interface CPJThreadGroup ()

@property (nonatomic, strong)NSMutableArray *tasks;

@end

@implementation CPJThreadGroup

- (NSMutableArray *)tasks{
    
    if(!_tasks){
        _tasks = [NSMutableArray new];
        _timeout = DISPATCH_TIME_FOREVER;
    }
    return _tasks;
    
}// tasks

- (void)setTimeout:(dispatch_time_t)timeout{
    if(timeout == DISPATCH_TIME_FOREVER || timeout == DISPATCH_TIME_NOW){
        _timeout = timeout;
    }else{
        _timeout = dispatch_time(DISPATCH_TIME_NOW, (dispatch_time_t)timeout*NSEC_PER_SEC);
    }
}

- (void)addTask:(CPJThreadTask *)task{
    
    [self.tasks addObject:task];
    
}// addTask

- (void)removeTask:(CPJThreadTask *)task{
    
    [self.tasks removeObject:task];
    
}// removeTask;

- (void)removeTaskAtIndex:(NSInteger)index{
    
    [self.tasks removeObjectAtIndex:index];
    
}// tasks

- (void)removeAllObjects{
    
    [self.tasks removeAllObjects];
    
}//removeAllObjects

- (void)start{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    for(CPJThreadTask *task in self.tasks){
        
        dispatch_group_async(group, queue, task.threadTask);
        
    }// for
    
    dispatch_group_wait(group, self.timeout);
    
}// start

@end

@interface CPJThreadTask ()

@end

@implementation CPJThreadTask

+ (instancetype)createTask:(ThreadTask)task{
    
    CPJThreadTask *threadTask = [CPJThreadTask new];
    threadTask.threadTask = task;
    return threadTask;
    
}// createTask



@end