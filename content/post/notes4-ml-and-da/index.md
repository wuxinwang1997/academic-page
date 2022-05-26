---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Notes for Machine Learning and Data Assimilation"
subtitle: "机器学习与资料同化结合相关论文笔记"
summary: ""
authors: [admin]
tags: [Academic, Data Assimilation, Machine Learning]
categories: [Note]
date: 2022-02-17T00:00:00+00:00
lastmod: 2022-05-26T14:09:29+08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: "Image credit: [**Unsplash**](https://unsplash.com/photos/CpkOjOcXdUY)"
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

- ##### Evaluation, Tuning, and Interpretation of Neural Networks for Working with Images in Meteorological Applications
  
  Imme Ebert-Uphoff and Kyle Hilburn, **Bulletin of the American Meteorological Society (BAMS), 2020, Q1** (Citations 27)
  
  Type: Survey
  
  Quesitons:
  
  - Evaluation and tuning: Which performance measures are most useful to evaluate and tune a neural net work in a metorological context?
  
  - Intepretability: If an NN is performing well, how does it generate meteorological meaningful results? Can we discover the strategies it uses?
  
  Anwsers:

- Models are classified into two types:
  
  1. Image Classification
  
  2. Image-to-image tanslation

- GANs can successfully emulate small-scale features in meterological fileds.

- Using receptive fields (RF) and layer-wise relevance propagation (LRP) to analysis NN model.
  
  RF:
  
  1. TRF: Theoretical Receptive Field determines the maximal spatial context used bt each layer, which is a theoretical upper bound.
  
  2. ERF: Effective Receptive Field determines the area that the NN truely used, might be a bit smaller than TRF.

- Using performance measuers for NN tuning
  
  1. Weighted MSE:
     
     $$
     \begin{aligned}
L(y^{true},y^{pred})&=\sum^P_{p=1}w(y^{true_p})(y^{pred}_p-y^{true_p})^2 \\
w(y^{true_p})&=e^{b(y^{true}_p)^c}
\end{aligned}
     $$
  
  2. Loss functions versus auxiliary metrics:
     
     - ROC
     
     - AUC
     
     - Physics constraints

- Visulization methods
  
  1. Layer-wise relevance propagation (LRP): show where in the input nerual network was paying the most attention when deriving its result, takes a more global view, only available for a small set of NN architeture.
  
  2. Saliency maps: look at local gradient int the input space, available fr any network type.

- ##### Machine Learning for Earth System Observation and Prediction
  
  Massimo Bonavita, Rossella Arcucci, Alberto Carrassi, Peter Dueben, Alan J. Geer, Bertrand Le Saux, Nicolas Longépé, Pierre-Philippe Mathieu, and Laure Raynaud, **BAMS, 2021, Q1** (Citations 3)
  
  Type: summary og the WCMWF-ESA Workshop on Machine Learning for Earth System Observation and Prediction (ESOP)
  
  - Both ML/DL and DA can be seen as inverse methods based on Bayes’s theorem.
  
  - Earth system observations are sparse, affected by uncertainties and made using indrect methods, ofthen with substantial nonlinearities.
  
  - one research direction is to preserve the DA system as much as possible but to incorporate ML tools to improve or make some critical components of the DA system faster/more efficient.
  
  - The second area describes attempts to combine DA and ML in a hybrid configuration.
  
  - The third area includes contributions that have identified methodological analogies between DA and ML, or that have proposed unifying the two families of methods under a common theoretical formalism.
  
  - weak-constraint 4D-Var, already perform a form of online ML of the model errors.
  
  - how to embed deep learning in a Bayesian framework so as to equip it with the ability to provide uncertainty estimates of the learned model.

- ##### Making the black box more transparent: Understanding the Physical Implications of Machine Learning
  
  aMy McGovern, ryan LaGerquist, david John GaGne ii, G. eLi JerGensen, KiMberLy L. eLMore, caMeron r. hoMeyer, and travis sMith, **BAMS, 2019, Q1** (Citations 120)

- ##### Outlook for Exploiting Artificial Intelligence in the Earth and Environmental Sciences
  
  Sid-Ahmed Boukabara, Vladimir Krasnopolsky, Stephen G. Penny, Jebb Q. Stewart, Amy McGovern, David Hall, John E. Ten Hoeve, Jason Hickey, Hung-Lung Allen Huang, John K. Williams, Kayo Ide, Philippe Tissot, Sue Ellen Haupt, Kenneth S. Casey, Nikunj Oza, Alan J. Geer, Eric S. Maddy, and Ross N. Hoffman, **BAMS, 2021, Q1** (Citations 9)

