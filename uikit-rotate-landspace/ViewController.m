//
//  ViewController.m
//  uikit-rotate-landspace
//
//  Created by 张亚瀚 on 2023/2/18.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextView *_textView;
@end

@implementation ViewController

- (UITextView *) getTextView {
    if (!self._textView) {
        CGRect rect = self.view.frame;
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(rect.size.width / 2 - 100, rect.size.height / 2 - 40, 100, 40)];
        self._textView = textView;
    }
    return self._textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getTextView].text = @"Hello World";
    [self getTextView].textColor = [UIColor blackColor];
    [self.view addSubview:[self getTextView]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChangeNotification) name:UIDeviceOrientationDidChangeNotification object:nil];
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAllButUpsideDown; // 该视图只支持竖屏幕;
//}

- (void) deviceOrientationChangeNotification {
    UIInterfaceOrientation orientation = (UIInterfaceOrientation) [UIDevice currentDevice].orientation;
    CGRect rect = self.view.frame;
    NSLog(@"width: %f, height: %f", rect.size.width, rect.size.height);
    NSLog(@"orientation: %li", orientation);
    [self getTextView].center = CGPointMake(rect.size.width / 2, rect.size.height / 2);;
    
    switch (orientation) {
        case UIInterfaceOrientationUnknown:
        case UIInterfaceOrientationPortrait: {
            NSLog(@"UIInterfaceOrientationPortrait: %li, UIInterfaceOrientationUnknown: %li", UIInterfaceOrientationPortrait, UIInterfaceOrientationUnknown);
            [self getTextView].frame = CGRectMake(rect.origin.x, rect.origin.y, 100, 40);
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight: {
            [self getTextView].frame = CGRectMake(rect.origin.x, rect.origin.y, 100, 40);
            break;
        }
        default: {
            
        }
    }
}


@end
