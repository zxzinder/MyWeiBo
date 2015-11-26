//
//  MyWBTabBarViewController.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/18.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBTabBarViewController.h"
#import "MyWBHomeViewController.h"
#import "MyWBDiscoverViewController.h"
#import "MyWBMessageCenterViewController.h"
#import "MyWBProfileViewController.h"
#import "MyWBNavigationController.h"
#import "MyWBTabBar.h"


@interface MyWBTabBarViewController ()<MyWBTabBarDelegate>

@end

@implementation MyWBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MyWBHomeViewController *home = [[MyWBHomeViewController alloc] init];
    
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    MyWBMessageCenterViewController *messageCenter = [[MyWBMessageCenterViewController alloc] init];
    
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    MyWBDiscoverViewController *discover = [[MyWBDiscoverViewController alloc] init];
    
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    MyWBProfileViewController *profile = [[MyWBProfileViewController alloc] init];
    
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    MyWBTabBar *tabBar =[[MyWBTabBar alloc] init];
    
    tabBar.delegate = self;
    
    [self setValue:tabBar forKey:@"tabBar"];
    
}



-(void)addChildVc:(UITableViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
     // 同时设置tabbar和navigationBar的文字
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    
    textAttrs[NSForegroundColorAttributeName] = MyWBColor(123, 123, 123);
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    //childVc.view.backgroundColor = [UIColor whiteColor];
    
    
    MyWBNavigationController *nav =[[MyWBNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarDidClickPlusButton:(MyWBTabBar *)tabBar{
    
    UIViewController *vc = [[UIViewController alloc ] init];
    
    vc.view.backgroundColor = [UIColor redColor];
    
    [self presentViewController:vc
                       animated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
