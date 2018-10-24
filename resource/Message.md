消息中心相关的所有功能对应`TuyaSmartMessage`类，支持获取消息列表，批量删除消息，以及是否有消息更新。

### 获取消息列表
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
### 删除消息
批量删除消息，`messgeIdList`是要删除消息的id数组，消息id可以从消息列表中获取。

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
### 获取最新一条消息的时间戳
获取最新一条消息的时间戳，可以用于与本地最新一条消息的时间戳比较，大于本地最新消息时间，则展示红点，表示有新消息。

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