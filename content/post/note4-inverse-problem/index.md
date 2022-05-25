---
title: 反问题课程笔记
subtitle: 

# Summary for listings and search engines
summary: 反问题课程笔记

# Link this post with a project
projects: []

# Date published
date: "2022-03-14"

# Date updated
lastmod: "2022-05-25"

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

##### 正问题与反问题的关系

一对问题称为是互逆的，如果一个问题的表述或处理需要另一个问题解的信息；若把其中的一个问题称为正问题，另一个就称为反问题。

第一类：由输出求输入

第二类：借助解的某些泛函，去识别具有已知结构的算子函数（给定代价函数求某些参数）

以**定解问题**=微分方程+定解条件为背景问题

- 通常把研究的较多的，适定性成立的一个问题称为正问题。

- 反问题通常是由定解问题解的部分信息去确定丁姐问题中的未知成分。

- 反问题通常是不适定的

反问题的分类：

1. L结构已知，但其中含有未知的稀疏，要确定未知系数——称为算子识别问题或参数识别问题

2. 确定源项——寻源反问题

3. 确定初始条件——也称为逆时间过程的反问题

4. 确定边界条件

5. 确定边界区域

设$A$是从函数空间$X$到函数空间$Y$的一个映射：

$$
A: X \rightarrow Y
$$

数学上$A$常称为算子，也即数学模型。

不适定性：

适定的：

1. 解的存在性

2. 解的唯一性

3. 解的连续依赖性

以上三个条件有一个不满足，称反问题$Ax=y$是不适定的

反问题通常是不适定的

##### 反问题的求解特点

- 反演问题的求解与正问题密切相关
  
  - 若正问题遇到困难没有解决，反演问题无法解决
  
  - 在许多反演求解中（特别四非线性反演求解中）需要进行正演计算。欲求解反演问题，首先必须假设相应的正演问题已经获得解决
  
  $\color{red}{反问题的求解比正问题困难，且与正问题相关}$

- 反演问题的求解归结为最有估计问题，计算量很大
  
  $Ax=y, x \in X, y \in Y$
  
  $A$是算子，$x$代表了初值、边界、物理参数等
  
  把反问题转化为正问题：在$x$的变化范围内，寻找$x$使得它对应的$y$等于$y^{obs}$，那么这样的$x$就是要求最优解
  
  由于$A$可能不是满射，即$R(A) \neq Y$，因此，对$y \in Y$，反问题很可能无解
  
  另一方面，$y^{obs}$一般存在误差（未知），因此，求出$Ax=y^{obs}$精确解$x^a$不可能
  
  于是，寻求近似解，即把使得$\|Ax-y^{obs}\|$最小的$x^a$作为$Ax=y^{obs}$的近似解（最优化问题）

- 反问题的不适定性带来的求解困难
  
  1. 解不存在。解决办法：求近似解
  
  2. 解不唯一。解决办法：增加约束条件
  
  3. 解不稳定，导致$\color{red}{通常的数值方法失效}$
     
     解决办法：增加约束条件，构造稳定近似解

##### 反问题的求解方法

###### 分类1：

- 确定性方法
  
  - 最小二乘
    
    $$
    Ax=b \quad A=(a_{ij})_{m \times n} \quad x=[x_1,\cdots,x_n]^T \quad b=[b_1,\cdots,b_m^T]
    $$
    
    考虑$m > n$，超定，往往无解
    
    $J(x)=|Ax-b|^2=\min ! \Rightarrow \frac{\partial{J}}{\partial{x}}(\nabla_xJ)=0 \Rightarrow A'Ax=A'b$
    
    解一定存在，但条件数$Cond(A)=\|A\|\|A^{-1}\|$很大，则解是不适定的
    
    最小二乘求解的结果未必是稳定的
    
    考虑$m<n$，欠定，解不唯一
    
    采用Lagrange乘子法，增加约束条件，$\|x\|^2=\min ! \quad s.t \quad Ax=b$
    
    $$
    J(x) = \|x\|^2 - \lambda'(Ax-b)
    $$
    
    $\lambda = \begin{matrix}\lambda_1\\ \vdots \\\lambda_m\end{matrix}$
    
    是Lagrange乘子向量
    
    若$Ax=b$不精确，考虑$\|Ax-b\|^2 \min !$，增加惩罚项做正则化
    
    $$
    \tilde{J}(x)=\|Ax-b\|^2+\alpha \|Lx\|^2
    $$
    
    $L$——算子， $\alpha > 0$参数
  
  - 伴随方法
    
    $$
    \begin{aligned}
