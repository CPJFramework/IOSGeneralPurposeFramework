//
//  CPJAbstractNetworking.m
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 8/28/15.
//  Copyright (c) 2015 com.shuaizhai. All rights reserved.
//

#import "CPJAbstractNetworking.h"
#import "CPJJSONAdapter.h"
#import <AFNetworking/AFNetworking.h>

typedef void (^DownloadProgress)(NSProgress *);
typedef void (^Success)(id _Nullable);
typedef void (^SuccessDict)(NSDictionary* _Nullable);
typedef void (^Failure)(NSError * _Nullable);

@interface CPJAbstractNetworking()

@property (nonatomic, copy)DownloadProgress downloadProgress;
@property (nonatomic, copy)Success          success;
@property (nonatomic, copy)SuccessDict      successDict;
@property (nonatomic, copy)Failure          failure;

@end

@implementation CPJAbstractNetworking{
    
    NSString *urlstr;

}

- (instancetype _Nonnull)initWithUrl:(NSString *_Nonnull)url withDataClass:(Class _Nonnull) cla withParameters:(NSDictionary *_Nonnull)param{
    if(self = [super init]){
        self.dataType = cla;
        urlstr = url;
        self.parameters = param;
    }
    return self;
}


- (void)addProgress:(void (^)(NSProgress *))downloadProgress{
    self.downloadProgress = downloadProgress;
}

- (void)addSuccess:(void (^)(id _Nullable))success{
    self.success = success;
}

- (void)addFailure:(void (^)(NSError * _Nullable))failure{
    self.failure = failure;
}

- (void)addSuccessDict:(void (^)(NSDictionary * _Nullable))success{
    self.successDict = success;
}

- (void)requestWithIdentifier:(NSString *)Identifier{

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:urlstr parameters:self.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if(self.downloadProgress)
            self.downloadProgress(downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(self.successDict)
            self.successDict(responseObject);
        
        if(self.success)
            self.success([[CPJJSONAdapter new] modelsOfClass:self.dataType fromJSON:responseObject]);
        
        if([self.delegate respondsToSelector:@selector(finishRequest)]){
            [self.delegate finishRequest];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(self.failure)
            self.failure(error);
        
        if([self.delegate respondsToSelector:@selector(finishRequest)]){
            [self.delegate finishRequest];
        }
    }];

    
}

- (CPJDataSource *)dataSource{
    if(!_dataSource){
        _dataSource = [[CPJDataSource alloc] init];
    }
    return _dataSource;
}

@end
