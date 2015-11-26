//
//  MyDropdownMenu.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/20.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyDropdownMenu.h"

@interface MyDropdownMenu()

@property (nonatomic, weak)UIImageView *containerView;

@end

@implementation MyDropdownMenu

+(instancetype)menu{
    
    return [[self alloc] init];
    
}

- (UIImageView *)containerView
{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES; // 开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

-(void)setContent:(UIView *)content{

    _content = content;
    
    content.x = 10;
    content.y = 15;
    
    //content.width = self.containerView.width - 2 * content.x;
    
    //设置灰色宽高
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    [self.containerView addSubview:content];
    
    
}

-(void)setContentController:(UIViewController *)contentController{
    
    _contentController = contentController;
    
    self.content = contentController.view;
    
}

-(void)showFron:(UIView *)from{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    self.frame = window.bounds;
    
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX =CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
    
}

-(void)dismiss{
    
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismiss];
    
}

@end

















