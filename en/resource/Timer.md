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
                   bizId:(NSString *)bizId
                 bizType:(NSUInteger)bizType
                    time:(NSString *)time
                     dps:(NSDictionary *)dps
                  status:(BOOL)status
               isAppPush:(BOOL)isAppPush
               aliasName:(NSString *)aliasName
                 success:(TYSuccessHandler)success
                 failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| task      | Task name                                                    |
| loops     | Loops: "0000000"<br />0 denotes off, and 1 denotes on. Each 0 from the left to the right denotes  Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday, respectively. |
| bizId     | Device id，if group, set group id                            |
| bizType | 0:device;  1:group |
| time      | Time 18:00                                                   |
| dps       | Dps command                                                  |
| status | timer open status |
| isAppPush	| Is support push message after the timer executed |
| aliasName	| The timer remark name |
| success   | Success block                                                |
| failure   | Failure block                                                |

**Example**

Objc:

```objc
- (void)addTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	  NSDictionary *dps = @{@"1": @(YES)};
    [self.timer addTimerWithTask:@"timer_task_name" loops:@"1000000" bizId:@"device_id" bizType:0 time:@"18:00"  dps:dps status:YES isAppPush:YES aliasName:@"timer for device xxx" success:^{
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
    self.timer.add(withTask: "timer_task_name", loops: "1000000", bizId: "device_id", bizType: 0, time: "18:00", dps: dps, status: true, isAppPush: true, aliasName: "timer for device xxx") {
        print("addTimerWithTask success")
    } failure: { (error) in
        if let e = error {
            print("addTimerWithTask failure: \(e)")
        }
    }
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
- (void)updateTimerStatusWithTimerId:(NSString *)timerId
                               bizId:(NSString *)bizId
                             bizType:(NSUInteger)bizType
                              status:(BOOL)status
                             success:(TYSuccessHandler)success
                             failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| timerId   | Timer id                          |
| bizId     | Device id，if group, set group id                            |
| bizType | 0:device;  1:group |
| status    | Task status，0:close, 1:open      |
| success   | Success block                     |
| failure   | Failure block                     |

**Example**

Objc:

```objc
- (void)updateTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];

    [self.timer updateTimerStatusWithTimerId:@"timer_id" bizId:@"device_id" bizType:0 status:NO success:^{
        NSLog(@"updateTimer success");
    } failure:^(NSError *error) {
        NSLog(@"updateTimer failure: %@", error);
    }];
}
```

Swift:

```swift
func updateTimer() {

    self.timer.updateTimerStatus(withTimerId: "timer_id", bizId: "device_id", bizType: 0, status: false) {
        print("updateTimer success")
    } failure: { (error) in
        if let e = error {
            print("updateTimer failure: \(e)")
        }
    }
}
```

## Remove Timer

Remove the timer of a task specified by a device. 

**Declaration**

```objective-c
- (void)removeTimerWithTimerId:(NSString *)timerId
                         bizId:(NSString *)bizId
                       bizType:(NSUInteger)bizType
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| timerId   | Timer id                          |
| bizId     | Device id，if group, set group id                            |
| bizType | 0:device;  1:group |
| success   | Success block                     |
| failure   | Failure block                     |

**Example**

Objc:

```objc
- (void)removeTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	
    [self.timer removeTimerWithTimerId:@"timer_id" bizId:@"device_id" bizType:0 success:^{
        NSLog(@"removeTimer success");
    } failure:^(NSError *error) {
        NSLog(@"removeTimer failure: %@", error);
    }];
}
```

Swift:

```swift
func removeTimer() {

    self.timer.removeTimer(withTimerId: "timer_id", bizId: "device_id", bizType: 0) {
        print("removeTimer success")
    } failure: { (error) in
        if let e = error {
            print("removeTimer failure: \(e)")
        }
    }
}
```

## Update Timer

Update the timer of a task specified by a device.

**Declaration**

```objective-c
- (void)updateTimerWithTimerId:(NSString *)timerId
                         loops:(NSString *)loops
                         bizId:(NSString *)bizId
                       bizType:(NSUInteger)bizType
                          time:(NSString *)time
                           dps:(NSDictionary *)dps
                        status:(BOOL)status
                     isAppPush:(BOOL)isAppPush
                     aliasName:(NSString *)aliasName
                       success:(TYSuccessHandler)success
                       failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                                                  |
| --------- | ------------------------------------------------------------ |
| timerId   | Timer id                                                     |
| loops     | Loops: "0000000"<br />0 denotes off, and 1 denotes on. Each 0 from the left to the right denotes  Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday, respectively. |
| bizId     | Device id，if group, set group id                            |
| bizType | 0:device;  1:group |
| time      | Time， 18:00                                               |
| dps       | Dps command                                                  |
| status  | Timer status |
| isAppPush | Is support push message after the timer executed             |
| aliasName | The timer remark name                                        |
| success   | Success block                                                |
| failure   | Failure block                                                |

**Example**

Objc:

```objc
- (void)updateTimer {
	// self.timer = [[TuyaSmartTimer alloc] init];
	NSDictionary *dps = @{@"1": @(YES)};
	
    [self.timer updateTimerWithTimerId:@"timer_id" loops:@"1000000" bizId:@"device_id" bizType:0 time:@"18:00" dps:dps status:YES isAppPush:YES aliasName:@"timer for device xxx" success:^{
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
    self.timer.updateTimer(withTimerId: "timer_id", loops: "1000000", bizId: "device_id", bizType: 0, time: "18:00", dps: dps, status: true, isAppPush: true, aliasName: "timer for device xxx") {
        print("updateTimer success")
    } failure: { (error) in
        if let e = error {
            print("updateTimer failure: \(e)")
        }
    }
}
```

## Obtain All Timers of Timer Task

Obtain all timer modules of task required by a device.

**Declaration**

```objective-c
- (void)getTimerListWithTask:(NSString *)task
                       bizId:(NSString *)bizId
                     bizType:(NSUInteger)bizType
                     success:(void(^)(NSArray<TYTimerTaskModel *> *list))success
                     failure:(TYFailureError)failure;
```

**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| task      | Timer task name                   |
| bizId     | Device id，if group, set group id                            |
| bizType | 0:device;  1:group |
| success   | Success block                     |
| failure   | Failure block                     |

**Example**

Objc:

```objc
- (void)getTimer {
	  // self.timer = [[TuyaSmartTimer alloc] init];

    [self.timer getTimerListWithTask:@"timer_task_name" bizId:@"device_id" bizType:0 success:^(NSArray<TYTimerModel *> *list) {
        NSLog(@"getTimer success %@:", list);
    } failure:^(NSError *error) {
        NSLog(@"getTimer failure: %@", error);
    }];
}
```

Swift:

```swift
func getTimer() {

    self.timer.getListWithTask("timer_task_name", bizId: "device_id", bizType: 0, success: { (list) in
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