# IOS开发

## Objective-C

### 定义类的语法规范

实现类中的属性不用在此进行声明，只需要实现其定义的方法即可。为类定义属性的时候建议使用 _ 开头进行命名名称，因为这是后面即将学习到的 @property 修饰符的规范。

```objective-c
@interface 类名称 {
	数据类型 属性名;
}
@end

@implementation 类名
@end
```

### 类对象的使用

创建类对象的语法为 `类型 *变量名 = [类名 new];`，类属性默认是保护类型的 @protected 的，保护类型的属性只能在其类中和子类中进行使用，外部无法进行直接访问。可以将属性名使用 @public 进行修饰，这样属性就是公开的。在其内部或者外部或者子类中都可以进行直接访问。但    是根据类定义的规范，属性不应该是公开可以直接访问的，这样会破环类中封闭原则，这里属实是无奈之举。

```objective-c
int main(int argc, const char * argv[]) {
	Student *student = [Student new];
    student->_name = @"张三";
    (*student)._age = 12;
    NSLog(@"%@", [student description]);
}
```

### 类方法的定义和使用

类方法分为对象方法和本类方法，对象方法只可以在对象上进行调用，本类方法可以直接使用。对象方法和类方法的区别只在于方法头部的加号和减号，加号为本类方法，减号为对象方法。

定义方法时建议使用 `xxxWith:(int) arg1 andXXX: (int) arg2`，这样在函数名称的可读性上比较好。

```objective-c
@interface 类名 {
	// ...
}

- (返回值) 方法名称: (参数类型) 参数名称 [方法签名]: (参数类型) 参数名称; // 对象方法

+ (返回值) 方法名称: (参数类型) 参数名称 [方法签名]: (参数类型) 参数名称; // 本类方法

@end

@implementation 类名

- (返回值) 方法名称: (参数类型) 参数名称 [方法签名]: (参数类型) 参数名称 {
	// 函数逻辑代码
}

+ (返回值) 方法名称: (参数类型) 参数名称 [方法签名]: (参数类型) 参数名称 {
	// 函数逻辑代码
}

@end
    
int main() {
	Student *student = [Student new];
	[student funcName]; // 对象方法
    [Student funcName]; // 本类方法
}
```

对象方法和类方法的使用

### 类属性和属性修饰符

- MRC: 开发者自己管理对象的内存，在使用的时候申请，不在使用的时候手动尽心回收
- ARC: 系统自己管理对象的内存，自动引用计数。

#### 定义类的时候可以给属性添加修饰符

- @public: 公开的属性信息，可以在类的内部或者外部都可以直接访问。直接访问格式为 对象->属性名称
- @private: 私有的属性，在子类中有继承但是不能直接访问，通过self.方法间接调用 setter 等进行间接访问
- @protected: 受保护的属性，在子类中也可进行访问，这个修饰符是默认的。

#### 私有属性和私有方法

在 `@implementation` 中定义的属性为私有属性。在 `@implementation` 中实现的方法，但是没有在 `@interface` 中定义的方法为私有方法，或者在 `@interface` 中使用 `@private` 修饰的方法也是私有方法。唯一的区别是未定义的私有方法不会进行代码提示，而在 `@interface` 中定义的方法会进行代码提示，但是都是不可访问的。

### 对象在内存中的存储

内存中的5大区域：

- 栈：存储局部变量
- 堆：对象存在的位置
- BSS段：存储未被初始化的全局变量和静态变量
- 数据段（常量区）：存储已经被初始化的全局变量、静态变量、常量数据
- 代码段：存储代码文本；

初始化对象时会在堆空间中申请一块内存，在这个块内存上使用对象模版创建对象，基本数据类型的属性会被赋值为 0，C语言指针类型会被复制为 NULL，OC数据类型会被复制为 nil。

#### NULL 与nil的区别

1. NULL，可以作为指针的变量，如果一个指针变量的值为NULL，那么这个指针变量的指向的内存地址则为空，换句话的意思就是说这个指针没有指向其值的内存变量。在OC中NULL等价于0，因为在OC中NULL是一个宏其值为0；
2. nil，只能作为指针变量的值，其表示这个指针指向的变量为空；

使用时，C指针使用NULL，OC中的数据类型指针使用 nil

```objective-c
int main {
    int *p1 = NULL;
    NSString *s1 = nil;
}
```

### 多个指针指向相同的对象

