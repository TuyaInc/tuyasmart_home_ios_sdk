# Timer Task

Tuya Smart provides basic timing capabilities, and supports devices (including WiFi devices, Bluetooth mesh sub-devices and zigbee sub-devices) and groups. It is also provided with the interface for addition, deletion, change and querying of timer information for dp points of the device. After the APP sets the timer information through the timing interface, the hardware module automatically performs the scheduled operation according to the timing requirements. Multiple timers can be included in each timer task, as shown in the figure below:

![Timer](./images/ios-sdk-timer.jpg)

The taskName is used by multiple interfaces, which can be described as a group, and a group may include multiple timers. Each timer task belongs to or does not belong to a group, and the group is currently only used for presentation.

| Class          | Description                   |
| -------------- | ----------------------------- |
| TuyaSmartTimer | Device and group time feature |

## Add Timer Task

> Up to 30 timers per device or group

Add a timer to the required task specified by a device or group.

**Declaration**

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

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| task      | Task name                                                    |
| loops     | Loops: "0000000"<br />0 denotes off, and 1 denotes on. Each 0 from the left to the right denotes  Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday, respectively. |
| devId     | Device id，if group, set group id                            |
| time      | Time 18:00                                                   |
| dps       | Dps command                                                  |
| timeZone  | The time zone of the device or group, like +08:00            |
| success   | Success block                                                |
| failure   | Failure block                                                |

**Example**

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

## Obtain Status of Timer Task

Obtain all task modules of a specified device.

**Declaration**

```objective-c
- (void)getTimerTaskStatusWithDeviceId:(NSString *)devId
                               success:(void(^)(NSArray<TYTimerTaskModel *> *list))success
                               failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| devId     | Device id，if grouo, set group id |
| success   | Success block                     |
| failure   | Failure block                     |

**`TYTimerTaskModel` ** Description

| Field    | Type      | Description                  |
| -------- | --------- | ---------------------------- |
| taskName | NSString  | Timer task name              |
| status   | NSInteger | Task status，0:close, 1:open |

**Example**

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



## Update the Status of Timer

Update the status of a designated timer specified by a device. 0 denotes off, and 1 denotes on.

**Declaration**

```objective-c
- (void)updateTimerStatusWithTask:(NSString *)task
                            devId:(NSString *)devId
                          timerId:(NSString *)timerId
                           status:(NSInteger)status
                          success:(TYSuccessHandler)success
                          failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| task      | Timer task name                   |
| devId     | Device id，if grouo, set group id |
| timerId   | Timer id                          |
| status    | Task status，0:close, 1:open      |
| success   | Success block                     |
| failure   | Failure block                     |

**Example**

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

## Remove Timer

Remove the timer of a task specified by a device. 

**Declaration**

```objective-c
- (void)removeTimerWithTask:(NSString *)task
                      devId:(NSString *)devId
                    timerId:(NSString *)timerId
                    success:(TYSuccessHandler)success
                    failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| task      | Timer task name                   |
| devId     | Device id，if grouo, set group id |
| timerId   | Timer id                          |
| success   | Success block                     |
| failure   | Failure block                     |

**Example**

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

## Update Timer

Update the timer of a task specified by a device.

**Declaration**

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

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| task      | Timer task name                                              |
| loops     | Loops: "0000000"<br />0 denotes off, and 1 denotes on. Each 0 from the left to the right denotes  Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday, respectively. |
| devId     | Device id，if grouo, set group id                            |
| timerId   | Timer id                                                     |
| time      | Time，如 18:00                                               |
| dps       | Dps command                                                  |
| timeZone  | The time zone of the device or group, like +08:00            |
| success   | Success block                                                |
| failure   | Failure block                                                |

**Example**

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

## Obtain All Timers of Timer Task

Obtain all timer modules of task required by a device.

**Declaration**

```objective-c
- (void)getTimerWithTask:(NSString *)task
                   devId:(NSString *)devId
                 success:(void(^)(NSArray<TYTimerModel *> *list))success
                 failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| task      | Timer task name                   |
| devId     | Device id，if grouo, set group id |
| success   | Success block                     |
| failure   | Failure block                     |

**Example**

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

## Obtain All Timers of All Timer Tasks

Obtain all timer modules of task required by a device.

**Declaration**

```objective-c
- (void)getAllTimerWithDeviceId:(NSString *)devId
                        success:(TYSuccessDict)success
                        failure:(TYFailureError)failure
```

**Example**

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