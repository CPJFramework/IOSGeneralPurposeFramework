//
//  CPJNetworkingProtocol.h
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/26/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#ifndef IOSGeneralPurposeModule_CPJNetworkingProtocol_h
#define IOSGeneralPurposeModule_CPJNetworkingProtocol_h

@protocol CPJNetworkingProtocol<NSObject>



@optional

@required
/**
 * 在子类中调用
 */
- (void)requestWithIdentifier:(NSString *)Identifier withCallback:(void (^)())callback;

@end

#endif
