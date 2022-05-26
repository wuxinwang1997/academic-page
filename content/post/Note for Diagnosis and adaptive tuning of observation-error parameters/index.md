---
title: Note for Diagnosis and adaptive tuning of observation-error parameters in a variational assimilation
subtitle: 

# Summary for listings and search engines
summary: 文章使用观测误差诊断进行自适应调整

# Link this post with a project
projects: []

# Date published
date: "2021-11-22"

# Date updated
lastmod: "2021-11-22"

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

由于观测精度低、分布系数，当前的分析方法主要基于较少的观测和短期预报的背景场。在另一个角度看，背景场可以视为另外一种观测。每个观测对分析的贡献依赖于其误差协方差，而这些误差不全是已知的，通过模式误差订正或自适应地调整误差参数可以提高分析质量。

一些文章使用后验诊断方法，使用基于观测值或背景场随机扰动的方法，证明了实际计算代价函数字部分的期望值是可行的。

另外一种思路试图从第一分析中使用的一组观测值对误差参数进行调整，提出了基于极大似然估计的方法，以及广义交叉验证方法（GCV）。

本文提出了一种基于O-B的方法进行诊断，目的是从一批观测和背景场中自适应调整观测误差参数。

## 理论方法
### VARDA
三维变分的目标函数的增量形式为

$$
\begin{aligned}
  J(\delta x) &= J^b(\delta \mathrm{x})+J^o(\delta \mathrm{x}) \\\\
              &= \frac{1}{2}\delta \mathrm{x}^T\mathrm{B}^{-1}\delta \mathrm{x} + \frac{1}{2}(\mathrm{d}-\mathrm{H}\delta x)^T\mathrm{R}^{-1}(\mathrm{d}-\mathrm{H}\delta\mathrm{x})
\end{aligned}
$$

该代价函数最小值由

$$
\delta \mathrm{x}^a = \mathrm{K}\mathrm{d} = \mathrm{K}[\mathrm{y}^o-\mathrm{H}(\mathrm{x}^b)]
$$
得到，其中增益矩阵$\mathrm{K}=\mathrm{B}\mathrm{H}^T(\mathrm{H}\mathrm{B}\mathrm{H}^T+\mathrm{R})^{-1}$

### J的统计期望

完整的观测向量$\mathrm{z}^o$可视为$p$维$\mathrm{y}^o$适当观测向量和与真实状态相同维度$n$的背景场$\mathrm{x}^b$两份量的组合。$\mathrm{z}^o=\\{(\mathrm{x}^b)^T(\mathrm{y}^o)^T\\}$，且

$$
\mathrm{x}^b = \mathrm{x}^t + \mathrm{\varepsilon}^b
$$
其中$\mathrm{\varepsilon}^b$为B矩阵中预报误差组成的向量

$$
\mathrm{y}^o = \mathrm{H}(\mathrm{x}^t) + \mathrm{\varepsilon}^o
$$
其中$\mathrm{\varepsilon}^o$为R矩阵中观测误差组成的向量

则$\mathrm{z}^o$可以写为：
$$
\mathrm{z}^o = \Gamma(\mathrm{x}^t)+\mathrm{\varepsilon}
$$
其中$\Gamma$是完整的观测算子，$\mathrm{\varepsilon}$是预报和观测误差组成的$n+p$维向量

Talagrand(1999)得到了一个和结论：如果$J_j$表示$J$的一项，其为$m_j$个元素的和，则$J_j$最小值的期望为
$$
E[J_j(\mathrm{x}^a)]=\frac{1}{2}[m_j-Tr(\Gamma^T_j\mathrm{S}_j^{-1}\Gamma_j\mathrm{P}^a)]
$$
其中$\Gamma_j$和$\mathrm{S}_j$分别是与这$m_j$个元素相关的线性观测算子和R矩阵，$\mathrm{P}^a$表示对所有观测进行分析得到的分析误差协方差矩阵的估计。

对于$J^o$，令$\Gamma_j=\mathrm{H},\mathrm{S}_j=\mathrm{R}$：
$$
\begin{aligned}
  E(J^o) &= \frac{1}{2}[p-Tr(\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H}\mathrm{P}^a)] \\\\
         &= \frac{1}{2}[p-Tr(\mathrm{H}^T\mathrm{K}^T)] \\\\
         &= \frac{1}{2}Tr(\mathrm{I}_p-\mathrm{H}\mathrm{K})
