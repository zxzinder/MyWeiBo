//
//  MyWBEmotionPageView.h
//  MyWeiBo
//
//  Created by alexzinder on 15/12/24.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define MyEmotionMaxRows 3
// 一行中最多7列
#define MyEmotionMaxCols 7
// 每一页的表情个数
#define MyEmotionPageSize ((MyEmotionMaxRows * MyEmotionMaxCols) - 1)


@interface MyWBEmotionPageView : UIView
/**
 *  当前页显示的表情
 */
@property (nonatomic,strong)NSArray *emotions;

@end
