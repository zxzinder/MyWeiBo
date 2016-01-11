//
//  MyWBEmotionPopView.m
//  MyWeiBo
//
//  Created by alexzinder on 16/1/10.
//  Copyright © 2016年 MacMini. All rights reserved.
//

#import "MyWBEmotionPopView.h"
#import "MyWBEmotion.h"
#import "MyWBEmotionButton.h"

@interface MyWBEmotionPopView()

@property (weak, nonatomic) IBOutlet MyWBEmotionButton *emotionButton;

@end

@implementation MyWBEmotionPopView

+(instancetype)popView{

    UIView *pv = [[[NSBundle mainBundle] loadNibNamed:@"MyWBEmotionPopView" owner:nil options:nil] lastObject];
    MyLog(@"%f",pv.height);
    return [[[NSBundle mainBundle] loadNibNamed:@"MyWBEmotionPopView" owner:nil options:nil] lastObject];
    
}

-(void)setEmotion:(MyWBEmotion *)emotion{
    
    _emotion = emotion;
    
    self.emotionButton.emotion = emotion;
    
}

@end
