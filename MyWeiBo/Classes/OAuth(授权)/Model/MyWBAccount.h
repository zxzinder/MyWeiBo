//
//  MyWBAccount.h
//  MyWeiBo
//
//  Created by MacMini on 15/11/26.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWBAccount : NSObject <NSCoding>


@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSNumber *expires_in;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSDate *created_time;


@property (nonatomic, copy) NSString *name;


+(instancetype)accountWithDict:(NSDictionary *)dict;

@end
