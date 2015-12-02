//
//  MyWBStatusToolBar.h
//  MyWeiBo
//
//  Created by MacMini on 15/12/2.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyWBStatus;

@interface MyWBStatusToolBar : UIView

+(instancetype)toolbar;

@property (nonatomic, strong) MyWBStatus *status;

@end
