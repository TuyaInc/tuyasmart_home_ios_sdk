## 更新日志

### 1.2.5 (2020-07-04)

依赖最新版本 `pod 'TuyaSmartDeviceKit'`

- [新增] ：分页获取语音包文件列表
- [新增] ：语音包新增扩展属性



### 1.2.4 (2020-04-26)

依赖最新版本 `pod 'TuyaSmartDeviceKit'`

- [新增] ：扫地机设备管理类 `TuyaSmartSweeperDevice`
- [新增] ：新版流数据通道接口
- [废弃] ：`TuyaSmartSweeper` 和 `TuyaSmartFileDownload`



### 1.0.7 (2019-11-09)

依赖最新版本 `pod 'TuyaSmartDeviceKit'`

- [新增] ：语音下载功能
- [bugfix] : 修复 `-[TuyaSmartSweeper sweeper:didReciveDataWithDevId:]` 回调当前设备的数据 



### 1.0.6 (2019-09-27)

依赖最新版本 `pod 'TuyaSmartDeviceKit'`

- [bugfix] : remove log



### 1.0.5 (2019-07-03)

依赖最新版本 `pod 'TuyaSmartDeviceKit'`

- [bugfix] : 修复偶现崩溃问题



### 1.0.4 (2019-06-24)

依赖最新版本 `pod 'TuyaSmartDeviceKit'`

- [修改] : 对象销毁时移除 mqtt 的 delegate



### 0.2.0 (2019-05-15)

依赖版本 `pod 'TuyaSmartDeviceKit', '~> 2.10.96'`

- [废弃] : `-[TuyaSmartSweeperDelegate sweeper:didReciveDataWithDevId:mapType:mapPath:]` 接收激光数据通道消息
- [新增] : `-[TuyaSmartSweeperDelegate sweeper:didReciveDataWithDevId:mapData:]` 接收激光数据通道消息



### 0.1.7 (2019-05-15)

依赖版本 `pod 'TuyaSmartDeviceKit', '~> 2.8.43'`

- [bugfix] : 支持 bitcode
- [bugfix] : `- (void)getSweeperCurrentPathWithDevId:` 更新云配置的逻辑
- [新增] : `- (void)removeAllHistoryDataWithDevId:` 清空当前扫地机历史记录



### 0.1.6 (2019-03-21)

- [新增] : 分享设备支持查看历史记录



### 0.1.5 (2019-03-19)

- [bugfix] : 获取历史记录接口调整，会根据所属家庭的纬度区分



### 0.1.4 (2019-03-05)

- [bugfix] : TuyaSmartSweeperDelegate 代理方法只返回当前初始化时传入的 devId 对应的设备接受到的 MQTT消息
- [新增] : - (void)getSweeperDataWithBucket: 根据 bucket 和 path 下载文件，complete 回调 下载内容
- [新增] : - (void)getSweeperDataWithBucket: 解析 OSS 错误信息，并返回 NSError
- [新增] : - (void)getSweeperCurrentPathWithDevId: 获取实时的地图/路径的文件路径
- [新增] : - (void)removeSweeperHistoryDataWithDevId: 删除扫地机历史记录



### 0.1.3 (2019-01-29)

