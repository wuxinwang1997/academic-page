---
# Documentation: https://wowchemy.com/docs/managing-content/

title: A Four-Dimensional Variational Constrained Neural Network-Based Data Assimilation
  Method
subtitle: ''
summary: ''
authors:
- admin
- Kaijun Ren
- Boheng Duan
- Junxing Zhu
- Xiaoyong Li
- Weicheng Ni
- Jingze Lu
- Taikang Yuan
tags:
- data assimilation
- machine learning
- four-dimensional variational
- analysis field
- Lorenz96
categories: []
date: '2024-01-01'
lastmod: 2024-01-25T15:41:25+08:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ''
  focal_point: ''
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
publishDate: '2024-01-25T07:41:24.120657Z'
publication_types:
- '2'
abstract: Abstract Advances in data assimilation (DA) methods and the increasing amount
  of observations have continuously improved the accuracy of initial fields in numerical
  weather prediction during the last decades. Meanwhile, in order to effectively utilize
  the rapidly increasing data, Earth scientists must further improve DA methods. Recent
  studies have introduced machine learning (ML) methods to assist the DA process.
  In this paper, we explore the potential of a four-dimensional variational (4DVar)
  constrained neural network (NN) method for accurate DA. Our NN is trained to approximate
  the solution of the variational problem, thereby avoiding the need for expensive
  online optimization when generating the initial fields. In the context that the
  full-field system truths are unavailable, our approach embeds the system's kinetic
  features described by a series of analysis fields into the NN through a 4DVar-form
  loss function. Numerical experiments on the Lorenz96 physical model demonstrate
  that our method can generate better initial fields than most traditional DA methods
  at a low computational cost, and is robust when assimilating observations with higher
  error outside of the distributions where it is trained. Furthermore, our NN-based
  DA model is effective against Lorenz96 physical models with larger variable numbers.
  Our approach exemplifies how ML methods can be leveraged to improve both the efficiency
  and accuracy of DA techniques.
publication: '*Journal of Advances in Modeling Earth Systems*'
doi: https://doi.org/10.1029/2023MS003687
links:
- name: URL
  url: https://agupubs.onlinelibrary.wiley.com/doi/abs/10.1029/2023MS003687
---
