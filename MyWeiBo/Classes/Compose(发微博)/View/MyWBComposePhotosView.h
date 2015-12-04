//
//  MyWBComposePhotosView.h
//  MyWeiBo
//
//  Created by MacMini on 15/12/4.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWBComposePhotosView : UIView


-(void)addPhoto:(UIImage *)image;

@property (nonatomic, strong,readonly) NSMutableArray  *photos;

@end
