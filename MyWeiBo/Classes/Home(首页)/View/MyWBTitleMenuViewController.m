//
//  MyWBTitleMenuViewController.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/20.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBTitleMenuViewController.h"

@implementation MyWBTitleMenuViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    }else if (indexPath.row == 1){
        
        cell.textLabel.text = @"密友";
        
    }else if (indexPath.row == 2){
        
        cell.textLabel.text = @"全部";
        
    }
    return  cell;
}
@end
