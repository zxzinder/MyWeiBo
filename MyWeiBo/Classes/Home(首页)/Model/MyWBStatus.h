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


/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;




/** 微博配图地址。多图时返回多图链接。无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;


/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic, strong) MyWBStatus *retweeted_status;

/**
 *  转发数
 */
@property (nonatomic,assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic,assign) int comments_count;
/**
 *  点赞数
 */
@property (nonatomic,assign) int attitudes_count;

@end
