//
//  ViewController.m
//  uikit-async-download-image
//
//  Created by 张亚瀚 on 2023/2/10.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *image;
@end

@implementation ViewController

- (void) loadView {
    // 初始化 scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.view = self.scrollView;
    
    // 初始化 image view
    self.image = [[UIImageView alloc] init];
    
    [self.scrollView addSubview:self.image];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    [thread start];
}

- (void) updateImage: (UIImage *) image {
    self.image.image = image;
    [self.image sizeToFit];
    self.scrollView.contentSize = image.size;
}

- (void) downloadImage {
    NSURL *url = [NSURL URLWithString:@"https://i.stack.imgur.com/ILTQq.png"];
    NSData *data = [NSData dataWithContentsOfURL: url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:image waitUntilDone:YES];
}

@end
