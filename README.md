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

### 快捷初始化对象

在初始化对象时应该存在封装的思想，在不能一直一遍一遍的 new 和在外部设置属性值。

```objective-c
// .h
@interface Student
@property(nonatomic, copy) NSString *name;

// 对象方法
- (instancetype) initWith: (NSString *) name;
// 本类方法
+ (instancetype) studentWith: (NSString *) name;
@end
    
// .m
@implementation Student
- (instancetype) initWith: (NSString *) name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}
+ (instancetype) studentWith: (NSString *) name {
    return [[self alloc] initWith: name];
}
@end
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

在循环引用的一侧属性上使用 `@property(nonatomic, weak)` 指定属性为弱引用即可消除在 `ARC` 模式下的循环引用问题。

### 分类、类别、类目、Category

如果一个类中的属性和方法太多的话会显得特别臃肿，所以可以使用分类的方法进行避免这个情况。原理就是将类分成多个模块（类别），就像 `Student` 类型，将小学生、初中生、高中生、大学生各个类别的属性和方法定义在各自的类别中去。

```objective-c
// 本类文件 Student.h
@interface Student {
    
}
@end

// 本类文件 Student.m
@implementation Student
@end
    
// 分类文件 Student+small.h
@interface Student (small) {
    
}
@end

// 分类文件 Student+small.m
@implementation Student (small)
@end
```

这样在使用的时候，如果只需要使用本类文件只需引入 `Student.h` 即可，如果需要使用 `small` 模块的方法和属性就新增引入 `Student+small.h` 即可。

```objective-c
#import "Student.h" // 只能使用本类的属性和方法
#import "Student+small.h" // 可以使用分类的属性和方法

int main() {
    return 0;
}
```

使用分类需要注意的地方：

1. 分类中只能增加方法不能增加属性
2. 在分类中可以写 `@property` 但是不会自动生成私有属性，也不会生成setter和getter实现，只会生成getter和setter的声明
3. 在分类的方法实现中不可以直接访问本类的属性，需要使用 setter 和 getter 方法间接访问
4. 在分类中如果存在和本类相同的方法名称，则会优先调用分类的方法，即使分类没有被引用。当多个分类都存在相同的方法名称时，调用最后一个编译的分类方法

### 非正式协议

为已经存在的类添加分类方法，来满足未实现的功能，这种理念就叫非正式协议。

### 延展（Extension）

一种特殊的分类（没有分类名的分类）就可以叫做延展，它没有对方法的实现功能，实现需要写在延展的本类中。可以在延展只用添加属性和 `@property` 那么它们的实现就会在本类实现中生成。在使用延展时需要定义延展的类，和使用延展时需要导入延展文件，一般延展文件的名称方式为 `本类名_延展名.h`，因为没有实现所以没有 `.m`文件。

**延展的使用场景：**

1. 为类生成私有属性，将属性的定义放到扩展中，将实现放到本类中。这样的话外部就无法调用这个属性的 `setter` 和 `getter` 方法了，因为方法未被定义所以访问不到。
2. 延展100%的情况下不会单独占一个文件，就是将延展写在本类的实现文件中，这样写在延展中的成员就是这个类的私有成员属性了。

### block 数据类型

`block` 数据类型存在是一段代码段，这段代码段可以携带参数和返回值。就好像 `block` 是一个特殊的函数一样，可以声明在任何地方，也可以当作参数进行回调。定义当形参，声明可以当作实参，也可以作为函数的返回值。

```objective-c
// 声明block 数据类型的语法
void (^blockName)(int, NSString);

// 定义 block 数据类型的语法
^ (int: age, NSString: name) {
  	// 代码逻辑  
};

// 声明和定义
void (^blockName)(int, NSString) = ^ (int: age, NSString: name) {
  	// 代码逻辑  
};

// 使用 block 数据类型
blockName(13, @"张三");
```

**`block` 简写形式：**

1. 如果没有返回值，代码段的 `void` 可以进行忽略。
2. 如果没有参数，代码段的`()` 可以进行忽略。
3. 声明 `block`变量时，变量的参数列表可以只写参数的类型而不写参数的名称。
4. 不论代码段是否存在返回值，都可以忽略返回值类型，但是 `block` 类型的声明必须指定，应该会自动推导是否是符合的返回值类型。

建议：使用最标准的写法来写 `block` 变量和 `block` 代码段，因为这样可以提高代码的阅读性。

在很多情况下定义 `block` 数据类型是比较冗长的，所以可以使用 `typedef` 关键字为冗长的数据类型进行起简短的别名。

```objective-c
int main() {
    typeof void (^MyBlockType)(int age, NSString name); // 定义 block 数据类型的别名
    
    MyBlockType blockName = ^void (int age, NSString name) {
    	// 代码块  
    };
}
```

在 block 代码段中可以访问任意作用域的变量，但是只可以修改全局变量和本局变量。如果要修改其他作用域的局部变量则需要将该变量的声明为 `__block` 修饰符。

```objective-c
int main() {
    __block int num = 100;
}
```

### 协议（Protocol）

用来声明类接口，之前文件有定义和实现，现在新增接口概念。只要是某个类遵守了这个协议，就相当于拥有了这个协议中所有方法的声明。协议的文件名为 `*.h` 文件，并且只有 `*.h` 文件。在协议中只能定义或者说是声明方法，协议的作用就是专门用来定义或者声明方法的。

```objective-c
@protocol 协议名称 <NSObject, ...>
// 方法声明
@end

