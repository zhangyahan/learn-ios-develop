//
//  ViewController.m
//  uikit-uiscrollview-example
//
//  Created by 张亚瀚 on 2022/12/8.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *innerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // UIScrollView example
    self.innerView.backgroundColor = [[UIColor alloc] initWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.innerView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(0, 200);
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


/// 用户在滚动的时候
/// @param scrollView 滚动对象
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    // some code...
}


/// 用户开始拖拽的时候
/// @param scrollView 拖拽对象
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // some code...
}


/// 拖拽完毕后
/// @param scrollView 拖拽对象
/// @param decelerate 是否还在运动
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // some code...
}
@end
