//
//  TuyaSmartUser+BleMesh.h
//  TuyaSmartBLEKit
//
//  Created by 高森 on 2018/9/4.
//

#import <TuyaSmartBaseKit/TuyaSmartUser.h>
#import <TuyaSmartDeviceKit/TuyaSmartBleMeshModel.h>
#import "TuyaSmartBleMesh.h"

@interface TuyaSmartUser (BleMesh)

@property (nonatomic, strong) TuyaSmartBleMeshModel *meshModel;

@property (nonatomic, strong) TuyaSmartBleMesh *mesh;

@end