@interface 类名: 父类名 <协议名称, ...>
@end
```

如果一个类遵守了某协议，但是没有实现其定义的方法时，在编译或者运行的时候就会报错。可以使用 `@required` 或者 `@optional`在协议中定义方法是否为必须实现的。协议可以从另外一个协议继承并且可以多继承，当继承了某协议后那么该协议就拥有的继承协议的方法声明。类的名称可以和协议的名称一直，在 `Foundation` 框架中，`NSObject` 即是基协议也是一个基类。

```objective-c
int main() {
    Person<ProtocolName> *obj = [Person new]; // Person 类必须遵守 ProtocolName 协议，否则将会发出警告。
}
```

可以在声明指针变量的时候，让其必须遵守某个协议，否则将发出警告，如果需要遵守多个协议就在 `<>` 类型限定中书写多个协议名称即可。

## Foundation 框架

`Foundation` 框架就是在 `C` 语言的基础上封装了很多类，简化了很多代码，也是 `Objective-c` 的核心部分。

### 常用类的介绍

## UIKit

### 动画

在 `UIKit` 框架中，移动控件的位置或者修改控件的大小时可以开启动画效果。

```objective-c
@implementation ViewControll
- (void) viewDidLoad {
    [super viewDidLoad];
    
    // 1. 开启动画
    [UIView beginANimations: nil context: nil];
    
    // 2. 设置动画的时长
    [UIView setAnimationDuration: 2];
    
    // 3. 修改控件的大小和位置
    // ...
    
    // 4. 提交动画
    [UIView commitAnimations];
}
@end
```

### UIImageView 图片列表动画

在 `UIImageView` 中可以为 `animationImages` 属性设置多个图片资源并为其开启动画，关键API如下：

- `@property(nonatomic, copy) NSArray * animationImages;`
- `@property(nonatomic) NSTimeInterval animationDuration;`
- `@property(nonatomic) NSInteger animationRepeatCount;`
- `- (void) startAnimating;`
- `- (void) stopAnimating;`
- `- (BOOL) isAnimating;`
- `- (void) preformSelector: @selector() withObject:NSObject afterDelay: number;`

### 关于加载图片后的内存占用问题

使用 `[UIImage imageNamed: @""]` 方法加载的图片资源会在内存中进行缓存，如果在使用到大量的图片时。不希望过多的占用内存而导致的异常，请使用 `[UIImage imageWithContentsOfFile: @""]` 方法加载图片资源，该图片资源会在失去引用时自动清除在内存中的残留，并且在图片使用完毕后延迟将指针变量引用为 `nil`。

### 加载 `*.plist` 文件内容的方法

使用 `[NSBundle mainBundle] pathForResource:@"" ofType: @""` 读取根路径下的文件路径，然后使用 `NSObject *WithContentsOfFile: @""` 方法将文件内容读取到对象中去。

```objective-c
NSString *path = [[NSBundle mainBundle] pathForResource:@"<文件名称>" ofType:@"<文件后缀>"];
[NSArray arrayWithContentsOfFile:path]; // 将文件读取到数组中, 如果 .plist 文件中的数组类型为数组的话.
```

### 字典转模型

将 `*.plist` 文件内的内容转换为 `NSObject` 对象类型，这样可以在使用和赋值当中避免取值错误而造成的运行时间的错误，在使用这种思想的时候请为你的模型对象设置便捷的初始化方法。

```objective-c
@implementation ViewController {
    - (NSArray *) data {
        if (_data == nil) {
            // 使用数据对象懒加载数据
            // 1. 获取 *.plist 的文件路径
            NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType: nil];
            
            // 2. 读取文件中的内容
            NSArray *content = [NSArray arrayWithContentsOfFile: path];
            
            // 3. 生成一个可变长数组存储数据
            NSMutableArray *models = [NSMutableArray array];
            
            for (NSDirectory *dict in content) {
                ModelName *model = [[ModelName alloc] init];
                model.field = dict[@"field"];
                [models addObject: model];
            }
            _data = models;
        }
        return _data;
    }
}
```

### 封装 xib

`xib` 其实和 `storyboard` 一样都是描述控件的文件，两者的区别的 `storyboard` 描述的是重量级的（比如承载着页面的跳转等操作），`xib` 描述的是轻量级的（比如只是展示一些信息或者是封装可复用组件等操作）。主要的目的还是为了减少在代码中动态创建控件的代码量。

```objective-c
// 加载 xib 文件
NSArray *views = [[NSBundle mainBundle] loadNibNameed: @"xib文件名称" owner: nil options: nil];
UIView *view = [views firstObject];
```

需要在 `xib` 文件中为各个控件设置 `tag` 并使用 `[UIView viewWithTag: number]` 获取子控件对象，

## Xcode 使用指南

### 快捷键

1. 代码格式化 `control + i` 如果希望全文件格式话则先全选文件内容
2. 快捷注释 `option + command + /`

