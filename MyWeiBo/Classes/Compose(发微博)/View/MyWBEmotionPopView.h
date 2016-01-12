//
//  MyWBEmotionPopView.h
//  MyWeiBo
//
//  Created by alexzinder on 16/1/10.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyWBEmotion,MyWBEmotionButton;

@interface MyWBEmotionPopView : UIView

+(instancetype)popView;

-(void)showFrom:(MyWBEmotionButton *)button;

@end
