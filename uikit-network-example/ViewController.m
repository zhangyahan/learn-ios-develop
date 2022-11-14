//
//  ViewController.m
//  uikit-network-example
//
//  Created by 张亚瀚 on 2022/11/14.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 包装请求地址
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    // 包装请求对象
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    // 请求响应处理块
    void (^completionHandler)( NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) = ^( NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError ) {
        // code in here;
        if (!connectionError) {
            NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"请求成功, %@", responseData);
        }
        else {
            NSLog(@"请求错误, %@", connectionError);
        }
    };
    
    // 发起网络请求, 参数1: 请求对象, 参数2: 请求完成后执行回调块的线程队列, 参数3: 请求完成后的回调块.
    [NSURLConnection
     sendAsynchronousRequest: request
     queue: [NSOperationQueue mainQueue]
     completionHandler:completionHandler
    ];
}


@end
