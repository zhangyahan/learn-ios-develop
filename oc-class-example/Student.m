//
//  Student.m
//  oc-class-example
//
//  Created by 张亚瀚 on 2022/10/28.
//

#import "Student.h"

@implementation Student

- (instancetype) initWithName:(NSString *)name andAge:(int)age andClassroom:(NSString *)classroom {
    self->_name = name;
    self->_age=age;
    self->_classroom = classroom;
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"name: %@, age: %d, classroom: %@", self->_name, self->_age, self->_classroom];
}
@end
