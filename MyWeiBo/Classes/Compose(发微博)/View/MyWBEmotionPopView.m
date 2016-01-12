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

    return [[[NSBundle mainBundle] loadNibNamed:@"MyWBEmotionPopView" owner:nil options:nil] lastObject];
    
}

-(void)showFrom:(MyWBEmotionButton *)button{
    
    if (button == nil) {
        return;
    }
    
    self.emotionButton.emotion = button.emotion;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    
    self.y = CGRectGetMidY(btnFrame) - self.height;
    
    self.centerX = CGRectGetMidX(btnFrame);
    
    
}

@end
