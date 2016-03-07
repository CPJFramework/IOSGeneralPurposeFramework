//
//  CPJJSONAdapter.m
//  testMantle
//
//  Created by shuaizhai on 1/2/16.
//  Copyright © 2016 com.shuaizhai. All rights reserved.
//

#import "CPJJSONAdapter.h"
#import <objc/runtime.h>

@implementation CPJModel

@end

@interface CPJProperty : NSObject

// model的类型
//
@property (nonatomic, strong)Class    modelType;

// model中对应的接口名称
//
@property (nonatomic, strong)NSString *modelParam;

// model中property的名称
//
@property (nonatomic, strong)NSString *propertyName;

@end

@implementation  CPJProperty



@end

@interface CPJJSONAdapter ()

enum CPJModelVar{CPJModelProperty, CPJModelParam, CPJModelType, CPJModelVarCount};

@end

@implementation CPJJSONAdapter

#pragma mark - modelsOfClass相关方法

- (id)modelsOfClass:(Class)obj fromJSON:(id)json{
    if(![obj isSubclassOfClass:CPJModel.class])
        NSAssert(NO, @"obj必须是CPJModel及其子类。");
    if([json isKindOfClass:[NSDictionary class]]){
        return [self modelsOfClass:obj fromJSONDictionary:json];
    }else if([json isKindOfClass:[NSArray class]]){
        return [self modelsOfClass:obj fromJSONArray:json];
    }else{
        // 留作扩展
        //
        NSAssert(NO, @"json的类型必须是NSDictionary、NSArray类型的。");
    }
    
    
    return nil;
}

- (id)modelsOfClass:(Class)obj fromJSONDictionary:(NSDictionary *)dict{
    NSArray *propertyList = [self getPropertyNameArrayWithClass:obj];
    CPJModel *model = [[obj alloc] init];
    for(CPJProperty *property in propertyList){
        [model setValue:[self converToClass:property.modelType withObject:[dict objectForKey:property.modelParam]] forKey:property.propertyName];
    }
    
    return model;
}

- (id)modelsOfClass:(Class)obj fromJSONArray:(NSArray *)array{
    NSMutableArray *newObjects = [NSMutableArray new];
    for(id object in array){
        [newObjects addObject:[self modelsOfClass:obj fromJSON:object]];
    }
    return newObjects;
}

- (id)converToClass:(Class)obj withObject:(id)object{
    if([obj isSubclassOfClass:[NSString class]]){
        return [self converToNSString:object];
    }else if([obj isSubclassOfClass:[NSNumber class]]){
        return [self converToNSNumber:object];
    }else if([obj isSubclassOfClass:[CPJModel class]]){
        return [self converToCPJModelWithClass:obj withObject:object];
    }
    
    return nil;
}

- (NSString *)converToNSString:(id)object{
    return [NSString stringWithFormat:@"%@", object];
}

- (NSNumber *)converToNSNumber:(id)object{
    return @([[NSString stringWithFormat:@"%@", object] doubleValue]);
}

- (id)converToCPJModelWithClass:(id)obj withObject:(id)object{
    return [self modelsOfClass:obj fromJSON:object];
}

#pragma mark - modelsOfClass相关的运行时相关方法

- (NSArray *)getPropertyNameArrayWithClass:(Class)obj{
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList([obj class], &propertyCount);
    NSMutableArray *propertyList = [NSMutableArray new];
    for( int i = 0 ; i < propertyCount ; i++ ){
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        if([propertyName rangeOfString:@"___CPJMANTLE_PROPERTY_"].location != NSNotFound){
            NSRange range = [propertyName rangeOfString:@"___CPJMANTLE_PROPERTY_"];
            NSString *keyValue = [propertyName substringWithRange:NSMakeRange(range.location + range.length, propertyName.length - range.length)];
            NSArray * arr = [keyValue componentsSeparatedByString:@"$$"];
            CPJProperty *property = [CPJProperty new];
            if(arr.count == CPJModelVarCount){
                property.propertyName = arr[CPJModelProperty];
                property.modelParam = arr[CPJModelParam];
                property.modelType = NSClassFromString(arr[CPJModelType]);
                [propertyList addObject:property];
            }
        }
    }
    return propertyList;
}

#pragma mark - getValueWithPath

- (id)getValueWithPath:(NSString *)path fromJSON:(id)json{
    NSMutableArray *paths = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@"."]];
    return [self getValuewithPathArray:paths fromJSON:json];
}

- (id)getValuewithPathArray:(NSMutableArray *)paths fromJSON:(id)json{
    NSString *key = [paths firstObject];
    if(paths.count==0)
        return nil;
    [paths removeObjectAtIndex:0];
    
    if([json isKindOfClass:[NSDictionary class]]){
        if(![json objectForKey:key]){
            NSLog(@"key: %@ 不存在!", key);
            return nil;
        }
        json = [json objectForKey:key];
    }else if([json isKindOfClass:[NSArray class]]){
        NSInteger index = [key integerValue];
        if(index < [json count]){
            json = [json objectAtIndex:index];
        }else{
            return nil;
        }
    }else{
        // 留作扩展
        //
        NSAssert(NO, @"json的类型必须是NSDictionary、NSArray类型的。");
    }
    
    if(paths.count!=0){
        return [self getValuewithPathArray:paths fromJSON:json];
    }else{
        return json;
    }
}

@end
