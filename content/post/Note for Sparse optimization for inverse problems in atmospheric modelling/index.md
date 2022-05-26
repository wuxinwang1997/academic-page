---
title: Note for sparse optimization for inverse problems in atmospheric modelling
subtitle: 

# Summary for listings and search engines
summary: 将大气中的反问题转化为稀疏优化问题进行求解

# Link this post with a project
projects: []

# Date published
date: "2021-11-11"

# Date updated
lastmod: "2021-11-11"

# Is this an unpublished draft?
draft: false

# Show this page in the Featured widget?
featured: false

# Featured image
# Place an image named `featured.jpg/png` in this page's folder and customize its options here.
image:
  caption: 'Image credit: [**Inverse Problem**](https://tse1-mm.cn.bing.net/th/id/R-C.f3f66f9e34ac0b0d10c518135e7c8fa3?rik=%2fHcwpOHBr8AxJQ&riu=http%3a%2f%2fwww.siltanen-research.net%2fIPexamples%2fslides%2fwhat_are_inverse_problems%2fslide1.png&ehk=l2cD7PBTAn3ObxnUzw2y1UWwqEcgEGwmf6zGow0iEXc%3d&risl=&pid=ImgRaw&r=0)'
  focal_point: ""
  placement: 2
  preview_only: false

authors:
- admin

tags:
- Academic
- Data Assimilation
- Observation correlation

categories:
- Note
- 笔记
---

文章将要解决的问题简化为一个最优化问题
$$
\begin{align}
  &\min_x \left\| Mx-y \right\|_2^2 \\\\
  &s.t \quad x \geq 0
\end{align}
$$


其中$M$是一个映射（理解为观测算子），$y$为观测，$x$为位置的排放位置，$M$是一个$\mathbb{R}^n \rightarrow \mathbb{R}^m$的映射（$M \in \mathbb{R^{m \times n}}$）。

## Spatial and temporal location weighting

对于每个观测$y_j$，假设有一个数据$z_j=(z_j^x,z_j^y,z_j^t)$，其中$(z_j^x,z_j^y)$描述了观测的经纬度，$z_j^t$描述观测时刻。定义与观测$z_i,z_j$的距离相关的权重，首先对空间和时间权重定义如下:
$$
{\small
  \begin{align}
  w_S(z_i,z_j) &= 
  \begin{cases}
  \exp\left(-\alpha_S\left\|(z_i^x,z_i^y)-(z_j^x,z_j^y)\right\|\right) & if \left\| (z_i^x,z_i^y)-(z_j^x,z_j^y) \right\| \leq s_{max} \\\\
  0 & otherwise
  \end{cases} \\\\
  w_T(z_i,z_j) &= 
  \begin{cases}
  \exp\left(-\alpha_T\left\|z_i^t-z_j^t \right\|\right) & if \left\| z_i^t,z_j^t \right\| \leq t_{max} \\\\
  0 & otherwise
  \end{cases}
  \end{align}
}
$$

其中$\alpha_S,\alpha_T \geq 0, s_{max}, t_{max} \in [0, \infty]$为给定的参数。

注：为何使用指数函数来进行权重的定义？直接用范数定义不行吗？

然后对$z_i$与$z_j$的距离相关权重定义如下
$$
  w(z_i,z_j)=w_S(z_i,z_j)w_T(z_i,z_j)
$$

注：这里使用乘法就将指数函数中距离进行了加权求和，相当于对空间距离以及时间距离进行了加权得到新的距离，再用指数函数得到权重，那为什么不用$\ln,\log$等对数函数呢？（指数函数可以保证权重是正数）（问题：一定要是正相关的权重吗？能不能是负数？对于污染气体排放问题，一定是正数，而对于别的观测，如风速风向等则有可能互相之间有负相关的影响。）

接下来对每个观测$j=1,2,\cdots,m$，都想要最小化如下式子：
$$
  \left(\sum^m_{i=1}\frac{w(z_j,z_i)}{\sum^m_{k=1}w(z_j,z_k)}(Mx)_i-\sum^m_{i=1}\frac{w(z_j,z_i)}{\sum^m_{k=1}w(z_j,z_k)}y_i\right)^2
$$
推导：

本来需要最优化的式子为：
$$
  \left((Mx)_j-y_j \right)^2
