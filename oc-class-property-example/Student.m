//
//  Student.m
//  oc-class-property-example
//
//  Created by 张亚瀚 on 2022/10/30.
//
/**
 学生类的实现
 
 */
#import "Student.h"

@implementation Student

- (void) initWithName:(NSString *)name andAge:(int)age andClasroom:(NSString *)classrooom {
    // 因为属性是私有的, 可以在本类中直接方法
    age = age;
}

@end
