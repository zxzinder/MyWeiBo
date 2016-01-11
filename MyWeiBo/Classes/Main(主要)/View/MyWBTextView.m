//
//  MyWBTextView.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/3.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBTextView.h"


@implementation MyWBTextView


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [NotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    
    return self;
    
}

-(void)dealloc{
    
    [NotificationCenter removeObserver:self];
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

-(void)setAttributedText:(NSAttributedString *)attributedText{
    
    [super setAttributedText:attributedText];
    
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
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

@end






