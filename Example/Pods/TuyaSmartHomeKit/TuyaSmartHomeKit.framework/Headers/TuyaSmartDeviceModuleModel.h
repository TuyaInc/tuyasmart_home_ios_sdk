//
//  TuyaSmartDeviceModel.h
//  TuyaSmartKit
//
//  Created by XuChengcheng on 2017/6/8.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#ifndef TuyaSmart_BleMeshSubDeviceModuleModel
#define TuyaSmart_BleMeshSubDeviceModuleModel

#import "TYModel.h"

@interface TuyaSmartDeviceMcuModel : TYModel

@property (nonatomic, assign) BOOL     isOnline;
@property (nonatomic, strong) NSString *verSw;

@property (nonatomic, strong) NSString     *bv;
@property (nonatomic, strong) NSString     *pv;

@end

@interface TuyaSmartDeviceZigbeeModel : TYModel

@property (nonatomic, assign) BOOL     isOnline;
@property (nonatomic, strong) NSString *verSw;

@end

@interface TuyaSmartDeviceBluetoothModel : TYModel

@property (nonatomic, assign) BOOL     isOnline;
@property (nonatomic, strong) NSString *verSw;

@end

@interface TuyaSmartDeviceWifiModel : TYModel

@property (nonatomic, assign) BOOL         isOnline;
@property (nonatomic, strong) NSString     *bv;
@property (nonatomic, strong) NSString     *pv;
@property (nonatomic, strong) NSString     *verSw;
@property (nonatomic, strong) NSString     *cadv;
@property (nonatomic, strong) NSString     *cdv;

@end

@interface TuyaSmartDeviceInfraredModel : TYModel

@property (nonatomic, assign) BOOL         isOnline;
@property (nonatomic, strong) NSString     *verSw;
@property (nonatomic, strong) NSString     *cadv;
@property (nonatomic, strong) NSString     *cdv;

@end

@interface TuyaSmartDeviceGprsModel : TYModel

@property (nonatomic, assign) BOOL         isOnline;
@property (nonatomic, strong) NSString     *bv;
@property (nonatomic, strong) NSString     *pv;
@property (nonatomic, strong) NSString     *verSw;

@end

@interface TuyaSmartDeviceModuleModel : TYModel

@property (nonatomic, strong) TuyaSmartDeviceWifiModel           *wifi;
@property (nonatomic, strong) TuyaSmartDeviceBluetoothModel      *bluetooth;
@property (nonatomic, strong) TuyaSmartDeviceMcuModel            *mcu;
@property (nonatomic, strong) TuyaSmartDeviceGprsModel           *gprs;
@property (nonatomic, strong) TuyaSmartDeviceZigbeeModel         *zigbee;
@property (nonatomic, strong) TuyaSmartDeviceInfraredModel       *infrared;


@end


#endif
