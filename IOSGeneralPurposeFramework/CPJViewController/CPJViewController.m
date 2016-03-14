//
//  CPJViewController.m
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/21/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "CPJViewController.h"
#import "Reachability.h"
#import "CPJBaseNetworkStateComponent.h"
#import "CPJLoadingViewComponent/CPJBaseLoadingComponent.h"
#import "UIViewExt.h"
#import "CPJAbstractNetworking.h"
#import "CPJTimeoutNetworkComponent.h"

@interface CPJViewController ()

@property(nonatomic, strong)NSMutableArray *serialRequestQueue;
@property(nonatomic, strong)NSMutableArray *concurrentRequestQueue;

@end

@implementation CPJViewController{
    Reachability* reachHander;
}

@synthesize contentView = _contentView;
@synthesize stateView = _stateView;
@synthesize loadingGlanceView = _loadingGlanceView;

#pragma mark - 初始化

- (instancetype)init{
    self = [super init];
    if(self){
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
//    [self configViews];
}

- (void)configViews{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,
                                                         self.view.frame.origin.y,
                                                         self.view.frame.size.width,
                                                         self.view.frame.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.stateView];
    [self.view addSubview:self.loadingGlanceView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configViews];
    [self configReachility];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求执行队列

- (void)addNetworkComponentToSerialQueue:(id<CPJNetworkingProtocol>)networkComponent{
    [self.serialRequestQueue addObject:networkComponent];
}

- (void)addNetworkComponentToConcurrentQueue:(id<CPJNetworkingProtocol>)networkComponent{
    [self.concurrentRequestQueue addObject:networkComponent];
}

/**
 * 开始执行串行网络请求队列
 */
- (void)startRequestSerialQueue{
    
}

/**
 * 开始执行并发网络队列
 */
- (void)startRequestConcurrentQueueWithIdentifier:(NSString *)requestIdentifier{
    dispatch_group_t group = dispatch_group_create();
    for(id<CPJNetworkingProtocol> networkComponent in self.concurrentRequestQueue){
         dispatch_group_enter(group);
        [networkComponent requestWithIdentifier:requestIdentifier withCallback:^{
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{ // 4
        CPJAbstractNetworking *errorNetwork;
        for(CPJAbstractNetworking *netWork in self.concurrentRequestQueue){
            if(netWork.networkError!=nil){
                errorNetwork = netWork;
                break;
            }
        }
        [self.concurrentRequestQueue removeAllObjects];
        [self handleErrorNetworking:errorNetwork requestIdentifier:requestIdentifier];
        [self requestFinished:CONCURRENT_REQUEST_QUEUE requestIdentifier:requestIdentifier];
    });
}

/**
 * 处理错误
 */
- (void)handleErrorNetworking:(CPJAbstractNetworking *)networking requestIdentifier:(NSString *)identifier;{
    // 处理超时错误
    //
    if(networking.networkError.code == -1001)
        [self.networkingErrorComponent handleNetworkError:networking withView:self.stateView];
    else
        [self.networkingErrorComponent hidenNetworkErrorView];
    [self.loadingComponent hideLoadingViewFromVC:self];
}

/**
 * 队列中的请求都已执行完毕
 */
- (void)requestFinished:(enum NetworkQueueType)queueType requestIdentifier:(NSString *)identifier{
    
}

#pragma mark - 配置网络可达检查组件

- (void)configReachility{
    // Allocate a reachability object
    reachHander = [Reachability reachabilityWithHostname:ReachabilityWithHostname];
    __weak id mySelf = self;
    // Set the blocks
    reachHander.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(reach.isReachableViaWiFi){
                
                [mySelf handleReachableViaWiFi];
            }else if(reach.isReachableViaWWAN){
                
                [mySelf handleReachableViaWWAN];
            }else if(reach.isReachable){
                
                [mySelf handleReachableViaOther];
            }
        });
    };
    
    reachHander.unreachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [mySelf handleNOInternetState];
        });
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reachHander startNotifier];
}

- (void)handleReachableViaWiFi{
    [self.networkStateHander handleReachableViaWiFiWithView:self.stateView];
    // 可以在该处填写请求网络的接口
    //
}

- (void)handleReachableViaWWAN{
    [self.networkStateHander handleReachableViaWWANWithView:self.stateView];
    [self handleReachableViaWiFi];
}

- (void)handleReachableViaOther{
    [self.networkStateHander handleReachableViaOtherWithView:self.stateView];
    [self handleReachableViaWiFi];
}

- (void)handleNOInternetState{
    [self.networkStateHander handleNoInternetStateWithView:self.stateView];
    
}

- (void)dealloc{
    [reachHander stopNotifier];
}

#pragma mark - 懒加载
/*  根据需要自己配置
- (id<CPJNetworkStateComponentProtocol>)networkStateHander{
    if(!_networkStateHander){
        _networkStateHander = [[CPJBaseNetworkStateComponent alloc] init];
    }
    return _networkStateHander;
}
*/

- (id<CPJLoadingComponentProtocal>)loadingComponent{
    if(!_loadingComponent){
        _loadingComponent = [[CPJBaseLoadingComponent alloc] init];
    }
    return _loadingComponent;
}

- (id<CPJNetworkErrorProtocol>)networkingErrorComponent{
    if(!_networkingErrorComponent){
        _networkingErrorComponent = [CPJTimeoutNetworkComponent new];
    }
    return _networkingErrorComponent;
}

- (UIView *)contentView{
    if(!_contentView){
        
        _contentView = [[UIView alloc] initWithFrame:self.view.frame];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)stateView{
    if(!_stateView){
        _stateView = [[UIView alloc] initWithFrame:self.view.frame];
        _stateView.userInteractionEnabled = NO;
        _stateView.backgroundColor = [UIColor clearColor];
    }
    return _stateView;
}

- (UIView *)loadingGlanceView{
    if(!_loadingGlanceView){
        _loadingGlanceView = [[UIView alloc] initWithFrame:self.view.frame];
        _loadingGlanceView.userInteractionEnabled = NO;
        _loadingGlanceView.backgroundColor = [UIColor clearColor];
    }
    return _loadingGlanceView;
}

- (NSMutableArray *)serialRequestQueue{
    if(!_serialRequestQueue){
        _serialRequestQueue = [[NSMutableArray alloc] init];
    }
    return _serialRequestQueue;
}

- (NSMutableArray *)concurrentRequestQueue{
    if(!_concurrentRequestQueue){
        _concurrentRequestQueue = [[NSMutableArray alloc] init];
    }
    return _concurrentRequestQueue;
}

@end