\end{aligned}
$$
其中$\mathrm{I}_p$为$p$阶单位阵，$\mathrm{K}=\mathrm{P}^a\mathrm{H}^T\mathrm{R}^{-1}$证明如下：

$$
\begin{aligned}
  \mathrm{P}^a &= E[(\mathrm{\varepsilon}^a)(\mathrm{\varepsilon})^T] \\\\
               &= E[(\varepsilon^b+\mathrm{K}(\varepsilon-\mathrm{H}\varepsilon^b))(\varepsilon^b+\mathrm{K}(\varepsilon-\mathrm{H}\varepsilon^b))^T] \\\\
               &= E\\{[(\mathrm{I}-\mathrm{K}\mathrm{H})\varepsilon^b+\mathrm{K}\varepsilon][(\mathrm{I}-\mathrm{K}\mathrm{H})\varepsilon^b+\mathrm{K}\varepsilon]^T\\} \\\\
               &\overset{\mathrm{L}=\mathrm{I}-\mathrm{KH}}{=} E[(\mathrm{L}\varepsilon^b+\mathrm{K}\varepsilon)(\mathrm{L}\varepsilon^b+\mathrm{K}\varepsilon)^T] \\\\
               &\overset{\varepsilon与\varepsilon^b无关}{=} E[\mathrm{L}\varepsilon^b(\varepsilon^b)^T\mathrm{L}^T]+E[\mathrm{K}\varepsilon\varepsilon^T\mathrm{K}^T] \\\\
               &= \mathrm{L}\mathrm{B}\mathrm{L}^T+\mathrm{K}\mathrm{R}\mathrm{K}^T \\\\
               &= (\mathrm{I}-\mathrm{K}\mathrm{H})\mathrm{B}(\mathrm{I}-\mathrm{K}\mathrm{H})^T+\mathrm{K}\mathrm{R}\mathrm{K}^T
\end{aligned}
$$
为了得到分析协方差矩阵的最优估计，最小化分析协方差矩阵的迹
$$
\begin{aligned}
  Tr(\mathrm{P}^a) &= Tr(\mathrm{B})+Tr(\mathrm{K}\mathrm{H}\mathrm{B}\mathrm{H}^T\mathrm{K}^T)-2Tr(\mathrm{B}\mathrm{H}^T\mathrm{K}^T)+Tr(\mathrm{K}\mathrm{R}\mathrm{K}^T) \\\\
\end{aligned}
$$
对此求导可得
$$
\begin{aligned}
  \frac{d[Tr(\mathrm{P}^a)]}{d\mathrm{K}} &= 2Tr(\mathrm{K}\mathrm{H}\mathrm{B}\mathrm{H}^T)-2Tr(\mathrm{B}\mathrm{H}^T)+2Tr(\mathrm{K}\mathrm{R}) \\\\
  &= 2T(\mathrm{K}\mathrm{H}\mathrm{B}\mathrm{H}^T-\mathrm{B}\mathrm{H}^T+\mathrm{K}\mathrm{R}) \\\\
  &= 2Tr[\mathrm{K}(\mathrm{H}\mathrm{B}\mathrm{H}^T+\mathrm{R})-\mathrm{B}\mathrm{H}^T]
