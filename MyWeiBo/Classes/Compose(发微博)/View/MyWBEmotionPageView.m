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

@property (nonatomic,weak)UIButton *deleteBtn;

@end

@implementation MyWBEmotionPageView

-(MyWBEmotionPopView *)popView{
    
    if (!_popView) {
        self.popView = [MyWBEmotionPopView popView];
    }
    
    return _popView;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        UIButton *deleteBtn = [[UIButton alloc] init];
        
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
    }
    
    return self;
    
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

-(void)deleteClick{
    
    MyLog(@"deleteClick");
}

-(void)btnClick:(MyWBEmotionButton *)btn{
    
    
    self.popView.emotion = btn.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self.popView];
    
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];

    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    
    self.popView.centerX = CGRectGetMidX(btnFrame);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[MyWBSelectEmotionKey] = btn.emotion;
    [NotificationCenter postNotificationName:MyWBEmotionDidSelectNotification object:nil userInfo:userInfo];
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
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.x = self.width - inset - btnW;
    self.deleteBtn.y = self.height - btnH;
    
}



@end
