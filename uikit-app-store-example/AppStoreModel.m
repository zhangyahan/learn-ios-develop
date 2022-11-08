//
//  AppStoreModel.m
//  uikit-app-store-example
//
//  Created by 张亚瀚 on 2022/11/8.
//

#import "AppStoreModel.h"

/**
 * 应用中心单个控件数据模型
 */
@implementation AppStoreModel

- (instancetype) initWithDict: (NSDictionary *) dict {
    if (self = ([self init])) {
        self.label = dict[@"label"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (instancetype)initWithDict: (NSDictionary *) dict  {
    return [[self alloc] initWithDict:dict];
}
@end
