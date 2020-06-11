//
//  TuyaSmartDeviceModelUtils.h
//  TuyaSmartDeviceKit
//
//  Created by Hemin Won on 2020/3/11.
//

#ifndef TuyaSmartDeviceModelUtils_h
#define TuyaSmartDeviceModelUtils_h

typedef enum : NSUInteger {
    TuyaSmartDeviceUpgradeStatusDefault = 0,    // default 默认不需要升级的
    TuyaSmartDeviceUpgradeStatusReady,          // ready  硬件准备就绪
    TuyaSmartDeviceUpgradeStatusUpgrading,      // upgrading  升级中
    TuyaSmartDeviceUpgradeStatusSuccess,        // success  升级完成
    TuyaSmartDeviceUpgradeStatusFailure,        // failure 升级异常
    TuyaSmartDeviceUpgradeStatusWaitingExectue, // for nb, waiting exectue nb设备任务已下发，但还未执行
    TuyaSmartDeviceUpgradeStatusDownloaded,     // for nb, downloaded nb设备固件已下载
    TuyaSmartDeviceUpgradeStatusTimeout         // timeout 升级超时
} TuyaSmartDeviceUpgradeStatus;

#endif /* TuyaSmartDeviceModelUtils_h */
