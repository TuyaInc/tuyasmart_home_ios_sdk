#  蓝牙第一节——涂鸦蓝牙简介

##  涂鸦蓝牙体系简介

涂鸦蓝牙有三条技术线路。蓝牙设备与手机一对一相连的蓝牙单点设备 **SingleBLE**，涂鸦自研的蓝牙拓扑通信 **TuyaMesh** 和蓝牙技术联盟发布的蓝牙拓扑通信 **SigMesh**。除了以上三种之外，还有一些多协议设备也会使用到蓝牙技术，比如同时具备 Wi-Fi 能力和 BLE 能力的 **双模设备**，也可以使用蓝牙进行配网，当然 Wi-Fi 设备原本的配网仍然可用。

| 蓝牙技术分类 | 产品举例                                                  |
| ------------ | --------------------------------------------------------- |
| SingleBLE    | 体脂秤、手环、温控器、电动牙刷、门锁等                    |
| SigMesh      | 一路、二路、五路等灯泡、插座、传感器等 Sigmesh 子设备     |
| TuyaMesh     | 与 Sigmesh 产品类似，协议为 Tuya 自研                     |
| 双模设备     | Sigmesh 网关、IPC 设备以及新版多协议 Wi-Fi 设备等均有可能 |

> 双模配网的蓝牙配网部分，使用的是 Single BLE 技术为设备配网，将放到 Single BLE 章节进行说明。

蓝牙部分所具备的功能如下：

**1.配网**

- 扫描发现设备
- 设备配网

**2.配网后的设备操作**

- 检查设备当前连接状态
- 连接设备
- 设备操作
- 解绑设备

**3.设备升级固件**

- 检测设备版本
- 升级设备固件 OTA



## App 使用蓝牙所需要权限

在 iOS 13 中，苹果将原来蓝牙申请权限用的 `NSBluetoothPeripheralUsageDescription` 字段，替换为 `NSBluetoothAlwaysUsageDescription` 字段。在 info.plist 中添加新字段

```json

<key>NSBluetoothAlwaysUsageDescription</key>
	<string></string>

<key>NSBluetoothPeripheralUsageDescription</key>
	<string></string>
```