\end{aligned}
$$
令上述导数为$0$可得
$$
\begin{aligned}
  \mathrm{K} &= \mathrm{B}\mathrm{H}^T(\mathrm{H}\mathrm{B}\mathrm{H}^T+\mathrm{R})^{-1} \\\\
  &= (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^{-1}(\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})\mathrm{B}\mathrm{H}^T(\mathrm{H}\mathrm{B}\mathrm{H}^T+\mathrm{R})^{-1} \\\\
  &= (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^{-1}(\mathrm{H}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H}\mathrm{B}\mathrm{H}^T)(\mathrm{H}\mathrm{B}\mathrm{H}^T+\mathrm{R})^{-1} \\\\
  &= (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^{-1}\mathrm{H}^T\mathrm{R}^{-1}(\mathrm{R}+\mathrm{H}\mathrm{B}\mathrm{H}^T)(\mathrm{H}\mathrm{B}\mathrm{H}^T+\mathrm{R})^{-1} \\\\
  &= (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^{-1}\mathrm{H}^T\mathrm{R}^{-1}
\end{aligned}
$$

对于三维变分：
$$
J(\mathrm{x}) = \frac{1}{2}[(\mathrm{x}-\mathrm{x}^b)^T\mathrm{B}^{-1}(\mathrm{x}-\mathrm{x}^b)]+\frac{1}{2}[(\mathrm{y}-\mathrm{H}(x))^T\mathrm{R}^{-1}(\mathrm{y}-\mathrm{H}(x))]
$$
想要$J$最小，则需要
$$
\begin{aligned}
  &\nabla J(\mathrm{x}^a) = \frac{d J}{d \mathrm{x}}|_{\mathrm{x}^a} = 0 \\\\
  \Leftrightarrow & \mathrm{B}^{-1}(\mathrm{x}^a-\mathrm{x}^b)-\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{y}-\mathrm{H}(\mathrm{x}^a)] = 0 \\\\
  \Leftrightarrow & \mathrm{B}^{-1}(\mathrm{x}^a-\mathrm{x}^b)-\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{y}-\mathrm{H}(\mathrm{x}^b)]+\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{H}(\mathrm{x}^a)-\mathrm{H}(x)^b] = 0 \\\\
  \overset{\text{根据切线性假设}}{\Leftrightarrow} & \mathrm{x}^a-\mathrm{x}^b = (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^{-1}\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{y}-\mathrm{H}(\mathrm{x}^b)]
\end{aligned}
$$
对于二阶导（Hessian矩阵）：
$$
\nabla \nabla J(\mathrm{x}) = 2(\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})
$$

那么将真实大气状态$\mathrm{x}^t$带入一阶导为$0$可得
$$
\begin{aligned}
  0 &= \mathrm{B}^{-1}(\mathrm{x}^a-\mathrm{x}^t+\mathrm{x}^t-\mathrm{x}^a)-\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{y}-\mathrm{H}(\mathrm{x}^t)+\mathrm{H}(\mathrm{x}^t)-\mathrm{x}^a] \\\\
  &= \mathrm{B}^{-1}(\mathrm{x}^a-\mathrm{x}^t)-\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H}(\mathrm{x}^t-\mathrm{x}^a)-\mathrm{B}^{-1}(\mathrm{x}^b-\mathrm{x}^t)+\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{y}-\mathrm{H}(\mathrm{x}^t)] \\\\
  \Leftrightarrow & (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})(\mathrm{x}^t-\mathrm{x}^a) = \mathrm{B}^{-1}(\mathrm{x}^b-\mathrm{x}^t)+\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{y}-\mathrm{H}(\mathrm{x}^t)]
\end{aligned}
$$

上述式子两端均乘以自己的转置可得：

