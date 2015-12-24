//
//  MyWBEmotionPageView.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/24.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBEmotionPageView.h"
#import "MyWBEmotion.h"

@implementation MyWBEmotionPageView

-(void)setEmotions:(NSArray *)emotions{
    
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    
    for (int i = 0;  i< count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        MyWBEmotion *emotion = emotions[i];
        
        if (emotion.png) {
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        }else if(emotion.code){
            
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
            
            
        }
        
        [self addSubview:btn];
        
    }
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat inset = 20;//内边距
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / MyEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / MyEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % MyEmotionMaxCols) * btnW;
        btn.y = inset + (i / MyEmotionMaxCols) * btnH;
    }
    
}



@end
