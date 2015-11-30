//
//  MyWBStatus.h
//  MyWeiBo
//
//  Created by MacMini on 15/11/27.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyWBUser;

@interface MyWBStatus : NSObject
//微博id
@property (nonatomic, copy) NSString *idstr;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) MyWBUser *user;

@end
