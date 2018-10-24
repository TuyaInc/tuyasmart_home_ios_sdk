涂鸦硬件模块支持两种配网模式：快连模式（TLink，简称EZ模式）、热点模式（AP模式）。快连模式操作较为简便，建议在配网失败后，再使用热点模式作为备选方案。
Zigbee 采用有线配网，不用输入Wifi配置信息。

**EZ模式配网流程：**

手机连上路由器WiFi -> 将设备切换至EZ模式 -> 手机开始配网（发送配置信息） -> 设备收到配置信息 -> 设备连上路由器WiFi -> 设备进行激活 -> 配网成功

**AP模式配网流程：**

将设备切换至AP模式 -> 手机连上设备的热点 -> 手机开始配网（发送配置信息） -> 设备收到配置信息 -> 设备自动关闭热点 -> 设备连上路由器WiFi -> 设备进行激活 -> 配网成功

配网相关的所有功能对应`TuyaSmartActivator`类（单例）。

**zigbee 有线配网**

将zigbee网关重置 -> 手机连上和网关相同的热点 -> 手机发送激活指令 -> 设备收到激活信息 -> 设备进行激活 -> 配网成功

### 准备工作

开始配网之前，SDK需要在联网状态下从涂鸦云获取配网Token，然后才可以开始EZ/AP模式配网。Token的有效期为5分钟，且配置成功后就会失效（再次配网需要重新获取）。

```
- (void)getToken {
	[[TuyaSmartActivator sharedInstance] getTokenWithHomeId:homeId success:^(NSString *token) {
		NSLog(@"getToken success: %@", token);
		// TODO: startConfigWiFi
	} failure:^(NSError *error) {
		NSLog(@"getToken failure: %@", error.localizedDescription);
	}];
}
```

### 开始配网

EZ模式配网：

```objc
- (void)startConfigWiFi:(NSString *)ssid password:(NSString *)password token:(NSString *)token {
	// 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
	[TuyaSmartActivator sharedInstance].delegate = self;
	
	// 开始配网
	[[TuyaSmartActivator sharedInstance] startConfigWiFi:TYActivatorModeEZ ssid:ssid password:password token:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
	
	if (!error && deviceModel) {
		//配网成功
    }
    
    if (error) {
        //配网失败
    }	
}

```

AP模式配网与EZ类似，把`[TuyaSmartActivator startConfigWiFi:ssid:password:token:timeout:]`的第一个参数改为`TYActivatorModeAP`即可。注意`ssid`和`password`需要填写的是路由器的热点名称和密码，并不是设备的热点名称和密码。

### zigbee 有线配网

```objc
- (void)startConfigWiFiToken:(NSString *)token {
	// 设置 TuyaSmartActivator 的 delegate，并实现 delegate 方法
	[TuyaSmartActivator sharedInstance].delegate = self;
	
	// 开始配网
	[[TuyaSmartActivator sharedInstance] startConfigWiFiWithToken:token timeout:100];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
	
	if (!error && deviceModel) {
		//配网成功
    }
    
    if (error) {
        //配网失败
    }	

}

```

### 停止配网

开始配网操作后，APP会持续广播配网信息（直到配网成功，或是超时）。如果需要中途取消操作或配网完成，需要调用`[TuyaSmartActivator stopConfigWiFi]`方法。

```objc
- (void)stopConfigWifi {
	[TuyaSmartActivator sharedInstance].delegate = nil;
	[[TuyaSmartActivator sharedInstance] stopConfigWiFi];
}
```


### 激活ZigBee子设备

如果需要中途取消操作或配网完成，需要调用`stopActiveSubDeviceWithGwId`方法

```objc
- (void)activeSubDevice {

	[[TuyaSmartActivator sharedInstance] activeSubDeviceWithGwId:@"your_device_id" success:^{
		NSLog(@"active sub device success");
	} failure:^(NSError *error) {
		NSLog(@"active sub device failure: %@", error);
	}];
}

#pragma mark - TuyaSmartActivatorDelegate
- (void)activator:(TuyaSmartActivator *)activator didReceiveDevice:(TuyaSmartDeviceModel *)deviceModel error:(NSError *)error {
    
    if (deviceModel) {
        //配网成功,zigbee子设备没有做超时失败处理
    }   
}
```

### 停止激活zigbee子设备

```objc
- (void)stopActiveSubDevice {
	[[TuyaSmartActivator sharedInstance] stopActiveSubDeviceWithGwId:@"your_device_id"];
}
```

