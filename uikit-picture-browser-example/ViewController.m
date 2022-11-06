//
//  ViewController.m
//  uikit-picture-browser-example
//
//  Created by 张亚瀚 on 2022/11/6.
//

#import "ViewController.h"


@interface ViewController ()

// 展示当前所查看的图片下标文字
@property (weak, nonatomic) IBOutlet UILabel *pictureIndexText;

// 展示图片内容
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// 图片数据列表.
@property(nonatomic, strong) NSArray *pictures;

@property(nonatomic, assign) int index;
@end


/**
 图片浏览器示例
    1. 展示图片列表
    2. 具有上一张和下一张切换功能
 */
@implementation ViewController

/**
 重新定义 pictures 属性的 getter 方法实现懒加载.
 */
- (NSArray *)pictures {
    // 加载 pictures.plist 文件中定义的的数据到 _pictures;
    if (_pictures == nil) {
        // 获取资源文件的路径.
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pictures" ofType:@".plist"];
        // 将内容读取到 _pictures.
        _pictures = [NSArray arrayWithContentsOfFile:path];
    }
    return _pictures;
}

/**
 页面加载完成生命周期函数
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.index = 0;
    self.pictureIndexText.text = [NSString stringWithFormat:@"%d/%d", self.index + 1, (int) self.pictures.count];
    self.imageView.image = [UIImage imageNamed:self.pictures[self.index][@"picture"]];
}

/**
 
 */
- (IBAction)onNextButtonClick:(UIButton *)sender {
    if (sender.tag == 0) {
        NSLog(@"上一张");
        self.index--;
    }
    else if (sender.tag == 1) {
        NSLog(@"下一张");
        self.index++;
    }
    else {
        NSLog(@"未找到相应的处理事件");
    }
    if (self.index < 0) {
        self.index = 0;
    }
    else if (self.index > self.pictures.count - 1) {
        self.index = (int) self.pictures.count - 1;
    }
    
    self.pictureIndexText.text = [NSString stringWithFormat:@"%d/%d", self.index + 1, (int) self.pictures.count];
    self.imageView.image = [UIImage imageNamed:self.pictures[self.index][@"picture"]];
}


@end
