//
//  MyWBStatusPhotosView.h
//  MyWeiBo
//
//  Created by alexzinder on 15/12/2.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWBStatusPhotosView : UIView

@property (nonatomic,strong)NSArray *photos;


+(CGSize)sizeWithCount:(NSInteger)count;

@end
