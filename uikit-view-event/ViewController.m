//
//  ViewController.m
//  uikit-view-event
//
//  Created by 张亚瀚 on 2023/2/16.
//

#import "ViewController.h"

@interface ViewController ()

@end

/// 视图生命周期事件的学习
@implementation ViewController

/// 视图加载完成事件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
}

/// 视图即将被展示
-(void) viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
}

/// 视图已经被展示
-(void) viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear");
}

/// 视图即将被移除
-(void) viewWillDisappear:(BOOL)animated {
    NSLog(@"viewWillDisappear");
}

/// 视图已经被移除
-(void) viewDidDisappear:(BOOL)animated {
    NSLog(@"viewDidDisappear");
}


@end
