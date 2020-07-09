# Sweeper SDK

## Features Overview

Tuya Smart Sweeper iOS SDK is based on the [Tuya Smart Home iOS SDK](https://github.com/TuyaInc/tuyasmart_home_ios_sdk)(The following introduction is: Home SDK), which expands the interface package for accessing the related functions of the sweeper device to speed up the development process. Mainly includes the following functions:

- Streaming media (for gyro or visual sweepers) universal data channel
- Data transmission channel of laser sweeper
- Laser sweeper real-time / historical sweep record
- Sweeper universal voice download service

> The laser sweeper data is divided into real-time data and historical record data. Both types of data include map data and path data, which are stored in the cloud in the form of files. Among them, the map and path of real-time data are stored in different files, and the map and path of historical data are stored in the same file. The map and path data are split and read according to the specified rules.



## Preparation for Integration

Tuya Smart Sweeper iOS SDK relies on the Tuya Smart Home iOS SDK, and develop on this basis。Before starting to develop with the SDK, you need to register a developer account, create a product, etc. on the Tuya Smart Development Platform, and obtain a key to activate the SDK, please refer to [Tuya Smart Home iOS SDK Preparation work](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/Preparation.html).

## Rapid Integrated

Add the following content in file `Podfile`:

```ruby
platform :ios, '9.0'

target 'your_target_name' do

   pod 'TuyaSmartSweeperKit'
   
end
```

Execute command `pod update` in the project's root directory to begin integration.

For the instructions of CocoaPods, please refer to: [CocoaPods Guides](https://guides.cocoapods.org/) 



## Header File

Add the following to the project file `PrefixHeader.pch`：

```objective-c
#import <TuyaSmartSweeperKit/TuyaSmartSweeperKit.h>
```

Swift project add the following to the `xxx_Bridging-Header.h` file:

```
#import <TuyaSmartSweeperKit/TuyaSmartSweeperKit.h>
```