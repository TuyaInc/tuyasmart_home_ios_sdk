## Memory card management

Mmemory card management use data point, for related data point refer to [Data point id](https://tuyainc.github.io/tuyasmart_camera_ios_sdk_doc/en/resource/device_points.html#data-point-id).

### Status

Before starting to manage the memory card, you need to obtain the status of the memory card. If the device does not detect the memory card, you cannot proceed to the next step. If the memory card is abnormal, you need to format the memory card first.

**enum TuyaSmartCameraSDCardStatus**

| Value                                 | Description                                       |
| ------------------------------------- | ------------------------------------------------- |
| TuyaSmartCameraSDCardStatusNormal     | Memory card is normal working                     |
| TuyaSmartCameraSDCardStatusException  | Memory card is abnormal and needs to be formatted |
| TuyaSmartCameraSDCardStatusMemoryLow  | Memory card is low on memory                      |
| TuyaSmartCameraSDCardStatusFormatting | Memory card is being formatted                    |
| TuyaSmartCameraSDCardStatusNone       | The device did not detect the memory card         |



### Format

When formatting the memory card, there are two cases according to the implementation of the camera manufacturer. The firmware implemented by some manufacturers will actively report the progress of formatting, and will also actively report the current capacity status after formatting is completed. However, there are a few manufacturers' firmware that will not actively report, so it is necessary to periodically and actively query the formatting progress, when the progress reaches 100, and then actively query the current capacity status, you need to use the following interface to query the value of the function point:

```objc
- (void)valueForDP:(TuyaSmartCameraDPKey)dpName success:(TYSuccessID)success failure:(TYFailureError)failure;
```

### Memory card recording

After the Tuya camera is inserted into the memory card, the captured image recording can be saved in the memory card, and the video recording switch and mode can be set through the SDK. There are two recording modes:

* **Continuous recording**: The camera will continuously record the collected audio and video recordings on the memory card. When the capacity of the memory card is insufficient, the oldest recorded video data will be overwritten.
* **Event recording**: The camera will only start recording video when the detection alarm is triggered. The length of the video will change according to the type of event and the duration of the event.

### Example

ObjC

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dpManager valueForDP:TuyaSmartCameraSDCardStatusDPName success:^(id result) {
        [self checkStatus:[result integerValue]];
    } failure:^(NSError *error) {
        
    }];
}

- (void)changeToEventRecordMode {
    if (![self.dpManager isSupportDP:TuyaSmartCameraSDCardRecordDPName]) {
        return;
    }
    BOOL isRecordOn = [[self.dpManager valueForDP:TuyaSmartCameraSDCardRecordDPName] boolValue];
    if (isRecordOn && [self.dpManager isSupportDP:TuyaSmartCameraRecordModeDPName]) {
        TuyaSmartCameraRecordMode recordMode = [self.dpManager valueForDP:TuyaSmartCameraRecordModeDPName];
        if (recordMode == TuyaSmartCameraRecordModeAlways) {
            [self.dpManager setValue:TuyaSmartCameraRecordModeEvent forDP:TuyaSmartCameraRecordModeDPName success:^(id result) {
                NSLog(@"current recording mode is %@", result);
            } failure:^(NSError *error) {
								// Network error
            }];
        }
    }
}

- (void)checkStatus:(TuyaSmartCameraSDCardStatus)status {
    if (status == TuyaSmartCameraSDCardStatusNone) {
        return;
    }else if (status == TuyaSmartCameraSDCardStatusException) {
        [self formatAction];
    }else if (status == TuyaSmartCameraSDCardStatusFormatting) {
        [self handleFormatting];
    }else {
        [self getStorageInfo];
      	[self changeToEventRecordMode];
    }
}

- (void)formatAction {
    __weak typeof(self) weakSelf = self;
    [self.dpManager setValue:@(YES) forDP:TuyaSmartCameraSDCardFormatDPName success:^(id result) {
        [weakSelf handleFormatting];
    } failure:^(NSError *error) {
        // Network error
    }];
}

- (void)handleFormatting {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	      // Query the formatting progress, because some manufacturers' devices will not automatically report the progress
        int status = [self getFormatStatus];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status >= 0 && status < 100) {
                [self performSelector:@selector(handleFormatting) withObject:nil afterDelay:2.0];
            } else if (status == 100) {
              	// After formatting successfully, query the capacity information of the device
                [self getStorageInfo];
            } else {
								// fromatting failed
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
		// timeout
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 300.0f * NSEC_PER_SEC));
    return status;
}

- (void)getStorageInfo {
    __weak typeof(self) weakSelf = self;
    [self.dpManager valueForDP:TuyaSmartCameraSDCardStorageDPName success:^(id result) {
        NSArray *components = [result componentsSeparatedByString:@"|"];
        if (components.count < 3) {
          	// Data invalid
            return;
        }
        weakSelf.total = [[components firstObject] integerValue];
        weakSelf.used = [[components objectAtIndex:1] integerValue];
        weakSelf.left = [[components lastObject] integerValue];
    } failure:^(NSError *error) {
        // Network error
    }];
}
```

Swift

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    self.dpManager.value(forDP: .sdCardStatusDPName, success: { result in
        self.checkStatus(status: TuyaSmartCameraSDCardStatus(rawValue: result as! UInt)!)
    }) { _ in
        // Network error
    }
}

func checkStatus(status: TuyaSmartCameraSDCardStatus) {
    switch status {
    case .exception:
        self.formatSDCard()
        break
    case .formatting:
        self.handleFormatting()
        break
    case .none:
        return
    default:
        self.getStorageInfo()
        self.changeToEventRecordMode()
    }
}

func formatSDCard() {
    self.dpManager.setValue(true, forDP: .sdCardFormatDPName, success: { [weak self] _ in
        self?.handleFormatting()
    }) { _ in
        // Network error
    }
}

func handleFormatting() {
    DispatchQueue.global().async {
        // Query the formatting progress, because some manufacturers' devices will not automatically report the progress
        let status = self.getFormatStatus()
        DispatchQueue.main.async {
            if status >= 0, status < 100 {
                self.handleFormatting()
            }else if status == 100 {
                // After formatting successfully, query the capacity information of the device
                self.getStorageInfo()
            }else {
                // Formatting failed
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
    // timeout
    let _ = semaphore.wait(timeout: DispatchTime(uptimeNanoseconds: 300 * NSEC_PER_SEC))
    return status
}

func getStorageInfo() {
    self.dpManager.value(forDP: .sdCardStorageDPName, success: { result in
        let components = (result as! String).split(separator: "|")
        guard components.count == 3 else {
            // Data invalid
            return
        }
        let total = Int(components[0])
        let used = Int(components[1])
        let left = Int(components[2])
    }) { _ in
        // Network error
    }
}

func changeToEventRecordMode() {
    guard self.dpManager.isSupportDP(.sdCardRecordDPName) else {
        return
    }
    let isRecordOn = self.dpManager.value(forDP: .sdCardRecordDPName) as! Bool
    guard self.dpManager.isSupportDP(.recordModeDPName), isRecordOn else {
        return
    }

    let recordMode = self.dpManager.value(forDP: .recordModeDPName) as! String
    if recordMode == TuyaSmartCameraRecordMode.always.rawValue {
        self.dpManager.setValue(TuyaSmartCameraRecordMode.event.rawValue, forDP: .recordModeDPName, success: { result in
            print("current recording mode is ", result as! String)
        }) { _ in
            // Network error
        }
    }

}
```

