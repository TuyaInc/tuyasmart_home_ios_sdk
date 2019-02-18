#### 定时任务



设计思路如下图所示：

![Timer](./images/ios-sdk-timer.jpg)

定时任务相关的所有功能对应`TuyaSmartTimer`类。

_注：loops: @"0000000", 每一位 0:关闭,1:开启, 从左至右依次表示: 周日 周一 周二 周三 周四 周五 周六_

### 增加定时任务

增加一个timer到指定device的指定task下

Objc:

```objc
- (void)addTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	NSDictionary *dps = @{@"1": @(YES)};
	
	[self.timer addTimerWithTask:@"timer_task_name" loops:@"1000000" devId:@"device_id" time:@"18:00" dps:dps timeZone:@"+08:00" success:^{
		NSLog(@"addTimerWithTask success");
	} failure:^(NSError *error) {
		NSLog(@"addTimerWithTask failure: %@", error);
	}];
}
```

Swift:

```swift
func addTimer() {
    let dps = ["1" : true]
    timer?.add(withTask: "timer_task_name", loops: "1000000", devId: "device_id", time: "18:00", dps: dps, timeZone: "+08:00", success: {
        print("addTimerWithTask success")
    }, failure: { (error) in
        if let e = error {
            print("addTimerWithTask failure: \(e)")
        }
    })
}
```



### 获取定时任务状态

获取指定device下所有task模型

Objc:

```objc
- (void)getTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	
	[self.timer getTimerTaskStatusWithDeviceId:@"device_id" success:^(NSArray<TPTimerTaskModel *> *list) {
		NSLog(@"getTimer success %@:", list);
	} failure:^(NSError *error) {
		NSLog(@"getTimer failure: %@", error);
	}];
}
```

Swift:

```swift
func getTimer() {
    timer?.getTaskStatus(withDeviceId: "device_id", success: { (list) in
        print("getTimer success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("getTimer failure: \(e)")
        }
    })
}
```



### 更新定时任务状态

更新指定device下的指定task的状态 0:关闭,1:开启

Objc:

```objc
- (void)updateTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	
	[self.timer updateTimerTaskStatusWithTask:@"timer_task_name" devId:@"device_id" status:1 success:^{
		NSLog(@"updateTimer success");
	} failure:^(NSError *error) {
		NSLog(@"updateTimer failure: %@", error);
	}];
}
```

Swift:

```swift
func updateTimer() {

    timer?.updateTaskStatus(withTask: "timer_task_name", devId: "device_id", status: 1, success: {
        print("updateTimer success")
    }, failure: { (error) in
        if let e = error {
            print("updateTimer failure: \(e)")
        }
    })
}
```



### 更新定时钟状态

更新指定device下的指定task下的指定timer的状态 0:关闭,1:开启

Objc:

```objc
- (void)updateTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];

	[self.timer updateTimerStatusWithTask:@"timer_task_name" devId:@"device_id" timerId:@"timer_id" status:1 success:^{
		NSLog(@"updateTimer success");
	} failure:^(NSError *error) {
		NSLog(@"updateTimer failure: %@", error);
	}];
}
```

Swift:

```swift
func updateTimer() {

    timer?.updateStatus(withTask: "timer_task_name", devId: "device_id", timerId: "timerID", status: 1, success: {
        print("updateTimer success")
    }, failure: { (error) in
        if let e = error {
            print("updateTimer failure: \(e)")
        }
    })
}
```



### 删除定时钟

删除指定device下的指定task下的指定timer

Objc:

```objc
- (void)removeTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	
	[self.timer removeTimerWithTask:@"timer_task_name" devId:@"device_id" timerId:@"timer_id" success:^{
		NSLog(@"removeTimer success");
	} failure:^(NSError *error) {
		NSLog(@"removeTimer failure: %@", error);
	}];
}
```

Swift:

```swift
func removeTimer() {

    timer?.remove(withTask: "timer_task_name", devId: "device_id", timerId: "timer_id", success: {
        print("removeTimer success")
    }, failure: { (error) in
        if let e = error {
            print("removeTimer failure: \(e)")
        }
    })
}
```



### 更新定时钟

更新指定device下的指定task下的指定timer

Objc:

```objc
- (void)updateTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	NSDictionary *dps = @{@"1": @(YES)};
	
	[self.timer updateTimerWithTask:@"timer_task_name" loops:@"1000000" devId:@"device_id" timerId:@"timer_id" time:@"18:00" dps:dps timeZone:@"+08:00" success:^{
		NSLog(@"updateTimer success");
	} failure:^(NSError *error) {
		NSLog(@"updateTimer failure: %@", error);
	}];
}
```

Swift:

```swift
func updateTimer() {
    let dps = ["1" : true]
    timer?.update(withTask: "timer_task_name", loops: "1000000", devId: "device_id", timerId: "timer_id", time: "18:00", dps: dps, timeZone: "+08:00", success: {
        print("updateTimer success")
    }, failure: { (error) in
        if let e = error {
            print("updateTimer failure: \(e)")
        }
    })
}
```



### 获取定时任务下所有定时钟

获取指定device下的指定task下所有timer模型

Objc:

```objc
- (void)getTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];

	[self.timer getTimerWithTask:@"timer_task_name" devId:@"device_id" success:^(NSArray<TPTimerModel *> *list) {
		NSLog(@"getTimer success %@:", list); 
	} failure:^(NSError *error) {
		NSLog(@"getTimer failure: %@", error);
	}];
}
```

Swift:

```swift
func getTimer() {

    timer?.getWithTask("timer_task_name", devId: "device_id", success: { (list) in
        print("getTimer success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("getTimer failure: \(e)")
        }
    })
}
```



### 获取设备所有定时任务下所有定时钟

获取指定device下所有task下所有timer模型

Objc:

```objc
- (void)getTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];

	[self.timer getAllTimerWithDeviceId:@"device_id" success:^(NSDictionary *dict) {
		NSLog(@"getTimer success %@:", dict); 
	} failure:^(NSError *error) {
		NSLog(@"getTimer failure: %@", error);
	}];
}
```

Swift:

```swift
func getTimer() {

    timer?.getAllTimer(withDeviceId: "device_id", success: { (dict) in
        print("getTimer success: \(dict)")
    }, failure: { (error) in
        if let e = error {
            print("getTimer failure: \(e)")
        }
    })
}
```

