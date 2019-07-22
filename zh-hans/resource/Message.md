消息中心相关的所有功能对应`TuyaSmartMessage`类，支持获取消息列表，批量删除消息，以及是否有消息更新。

### 获取消息列表

Objc:

```objc
- (void)getMessageList {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageList:^(NSArray<TuyaSmartMessageListModel *> *list) {
		NSLog(@"get message list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get message list failure:%@", error);
	}];
}
```
Swift:

```swift
func getMessageList() {
    smartMessage?.getList({ (list) in
        print("get message list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get message list failure: \(e)")
        }
    })
}
```



### 删除消息

批量删除消息，`messgeIdList`是要删除消息的id数组，消息id可以从消息列表中获取。
Objc:

```objc
- (void)deleteMessage {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
    [self.smartMessage deleteMessage:(NSArray <NSString *> *)messgeIdList success:^{
		NSLog(@"delete message success");
    } failure:^(NSError *error) {
    	NSLog(@"delete message failure:%@", error);
    }];
}
```
Swift:

```swift
func deleteMessage() {
    smartMessage?.delete(["messgeIdList"], success: {
        print("delete message success")
    }, failure: { (error) in
        if let e = error {
            print("delete message failure: \(e)")
        }
    })
}
```



### 获取最新一条消息的时间戳

获取最新一条消息的时间戳，可以用于与本地最新一条消息的时间戳比较，大于本地最新消息时间，则展示红点，表示有新消息。

Objc:

```objc
- (void)getMessageMaxTime {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageMaxTime:^(int result) {
		NSLog(@"get message max time success:%d", result);
	} failure:^(NSError *error) {
		NSLog(@"get message max time failure:%@", error);
	}];
}
```

Swift:

```swift
func getMessageMaxTime() {
    smartMessage?.getMaxTime({ (result) in
        print("get message max time success :\(result)")
    }, failure: { (error) in
        if let e = error {
            print("get message max time failure: \(e)")
        }
    })
}
```



### 消息推送设置

#### 获取消息推送开关

消息推送开关为总开关，关闭状态下无法接收到 设备告警、家庭消息、通知消息 等任何消息

```objective-c
[[TuyaSmartSDK sharedInstance] getPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示推送开关开启
} failure:^(NSError *error) {

}];
```

#### 设置消息推送开关

 ````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setPushStatusWithStatus:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
 ````

#### 获取设备告警消息开关状态

```objective-c
[[TuyaSmartSDK sharedInstance] getDevicePushStatusWithSuccess:^(BOOL result) {
  // 当 result == YES 时，表示接收设备告警消息推送
} failure:^(NSError *error) {

}];
```

#### 设置设备告警消息开关

````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setDevicePushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
````

#### 获取家庭消息开关状态

```objective-c
[[TuyaSmartSDK sharedInstance] getFamilyPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收家庭消息推送
} failure:^(NSError *error) {

}];
```

#### 设置家庭消息开关

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setFamilyPushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```

#### 获取通知消息开关状态

```objective-c
[[TuyaSmartSDK sharedInstance] getNoticePushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收通知消息推送
} failure:^(NSError *error) {

}];
```

#### 设置通知消息开关

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setNoticePushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```
