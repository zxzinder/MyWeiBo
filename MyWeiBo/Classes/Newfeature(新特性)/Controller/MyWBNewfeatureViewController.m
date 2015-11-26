//
//  MyWBNewfeatureViewController.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/25.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBNewfeatureViewController.h"
#import "MyWBTabBarViewController.h"
#define NewfeatureCount 4

@interface MyWBNewfeatureViewController()<UIScrollViewDelegate>

@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, weak)UIPageControl *pageControl;
@end

@implementation MyWBNewfeatureViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    scrollView.frame = self.view.bounds;
    //scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i=0; i< NewfeatureCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        
        NSString *imgName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:imgName];
        
        [scrollView addSubview:imageView];
        if (i == NewfeatureCount -1) {
            [self setupLastImageView:imageView];
        }
        
    }
    
    scrollView.contentSize = CGSizeMake(NewfeatureCount * scrollW, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.numberOfPages = NewfeatureCount;
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = MyWBColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = MyWBColor(189, 189, 189);
    
    
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    double page = scrollView.contentOffset.x / scrollView.width;
    int  currentPage = (int)(page + 0.5);
    self.pageControl.currentPage = currentPage;
    
    //MyLog(@"%f %d",page,currentPage);
    
}

-(void)setupLastImageView:(UIImageView *)imageView{
    
    imageView.userInteractionEnabled = YES;
    
    //1.分享按钮
    UIButton *shareBtn = [[UIButton alloc] init];
    
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    // titleEdgeInsets:只影响按钮内部的titleLabel
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:shareBtn];
    
    //2.开始微博按钮
    UIButton *startBtn =[[UIButton alloc] init];
    
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    startBtn.backgroundColor =[UIColor redColor];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:startBtn];
}

-(void)startClick{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[MyWBTabBarViewController alloc] init];
    
}
-(void)shareClick:(UIButton *)shareBtn{
    
    shareBtn.selected = !shareBtn.isSelected;
    
}

- (void)dealloc
{
    MyLog(@"HWNewfeatureViewController-dealloc");
}
@end














