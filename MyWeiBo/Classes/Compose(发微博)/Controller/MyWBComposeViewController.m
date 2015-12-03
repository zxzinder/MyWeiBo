//
//  MyWBComposeViewController.m
//  MyWeiBo
//
//  Created by alexzinder on 15/12/3.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBComposeViewController.h"
#import "MyWBAccountTool.h"
#import "MyWBAccount.h"
#import "MyWBTextView.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

@interface MyWBComposeViewController ()

@property (nonatomic,weak)MyWBTextView *textView;

@end

@implementation MyWBComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self setupNav];
    [self setupTextView];
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    
    [NotificationCenter removeObserver:self];
    
}

-(void)setupNav{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name =[MyWBAccountTool account].name;
    NSString *prefix = @"发微博";
    
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        
        titleView.numberOfLines = 0;
        titleView.y = 50;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        
        //带属性字符串
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        
        titleView.attributedText = attrStr;
        
        self.navigationItem.titleView = titleView;
        
        
    }else{
        
        self.title = prefix;
        
    }
}
/**
 *  添加输入控件
 */
-(void)setupTextView{
    
    MyWBTextView *textView = [[MyWBTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    [NotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
}
/**
 UITextField:
 1.文字永远是一行，不能显示多行文字
 2.有placehoder属性设置占位文字
 3.继承自UIControl
 4.监听行为
 1> 设置代理
 2> addTarget:action:forControlEvents:
 3> 通知:UITextFieldTextDidChangeNotification
 
 UITextView:
 1.能显示任意行文字
 2.不能设置占位文字
 3.继承自UIScollView
 4.监听行为
 1> 设置代理
 2> 通知:UITextViewTextDidChangeNotification
 */
-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)sendMessage{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = [MyWBAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    MyLog(@"%@",params);
    
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"%@",error);
        [MBProgressHUD showError:@"发送失败 "];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)textDidChange{
    
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    
}

@end