\frac{\mathrm{d}X}{\mathrm{d}t} &= F(X), \Omega \\
X(0) &= X_0 \\
X|_P &= X_B \\
Z &= K(X(t))+\varepsilon \quad \text{观测方程}
\end{aligned}
    $$
    
    在$[0,T]$，$Z$有观测值，$Z^{obs}$，确定$X_0$（初始场）
    
    假设模型精确，问题归结为最优化问题
    
    $$
    J(X_0) = \frac{1}{2}\int_0^T \|K(X(t))-Z^{obs}\|^2 \mathrm{d}t = \min !
    $$
    
    求解方法：伴随方法$\Rightarrow$伴随方程$\Rightarrow$ $\nabla_{X_0}J$（梯度）
    
    伴随方程：线性化得到，或采用Lagrange乘子法得到

- 随机性方法
  
  即统计方法（不确定性方法）。随机方法既可以处理线性问题也可以处理非线性反问题。在问题是定时，随机方法和确定性方法得到的结果应该是一致的；在问题不适定时，随即方法应该优于确定性方法
  
  - Bayes方法
    
    在随机方法中解反问题的思路：所有的变量都视为随机变量，解反问题就归结为求条件概率$P(x|y)$
    
    $$
    P(x|y^{\delta})=\frac{P(y^{\delta}|x)P(x)}{P(y^\delta)}
    $$
  
  - Kalman
    
    一个演化方程和观测方程
    
    如果$T > N-1$，如$T=N$，则称为Kalman预测（外推）
    
    如果$T=N-1$，称为$Kalman$现报（滤波，估计）
    
    如果$0 \leq T \leq N-1$，称为Kalman回报（平滑或内插）
    
    对于非线性模型，且误差不服从正态分布
    
    例子滤波方法
  
  - 模拟退火和遗传算法
  
  - 人工神经网络方法
  
  - 深度学习

###### 分类2

- 线性反问题

- 非线性反问题
  
  - 线性化+迭代方法
  
  - 非线性最小二乘法

###### 分类3

- 数值优化方法
  
  反问题都可以归结为最优化问题
  
  Krylov子空间方法

- 解析方法

###### 关于正则化参数的选取

- 先验给定：与数据误差水平$\delta$的一元函数

- 后验选取：数据$y^{obs}$和数据误差水平$\delta$的函数

Morozov偏差原则

交叉检验和广义交叉检验

$C_L$方法

$L$曲线方法

##### 第4讲 最小二乘法解线性反问题

$Ax=b, A=(a_{ij})_{m \times n}$为实矩阵，$x = [x_1,\cdots,x_n]^T, b=[b_1,\cdots,b_m]^T$

- Case 1 $m > n$，超定，overdetermined
  
  可能误解，求近似解 $\|Ax-b\|^2=\min ! = (Ax-b)^T(Ax-b)$
  
  利用变分方法：$A^TAx=A^Tb$总有解，$(A^TA)^{-1}$存在，$\hat{x}=(A^TA)^{_1}b$，误差的估计：$\varepsilon = b-A\hat{x}$，解不稳定

- Case 2 $m=n$一样处理

- Case 3 $m < n$，欠定，underdetermined，解不唯一，有无穷解
  
  加约束条件，一般处理方法：在无穷多解中选择使得
  
  $\|x\|^2=\min$的解（极小模解）
  
  归结为$\|x\|^2=\min! \quad s.t \quad Ax=b$
  
  $Lagrange$乘子法，$J=x^Tx-\lambda^T(Ax-b)=\min !$
  
  $\Rightarrow \hat{x}=A^T(AA^T)^{-1}b,\hat{\lambda}=(AA^T)^{-1}b,\hat{\varepsilon}=0$
  
  $\hat{x}$的不确定性：$P=\left<(\hat{x}-x)(\hat{x}-x)^T\right>=A^T(AA^T)^{-1}\left<\varepsilon\varepsilon^T\right>(AA^T)^{-1}A$