$$

考虑不直接优化该式，转而优化$Mx$与$y$在点$j$的邻居上的距离，考虑$j$与$i$的距离权重占$j$与所有点的距离权重总和来对$i$与$j$的关系进行加权
$$
  \frac{w(z_j,z_i)}{\sum^m_{k=1}w(z_j,z_k)}
$$

表示了$i$对应的数值对$j$的影响占所有$i$对$j$总影响的权重，那么，这里相当于做了一个归一化处理，将指数函数变成了$[0,1]$区间的值。再对该权重乘以对应$i$的值得到$i$对$j$的影响值，则得到要优化的式子。

则，转为最优化
$$
  \sum^m_{j=1}\left(\sum^m_{i=1}\frac{w(z_j,z_i)}{\sum^m_{k=1}w(z_j,z_k)}\left((Mx)_i-{\sum^m_{k=1}w(z_j,z_k)}y_i\right)\right)^2
$$
等价于
$$
  \left\| W(Mx-y) \right\|^2_2
$$
其中权值矩阵$W$由元素
$$
  w_{ij}=\frac{w(z_i,z_j)}{\sum^m_{k=1}w(z_i,z_j)}
$$
组成。
则问题变为
$$
\begin{align}
  &\min_x \left\|WMx-Wy\right\|^2_2 \\\\
  &s.t \quad x \geq 0
\end{align}
$$

## Sparse optimization

稀疏优化的问题，首先提到了常见的方法：

1. 删除列
2. $L_2$正则化
3. $L_1$正则化（这个可以得到稀疏解）

参考如下知乎回答了解得到$L_1$正则化得到稀疏解的原理

[(7 封私信 / 75 条消息) l1 相比于 l2 为什么容易获得稀疏解？ - 知乎 (zhihu.com)](https://www.zhihu.com/question/37096933/answer/70938890)

文章对于要求解的问题，不直接使用正则化的方法，而是考虑多目标优化的方案得到稀疏解（不损失信息），主要目的是不修改目标或者数据，只假设解是稀疏的，这样其正则化参数就是一个常量。

考虑$0$范数，定义为
$$
  \left\| x \right\|_0 = \text{card} \\{i | x_i \neq 0\\}
$$
其中$\text{card}A$定义了$A$的元素个数。

则，稀疏优化想要同时最小化$\|x\|_0$与原始目标，即

$$
\begin{align}
  &\min_x \left\| WMx-Wy \right\|^2_2 \\\\
  s.t \quad &\|x\|\_0 \leq k_{tol} \\\\
  &x \geq 0
 \end{align}
$$

但这就造成了一个非凸优化问题，考虑$z_i \in \{0,1\}$，则
$$
  0 \leq x_i \leq z_i ub_i
$$

其中$ub_i$为$x_i$的上界，同样的考虑下界$lb_i$

以上问题转化为：

$$
\begin{align}
  & \min_x \left\| WMx-Wy \right\|^2_2 \\\\
  s.t \quad & \sum^n_{i=1} z_i \leq k_{tol} \\\\
  & z_ilb_i \leq x_i \leq z_iub_i, i = 1,2,\cdots,n \\\\
  & z_i \in \{0, 1\}
\end{align}
$$

将以上问题写作矩阵形式

$$
\begin{align}
  &\min_u u^THu+h^Tu \\\\
  & Au \leq b \\\\
  & u_z \in \{0,1\}
\end{align}
$$

其中
$$
  \begin{align}
  & u = (x,z), u_z = z\\\\
  & H = 
  \begin{pmatrix}
  M^TW^TWM & 0_{n \times n} \\\\
  0_{n \times n} & 0_{n \times n}
  \end{pmatrix}, 
  h = 
  \begin{pmatrix}
  -2M^TW^TWy \\\\
  0_{n \times 1}
  \end{pmatrix} \\\\
  & A = 
  \begin{pmatrix}
  0_{1 \times n} & 1_{1 \times n}\\\\
  -diag(1_{n \times 1}) & diag(lb) \\\\
  diag(1_{n \times 1}) & -diag(ub)
  \end{pmatrix},
  b = 
  \begin{pmatrix}
  k_{tol} \\\\
  0_{n \times 1} \\\\
  0_{n \times 1}
  \end{pmatrix}
  \end{align}
$$
