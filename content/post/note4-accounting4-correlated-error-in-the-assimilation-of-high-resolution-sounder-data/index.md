---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Note for Accounting for correlated error in the assimilation of high-resolution sounder data"
subtitle: ""
summary: "考虑IASI的通道相关性，通过改变特征值来改变矩阵条件数以达到减少同化迭代的目的"
authors: [admin]
tags: [Academic, Data Assimilation]
categories: [Note]
date: 2021-11-13T00:00:00+00:00
lastmod: 2021-11-13T14:09:29+08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: 'Image credit: [**Inverse Problem**](https://tse1-mm.cn.bing.net/th/id/R-C.f3f66f9e34ac0b0d10c518135e7c8fa3?rik=%2fHcwpOHBr8AxJQ&riu=http%3a%2f%2fwww.siltanen-research.net%2fIPexamples%2fslides%2fwhat_are_inverse_problems%2fslide1.png&ehk=l2cD7PBTAn3ObxnUzw2y1UWwqEcgEGwmf6zGow0iEXc%3d&risl=&pid=ImgRaw&r=0)'
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

## 问题背景

截至文章发表前对于IASI的同化中$R$矩阵都假设是对角阵，即观测通道之间是不相关的，主要通过扩大观测误差以间接表示通道间误差相关性，这就人为导致观测权重变低了。

卫星观测误差包括：仪器误差、代表性误差、前向模式误差以及其他预处理误差。之前有工作表明IASI数据中对水蒸气敏感的通道存在相关性，文章通过直接考虑水汽通道相关性以提高对应观测的权重。

## 理论方法
### 同化
考虑变分同化方法（可以将非线性观测如卫星资料进行同化）

$$
J(x) = \frac{1}{2}(\mathrm{x}-\mathrm{x}^b)^TB^{-1}(\mathrm{x}-\mathrm{x}^b)+\frac{1}{2}(\mathrm{y}-H(\mathrm{x}))^TR^{-1}(\mathrm{y}-H(\mathrm{x}))
$$

观测（$R$）和背景（$B$）误差协方差矩阵提供了有关观测和背景误差特征的信息，从而为每个观测提供了对应的权重。

代价函数的Hessian矩阵为

$$
J^{''} = B^{-1}+\mathrm{H}^TR^{-1}\mathrm{H}
$$

其中$\mathrm{H}$为观测算子$H$的雅可比矩阵（各分量二阶偏导数组成的矩阵）。Hessian矩阵与代价函数收敛速度相关，而该性质由矩阵的条件数（$\frac{\lambda_{max}}{\lambda_{min}}$）决定，条件数描述了矩阵与奇异矩阵或不可逆矩阵之间的距离，因此条件数越大，收敛速度越慢。

在业务系统中主要使用增量代价函数，即$J(\delta{x})=J(x-x^g)$，其中$x^g$为已知状态量。在最小化代价函数之前进行变量转换，$\delta x = \mathrm{U}\mathrm{\chi}=\mathrm{U}_h\mathrm{U}_v\mathrm{U}_p\mathrm{\chi}$，其中$\mathrm{U}_p$为参数转换，$\mathrm{U}_v$为垂向变换，$\mathrm{U}_h$为水平变换。则简化后的代价函数的Hessian矩阵为

$$
J^{''} = \mathrm{I}+\mathrm{B}^{T/2}\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H}\mathrm{B}^{1/2}
$$

则Hessian矩阵的$\lambda_{min}=1$，其条件数取决于后一项的条件数，即$\mathrm{R}$矩阵的条件数，那么使用病态的$\mathrm{R}$会导致收敛更慢。

### 观测误差

对于大多数观测，仪器噪声在通道之间不相关，这意味着其相应的协方差矩阵E是对角阵。然而，IASI测量是切趾(apodised)的（Chamberlain，1979），这降低了噪声，但引入了相邻通道之间的相关性，因此其对角线周围有非零协方差频带。

### 观测误差的估计

使用（O-A）与（O-B）进行$\mathrm{R}$矩阵的构建

$$
\mathrm{R}=E\left[\\{\mathrm{y}-H(\mathrm{x}^a)\\}\\{\mathrm{y}-H(\mathrm{x}^b)\\}^T\right]
$$

但是该估计基于以下假设
1. 观测误差与模式误差不想管
2. $\mathrm{B}$和$\mathrm{R}$是完全正确的

Desrozierset al.（2009）表明，观测值和背景误差必须具有足够不同的尺度，才能使诊断结果可靠。

### 诊断结果

尝试区分水平代表性错误方法包括
1. 比较1DVar和4DVar的诊断结果
2. 采用不同分辨率的同化分析的初猜场和分析值得偏差，对这些运行的输出执行Desroziers诊断并检查差异将说明不同IASI通道受代表性错误影响的程度。这还将显示哪些相关性是由代表性错误引起的。差异越大，该通道中的代表性误差越大。

## 修改矩阵

### 对相关性进行统计处理的影响 

考虑相关性时，大多数通道的O-A的标准差都会增大，即考虑相关性会导致观测权重降低（这也是为什么增大误差是抵消误差相关性的一种实用解决方案），误差膨胀永远不会完全补偿被忽略的误差相关性。

### 同化中矩阵的使用

1. 时间：考虑观测误差时计算$R$的逆计算成本很高，常有效的方法时利用Cholesky分解，但必须在每次最小化迭代中对每个观测进行。
2. 迭代次数：由于$\mathrm{O}$和$\mathrm{B}$差别太大或者假设误差太小；或者Hessian矩阵是病态的

正确指定同化中的观测误差，则最终的代价函数应为观测总数/2；Desroziers and Ivanov (2001) and Talagrand (1999)

IASI的完整矩阵的条件数远大于对角阵，而最小化对Hessian和$\mathrm{R}$矩阵的条件数很敏感，这表明减少矩阵条件数可以减少迭代次数提高最小化的稳定性，这可以通过修改矩阵的特征值来实现。

注：对于条件数的理解是这篇文章很重要的一点。需要对最优化、矩阵论较为熟悉。

### 修复矩阵的方法

1. 定义特征值的最小阈值
   $$
   \lambda_{thresh} = \frac{\lambda_{max}}{K_{req}}
   $$
   其中$\lambda_{thresh}$为特征值的阈值，$\lambda_{max}$为特征值最大值，$K_{req}$为要求的最大条件数。

   优点：改动比较小
   缺点：本应有不同误差的通道被赋予相同的权重和误差
2. 对角线增加一个相同的值，以达到需要的条件数
   $$
   \lambda_{inc} = \frac{\lambda_{max}-\lambda_{min} K_{req}}{K_{req}-1}
   $$
   其中$\lambda_{inc}$为增量。
   优点：不同通道误差之间的关系不变
   缺点：最大特征值的变化相对较小，这将会削弱通道之间的相关性

文章经过实验对比采用第二种方法，并通过实验确定目标条件数的取值。

### 修复矩阵的影响

由于误差协方差矩阵对角元素通常比较大，该方法会显著降低相关性。


