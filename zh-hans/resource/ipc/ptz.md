## 云台控制

云台摄像机可以通过 Camera SDK 远程控制其向指定方向转动。

> Camera SDK 控制云台机转动时，并不是单位角度转动。Camera SDK 下发开始转动的命令后，设备会朝着指定方向持续转动，直到无法转动，或者收到停止转动的命令。

在开始控制云台摄像机转动前，需要先判断当前设备是否支持云台控制。

**示例代码**

ObjC

```objc
- (void)startPtz {
    if ([self.dpManager isSupportDP:TuyaSmartCameraPTZControlDPName]) {
        [self.dpManager setValue:TuyaSmartCameraPTZDirectionRight forDP:TuyaSmartCameraPTZControlDPName success:^(id result) {
            // 设备开始向右转动
        } failure:^(NSError *error) {
            // 网络错误
        }];
    }
}

- (void)stopPtz {
    if ([self.dpManager isSupportDP:TuyaSmartCameraPTZStopDPName]) {
        [self.dpManager setValue:@(YES) forDP:TuyaSmartCameraPTZStopDPName success:^(id result) {
            // 设备停止转动
        } failure:^(NSError *error) {
            // 网络错误
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
        // 设备开始向右转动
    }) { _ in
        // 网络错误
    }
}

func stopPtz() {
    guard self.dpManager.isSupportDP(.ptzStopDPName) else {
        return
    }

    self.dpManager.setValue(true, forDP: .ptzStopDPName, success: { _ in
        // 设备停止转动
    }) { _ in
        // 网络错误
    }
}
```

> 在前面设备功能点的章节中，有介绍云台控制的取值范围，在下发控制命令时，建议使用 Camera SDK 中定义的常量。如果使用字面量下发，请确保下发的是字符串字面量，比如向右旋转是 `@"2"`。如果使用 `@(2)`，下发命令的操作将出现类型错误。

