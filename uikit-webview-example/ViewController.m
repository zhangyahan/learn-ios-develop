//
//  ViewController.m
//  uikit-webview-example
//
//  Created by 张亚瀚 on 2022/11/14.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // webview 组件功能示例，加载 http://m.baidu.com 到手机上.
    
    NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 请求完成的处理事情
        if (!connectionError) {
            NSString *responseData = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            NSLog(@"请求成功, %@", responseData);
            [self.webView loadHTMLString:responseData baseURL:nil];
        }
        else {
            NSLog(@"请求发生错误, %@", connectionError);
        }
    }];
}


@end
