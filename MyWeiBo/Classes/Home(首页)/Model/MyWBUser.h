//
//  MyWBUser.h
//  MyWeiBo
//
//  Created by MacMini on 15/11/27.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UserVerifiedTypeNone = -1,//无认证
    UserVerifiedPersonal = 0,//个人认证
    UserVerifiedOrgEnterprice = 2 ,//企业官方
    UserVerifiedOrgMedia = 3,//媒体官方
    UserVerifiedOrgWebsite = 5,//网站官方
    UserVerifiedDaren = 220//微博达人
} UserVerifiedType;

@interface MyWBUser : NSObject

//uid
@property (nonatomic, copy) NSString *idstr;

@property (nonatomic, copy) NSString *name;

/**
 *  小头像
 */
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic,assign) int mbtype;
/** 会员等级 */
@property (nonatomic,assign) int mbrank;

@property (nonatomic,assign,getter=isVip) BOOL vip;
/**
 *  大头像
 */
@property (nonatomic, copy) NSString *avatar_large;
/**
 *  认证类型
 */
@property (nonatomic,assign) UserVerifiedType verified_type;

@end
