# Timer Task

Tuya Smart provides basic timing capabilities, and supports devices (including WiFi devices, Bluetooth mesh sub-devices and zigbee sub-devices) and groups. It is also provided with the interface for addition, deletion, change and querying of timer information for dp points of the device. After the APP sets the timer information through the timing interface, the hardware module automatically performs the scheduled operation according to the timing requirements. Multiple timers can be included in each timer task, as shown in the figure below:

![Timer](./images/ios-sdk-timer.jpg)

The taskName is used by multiple interfaces, which can be described as a group, and a group may include multiple timers. Each timer task belongs to or does not belong to a group, and the group is currently only used for presentation.

| Class          | Description                   |
| -------------- | ----------------------------- |
| TuyaSmartTimer | Device and group time feature |

## Version Imprint

A new set of timing interfaces has been added from version 3.18.0 to solve the problems of the old interface, see [Old version interface](https://github.com/TuyaInc/tuyasmart_home_ios_sdk_doc/blob/feature/doc_standard/en/resource/Timer.md)

The new timer apis are all in `TuyaSmartTimer.h`,

The old time apis are in `TuyaSmartTimer+TYDeprecatedApi.h`

Compared with the old version of the interface, the new version of the interface has the following updates:

- Add or update the timer interface to set the timer switch state

- Provide interface for batch modification of timer status
- Fix the problem of the failure of the old version to close the timer categories
- Provide category timers delete function

**Upgrade suggestion**

The old interface is no longer maintained, and it is recommended to upgrade to the new interface. The upgrade needs to replace the entire set of timing interfaces. Using the old version of the interface to set the timing can still be obtained through the new version of the timer list.

## Add Timer Task

**Declaration**

Up to 30 timers per device or group

Add a timer to the required task specified by a device or group.

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

## Batch Modify Common Timers Status or Delete Timer

**Declaration**

```objective-c
- (void)updateTimerStatusWithTimerIds:(NSArray<NSString *> *)timerIds
                                bizId:(NSString *)bizId
                              bizType:(NSUInteger)bizType
                           updateType:(int)updateType
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;
```

**Parameters**

| Parameter  | Description                       |
| ---------- | --------------------------------- |
| timerIds   | Timer id list                     |
| bizId      | Device id，if group, set group id |
| bizType    | 0:device;  1:group                |
| updateType | 0: close 1: open 2:delete         |
| success    | Success block                     |
| failure    | Failure block                     |

**Example**

Objc:

```objective-c
    [self.timer updateTimerStatusWithTimerIds:@[@"2222", @"timer_id2"] bizId:@"device_id" bizType:0 updateType:1 success:^{
        NSLog(@"updateTimer success");
    } failure:^(NSError *error) {
        NSLog(@"updateTimer failure: %@", error);
    }];
    
```

Swift:

```swift
    self.timer.updateTimerStatus(withTimerIds: ["232323", "233"], bizId: "device_id", bizType: 0, updateType: 1) {
        print("updateTimer success")
    } failure: { (error) in
        if let e = error {
            print("updateTimer failure: \(e)")
        }
    }
```

## Update Timer

**Declaration**

Update the timer of a task specified by a device.

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

**Declaration**

Obtain all timer modules of task required by a device.

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

## Modify the Status of All Scheduled Tasks Under the Category or Delete the Timer

**Declaration**

```objective-c
- (void)updateTimerTaskStatusWithTask:(NSString *)task
                                bizId:(NSString *)bizId
                              bizType:(NSUInteger)bizType
                           updateType:(NSUInteger)updateType
                              success:(TYSuccessHandler)success
                              failure:(TYFailureError)failure;
```
**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| task      | Timer task name                   |
| bizId     | Device id，if group, set group id                            |
| bizType | 0:device;  1:group |
| updateType |0: close 1: open 2:delete   |
| success   | Success block                     |
| failure   | Failure block                     |


**Example**

Objc:

```objc
- (void)updateTimerTask {
	  // self.timer = [[TuyaSmartTimer alloc] init];

    [self.timer updateTimerTaskStatusWithTask:@"timer_task_name" bizId:@"device_id" bizType:0 updateType:1 success:^{
        NSLog(@"updateTimer success");
    } failure:^(NSError *error) {
        NSLog(@"updateTimer failure: %@", error);
    }];
}
```

Swift:

```swift
func updateTimerTask() {
    self.timer.updateTaskStatus(withTask: "timer_task_name", bizId: "device_id", bizType: 0, updateType: 1) {
        print("updateTimer success: \(list)")
    } failure: { (error) in
         if let e = error {
            print("updateTimer failure: \(e)")
        }   
    }
}
```