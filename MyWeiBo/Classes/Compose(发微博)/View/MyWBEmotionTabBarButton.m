//
//  MyWBEmotionTabBarButton.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/9.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBEmotionTabBarButton.h"


@implementation MyWBEmotionTabBarButton



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
    }
    
    return self;
    
}

-(void)setHighlighted:(BOOL)highlighted{
    
    
}

@end
