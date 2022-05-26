---
title: Note for some data resources of sea wind field
subtitle: 

# Summary for listings and search engines
summary: 对各类风场观测卫星数据进行梳理

# Link this post with a project
projects: []

# Date published
date: "2021-11-10"

# Date updated
lastmod: "2021-11-10"

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

categories:
- Note
- 笔记
---

## FY3E

### 简介

FY-3E卫星有效补充了6小时同化窗内卫星观测资料的空白，对南北半球预报和洲际尺度的区域预报有积极的贡献，弥补了全球观测资料的不足，上午卫星（ETC 10:00左右）、下午卫星（ETC 13:00左右）、晨昏轨道卫星三星组网观测可以使6小时同化窗内卫星资料100%全球覆盖，对4-7天500hPa位势高度的预报半球尺度（北半球）提高2-3个百分点，区域尺度（北美洲）提高2-10个百分点。三星组网后，每6小时可为数值预报提供一次完整全球覆盖的资料，有效提高和改进全球数值天气预报精度和时效，对完善全球对地观测系统具有重要意义。

FY-3E卫星在确保极轨气象卫星全球成像和大气垂直探测观测业务的基础上，侧重数值天气预报的应用目标，对天气会商、热带气旋和其它极端气象灾害预警、气候监测、太阳和空间天气观测具有独特优势。

### 特色

- 高精度光学微波组合大气温度湿度垂直分布探测能力：拥有晨昏轨道上微波温度、微波湿度、高光谱红外、无线电掩星全球大气温度湿度垂直分布探测能力
- 主动遥感仪器风场精确探测能力：主动遥感探测，可提供气象预测预报亟需的全球海面风场（风速和风向）信息，并通过与全球导航卫星海反观测同平台观测，可提供更高的风场空间采样密度。
- 全球气候变化监测与预测的支撑能力：提供在晨昏时刻的太阳和地气系统观测；太阳辐射是地球接收的、驱动地球大气和海洋运动唯一能量；
- 太阳和空间环境综合探测能力

### 技术指标

| 轨道类型    | 近极地太阳同步轨道        |
|:------- | ---------------- |
| 轨道标称高度  | 836公里            |
| 轨道倾角    | 98.75º           |
| 轨道保持偏心率 | ≤0.0025          |
| 轨道周期    | 101.5min         |
| 轨道回归周期  | 标称5.5天，设计范围4~10天 |
| 降交点地方时  | 05:30            |
| 交点地方时漂移 | 8年小于20分钟         |
| 姿态稳定方式  | 三轴稳定             |
| 卫星发射重量  | 2300公斤           |
| 卫星平均功率  | 2500瓦            |
| 卫星寿命    | 设计寿命8年，6年考核      |

### 探测仪器

FY-3E的主要仪器载荷配置有：微波温度计、微波湿度计、红外高光谱大气探测仪、**GPS掩星探测仪以及双频微波主动散射雷达**。

