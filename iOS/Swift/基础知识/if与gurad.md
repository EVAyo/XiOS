guard case 用法

https://stackoverflow.com/questions/32256834/swift-guard-let-vs-if-let





# Guard 作用



## 1. 提前退出

> 如果name不存在，则不需要执行后面的代码，直接返回。

```swift
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
		//.......    
}
```



## 2.使代码清晰，避免金字塔

```swift
func validateFieldsAndContinueRegistration() {
    if let firstNameString = firstName.text where firstNameString.characters.count > 0 {
        if let lastNameString = lastName.text where lastNameString.characters.count > 0 {
            if let emailString = email.text where emailString.characters.count > 3 && emailString.containsString("@") {
                if let passwordString = password.text where passwordString.characters.count > 7 {
                    //......
                } else {
                    //......
                }
            } else {
                //......
            }
        } else {
            //......
        }
    } else {
        //......
    }
}
```



## 3.guard创建的变量作用域

> 使用guard可以创建一个新的变量，该变量将存在于else语句之外。
>
> 新创建的变量只存在于代码块内部。

```swift
func someFunc(blog: String?) {

    guard let blogName = blog else {
        print("some ErrorMessage")
        print(blogName) // will create an error Because blogName isn't defined yet
        return
    }
    print(blogName) // You can access it here ie AFTER the guard statement!!

    // And if I decided to do 'another' guard let with the same name ie 'blogName' then I would create an error!
    guard let blogName = blog else { // errorLine: Definition Conflicts with previous value.
        print(" Some errorMessage")
        return
    }
    print(blogName)
}
```







guard 与 if 区别

1. 与 if 语句不同， guard 语句总是有一个 else 分句，else 分句里的代码会在条件不为真的时候执行。