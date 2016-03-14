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

@implementation CPJTableViewCell{
    CGFloat _cellHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initializer];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initializer];
}

- (void)initializer{
    self.splitLineView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1.0)];
    self.splitLineView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    [self addSubview:self.splitLineView];
    _cellHeight = 50;
}

- (void)configCellWithDataModel:(id)model withUserDictionary:(NSDictionary *)userInfo{
    self.userInfo = userInfo;
    self.model = model;
    self.splitLineView.frame = CGRectMake(self.splitLineView.frame.origin.x, [self cellHeight] - self.splitLineView.frame.size.height, self.splitLineView.frame.size.width, self.splitLineView.frame.size.height);
}

- (CGFloat)cellHeight{
    return _cellHeight;
}

- (void)setCellHeight:(CGFloat)height{
    _cellHeight = height;
    self.splitLineView.frame = CGRectMake(self.splitLineView.frame.origin.x, height - self.splitLineView.frame.size.height, self.splitLineView.frame.size.width, self.splitLineView.frame.size.height);
}

- (CGSize)sizeThatFits:(CGSize)size{
    
    return CGSizeMake(size.width, [self cellHeight]);
}

- (void)cellDidSelectedWithModel:(id)model withUserInfo:(NSDictionary *)userInfo{
    self.userInfo = userInfo;
    self.model = model;
}

- (CGFloat)heightForLabel:(UILabel *)label{
    return [self heightForText:label.text font:label.font withinWidth:label.frame.size.width];
}

- (CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, FLT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:font==nil?[UIFont systemFontOfSize:14]:font}
                                     context:nil];
    
    return rect.size.height;
}

@end
