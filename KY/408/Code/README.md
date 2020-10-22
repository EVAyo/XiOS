# 终端写C程序

```shell
// 创建
$ vim 001.c

// Coding
#include <stdio.h>
int main(){
	printf("AAAA");
}

// GCC 编译
$ gcc 001.c         // 默认生成a.out
$ gcc -o 001.out 001.c    // 自定义生成001.out

// 运行
$ ./a.out
```



# 线性表



## 静态分配

```C
#define MaxSize 10							// 定义最大长度
typedef struct {
		ElemType data[MaxSize];			// 用静态的『数组』存放数据元素
  	int Length;									// 顺序表当前的长度
}SqList													// 顺序表的类型定义（静态分配方式） Sq:Sequence 顺序、序列
```





```C
#include <stdio.h>

// 宏定义
#define MAXSIZE 10      // 定义最大长度
#define ElemType int    // 定义顺序表存储的类型，可自行设置

// 顺序存储结构的线性表的类型
typedef struct {
    ElemType data[MAXSIZE]; // 用『静态数组』存放数据元素
    int length;             // 顺序表的当前长度
}SqList;                    // 顺序表的类型定义（静态分配方式） Sq:Sequence 顺序、序列


//========================== 初始化 InitList ==========================
// 顺序表初始化一
SqList InitList() {
    SqList L;
    L.length = 0;
    return L;
}

// 顺序表初始化二
void InitList_2(SqList &L) {
    for (int i = 0; i < MAXSIZE; i++) {
        L.data[i] = 0;
    }
    L.length = 0;
}

int main() {
    // 方式一
    SqList L1 = InitList();
  
    // 方式二
    SqList L2;        // 声明一个线性表
    InitList_2(L2);  	// 初始化该线性表
  
    return 0;
}


// GCC编译不通过！！！

问题：
		编译的时候报:error: expected ';', ',' or ')' before '&' token
原因：
		C语言中是不存在引用的，也就是说C语言中&表示的不是引用，仅仅是取地址符。
解决：
	第一种：用指针来取代引用，在主函数中传进地址；
	第二种：将代码保存成.cpp文件(c++中支持引用)。
      
// 指针传参
void InitList_2(SqList *L) {
    for (int i = 0; i < MaxSize; i++) {
        L->data[i] = 0;    // 赋默认值，否则会有脏数据
    }
    L->length = 0;
}

// 调用
SqList L2;        // 声明一个线性表
InitList_2(&L2);  // 初始化该线性表
```



## 动态分配







