---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Note for Analysis of Covariance with Spatially Correlated Secondary Variable"
subtitle: ""
summary: "考虑空间协相关对数据进行分析"
authors: [admin]
tags: [Academic, Data Assimilation, Observation correlation]
categories: [Note]
date: 2021-11-19T00:00:00+00:00
lastmod: 2021-11-19T14:09:29+08:00
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

观测在空间上是有相关性的，目前的协克里金方法仅统计了协变量的相关结构，而协方差的空间分析允许进行参数估计但忽略了协变量的相关结构。本文的方法将两方面进行结合。

## 理论方法

### Kriging插值

#### 反距离插值

地理属性有空间相关性，相近的事物会更相似，则对于空间上任意一点$(x,y)$，定义反距离插值公式估计量

$$
\hat{z} = \sum^n_{i=1}\frac{1}{d^\alpha}z_i
$$

其中$\alpha=1,2$

即，用空间上所有已知点的数据加权求和来估计未知点的值，权重取决于距离的倒数（或者倒数的平方）。那么，距离近的点，权重就大；距离远的点，权重就笑。

#### 克里金插值

$$
\hat{z}_0 = \sum^n_{i=1}\lambda_i z_i
$$

其中$\hat{z}_0$是点$(x_0,y_0)$处的估计值，即$z_0=z(x_0,y_0)$，$\lambda_i$是权重系数，其定义为能满足点$(x_0,y_0)$处的估计值$\hat{z}_0$与真实值$z_0$的差最小的一套最优系数，即

$$
\min_{\lambda_i} Var(\hat{z}_0-z_0)
$$

同时满足无偏估计

$$
E(\hat{z}_0-z_0)=0
$$

#### 假设条件

普通克里金插值的假设条件为：空间属性$z$是均一的，对于空间任意一点$(x,y)$都有相同的期望和方差

$$
\begin{aligned}
    E[z(x,y)] &= E[z] = c \\\\
    Var[z(x,y)] &= \sigma^2
\end{aligned}
$$

则任意一点的$z$都由该区域平均至和该点的随机偏差$R(x,y)$组成

$$
\begin{aligned}
    z(x,y) &= E[z(x,y)] + R(x,y) = c+R(x,y) \\\\
    Var[R(x,y)] &= \sigma^2
\end{aligned}
$$

#### 无偏约束条件

$$
\begin{aligned}
    E(\hat{z}_0-z_0) &= 0 \\\\
    \Rightarrow E(\sum^n_{i=1}\lambda_i z_i - z_0) &= 0 \\\\
    \Rightarrow c\sum^n_{i=1}\lambda_i-c &= 0 \\\\
    \Rightarrow \sum^n_{i=1} \lambda_1 &= 1
\end{aligned}
$$

#### 优化目标

$$
\begin{aligned}
    J &= Var(\hat{z}_0-z_0) \\\\
      &= Var(\sum^n_{i=1}\lambda_i z_i - z_0) \\\\
      &= Var(\sum^n_{i=1}\lambda_i z_i)-2Cov(\sum^n_{i=1}\lambda_i z_i, z_0) + Var(z_0) \\\\
      &= \sum^n_{i=1}\sum^n_{j=1}\lambda_i\lambda_jCov(z_i,z_j)-2\sum^n_{i=1}\lambda_iCov(z_i,z_0)+Cov(z_0,z_0)
\end{aligned}
$$

定义$C_{ij}=Cov(z_i,z_j)=Cov(R_i,R_j)$，其中$R_i=z_i-c$

则

$$
J=\sum^n_{i=1}\sum^n_{j=1}\lambda_i\lambda_jC_{ij}-2\sum^n_{i}\lambda_iC_{i0}+C_{00}
$$

#### 最优解

定义半方差函数$r_{ij}=\sigma^2-C_{ij}$，带入$J$有

