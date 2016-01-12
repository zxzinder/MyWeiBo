//
//  MyWBEmotionTextView.m
//  MyWeiBo
//
//  Created by alexzinder on 16/1/11.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "MyWBEmotionTextView.h"
#import "MyWBEmotion.h"
#import "MyWBEmotionAttachment.h"

@implementation MyWBEmotionTextView

-(void)insertEmotion:(MyWBEmotion *)emotion{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    }else if(emotion.png){
        
        MyWBEmotionAttachment *attch = [[MyWBEmotionAttachment alloc] init];
        //传递模型
        attch.emotion = emotion;
            
        CGFloat attachWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        //根据文字创建属性文字
        NSAttributedString *imgStr = [NSMutableAttributedString attributedStringWithAttachment:attch];
        
      //  [self insertAttributeText:imgStr];
        [self insertAttributedText:imgStr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
    
}

-(NSString *)fullText{
    
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        MyWBEmotionAttachment *attch = attrs[@"NSAttachment"];
        
        if (attch) {
            [fullText appendString:attch.emotion.chs];
        
        }else{
            
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
            
        }
    }];
    
    return fullText;
}

@end
