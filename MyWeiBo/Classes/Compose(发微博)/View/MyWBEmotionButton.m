//
//  MyWBEmotionButton.m
//  MyWeiBo
//
//  Created by alexzinder on 16/1/10.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "MyWBEmotionButton.h"
#import "MyWBEmotion.h"

@implementation MyWBEmotionButton
/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
    
}
/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
    
}

-(void)setup{
    
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    
}

-(void)setEmotion:(MyWBEmotion *)emotion{
    
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else if (emotion.code){
        
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}

@end
