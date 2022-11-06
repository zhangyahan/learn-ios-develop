//
//  ViewController.m
//  uikit-example
//
//  Created by 张亚瀚 on 2022/11/6.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 视图加载完成声明周期函数, 可以在该函数中添加一些空间到视图中.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建一个按钮
    UIButton *button = [[UIButton alloc] init];
    
    // 设置不同状态下的按钮文本信息
    [button setTitle:@"默认状态按钮文本" forState:UIControlStateNormal];
    [button setTitle:@"高亮状态按钮文本" forState:UIControlStateHighlighted];
    
    // 设置不同状态下按钮文本显示的颜色信息
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    // 设置按钮的背景图片
    [button setBackgroundImage:[UIImage imageNamed:@"button_background_normal"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"button_background_highlight"] forState:UIControlStateHighlighted];
    
    // 如果要想控件在父容器中显示, 则必须设置 frame 来规定控件的位置.
    [button setFrame:CGRectMake(50, 100, 300, 300)];
    
    // 为按钮绑定单击事件
    [button addTarget:self action:@selector(onButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    // 将按钮组件添加到主容器中
    [self.view addSubview: button];
}

/**
 按钮单击事件处理函数
 */
- (void) onButtonTouchUpInside {
    NSLog(@"按钮被点击了.");
}

@end
