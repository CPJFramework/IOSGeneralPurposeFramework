//
//  CPJTextView.h
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 1/8/16.
//  Copyright © 2016 com.shuaizhai. All rights reserved.
//

#import "SZTextView.h"

@class CPJTextView;

@protocol CPJTextViewProtocol <NSObject>
@required

- (void)textViewTextReachMaxLimit:(SZTextView *)textView;


@optional

- (void)textViewChanged:(SZTextView *)textView;

@end

@interface CPJTextView : UIView

@property (nonatomic, assign)BOOL                  showCounter;
@property (nonatomic, assign)NSInteger             maxNum;
@property (nonatomic, weak)id<CPJTextViewProtocol> delegate;
@property (nonatomic, strong)SZTextView           *textView;
@property (nonatomic, strong)UILabel              *counterLabel;



@end

