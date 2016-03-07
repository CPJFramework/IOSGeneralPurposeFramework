//
//  CPJTableViewCell.m
//  IOSGeneralPurposeModule
//
//  Created by shuaizhai on 8/22/15.
//  Copyright (c) 2015 zhaishuai. All rights reserved.
//

#import "CPJTableViewCell.h"
//#import "UITableView+FDTemplateLayoutCell.h"

@interface CPJTableViewCell ()

@end

@implementation CPJTableViewCell


- (void)configCellWithDataModel:(id)model withUserDictionary:(NSDictionary *)userInfo{
    self.userInfo = userInfo;
    self.model = model;
}

- (CGSize)sizeThatFits:(CGSize)size{
    CGFloat totalHeight = 50;
    
    return CGSizeMake(size.width, totalHeight);;
}



- (void)cellDidSelectedWithModel:(id)model withUserInfo:(NSDictionary *)userInfo{
    self.userInfo = userInfo;
    self.model = model;
}

@end
