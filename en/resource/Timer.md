## Timer task

The design idea is given in the following figure:

![Timer](./images/ios-sdk-timer.jpg)
All functions of timer task are realized by using the `TuyaSmartTimer` Class.

*Note: loops: @"0000000", 0 denotes off, and 1 denotes on. Each 0 from the left to the right denotes  Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday, respectively.*

### Add timer task

Add a timer to the required task specified by a device.

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

### Obtain status of timer task

Obtain all task modules of a specified device.

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

### Update status of timer task

Update the status of a designated task specified by a device. 0 denotes off, and 1 denotes on. 

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

### Update the status of timer

Update the status of a designated timer specified by a device. 0 denotes off, and 1 denotes on.

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

### Remove timer

Remove the timer of a task specified by a device. 

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

### Update timer

Update the timer of a task specified by a device.

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

### Obtain all timers of timer task

Obtain all timer modules of task required by a device.

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

### Obtain all timers of all timer tasks

Obtain all timer modules of task required by a device.

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