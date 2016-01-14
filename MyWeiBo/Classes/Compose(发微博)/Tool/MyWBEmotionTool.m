//
//  MyWBEmotionTool.m
//  MyWeiBo
//
//  Created by alexzinder on 16/1/13.
//  Copyright © 2016年 MacMini. All rights reserved.
//
// 最近表情的存储路径
#define MyWBRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]


#import "MyWBEmotionTool.h"
#import "MyWBEmotion.h"

@implementation MyWBEmotionTool

static NSMutableArray *_recentEmotions;

+(void)initialize{
    
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:MyWBRecentEmotionsPath];
    
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
    
}

+(void)addRecentEmotion:(MyWBEmotion *)emotion{
    
    MyLog(@"%@",MyWBRecentEmotionsPath);
    
    [_recentEmotions removeObject:emotion];
    
    [_recentEmotions insertObject:emotion atIndex:0];

    //将表情写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:MyWBRecentEmotionsPath];
   
}

+(NSArray *)recentEmotions{
    
    
    return _recentEmotions;
    
}

@end
