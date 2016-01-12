//
//  MyWBEmotionTextView.h
//  MyWeiBo
//
//  Created by alexzinder on 16/1/11.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "MyWBTextView.h"
@class MyWBEmotion;
@interface MyWBEmotionTextView : MyWBTextView

- (void)insertEmotion:(MyWBEmotion *)emotion;

-(NSString *)fullText;

@end
