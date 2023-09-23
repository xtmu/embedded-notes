## 大数吃小数
当两个数量级相差大的浮点数进行运算时，小的数会被视为 0。因为浮点数的精度有限，小的数在对齐时会右移，逐渐丢弃尾数末位，当丢弃过多第一个有效位也被丢弃时，就变成零了。

## 位运算符异或^
### 场景
1. 快速交换两个变量的值
2. 奇偶判断
	- 偶数 ^1 会加 1，奇数 ^1 会减 1
3. 加密解密数据
4. 通信中用来计算校验和

>[!caution] 
> 按位异或不同于逻辑运算，需要确保两操作数位数相同.

## 关键字
### static
- 作用域为翻译单元（函数内为函数体范围，函数外为整个源文件范围）；生命周期为整个程序的生命周期。
- 只进行一次初始化；
- 优点是能在函数多次调用之间保持状态，常用于单例、计数器、缓存。

### switch
case 不支持浮点型数据。
default 可有可无，无需放最后。

### typedef
`typedef 数据类型 别名;`

```c
struct {int x;int y} point1,point2;

struct Point {int x;int y}; struct Point point1,point2; // Point 是结构体标签

typedef struct {int x;int y} Point; Point point1,point2;
```
## 声明时各运算符优先级
1. 括号部分
2. 后缀运算符
	-  () 函数声明
	-  \[\] 数组声明
3. 前缀运算符
	1. & 引用声明
	2. \* 指针声明
4. const 及 volatile 关键字
	- 关键字右边紧跟类型说明符（int、long）时作用于类型
	- 否则作用于左边的指针符号 *

## 常量指针与指针常量

```c
//常量指针，两种写法等价
const int* p; //推荐
int const* p; 

//指针常量
int* const p; 
```
常量指针使用场景：
- 传递只读数据
- 指向字符串字面值（常量字符数组）
- 指向对象让对象的状态在其生命周期内不可变。
- 编译器会将常量指针指向的数据存到只读区，能提高性能。

## 条件运算符
不支持嵌套。
制表用法：
```c
printf((i<1)?"%d":" %d",arr[i]);
```

## 数组

### 数组初始化
1. 初始化列表
2. 循环初始化
3. 部分初始化
4. 字符串初始化字符串数组
5. 动态初始化
```c
int nums[]={}; // 所有元素初始化为 '\0'
char nums2[]={}; // 所有元素初始化为 '\0'
int nums3[10]{1}; //第一个元素初始化为 1
char str[]="hello";
int *dynArr = (int *)malloc(size * sizeof(int)); // 不初始化
free(dynArr);
int *dynArr2 = (int *)calloc(1,size * sizeof(int)); // 分配 1 段参数二大小的空间并初始化
free(dynArr2);
```

### 数组名的含义
分两种情况：
1. 以下情况数组名代表数组
```c
&arr
sizeof(arr)
```

2. 其余情况数组名代表数组首元素地址
`arr` 等价于 `&arr[0]`
![[数组名的含义.png]]

#### 数组名的指针形式改写
```c
char s[]="love";
// &s[i] ⇔ s+i
// s[i] ⇔ *(s+i)
```

### 字符数组和字符指针的本质区别
```cpp
char s1[] = "hello world"; // s1 是字符数组，数组的每个元素都可以修改。
char *s2 = "hello world";  // s2 是字符型指针，指向字符串常量的第一个字符，字符串常量是不可修改的。
*s1 = 'A'; //正常
// *s2 = 'A'; // 报错
```

### 行字符串输入输出
```c
char s[10]={};
gets(s) 读取一行并将 '\n' 替换成 '\0' 存入字符串
puts(s) 输出一行字符串并输出一个 '\n'
```

```cpp
string s;
getline(cin,s);
```

## 结构体
结构体的分量可以是任意基本数据类型及其指针，唯一不能是结构体本身，但可以是结构体本身的指针。
### 自引用结构体(参考 C++ 类的 this 指针)
```c
typedef struct Ptag
{
	int x;
	int y;
	struct Ptag *next; // struct Ptag * 作为分量是合法的，PTag 可和 Point 同名
} Point;

Point p1, p2, p3, p4, p5;
Point *p;
p1.x = 10; p1.y = 1; p2.x = 20; p2.y = 2; p3.x = 30; p3.y = 3; p4.x = 40; p4.y = 4; p5.x = 50; p5.y = 5;

p1.next = &p2; p2.next = &p3; p3.next = &p4; p4.next = &p5;
p5.next = NULL;

for (p = &p1; p != NULL; p = p->next)
{
	printf("(%d, %d)\n", p->x, p->y);
}
```

