## Initialize SDK

### Use CocoaPods for Quick Integration 

SDK Basically Supports System Version 9.0

Add the following content in the `Podfile` file.

```ruby
platform :ios, '9.0'

target 'Your_Project_Name' do
	pod "TuyaSmartHomeKit"
end
```

Then run the `pod update` command in the root directory of project.
For use of CocoaPods, please refer to the [CocoaPods Guides](https://guides.cocoapods.org/). It is recommended to update the CocoaPods to the latest version.



### Initialize SDK

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
| ------------- | --------------- |
| appKey        | App key         |
| secretKey     | App secret key  |

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

