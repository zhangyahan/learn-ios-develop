//
//  Student.h
//  oc-class-property-example
//
//  Created by 张亚瀚 on 2022/10/30.
//

/**
    学生类的定义，实现该定义的类默认拥有属性，以及必须实现其方法
    属性:
        1. 学生名称
        2. 学生年龄
        3. 学生班级
 
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject {
    // 属性的定义必须写在打括号内部
    @private NSString *name;
    @private int       age;
    @private NSString *classroom;
}

// 方法的定义, - 表示类方法 + 表示静态方法
- (void) initWithName: (NSString *) name andAge: (int) age andClasroom: (NSString *) classrooom;
@end

NS_ASSUME_NONNULL_END
