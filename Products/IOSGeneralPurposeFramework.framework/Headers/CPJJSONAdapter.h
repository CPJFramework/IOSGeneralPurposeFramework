//
//  CPJJSONAdapter.h
//  testMantle
//
//  Created by shuaizhai on 1/2/16.
//  Copyright © 2016 com.shuaizhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
////////////////////////////////////////////////////////////////////////////////////////////////
//
// CPJModel
//
@interface CPJModel : NSObject

@end

#define CREATE_CPJMODEL_BEGAIN(CLASS_NAME)\
@interface CLASS_NAME : CPJModel

#define CPJMODEL_ADD_NSSTRING_PROPERTY(PROPERTY_NAME, INTERFACE_NAME)    \
@property(nonatomic, strong) NSString *PROPERTY_NAME;                      \
@property(nonatomic, weak, readonly) NSObject *___CPJMANTLE_PROPERTY_##PROPERTY_NAME##$$##INTERFACE_NAME##$$NSString;

#define CPJMODEL_ADD_NSNUMBER_PROPERTY(PROPERTY_NAME, INTERFACE_NAME)    \
@property(nonatomic, strong) NSNumber *PROPERTY_NAME;                      \
@property(nonatomic, weak, readonly) NSObject *___CPJMANTLE_PROPERTY_##PROPERTY_NAME##$$##INTERFACE_NAME##$$NSNumber;

#define CPJMODEL_ADD_CPJMODEL_PROPERTY(PROPERTY_TYPE ,PROPERTY_NAME, INTERFACE_NAME)\
@property(nonatomic, strong) PROPERTY_TYPE *PROPERTY_NAME;\
@property(nonatomic, weak, readonly) NSObject *___CPJMANTLE_PROPERTY_##PROPERTY_NAME##$$##INTERFACE_NAME##$$##PROPERTY_TYPE;

#define CPJMODEL_ADD_NSARRAY_PROPERTY(PROPERTY_TYPE ,PROPERTY_NAME, INTERFACE_NAME)\
@property(nonatomic, strong) NSArray *PROPERTY_NAME;\
@property(nonatomic, weak, readonly) NSObject *___CPJMANTLE_PROPERTY_##PROPERTY_NAME##$$##INTERFACE_NAME##$$##NSArray$##PROPERTY_TYPE;

#define CREATE_CPJMODEL_END @end

#define CPJMODEL_IMPLEMENT(CLASS_NAME)\
@implementation CLASS_NAME\
@end

// 在.m中自定义方法
//
#define CREATE_CPJMODEL_IMPLEMENT(CLASS_NAME)\
@implementation CLASS_NAME

#define CREATE_CPJMODEL_IMPLEMENT_END @end

//
//
////////////////////////////////////////////////////////////////////////////////////////////////

@interface CPJJSONAdapter : NSObject
/**
 * 将json装换为一个对象
 * xxx.h
 * CREATE_CPJMODEL_BEGAIN(MSMUserModel)
 *      CPJMODEL_ADD_NSSTRING_PROPERTY(userName, user_name)
 *      CPJMODEL_ADD_NSNUMBER_PROPERTY(userAge, user_age)
 *      CPJMODEL_ADD_NSSTRING_PROPERTY(userSex, user_sex)
 * CREATE_CPJMODEL_END
 *
 * xxx.m
 * CPJMODEL_IMPLEMENT(MSMUserModel)
 */
- (id)modelsOfClass:(Class) obj fromJSON:(id)json;

/**
 * 给定一个json的路径获取相应的值
 * 例如：[[CPJJSONAdapter new] getValueWithPath:@"face.0.face_id" fromJSON:responseObject]
 */
- (id)getValueWithPath:(NSString *)path fromJSON:(id)json;

@end


