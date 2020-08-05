# SDK Architecture

## SDK architecture

### Introduction

IPC SDK encapsulated the camera features base on Home SDK. The SDK is divided into four parts: Utils, Communication Layer，Core layer, Business Layer.

* Utils provides some common tools method，ex: JSON serialization, string codec.
* Communication Layer encapsulated  HTTP，MQTT，Socket，p2p network channels.
* Core layer provides user, home ,device management, and basic function of camera.
* Business Layer provides extension functions, alarm messages management, cloud storage management and other business functions。

### Architecture diagram

![architecture](./images/architecture.jpg)

### Component module

The IPC SDK relies on some components in the Home SDK, including account management, home device management, device configuration, and basic communication module. When using Cocoapods to introduce IPC SDK, the dependent components will be automatically introduced.

**Modules**

| Module                       | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| TuyaSmartCameraKit           | Camera extension functions, cloud storage, alarm messages management |
| TYCameraCloudServicePanelSDK | Tuya cloud storage service order management                  |
| TuyaSmartCameraBase          | Camera basic function interfaces                             |
| TuyaSmartCameraM             | Camera basic function implementations                        |
| TuyaSmartDeviceKit           | Home and Device management                                   |
| TuyaSmartActivatorKit        | Network configuration                                        |
| TuyaSmartBaseKit             | User management and Tuya server https common interface       |
| TuyaCameraSDK                | Tuya p2p network channel implementation                      |
| TuyaSmartSocketChannelKit    | Tuya socket network channel implementation                   |
| TuyaSmartMQTTChannelKit      | Tuya MQTT network channel implementation                     |
| TuyaSmartUtil                | Common tools method                                          |
| TYEncryptImage               | UI kit for display encrypted image                           |



