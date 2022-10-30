//
//  main.m
//  oc-class-property-example
//
//  Created by 张亚瀚 on 2022/10/30.
//

/**
    类属性和属性修饰符，
    MRC: 开发者自己管理对象的内存，在使用的时候申请，不在使用的时候手动尽心回收
    ARC: 系统自己管理对象的内存，自动引用计数。
    
    定义类的时候可以给属性添加修饰符
    @public: 公开的属性信息，可以在类的内部或者外部都可以直接访问。直接访问格式为 对象->属性名称
    @private: 私有的属性，在子类中有继承但是不能直接访问，通过self.方法间接调用 setter 等进行间接访问
    @protected: 受保护的属性，在子类中也可进行访问，这个修饰符是默认的。
 
 */
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