- ##### A Graph Clustering Approach to Localization for Adaptive Covariance Tuning in Data Assimilation Based on State-Observation Mapping
  
  Sibo Cheng, Jean-Philippe Argaud, Bertrand Iooss, Angélique Ponçot, Didier Lucor, **Mathematical Geosciences, 2021, Q3** [(Citations 2)

- ##### Bridging observations, theory and numerical simulation of the ocean using machine learning
  
  Maike Sonnewald, Redouane Lguensat, Daniel C Jones, Peter D Dueben, Julien Brajard, **Environmental Research Letters, 2021, Q2**, (Citations 2)
  
  type: survey

- ##### Deep Data Assimilation: Integrating Deep Learning with Data Assimilation
  
  Rossella Arcucci, Jiangcheng Zhu, Shuang Hu, and Yi-Ke Guo, **Applied Sciences, 2021, Q3** (Citations 14)
  
  Type: Method
  
  This paper use RNN to learn DA result. And do multi-stage training to iteratlly improve the model.
  
  It looks like a model error correction not data assimilation.
  
  The trained $\mathcal{M}_i$ is a surrogate model using to do prediction.
  
  ![](https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/19-11-53-58-2022-02-19-11-53-54-image.png)
  
  The key point is that it did not need truth of the system.

- ##### Deep Learning for Geophysics: Current and Future Trends
  
  Siwei Yu, Jianwei Ma, **Reviews of Geophysics, 2021, Q1** (Citations 5)

- ##### Learning to Correct Climate Projection Biases
  
  Baoxiang Pan, Gemma J. Anderson, André Goncalves, Donald D. Lucas, Céline J. W. Bonfil, **Journal of Advances in Modeling Earth Systems (JAMES), 2021, Q2** (Citations 0)
  
  Type: method
  
  Network: GAN
  
  What Counts as a "Perfect" Climate Projection Bias Corrector?
  
  - Correct ast high spatiotemporal resolution all moments of the variable of interest,
  
  - Assure spatiotemporal consistency as well as inter-field corrections,
  
  - Discriminate between different weather situations, allow for the bias to be time-transient,
  
  - Include feedback effects
  
  This paper using adversarial learning idea to match samples from a source domain to corresponding samples in a target domain. (domain adaptation/translation)
  
  Train $D$ using $\mathbf{Y}$ and $G(\mathbf{X})$ samples woth random dynamical states.
  
  ![](https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/20-21-56-56-2022-02-20-21-23-15-image.png)
  
  Use Wasserstein GAN.
  
  <img title="" src="https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/20-21-57-00-2022-02-20-21-25-31-image.png" alt="" data-align="center">
  
  In order to satisfy the above four conditions of bias corrector, the paper used 4 constraints.
  
  - Cycle Consistency (to alleviate the model collapse problem)
    
    <img title="" src="https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/20-21-57-02-2022-02-20-21-25-49-image.png" alt="" data-align="center">
  
  - Dynamical Consistency (make $\mathbf{x}$ and $G(\mathbf{x})$ correspond to a same dynamical state $\mathbf{s_x}$)
    
    maintaining the inter-field consistency between the target variable and its underlying dynamical state during training.
    
    <img title="" src="https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/20-21-57-05-2022-02-20-21-33-31-image.png" alt="" data-align="center">
    
    $F^*_{\mathbf{X}}$ and $F^*_{\mathbf{Y}}$ are statistical downscaling models for sim and obs; $\mathbf{s_x}$ and $\mathbf{s_y}$ are dynamical state representations corresponding to $\mathbf{x}$ and $\mathbf{y}$, which are typically resolvable variables not directly impaired by GCM biases.
    
    <img title="" src="https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/20-21-57-09-2022-02-20-21-38-01-image.png" alt="" data-align="center">
    
    this constraint implicitly encourages spatiotemporal consistency of the target variable, and further alleviates mode collapse. Provided 
  
  - Dynamical Dependency
    
    the bias correction function $G$ should take into consideration of both the target variable $\mathbf{X}$ and the dynamical state $\mathbf{s_x}$
  
  <img title="" src="https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/20-21-57-12-2022-02-20-21-45-09-image.png" alt="" data-align="center">
  
  Regularized Adversarial Domain Adaptation (RADA)
  
  <img title="" src="https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/20-21-57-16-2022-02-20-21-46-08-image.png" alt="" data-align="center">
  
  Training:
  
  1. train $F_{\mathbf{x}}$ and $F_{\mathbf{Y}}$ to minimize the statical downscaling loss
  
  2. fix the trained models $F^*_{\mathbf{X}}$ and $F^*_{\mathbf{Y}}$ and train $\{G,G^{-1}\}$ to minimize (a)-(d), and train $\{D,D^{-1}\}$ to maximize (a) and (b).
  
  3. compare some crucial precipitation indices between corrected simulations and observations for the validation set at the end of each training epoch, and terminate the training when these statistics match best.

- ##### Machine Learning for Model Error Inference and Correction
  
  Massimo Bonavita, Patrick Laloyaux, **JAMES, 2020, Q2** (Citations 22)
  
  Type: method
  
  Learn the model error using MLP. And combined with WC-4DVar
  
  The use of ANN models inside the weak-constraint 4D-Var framework has the pootential to extend the applicability of the weak-constraint methodology for model error correction to the whole atmospheric column.
  
  The impact of model biases on the assimilation algorithm mainly comes through the O-B residuals, these straegies typically involve a combination of (a) debiasing the O-B through varational bias correction techniques; (b) inflating the estimayes of the background forecast errors sampled from an ensemble data assimilation system.
  
  ![](D:\Software\MarkText\images\2022-03-09-20-19-55-image.png)

- ##### Opportunities and challenges for machine learning in weather and climate modelling: hard, medium and soft AI
  
  Matthew Chantry, Hannah Christensen, Peter Dueben, Tim Palmer, **Philosophical Transactions of the Royal Society A: Mathematical, Physical and Engineering Sciences (Phil. Trans. R. Soc. A.), 2021, Q3** (Citations 8)

- ##### Physically Interpretable Neural Networks for the Geosciences: Applications to Earth System Variability
  
  Benjamin A. Toms, Elizabeth A. Barnes, Imme Ebert-Uphoff, **JAMES, 2020, Q2** (Citations 69)

- ##### Recursive filter based GPU algorithms in a Data Assimilation scenario
  
  P. De Luca, A. Galletti, G. Giunta b, L. Marcellino, **Journal of Computational Science, 2021, Q2** (Citations 3)

- ##### Towards implementing artificial intelligence post-processing in weather and climate: proposed actions from the Oxford 2019 workshop
  
  Sue Ellen Haupt, William Chapman, Samantha V. Adams, Charlie Kirkwood, J. Scott Hosking, Niall H. Robinson, Sebastian Lerch, Aneesh C. Subramanian, **Phil. Trans. R. Soc. A., 2021, Q3** (Citations 8)

- ##### Towards neural Earth system modelling by integrating artificial intelligence in Earth system science
  
  Christopher Irrgang, Niklas Boers, Maike Sonnewald, Elizabeth A. Barnes, Christopher Kadow, Joanna StanevaJan Saynisch-Wagner, **Nature Machine Intelligence, 2021, Nature-Sub** (Citations 1)

- ##### Using machine learning to correct model error in data assimilation and forecast applications
  
  Alban Farchi, Patrick Laloyaux, Massimo Bonavita, Marc Bocquet, **Quarterly Journal of the Royal Meteorological Society (QJR Meteorol Soc), 2021, Q2** (Citations 7)
  
  Type: method
  
  This paper using ML to learn model error and do correcting after a DA step.
  
  <img src="https://raw.githubusercontent.com/wuxinwang1997/blogImages/main/2022/02/26-09-43-57-2022-02-26-09-43-51-image.png" title="" alt="" data-align="center">
  
  The experiment setting is great.

- ##### Training a convolutional neural network to conserve mass in data assimilation
  
  Yvonne Ruckstuhl, Tijana Janji´c, and Stephan Rasp, **Nonlinear Processes in Geophysics, 2021, Q3** (Citations 4)

- ##### A Reduced Order Deep Data Assimilation model
  
  César Quilodrán Casas, Rossella Arcucci, Pin Wu, Christopher Pain, Yi-Ke Guo, **Physica D: Nonlinear Phenomena, 2020, Q3** (Citations 16)

- ##### Analog ensemble data assimilation and a method for constructing analogs with variational autoencoders
  
  Ian Grooms, **QJR Meteorol. Soc, 2021, Q2** Citations 7)

