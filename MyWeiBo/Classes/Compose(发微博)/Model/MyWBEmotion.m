//
//  MyWBEmotion.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/15.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBEmotion.h"

@implementation MyWBEmotion
/**
 *  从文件中解析对象时调用
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
}

-(BOOL)isEqual:(MyWBEmotion *)other{
    
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
    
}

@end
