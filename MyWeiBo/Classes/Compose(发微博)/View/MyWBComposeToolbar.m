//
//  MyWBComposeToolbar.m
//  MyWeiBo
//
//  Created by MacMini on 15/12/4.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBComposeToolbar.h"

@implementation MyWBComposeToolbar


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        //初始化按钮
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:ComposeToolbarButtonTypeCamera];
        
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:ComposeToolbarButtonTypePicture];
        
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:ComposeToolbarButtonTypeMention];
        
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:ComposeToolbarButtonTypeTrend];
        
        [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:ComposeToolbarButtonTypeEmotion];
        
    }
    
    return self;
}

-(void)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(ComposeToolbarButtonType)type{
    
    
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    
    [self addSubview:btn];
    
}

-(void)btnClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (NSUInteger i = 0 ; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
    }
    
}

@end









