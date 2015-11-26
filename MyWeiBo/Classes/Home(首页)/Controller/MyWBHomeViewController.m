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
@interface MyWBHomeViewController ()<MyDropdownMenuDelegate>

@end

@implementation MyWBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpUserInfo];
    
}

-(void)setUpUserInfo{
    
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

-(void)setUpNav{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    UIButton *titleBtn = [[UIButton alloc] init];
    
    titleBtn.width = 150;
    titleBtn.height=30;
    
    //设置图片和文字
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
    
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
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
}

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
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


@end
