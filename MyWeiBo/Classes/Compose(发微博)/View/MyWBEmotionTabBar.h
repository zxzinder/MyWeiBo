//
//  MyWBEmotionTabBar.h
//  MyWeiBo
//
//  Created by alexzinder on 15/12/9.
//  Copyright © 2015年 MacMini. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>

typedef enum {
    
    MyWBEmotionTabBarButtonTypeRecent, // 最近
    MyWBEmotionTabBarButtonTypeDefault, // 默认
    MyWBEmotionTabBarButtonTypeEmoji, // emoji
    MyWBEmotionTabBarButtonTypeLxh, // 浪小花
    
} MyWBEmotionTabBarButtonType;

@class MyWBEmotionTabBar;

@protocol MyWBEmotionTabBarDelegate <NSObject>

@optional
-(void)emotionTabBar:(MyWBEmotionTabBar *)tabBar didSelectButton:(MyWBEmotionTabBarButtonType)buttonType;

@end

@interface MyWBEmotionTabBar : UIView

@property (nonatomic,weak)id<MyWBEmotionTabBarDelegate> delegate;

@end
