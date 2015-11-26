//
//  MyWBOAuthViewController.m
//  MyWeiBo
//
//  Created by MacMini on 15/11/25.
//  Copyright © 2015年 MacMini. All rights reserved.
//

#import "MyWBOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "MyWBAccount.h"
#import "MyWBTabBarViewController.h"
#import "MyWBNewfeatureViewController.h"
#import "MyWBAccountTool.h"

@interface MyWBOAuthViewController()<UIWebViewDelegate>



@end

@implementation MyWBOAuthViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    
    webView.frame = self.view.bounds;
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1379437138&response_type=code&redirect_uri=http://"];
    //NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.length != 0) {
        NSUInteger fromIndex = range.location + range.length;
        
        NSString *code = [url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
        
        //禁止加载回调地址
        return  NO;
    }
    return  YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [MBProgressHUD hideHUD];
    
}

-(void)accessTokenWithCode:(NSString *)code{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1379437138";
    params[@"client_secret"] = @"518b995bd4054015c855500c3502ddca";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://";
    params[@"code"] = code;
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        MyLog(@"请求成功-%@", dict);
        [MBProgressHUD hideHUD];
        
        MyWBAccount *account = [MyWBAccount accountWithDict:dict];
        [MyWBAccountTool saveAccount:account];
       
        //切换窗口的控制器

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        [window switchRootViewController];
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        MyLog(@"请求失败-%@",error);
    }];
    
}

@end












