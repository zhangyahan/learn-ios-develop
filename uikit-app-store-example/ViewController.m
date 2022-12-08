//
//  ViewController.m
//  uikit-app-store-example
//
//  Created by 张亚瀚 on 2022/11/8.
//

#import "ViewController.h"
#import "AppStoreModel.h"
#import "AppStoreCell.h"

@interface ViewController ()

@end

/**
 * 使用自定义 xib 文件来创建一个应用管理下载的应用页面.
 */
@implementation ViewController

/**
 * 重写 getter 方法实现懒加载
 */
- (NSArray *) appStores {
    if (_appStores == nil) {
        // 获取 .plist 文件路径
        NSString *appStoresContentPath = [[NSBundle mainBundle] pathForResource:@"appstore.plist" ofType:nil];
        // 读取内容到 NSArray 中
        NSArray *array = [NSArray arrayWithContentsOfFile:appStoresContentPath];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [models addObject: [AppStoreModel initWithDict:dict]];
        }
        _appStores = models;
    }
    return _appStores;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat clientWidth = self.view.frame.size.width;
    
    int colums = 4;
    CGFloat appStoreCellWidth = 75;
    CGFloat appStoreCellHeight = 90;
    CGFloat marginLeft = (clientWidth - colums * appStoreCellWidth) / (colums + 1);
    CGFloat marginTop = marginLeft;
    
    for (int i = 0; i < self.appStores.count; i++) {
        AppStoreModel *model = self.appStores[i];
        
        AppStoreCell *cell = [AppStoreCell appStoreCell];
        
        int col = i % colums;
        int row = i / colums;
        
        CGFloat appStoreCellX = marginLeft + col * (appStoreCellWidth + marginLeft);
        CGFloat appStoreCellY = marginTop + row * (appStoreCellHeight + marginTop);
        if (row == 0) {
            appStoreCellY += 30;
        }
        CGRect frame = CGRectMake(appStoreCellX, appStoreCellY, appStoreCellWidth, appStoreCellHeight);
        
        cell.frame = frame;
        
        [self.view addSubview:cell];
        
        [cell setModel:model];
    }
}


@end
