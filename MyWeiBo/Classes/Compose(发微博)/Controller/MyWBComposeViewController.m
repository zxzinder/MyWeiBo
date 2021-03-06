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
#import "MyWBComposeToolbar.h"
#import "MyWBComposePhotosView.h"
#import "MyWBEmotionKeyboard.h"
#import "MyWBEmotion.h"
#import "MyWBEmotionTextView.h"

@interface MyWBComposeViewController ()<UITextViewDelegate,MyWBComposeToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak)MyWBEmotionTextView *textView;
@property (nonatomic, weak)MyWBComposeToolbar *toolbar;

@property (nonatomic, weak)MyWBComposePhotosView *photosView;

@property (nonatomic, weak)UIButton *doneBtn;

@property (nonatomic,strong)MyWBEmotionKeyboard *emotionKeyboard;
/**
 *  是否正在切换键盘
 */
@property (nonatomic,assign)BOOL isSwitchKeyboard;
@end

@implementation MyWBComposeViewController

-(MyWBEmotionKeyboard *)emotionKeyboard{
    
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[MyWBEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
    }
    
    return _emotionKeyboard;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self setupNav];
    [self setupTextView];
    [self setupToolbar];
    [self setupPhotosView];
    // Do any additional setup after loading the view.
}
//-(void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    
//    [self.textView becomeFirstResponder];
//    
//}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
    
}
-(void)dealloc{
    
    [NotificationCenter removeObserver:self];
    
}
#pragma mark - 初始化
-(void)setupNav{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
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
    
    MyWBEmotionTextView *textView = [[MyWBEmotionTextView alloc] init];
    // 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    textView.delegate = self;
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    [NotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [NotificationCenter addObserver:self selector:@selector(keyboardWiiChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [NotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:MyWBEmotionDidSelectNotification object:nil];
    
    
    [NotificationCenter addObserver:self selector:@selector(emotionDidDelete:) name:MyWBEmotionDidDeleteNofitication object:nil];
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

-(void)setupToolbar{
    
    MyWBComposeToolbar *toolbar = [[MyWBComposeToolbar alloc ]init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)setupPhotosView{
    
    MyWBComposePhotosView *photosView = [[MyWBComposePhotosView alloc] init];
    photosView.y = 100;
   
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    
}



#pragma mark  - 监听方法
-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)send{
    
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else{
        
        [self sendWithoutImage];
        
    }
   // [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)sendWithoutImage{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = [MyWBAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"发送中";
      [hud showAnimated:YES whileExecutingBlock:^{
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"%@",error);
        //[MBProgressHUD showError:@"发送失败 "];
    }];
    
      } completionBlock:^{
          [hud removeFromSuperview];
          [self dismissViewControllerAnimated:YES completion:nil];
      }];
}

-(void)sendWithImage{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [MyWBAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
 
  
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"发送中";
    
    [hud showAnimated:YES whileExecutingBlock:^{
        [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage *image = [self.photosView.photos firstObject];
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //[MBProgressHUD showSuccess:@"发送成功"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            MyLog(@"sendWithImage --- %@",error);
            // [MBProgressHUD showError:@"发送失败"];
        }];
    } completionBlock:^{
        [hud removeFromSuperview];
        [self dismissViewControllerAnimated:YES completion:nil];
           }];
    
  //  [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)keyboardWiiChangeFrame:(NSNotification *)notification{
    
    if (self.isSwitchKeyboard) {
        return;
    }
    
    NSDictionary *userInfo = notification.userInfo;
    
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
            
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
            
        }
    }];
    
    
//    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    doneBtn.frame = CGRectMake( keyboardF.size.width - 44 , keyboardF.size.width , 44, 22);
//    [doneBtn setTitle:@"done" forState: UIControlStateNormal];
//    [doneBtn addTarget:self action:@selector(hideDoneBtn) forControlEvents:UIControlEventTouchUpInside];
//    //doneBtn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:doneBtn];
//    self.doneBtn = doneBtn;
    
}

-(void)emotionDidSelect:(NSNotification *)notification{
    
    MyWBEmotion *emotion = notification.userInfo[MyWBSelectEmotionKey];
    [self.textView insertEmotion:emotion];
    
}

-(void)emotionDidDelete:(NSNotification *)notification{
    
    [self.textView deleteBackward];
}

-(void)textDidChange{
    
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    
}
-(void)hideDoneBtn{
    
    [self.doneBtn removeFromSuperview];
    [self.textView resignFirstResponder];
    
}
#pragma mark - UITextViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
    
}

#pragma mark - MyWBComposeToolbarDelegate

-(void)composeToolbar:(MyWBComposeToolbar *)toolbar didClickButton:(ComposeToolbarButtonType)buttonType{
    
    switch (buttonType) {
        case ComposeToolbarButtonTypeCamera: // 拍照
            [self openCamera];
            break;
            
        case ComposeToolbarButtonTypePicture: // 相册
            [self openALbum];
            break;
            
        case ComposeToolbarButtonTypeMention: // @
            MyLog(@"--- @");
            break;
            
        case ComposeToolbarButtonTypeTrend: // #
            MyLog(@"--- #");
            break;
            
        case ComposeToolbarButtonTypeEmotion: // 表情\键盘
          //  MyLog(@"--- 表情");
            [self switchKeyboard];
            break;
    }
    
}

#pragma mark - 其他方法

-(void)switchKeyboard{
    
    if (self.textView.inputView == nil) {//使用的是系统自带键盘
        
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.showKeyboardButton = YES;
    }else{
        
        self.textView.inputView = nil;
        self.toolbar.showKeyboardButton = NO;
    }
    
    self.isSwitchKeyboard = YES;
    
    [self.textView endEditing:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
        
        self.isSwitchKeyboard = NO;
    });
    
}

-(void)openCamera{
    
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
    
}

-(void)openALbum{
    
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    
}

-(void)openImagePickerController:(UIImagePickerControllerSourceType)type{
    
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
    
}

#pragma mark -UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:image];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.picking = NO;
//        });

}


@end

















