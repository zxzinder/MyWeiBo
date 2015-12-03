//
//  MyWBHomeViewController.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/18.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBHomeViewController.h"
#import "MySearchBar.h"
#import "MyDropdownMenu.h"
#import "MyWBTitleMenuViewController.h"
#import "MyWBAccount.h"
#import "MyWBAccountTool.h"
#import "AFNetworking.h"
#import "MyWBTitleButton.h"
#import "UIImageView+WebCache.h"
#import "YYModel.h"
#import "MyWBStatus.h"
#import "MyWBUser.h"
#import "MyWBLoadMoreFooter.h"
#import "MyWBStatusCell.h"
#import "MyWBStatusFrame.h"

@interface MyWBHomeViewController ()<MyDropdownMenuDelegate>

@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation MyWBHomeViewController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = MyWBColor(211, 211, 211);
    
    [self setupNav];
    
    [self setupUserInfo];
    
    [self setupDownRefresh];
    
    [self setupUpRefresh];
    
    //获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self setupDownRefresh];
    
}

-(void)setupUserInfo{
    
    MyWBAccount *account = [MyWBAccountTool account];
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        
        NSString *name = dict[@"name"];
        
        [titleBtn setTitle:name forState:UIControlStateNormal];
        
        account.name = name;
        
        [MyWBAccountTool saveAccount:account];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"请求失败---%@",error);
    }];
    
    
}

-(void)setupNav{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    MyWBTitleButton *titleBtn = [[MyWBTitleButton alloc] init];
    
    //设置图片和文字
    NSString *name = [MyWBAccountTool account].name;
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
    
}


-(void)setupDownRefresh{
    
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:control];
    
    [control beginRefreshing];
    
    [self refreshStateChange:control];
    
}


-(void)setupUpRefresh{
    
    MyWBLoadMoreFooter *footer = [MyWBLoadMoreFooter footer];
    
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
}

-(void)refreshStateChange:(UIRefreshControl *)control{
    
    
    //读取测试数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        NSDictionary *responseObject = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fakeStatus" ofType:@"plist"]];
//        // 将 "微博字典"数组 转为 "微博模型"数组
//        NSArray *arr = responseObject[@"statuses"];
//        NSMutableArray *newStatuses = [NSMutableArray array];
//        for (NSDictionary *dicts in arr) {
//            MyWBStatus *status =[MyWBStatus yy_modelWithDictionary:dicts];
//            // MyLog(@"%d",status.retweeted_status.pic_urls.count);
//            [newStatuses addObject:status];
//        }
//        // 将 HWStatus数组 转为 HWStatusFrame数组
//        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
//        
//        // 将最新的微博数据，添加到总数组的最前面
//        NSRange range = NSMakeRange(0, newFrames.count);
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statusFrames insertObjects:newFrames atIndexes:set];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 结束刷新
//        [control endRefreshing];
//        
//        // 显示最新微博的数量
//        [self showNewStatusCount:newStatuses.count];
//        
//    });
//    
//    return;
    
    AFHTTPSessionManager *mgr =[AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    MyWBAccount *account = [MyWBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    //取出最前面的微博
    MyWBStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *arr = dict[@"statuses"];
        //MyLog(@"%@",arr);
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSMutableArray *newStatuses = [NSMutableArray array];
        for (NSDictionary *dicts in arr) {
            MyWBStatus *status =[MyWBStatus yy_modelWithDictionary:dicts];
           // MyLog(@"verified_type ---- :%d",status.user.verified_type);
            [newStatuses addObject:status];
        }
           // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set =[NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        [self.tableView reloadData];
        
        [control endRefreshing];
        
        [self showNewStatusCount:newFrames.count];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"请求失败-%@",error);
        
        [control endRefreshing];
    }];
}

-(void)showNewStatusCount:(NSInteger)count{
    
    UILabel *label = [[UILabel alloc] init];
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    label.width = [UIScreen mainScreen].bounds.size.width;
    
    label.height = 35;
    
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
        
    }else{
        
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",(long)count];
        
    }
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:16];
    
    label.y = 64 - label.height;
     // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
     // 先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

-(void)loadMoreStatus{
    
    AFHTTPSessionManager *mgr =[AFHTTPSessionManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    MyWBAccount *account = [MyWBAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = account.access_token;
    
    MyWBStatusFrame *lastStatus = [self.statusFrames lastObject];
    
    if (lastStatus) {
        long long maxId = lastStatus.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = dict[@"statuses"];
        
        NSMutableArray *newStatuses = [NSMutableArray array];
        for (NSDictionary *dicts in arr) {
            MyWBStatus *status =[MyWBStatus yy_modelWithDictionary:dicts];
            [newStatuses addObject:status];
            
            
        }
        
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        [self.statusFrames addObjectsFromArray:newFrames];
        
        [self.tableView reloadData];
        
        self.tableView.tableFooterView.hidden = YES;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"请求失败-%@",error);
        
        self.tableView.tableFooterView.hidden = YES;
    }];
    
    
}

-(void)setupUnreadCount{
    
    //MyLog(@"setupUnreadCount");
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    MyWBAccount *account = [MyWBAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *status = [dict[@"status"] description];
        
        if ([status isEqualToString:@"0"]) {
            //MyLog(@"unread------0");
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            // MyLog(@"unread------%@",status);
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"请求失败-%@", error);

    }];
    
}

-(NSArray *)statusFramesWithStatuses:(NSArray *)statuses{
    
    NSMutableArray *frames = [NSMutableArray array];
    
    for (MyWBStatus *status in statuses) {
        MyWBStatusFrame *f = [[MyWBStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
    
}

-(void)titleClick:(UIButton *)titleBtn{
    
    MyDropdownMenu *menu = [MyDropdownMenu menu];
    menu.delegate = self;
    // 设置内容
   // menu.content = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    
    
    MyWBTitleMenuViewController *vc = [[MyWBTitleMenuViewController alloc] init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;
    
    [menu showFron:titleBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)friendSearch
{
    MyLog(@"friendSearch");
}

- (void)pop
{
    MyLog(@"pop");
}

#pragma mark - HWDropdownMenuDelegate

-(void)dropdownMenuDidDismiss:(MyDropdownMenu *)menu{
    
    //NSLog(@"Dismiss");
    UIButton *titlebBtn = (UIButton *)self.navigationItem.titleView;
    titlebBtn.selected = NO;
    
}

-(void)dropdownMenuDidShow:(MyDropdownMenu *)menu{
    // NSLog(@"DidShow");
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyWBStatusCell *cell = [MyWBStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyWBStatusFrame *frame = self.statusFrames[indexPath.row];
    
    return frame.cellHeight;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) {
        return;
    }
    
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    //MyLog(@"%f %f",offsetY,judgeOffsetY);
    if (offsetY >= judgeOffsetY) {
        self.tableView.tableFooterView.hidden = NO;
    
        [self loadMoreStatus];
        //MyLog(@"加载数据中...");
    }
}

/**
 1.将字典转为模型
 2.能够下拉刷新最新的微博数据
 3.能够上拉加载更多的微博数据
 */
@end















