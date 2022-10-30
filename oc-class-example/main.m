//
//  main.m
//  oc-class-example
//
//  Created by 张亚瀚 on 2022/10/28.
//

#import <Foundation/Foundation.h>
#import "Student.h"
/**
 学习 OC 中的类对象
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Student *student = [[Student alloc] initWithName:@"张亚瀚" andAge:12 andClassroom:@"一年级二班"];
        NSLog(@"%@", [student description]);
    }
    return 0;
}
