 # 消息中心

## 功能概述

**消息 SDK 提供了消息相关的功能，具体如下：**
* 获取消息列表
* 批量删除消息
* 检查新消息
* 消息推送设置

**相关的类**
* TuyaSmartMessage
* TuyaSmartSDK

## 获取消息列表

**接口名**
1. 获取消息列表
```objc
- (void)getMessageList:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| success | 成功回调，返回消息数组  |
| failure | 失败回调，返回失败原因    |

**示例代码**
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

2. 获取分页的消息列表

**接口名**
```objc
- (void)getMessageList:(NSInteger)limit
                offset:(NSInteger)offset
               success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure
```

**参数说明**
| 参数    | 说明                      | 
| :------ | :------------------------ |
| limit  | 每页请求数据数 |
| offset  | 当前页数，从 0 开始 |
| success | 成功回调，返回消息数组  |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objc
- (void)getMessageList {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageList:@15 offset:@0 success:^(NSArray<TuyaSmartMessageListModel *> *list) {
		NSLog(@"get message list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get message list failure:%@", error);
	}];
}
```

3. 根据消息类型分页获取消息列表

**接口名**
```objc
- (void)getMessageListWithType:(NSInteger)msgType limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure
```

**参数说明**
| 参数    | 说明                      | 
| :------ | :------------------------ |
| msgType  | 消息类型（1 - 告警，2 - 家庭，3 - 通知）|
| limit  | 每页请求数据数 |
| offset  | 当前页数，从 0 开始 |
| success | 成功回调，返回消息数组 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objc
- (void)getMessageList {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageList:@15 offset:@0 success:^(NSArray<TuyaSmartMessageListModel *> *list) {
		NSLog(@"get message list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get message list failure:%@", error);
	}];
}
```

## 删除消息

**接口名**
1. 批量删除消息
```objc
- (void)deleteMessage:(NSArray <NSString *> *)messgeIdList
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| messgeIdList | 要删除的消息 id 组  |
| success | 成功回调 |
| failure | 失败回调，返回失败原因    |

**示例代码**

Objc:

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

2. 批量删除特定类型的消息
```objc
- (void)deleteMessageWithType:(NSInteger)msgType ids:(NSArray *)ids msgSrcIds:(NSArray *)msgSrcIds success:(TYSuccessHandler)success failure:(TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| msgType | 消息类型（1 - 告警，2 - 家庭，3 - 通知）  |
| msgSrcIds | 告警消息 id 组  |
| messgeIdList | 要删除的消息 id 组，可传递 nil  |
| success | 成功回调  |
| failure | 失败回调，返回失败原因    |

**示例代码**

Objc:

```objc
- (void)deleteMessage {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
    [self.smartMessage deleteMessageWithType:type ids:selectedRows msgSrcIds:nil success success:^{
		NSLog(@"delete message success");
    } failure:^(NSError *error) {
    	NSLog(@"delete message failure:%@", error);
    }];
}
```

## 检查新消息

**接口名**
```objc
- (void)getLatestMessageWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| success | 成功回调，返回字典类型（包含的 key 有 “alarm" - 告警，”family“ - 家庭，“notification” - 通知） |
| failure | 失败回调，返回失败原因    |

Objc:

```objc
- (void)getMessageMaxTime {
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getLatestMessageWithSuccess:^(NSDictionary *result) {
		NSLog(@"get latesMessage success:%@", result);
	} failure:^(NSError *error) {
		NSLog(@"get message max time failure:%@", error);
	}];
}
```

Swift:

```swift
func getMessageMaxTime() {
    smartMessage?.getLatestMessageWithSuccess({ (result) in
        print("get message max time success :\(result)")
    }, failure: { (error) in
        if let e = error {
            print("get message max time failure: \(e)")
        }
    })
}
```



## 消息推送设置

### 获取消息推送开关

消息推送开关为总开关，关闭状态下无法接收到设备告警、家庭消息、通知消息等任何消息

```objective-c
[[TuyaSmartSDK sharedInstance] getPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示推送开关开启
} failure:^(NSError *error) {

}];
```

### 设置消息推送开关

 ````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setPushStatusWithStatus:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
 ````

### 获取设备告警消息开关状态

```objective-c
[[TuyaSmartSDK sharedInstance] getDevicePushStatusWithSuccess:^(BOOL result) {
  // 当 result == YES 时，表示接收设备告警消息推送
} failure:^(NSError *error) {

}];
```

### 设置设备告警消息开关

````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setDevicePushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
````

### 获取家庭消息开关状态

```objective-c
[[TuyaSmartSDK sharedInstance] getFamilyPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收家庭消息推送
} failure:^(NSError *error) {

}];
```

### 设置家庭消息开关

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setFamilyPushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```

### 获取通知消息开关状态

```objective-c
[[TuyaSmartSDK sharedInstance] getNoticePushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收通知消息推送
} failure:^(NSError *error) {

}];
```

### 设置通知消息开关

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setNoticePushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```
