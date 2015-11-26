//
//  UIWindow+Extension.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/26.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MyWBTabBarViewController.h"
#import "MyWBNewfeatureViewController.h"

@implementation UIWindow (Extension)

-(void)switchRootViewController{
    
    //切换窗口的控制器
    NSString *key = @"CFBundleVersion";
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [[MyWBTabBarViewController alloc] init];
    }else{
        
        self.rootViewController = [[MyWBNewfeatureViewController alloc] init];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
}

@end
