//
//  MyWBEmotionKeyboard.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/9.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBEmotionKeyboard.h"
#import "MyWBEmotionListView.h"
#import "MyWBEmotionTabBar.h"

@interface MyWBEmotionKeyboard()<MyWBEmotionTabBarDelegate>

@property (nonatomic,weak)MyWBEmotionListView *listView;

@property (nonatomic,weak)MyWBEmotionTabBar *tabBar;
@end

@implementation MyWBEmotionKeyboard

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        MyWBEmotionListView *listView = [[MyWBEmotionListView alloc] init];
        listView.backgroundColor = MyWBRandomColor;
        [self addSubview:listView];
        self.listView = listView;
        
        MyWBEmotionTabBar *tabBar = [[MyWBEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.tabBar.width = self.width;
    self.tabBar.height = 44;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    self.listView.x = self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
    
}

#pragma mark - MyWBEmotionTabBarDelegate

-(void)emotionTabBar:(MyWBEmotionTabBar *)tabBar didSelectButton:(MyWBEmotionTabBarButtonType)buttonType{
    
    switch (buttonType) {
        case MyWBEmotionTabBarButtonTypeDefault:
            MyLog(@"默认");
            break;
        case MyWBEmotionTabBarButtonTypeRecent:
            MyLog(@"最近");
            break;
        case MyWBEmotionTabBarButtonTypeEmoji:
            MyLog(@"Emoji");
            break;
        case MyWBEmotionTabBarButtonTypeLxh:
            MyLog(@"浪小花");
            break;
    }
    
}

@end













