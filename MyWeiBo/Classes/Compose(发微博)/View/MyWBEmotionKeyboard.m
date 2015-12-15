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
#import "MyWBEmotion.h"
#import "YYModel.h"

@interface MyWBEmotionKeyboard()<MyWBEmotionTabBarDelegate>

@property (nonatomic,weak)UIView *contentView;

@property (nonatomic,strong)MyWBEmotionListView *recentListView;
@property (nonatomic,strong)MyWBEmotionListView *defaultView;
@property (nonatomic,strong)MyWBEmotionListView *emojiListView;
@property (nonatomic,strong)MyWBEmotionListView *lxhListView;

@property (nonatomic,weak)MyWBEmotionTabBar *tabBar;
@end

@implementation MyWBEmotionKeyboard

-(MyWBEmotionListView *)recentListView{
    
    if (!_recentListView) {
        self.recentListView = [[MyWBEmotionListView alloc] init];
        self.recentListView.backgroundColor = MyWBRandomColor;
    }
    
    return _recentListView;
    
}

-(MyWBEmotionListView *)defaultView{
    
    if (!_defaultView) {
        self.defaultView = [[MyWBEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        self.defaultView.emotions = [self arrayToArray:arr];
        
        self.defaultView.backgroundColor = MyWBRandomColor;
        
    }
    
    return _defaultView;
    
}
-(MyWBEmotionListView *)emojiListView{
    
    if (!_emojiListView) {
        self.emojiListView = [[MyWBEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        self.emojiListView.emotions = [self arrayToArray:arr];
        
        self.emojiListView.backgroundColor = MyWBRandomColor;
        
    }
    
    return _emojiListView;
    
}
-(MyWBEmotionListView *)lxhListView{
    
    if (!_lxhListView) {
        self.lxhListView = [[MyWBEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        
        self.lxhListView.emotions = [self arrayToArray:arr];
        
        self.lxhListView.backgroundColor = MyWBRandomColor;
        
    }
    
    return _lxhListView;
    
}
-(NSMutableArray *)arrayToArray:(NSArray *)arr{
    
    NSMutableArray *newEmotions = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        MyWBEmotion *emotion = [MyWBEmotion yy_modelWithDictionary:dict];
        [newEmotions addObject:emotion];
    }
    
    return newEmotions;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
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
    
    self.contentView.x = self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabBar.y;
    
    UIView *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;
    
}

#pragma mark - MyWBEmotionTabBarDelegate

-(void)emotionTabBar:(MyWBEmotionTabBar *)tabBar didSelectButton:(MyWBEmotionTabBarButtonType)buttonType{
    
    switch (buttonType) {
        case MyWBEmotionTabBarButtonTypeDefault:
            [self.contentView addSubview:self.recentListView];
            break;
        case MyWBEmotionTabBarButtonTypeRecent:
            [self.contentView addSubview:self.defaultView];
            break;
        case MyWBEmotionTabBarButtonTypeEmoji:
            [self.contentView addSubview:self.emojiListView];
            break;
        case MyWBEmotionTabBarButtonTypeLxh:
            [self.contentView addSubview:self.lxhListView];
            break;
    }
    
    [self setNeedsLayout];
    
}

@end













