//
//  MyWBTabBar.h
//  MyWeiBo
//
//  Created by MacMini on 15/11/24.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyWBTabBar;

@protocol MyWBTabBarDelegate <UITabBarDelegate>

@optional
-(void)tabBarDidClickPlusButton:(MyWBTabBar *)tabBar;

@end

@interface MyWBTabBar : UITabBar

@property (nonatomic, weak)  id<MyWBTabBarDelegate> delegate;

@end
