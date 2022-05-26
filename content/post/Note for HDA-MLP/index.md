---
title: Note for A Data-Driven Method for Hybrid Data Assimilation with Multilayer Perceptron
subtitle: 

# Summary for listings and search engines
summary: 提出HDA-MLP对同化结果进行优化，并用MLP替换模式进行预测

# Link this post with a project
projects: []

# Date published
date: "2021-04-17"

# Date updated
lastmod: "2021-04-17"

# Is this an unpublished draft?
draft: false

# Show this page in the Featured widget?
featured: false

# Featured image
# Place an image named `featured.jpg/png` in this page's folder and customize its options here.
image:
  caption: 'Image credit: [**Unsplash**](https://unsplash.com/photos/CpkOjOcXdUY)'
  focal_point: ""
  placement: 2
  preview_only: false

authors:
- admin

tags:
- Academic
- Data Assimilation
- Machine Learning

categories:
- Note
- 笔记
---

## 主要工作

提出一种HDA-MLP方法，在输出DA结果时有很好的进步性，且计算量小。

-   通过MLP对单一DA方法(3DVar和EnKF)进行了形式化优化，并构建了新的训练数据集，添加了未来的短期预测来修正当前的同化结果，显著提高了结果的质量
-   为了优化同化结果，提出了一种新的3D-Var定制MLP
-   整合了一个创造性的MLP框架HDA-MLP来混合单一的3D-Var和EnKF

## 问题定义

<img src="https://cdn.jsdelivr.net/gh/wuxinwang1997/blogImages/fi3.png" alt="fig3" style="zoom:67%;" />

短期预测作为背景场$\mathrm{x}^b$，结合来自新鲜观察$\mathrm{y}^o$的信息来获得分析场$\mathrm{x}^a$，这称作分析循环

单个同化（3D-Var/EnKF）的目的是寻找最佳权重$\mathcal{w}$使得
$$
x^a_t=x^b_t+w*(y^o_t-x^b_t)
$$


集合同化则是从不同的同化结果中进行加权
$$
x_{hybrid}^a=(1-v)*x_{Var}^a+v*x_{Ensemble}^a
$$


当前的$\mathrm{x}^a$受到多时刻历史数据的影响，可以将DA重新定义为一个时间序列问题。本文扩展认为，未来的短期预测$\mathrm{x}^b$是由之前的$\mathrm{x}^a$扩展得到的，未来短期的观测$\mathrm{y}^o$可以独立观测，用于修正$\mathrm{x}^a_t$，更具DA的动态性质，它也可以用来修正当前的分析场。

$x^a=f\left(historical(x^b,y^o),future(y^o)\right)$

其中$f$为训练得到的DA模型

考虑使用一段时间的$\mathrm{x}^a$来获得最终的$\mathrm{x}^a$，而不是将不同方法的DA结果结合。因此，混合DA可以定义为基于不同DA方法的多时刻$\mathrm{x}^a$的回归问题。

$x_{Hybrid}^a=F(x_{Var}^a,x_{Ensemble,l}^a),l=1,2,3,\cdots$

其中$F$为训练得到的混合DA模型，$l$表示$\mathrm{x}^a$的长度

## 方法

### HDA-MLP：优化问题

类似4DVar-DA，将同化时间窗设为$[t_1,t_n]$，利用前半段数据进行分析，利用后半段诗句对时间窗中的分析场进行修正，对当前分析场的优化由下式决定
$$
x_{ct}^a=\sum\limits^p_{i=0}w_{ct-i}x_{ct-i}^b+\sum\limits^q_{i=0}v_{ct-i}y_{ct-i}^o+bias
$$
其中$ct=\frac{n+1}{w},p=\frac{n-1}{2},q=n-1$，$\mathcal{w},\mathcal{v}$分别为$\mathrm{x}^b,\mathrm{y}^o$的权重矩阵

<img src="https://cdn.jsdelivr.net/gh/wuxinwang1997/blogImages/fi4.png" alt="fig4" style="zoom:67%;" />

![fig5](https://cdn.jsdelivr.net/gh/wuxinwang1997/blogImages/fi5.png)

### 混合

使用MLP优化过的结果作为训练集，直接混合优化后的3D-Var和EnKF的分析场，再用于分析$\mathrm{x}^a_t$

## 实验结论

在Lorenz-63上结果比较显著，但是在Lorenz-96上效果不太明显。

## 分析

1.  有可能是三层MLP用于替换模式不能捕获Lorenz-96这类稍微复杂的混沌模型的规律，考虑使用时空序列预测的深度学习模型替换模式进行短期预测
2.  可能是3D-Var本身不考虑时间的维度信息，缺少时间的指导，考虑用RNN替换MLP获取时间信息以增强同化结果