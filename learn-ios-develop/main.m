//
//  main.m
//  learn-ios-develop
//
//  Created by 张亚瀚 on 2022/10/28.
//
/**
 Objective-C 语言学习，OC语言为C语言的扩展。所以需要具备一定C语言的知识。
 如果你不了解C语言但是熟悉其他面向编程语言，如：Java，那么也可以直接学习OC。
 我学习这门语言的主要用途为完成IOS应用的开发。
 */
#import <Foundation/Foundation.h>

/**
 主函数
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 打印 Hello World
        // OC 依赖 Foundation 框架，Foundation 框架内包装了很多数据类型用于简化C语言
        NSLog(@"Hello, World!");
    }
    return 0;
}
