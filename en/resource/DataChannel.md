## Device data channel

Data channel mainly used for big data real-time upload such as sweeper map data, See `TuyaSmartSingleTransfer` class.

### Initialize

```objective-c
TuyaSmartSingleTransfer *transfer = [[TuyaSmartSingleTransfer alloc] init];
// Set delegate. status changed or data received event will be received through callback.
transfer.delegate = #<TuyaSmartTransferDelegateInstance>;
```

### Start connecting data channel

```objective-c
[self.transfer startConnect];
```


### Close data channel

```objective-c
[self.transfer close];
```


### Subscribe device

```objective-c
[self.transfer subscribeDeviceWithDevId:#<DevId>];
```

> Device can't be subscribed before channel connected. Please subscribe device in the channel status callback method.


### Unsubscribe device

```objective-c
[self.transfer unsubscribeDeviceWithDevId:#<DevId>];
```


### Get data channel connect status

```objective-c
BOOL isConnected = [self.transfer isConnected];
```



### TuyaSmartTransferDelegate

```objective-c
/**
 Connect status changed

 When data channel connected/disconnected, this method will be called.

 @param transfer
 @param state Current state，`TuyaSmartTransferState`
 */
- (void)transfer:(TuyaSmartSingleTransfer *)transfer didUpdateConnectState:(TuyaSmartTransferState)state;


/**
 New data received

 @param transfer
 @param devId Device id
 @param data Received data
 */
- (void)transfer:(TuyaSmartSingleTransfer *)transfer didReciveDataWithDevId:(NSString *)devId data:(NSData *)data;

```
