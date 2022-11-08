//
//  AppStoreModel.h
//  uikit-app-store-example
//
//  Created by 张亚瀚 on 2022/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppStoreModel : UIView
@property(nonatomic, copy) NSString *label;
@property(nonatomic, copy) NSString *icon;

- (instancetype) initWithDict: (NSDictionary *) dict;
+ (instancetype) initWithDict: (NSDictionary *) dict;
@end

NS_ASSUME_NONNULL_END
