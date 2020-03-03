# Message Center

All functions related to the message center are realized by using the `TuyaSmartMessage` class. Obtaining message list, deleting messages in batches and checking for message update are supported. 

## Obtain Message List

Objc:

```objc
- (void)getMessageList {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageList:^(NSArray<TuyaSmartMessageListModel *> *list) {
		NSLog(@"get message list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get message list failure:%@", error);
	}];
}
```
Swift:

```swift
func getMessageList() {
    smartMessage?.getList({ (list) in
        print("get message list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get message list failure: \(e)")
        }
    })
}
```

## Delete Messages

Delete messages in batches. `messgeIdList` denotes the id group of messages to be deleted, and the message id can be attained from the message list. 

```objc
- (void)deleteMessage {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
    [self.smartMessage deleteMessage:(NSArray <NSString *> *)messgeIdList success:^{
		NSLog(@"delete message success");
    } failure:^(NSError *error) {
    	NSLog(@"delete message failure:%@", error);
    }];
}
```
Swift:

```swift
func deleteMessage() {
    smartMessage?.delete(["messgeIdList"], success: {
        print("delete message success")
    }, failure: { (error) in
        if let e = error {
            print("delete message failure: \(e)")
        }
    })
}
```
## Obtain The Timestamp Of The Latest News

The timestamp of the latest news can be compared with that of local latest message. If the former is bigger than the later, a red dot will be displayed to hint the new message. 

Objc:

```objc
- (void)getMessageMaxTime {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageMaxTime:^(int result) {
		NSLog(@"get message max time success:%d", result);
	} failure:^(NSError *error) {
		NSLog(@"get message max time failure:%@", error);
	}];
}
```

Swift:

```swift
func getMessageMaxTime() {
    smartMessage?.getMaxTime({ (result) in
        print("get message max time success :\(result)")
    }, failure: { (error) in
        if let e = error {
            print("get message max time failure: \(e)")
        }
    })
}
```



## Message Push Settings

### Get Message Push Status

The main control of all message push, including device alert, family message, notification message.

```objective-c
[[TuyaSmartSDK sharedInstance] getPushStatusWithSuccess:^(BOOL result) {

} failure:^(NSError *error) {

}];
```

### Switch Message Push On / Off

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setPushStatusWithStatus:enable  success:^{

} failure:^(NSError *error) {

}];
```

### Get Status Of Device Alert Status

```objective-c
[[TuyaSmartSDK sharedInstance] getDevicePushStatusWithSuccess:^(BOOL result) {

} failure:^(NSError *error) {

}];
```

### Switch Device Alert On / Off

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setDevicePushStatusWithStauts:enable  success:^{

} failure:^(NSError *error) {

}];
```

### Get Family Message Status

```objective-c
[[TuyaSmartSDK sharedInstance] getFamilyPushStatusWithSuccess:^(BOOL result) {

} failure:^(NSError *error) {

}];
```

### Switch Family Message On / Off

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setFamilyPushStatusWithStauts:enable  success:^{

} failure:^(NSError *error) {

}];
```

### Get Notification Message Status

```objective-c
[[TuyaSmartSDK sharedInstance] getNoticePushStatusWithSuccess:^(BOOL result) {

} failure:^(NSError *error) {

}];
```

### Switch Notification Message On / Off

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setNoticePushStatusWithStauts:enable  success:^{

} failure:^(NSError *error) {

}];
```