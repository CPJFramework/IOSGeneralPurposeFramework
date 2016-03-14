//
//  CPJLibMacros.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 3/8/16.
//  Copyright © 2016 com.shuaizhai. All rights reserved.
//

#ifndef CPJLibMacros_h
#define CPJLibMacros_h

#import <UIKit/UIKit.h>

#define CPJSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CPJSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define CPJPROPERTY_INITIALIZER(return_value_type, property_name)\
- (return_value_type *)property_name{\
    if(!_##property_name){\
        _##property_name = [return_value_type new];\
    }\
    return _##property_name;\
}



#endif /* CPJLibMacros_h */
