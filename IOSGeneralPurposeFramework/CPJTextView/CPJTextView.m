//
//  CPJTextView.m
//  IOSGeneralPurposeFramework
//
//  Created by shuaizhai on 1/8/16.
//  Copyright © 2016 com.shuaizhai. All rights reserved.
//

#import "CPJTextView.h"
#import "UIViewExt.h"

#define CPJTEXTVIEW_COUNTER_HEIGHT 20

@interface CPJTextView ()<UITextViewDelegate>

@end

@implementation CPJTextView



- (void)setShowCounter:(BOOL)showCounter{
    _showCounter = showCounter;
    if(showCounter){
        [self addSubview:self.counterLabel];
        self.textView.height = self.height - CPJTEXTVIEW_COUNTER_HEIGHT;
    }else{
        [self.counterLabel removeFromSuperview];
        self.textView.height = self.height;
    }
    
}

- (void)setMaxNum:(NSInteger)maxNum{
    _maxNum = maxNum;
    self.counterLabel.text = [NSString stringWithFormat:@"%ld/%d", (unsigned long)self.textView.text.length, (int)self.maxNum];
}

- (SZTextView *)textView{
    if(!_textView){
        _textView = [[SZTextView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.showCounter == YES ? self.height - CPJTEXTVIEW_COUNTER_HEIGHT : self.height)];
        _textView.delegate = self;
        [self addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)counterLabel{
    if(!_counterLabel){
        _counterLabel = [[UILabel alloc] init];
        _counterLabel.width = self.width;
        _counterLabel.height = CPJTEXTVIEW_COUNTER_HEIGHT;
        _counterLabel.bottom = self.height;
        _counterLabel.textAlignment = NSTextAlignmentRight;
        _counterLabel.text = [NSString stringWithFormat:@"%ld/%d", (unsigned long)self.textView.text.length, (int)self.maxNum];
        _counterLabel.font = [UIFont systemFontOfSize:13];
    }
    return _counterLabel;
}

- (void)textViewDidChange:(SZTextView *)textView{
    if(self.maxNum != 0){
        NSString *lang = [textView.textInputMode primaryLanguage]; // 键盘输入模式
        if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textView markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
            //没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if(!position) {
                if(textView.text.length>self.maxNum){
                    textView.text = [textView.text substringWithRange:NSMakeRange(0, self.maxNum)];
                    if([self.delegate respondsToSelector:@selector(textViewTextReachMaxLimit:)]){
                        [self.delegate textViewTextReachMaxLimit:self.textView];
                    }
                }
            }
            //有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if(textView.text.length>self.maxNum){
                textView.text = [textView.text substringWithRange:NSMakeRange(0, self.maxNum)];
                if([self.delegate respondsToSelector:@selector(textViewTextReachMaxLimit:)]){
                    [self.delegate textViewTextReachMaxLimit:self.textView];
                }
            }
            
        }
    }
    self.counterLabel.text = [NSString stringWithFormat:@"%ld/%d", (unsigned long)self.textView.text.length, (int)self.maxNum];
    if([self.delegate respondsToSelector:@selector(textViewChanged:)]){
        [self.delegate textViewChanged:self.textView];
    }
}



@end

