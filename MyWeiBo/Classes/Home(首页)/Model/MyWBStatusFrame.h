//
//  MyWBStatusFrame.h
//  MyWeiBo
//
//  Created by MacMini on 15/12/1.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <Foundation/Foundation.h>

// 昵称字体
#define StatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define StatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define StatusCellSourceFont StatusCellTimeFont
// 正文字体
#define StatusCellContentFont [UIFont systemFontOfSize:14]
// 被转发微博的正文字体
#define StatusCellRetweetContentFont [UIFont systemFontOfSize:13]



@class MyWBStatus;

@interface MyWBStatusFrame : NSObject

@property (nonatomic, strong) MyWBStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;
/**
 *  底部工具条
 */
@property (nonatomic,assign) CGRect toolbarF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
