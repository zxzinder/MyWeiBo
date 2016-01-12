//
//  UITextView+Extension.m
//  MyWeiBo
//
//  Created by alexzinder on 16/1/11.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)


- (void)insertAttributedText:(NSAttributedString *)text
{
    [self insertAttributedText:text settingBlock:nil];
}

-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *))settingBlock{
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接图片
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];
    
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
    self.attributedText = attributedText;
    
    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
    
    // 设置字体
    
   // [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    
}

@end
