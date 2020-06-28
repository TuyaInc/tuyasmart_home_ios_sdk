## 存储卡管理

存储卡管理通过设备功能点实现，相关的功能点请在[设备功能点](https://tuyainc.github.io/tuyasmart_camera_ios_sdk_doc/zh-hans/resource/device_points.html#%E5%8A%9F%E8%83%BD%E7%82%B9%E5%B8%B8%E9%87%8F)中查看。

### 状态

在开始管理存储卡或者进行录像回放前，需要先获取存储卡的状态，如果设备未检测到存储卡，则无法进行下一步。如果存储卡异常，则需要先格式化存储卡。

**TuyaSmartCameraSDCardStatus 枚举**

| 枚举值                                | 说明                   |
| ------------------------------------- | ---------------------- |
| TuyaSmartCameraSDCardStatusNormal     | 存储卡正常使用中       |
| TuyaSmartCameraSDCardStatusException  | 存储卡异常，需要格式化 |
| TuyaSmartCameraSDCardStatusMemoryLow  | 存储卡内存不足         |
| TuyaSmartCameraSDCardStatusFormatting | 存储卡正在格式化       |
| TuyaSmartCameraSDCardStatusNone       | 设备未检测到存储卡     |



### 格式化

在格式化存储卡的时候，根据摄像机厂商的实现，有两种情况。有些厂商实现的固件中，会主动上报格式化的进度，格式化完成后也会主动上报当前的容量状态，但是有少部分厂商的固件，不会主动上报，所以需要定时主动去查询格式化的进度，当进度达到 100 时，再主动去查询当前的容量状态，需要使用下面的接口查询功能点的值：

```objc
- (void)valueForDP:(TuyaSmartCameraDPKey)dpName success:(TYSuccessID)success failure:(TYFailureError)failure;
```

存储卡容量的功能点，值的字符串格式是“总容量|已使用|空闲”，单位是`kB`。

### 存储卡录制

涂鸦摄像机在插入存储卡后，可以将采集的影像录制保存在存储卡中，可以通过 SDK 设置视频录制开关和模式。录制模式分为以下两种：

* **连续录制**：摄像机会将采集到的音视频连续不断的录制保存在存储卡中，存储卡的容量不足的时候，将会覆盖最早录制的视频数据。
* **事件录制**：摄像机只会在触发侦测报警的时候才会开始录制视频，视频的长短会根据事件类型，和事件持续时间而变化。

### 示例代码

ObjC

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取存储卡状态
    [self.dpManager valueForDP:TuyaSmartCameraSDCardStatusDPName success:^(id result) {
        [self checkStatus:[result integerValue]];
    } failure:^(NSError *error) {
        
    }];
}

- (void)changeToEventRecordMode {
  	// 判断摄像机是否支持存储卡录像
    if (![self.dpManager isSupportDP:TuyaSmartCameraSDCardRecordDPName]) {
        return;
    }
    BOOL isRecordOn = [[self.dpManager valueForDP:TuyaSmartCameraSDCardRecordDPName] boolValue];
  	// 如果存储卡录像已经开启，并且支持录像模式设置
    if (isRecordOn && [self.dpManager isSupportDP:TuyaSmartCameraRecordModeDPName]) {
        TuyaSmartCameraRecordMode recordMode = [self.dpManager valueForDP:TuyaSmartCameraRecordModeDPName];
      	// 如果当前的录像模式是连续录像
        if (recordMode == TuyaSmartCameraRecordModeAlways) {
          	// 设置为事件录像模式
            [self.dpManager setValue:TuyaSmartCameraRecordModeEvent forDP:TuyaSmartCameraRecordModeDPName success:^(id result) {
                NSLog(@"当前的存储卡录像模式是：%@", result);
            } failure:^(NSError *error) {
                // 网络错误
            }];
        }
    }
}

- (void)checkStatus:(TuyaSmartCameraSDCardStatus)status {
    if (status == TuyaSmartCameraSDCardStatusNone) {
      	// 未检测到存储卡
        return;
    }else if (status == TuyaSmartCameraSDCardStatusException) {
      	// 存储卡异常，开始格式化
        [self formatAction];
    }else if (status == TuyaSmartCameraSDCardStatusFormatting) {
      	// 存储卡正在格式化
        [self handleFormatting];
    }else {
      	// 获取存储卡容量信息
        [self getStorageInfo];
      	// 设置录像模式为事件录像
      	[self changeToEventRecordMode];
    }
}

- (void)formatAction {
    __weak typeof(self) weakSelf = self;
    [self.dpManager setValue:@(YES) forDP:TuyaSmartCameraSDCardFormatDPName success:^(id result) {
      	// 开始格式化成功，监听格式化进度
        [weakSelf handleFormatting];
    } failure:^(NSError *error) {
        // 网络错误
    }];
}