在OC中，多个指针可以指向相同的对象，这样这几个指针所引用的值就来自同一块内存块，在其中一个指针改变其值的时候，其他指针指向的值也会进行改变；这个不会作用在基础数据类型之上，因为基础类型的值就是地址，要是改变其变量地址的话，在做修改并不会应该到之前指向的值；

```objective-c
int main() {
    Student *zhangsan = [Student new];
    zhangsan->_name = @"张三";
    (*zhangsan)._age = 12;
    (*zhangsan)._classroom = @"二年级三班";


    Student *lisi = zhangsan;
    lisi->_name = @"李四";
    NSLog(@"%@", [zhangsan description]);
    NSLog(@"%@", [lisi description]);
    
    // 2022-10-30 20:40:34.680212+0800 oc-class-example[5001:253480] name: 李四, age: 12, classroom: 二年级三班
	// 2022-10-30 20:40:34.680265+0800 oc-class-example[5001:253480] name: 李四, age: 12, classroom: 二年级三班
    
    NSString *s1 = @"张三";
    NSString *s2 = s1;
    s2 = @"李四";
	// 不会指向相同对象了！！！
}
```

### 分组导航标记

`pragma mark - xxx`

### 异常处理

```objective-c
int main() {
    @try {
        
    }
    @catch (NSException *ex) {
        
    }
    @finally {
        
    }
}
```

### static 关键字

在方法中用于定义类的静态变量，类的静态变量是唯一的，所以方法的操作会持续操作该变量。在代码块以外使用就是用于定义静态变量。

```objective-c
static NSString *reuseIdentifier = @"homeCollectionCell";
static NSString *footerCellID = @"footerCellID";
static NSString *firstReusableView = @"firstReusableView";
static NSString *secondReusableView = @"secondReusableView";
```

### 类的继承

继承的作用，子类继承父类后拥有所有父类的属性和方法，并且可以重新父类的方法。

```objective-c
@interface 类名: 父类名称 {
    
}
@end
```

#### 里氏替换法则

可以使用父类来代表子类的类型。

#### 方法重写

只需要在子类的实现中重新实现方法内容即可，这样在调用的时候就会调用子类实现的方法方法代码。

### 类对象的使用

`Class c1 = [类名 Class]` 这时 `c1` 就相当于类名，也可以使用 c1 来替换类名做相同的操作。

### SEL

SEL 全称叫做 `Selector` 选择器，SEL 是一个数据类型。方法的本质其实就是 SEL，所以可以使用 SEL 来触发类的方法。

```objective-c
int main() {
    Person *p1 = [Person new];
    
    SEL s1 = @selector(funcName);
    [p1 performSelector: s1];
    [p1 funcName];
}
```

### 点语法

OC对象如果来为对象赋值或者取值，需要调用对象的 `setter` 和 `getter` 方法。如果像使用点语法操作属性，只需要 `对象.去掉下划线的属性名称` 即可。但是这样搞的话只能单纯的取值和赋值，所以还需要实现属性的 `setter` 和 `getter` 方法。重新的规则就为 `getXxx` 或者 `setXxx` ，注意要使用小驼峰。

### @property

如果使用点语法来访问属性的话，既然需要实现属性的 `setter` 和 `getter` 方法，那有没有好的手段去更好的实现这类操作那？那就是使用 `@proterty` 属性修饰在属性定义的时候对属性进行描述，这样就会自动生成 `getter` 方法和 `setter` 方法的声明，并且将属性名命名为 `_属性名` 的类型。但是这个修饰符只能实现对 `setter` 和 `getter` 方法声明而不能对方法进行实现，需要使用 `@synthsize` 来自定生成方法的实现。

### @sythesize

自定生成 `setter` 和 `getter` 方法的实现，语法为：

```objective-c
@interface Person: NSObject
@property int age;
@end
    
@implmentation Person
@sythesize age;
@end
```

使用 `@sythesize` 声明的属性，将会生成一个真私有属性，就是定义在 `@implmentation` 中的属性。如果不需要生成私有属性则需要这样声明 `@sythesize age = 已经存在的属性名称;`即可。

### @property 增强

在 Xcode4.4 以后 @property 就包含了对 @sythesize 的操作，并且这个方法生产的属性是私有的。所以以后只需要在类定义的文件写就可以了。

### @property 参数

在`MRC`模式下，一个类的属性如果是OC对象类型的，那么这个属性的 setter 方法就应该按照以下以下格式进行书写，因为要手动进行释放对象的引用或者内存，仅限在属性的对象为OC对象时需要执行该逻辑。

