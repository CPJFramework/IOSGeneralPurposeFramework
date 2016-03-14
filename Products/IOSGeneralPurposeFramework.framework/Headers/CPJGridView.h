//
//  CPJGridView.h
//  CPJGridLayoutView
//
//  Created by shuaizhai on 3/9/16.
//  Copyright © 2016 shuaizhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPJGridView;
@protocol CPJGridViewDelegate <NSObject>

- (void)deleteGridViewAction:(NSInteger)index;

@end

@interface CPJGridView : UIView

@property (nonatomic)UIImage                       *deleteButtonImage;
@property (nonatomic, assign)CGSize                deleteBtnSize;
@property (nonatomic, weak)id<CPJGridViewDelegate> delegate;
@property (nonatomic, assign)BOOL                  editMode;
@property (nonatomic, assign)BOOL                  hideDeleteButton;
// 存放用户数据
//
@property (nonatomic)id                            userData;

@end
