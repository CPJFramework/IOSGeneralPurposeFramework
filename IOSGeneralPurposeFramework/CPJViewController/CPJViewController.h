//
//  CPJViewController.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/21/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPJNetworkStateComonentProtocol.h"
#import "CPJLoadingComponentProtocal.h"
#import "CPJNetworkingProtocol.h"
#import "CPJNetworkErrorProtocal.h"
#import "CPJNODataStateComponentProtocol.h"

#define ReachabilityWithHostname @"www.baidu.com"

@class CPJAbstractNetworking;
@interface CPJViewController : UIViewController
enum NetworkQueueType{SERIAL_REQUEST_QUEUE, CONCURRENT_REQUEST_QUEUE};
/**
 * 串行队列和并行队列都是在队列里的所有网络组件都完成请求后，
 * 才会执行后续的操作。如果返回数据需要较长的时间（网络良好的情况下）
 * 而且还需要及时与用户进行交互的情况时，请谨慎使用这两个队列。
 * 这两个队列的目的主要是进行普通的Json串请求。
 */
@property (nonatomic, strong)id<CPJNetworkStateComponentProtocol> networkStateHander;
@property (nonatomic, strong)id<CPJLoadingComponentProtocal> loadingComponent;
@property (nonatomic, strong)id<CPJNetworkErrorProtocol> networkingErrorComponent;
@property (nonatomic, strong)id<CPJNODataStateComponentProtocol> noDataStateComponent;

/**
 * 用来显示loading动画和闪屏提示的图层，在三者的最顶层.
 */
@property (nonatomic, strong, readonly)UIView *loadingGlanceView;

/**
 * 用来显示无网络时的提示图像以及其他状态的图像，在三者的中间.
 */
@property (nonatomic, strong, readonly)UIView *stateView;

/**
 * 相当于UIViewController当中的self.view。在三者的最下层.
 */
@property (nonatomic, strong, readonly)UIView *contentView;



/**
 * 处理通过wifi连接 可在子类中重写
 */
- (void)handleReachableViaWiFi;

/**
 * 处理通过2G/3G连接 可在子类中重写
 */
- (void)handleReachableViaWWAN;
/**
 * 处理其他连接方式 可在子类中重写
 */
- (void)handleReachableViaOther;

/**
 * 处理无网络的情况 可在子类中重写
 */
- (void)handleNOInternetState;

/**
 * 向串行队列添加网络组件
 */
//- (void)addNetworkComponentToSerialQueue:(id<CPJNetworkingProtocol>)networkComponent;

/**
 * 向并行队列添加网络组件
 */
- (void)addNetworkComponentToConcurrentQueue:(id<CPJNetworkingProtocol>)networkComponent;

/**
 * 开始执行串行网络请求队列
 */
//- (void)startRequestSerialQueue;

/**
 * 开始执行并发网络队列
 */
- (void)startRequestConcurrentQueueWithIdentifier:(NSString *)requestIdentifier;

/**
 * 处理错误。如果发生错误则只调用handleErrorNetworking，不调用requestFinished。
 */
- (void)handleErrorNetworking:(CPJAbstractNetworking *)networking requestIdentifier:(NSString *)identifier;

/**
 * 队列中的请求都已执行完毕。如果没有错误则只调用requestFinished不调用handleErrorNetworking。
 */
- (void)requestFinished:(enum NetworkQueueType)queueType requestIdentifier:(NSString *)identifier;


@end
