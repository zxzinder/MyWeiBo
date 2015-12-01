//
//  MyWBStatusCell.h
//  MyWeiBo
//
//  Created by MacMini on 15/12/1.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyWBStatusFrame;


@interface MyWBStatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) MyWBStatusFrame *statusFrame;


@end
