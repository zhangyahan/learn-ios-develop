//
//  ViewController.m
//  uikit-super-guess-example
//
//  Created by 张亚瀚 on 2022/11/11.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController


/// 视图控制器已加载生命周期函数
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


/// 设置当前视图控制器状态栏内容颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    // return UIStatusBarStyleLightContent;
    // return UIStatusBarStyleDefault;
    // return UIStatusBarStyleDarkContent;
    return UIStatusBarStyleLightContent;
}


/// 设备当前视图控制器状态栏是否隐藏
- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
