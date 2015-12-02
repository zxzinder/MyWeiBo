//
//  MyWBStatusToolBar.m
//  MyWeiBo
//
//  Created by MacMini on 15/12/2.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBStatusToolBar.h"
#import "MyWBStatus.h"

@interface MyWBStatusToolBar()
/**
 *  按钮
 */
@property (nonatomic, strong) NSMutableArray *btns;
/**
 *  分割线
 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak)UIButton *repostBtn;
@property (nonatomic, weak)UIButton *commentBtn;
@property (nonatomic, weak)UIButton *attitudeBtn;
@end

@implementation MyWBStatusToolBar

+(instancetype)toolbar{
    
    return [[self alloc] init];
    
    
}

-(NSMutableArray *)btns{
    
    if (_btns == nil) {
        self.btns = [NSMutableArray array];
        
    }
    return _btns;
    
}

-(NSMutableArray *)dividers{
    
    if (_dividers == nil) {
        self.dividers = [NSMutableArray array];
    }
    
    return _dividers;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        //添加按钮
        
        self.repostBtn = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
        
        [self setupDivider];
        [self setupDivider];
    }
    
    return self;
}

-(void)setupDivider{
    
    UIImageView *divider = [[UIImageView alloc] init];
    
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
    
}

-(UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon
                   ] forState:UIControlStateNormal];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

-(void)setStatus:(MyWBStatus *)status{
    
    _status = status;
    
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
    
}

-(void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title{
    
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            
            double wan = count / 10000.0;
            
            title = [NSString stringWithFormat:@"%.1f万",wan];
            
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
        }
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //按钮frame
    NSInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    
    for (int i = 0 ; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btn.width;
        btn.height = btnH;
    }
    
    NSInteger dividerCount = self.dividers.count;
    
    for (int i = 0 ; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i+1) * btnW;
        divider.y = 0;
    }
}

@end


















