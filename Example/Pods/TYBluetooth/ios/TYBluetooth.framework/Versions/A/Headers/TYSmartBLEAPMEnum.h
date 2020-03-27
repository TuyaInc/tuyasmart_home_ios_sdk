//
//  TYSmartBLEAPMEnum.h
//  Pods
//
//  Created by 温明妍 on 2019/9/24.
//

#ifndef TYSmartBLEAPMEnum_h
#define TYSmartBLEAPMEnum_h

typedef enum : NSUInteger {
    TYSmartBLEAPMType_Activate = 1,// 蓝牙设备激活
    TYSmartBLEAPMType_Online = 2,// 设备本地上线
    TYSmartBLEAPMType_Offline = 3,// 设备本地下线
    TYSmartBLEAPMType_Delete = 4,// 移除设备
    TYSmartBLEAPMType_Publish = 5,// 下发设备
    TYSmartBLEAPMType_Report = 6,// 上报设备
} TYSmartBLEAPMType;

#endif /* TYSmartBLEAPMEnum_h */
