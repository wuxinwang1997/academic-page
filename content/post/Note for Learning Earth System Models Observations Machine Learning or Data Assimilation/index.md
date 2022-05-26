---
title: Note for Learning Earth System Models Observations Machine Learning or Data Assimilation
subtitle: 

# Summary for listings and search engines
summary: 资料同化与机器学习的共同点：在贝叶斯理论框架下，都是反问题求解 资料同化的特性：不确定性、稀疏性、非直接观测 四维变分同化与RNN在一定程度下是等价的

# Link this post with a project
projects: []

# Date published
date: "2021-04-13"

# Date updated
lastmod: "2021-04-13"

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

## 主要结论

- 资料同化与机器学习的共同点：在贝叶斯理论框架下，都是反问题求解。
- 资料同化的特性：不确定性、稀疏性、非直接观测
- 四维变分同化与RNN在一定程度下是等价的

## 背景介绍

地球系统中存在大量不确定性，目前使用机器学习方法主要是为了`解决预测的不确定性`[^2] [^3] [^4] [^5]。在数值预报中，常用的解决数据不确定性的方法为资料同化，其使用`物理定律和过去的观测中积累的知识`。在理论背景下，资料同化已被用作学习地球物理模型的替代ML框架[^6]，而混合DA-ML方法则寻求`将可训练的模型纳入物理模型`的组成部分，或在`状态评估`和`预测的主要DA过程`中完全替代物理模型[^7]。

## 在贝叶斯理论框架下结合ML和DA

DA和ML均为了解决`反问题`

对于正问题的定义：函数$h(\cdot)$将状态$x$映射到观测$y$：
$$
y = h(x, w)
$$
反问题则是为了从观测$y$找到$x$

<img src="https://cdn.jsdelivr.net/gh/wuxinwang1997/blogImages/fig1.png" alt="fig1" style="zoom:67%;" />

上图说明：DA通常用固定的$w$估计$x$，ML保持固定的$x$估计$w$

在机器学习的视角上看，特征$x$和权重$w$是平等的，一般将特征与标签集合起来$(x,y)$作为数据

常规DA与ML最接近的是参数估计，通常可以将状态模型中的一小部分参数与状态一起进行估计

## 时间维度分析

DA过程中的时间维度可以等同于前馈神经网络中的层[^8]，但DA与递归神经网络（RNN）之间存在更清晰的相似之处。`RNN成为监视和预测大气等混沌动力学系统并使用ML完全替代DA的一种方式`[^9] [^10] [^11] [^12]

## 机器学习可用于学习新的物理地球模式

如下图所示，`云参数化`步骤是ML或DA方法的主要目标，旨在`从观测中学习新的物理模型`[^13] [^14]

<img src="https://cdn.jsdelivr.net/gh/wuxinwang1997/blogImages/fig3.png" alt="fig3" style="zoom:67%;" />

此外，随着地球系统建模进一步代表表面和生物过程，而我们在基于物理的正向模型中表达理解的能力甚至更低，因此ML仍然是一种`利用观测来提高科学知识（进而提高模型）的有吸引力的方法`[^15]

大气的详细预测需要比常规观测更高的垂直分辨率，因此DA使用大气模型填充高分辨率细节（观测的“零空间”）以间接推断其他观测信息（通过向前和向后） 及时传播观测信息

机器学习的第二个主要问题是如何整合现有的领域知识。 比较常见的方法是`将物理约束条件作为损失函数中的附加项`[^16] [^17]，并且存在其他方法[^18]

对于已经运行了数据同化系统的天气预报中心，该数据同化系统对数十年的专业天气预报知识进行了编码，显而易见的方法是扩展现有的DA系统以学习模型的各个方面，无论是通过参数估计还是通过 使用神经网络或等效方法学习新的功能表示[^6]

在循环DA系统中，通过过去10天（对于大气）的观测信息的正向传播以及观测数据的向后传播，可以减少这些状态下的不确定性。也可以从`后处理预测中使用ML进行偏差校正`[^19]，适用于由物理模型做出的部分错误的预测。机器学习可以同样适用于`学习可以估计模型误差的空间范围`[^20]

**问题**：一个实际的问题是将Fortran中的典型DA或科学应用程序与ML软件（例如Keras和TensorFlow）相结合，这些软件是Python前端和C ++后端[^21]

使用ML从地球系统观测中学习的部分驱动力是假设ML仿真器将比观测的物理模型更快[^2]。 但是，在一个4D-Var DA系统中，观测的运行时间成本仅为2％，主要成本来自DA算法和地球系统的物理模型[^22]

## 总结

此外，尽管试图丢弃现有的物理知识并开始使用ML进行尝试[^23] [^10] [^12]，但是任何尊重贝叶斯的方法都将尝试从先验知识受益

- 机器学习可以`将物理观测模型合并为输出层`
- `物理模型层也可以并入神经网络`以约束地球物理状态
- `递归网络`在地球物理状态预测中的主要工作是及时传播此状态，以`保留过去的观测信息`

机器学习可以作为：

1. 其他物理模型框架中可学习的模块； 
2. 用于`学习模型和观察系统误差`； 
3. 加速过程的一部分的`加速器`（特别是在需要多次运行模型的区域中，这在集合和变体中都存在）； 
4. 以及作为`变分同化自动微分`的替代工具

