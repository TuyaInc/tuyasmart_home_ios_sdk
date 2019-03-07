## 准备工作

### 注册开发者账号
前往 [涂鸦智能开发平台](https://developer.tuya.com) 注册开发者账号、创建产品、创建功能点等，具体流程请参考[接入流程](https://docs.tuya.com/cn/overview/dev-process.html)

### 获取iOS的App Key、App Secret、安全图片
前往 开发平台 - 应用管理 - 新建应用 获取`iOS`的`App Key`、`App Secret`、安全图片。

![cmd-markdown-logo](http://images.airtakeapp.com/smart_res/developer_default/sdk_zh.jpeg)



下载安全图片，重命名为`t_s.bmp`，放入项目根目录，作为资源文件引入app。确认「项目设置 => Target => Build Phases => Copy Bundle Resources」包含`t_s.bmp`文件。

集成SDK时请确认`bundleId`、`appKey`、`appSecret`、安全图片是否与平台上的信息一致，任意一个不匹配会导致SDK无法使用。



### 联调方式
- 通过硬件控制板 进行真机调试
- 通过开发平台 - 模拟设备 进行模拟调试

### SDK Demo
SDK Demo 是一个完整的APP，包含了登录、注册、共享、配网、控制等主流程，可参看Demo代码进行开发。 [下载地址](https://github.com/TuyaInc/tuyasmart_home_ios_sdk)