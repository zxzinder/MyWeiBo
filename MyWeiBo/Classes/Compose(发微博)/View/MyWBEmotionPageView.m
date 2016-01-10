//
//  MyWBEmotionPageView.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/24.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBEmotionPageView.h"
#import "MyWBEmotion.h"
#import "MyWBEmotionButton.h"
#import "MyWBEmotionPopView.h"

@interface MyWBEmotionPageView()

@property (nonatomic,strong)MyWBEmotionPopView *popView;

@end

@implementation MyWBEmotionPageView

-(MyWBEmotionPopView *)popViewP{
    
    if (!_popView) {
        self.popView = [MyWBEmotionPopView popView];
    }
    
    return _popView;
    
}



-(void)setEmotions:(NSArray *)emotions{
    
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    
    for (int i = 0;  i< count; i++) {
        MyWBEmotionButton *btn = [[MyWBEmotionButton alloc] init];
        [self addSubview:btn];
        
        btn.emotion = emotions[i];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)btnClick:(MyWBEmotionButton *)btn{

    self.popView.emotion = btn.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self.popView];
    
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    self.popView.centerX = CGRectGetMinX(btnFrame);
    
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
