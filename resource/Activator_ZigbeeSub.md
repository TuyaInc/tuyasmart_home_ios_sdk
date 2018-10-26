#### zigbee 子设备激活

##### 激活ZigBee子设备

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

##### 停止激活zigbee子设备

```objc
- (void)stopActiveSubDevice {
	[[TuyaSmartActivator sharedInstance] stopActiveSubDeviceWithGwId:@"your_device_id"];
}
```