##### 第5讲 用SVD分解解线性反问题

$A=(a_{ij})_{m \times n}$为实矩阵，$A: R^n \rightarrow R^m$，秩$R(A)=l(>0)$，则一定存在$l$个正数$\sigma_0 \geq \sigma_1 \geq \cdots \geq \sigma_l \geq 0$，同时存在两组标准正交向量：$v_1,v_2,\cdots,v_n，u_1,u_2,\cdots,u_m$满足

$$
\begin{aligned}
Av_i &= \sigma_iu_i, &i=1,\cdots,l \\
A^Tu_i &= \sigma_iv_i, &i=1,\cdots,l \\
Av_i&=0 & i=l+1,\cdots,n \\
A^Tu_i&=0 & i=l+1,\cdots,m \\
\end{aligned}
$$

则

$$
A=\sum^l_{i=1}\sigma_iu_iv_i^T=(u_1 \cdots u_n)\begin{bmatrix}\sigma_1 & \cdots & 0 \\
0 & \ddots & 0\\ 
0 & \cdots & \sigma_l\end{bmatrix}(v_1^T \cdots v_m^T)^T
$$

物理意义：协方差矩阵将两个场联系起来，确定耦合模态

###### 正则化思想的引入

一般来说，$Ax=b$都是欠定的，解不唯一，为了使解位移，引入一个所谓的第二函数（半范数），$\Omega(x)$，使$\Omega(x) = \min!$的解唯一

令$F=\{x\big|\|Ax-b\|^2 \leq C_0^2\}$，$C_0$称为误差水平（应该叫做精度，precision），$F$称为$Ax=b$的可行解集，通过令$\Omega(x)=\min!$得到唯一解。

如何确定$\Omega(x)$？如令$\Omega(x) = \|x\|^2=\min!$即可得到最小模解

若$x$有先验的值（背景场）$x^b$，可令$\Omega(x)=\|x-x^b\|^2=\min!$

若$x$的变化比较平滑，可令$\Omega(x)=\|L(x-x^b)\|^2=\min!$

$L-$算子（求导算子）

$L_0=I$（单位阵）

$L_1=\frac{1}{\Delta x}\begin{bmatrix}-1&1&0&0&0\\0&-1&1&0&0\\0&0&\ddots&\ddots\end{bmatrix}$

$L_2$（二阶导数）

也可以把各阶导数组合在一起

问题归结为$\Omega(x)=\min! \quad \|Ax-b\|^2=C_0$

令$J(x)=\Omega(x)+\lambda\|Ax-b\|^2=\min!$

考虑$\Omega(x)=\|L_k(x-x^b)\|^2$，$J(x)=\|L_k(x-x^b)\|^2+\lambda\|Ax-b\|^2=\min!$

两边除以$\lambda$，$J'(x)=\frac{1}{\lambda}\|L_k(x-x^b)\|^2+\|Ax-b\|^2$

考虑$L_k=I$，$\hat{x}=(\lambda I+A^TA)^{-1}(\lambda x^b+ATd)$

$A^TA=\left(\sum^l_{i=1}\sigma_iv_iu_i^T\right)\left(\sum^l_{i=1}\sigma_iu_iv_i^T\right)=\sum^l_{i=1}\sigma^2_iv_iv_i^T$

$I_{n \times n}=\sum^n_{i=1}v_iv_i^T$

$$
\begin{aligned}
\lambda I+A^TA &= \lambda\sum^n_{i=1}v_iv_i^T+\sum^l_{i=1}\sigma^2_iv_iv_i^T \\
&= \sum^n_{i=1}(\lambda+\sigma^2_i)v_iv_i^T
\end{aligned}
$$

$$
(\lambda I+A^TA)^{-1} = \sum^n_{i=1}(\lambda + \sigma_i^2)^{-1}v_iv_i^T
$$

$$
\lambda x^b+A^Td = \lambda\sum^n_{i=1}(v_i^Tx^b)v_i+\sum^l_{i=1}\sigma_iv_i(u_i^Td)
$$

