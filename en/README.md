# Tuya Smart iOS SDK

---


## Features Overview

Tuya Smart APP SDK provides the interface package for the communication with hardware and Tuya Cloud to accelerate the application development process, including the following features:

- Hardware functions (network configuration, control, status reporting, regular tasks, groups, firmware upgrades, sharing)
- Account system (phone number, email registration, login, password reset and other general account functions)
- Tuya Cloud HTTP API interface package

## Rapid Integration

### Using CocoaPods integration (version 8.0 or above is supported)

Add the following content in file `Podfile`:

```ruby
pod "TuyaSmartHomeKit"
```

Execute command `pod update` in the project's root directory to begin integration.

For the instructions of CocoaPods, please refer to: [CocoaPods Guides](https://guides.cocoapods.org/)

## Initializing SDK

Add the following to the project file `PrefixHeader.pch`：

```objc
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

Swift project add the following to the `xxx_Bridging-Header.h` file:

```swift
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

Open file `AppDelegate.m`，and use the `App ID` and `App Secret` obtained from the development platform in the `[AppDelegate application:didFinishLaunchingWithOptions:]`method to initialize SDK:

Objc:

```objc
[[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];
```

Swift:

```swift
 TuyaSmartSDK.sharedInstance()?.start(withAppKey: <#your_app_key#>, secretKey: <#your_secret_key#>)
```

Now all the preparatory work has been completed. You can set out to develop your application.



