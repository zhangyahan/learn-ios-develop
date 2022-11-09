//
//  AppStoreCell.m
//  uikit-app-store-example
//
//  Created by 张亚瀚 on 2022/11/8.
//

#import "AppStoreCell.h"

/**
 * 应用中心单个控件
 */
@implementation AppStoreCell

+ (instancetype) appStoreCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"AppStoreCell" owner:nil options:nil] lastObject];;
}

- (void) setModel:(AppStoreModel *)model {
    self.label.text = model.label;
    self.imageView.image = [UIImage imageNamed:model.icon];
}
- (IBAction)onDownloadButtonClick:(UIButton *)sender {
    sender.enabled = false;
    
    // 显示正在下载的 label 控件,
    UILabel *label = [[UILabel alloc] init];
    [self.superview addSubview:label];
    
    label.frame = CGRectMake((self.superview.frame.size.width - 200) * 0.5, (self.superview.frame.size.height - 30) / 2, 200, 30);
    label.text= @"正在下载...";
    label.backgroundColor = [UIColor greenColor];
    label.textColor = [UIColor redColor];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.0;
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha = 0.6;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [label removeFromSuperview];
                }
            }];
        }
    }];
    
    


}
@end