[^1]: Geer AJ. Learning earth system models from observations: machine learning or data assimilation? Philos Trans A Math Phys Eng Sci. 2021 Apr 5;379(2194):20200089. doi: 10.1098/rsta.2020.0089. Epub 2021 Feb 15. PMID: 33583270.
Boukabara, S.-A., V. Krasnopolsky, J. Q. Stewart, A. McGovern, D. Hall, J. E. T. Hoeve, J. Hickey, H.L. A. Huang, J. K. Williams, K. Ide, P. Tissot, S. E. Haupt, E. Kearns, K. S. Casey, N. Oza, P. Dolan, P. Childs, S. G. Penny, A. J. Geer, E. Maddy, and R. N. Hoffman (2020). Outlook for exploiting artificial intelligence in earth science. Bull. Am. Meteorol. Soc., submitted.
Reichstein, M., G. Camps-Valls, B. Stevens, M. Jung, J. Denzler, N. Carvalhais, et al. (2019). Deep learning and process understanding for data-driven Earth system science. Nature 566(7743), 195–204.
Gal, Y. and Z. Ghahramani (2016). Dropout as a Bayesian approximation: Representing model uncertainty in deep learning. In International conference on machine learning, pp. 1050–1059.
Lakshminarayanan, B., A. Pritzel, and C. Blundell (2017). Simple and scalable predictive uncertainty estimation using deep ensembles. In Advances in neural information processing systems, pp. 6402–6413.
Bocquet, M., J. Brajard, A. Carrassi, and L. Bertino (2019). Data assimilation as a learning tool to infer ordinary differential equation representations of dynamical models. Nonlinear Processes in Geophysics 26(3), 143–162
Brajard, J., A. Carassi, M. Bocquet, and L. Bertino (2020). Combining data assimilation and machine learning to emulate a dynamical model from sparse and noisy observations: a case study with the Lorenz 96 model. arXiv preprint arXiv:2001.01520.
Abarbanel, H. D., P. J. Rozdeba, and S. Shirman (2018). Machine learning: deepest learning as statistical data assimilation problems. Neural Computation 30(8), 2025–2055.
Park, D. C. and Y. Zhu (1994). Bilinear recurrent neural network. In Proceedings of1994 IEEE International Conference on Neural Networks (ICNN’94), Volume 3, pp. 1459–1464. IEEE.
Pathak, J., B. Hunt, M. Girvan, Z. Lu, and E. Ott (2018). Model-free prediction of large spatiotemporally chaotic systems from data: A reservoir computing approach. Phys. Rev. Let. 120(2), 024102.
Vlachas, P., J. Pathak, B. Hunt, T. Sapsis, M. Girvan, E. Ott, and P. Koumoutsakos (2020). Backpropagation algorithms and reservoir computing in recurrent neural networks for the forecasting of complex spatiotemporal dynamics. Neural Networks 126, 191–217.
Sønderby, C. K., L. Espeholt, J. Heek, M. Dehghani, A. Oliver, T. Salimans, S. Agrawal, J. Hickey, and N. Kalchbrenner (2020). MetNet: A neural weather model for precipitation forecasting. arXiv preprint arXiv:2003.12140.
Schneider, T., S. Lan, A. Stuart, and J. Teixeira (2017). Earth system modeling 2.0: A blueprint for models that learn from observations and targeted high-resolution simulations. Geophys. Res. Let. 44(24), 12–396.
Gentine, P., M. Pritchard, S. Rasp, G. Reinaudi, and G. Yacalis (2018). Could machine learning break the convection parameterization deadlock? Geophysical Research Letters 45(11), 5742–5751.
Reichstein, M., G. Camps-Valls, B. Stevens, M. Jung, J. Denzler, N. Carvalhais, et al. (2019). Deep learning and process understanding for data-driven Earth system science. Nature 566(7743), 195–204.
Beucler, T., M. Pritchard, S. Rasp, P. Gentine, J. Ott, and P. Baldi (2019). Enforcing analytic constraints in neural-networks emulating physical systems. arXiv preprint arXiv:1909.00912.
Wu, Y., M. Schuster, Z. Chen, Q. V. Le, M. Norouzi, W. Macherey, M. Krikun, Y. Cao, Q. Gao, K. Macherey, et al. (2016). Google’s neural machine translation system: Bridging the gap between human and machine translation. arXiv preprint arXiv:1609.08144.
Von Rueden, L., S. Mayer, J. Garcke, C. Bauckhage, and J. Schuecker (2019). Informed machine learning–towards a taxonomy of explicit integration of knowledge into machine learning. Learning 18, 19–20.
McGovern, A., K. L. Elmore, D. J. Gagne, S. E. Haupt, C. D. Karstens, R. Lagerquist, T. Smith, and J. K. Williams (2017). Using artificial intelligence to improve real-time decision-making for high-impact weather. Bulletin ofthe American Meteorological Society 98(10), 2073–2090.
Bonavita, M. and P. Laloyaux (2020). Machine learning for model error inference and correction. J. App. Meterol. Earth. Sys., to be submitted.
Ott, J., M. Pritchard, N. Best, E. Linstead, M. Curcic, and P. Baldi (2020). A Fortran-Keras deep learning bridge for scientific computing. arXiv preprint arXiv:2004.10652.
English, S., P. Lean, and A. Geer (2020). How radiative transfer models can support the future needs of earth-system forecasting and re-analysis. J. Quant. Spectrosc. Rad. Trans., accepted.
Dueben, P. D. and P. Bauer (2018). Challenges and design choices for global weather and climate models based on machine learning. Geosci. Mod. Dev. 11(10), 3999–4009.
