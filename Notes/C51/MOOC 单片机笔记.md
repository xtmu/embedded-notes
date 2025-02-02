---
created: 2023-10-12T13:31
updated: 2023-10-12T13:32
---
>[!oref]- 参考
> [爱课程](https://www.icourses.cn/web/sword/portal/shareDetails?&cId=5981#/course/chapter)

## 单片机概述
ATMEL 公司的 AT89S51 比 AT89C51(C 代表 cmos，省电) 多了 ISP（在线编程）、看门狗功能。
EMCU(Embed MicroController Unit)：嵌入式微控制器，又称单片机
### 应用领域
| 工业自动化 | 自动检测与控制 | 智能仪器仪表 | 机电一体化 | 汽车电子 | 家用电器 |
| ---------- | -------------- | ------------ | ---------- | -------- | -------- |
|            |                |              |            |          |          |
### 功能分类
- 通用型：无程序，自行编程及拓展
- 专用型：家用电器中的厂商定制的通用单片机，成本低
### 16位单片机
TI 公司 MS430
### 单片机公司
羚羊（台湾），AVR（工业），PIC（工业）（ ，STC（中国，抗干扰提高，定时器，串口性能都有提升），飞思卡尔（Motorola ），MCS51(Intel)，日立，荷兰飞利浦，
### 其他
- 驱动电流一般是几毫安
- 选购单片机时不要大马拉小车

### MCS-51 系列
#### 基本型
8051 先入为主，且好掌握
8031/8051/8751 区别在与片内程序存储器，31 无片内必须外扩，51 有 4k ROM ，751 有 4k [[EPROM]](紫外可擦除)
#### 增强型
增加了多种外设 8052
8052/8052/8752 区别在于定时器多了一个，程序存储器 4k 变 8k

#### 兼容 mcs8051 内核的单片机
兼容 89c51 主要在两方面：内核和指令系统(111条)一样
![[Pasted image 20231003112815.png]]
c80c51f 集成度高，是一个 SoC(system on chip) 单片机。

at89c/s51 和 mcs8751 ：主要区别是替换 4k EPROM 为了 4k FLASH 

89s51 相比 c51 优势：时钟频率 33MHz ，可在线编程

at89c55 : 20k flash

## 硬件结构
本文档主讲 AT89S51
### 硬件组成
- 8 位 CPU
- 128 B RAM
- 4 KB Flash ROM
- 4 个 8 位并行 I/O 口(P0 到 P3)
- 一个[[全双工]][[异步]]串口
- 两个 16 位定时/计数器
- 一个看门狗定时器
- 中断系统：5 个中断源、5 个中断向量
- 特殊功能寄存器 SFR 26 个
- 低功耗的空闲模式和掉电模式
- 3 个程序加密位
#### s51 相比 c51 额外部件：
- 增加 ISP (in system program)，现场程序调试更灵活；
- 数据指针 2 个，方便对外 RAM 访问；
- 看门狗定时器，跑飞或陷入死循环后复位程序，提高抗干扰能力；
- 增加了断点标志；
- 增加掉电状态下的中断恢复模式；

### 结构特点
单一总线；
传统微机结构：CPU 加外围芯片；
集中控制方式：CPU 对功能部件的控制采用特殊功能寄存器 FSR

### 功能部件介绍
#### CPU
8 位；包含运算器和控制器；有位处理功能
#### 数据存储器 RAM
128 B（52 系列 256 B），可扩展到 64 KB ，片内 RAM 为高速 RAM ，速度高，功耗低；片内和片外前 128 B 不能冲突（访问指令不同）。
#### 程序存储器 Flash ROM
4 KB （52 系列 8 KB，55 系列 20 KB ），片外可扩至 64 KB 
#### 中断系统
5 中断器，2 级中断优先级
#### 定时/计数器
2 个 16 位定时/计数器（52 为 3 个），四种工作方式
#### 看门狗计时器 WDT 
#### 串行口
全双工异步串行口，四种工作方式，可串行，扩展并行 I/O 口，可与多个单片机构成多机系统。
#### P1,P2,P3,P0 
四个八位并行 I/O 口
#### 特殊功能寄存器 SFR
26 个（c51 为 21 个），对片内部件进行管理、控制、监视。是各功能部件的**控制寄存器**和**状态寄存器**，映射在片内 RAM 区 80H-FFH
### 引脚

#### 电源
##### Vcc
+5 V 电源
##### Vss
数字地
#### 时钟
##### XTAL1
输入端
- 使用片内振荡器时，接外部石英晶体和微调电容
- 使用外接时钟源时，接外部时钟振荡器信号
##### XTAL2
片内振荡器反相放大器的输出端
- 使用片内振荡器时，接外部石英晶体和微调电容
- 使用外接时钟源时，脚悬空
#### 控制
##### RST 
复位信号输入，保持大于 2 个机器周期的高电平会复位单片机，平常应该保持 <= 0.5V
看门狗是个计数器，内部和 RST 相连，当程序跑飞或死循环时，没有正常指令给计数器清零，计数器就会溢出，溢出后看门狗会输出长达 96 个时钟周期的高电平给 RST 。
##### EA*/VPP 31
enable address/voltage pulse of programing
第一功能：EA* 允许外部程序存储器控制
决定是否访问片内 Flash，片内 Flash 大小为 4k (2^12)( 0000H ~ 0FFFH )
a) EA* = 1 
- PC值 <= 0FFFH，读取 4KB Flash 中的程序;
- PC值 > 0FFFH，读取片外 60KB 程序存储器空间中的程序。	
b) EA* = 0
- 只使用拓展 ROM (1000H~FFFFH)，片内 Flash  被屏蔽
第二功能：Vpp 接**编程电压**，利用编程器，对片内 Flash 编程。
##### ALE/PROG* 30
Address Latch Enable/PROGramming
第一功能 ALE ：为访问外部存储器提供低 8 位**地址锁存信号**，将低 8 位地址锁存在片外地址锁存器中。
![[Pasted image 20231003185412.png]]
单片机运行时 ALE 会输出正脉冲信号，频率为六分之一时钟频率，但是访问片外 RAM 时会有损失。
第二功能 PROG* ： 向片内 Flash 写入程序时，每写一个单元要加一个编程脉冲
##### PSEN* 29
Program Strobe ENable
片外程序存储器的读选通信号，低电平有效
#### 并行 I/O 口引脚
P0 口： 8 位，[[漏极开路]]的双向 I/O 口。

# # Footnotes

[^1]: [EEPROM 和 flash 这样讲，早就懂了！ - 知乎](https://zhuanlan.zhihu.com/p/598760044)