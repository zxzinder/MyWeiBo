//
//  MyWBEmotionTextView.m
//  MyWeiBo
//
//  Created by alexzinder on 16/1/11.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "MyWBEmotionTextView.h"
#import "MyWBEmotion.h";

@implementation MyWBEmotionTextView

-(void)insertEmotion:(MyWBEmotion *)emotion{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    }else if(emotion.png){
        
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        
        attch.image = [UIImage imageNamed:emotion.png];
        CGFloat attachWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        //根据文字创建属性文字
        NSAttributedString *imgStr = [NSMutableAttributedString attributedStringWithAttachment:attch];
        
        [self insertAttributeText:imgStr];
        
    }
    
}

@end