$$
 \begin{aligned}
   &(\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})(\mathrm{x}^t-\mathrm{x}^a)(\mathrm{x}^t-\mathrm{x}^a)^T(\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^T \\\\
  &= \\{\mathrm{B}^{-1}(\mathrm{x}^b-\mathrm{x}^t)+\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{y}-\mathrm{H}(\mathrm{x}^t)]\\}\\{\mathrm{B}^{-1}(\mathrm{x}^b-\mathrm{x}^t)+\mathrm{H}^T\mathrm{R}^{-1}[\mathrm{y}-\mathrm{H}(\mathrm{x}^t)]\\}^T \\\\
  \Leftrightarrow
  & (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})\mathrm{P}^a(\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^T \overset{\text{背景误差与观测不相关}}{=} \mathrm{B}^{-1}\mathrm{B}\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{R}\mathrm{R}^{-1}\mathrm{H} \\\\
  \Leftrightarrow & (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})\mathrm{P}^a(\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^T = \mathrm{B}^{-1}+\mathrm{H}^T
\mathrm{R}^{-1}\mathrm{H} \\\\
  \Leftrightarrow & \mathrm{P}^a = (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^{-1}
\end{aligned} 
$$
这样得到Hessian矩阵可如下计算：
$$
\nabla\nabla J(\mathrm{x}) = \frac{1}{2}(\mathrm{P}^a)^{-1}
$$
由以上推导可知：
$$
\mathrm{K} = (\mathrm{B}^{-1}+\mathrm{H}^T\mathrm{R}^{-1}\mathrm{H})^{-1}\mathrm{H}^T\mathrm{R}^{-1} = (\mathrm{P}^a)^{-1}\mathrm{H}^T\mathrm{R}^{-1}
$$

回到论文，同样的，对于完整的背景场部分，$\Gamma_j=\mathrm{I}_n,\mathrm{S}_j=\mathrm{B}$可得
$$
\begin{aligned}
  E(\mathrm{J}^b) &= \frac{1}{2}\\{n-Tr[\mathrm{B}^{-1}(\mathrm{B}-\mathrm{K}\mathrm{H}\mathrm{B})]\\} \\\\
  &= \frac{1}{2}\\{n-Tr(\mathrm{I}_n-\mathrm{B}^{-1}\mathrm{K}\mathrm{H}\mathrm{B})\\} \\\\
  &= \frac{1}{2}Tr(\mathrm{K}\mathrm{H})
\end{aligned}
$$
其中$\mathrm{P}^a=\mathrm{B}-\mathrm{K}\mathrm{H}\mathrm{B}$证明如下：
$$
\begin{aligned}
  \mathrm{P}^a &= (\mathrm{I}-\mathrm{K}\mathrm{H})\mathrm{B}(\mathrm{I}-\mathrm{K}\mathrm{H})^T+\mathrm{K}\mathrm{R}\mathrm{K}^T \\\\
  &= (\mathrm{I}-\mathrm{K}\mathrm{H})\mathrm{B}(\mathrm{I}-\mathrm{K}\mathrm{H})^T+\mathrm{P}^a\mathrm{H}\mathrm{R}^{-1}\mathrm{R}\mathrm{K}^T \\\\
  &= (\mathrm{I}-\mathrm{K}\mathrm{H})\mathrm{B}(\mathrm{I}-\mathrm{K}\mathrm{H})^T+\mathrm{P}^a\mathrm{H}^T\mathrm{K}^T \\\\
  \Leftrightarrow & \mathrm{P}^a(\mathrm{I}-\mathrm{H}^T\mathrm{K}^T) = (\mathrm{I}-\mathrm{K}\mathrm{H})\mathrm{B}(\mathrm{I}-\mathrm{K}\mathrm{H})^T \\\\
  \Leftrightarrow & \mathrm{P}^a = (\mathrm{I}-\mathrm{K}\mathrm{H})\mathrm{B} = \mathrm{B}-\mathrm{B}\mathrm{K}\mathrm{H}
\end{aligned}
$$

则
$$
E(\mathrm{J}) = E(\mathrm{J}^o)+E(\mathrm{J}^b) = \frac{1}{2}Tr(\mathrm{I}_p)=p/2
$$

这表明，如果给定了观测误差协方差，则最小代价函数的期望值与观测数量$p$成正比，$p$也对应于分析问题中的自由度数量（这个可以进行后验诊断，如利用信息论的方法）。$E(\mathrm{J})$与$p/2$的偏差可以统计分析错误。

### $Tr(\mathrm{K}\mathrm{H})$和$Tr(\mathrm{H}\mathrm{K})$的随机估计

通过随机方法估计矩阵的迹如下：

$$
\text{Rand} \quad Tr(\mathrm{H}\mathrm{K}) = \text{Rand} \quad Tr(\mathrm{R}^{-1/2}\mathrm{H}\mathrm{K}\mathrm{R}^{1/2}) = (\mathrm{R}^{-1/2}\xi)^T\mathrm{H}\mathrm{K}\mathrm{R}^{1/2}\xi
$$

其中$\xi$是一个$p$维标准正态分布向量。

但是在实际系统中$\mathrm{K}$不是在变分过程中给显式计算的。

由文章第一个公式$\delta \mathrm{x}^a = \mathrm{K}\mathrm{d} = \mathrm{K}[\mathrm{y}^o-\mathrm{H}(\mathrm{x}^b]$可得：

$$
\mathrm{H}\delta \mathrm{x}^a_{\mathrm{y}^o+\delta \mathrm{y}^o}-\mathrm{H} \delta \mathrm{x}^a_{\mathrm{y}^o} \simeq \mathrm{H}\mathrm{K}\delta \mathrm{y}^o
$$

则令$\delta \mathrm{y}^o = \mathrm{R}^{1/2}\xi$，上述随即估计为

$$
\text{Rand} \quad Tr(\mathrm{H}\mathrm{K}) = (\mathrm{R}^{-1/2}\xi)^T(\mathrm{H}\delta \mathrm{x}^a_{(\mathrm{y}^o+\mathrm{R}^{1/2}\xi)}-\mathrm{H}\delta \mathrm{x}^a_{(\mathrm{y}^o)})
$$

该估计也可用于计算$E(\mathrm{J}^b)$，类似地由
$$
\delta \mathrm{x}^a_{\mathrm{x}^b+\delta \mathrm{x}^b}-\delta \mathrm{x}^a _{\mathrm{x}^b} \simeq -\mathrm{K}\mathrm{H}\delta \mathrm{x}^b
$$
可得
$$
\text{Rand} \quad Tr(\mathrm{K}\mathrm{H}) = -(\mathrm{B}^{-1/2}\xi)^T(\delta \mathrm{x}^a_{(\mathrm{x}^b+\mathrm{B}^{1/2}\xi)}-\delta \mathrm{x}^a_{(\mathrm{x}^b)})
$$

通过以上方法可以求得$E(\mathrm{J}^o)$和$E(\mathrm{J}^b)$

## 自适应调整

### 在线调整背景和观测误差的比例

设两个参数$s^{b^2}$与$s^{o^2}$可得
$$
\mathrm{J}(\delta \mathrm{x}) = \frac{1}{{s^b}^2}\mathrm{J}^b(\delta \mathrm{x})+\frac{1}{{s^o}^2}\mathrm{J}^o(\delta \mathrm{x})
$$

在GCV或一些极大似然估计方法中主要优化两个参数的比例$\lambda=s^{o^2}/s^{b^2}$，而若权重$s^b$和$s^o$是恰当的，则$(1/{s^b}^2)\mathrm{J}^b(\delta \mathrm{x})$和$(1/{s^o}^2)\mathrm{J}^o(\delta \mathrm{x})$需要与它们的期望相接近。即$(1/2)Tr[\mathrm{K}\mathrm{H}(s^b,s^o)]$和$(1/2)Tr[\mathrm{I}_p-\mathrm{H}\mathrm{K}(s^b,s^o)]$，其中$(s^b,s^o)$是参数，对应的结果应该是他们的一个函数

然后定义$S^b = 2\mathrm{J}^b/Tr(\mathrm{K}\mathrm{H})$和$S^o=2\mathrm{J}^o/Tr(\mathrm{I}_p-\mathrm{H}\mathrm{K})$，则该想法是寻找$s^b,s^o$使得

$$
\begin{cases}
  {s^b}^2 = S^b(s^b,s^o) \\\\
  {s^o}^2 = S^o(s^b,s^o)
\end{cases}
$$

该方法与GCV存在相似性，GCV主要最优化比率$\lambda$，定义如下：

$$
\begin{aligned}
  V(\lambda) &= \frac{(\mathrm{d}-\mathrm{H}\delta \mathrm{x}^a)^T\mathrm{R}^{-1}(\mathrm{d}-\mathrm{H}\delta \mathrm{x}^a)}{[Tr(\mathrm{I_p-\mathrm{H}\mathrm{K}})]^2} \\\\
  &= \frac{S^o(\delta \mathrm{x}^a)}{Tr(\mathrm{I}_p-\mathrm{H}\mathrm{K})}
\end{aligned}
$$

其中$S^o(\delta x^a)$表示$S^o$与$\delta x^a$有关。同样使用之前介绍的随机化方法进行计算

则可以使用如下的序列进行迭代计算不动点

$$
\begin{cases}
  s^b_{k+1} = [S^b(s^b_k,s^o_k)]^{1/2} \\\\
  s^o_{k+1} = [S^o(s^b_k,s^o_k)]^{1/2}
\end{cases}
$$

