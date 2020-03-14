#定时任务

`TuyaSmartTimerKit` 提供设置**设备**与**群组**定时执行动作的功能

## 设计思路

以设备为例，定时的设计思路如下图所示:

![Timer](./images/ios-sdk-timer.jpg)



| 类名           | 说明             |
| -------------- | ---------------- |
| TuyaSmartTimer | 定时任务接口封装 |

## 增加定时任务

> 每个设备或群组定时的上限为 30 个

为 device 或 group 新增一个定时 timer 到指定的 task 下

**接口说明**

```objective-c
- (void)addTimerWithTask:(NSString *)task
                   loops:(NSString *)loops
                   devId:(NSString *)devId
                    time:(NSString *)time
                     dps:(NSDictionary *)dps
                timeZone:(NSString *)timeZone
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明     |
| -------- | -------- |
| task     | 定时任务名称 |
| loops    | 循环次数，格式 "0000000"<br />每一位 0:关闭, 1:开启, 从左至右依次表示: 周日 周一 周二 周三 周四 周五 周六<br />如每个周一: 0100000 |
| devId    | 设备 id，如果是群组传群组 id |
| time     | 定时的时间，如 18:00 |
| dps      | dps 命令 |
| timeZone | 要设置的设备或群组的时区，格式如 +08:00，如果没有传手机时区 |
| success  | 成功回调  |
| failure | 失败回调 |

**示例代码**

Objc:

```objc
- (void)addTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	NSDictionary *dps = @{@"1": @(YES)};
	[self.timer addTimerWithTask:@"timer_task_name"
                         loops:@"1000000" 
                         devId:@"device_id"
                          time:@"18:00" 
                           dps:dps
                      timeZone:@"+08:00"
                       success:^{
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



## 获取定时任务状态

获取 device 或群组下所有 task 定时任务

**接口说明**

```objective-c
- (void)getTimerTaskStatusWithDeviceId:(NSString *)devId
                               success:(void(^)(NSArray<TYTimerTaskModel *> *list))success
                               failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                         |
| ------- | ---------------------------- |
| devId   | 设备 id，如果是群组传群组 id |
| success | 成功回调，获取的定时任务数组 |
| failure | 失败回调                     |

**`TYTimerTaskModel` 模型说明**

| 字段名   | 类型      | 说明                    |
| -------- | --------- | ----------------------- |
| taskName | NSString  | 定时任务名              |
| status   | NSInteger | 任务状态，0:关闭,1:开启 |

**示例代码**

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



## 更新定时任务状态

更新 device 或群组下对应 task 定时任务状态

**接口说明**

```objective-c
- (void)updateTimerTaskStatusWithTask:(NSString *)task
                                devId:(NSString *)devId
                               status:(NSInteger)status
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                         |
| ------- | ---------------------------- |
| task    | 任务名称                     |
| devId   | 设备 id，如果是群组传群组 id |
| status  | 任务状态，0:关闭,1:开启      |
| success | 成功回调                     |
| failure | 失败回调                     |

**示例代码**

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



## 更新定时钟状态

更新 device 或群组下指定 task 下的指定 timer 的状态

**接口说明**

```objective-c
- (void)updateTimerStatusWithTask:(NSString *)task
                            devId:(NSString *)devId
                          timerId:(NSString *)timerId
                           status:(NSInteger)status
                          success:(TYSuccessHandler)success
                          failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                         |
| ------- | ---------------------------- |
| task    | 任务名称                     |
| devId   | 设备 id，如果是群组传群组 id |
| timerId | 更新的 timer id              |
| status  | 定时状态，0:关闭,1:开启      |
| success | 成功回调                     |
| failure | 失败回调                     |

**示例代码**

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



## 删除定时钟

删除 device 或群组下指定 task 下的指定 timer

**接口说明**

```objective-c
- (void)removeTimerWithTask:(NSString *)task
                      devId:(NSString *)devId
                    timerId:(NSString *)timerId
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                         |
| ------- | ---------------------------- |
| task    | 任务名称                     |
| devId   | 设备 id，如果是群组传群组 id |
| timerId | 删除的 timer id              |
| success | 成功回调                     |
| failure | 失败回调                     |

**示例代码**

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



## 更新定时钟

更新 device 或群组下指定 task 下的指定 timer 信息

**接口说明**

```objective-c
- (void)updateTimerWithTask:(NSString *)task
                      loops:(NSString *)loops
                      devId:(NSString *)devId
                    timerId:(NSString *)timerId
                       time:(NSString *)time
                        dps:(NSDictionary *)dps
                   timeZone:(NSString *)timeZone
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;
```

**参数说明**

| 参数     | 说明                                                         |
| -------- | ------------------------------------------------------------ |
| task     | 定时任务名称                                                 |
| loops    | 循环次数，格式 "0000000"<br />每一位 0:关闭, 1:开启, 从左至右依次表示: 周日 周一 周二 周三 周四 周五 周六<br />如每个周一: 0100000 |
| devId    | 设备 id，如果是群组传群组 id                                 |
| timerId | 更新的 timer id              |
| time     | 定时的时间，如 18:00                                         |
| dps      | dps 命令                                                |
| timeZone | 要设置的设备或群组的时区，格式如 +08:00，如果没有传手机时区  |
| success  | 成功回调                                                     |
| failure  | 失败回调                                                     |

**示例代码**

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



## 获取定时任务下所有定时钟

获取 device 或群组下指定的 task 下的定时 timer

**接口说明**

```objective-c
- (void)getTimerWithTask:(NSString *)task
                   devId:(NSString *)devId
                 success:(void(^)(NSArray<TYTimerModel *> *list))success
                 failure:(TYFailureError)failure;
```

**参数说明**

| 参数    | 说明                         |
| ------- | ---------------------------- |
| task     | 定时任务名称                 |
| devId   | 设备 id，如果是群组传群组 id |
| success | 成功回调，timer 数组         |
| failure | 失败回调                     |

**示例代码**

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



## 获取设备所有定时任务下所有定时钟

获取 device 或群组下所有的 task 下的定时 timer

**接口说明**

```objective-c
- (void)getAllTimerWithDeviceId:(NSString *)devId
                        success:(TYSuccessDict)success
                        failure:(TYFailureError)failure
```

**示例代码**

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

