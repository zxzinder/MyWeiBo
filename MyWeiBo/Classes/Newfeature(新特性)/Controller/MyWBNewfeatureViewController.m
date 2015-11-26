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
#define k_Base_Tag  10000
#define k_Rotate_Rate 1
#define K_SCREEN_WIDHT [UIScreen mainScreen].bounds.size.width  //屏幕宽度
#define K_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高

@interface MyWBNewfeatureViewController()<UIScrollViewDelegate>

@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, weak)UIPageControl *pageControl;
@end

@implementation MyWBNewfeatureViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self normalScroll];
   // [self jumpScroll];
}

-(void)jumpScroll{

    self.view.backgroundColor = MyWBColor(140, 255, 255);
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDHT, K_SCREEN_HEIGHT)];
    mainScrollView.pagingEnabled =YES;
    mainScrollView.bounces = YES;
    mainScrollView.contentSize = CGSizeMake(K_SCREEN_WIDHT * NewfeatureCount, K_SCREEN_HEIGHT);
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    
    //添加图片
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 330, K_SCREEN_WIDHT, 170 * K_SCREEN_WIDHT/1242.0)];
    
    for (int i = 0; i<NewfeatureCount; i++) {
        UIView *rotateView = [[UIView alloc] initWithFrame:CGRectMake(K_SCREEN_WIDHT * i, 0, K_SCREEN_WIDHT, K_SCREEN_HEIGHT * 2)];
        [rotateView setTag:k_Base_Tag + i];
        [mainScrollView addSubview:rotateView];
        if (i!= 0) {
            rotateView.alpha = 0;
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDHT, K_SCREEN_HEIGHT)];
        NSString *imgName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:imgName];
        
        [rotateView addSubview:imageView];
        
        if (i == NewfeatureCount -1) {
            [self setupLastImageView:imageView];
        }
    }
    
    UIView *firstView = [mainScrollView viewWithTag:k_Base_Tag];
    [mainScrollView bringSubviewToFront:firstView];
    
}

