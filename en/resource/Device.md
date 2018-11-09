## Device control

The device ID needs to be used to initiate all `TuyaSmartDevice` classes related to all functions for device control. Wrong device Id may cause initiation failure, and the `nil` will be returned.

### Update device information

#### Update single device information

```objc
- (void)updateDeviceInfo {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	__weak typeof(self) weakSelf = self;
	[self.device syncWithCloud:^{
		NSLog(@"syncWithCloud success");
		NSLog(@"deviceModel: %@", weakSelf.device.deviceModel);
	} failure:^{
		NSLog(@"syncWithCloud failure");
	}];
}
```

### Functions of device

The `dps` (`NSDictionary` type) attribute of the `TuyaSmartDeviceModel` class defines the state of the device, and the state is called data point (DP) or function point.
Each `key` in the `dps` dictionary refers to a `dpId` of a function point, and `Value` refers to the `dpValue` of a function point. The `dpValue` is the value of the function point.
Refer to the functions of product in the [Tuya developer platform](https://developer.tuya.com/) for definition of function points of products. See the following figure.

![功能点](./images/ios_dp_sample.png)

The control instructions shall be sent in the format given below:

`{"<dpId>":"<dpValue>"}`

According to the definition of function points of the product in the back end, the example codes are as follows.

```objc
- (void)publishDps {
    // self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

    NSDictionary *dps;
	//设置dpId为1的布尔型功能点示例 作用:开关打开
	dps = @{@"1": @(YES)};

	//设置dpId为4的字符串型功能点示例 作用:设置RGB颜色为ff5500
	dps = @{@"4": @"ff5500"};

	//设置dpId为5的枚举型功能点示例 作用:设置档位为2档
	dps = @{@"5": @"2"};

	//设置dpId为6的数值型功能点示例 作用:设置温度为20°
	dps = @{@"6": @(20)};

	//设置dpId为15的透传型(byte数组)功能点示例 作用:透传红外数据为1122
	dps = @{@"15": @"1122"};

	//多个功能合并发送
	dps = @{@"1": @(YES), @"4": @(ff5500)};

	[self.device publishDps:dps success:^{
		NSLog(@"publishDps success");

		//下发成功，状态上报通过 deviceDpsUpdate方法 回调

	} failure:^(NSError *error) {
		NSLog(@"publishDps failure: %@", error);
	}];


}
```

##### Precautions:

- Special attention shall be paid to the type of data in sending the control commands. For example, the data type of function points shall be value, and the `@{@"2": @(25)}` instead of `@{@"2": @"25"}` shall be sent for the control command.
- In the transparent transmission, the byte string shall be the string format, and all letters shall be in the lower case, and the string must have even bits. The correct format shall be: `@{@"1": @"011f"}` instead of `@{@"1": @"11f"}`


For more concepts of function points, please refer to the [QuickStart-Related Concepts of Function Points](https://docs.tuya.com/cn/creatproduct/#_7)

#### Update device status

After the `TuyaSmartDeviceDelegate` delegate protocol is realized, user can update the UI of the App device control in the callback of device status change.

```objc
- (void)initDevice {
	self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	self.device.delegate = self;
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device dpsUpdate:(NSDictionary *)dps {
	NSLog(@"deviceDpsUpdate: %@", dps);
	// TODO: 刷新界面UI
}

- (void)deviceInfoUpdate:(TuyaSmartDevice *)device {
	//当前设备信息更新 比如 设备名、设备在线状态等
}

- (void)deviceRemoved:(TuyaSmartDevice *)device {
	//当前设备被移除
}

```

### Modify the device name

```objc
- (void)modifyDeviceName:(NSString *)mame {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device updateName:name success:^{
		NSLog(@"updateName success");
	} failure:^(NSError *error) {
		NSLog(@"updateName failure: %@", error);
	}];
}
```

### Remove device

After a device is removed, it will be in the to-be-network-configured status (quick connection mode).

```objc
- (void)removeDevice {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device remove:^{
		NSLog(@"remove success");
	} failure:^(NSError *error) {
		NSLog(@"remove failure: %@", error);
	}];
}
```

### Obtain Wifi signal strength of device

```objc
- (void)removeDevice {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
    // self.device.delegate = self;

	[self.device getWifiSignalStrengthWithSuccess:^{
		NSLog(@"get wifi signal strength success");
	} failure:^(NSError *error) {
		NSLog(@"get wifi signal strength failure: %@", error);
	}];
}

#pragma mark - TuyaSmartDeviceDelegate

- (void)device:(TuyaSmartDevice *)device signal:(NSString *)signal {
    NSLog(@" signal : %@", signal);
}
```

### Obtain the sub-device list of a gateway

```objc
- (void)getSubDeviceList {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device getSubDeviceListFromCloudWithSuccess:^(NSArray<TuyaSmartDeviceModel *> *subDeviceList) {
        NSLog(@"get sub device list success");
    } failure:^(NSError *error) {
        NSLog(@"get sub device list failure: %@", error);
    }];
}
```


### Firmware upgrade

**Firmware upgrade process:**

Obtain device upgrade information -> send module upgrade instructions -> module upgrade succeeds -> send upgrade instructions to the device control module -> the upgrade of device control module succeeds

#### Obtain device upgrade information:

```objc
- (void)getFirmwareUpgradeInfo {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];

	[self.device getFirmwareUpgradeInfo:^(NSArray<TuyaSmartFirmwareUpgradeModel *> *upgradeModelList) {
		NSLog(@"getFirmwareUpgradeInfo success");
	} failure:^(NSError *error) {
		NSLog(@"getFirmwareUpgradeInfo failure: %@", error);
	}];
}
```

#### Send upgrade instruction:

```objc
- (void)upgradeFirmware {
	// self.device = [TuyaSmartDevice deviceWithDeviceId:@"your_device_id"];
	// 设备类型type 从获取设备升级信息接口 getFirmwareUpgradeInfo 返回的类型
	// TuyaSmartFirmwareUpgradeModel - type

	[self.device upgradeFirmware:type success:^{
		NSLog(@"upgradeFirmware success");
	} failure:^(NSError *error) {
		NSLog(@"upgradeFirmware failure: %@", error);
	}];
}
```

#### Callback interface:
```objc
- (void)deviceFirmwareUpgradeSuccess:(TuyaSmartDevice *)device type:(NSInteger)type {
	//固件升级成功
}

- (void)deviceFirmwareUpgradeFailure:(TuyaSmartDevice *)device type:(NSInteger)type {
	//固件升级失败
}

- (void)device:(TuyaSmartDevice *)device firmwareUpgradeProgress:(NSInteger)type progress:(double)progress {
	//固件升级的进度
}
```


### Get historical statistics of DP

Get history data of DP such as battery and other information.

#### Get all historical statistics of DP

```objc
_request = [[TuyaSmartRequest alloc] init];

[_request requestWithApiName:@"m.smart.dp.his.stat.get.all" postData:@{@"devId":@"your_devId", @"dpId":@"device_dpId"} version:@"1.0" success:^(id result) {

} failure:^(NSError *error) {

}];

```

#### Get historical statistics of DP for one month

```objc
_request = [[TuyaSmartRequest alloc] init];

[_request requestWithApiName:@"m.smart.dp.his.stat.get.month" postData:@{@"devId":@"your_devId", @"month":@"201809", @"dpId":@"device_dpId"} version:@"1.0" success:^(id result) {

} failure:^(NSError *error) {

}];
```
