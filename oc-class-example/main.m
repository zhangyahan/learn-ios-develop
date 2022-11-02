#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Student *student = [[Student alloc] initWithName:@"张亚瀚" andAge:12 andClassroom:@"一年级二班"];
        NSLog(@"%@", [student description]);
        
        Student *zhangsan = [Student new];
        zhangsan->_name = @"张三";
        (*zhangsan)._age = 12;
        (*zhangsan)._classroom = @"二年级三班";
        
        
        Student *lisi = zhangsan;
        lisi->_name = @"李四";
        NSLog(@"%@", [zhangsan description]);
        NSLog(@"%@", [lisi description]);
    }
    return 0;
}
