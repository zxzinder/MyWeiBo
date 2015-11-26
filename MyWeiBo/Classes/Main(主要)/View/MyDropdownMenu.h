//
//  MyDropdownMenu.h
//  MyWeiBo
//
//  Created by MacMini on 15/11/20.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyDropdownMenu;

@protocol MyDropdownMenuDelegate <NSObject>

@optional
-(void)dropdownMenuDidDismiss:(MyDropdownMenu *)menu;
-(void)dropdownMenuDidShow:(MyDropdownMenu *)menu;

@end

@interface MyDropdownMenu : UIView

+(instancetype)menu;

-(void)showFron:(UIView *)from;

-(void)dismiss;

@property (nonatomic, strong) UIView *content;

@property (nonatomic, strong) UIViewController *contentController;

@property (nonatomic, weak) id<MyDropdownMenuDelegate> delegate;

@end
