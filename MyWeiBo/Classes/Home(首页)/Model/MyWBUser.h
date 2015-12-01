//
//  MyWBUser.h
//  MyWeiBo
//
//  Created by MacMini on 15/11/27.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWBUser : NSObject

//uid
@property (nonatomic, copy) NSString *idstr;

@property (nonatomic, copy) NSString *name;

//头像
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic,assign) int mbtype;
/** 会员等级 */
@property (nonatomic,assign) int mbrank;

@property (nonatomic,assign,getter=isVip) BOOL vip;

@property (nonatomic, copy) NSString *avatar_large;

@end
