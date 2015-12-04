//
//  MyWBComposeToolbar.h
//  MyWeiBo
//
//  Created by MacMini on 15/12/4.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    ComposeToolbarButtonTypeCamera, // 拍照
    ComposeToolbarButtonTypePicture, // 相册
    ComposeToolbarButtonTypeMention, // @
    ComposeToolbarButtonTypeTrend, // #
    ComposeToolbarButtonTypeEmotion // 表情
    
}ComposeToolbarButtonType;


@class MyWBComposeToolbar;

@protocol MyWBComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(MyWBComposeToolbar *)toolbar didClickButton:(ComposeToolbarButtonType)buttonType;

@end

@interface MyWBComposeToolbar : UIView

@property (nonatomic, weak)id<MyWBComposeToolbarDelegate> delegate;

@end
