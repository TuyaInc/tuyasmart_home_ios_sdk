//
//  TYBLECentralManagerProtocol.h
//  TYBluetooth
//
//  Created by 黄凯 on 2019/6/5.
//

#ifndef TYBLECentralManagerProtocol_h
#define TYBLECentralManagerProtocol_h

#import <CoreBluetooth/CoreBluetooth.h>

@class TYBLECentralManager;
@class TYBLEPeripheral;
@protocol TYBLECentralManagerDiscvoeryDelegate <NSObject>

@property (nonatomic, copy, readonly) BOOL(^scanFilter)(NSDictionary *advertisementData, NSNumber *rssi);

- (void)centralManager:(TYBLECentralManager *)central didUpdateState:(BOOL)isPoweredOn;
- (void)centralManager:(TYBLECentralManager *)central didDiscoverPeripheral:(TYBLEPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;

@end

@protocol TYBLECentralManagerSessionDelegate <NSObject>

- (void)centralManager:(TYBLECentralManager *)central didConnectPeripheral:(TYBLEPeripheral *)peripheral;
- (void)centralManager:(TYBLECentralManager *)central didDisconnectPeripheral:(TYBLEPeripheral *)peripheral error:(NSError *)error;
- (void)centralManager:(TYBLECentralManager *)central didFailToConnectPeripheral:(TYBLEPeripheral *)peripheral error:(NSError *)error;

@end

#endif /* TYBLECentralManagerProtocol_h */