## 函数参数传递
### 二维数组
二维数组作为实参传递给函数时，所匹配的形参为行指针；即形参数组行要省略，列不省略
```c
func(int Arr[][4]){};
```
![[数组实参与匹配的形参.png]]

## C 库

### stdio.h

#### printf 格式修饰符
```c
// %x 十六进制格式
```

#### sprintf()
```c
s1="hello";
s2="world";

sprintf("%.3s %.4s",s1,s2); // 输出 "hel worl"
int m=3;int n=4;
sprintf("%.*s %.*s",s1,s2); // 输出 "hel worl"
```

#### scanf()
自定义休止符
```c
scanf("%[^\n]",&line); // 休止符为 '\n' 前的字符,即录入无换行行 ，'\n' 需要用 getchar() 清除
scanf("%[^ ]",&str); // 休止符为 ' '，即录入的是无空格字符串
```

#### fwrite()
#### fread()
#### freopen()
#### freopen()
#### fseek()
#### rewind()
### conio.h
#### getch()
- 阻塞函数，无接受不返回；
- 与 getchar() 的区别是不回显；
#### kbhit()
- 非阻塞函数，无接受时返回 0，有接受时返回 1；
### stdlib.h
#### malloc()
#### srand() 和 rand()
#### malloc()

### string.h
#### strlen()
#### strcpy()
#### strcat()
#### strcmp()

#### strlen() 与 sizeof()
```c
strlen("love") //4
strlen("love\0") //4

sizeof("love") //5
sizeof("love\0") //6
```

### ctype.h
字符大小写，字符分类
### time.h
#### time(NULL)
生成当前时间戳
#### strftime()
由`localtime(time(NULL))`返回的结构体生成特定格式日期时间字符串
```c
#include <stdio.h>
#include <time.h>

int main() {
    time_t currentTime;
    struct tm *timeInfo;
    char timeString[80];

    currentTime = time(NULL);
    timeInfo = localtime(&currentTime);

    strftime(timeString, sizeof(timeString), "%Y-%m-%d %H:%M:%S", timeInfo);
    printf("Formatted time: %s\n", timeString);

    return 0;
}

```
#### ctime()
将时间戳转换为日期时间字符串
### math.h
#### fabs()
#### floor()
#### pow()

#### memset()
逐字节初始化

### memory.h
#### memcpy()
可用于数组间赋值；
```c
memcpy(arrB,arrA,5*sizeof(int)); //5 为数组长度，两数组长度相同
```
### Windows.h
#### Beep(fre,delay)
#### Sleep()

### shellapi.h

#### ShellExecute()

##### 调用另一个 exe 程序
[C++使用ShellExecute打开目标文件所在文件夹并选中目标文件\_c++打开指定路径文件\_dvlinker的博客-CSDN博客](https://blog.csdn.net/chenlycly/article/details/7366364)
```c
    CString str = _T("/select, E:\\TestDir\\test.txt");   
    ShellExecute( NULL, _T("open"), _T("explorer.exe"), str, NULL, SW_SHOWNORMAL );  
```

##### 执行命令行程序
```c
ShellExecute(NULL, "runas", "cmd", "/c ipconfig >> D:\\disk.txt", NULL, SW_SHOWNORMAL);
```

## C++ 库
### iostream
#### exit()
### bitset
#### bitset()
返回数据在内存中的二进制形式（补码）
```cpp
bitset<转换后的位数>(将被转成二进制的数) // 被转换的位数 = 8*sizeof(待转换的数)
```

## 虚拟键值查询
[虚拟键码 (Winuser.h) - Win32 apps | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/win32/inputdev/virtual-key-codes)

## 条件编译
常用于头文件中，防止双重定义
```c
#ifdef
// 程序段1
#else
// 程序段2
#endif
```