- ##### Combining data assimilation and machine learning to emulate a dynamical model from sparse and noisy observations: A case study with the Lorenz 96 model
  
  Julien Brajard, Alberto Carrassi, Marc Bocquet, Laurent Bertino, **Journal of Computational Science, 2020, Q2** (Citations 77)

- ##### Fast data assimilation (FDA): Data assimilation by machine learning for faster optimize model state
  
  Pin Wu, Xuting Chang, Wenyan Yuan, Junwu Sun, Wenjie Zhang, Rossella Arcucci, Yike Guo, **Journal of Computational Science, 2021, Q2**, (Citations 1)

- ##### Machine Learning Techniques to Construct Patched Analog Ensembles for Data Assimilation
  
  L. Minah Yang∗, Ian Grooms, **Journal of Computational Physics, 2021, Q2** (Citations 1)

- ##### Spatio-Temporal Interpolation of Cloudy SST Fields Using Conditional Analog Data Assimilation
  
  Ronan Fablet, Phi Huynh Viet, Redouane Lguensat, Pierre-Henri Horrein, Bertrand Chapron, **Remote Sensing, 2018, Q2** (Citations 10)

- ##### Deep Emulators for Differentiation, Forecasting, and Parametrization in Earth Science Simulators
  
  Marcel Nonnenmacher, David S. Greenberg, **JAMES, 2021, Q2** (Citations 3)
  
  Type: DP method
  
  This paper using CNN to learning Lorenz96, and change the adjoint model with NN's derivative.
  
  It just learn the function between input and output without the formular of Lorenz96 model.
  
  It is the first to estimate derivatives through simulation-trained emulators.
  
  The model architecture is awesome.

- ##### Towards Physically-consistent, data-driven models of convection
  
  Tom Beucler, Michael Pritchard, Pierre Gentine, Stephan Rasp, **IEEE International Geoscience and Remote Sensing Symposium (IGARSS), 2020**