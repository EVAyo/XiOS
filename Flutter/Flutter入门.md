

# 前提

环境





```
$ flutter create <Project Name>
```



```
$ flutter run 
$ flutter run -d 'iPhone X'
```



导入库

```
import 'package:flutter/material.dart';
```



hello world 

```
import 'package:flutter/material.dart';

void main() {
  runApp(
    Center(
      child: Text(
        'hello world',
        textDirection: TextDirection.ltr,
     ),
    ),
  );
}
```



目录结构

```
android 
build
ios
lib
	- src
	- main.dart
test  			
pubspec.yaml
```



图片 及 分辨率

获取本地资源







国际化























