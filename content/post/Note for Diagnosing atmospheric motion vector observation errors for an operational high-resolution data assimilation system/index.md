---
title: Note for Diagnosing atmospheric motion vector observation errors for an operational high-resolution data assimilation system
subtitle: 

# Summary for listings and search engines
summary: 文章使用Descroziers diagnostic方法得到观测误差相关性并做进一步分析

# Link this post with a project
projects: []

# Date published
date: "2021-11-21"

# Date updated
lastmod: "2021-11-21"

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

目前，风速观测时从中等大小的特征中得出的，没有快速突变和专门的水平位移，这意味着AMV只能描述一般的大气波动。

## 理论方法

### Desrozierst诊断方法

文章使用Desrozier诊断，利用$(O-B)(O-A)$对局部区域高分辨率同化系统的AMV误差统计进行估计。

$$
\mathrm{d}_b^o = \mathrm{y}-\mathrm{H}\mathrm{x}^b
$$

$$
\mathrm{d}_a^o = \mathrm{y}-\mathrm{H}\mathrm{x}^a
$$

则

$$
\langle \mathrm{d}_a^o,\mathrm{d}_b^o\rangle \approx \mathrm{R}_e
$$

### 诊断方法的实现

假设由N对观测在距离$d$和垂向$z$层上属于同一个间隔距离仓内，设第$k$个观测对为$(i_k,j_k)$，则其协方差表达式为：

$$
\begin{aligned}
   cov(z,d) &= \frac{1}{N}\sum^N_{k=1}(\mathrm{d}_a^0)_{i_k}(\mathrm{d}_b^o)_{j_k}-\left[\frac{1}{N}\sum^N_{k=1}(\mathrm{d}_a^o)_{i_k}\right]\left[\frac{1}{N}\sum^N_{k=1}(\mathrm{d}_b^o)_{j_k}\right]
\end{aligned}
$$

误差方差$var(z)$使用类似的形式计算，但假设$d=0,j_k=i_k$。给定垂直层$z$，其水平相关函数时通过$z$水平面的总体观测误差方差对每个间隔距离仓内的观测误差协方差进行归一化得到的。

$$
\rho(z,d)=\frac{cov(z,d)}{var(z)}
$$

## 误差来源

1. 跟踪误差：跟踪了错误的特征
2. 高度分配误差：模型亮温倒数和亮温到气压的转换错误会导致特征高度的误差
3. 中尺度特征：
4. 风切变：风切变时风速垂直方向上变化率。
5. 极地锋急流：是一个中纬度的高风速径向曲流核心（$> 30m/s$），主要在$250-300hPa$。
6. 温度反演：

## 实验

文章使用Met Office UKV模式进行3DVAR实验
文章对于观测误差的定义如下

$$
\sigma^2_{assigned} = \sigma^2_{tracking}+\sigma^2_{height}
$$

对于间隔仓定义如下：与某个观测相聚80km到100km内的被放到同一个间隔仓内。

## 结果

论文第一次使用Desrozierset诊断来估计AMV误差方差垂直和水平相关性。通过实验得到的结论有：

1. 高度分配误差与高风切变结合对风速误差产生重大的影响
2. 最大误差方差出现在中层，其中的风切变较大，跟踪特征更容易收到上下层的影响
3. 文章估算了四个通道在不同垂直层的水平AMV误差相关性，对于IR108、WV062、WV073三个通道水平误差相关长度标度在（140-210km）范围内

在高分辨率同化中，需要考虑相关性以便得到准确的R矩阵。