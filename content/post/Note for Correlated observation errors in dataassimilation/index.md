---
title: Note for Correlated observation errors in dataassimilation
subtitle: 

# Summary for listings and search engines
summary: 对观测的相关性假设与信息的损失联合进行分析

# Link this post with a project
projects: []

# Date published
date: "2021-11-19"

# Date updated
lastmod: "2021-11-19"

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

## 问题背景

同化过程中观测的权重与其误差值成反比，遥感仪器误差通常认为是不相关的。而观测的相关性提高了在分析场中观测域梯度的精度，但对于观测域本身的精度没有太大影响。

由于观测可以达到$10^6$，则对观测误差相关性的存储和计算成本很高。故在实施上假设观测不相关。为了弥补相关性的不足，一般将观测误差进行膨胀，使得观测在分析中有较低的权重。（最多可放大2~4倍）。

通常使用稀疏化技术以降低数据密度满足观测无相关的假设，而目前对流风暴的预报使用高分辨率的模式，这要求尽可能很多的数据进行同化，而不是是用稀疏化技术，这就需要一种处理观测误差相关性的方法。

## 理论方法

### 信息论

一组观测的信息量由他们降低分析的不确定性的多少衡量，文章使用Shannon Information Content和信号自由度进行评估。

#### Shannon Information Content

SIC是熵减少的一种度量。（物理上熵用于描述状态的概率密度函数所占据的状态空间的体积）。假设所有数据都服从高斯分布

$$
\begin{aligned}
    SIC &= \frac{1}{2}|S_A^{-1}B| \\\\
    S_A^{-1} &= \mathrm{H}^T\mathrm{R}^{-1}\mathrm{H}+\mathrm{B}^{-1}
\end{aligned}
$$

其中$S_A$是分析的误差协方差矩阵，SIC越大，对分析不确定性的减少越多。

#### 信号自由度

信号自由度表示观测值测量的数量，信号自由度与总自由度越接近，观测提供的信息就越多

通过比较$B$矩阵和$S_A$特征值的大小可以知道不确定性的减少。

定义一个非奇异矩阵$L$，使得$LBL^T=I$且$LS_AL^T=\hat{S}_A$（该变换不是唯一的），可以将$L$替换为$X^TL$，其中$X$是一个正交阵。若取$X$为$\hat{S}_A$的特征向量矩阵，同时将$B$还原为单位阵，$S_A$还原为对角阵$\Lambda$，则

$$
\begin{aligned}
    X^TLBL^TX &= X^XX = I \\\\
    X^TLS_AL^TX &= X^T\hat{S}_AX = \Lambda
\end{aligned}
$$

经过该变换后，变换矩阵的对角元素都是相同的，每个元素对应一个单独的信号自由度。$\hat{S}_A$的特征值可以解释为每个独立方向上方差的相对减少，因此信号自由度为

$$
dofs = N - trace(\Lambda)
$$

注：信号自由度表示观测测量的数量，则应该是以$1$为单位，故通过将$B$矩阵转化为单位阵，其迹即为$B$中状态的数量，对$S_A$进行相同的变换对角化之后，也就将特征值进行了对应的缩放，对该对角阵求迹也就将$S_A$的信息量求出来了。

### 理想数据集

考虑200km的$N \times N$网格平面观测，假设每个观测都是直接获取的，$H=I$，背景误差是均匀的且由相关函数$B_{ij}=e^{-r_{ij}^2/2L}$描述，其中$r_{ij}$是两点之间的距离，$L=190$

测试误差矩阵$R_t$使用经验推导的误差方差和各向同性相关性得到，相关性表示为$C_{ij}=(1+\frac{r_{ij}}{L})e^{-r_{ij}/L}$。则$R_t=D^{1/2}CD^{1/2}$，其中$D$为观测方差的对角阵。

### 观测误差协方差矩阵结构

文章比较了以下四种结构

1. 使用测试误差协方差矩阵
2. 将$R_t$中的相关性设为0（C为对角阵）
3. 将$R_t$中的相关性设为0并膨胀观测方差（C为对角阵且误差进行了放大）
4. $$
\tilde{R}=D^{1/2}(\alpha I+\sum^K_{k=1}(\lambda_k-\alpha)v_kv_k^T)D^{1/2}=D^{1/2}\tilde{C}D^{1/2}
$$
其中$(\lambda_k,v_k)$是$C$的特征值、特征向量对，$K$是主要特征对的数量，$\alpha$取为$trace(\tilde{R})=trace(D)$，则不会出现总误差方差的近似缺失。

结果是第四种方法与测试矩阵最相似，使用的特征对越多，信息差异越小。