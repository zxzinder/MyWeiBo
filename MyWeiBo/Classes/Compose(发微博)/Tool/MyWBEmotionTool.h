//
//  MyWBEmotionTool.h
//  MyWeiBo
//
//  Created by alexzinder on 16/1/13.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyWBEmotion;

@interface MyWBEmotionTool : NSObject

+(void)addRecentEmotion:(MyWBEmotion *)emotion;

+(NSArray *)recentEmotions;

@end

