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

@implementation MyWBEmotionTool

+(void)addRecentEmotion:(MyWBEmotion *)emotion{
    
    MyLog(@"%@",MyWBRecentEmotionsPath);
    
    //加载沙盒中的表情数据
    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
    
    if (emotions == nil) {
        emotions = [NSMutableArray array];
    }
    //将表情数据放到数组最前面
   // [emotions insertObject:emotion atIndex:0];
     [emotions addObject:emotion];
    //将表情写入沙盒
    [NSKeyedArchiver archiveRootObject:emotions toFile:MyWBRecentEmotionsPath];
}

+(NSArray *)recentEmotions{
    
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:MyWBRecentEmotionsPath];
    
}

@end
