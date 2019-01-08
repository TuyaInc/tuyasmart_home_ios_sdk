//
//  TYBLEPeripheralManager.h
//  TuyaSmartPublic
//
//  Created by 冯晓 on 16/8/2.
//  Copyright © 2016年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class TYBLEService;
@class TYBLECharacteristic;

typedef void(^TYBLEPeripheralUserDidSubscribeCallback)(TYBLEService* aService,TYBLECharacteristic* aCharacteristic);
typedef void(^TYBLEPeripheralReadingCallback)(TYBLEService* aService,TYBLECharacteristic* aCharacteristic,NSError* error);
typedef void(^TYBLEPeripheralWritingCallback)(TYBLEService* aService,TYBLECharacteristic* aCharacteristic,NSData* writtenData);
typedef void(^TYBLEPeripheralDataTransferCallback)(TYBLEService* aService,TYBLECharacteristic* aCharacteristic,NSData* dataBeenSent,BOOL sendingEOM,NSError* error);



@interface TYBLEPeripheralManager : NSObject<CBPeripheralManagerDelegate>


/**
 *  引用的CBPeripheralManager对象
 */
@property(nonatomic,strong,readonly) CBPeripheralManager* cbManager;
/**
 *  list of TYBLEService
 */
@property(nonatomic,strong,retain) NSArray* services;

/**
 *  callback blocks
 */
@property(nonatomic,copy) TYBLEPeripheralUserDidSubscribeCallback subscribedCallback;
@property(nonatomic,copy) TYBLEPeripheralReadingCallback readingCallback;
@property(nonatomic,copy) TYBLEPeripheralWritingCallback writingCallback;
@property(nonatomic,copy) TYBLEPeripheralDataTransferCallback dataTransferCallback;
/**
 *  占用的central
 */
@property(nonatomic,strong,readonly) CBCentral* subscribedCentral;
/**
 *  占用的characteristic
 */
@property(nonatomic,strong,readonly) CBMutableCharacteristic* subscribedCharacteristic;
/**
 *  占用的request
 */
@property(nonatomic,strong,readonly) CBATTRequest* subscribedRequest;


/**
 *  为manager添加单个service
 *
 *  @param service TYBLEService对象
 */
- (void)addService:(TYBLEService *)aService withCompletion:(void(^)(void))aCallback;
/**
 *  开始广播
 */
- (void)startAdvertising;

/**
 *  停止广播service
 */
- (void)stopAdvertising;
/**
 *  发送数据到central端,data可以是文件
 *
 *  @param data     待发送的数据
 *  @param eom      结束标识符
 *  @param callback 回调
 */
- (void)pushDataToCentral:(NSData *)data withEOM:(NSString *)eom completion:(TYBLEPeripheralDataTransferCallback) callback;
/**
 *  对central 这个方法通常用来发送较少较短的文本数据
 *
 *  @param data 给central发送的数据
 */
- (void)replyToCentralWithData:(NSData *)data;

@end

