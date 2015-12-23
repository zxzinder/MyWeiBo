//
//  MyWBEmotionTabBar.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/9.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBEmotionTabBar.h"
#import "MyWBEmotionTabBarButton.h"

@interface MyWBEmotionTabBar()

@property (nonatomic,weak)MyWBEmotionTabBarButton *selectedBtn;

@end

@implementation MyWBEmotionTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupBtn:@"最近" type:MyWBEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" type:MyWBEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" type:MyWBEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" type:MyWBEmotionTabBarButtonTypeLxh];
    }
    
    return self;
    
}

-(MyWBEmotionTabBarButton *)setupBtn:(NSString *)title type:(MyWBEmotionTabBarButtonType)type{
    
    
    MyWBEmotionTabBarButton *btn = [[MyWBEmotionTabBarButton alloc] init];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = type;
    
    [self addSubview:btn];
    
    
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectedImage = @"compose_emotion_table_mid_selected";
    
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectedImage = @"compose_emotion_table_left_selected";
    }else if(self.subviews.count == 4){
        
        image = @"compose_emotion_table_right_normal";
        selectedImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateDisabled];
    
    return btn;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger btnCount = self.subviews.count;
    
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    
    for (int i = 0 ; i < btnCount; i++) {
        MyWBEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
    }
    
}

//-(void)setDelegate:(id<MyWBEmotionTabBarDelegate>)delegate{
//    
//    _delegate = delegate;
//    //选中"默认"按钮
//    [self btnClick:(MyWBEmotionTabBarButton *)[self viewWithTag:MyWBEmotionTabBarButtonTypeDefault]];
//    
//}

-(void)btnClick:(MyWBEmotionTabBarButton *)btn{
    
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
    
}

@end
