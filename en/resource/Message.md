# Message Center

## Function Overview
Message Module contains message and push notifications function. as follows:
* [1. Message](#1)
    * [1.1 Get Message List](#1.1)
    * [1.2 Batch Delete Message](#1.2)
    * [1.3 Check New Message](#1.3)
* [2. Push Notification](#2)
    * [2.1 Get Push Notification Status](#2.1)
    * [2.2 Set Push Notification Status](#2.2)
    * [2.3 Get Device Alarm Push Status](#2.3)
    * [2.4 Set Device Alarm Push Status](#2.4)
    * [2.5 Get Family Message Push Status](#2.5)
    * [2.6 Set Family Message Push Status](#2.6)
    * [2.7 Get Notice Message Push Status](#2.7)
    * [2.8 Set Notice Message Push Status](#2.8)
    * [2.9 Get Market Message Push Status](#2.9)
    * [2.10 Set Market Message Push Status](#2.10)

<h2 id="1">1. Message</h2>
<h3 id="1.1">1.1 Get Message List</h3>
#### 1.1.1 Get Message List
**Interface Name**
```objc
- (void)getMessageList:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，reture message list  |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
Objc:

```objc
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getMessageList:^(NSArray<TuyaSmartMessageListModel *> *list) {
		NSLog(@"get message list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get message list failure:%@", error);
	}];
```
Swift:

```swift
    smartMessage?.getList({ (list) in
        print("get message list success: \(list)")
    }, failure: { (error) in
        if let e = error {
            print("get message list failure: \(e)")
        }
    })
```

### 1.1.2 Get A List Of Paged Messages

**Interface Name**
```objc
- (void)getMessageList:(NSInteger)limit
                offset:(NSInteger)offset
               success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure
```

**Parameter Description**
| Parameter    | Description                     | 
| :------ | :------------------------ |
| limit  | Number of requests per page |
| offset  | Total number of messages requested |
| success | Success callback，reture message list  |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objc
//  self.smartMessage = [[TuyaSmartMessage alloc] init];
    NSNumber *limit = @15;
    NSNumber *offset = @0;
    [self.smartMessage getMessageList:limit offset:offset success:^(NSArray<TuyaSmartMessageListModel *> *list) {
        NSLog(@"get message list success:%@", list);
    } failure:^(NSError *error) {
        NSLog(@"get message list failure:%@", error);
    }];
```

### 1.1.3 Gets A List Of Messages By Paging By Message Type

**Interface Name**
```objc
- (void)getMessageListWithType:(NSInteger)msgType limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure
```

**Parameter Description**
| Parameter    | Description                     | 
| :------ | :------------------------ |
| msgType  | Message type（1 - alarm，2 - family，3 - notifiction）|
| limit  | Number of requests per page |
| offset  | Total number of messages requested |
| success | Success callback，reture message list |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objc
//   self.smartMessage = [[TuyaSmartMessage alloc] init];
    NSNumber *limit = @15;
    NSNumber *offset = @0;
    [self.smartMessage getMessageList:limit offset:offset success:^(NSArray<TuyaSmartMessageListModel *> *list) {
        NSLog(@"get message list success:%@", list);
    } failure:^(NSError *error) {
        NSLog(@"get message list failure:%@", error);
    }];
```

<h3 id="1.2">1.2. Delete Message</h3>

#### 1.2.1 Batch Delete Message
**Interface Name**
```objc
- (void)deleteMessage:(NSArray <NSString *> *)messgeIdList
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| messgeIdList | Delete messageId list  |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Sample Code**

Objc:

```objc
//  self.smartMessage = [[TuyaSmartMessage alloc] init];
    [self.smartMessage deleteMessage:(NSArray <NSString *> *)messgeIdList success:^{
        NSLog(@"delete message success");
    } failure:^(NSError *error) {
        NSLog(@"delete message failure:%@", error);
    }];
```
Swift:

```swift
    smartMessage?.delete(["messgeIdList"], success: {
        print("delete message success")
    }, failure: { (error) in
        if let e = error {
            print("delete message failure: \(e)")
        }
    })
```

#### 1.2.2 Batch Deletion Of Specific Types Of Message
**Interface Name**
```objc
- (void)deleteMessageWithType:(NSInteger)msgType ids:(NSArray *)ids msgSrcIds:(NSArray *)msgSrcIds success:(TYSuccessHandler)success failure:(TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| msgType | Message type（1 - alarm，2 - family，3 - notifiction）  |
| ids | Delete messageId list  |
| msgSrcIds | Delete alarm messageId list，nil or @[] mean don't delete alarm message  |
| success | Success callback  |
| failure | Failure canllback，return reason for failure    |

**Sample Code**

Objc:

```objc
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
    [self.smartMessage deleteMessageWithType:msgType ids:ids msgSrcIds:nil success:^{
        NSLog(@"delete message success");
    } failure:^(NSError *error) {
        NSLog(@"delete message failure:%@", error);
    }];
```

<h3 id="1.3">1.3 检查新消息</h3>

**Interface Name**
```objc
- (void)getLatestMessageWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，返回字典类型（包含的 key 有 “alarm" - 告警，”family“ - 家庭，“notification” - 通知） |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
Objc:

```objc
//      self.smartMessage = [[TuyaSmartMessage alloc] init];
	[self.smartMessage getLatestMessageWithSuccess:^(NSDictionary *result) {
        NSLog(@"get latesMessage success:%@", result);
	} failure:^(NSError *error) {
        NSLog(@"get message max time failure:%@", error);
	}];
```

Swift:

```swift
    smartMessage?.getLatestMessageWithSuccess({ (result) in
        print("get message max time success :\(result)")
    }, failure: { (error) in
        if let e = error {
            print("get message max time failure: \(e)")
        }
    })
```



<h2 id="2">2. 消息推送设置</h2>

<h3 id="2.1">2.1 获取 APP 消息推送的开启状态</h3>

**Interface Name**
```objc
- (void)getPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，返回布尔值；false - 无法接收到设备告警、家庭消息、通知消息等任何消息 |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objective-c
[[TuyaSmartSDK sharedInstance] getPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示推送开关开启
} failure:^(NSError *error) {

}];
```
<h3 id="2.2">2.2 开启或者关闭 APP 消息推送</h3>

**Interface Name**
```objc
- (void)setPushStatusWithStatus:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
 ````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setPushStatusWithStatus:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
 ````

<h3 id="2.3">2.3 获取 APP 设备告警类推送的开启状态</h3>

**Interface Name**
```objc
- (void)getDevicePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，返回布尔值 |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objective-c
[[TuyaSmartSDK sharedInstance] getDevicePushStatusWithSuccess:^(BOOL result) {
  // 当 result == YES 时，表示接收设备告警消息推送
} failure:^(NSError *error) {

}];
```

<h3 id="2.4">2.4 开启或者关闭 APP 设备告警推送</h3>

**Interface Name**
```objc
- (void)setDevicePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setDevicePushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
````

<h3 id="2.5">2.5 获取 APP 家庭通知类推送的开启状态</h3>

**Interface Name**
```objc
- (void)getFamilyPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，返回布尔值 |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objective-c
[[TuyaSmartSDK sharedInstance] getFamilyPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收家庭消息推送
} failure:^(NSError *error) {

}];
```

<h3 id="2.6">2.6 开启或者关闭 APP 家庭推送</h3>

**Interface Name**
```objc
- (void)setFamilyPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setFamilyPushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```

<h3 id="2.7">2.7 获取 APP 消息通知类推送的开启状态</h3>

**Interface Name**
```objc
- (void)getNoticePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，返回布尔值 |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objective-c
[[TuyaSmartSDK sharedInstance] getNoticePushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收通知消息推送
} failure:^(NSError *error) {

}];
```

<h3 id="2.8">2.8 开启或者关闭 APP 消息通知推送</h3>

**Interface Name**
```objc
- (void)setNoticePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setNoticePushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```

<h3 id="2.9">2.9 获取 APP 营销消息类推送的开启状态</h3>

**Interface Name**
```objc
- (void)getMarketingPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，返回布尔值 |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objective-c
[[TuyaSmartSDK sharedInstance] getMarketingPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收营销类消息推送
} failure:^(NSError *error) {

}];
```

<h3 id="2.10">2.10 开启或者关闭 APP 营销类消息推送</h3>

**Interface Name**
```objc
- (void)setMarketingPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**Parameter Description**
| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Sample Code**
```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setMarketingPushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```
