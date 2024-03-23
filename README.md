# 简吃App

包含功能：
- 登录
- 浏览食品
- 购买
- 查看订单状态


素材来源：
- icon 来自iconFont和iconPark
- 图片 来自花瓣

使用的技术：



## 编译说明：
- Api版本为9.0
- 需安装ohpm https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V3/ide-command-line-ohpm-0000001490235312-V3

## 运行说明：
1. 修改IP

文件位置`src/main/ets/net/HttpRequest.ts`
```
/**
 * 需要替换成自己电脑在区域网中的ip
 */
const BASE_URL = "http://192.168.3.5:8013"

```

2. 输入账号`shop` 密码：`123456` 可登录成功