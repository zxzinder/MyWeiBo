//
//  MyWBEmotionListView.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/9.
//  Copyright © 2015年 MacMini. All rights reserved.
//  表情键盘顶部的表情内容（显示所有表情）

#import "MyWBEmotionListView.h"
//每页表情数
#define MyWBEmotionPageSize 20

@interface MyWBEmotionListView()<UIScrollViewDelegate>

@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,weak)UIPageControl *pageControl;


@end

@implementation MyWBEmotionListView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor redColor];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
    }
    
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    
    _emotions = emotions;
    
    NSUInteger count = (emotions.count + MyWBEmotionPageSize - 1) / MyWBEmotionPageSize;
    
    self.pageControl.numberOfPages = count;
    
    for (int i = 0 ; self.pageControl.numberOfPages; i++) {
        UIView *pageView = [[UIView alloc ] init];
        pageView.backgroundColor = MyWBRandomColor;
        [self.scrollView addSubview:pageView];
        
    }
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    self.scrollView.x = self.scrollView.y = 0;
    
    
    NSUInteger count = self.scrollView.subviews.count;
    
    for (int i = 0; i<count; i++) {
        UIView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
    
}

@end

