$$
\begin{aligned}
    J &= \sum^n_{i=1}\sum^n_{j=1}\lambda_i\lambda_jC_{ij}-2\sum^n_{i}\lambda_iC_{i0}+C_{00} \\\\
      &= \sum^n_{i=1}\sum^n_{j=1}\lambda_i\lambda_j(\sigma^2-r_{ij})-2\sum^n_{i}\lambda_i(\sigma^2-r_{i0})+\sigma^2-r_{00} \\\\
      &= \sum^n_{i=1}\sum^n_{j=1}\lambda_i\lambda_j\sigma^2-\sum^n_{i=1}\sum^n_{j=1}\lambda_i\lambda_jr_{ij}-2\sum^n_{i}\lambda_i\sigma^2+2\sum^n_{i=1}\lambda_ir_{i0}+\sigma^2-r_{00} \\\\
\end{aligned}
$$

考虑到$\sum^n_{i=1}\lambda_i = 1$

则

$$
\begin{aligned}
    J &= \sigma^2-\sum^n_{i=1}\sum^n_{j=1}\lambda_i\lambda_j(r_{ij})-2\sigma^2+2\sum^n_{i=1}\lambda_ir_{i0}+\sigma^2-r_{00} \\\\
      &= 2\sum^n_{i=1}\lambda_ir_{i0} - \sum^n_{i=1}\sum^n_{j=1}\lambda_i\lambda_j(r_{ij})-r_{00}
\end{aligned}
$$

目标是找到使$J$最小的$\lambda_i$，且$J$是$\lambda_i$的函数，因此求偏导令为$0$即可。又因为需要满足$\sum^n_{i=1}\lambda_i=1$，这就是一个带约束的最优化问题，采用拉格朗日乘子法，构造新的目标函数

$$
J+2\phi\left(\sum^n_{i=1}\lambda_i-1\right)
$$

其中$\phi$是拉格朗日乘子，求解使得该目标函数最小的参数集$\phi,\lambda_i$

$$
\begin{aligned}
    &\begin{cases}
        \frac{\partial(J+2\phi(\sum^n_{i=1}\lambda_i-1))}{\partial\lambda_k} = 0; & k=1,2,\cdots,n \\\\
        \frac{\partial(J+2\phi(\sum^n_{i=1}\lambda_i-1))}{\partial\phi} = 0
    \end{cases} \\\\
    \Rightarrow 
    &\begin{cases}
        2r_{k0} - \sum^n_{j=1}(r_{kj}+r_{jk})\lambda_j+2\phi = 0;&k=1,2,\cdots,n\\\\
        \sum^n_{i=1}\lambda_i = 1
    \end{cases} \\\\
\end{aligned}
$$

由于$C_{ij}=Cov(z_i,z_j)=C_{ji}$，则$r_{ij}=r_{ji}$，即

$$
\begin{cases}
    r_{k0} - \sum^n_{j=1}r_{kj}\lambda_j+\phi = 0;&k=1,2,\cdots,n\\\\
    \sum^n_{i=1}\lambda_i = 1
\end{cases}
$$

则需要求解线性方程组

$$
\begin{bmatrix}
    r_{11} & r_{12} & \cdots & r_{1n} & 1 \\\\
    r_{21} & r_{22} & \cdots & r_{2n} & 1 \\\\
    \vdots & \vdots & \vdots & \ddots & \vdots \\\\
    r_{n1} & r_{n2} & \cdots & r_{nn} & 1 \\\\
    1 & 1 & \cdots & 1 & 0
\end{bmatrix}
\begin{bmatrix}
    \lambda_1 \\\\
    \lambda_2 \\\\
    \vdots \\\\
    \lambda_n \\\\
    -\phi
\end{bmatrix} = 
\begin{bmatrix}
    r_{10}\\\\
    r_{20} \\\\
    \vdots \\\\
    r_{n0} \\\\
    1
\end{bmatrix}
$$

对矩阵求逆即可，未知内容包括开始定义的半方差函数$r_{ij}$

#### 半方差函数

