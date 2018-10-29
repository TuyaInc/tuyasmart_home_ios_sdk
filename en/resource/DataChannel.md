## 设备数据流通道

该通道主要用于扫地机地图数据等大量实时上报的场景，功能对应类为 `TuyaSmartSingleTransfer`



### 初始化

```objective-c
TuyaSmartSingleTransfer *transfer = [[TuyaSmartSingleTransfer alloc] init];
// 设置代理，状态变化、以及数据接收都会通过代理回调
transfer.delegate = #<TuyaSmartTransferDelegateInstance>;
```



### 开始连接通道

```objective-c
[self.transfer startConnect];
```



### 关闭通道

```objective-c
[self.transfer close];
```



### 订阅设备

```objective-c
[self.transfer subscribeDeviceWithDevId:#<DevId>];
```

> 只有通道连接后才能进行设备订阅，所以进行正确的订阅操作是在收到通道的连接状态更新代理方法后进行设备数据订阅



###  取消订阅设备

```objective-c
[self.transfer unsubscribeDeviceWithDevId:#<DevId>];
```



### 查看通道连接情况

```objective-c
BOOL isConnected = [self.transfer isConnected];
```



### TuyaSmartTransferDelegate 

```objective-c
/**
 数据通道连接情况变化
 
 当通道连接、断开连接等都会通过此方法回调，

 @param transfer
 @param state 状态变化，`TuyaSmartTransferState`
 */
- (void)transfer:(TuyaSmartSingleTransfer *)transfer didUpdateConnectState:(TuyaSmartTransferState)state;


/**
 数据通道收到新数据

 @param transfer
 @param devId 对应数据所属设备 Id
 @param data 收到的数据
 */
- (void)transfer:(TuyaSmartSingleTransfer *)transfer didReciveDataWithDevId:(NSString *)devId data:(NSData *)data;
```