$$
\hat{x} = \sum^l_{i=1}[\frac{\lambda}{\lambda+\sigma_i^2}x_i^b+\frac{\sigma_i^2}{\lambda+\sigma_i^2}(\frac{d_i}{\sigma_i})]v_i+\sum^n_{i=l+1}x_i^bv_i
$$

其中$x_i^b=(v_i^Tx^b),d_i=(u_i^Td)$

此方法被称为Tikhonovz正则化

还有一种叫做截断奇异值分解TSVD，抛弃小的奇异值，保留大的奇异值，$A=\sum^l_{i=1}\sigma_iu_iv_i^T$

问题：对于给定的系统，已知观测数据$Z$（$m$维随机向量），利用$Z$对参数$x$（$n$维随机向量）做出最优估计

方法1：Bayes公式：

$$
P_{X|Z}(x|z) = \frac{p(x,z)}{P_Z(z)}=\frac{p(x|z)p(x)}{p(z)}
$$

方法2：构造$Z$的函数$\hat{x}=g(z)$，估计$x$

结果：

$$
\begin{aligned}
Z &= kx+\varepsilon \\
x &= [x_1,\cdots,x_n]^T
\end{aligned}
$$

##### 第9讲 Kalman滤波类的估计

###### 一 问题的提出：

两个方程

$$
\begin{aligned}
\mathbf{x} &= \mathbf{M}_{t:t-1}(\mathbf{x}_{t-1})+\xi_t & \xi_t\text{-随机噪声或状态变量中没有表示的部分} \\
\mathbf{y}_t &= F_t(\mathbf{x}_t)+\varepsilon_t & \varepsilon_t\text{-观测误差} \\
\mathbf{x_t}&\text{为}t\text{时刻状态参量}，&\mathbf{M}_{t:t-1}-\text{演化算子Propagator}，F_t是观测算子 \\
\xi_t,\varepsilon_t&统计特性已知
\end{aligned}
$$

已知前两个方程从时刻$t_0$开始观测，得到观测数据$Z(t)(t \geq t_0)$

现在知道$t_0$到$t$时刻的观测值$Z(\sigma)$，找出$t_1$时刻$\mathbf{x}$的最优估计。$\hat{x}(t_1|t)$

###### 二 （线性）Kalman滤波

线性系统

$$
\begin{aligned}
\mathbf{x}_t &= \mathbf{M}_{t:t-1}\mathbf{x}_{t-1}+\xi_t \\
\mathbf{y}_t &= \mathbf{K_t}\mathbf{x}_t+\varepsilon_t 
\end{aligned}
$$

设$t-1$时刻，$\mathbf{x}_{t-1}$有估计值$\hat{\mathbf{x}}_{t-1}$，误差协方差矩阵$\hat{S}_{t-1}$，$t$时刻观测$\mathbf{y}_t$已知，则$t$时刻的状态$\mathbf{x}_t$按下面的步骤计算

step1 按照预报方程得到$t$时刻背景场（先验值）$\mathbf{x}^b_t$和协方差矩阵$B^b_t$

$$
\begin{aligned}
\mathbf{x}^b_t &= \mathbf{M}_{t:t-1}\hat{\mathbf{x}}_{t-1} \\
\mathbf{B}_t &= \mathbb{E}[(\hat{\mathbf{x}}_t-\mathbf{x}^b_t)^T(\hat{\mathbf{x}}_t-\mathbf{x}^b_t)]
=\mathbf{M}_{t:t-1}\mathbf{B}^b_{t-1}\mathbf{M}_{t:t-1}^T
\end{aligned}
$$

step2 按照观测方程做出$t$时刻$\mathbf{x}_t$的最优估计$\hat{\mathbf{x}}_t$

$$
\begin{aligned}
\hat{\mathbf{x}_t} &= \mathbf{x}^b_t+\mathbf{G}_t(\mathbf{y}_t-\mathbf{K_t\mathbf{x}_t^b})\\
\mathbf{S}_{\hat{\mathbf{x}}} &= (I-\mathbf{G}_t\mathbf{K_t})\mathbf{B}^b_t \\
\mathbf{G}_t &= \mathbf{B}^b_t\mathbf{K}'_t(\mathbf{K}_t \mathbf{B}_t^b \mathbf{K}‘_t + \mathbf{R})^{-1}
\end{aligned}
$$