$$
r_{ij} = \sigma^2-C_{ij}
$$

其等价形式为

$$
r_{ij}=\frac{1}{2}E[(z_i-z_j)^2]
$$

这也是半方差函数名称的由来。而由地理学第一定律，空间上相近的属性相近，空间的相似度由距离来表达，通过对空间距离$d_{ij}=\sqrt{(x_i-x_j)^2+(y_i-y_j)^2}$与观测的半方差$\sigma^2-C_{ij}$进行计算，再通过曲线进行最优拟合，得到函数

$$
r=r(d)
$$

之后就可以直接将两点的距离带入函数计算半方差

#### 克里金插值总结

1. 对于观测数据，两两计算距离与半方差
2. 寻找一个拟合曲线拟合距离与半方差的关系，从而能根据任意距离计算出相应的半方差
3. 计算出所有已知点之间的半方差$r_ij$
4. 对于未知点$z_0$，计算它到所有已知点$z_i$的半方差$r_{i0}$
5. 求解方程组，得到最优系数$λ_i$
6. 使用最优系数对已知点的属性值进行加权求和，得到未知点$z_0$的估计值

参考自[克里金(Kriging)插值的原理与公式推导](https://xg1990.com/blog/archives/222)

### 本文方法

对于并置的数据，其模型可表示为

$$
\begin{align}
y &= X\tau+\beta u + e_y \\\\
u &= \mathrm{1}\mu + e_u
\end{align}
$$

其中$y$是一个$n \times 1$的观测向量，$u$是一个$n \times 1$的协变量观测向量，设站点为$S_{yu}$，$X$是一个$n \times p$的处理效应矩阵，$\tau$是一个$p \times 1$的处理效应向量，$\beta$是协变量的回归系数，$\mathrm{1}$是$n \times 1$的全$1$向量，$\mu$表示大量协变量的均值。且假设

$$
\begin{align}
e_y \sim N(0,\sigma^2_yR) && and && e_u \sim N(0,\sigma_u^2R)
\end{align} 
$$

其中$R$表示一个空间相关结构矩阵。（是否可以用来构造观测误差协方差矩阵？或者具有某种结构的$R$就是观测误差协方差矩阵？）

则

$$
\begin{align}
E(y) &= E(X\tau + \beta u + e_y) = X\tau+\beta E(u)=X\tau+\beta\mathrm{1}\mu \\\\
E(u) &= E(\mathrm{1}\mu+e_u) = E(\mathrm{1}\mu) = \mathrm{1}\mu
\end{align}
$$

由于$\beta u$可与包含$y$和$u$的任何相关性，则可以假设$Cov(e_y,e_u)=0$。

则

$$
\begin{align}
Var(y) &= Var(X\tau+\beta u + e_y) \\\\
       &= Var(X\tau) + Var(\beta u) + Var(e_y) \\\\
       &= \beta^2 Var(u)+Var(e_y) \\\\
       &= \beta^2 Var(e_u)+Var(e_y) \\\\
Var(u) &= Var(\mathrm{1}\mu + e_u) \\\\
       &= Var(e_u) \\\\
Cov(y, u) &= Cov(X\tau+\beta u+e_y, \mathrm{1}\mu+e_u) \\\\
          &= Cov(X\tau+\beta(\mathrm{1}\mu+e_u)+e_y, \mathrm{1}\mu+e_u) \\\\
          &= Cov(\beta(\mathrm{1}\mu+e_u)+e_y,\mathrm{1}\mu+e_u) \\\\
          &= Cov(\beta e_u+e_y, e_u) \\\\
          &= Cov(\beta e_u, e_u)+Cov(e_y,e_u) \\\\
          &= \beta Var(e_u)
\end{align}
$$

则，模型假设可写作

$$
\begin{bmatrix}
y \\\\
u
\end{bmatrix}
\sim
N
\begin{pmatrix}
\begin{bmatrix}
X\tau+\beta\mathrm{1}\mu \\\\
\mathrm{1}\mu
\end{bmatrix},
\begin{bmatrix}
\Sigma_{yy} & \Sigma_{yu} \\\\
\Sigma_{uy} & \Sigma_{uu}
\end{bmatrix}
\end{pmatrix}
$$

其中，根据上面对$Var$和$Cov$的推导可知：

$$
\begin{align}
\Sigma_{yy} &= \beta^2 \Sigma_{uu}+\Sigma_{yy}=(\beta^2 \sigma_u^2 +\sigma_y^2)R \\\\
\Sigma_{uu} &= Var(e-U) = \sigma_u^2R \\\\
\Sigma_{yu} &= \beta \Sigma_{uu} = \beta\sigma_u^2R
\end{align}
$$

即

$$
\begin{bmatrix}
y \\\\
u
\end{bmatrix}
\sim
N
\begin{pmatrix}
\begin{bmatrix}
X\tau+\beta\mathrm{1}\mu \\\\
\mathrm{1}\mu
\end{bmatrix},
\begin{bmatrix}
(\beta^2 \sigma_u^2 +\sigma_y^2)R & \beta\sigma_u^2R \\\\
\beta\sigma_u^2R & \sigma_u^2R
\end{bmatrix}
\end{pmatrix}
$$

对于单变量的情况，响应变量的方差定义为

$$
\mathcal{K}_y^2 = Var(y_i) = \beta\sigma^2_u+\sigma^2_y
$$

且协变量的方差定义为

$$
\mathcal{K}_u^2 = Var(u_i) = \sigma^2_u
$$

同样的

$$
\mathcal{K}_{yu} = Cov(y_i, u_i) = \beta \sigma^2_u
$$

设$\rho$表示协变量和响应变量之间的相关性，$\rho$和$\beta$的关系可表示如下

$$
\begin{aligned}
\mathcal{K}\_{yu} &= \beta \sigma_u^2 \Rightarrow \beta = \frac{\mathcal{K}\_{yu}}{\sigma^2_u} = \frac{\mathcal{K}\_{yu}}{\mathcal{K}^2_u} \\\\
\rho &= \frac{Cov(y_i,u_i)}{\sqrt{Var(y_i)Var(u_i)}} = \frac{\mathcal{K}\_{yu}}{\mathcal{K}_y\mathcal{K}_u} \Rightarrow \mathcal{K}\_{yu} = \rho\mathcal{K}_y\mathcal{K}_u
\end{aligned}
$$

则

$$
\begin{aligned}
    \beta &= \frac{\rho \mathcal{K}_y \mathcal{K}_u }{ \mathcal{K}_u^2 } \\\\
    \hat{\beta} &= \frac{\hat{\rho}\hat{\mathcal{K}_y}}{\hat{\mathcal{K}_u}}
\end{aligned}
$$

其中$\mathcal{K}_y$也是反应变量基台值(sill)的平方根，$\mathcal{K}_u$是协变量基台值(sill)的平方根。（基台值用以衡量区域化变量变化幅度的大小。当滞后距无限增大并到达某一程度后，试验变异函数若趋于平稳，则这一平稳水平所对应的数值即为基台值。然而，并不是所有的区域化变量均具有基台值——如无基台值模型对应的变异函数。）

该模型可以拓展到非同位数据，令$y$是在$S_{yu} \bigcup S_y$中的观测$y(s_i)$的向量，$u$为在$S_{yu} \bigcup S_y$中的观测$u(s_j)$的向量。令$y'$表示$S_u$上缺失的观测$y$的向量，$u'$为在$S_y$上缺失的观测$u$的向量。则模型中的反应和协观测可以被替换为$y_{aug} = (y,y'),u_{aug}=(u,u')$，再将其排列到$\begin{bmatrix}y \\ u\end{bmatrix}$带入式子即可。

则可以同过将$\hat{\beta}$求解出来，由$u$的分布推导出$y$的分布。