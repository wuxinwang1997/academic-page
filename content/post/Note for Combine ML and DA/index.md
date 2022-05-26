---
title: Note for Combining data assimilation and machine learning to emulate a dynamical model from sparse and noisy observations a case study with the Lorenz96 model
subtitle: 

# Summary for listings and search engines
summary: 使用CNN预测混沌模型Lorenz96，采用集合卡尔曼滤波同化数据更新初始场

# Link this post with a project
projects: []

# Date published
date: "2021-04-16"

# Date updated
lastmod: "2021-04-16"

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

## 背景

在地球物理流体动力学中，由于`小尺度特征的表示不正确或物理过程被忽略`，数值模式的某些部分必须由经验子模型或参数化进行表示。地球观测主要包括两个步骤：1. 模型调整和选择；2. 数据同化。

机器学习算法已经被用来产生`完全由观测到的低阶混沌系统`的替代模型，然后用于预测。机器学习也已基于真实观测值应用于临近预报。特别的，`在模型误差存在下，由DA解决的优化问题等效于 ML问题`。

在必须基于嘈杂和稀疏的观测结果提出系统状态及其动力学模型的情况下，本文提出的混合算法`依靠DA来估计系统状态，并依靠ML来模拟动力模型`。

## 问题定义

考虑对于未知过程$\mathbb{x}_k \in \mathbb{R}^m$多维观测的时间序列$\mathbb{y}^{obs}_k \in \mathbb{R}^p$：
$$
y^{obs}_k=\mathcal{H}_k(x_k)+\epsilon^{obs}_k
$$
其中$0 \leq k \leq K$是时间步的索引，$\mathcal{H}_k:\mathbb{R}^m\rightarrow\mathbb{R}^p$是观测算子（未知），假设观测误差$\epsilon^{obs}_k$服从均值为$0$和协方差矩阵为$R_k$的正态分布，观察次数$p$及其噪声水平不会随时间变化，且观测空间无关（即$R_k$是一个对角阵），并且考虑常规时间离散化，例如：$\forall k，t_{k + 1} -t_k = h$



假设$x_k$是连续过程$x$的时间离散，服从形式为的未知的常微分方程
$$
\frac{dx}{dt} = \mathcal{M}(x)
$$
目标是得到$t_k$和$t_{k + 1}$之间的$\mathcal{M}$的的替代模型$\mathcal{G}$
$$
x_{k+1}=\mathcal{G}(x_k)+\epsilon_k^m=x_k+\int_{t_k}^{t_{k+1}}\mathcal{M}(x)dt \tag{3} \label{eq3}
$$
其中$\mathbb{\epsilon}_k^m$是模型$\mathcal{G}$的误差

## 方法

### CNN

目前已有论文使用卷积神经网络来表示代理模型。

由于$\ref{eq3}$中表达式可表示为$x_{k+1}=x_k+\cdots$，故采用残差网络的方式构建模型$\mathcal{G}(x)=x_k+f_{nn}(x_k,W)$。

$Loss$函数定义为
$$
L(W)=\sum^{K-{N_f}-1}_{k=0} \sum^{N_f}_{i=1} \|\mathcal{G}_W^{(i)}-x_{k+1}\|_{P_k^{-1}}^2
$$


其中$N_f$是时间步数，$P_k$是定义范数$\|x\|_{P_k^-1}^2=x^TP_k^{-1}x$的半正定对称阵，注意：$\mathrm{P}_k$是代理模型的误差协方差矩阵。

<img src="https://cdn.jsdelivr.net/gh/wuxinwang1997/blogImages/fig2.jpg" alt="fig2" style="zoom:60%;" />

### 同化

本文使用有限大小的集合卡尔曼滤波器EnKF-N（本文方法不依赖于特定同化过程）

EnKF-N是一种序列集合同化方法，时间$t_k$时的分析矩阵$X_k^{a/f} \equiv \left[x_{k,1}^{a/f},\cdots,x_{k,p}^{a/f},\cdots,x_{k,N}^{a/f}\right] \in R^{m \times N}$其中的$a$表示分析场，成员$x_{k,p}^{a/f}=\mathcal{G}(x_{k-1,p}^a)+\epsilon_{k,p}^m$，其中$\mathrm{\epsilon}_{k,p}^a$是第$t_k$时刻成员$p$的模型误差。

分析过程中，给一个观测$\mathrm{y}^{obs}_k$和集合预测$\mathrm{X}_k^f$，使用同化算法更新为$\mathrm{X}_k^a$，对集合进行均值和协方差的求解。

### 结合同化与机器学习

<img src="https://cdn.jsdelivr.net/gh/wuxinwang1997/blogImages/fig1.jpg" alt="fig1" style="zoom:50%;" />

该过程可以看作是`期望最大化算法`，其中`DA是期望步骤`，而`ML是最大化步骤`。且ML与DA算法选取是`相互独立`的。

## 实验

组合DA-ML方法使用40变量Lorenz96产生的综合观测值进行测试。通过以下一组常微分方程，在周期一维域上定义模型L96：
$$
\frac{x_n}{dt} = (x_{n+1}-x_{n-2})x_{n-1}-x_n+F
$$
其中$x_n, 0 \leq n < m$是标量状态变量，$x_m = x_0, x_{−1} = x_{m−1}, x_{−2} = x_{m−2}, m= 40, F = 8$

使用Lyapunov时间单位$t_\Lambda=\Lambda_1t$，其中$t$是模型单位中的时间：一个Lyapunov时间单位对应于误差增长$e$倍的时间。

具体实验步骤查看论文。

## 结论与分析

实验中的观测值是来自全状态向量的子样本，意味着DA充当观测值的插值器和平滑器，从而产生了所谓的“分析”。
