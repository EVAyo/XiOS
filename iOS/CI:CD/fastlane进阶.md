

# fastlane构建手动传参



## 真假判断

```shell
lane :TrueOrFalse do |options|

  if 0
    puts '我是真'
  else 
    puts '我是假'
  end

end
```











## 外部传参

```shell
# 定义常量
output_name = “TestOne”

# lane
lane :getParam_lane do |options|         # 传参

  # 打印
  puts 'print something'

  # 使用常量
  puts "#{output_name}"

  # 字符串拼接
  puts '字符串A' + '字符串B'

  # 获取外部参数
  puts '外部参数是：' + "#{options[:a]}"

end
```



## 调用

```shell
$ fastlane getParam_lane a:123 b:abc

# 输出
[23:40:41]: print something
[23:40:41]: TestOne
[23:40:41]: 参数是asdf
[23:40:41]: 参数：123
[23:40:41]: 参数：123abc
```

