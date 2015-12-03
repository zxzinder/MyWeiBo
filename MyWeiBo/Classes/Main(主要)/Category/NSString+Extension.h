//
//  NSString+Extension.h
//  MyWeiBo
//
//  Created by MacMini on 15/12/3.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

-(CGSize)sizeWithFont:(UIFont *)font;

-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

@end
