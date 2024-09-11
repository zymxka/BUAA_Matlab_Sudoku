# ATOM_SUDOKU

用 `MATLAB` 实现的 AI 数独求解器：从图片中找到并求解数独，顺便将结果回填到原始图片中。



## 架构

+ 感知与交互
+ CV与DL
+ 训练与调优



## 两段式感知

先由**语义分割**确定数独的位置，再由**分类网络**识别具体的数字。

使用matlab提供的**预训练模型**和**数据增强器**。

#### 语义分割





## 参与贡献

1.  wsq: front end
1.  xwc: CNN classifier
1.  fjh: CNN semantic segmentation
1.  zym: CV


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
