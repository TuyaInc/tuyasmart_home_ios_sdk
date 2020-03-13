# Tuya Smart iOS SDK

---


## Features Overview

Tuya Smart iOS Home SDK is the iOS 8.0 and above version provided by Tuya for the field of smart home. iOS developers can quickly develop app functions based on SDK, realize the activation of intelligent hardware, hardware control, firmware upgrades, timed tasks, intelligent scenarios and other operations.

The SDK includes the following features::

- Account system (phone number, email registration, login, password reset and other general account functions)
- Home system (home management, room management, home sharing and other functions)
- Hardware functions (network configuration, control, status reporting, timed tasks, groups, firmware upgrades, sharing)

## Fast Integration

### Using CocoaPods

Add the following content in file `Podfile`:

```ruby
pod "TuyaSmartHomeKit"
```

Execute command `pod update` in the project's root directory to begin integration.

For the instructions of CocoaPods, please refer to: [CocoaPods Guides](https://guides.cocoapods.org/)

## Initializing SDK

1. Open project setting, `Target => General`, edit `Bundle Identifier` to the value from Tuya develop center.

2. Import security image to the project and rename as `t_s.bmp`, then add it into `Project Setting => Target => Build Phases => Copy Bundle Resources`.

3. Add the following to the project file `PrefixHeader.pch`：

```objc
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

Swift project add the following to the `xxx_Bridging-Header.h` file:

```swift
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

4. Open file `AppDelegate.m`，and use the `App Key` and `App Secret` obtained from the development platform in the `[AppDelegate application:didFinishLaunchingWithOptions:]`method to initialize SDK:

**Declaration**

Init SDK

```objc
- (void)startWithAppKey:(NSString *)appKey secretKey:(NSString *)secretKey;
```

**Parameters**

| **Parameter** | **Description** |
| ------------- | ----------------- |
| appKey        | App key           |
| secretKey     | App secret key |

**Example**

Objc:

```objc
[[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];
```

Swift:

```swift
 TuyaSmartSDK.sharedInstance()?.start(withAppKey: <#your_app_key#>, secretKey: <#your_secret_key#>)
```

Now all the prepare work has been completed. You can use the sdk to develop your application now.



### Debug Mode

During the development we can open debug mode, print the log to analyze some problem.

Objc:

```objc
#ifdef DEBUG
    [[TuyaSmartSDK sharedInstance] setDebugMode:YES];
#else
#endif
```

Swift:

```swift
#if DEBUG
   TuyaSmartSDK.sharedInstance()?.debugMode = true
#else
#endif
```

