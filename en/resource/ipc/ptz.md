## PTZ control

The PTZ camera can be remotely controlled in the specified direction through the SDK.

> When the SDK controls the camera to rotate, it is not a unit angle rotation. After the SDK publish a rotation start command, the device will continue to rotate in the specified direction until it fails to rotate or receives a command to stop rotation.

Before starting to control the PTZ camera rotation, you need to determine whether the current device supports PTZ control.

**Example**

ObjC

```objc
- (void)startPtz {
    if ([self.dpManager isSupportDP:TuyaSmartCameraPTZControlDPName]) {
        [self.dpManager setValue:TuyaSmartCameraPTZDirectionRight forDP:TuyaSmartCameraPTZControlDPName success:^(id result) {
            // Camera start rotate to right
        } failure:^(NSError *error) {
            // Network error
        }];
    }
}

- (void)stopPtz {
    if ([self.dpManager isSupportDP:TuyaSmartCameraPTZStopDPName]) {
        [self.dpManager setValue:@(YES) forDP:TuyaSmartCameraPTZStopDPName success:^(id result) {
            // Camera Stop rotate
        } failure:^(NSError *error) {
            // Network error
        }];
    }
}
```

Swift

```swift
func startPtz() {
    guard self.dpManager.isSupportDP(.ptzControlDPName) else {
        return
    }

    self.dpManager.setValue(TuyaSmartCameraPTZDirection.right, forDP: .ptzControlDPName, success: { _ in
        // Camera start rotate to right
    }) { _ in
        // Network error
    }
}

func stopPtz() {
    guard self.dpManager.isSupportDP(.ptzStopDPName) else {
        return
    }

    self.dpManager.setValue(true, forDP: .ptzStopDPName, success: { _ in
        // Camera Stop rotate
    }) { _ in
        // Network error
    }
}
```
