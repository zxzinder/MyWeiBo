//
//  MyWBEmotionAttachment.m
//  MyWeiBo
//
//  Created by alexzinder on 16/1/12.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "MyWBEmotionAttachment.h"
#import "MyWBEmotion.h"

@implementation MyWBEmotionAttachment

-(void)setEmotion:(MyWBEmotion *)emotion{
    
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
    
}

@end