```objective-c
- (void) setValue: (Value *) value {
    if (_value != value) {
        [_value release]; // 释放旧的对象
        _value = [value retain]; // 赋值新的对象
    }
}

// 并且需要重新该类的 dealloc 方法
- (void) dealloc {
    [_value release];
    [super dealloc]; // 调用父级的 dealloc 方法
}
```

- 自动生成私有属性
- 自动生成属性 getter 和 setter 方法的声明
- 自动生成属性 getter 和 setter 方法的实现

因为自动生成的 setter 的实现，不关心属性的类型。所以在手动管理对象内存的情况下，并不是很适用，所以引入了 `@property` 的参数来进行属性的说明。

**携带参数的 `@property` 的书写方式：**

- `@property (参数1, 参数2, 参数3, ...) 数据类型 属性名称;`

**`@property` 的四组参数：**

1. 与多线程相关的两个参数
   1. `atomic`：默认值，该值为原子性的属性
   2. `nonatomic`：该值为非原子性的属性
2. 与 `setter` 方法实现相关的两个参数
   1. `assign`：默认值，生成的 `setter` 方法实现就是直接赋值。
   2. `retain`：生成的 `setter` 方法实现为对象释放的写法，但是不会在 `dealloc `方法中进行对象的释放。
3. 与读写相关的参数的两个参数
   1. `readonly`：该属性只读的。
   2. `readwrite`：默认值，该属性为读写的。
4. 与 `setter` 和 `getter` 方法名字相关的两个参数
   1. `setter`：设置 `setter` 方法的名称。
   2. `getter`：设置 `getter` 方法的名称。

### @class

当两个类的属性分别包含对象的时候，互相引入头文件会产生无限递归的情况，在这个时候在其中一个文件中使用 `@class 类名` 进行引入。

### 循环 retain 的情况

当在 `MRC` 模式下的两个类的属性互相包含对象的时候，如果两边的属性都使用 `@property(retain)` 的话就会存在循环 retain 的情况，导致两个属性对象都不能被回收掉，因为互相的引用计数都是2，当触发回收的时候，计数器-1，但是属性对象都已经回收就会造成内存泄露的情况。

### @autorelease 自动释放池

在自动释放池创建的对象，在池子被销毁时内部的对象将会自动被释放。但是创建对象的方法符合如下写法，只有使用 `autorelease` 方法创建出来的对象才会被自动销毁。

```objective-c
int main() {
    @autorelease {
        Person *p1 = [[[Person alloc] init] autorelease];
    }
}
```

关于 `@autorelease` 方法的规范：

1. 在对象方法中初始化对象不返回已经 `autorelease` 的对象
2. 在类方法中初始化对象需要返回一个已经 `autorelease` 的对象

### ARC

`Automatic Reference Counting` 自动引用计数，与 `MRC` 相反自动帮助开发者进行自动引用计数。不要在 `ARC` 模式下书写 `retain` `release` `autorelease` 即可，当 `ARC` 开启的时候会自动在适当的地方调用 `retain` `release` `autorelase` 方法。`ARC` 是编译器机制，在进行代码编译的时候加入了与对象释放相关的代码。在 `ARC` 机制下，只要没有强指针指向这个对象，这个对象就会被立即回收。

### 强指针与弱指针

默认情况下，声明一个指针后这个指针就是强指针。也可以使用 `__strong` 来显式的声明这是一个强指针，代码如下：

```objective-c
Person *p1; // 隐式声明强指针
__strong Person *p2; // 显式声明强指针
__weak Person *p3; // 声明弱指针
```

弱指针使用 `__weak` 标识符进行声明，无论是强指针还是弱指针都是指针。都可以用来存储内存地址，唯一的区别就是在 `ARC` 模式下它们是作为回收对象的基准，如果一个对象没有被任何强类型的指针指向，那么这个对象就会被立即回收。

### @property 在 ARC 模式下的参数

在 `ARC` 模式在使用 @property 是就不可以使用 retain 参数了，因为在 `ARC` 模式下不允许调用 retain 方法。所以在这个情况下引入的 `strong` 和 `weak` 参数，在 `ARC` 模式下使用 @property 生成的指针属性默认为强类型的。

```objective-c
@interface Person {
    @property(nonatomic, strong) NSString *name; // 强类型指针的属性
    @property(nonatomic, weak) NSString age; // 弱类型指针的属性
}
```

**使用建议：**

1. 在ARC模式下，如果属性的类型是OC对象类型的，在绝大多数场景下使用 `strong`。
2. 在ARC模式线，如果属性的类型不是OC对象类型的，使用 `assign`。

### 在 ARC 机制下类属性循环引用的问题

P133

