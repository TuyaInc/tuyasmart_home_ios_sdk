## 配置 Widget 工程
* widget 创建步骤
* 修改 Podfile
```
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'NO'
        end
    end
end
```

* AppGroups
	* 开启 AppGroups 权限
	* 在 SDK 初始化前，给 SDK 设置 AppGroups Name
	* 因为 AppGroups 只有付费开发者账号才能创建权限，所以免费开发者账号不能调试 Widget 应用
* 配置安全图片和用 AppKey、AppSecret初始化 SDK
* 在用 AppKey 初始化 SDK 前设置 AppGroupName
```objective-c
    [TuyaSmartSDK sharedInstance].appGroupId = APP_GROUP_NAME;
    [[TuyaSmartSDK sharedInstance] startWithAppKey:SDK_APPKEY secretKey:SDK_APPSECRET];
```


## 使用SDK
* 在主工程中设置当前 homeID
* 使用 TuyaSmartDeviceModel.switchDp 判断设备是否支持快捷开关
* 需要在 viewWillAppear 中判断是否在主工程中切换了账号和房间，如果切换了需要刷新数据

