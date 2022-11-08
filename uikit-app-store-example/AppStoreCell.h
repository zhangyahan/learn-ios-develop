//
//  AppStoreCell.h
//  uikit-app-store-example
//
//  Created by 张亚瀚 on 2022/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppStoreCell : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

NS_ASSUME_NONNULL_END