| 仪器名称                                                                 | 仪器全称             | 英文全称                                         |
|:-------------------------------------------------------------------- |:---------------- |:-------------------------------------------- |
| [MERSI-LL ](http://fy4.nsmc.org.cn/nsmc/cn/instrument/MERSI-LL.html) | 中分辨率光谱成像仪（微光型）   | Medium Resolution Spectral Imager-LL         |
| [HIRAS-2 ](http://fy4.nsmc.org.cn/nsmc/cn/instrument/HIRAS.html)     | 红外高光谱大气探测仪（II型）  | Hyperspectral Infrared Atmospheric Sounder-2 |
| [MWTS-3 ](http://fy4.nsmc.org.cn/nsmc/cn/instrument/MWTS-2.html)     | 微波温度计（III型）      | Micro-Wave Temperature Sounder-3             |
| [MWHS-2 ](http://fy4.nsmc.org.cn/nsmc/cn/instrument/MWHS-2.html)     | 微波湿度计（II型）       | Micro-Wave Humidity Sounder-2                |
| [GNOS-2 ](http://fy4.nsmc.org.cn/nsmc/cn/instrument/GNOS.html)       | 全球导航卫星掩星探测仪（II型） | GNSS Radio Occultation Sounder-2             |
| WindRad                                                              | 风场测量雷达           | Wind Radar                                   |
| SSIM                                                                 | 太阳辐照度光谱仪         | Solar Spectral Irradiance Monitor            |
| SIM-2                                                                | 太阳辐射监测仪（II型）     | Solar Irradiance Monitor-2                   |
| X-EUVI                                                               | 太阳X射线极紫外成像仪      | Solar X-ray and Extreme Ultraviolet Imager   |
| [Tri-IPM ](http://fy4.nsmc.org.cn/nsmc/cn/instrument/IPM.html)       | 电离层光度计（多角度型）     | Triple-angle Ionospheric PhotoMeter          |
| SEM                                                                  | 空间环境监测器          | Space Environment Monitor                    |

## HY2B

### 简介

该卫星集主、被动微波遥感器于一体，属于我国海洋系列遥感卫星，具有高精度测轨、定轨能力与全天候、全天时、全球探测能力。卫星的主要使命是监测和调查海洋环境，获得包括海面风场、浪高、海面高度、海面温度等多种海洋动力环境参数，直接为灾害性海况预警预报提供实测数据，为海洋防灾减灾、海洋权益维护、海洋资源开发、海洋环境保护、海洋科学研究以及国防建设等提供支撑服务。

### 观测要素及精度

- 海面风场
- 海面高度
- 有效波高
- 重力场
- 大洋环流和海面温度
- 兼顾观测要素包括：海冰、大地水准面和水汽含量。

| 参量    | 测量精度             | 有效测量范围        |
| ----- | ---------------- | ------------- |
| 风速    | 2m/s或10%，取大者     | 2-24m/s       |
| 风向    | 20°              | 0°-360°       |
| 海面高度  | ~5cm             |               |
| 有效波高  | 0.5m或10%，取大者     | 0.2~20m       |
| 海面温度  | $\pm 1.0$℃       | -2~35℃        |
| 水汽含量  | $\pm 3.5 kg/m^2$ | 0~80 $kg/m^2$ |
| 云中液态水 | $\pm0.05 kg/m^2$ | 0~1.0$kg/m^2$ |

### 有效载荷

#### 雷达高度计

- 主要功能：测量海面高度、有效波高和重力场参数，具有外定标工作模式
- 技术指标
  - 工作频率：$13.58GHz,5.25GHz$
  - 脉冲有限足迹 优于$2km$
  - 测距精度：优于$2cm$（海洋星下点）
  - 具有海陆观测功能
- 外定标模式工作方式：输出高度计脉冲$I/Q$原始数据，外定标过程能够覆盖完整的定标区域

#### 微波散射计

- 主要功能：测量海面风矢量场，具有外定标工作模式。

- 技术指标：
  
  - 工作频率 13.256GHz
  
  - 工作带宽（1dB）： 1MHz
  
  - 极化方式： HH, VV
  
  - 处理后地面分辨率 25km
  
  - 刈幅
    
    - H极化： 优于1350km
    - V极化： 优于1700km
  
  - s°测量精度 0.5dB
  
  - s°测量范围 -40dB~+20dB

#### 扫描微波辐射计

- 主要功能：测量海面温度、海面水汽含量、液态水和降雨强度等参数

- 技术指标
  
  ![](D:\File\Github\MySite\content\post\Note%20for%20data%20resources\index.assets\image-20211110093857740.png)

#### 校正辐射计

- 主要功能：为高度计提供大气湿对流层路径延迟校正服务。

- 技术指标：
  
  ![image-20211110093938948](D:\File\Github\MySite\content\post\Note for data resources\index.assets\image-20211110093938948.png)

#### 船舶识别系统

- 主要功能：侦收、解调并转发AIS报文。

- 技术指标：
  
  工作频率：161.975MHz，162.025 MHz，156.775 MHz，156.825 MHz；
  
  可监测幅宽：≥1000km。

#### 数据收集系统

- 主要功能：接收我国近海及其他海域的浮标测量数据，存贮后通过卫星对地数传通道进行星地转发

- 技术指标
  
  工作频率：401.65MHz±55kHz；
  
  调制方式：BPSK。
