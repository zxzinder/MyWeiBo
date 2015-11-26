//
//  MyWBTest2ViewController.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/18.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBTest2ViewController.h"
#import "MyWBTest3ViewController.h"
@interface MyWBTest2ViewController ()

@end

@implementation MyWBTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    MyWBTest3ViewController *test3 = [[MyWBTest3ViewController alloc] init];
    
    test3.title = @"测试3控制器";
    
    [self.navigationController pushViewController:test3 animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
