//
//  TYBLEMeshCommand.h
//  TYBLEMeshKit
//
//  Created by 黄凯 on 2018/5/28.
//

#import <Foundation/Foundation.h>
#import "TYBLEMeshCommandType.h"

//DECLARE_ENUM()

@protocol TYBLEMeshCommandProtocol <NSObject>

/**
 转化为蓝牙命令

 @return 蓝牙命令
 */
- (NSData *)command;

/**
 转化为 raw 类型命令（网关使用）

 @return raw 命令
 */
- (NSString *)raw;

@end

@interface TYBLEMeshCommand : NSObject <TYBLEMeshCommandProtocol>

/**
 命令类型
 */
@property (nonatomic, assign) TYBLEMeshCommandType commandType;

/**
 设备类型，小类在前，大类在后，例如四路灯，此时 pcc 为：0401「04 代表四路灯，01 代表灯大类」
 */
@property (nonatomic, strong) NSString *pcc;

/**
 设备或群组地址，设备地址范围（1 ～ 255），群组地址范围 0x8001～0x8008
 */
@property (nonatomic, assign) uint32_t address;

/**
 是否为群组命令
 */
@property (nonatomic, assign) BOOL isGroup;

/**
 命令数据，需参考文档
 */
@property (nonatomic, strong) NSArray<NSString *> *dataParams;

/**
 辅助日志输出
 */
@property (nonatomic, strong) NSString *logDescription;

@end
