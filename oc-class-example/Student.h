//
//  Student.h
//  oc-class-example
//
//  Created by 张亚瀚 on 2022/10/28.
//

/**
 
 这是OC类的属性和方法的定义文件，所有要访问的类方法和类变量都应该再次进行定义
 
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject {
    /**
     * 学生姓名属性
     */
    NSString *name;
    /**
     * 学生年龄属性
     */
    int age;
    /**
     * 学生班级属性
     */
    NSString *classroom;
}

/**
 * 根据 name, age, classroom 初始化对象
 * @param name 学生姓名
 * @param age 学生年龄
 * @param classroom 学生班级
 * @return Student 对象
 */
- (instancetype) initWithName: (NSString *) name andAge:(int) age andClassroom :(NSString *) classroom;


@end

NS_ASSUME_NONNULL_END
