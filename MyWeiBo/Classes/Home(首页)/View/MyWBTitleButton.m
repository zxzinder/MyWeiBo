//
//  MyWBTitleButton.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/27.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBTitleButton.h"

@implementation MyWBTitleButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
        self.titleLabel.x = self.imageView.x;
        
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    }
    return  self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.titleLabel.x = self.imageView.x;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    [super setTitle:title forState:state];
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
    
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    
    [super setImage:image forState:state];
    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
    
}

@end