- (void)handleFormatting {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	      // 主动查询格式化进度，因为部分厂商的设备不会自动上报进度
        int status = [self getFormatStatus];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status >= 0 && status < 100) {
                [self performSelector:@selector(handleFormatting) withObject:nil afterDelay:2.0];
            } else if (status == 100) {
              	// 格式化成功后，主动获取设备的容量信息
                [self getStorageInfo];
            } else {
								//格式化失败
            }
        });
    });
}

- (int)getFormatStatus {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block int status = -1;
    [self.dpManager valueForDP:TuyaSmartCameraSDCardFormatStateDPName success:^(id result) {
        status = [result intValue];
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSError *error) {
        dispatch_semaphore_signal(semaphore);
    }];
    //大SD卡格式化上报比较慢，超时时间设置5分钟
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 300.0f * NSEC_PER_SEC));
    return status;
}

- (void)getStorageInfo {
    __weak typeof(self) weakSelf = self;
    [self.dpManager valueForDP:TuyaSmartCameraSDCardStorageDPName success:^(id result) {
        NSArray *components = [result componentsSeparatedByString:@"|"];
        if (components.count < 3) {
          	// 数据异常
            return;
        }
      	// 总容量
        weakSelf.total = [[components firstObject] integerValue];
      	// 已使用
        weakSelf.used = [[components objectAtIndex:1] integerValue];
      	// 空闲
        weakSelf.left = [[components lastObject] integerValue];
    } failure:^(NSError *error) {
        // 网络错误
    }];
}
```

Swift

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    // 获取存储卡状态
    self.dpManager.value(forDP: .sdCardStatusDPName, success: { result in
        self.checkStatus(status: TuyaSmartCameraSDCardStatus(rawValue: result as! UInt)!)
    }) { _ in
        // 网络错误
    }
}

func checkStatus(status: TuyaSmartCameraSDCardStatus) {
    switch status {
    case .exception:
        // 存储卡异常，开始格式化
        self.formatSDCard()
        break
    case .formatting:
        // 存储卡正在格式化
        self.handleFormatting()
        break
    case .none:
        // 未检测到存储卡
        return
    default:
        // 获取存储卡容量信息
        self.getStorageInfo()
        // 设置录像模式为事件录像
        self.changeToEventRecordMode()
    }
}

func formatSDCard() {
    self.dpManager.setValue(true, forDP: .sdCardFormatDPName, success: { [weak self] _ in
        // 开始格式化成功，监听格式化进度
        self?.handleFormatting()
    }) { _ in
        // 网络错误
    }
}

func handleFormatting() {
    DispatchQueue.global().async {
        // 主动查询格式化进度，因为部分厂商的设备不会自动上报进度
        let status = self.getFormatStatus()
        DispatchQueue.main.async {
            if status >= 0, status < 100 {
                self.handleFormatting()
            }else if status == 100 {
                // 格式化成功后，主动获取设备的容量信息
                self.getStorageInfo()
            }else {
                // 格式化失败
            }
        }
    }
}

func getFormatStatus() -> Int {
    let semaphore = DispatchSemaphore.init(value: 0)
    var status = -1
    self.dpManager.value(forDP: .sdCardFormatStateDPName, success: { result in
        status = result as! Int
        semaphore.signal()
    }) { _ in
        semaphore.signal()
    }
    // 大SD卡格式化上报比较慢，超时时间设置5分钟
    let _ = semaphore.wait(timeout: DispatchTime(uptimeNanoseconds: 300 * NSEC_PER_SEC))
    return status
}

func getStorageInfo() {
    self.dpManager.value(forDP: .sdCardStorageDPName, success: { result in
        let components = (result as! String).split(separator: "|")
        guard components.count == 3 else {
            // 数据异常
            return
        }
        // 总容量
        let total = Int(components[0])
        // 已使用
        let used = Int(components[1])
        // 空闲
        let left = Int(components[2])
    }) { _ in
        // 网络错误
    }
}

func changeToEventRecordMode() {
    // 判断摄像机是否支持存储卡录像
    guard self.dpManager.isSupportDP(.sdCardRecordDPName) else {
        return
    }
    let isRecordOn = self.dpManager.value(forDP: .sdCardRecordDPName) as! Bool
    // 如果存储卡录像已经开启，并且支持录像模式设置
    guard self.dpManager.isSupportDP(.recordModeDPName), isRecordOn else {
        return
    }

    let recordMode = self.dpManager.value(forDP: .recordModeDPName) as! String
    // 如果当前的录像模式是连续录像
    if recordMode == TuyaSmartCameraRecordMode.always.rawValue {
        // 设置为事件录像模式
        self.dpManager.setValue(TuyaSmartCameraRecordMode.event.rawValue, forDP: .recordModeDPName, success: { result in
            print("当前的录像模式是： ", result as! String)
        }) { _ in
            // 网络错误
        }
    }

}
```