###### 三 Extended Kalman Filter

考虑非线性系统，

$$
\begin{aligned}
\mathbf{x}_t &= \mathcal{M}_{t:t-1}(\mathbf{x}_{t-1})+\xi_t \\
\mathbf{y}_t &= F_t(\mathbf{x}_t)+\varepsilon_t
\end{aligned}
$$

已知$t-1$时刻$\mathbf{x}_{t-1}$的估计值为$\hat{\mathbf{x}}_{t-1}$，协防差矩阵$\hat{\mathbf{S}}_{t-1}$，$t$时刻观测$\mathbf{y}_t$已知，则$t$时刻$\mathbf{x}_t$的估计值可按下面的步骤计算、

step1 $t$时刻的先验估计$\mathbf{x}^b_t=\mathcal{M}_{t:t-1}(\hat{\mathbf{x}}_{t-1})$

下面对方程（模式）线性化

$$
\begin{aligned}
\mathbf{x}_t &= \mathcal{M}_{t:t-1}(\mathbf{x}_{t-1})+\xi_t \\
&= \mathcal{M}_{t:t-1}(\hat{\mathbf{x}}_{t-1}+\mathbf{x}_{t-1}-\hat{\mathbf{x}_{t-1}}) \\
&\approx \mathcal{M}_{t:t-1}+\frac{\partial{\mathbf{M}}}{\partial{\mathbf{x}}}\big|_{\hat{\mathbf{x}_{t-1}}}(\mathbf{x}_t-\hat{\mathbf{x}}_{t-1})+\xi_t
\end{aligned}
$$

$$
\begin{aligned}
\mathbf{x}_t-\mathbf{x}^b_t &= \frac{\partial{M}}{\partial{x}}|_{\hat{\mathbf{x}}_{t-1}}(\mathbf{x}_{t-1}-\hat{\mathbf{x}}_{t-1}) \\
&=\mathbf{M}_{1t}(\mathbf{x}_{t-1}-\hat{\mathbf{x}}_{t-1})+\xi_t
\end{aligned}
$$

对应的协方差矩阵

$$
\begin{aligned}
\mathbf{S}^b_t &= \mathbb{E}[(\mathbf{x}_t-\mathbf{x}^b_t)(\mathbf{x}_t-\hat{\mathbf{x}}_{t})^T] \\
&= \mathbf{M}_{1t}\hat{\mathbf{S}}_{t-1}\mathbf{M}_{1t}^T+\mathbf{S}_{\xi t}
\end{aligned}
$$

step2 观测方程线性化（在$\mathbf{x}_t^b$附近）

$$
\begin{aligned}
\mathbf{y}_t &= F_t(\mathbf{x}_t)+\varepsilon_t \\
&= F_t(\mathbf{x}_t^b+\mathbf{x}_t-\mathbf{x^b_t})+\varepsilon_t \\
&\approx F_t(\mathbf{x}^b_t)+\frac{\partial{F}_t}{\partial{x}}|_{\mathbf{x}^b_t}(\mathbf{x}_t-\mathbf{x}_t^b)+\varepsilon_t \\
\mathbf{y_t}-F_t(\mathbf{x}^b_t) &= \mathbf{K}_{1t}(\mathbf{x}_t-\mathbf{x}_t^b)+\varepsilon_t
\end{aligned}
$$

$$
\begin{aligned}
\hat{\mathbf{x}}_t &= \mathbf{x}^b_t+\mathbf{G}_t[\mathbf{y}_t-F_t(\mathbf{x_t^b})] \\
\hat{\mathbf{S}}_t &= (\mathbf{I}-\mathbf{G_t}\mathbf{K}_{1t})\mathbf{S}^b_t \\
\mathbf{G_t} &= \mathbf{S}_t
\end{aligned}
$$

C.K. Wikle and L.M.Berliner, 2007. A Bayesian tutorial for data assimilation. Physica D.
