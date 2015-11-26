//
//  MyWBAccountTool.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/26.
//  Copyright © 2015年 MacMini. All rights reserved.
//
// 账号的存储路径
#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "MyWBAccountTool.h"
#import "MyWBAccount.h"


@implementation MyWBAccountTool

+(void)saveAccount:(MyWBAccount *)account{
    
    account.created_time = [NSDate date];
    
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
    
}

+(MyWBAccount *)account{
    
    MyWBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    
    long long expires_in = [account.expires_in longLongValue];
    
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now =[NSDate date];
    
    NSComparisonResult result =[expiresTime compare:now];
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    if (result != NSOrderedDescending) {
        return nil;
    }
    
    return account;
}

@end