-(void)normalScroll{
    
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
-(BOOL)shouldAutorotate
{
    return YES;
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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

-(void)setImageJump:(UIScrollView *)scrollView{
    
    UIView * view1 = [scrollView viewWithTag:k_Base_Tag];
    UIView * view2 = [scrollView viewWithTag:k_Base_Tag+1];
    UIView * view3 = [scrollView viewWithTag:k_Base_Tag+2];
    UIView * view4 = [scrollView viewWithTag:k_Base_Tag+3];
    
    UIImageView * imageView1 = (UIImageView *)[scrollView viewWithTag:k_Base_Tag*2];
    UIImageView * imageView2 = (UIImageView *)[scrollView viewWithTag:k_Base_Tag*2+1];
    UIImageView * imageView3 = (UIImageView *)[scrollView viewWithTag:k_Base_Tag*2+2];
    UIImageView * imageView4 = (UIImageView *)[scrollView viewWithTag:k_Base_Tag*2+3];
    
    
    CGFloat xOffset = scrollView.contentOffset.x;
    
    //根据偏移量旋转
    CGFloat rotateAngle = -1 * 1.0/K_SCREEN_WIDHT * xOffset * M_PI_2 * k_Rotate_Rate;
    view1.layer.transform = CATransform3DMakeRotation(rotateAngle, 0, 0, 1);
    view2.layer.transform = CATransform3DMakeRotation(M_PI_2*1+rotateAngle, 0, 0, 1);
    view3.layer.transform = CATransform3DMakeRotation(M_PI_2*2+rotateAngle, 0, 0, 1);
    view4.layer.transform = CATransform3DMakeRotation(M_PI_2*3+rotateAngle, 0, 0, 1);
    
    //根据偏移量位移（保证中心点始终都在屏幕下方中间）
    view1.center = CGPointMake(0.5 * K_SCREEN_WIDHT+xOffset, K_SCREEN_HEIGHT);
    view2.center = CGPointMake(0.5 * K_SCREEN_WIDHT+xOffset, K_SCREEN_HEIGHT);
    view3.center = CGPointMake(0.5 * K_SCREEN_WIDHT+xOffset, K_SCREEN_HEIGHT);
    view4.center = CGPointMake(0.5 * K_SCREEN_WIDHT+xOffset, K_SCREEN_HEIGHT);
    
    //当前哪个视图放在最上面
    if (xOffset<K_SCREEN_WIDHT*0.5) {
        [scrollView bringSubviewToFront:view1];
        
    }else if (xOffset>=K_SCREEN_WIDHT*0.5 && xOffset < K_SCREEN_WIDHT*1.5){
        [scrollView bringSubviewToFront:view2];
        
        
    }else if (xOffset >=K_SCREEN_WIDHT*1.5 && xOffset < K_SCREEN_WIDHT*2.5){
        [scrollView bringSubviewToFront:view3];
        
    }else if (xOffset >=K_SCREEN_WIDHT*2.5)
    {
        [scrollView bringSubviewToFront:view4];
        
    }
    
    //调节其透明度
    CGFloat xoffset_More = xOffset*1.5>K_SCREEN_WIDHT?K_SCREEN_WIDHT:xOffset*1.5;
    if (xOffset < K_SCREEN_WIDHT) {
        view1.alpha = (K_SCREEN_WIDHT - xoffset_More)/K_SCREEN_WIDHT;
        imageView1.alpha = (K_SCREEN_WIDHT - xOffset)/K_SCREEN_WIDHT;;
        
    }
    if (xOffset <= K_SCREEN_WIDHT) {
        view2.alpha = xoffset_More / K_SCREEN_WIDHT;
        imageView2.alpha = xOffset / K_SCREEN_WIDHT;
    }
    if (xOffset >K_SCREEN_WIDHT && xOffset <= K_SCREEN_WIDHT*2) {
        view2.alpha = (K_SCREEN_WIDHT*2 - xOffset)/K_SCREEN_WIDHT;
        view3.alpha = (xOffset - K_SCREEN_WIDHT)/ K_SCREEN_WIDHT;
        
        imageView2.alpha = (K_SCREEN_WIDHT*2 - xOffset)/K_SCREEN_WIDHT;
        imageView3.alpha = (xOffset - K_SCREEN_WIDHT)/ K_SCREEN_WIDHT;
    }
    if (xOffset >K_SCREEN_WIDHT*2 ) {
        view3.alpha = (K_SCREEN_WIDHT*3 - xOffset)/K_SCREEN_WIDHT;
        view4.alpha = (xOffset - K_SCREEN_WIDHT*2)/ K_SCREEN_WIDHT;
        
        imageView3.alpha = (K_SCREEN_WIDHT*3 - xOffset)/K_SCREEN_WIDHT;
        imageView4.alpha = (xOffset - K_SCREEN_WIDHT*2)/ K_SCREEN_WIDHT;
    }
    
    //调节背景色
    if (xOffset <K_SCREEN_WIDHT && xOffset>0) {
        self.view.backgroundColor = [UIColor colorWithRed:(140-40.0/K_SCREEN_WIDHT*xOffset)/255.0 green:(255-25.0/K_SCREEN_WIDHT*xOffset)/255.0 blue:(255-100.0/K_SCREEN_WIDHT*xOffset)/255.0 alpha:1];
        
    }else if (xOffset>=K_SCREEN_WIDHT &&xOffset<K_SCREEN_WIDHT*2){
        
        self.view.backgroundColor = [UIColor colorWithRed:(100+30.0/K_SCREEN_WIDHT*(xOffset-K_SCREEN_WIDHT))/255.0 green:(230-40.0/K_SCREEN_WIDHT*(xOffset-K_SCREEN_WIDHT))/255.0 blue:(155-5.0/320*(xOffset-K_SCREEN_WIDHT))/255.0 alpha:1];
        
    }else if (xOffset>=K_SCREEN_WIDHT*2 &&xOffset<K_SCREEN_WIDHT*3){
        
        self.view.backgroundColor = [UIColor colorWithRed:(130-50.0/K_SCREEN_WIDHT*(xOffset-K_SCREEN_WIDHT*2))/255.0 green:(190-40.0/K_SCREEN_WIDHT*(xOffset-K_SCREEN_WIDHT*2))/255.0 blue:(150+50.0/K_SCREEN_WIDHT*(xOffset-K_SCREEN_WIDHT*2))/255.0 alpha:1];
        
    }else if (xOffset>=K_SCREEN_WIDHT*3 &&xOffset<K_SCREEN_WIDHT*4){
        
        self.view.backgroundColor = [UIColor colorWithRed:(80-10.0/K_SCREEN_WIDHT*(xOffset-K_SCREEN_WIDHT*3))/255.0 green:(150-25.0/K_SCREEN_WIDHT*(xOffset-K_SCREEN_WIDHT*3))/255.0 blue:(200-90.0/K_SCREEN_WIDHT*(xOffset-K_SCREEN_WIDHT*3))/255.0 alpha:1];
    }
    
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














