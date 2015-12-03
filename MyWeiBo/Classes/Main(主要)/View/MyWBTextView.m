//
//  MyWBTextView.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/3.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBTextView.h"

@implementation MyWBTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [NotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
    
}

-(void)textDidChange{
    
    [self setNeedsDisplay];
    
}

-(void)setPlaceholder:(NSString *)placeholder{
    
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
    
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
    
}

-(void)setText:(NSString *)text{
    
    [super setText:text];
    
    [self setNeedsDisplay];
    
}

-(void)setFont:(UIFont *)font{
    
    [super setFont:font];
    
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect{
     // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) {
        return;
    }
    
    //文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor:[UIColor grayColor];
    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
}

@end






