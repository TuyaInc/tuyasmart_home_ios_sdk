# Tuya Smart Lock iOS SDK

Tuya Smart Lock iOS SDK provides function packaging with smart door lock devices to speed up and simplify the development process of door lock application functions, including the following functions:

* Door lock user system (including lock user management, associated password, fingerprint, card, etc.)
* Door lock password unlocking (including dynamic password, temporary password management, etc.)
* Door lock usage records (including door lock unlock records, doorbell records, alarm records, etc.)

## Preparation Work

Tuya lock SDK is based on [Tuya Smart Home SDK](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/)

Before integrating Tuya Lock SDK, you need to do the following:

* Integrate TuyaHomeSdk (including application for tuya App ID and App Secret, security image configuration related environment)，please read [Tuya Smart Home SDK Document]((https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Preparation.html))
* Activation of the lock device

## Integrated SDK

###  Use CocoaPods for Quick Integration

Add the following content in the `Podfile` file.

```ruby
platform :ios, '8.0'

target 'your_target_name' do
   pod "TuyaSmartLockKit"
end
```

Then run the `pod update` command in the root directory of project. For use of CocoaPods, please refer to the [CocoaPods Guides](https://guides.cocoapods.org/). It is recommended to update the CocoaPods to the latest version.https://guides.cocoapods.org/)

### Import Header

Objective-C project add in your class

```objective-c
#import <TuyaSmartLockKit/TuyaSmartLockKit.h>
```

Swift project add in `bridge-header.h`

```
import TuyaSmartLockKit
```