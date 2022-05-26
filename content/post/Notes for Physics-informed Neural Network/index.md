---
title: Notes for Physics-informed Neural Network
subtitle: 

# Summary for listings and search engines

summary: 物理信息神经网络相关论文笔记

# Link this post with a project

projects: []

# Date published

date: "2022-02-19"

# Date updated

lastmod: "2022-02-19"

# Is this an unpublished draft?

draft: false

# Show this page in the Featured widget?

featured: false

# Featured image

# Place an image named `featured.jpg/png` in this page's folder and customize its options here.

image:
  caption: ""
  focal_point: ""
  placement: 2
  preview_only: false

authors:

- admin

tags:

- Academic
- Physics-informed Neural Network
- Machine Learning

categories:

- Note
- 笔记

---

- ##### Physics-informed neural networks: A deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations
  
  M. Raissi, P. Perdikaris, G.E. Karniadakis, **Journal of Computational Physics, 2019, Q2** (Citations 1249)
  
  Type: new method and framework
  
  Theory:
  
  A PDE function has a general form:
  
  $$
  u_t+\mathcal{N}[u] = 0, x \in \Omega,t \in [0,T]
  $$
  
  This paper introduces physics-informed neural networks which uses NN to learn PDE functions. 
  
  $$
  f := u_t+\mathcal{N}[u]
  $$
  
  The shared parameters between the neural networks $u(t, x)$ and $f(t,x)$ can be learned by minimizing:
  
  $$
  \begin{aligned}
MSE &= MSE_u + MSE_f \\
MSE_u &= \frac{1}{N_u}\sum^{N_u}_{i=1}\left|u(t^i_u,x^i_u)-u^i\right|^2 \\
MSE_f &= \frac{1}{N_f}\sum^{N_f}_{i=1}\left|f(t^i_f,x^i_f)\right|^2
\end{aligned}
  $$
  
  Where $\{t^i_u, x^i_u, u^i\}^{N_u}_{i=1}$ denote the initial and boundary training data on $u(t, x)$ and $\{t^i_f,x^i_f\}^{N_f}_{i=1}$ specify the collocations points for $f(t, x)$.
  
  The discrete time models are using Runge-Kutta methods with q stages to equation. 
  
  $$
  \begin{aligned}
&u^{n+c_i}=u^n-\Delta t\sum^q_{j=1}a_{ij}\mathcal{N}[u^{n+c_j}],i=1,\cdots,q \\
&u^{n+1}=u^n-\Delta t\sum^q_{j=1}b_j\mathcal{N}[u^{n+c_j}]
\end{aligned}
  $$
  
  Here, $u^{n+c_j}(x)=u(t^n+c_j\Delta t, x)$ for $j=1,\cdots,q$.

- ##### Physics-informed learning of governing equations
  
  Zhao Chen, Yang Liu， Hao Sun， **Nature Communications, 2021, Nature_sub** (Citation 11)
  
  Type: method
  
  Physics-informed neural network with sparse regrassion.
  
  SINDy has strong dependence on both quality and quantity of the measurement data.
  
  the deep neural network (DNN) is used to approximate the solution constrained by both the PDE(s) and a small amount of available data. 
  
  <img src="file:///D:/Software/MarkText/images/2022-02-22-12-07-30-image.png" title="" alt="" data-align="center">
  
  ![](D:\Software\MarkText\images\2022-02-22-12-11-14-image.png)