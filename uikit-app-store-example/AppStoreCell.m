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
@end
