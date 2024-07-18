# 怎么用 copy 关键字？

* NSString、NSArray、NSDictionary等等经常使用copy关键字，是因为他们有对应的可变类型：NSMutableString、NSMutableArray、NSMutableDictionary，为确保对象中的属性值不会无意间变动，应该在设置新属性值时拷贝一份，保护其封装性
* block也经常使用copy关键字
    * block 使用 copy 是从 MRC 遗留下来的“传统”,在 MRC 中,方法内部的 block 是在栈区的,使用 copy 可以把它放到堆区.
    * 在ARC中写不写都行：对于 block 使用 copy 还是 strong 效果是一样的，但是建议写上copy，因为这样显示告知调用者“编译器会自动对 block 进行了 copy 操作”





假如有一个NSMutableString,现在用他给一个retain修饰 NSString赋值,那么只是将NSString指向了NSMutableString所指向的位置,并对NSMUtbaleString计数器加一,此时,如果对NSMutableString进行修改,也会导致NSString的值修改,原则上这是不允许的. 如果是copy修饰的NSString对象,在用NSMutableString给他赋值时,会进行深拷贝,及把内容也给拷贝了一份,两者指向不同的位置,即使改变了NSMutableString的值,NSString的值也不会改变.

所以用copy是为了安全,防止NSMutableString赋值给NSString时,前者修改引起后者值变化而用的.



strong修饰NSString

```objective-c
@property (nonatomic, strong) NSString *name;

- (void)string_strong {
    NSMutableString *mStr = [NSMutableString stringWithString:@"张三"];

    self.name = mStr;

    NSLog(@"使用strong第一次得到的名字：%@", self.name);

    [mStr appendString:@"丰"];

    NSLog(@"使用strong第二次得到的名字：%@", self.name);
}

// 输出
使用strong第一次得到的名字：张三
使用strong第二次得到的名字：张三丰
```





copy修饰NSString

```objective-c
@property (nonatomic, copy) NSString *title;

- (void)string_copy {
    
    NSMutableString *mStr = [NSMutableString stringWithString:@"张三"];

    self.title = mStr;

    NSLog(@"使用copy第一次得到的名字：%@", self.title);

    [mStr appendString:@"丰"];

    NSLog(@"使用copy第二次得到的名字：%@", self.title);
}

// 输出
使用copy第一次得到的名字：张三
使用copy第二次得到的名字：张三
```











