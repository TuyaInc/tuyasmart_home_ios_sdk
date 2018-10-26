## Message center

All functions related to the message center are realized by using the `TuyaSmartMessage` class. Obtaining message list, deleting messages in batches and checking for message update are supported. 

### Obtain message list

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

### Delete messages

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
### Obtain the timestamp of the latest news

The timestamp of the latest news can be compared with that of local latest message. If the former is bigger than the later, a red dot will be displayed to hint the new message. 

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