 # 消息中心

## 功能概述

**消息中心模块包含了消息和推送相关的功能，具体如下：**
* [1. 消息相关功能](#1)
    * [1.1 获取消息列表](#1.1)
    * [1.2 批量删除消息](#1.2)
    * [1.3检查新消息](#1.3)
* [2. 消息推送设置](#2)
    * [2.1 获取 APP 消息推送的开启状态](#2.1)
    * [2.2 开启或者关闭 APP 消息推送](#2.2)
    * [2.3 获取 APP 设备告警类推送的开启状态](#2.3)
    * [2.4 开启或者关闭 APP 设备告警推送](#2.4)
    * [2.5 获取 APP 家庭通知类推送的开启状态](#2.5)
    * [2.6 开启或者关闭 APP 家庭推送](#2.6)
    * [2.7 获取 APP 消息通知类推送的开启状态](#2.7)
    * [2.8 开启或者关闭 APP 消息通知推送](#2.8)
    * [2.9 获取 APP 营销消息类推送的开启状态](#2.9)
    * [2.10 开启或者关闭 APP 营销类消息推送](#2.10)


**相关的类**
* TuyaSmartMessage
* TuyaSmartSDK

<h2 id="1">1. 消息相关功能</h2>
<h3 id="1.1">1.1 获取消息列表</h3>
#### 1.1.1 获取消息列表
**接口名**
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

### 1.1.2 获取分页的消息列表

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
| offset  | 已请求到的消息总数 |
| success | 成功回调，返回消息数组  |
| failure | 失败回调，返回失败原因    |

**示例代码**
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

### 1.1.3 根据消息类型分页获取消息列表

**接口名**
```objc
- (void)getMessageListWithType:(NSInteger)msgType limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure
```

**参数说明**
| 参数    | 说明                      | 
| :------ | :------------------------ |
| msgType  | 消息类型（1 - 告警，2 - 家庭，3 - 通知）|
| limit  | 每页请求数据数 |
| offset  | 已请求到的消息总数 |
| success | 成功回调，返回消息数组 |
| failure | 失败回调，返回失败原因    |

**示例代码**
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

<h3 id="1.2">1.2. 删除消息</h3>

#### 1.2.1 批量删除消息
**接口名**
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

#### 1.2.2. 批量删除特定类型的消息
**接口名**
```objc
- (void)deleteMessageWithType:(NSInteger)msgType ids:(NSArray *)ids msgSrcIds:(NSArray *)msgSrcIds success:(TYSuccessHandler)success failure:(TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| msgType | 消息类型（1 - 告警，2 - 家庭，3 - 通知）  |
| ids | 要删除的消息 id 组  |
| msgSrcIds | 告警消息 id 组，传 nil 或 @[] 表示不删除告警消息  |
| success | 成功回调  |
| failure | 失败回调，返回失败原因    |

**示例代码**

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

**接口名**
```objc
- (void)getLatestMessageWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| success | 成功回调，返回字典类型（包含的 key 有 “alarm" - 告警，”family“ - 家庭，“notification” - 通知） |
| failure | 失败回调，返回失败原因    |

**示例代码**
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

**接口名**
```objc
- (void)getPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| success | 成功回调，返回布尔值；false - 无法接收到设备告警、家庭消息、通知消息等任何消息 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objective-c
[[TuyaSmartSDK sharedInstance] getPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示推送开关开启
} failure:^(NSError *error) {

}];
```
<h3 id="2.2">2.2 开启或者关闭 APP 消息推送</h3>

**接口名**
```objc
- (void)setPushStatusWithStatus:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | 成功回调 |
| failure | 失败回调，返回失败原因    |

**示例代码**
 ````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setPushStatusWithStatus:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
 ````

<h3 id="2.3">2.3 获取 APP 设备告警类推送的开启状态</h3>

**接口名**
```objc
- (void)getDevicePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| success | 成功回调，返回布尔值 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objective-c
[[TuyaSmartSDK sharedInstance] getDevicePushStatusWithSuccess:^(BOOL result) {
  // 当 result == YES 时，表示接收设备告警消息推送
} failure:^(NSError *error) {

}];
```

<h3 id="2.4">2.4 开启或者关闭 APP 设备告警推送</h3>

**接口名**
```objc
- (void)setDevicePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | 成功回调 |
| failure | 失败回调，返回失败原因    |

**示例代码**
````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setDevicePushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
````

<h3 id="2.5">2.5 获取 APP 家庭通知类推送的开启状态</h3>

**接口名**
```objc
- (void)getFamilyPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| success | 成功回调，返回布尔值 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objective-c
[[TuyaSmartSDK sharedInstance] getFamilyPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收家庭消息推送
} failure:^(NSError *error) {

}];
```

<h3 id="2.6">2.6 开启或者关闭 APP 家庭推送</h3>

**接口名**
```objc
- (void)setFamilyPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | 成功回调 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setFamilyPushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```

<h3 id="2.7">2.7 获取 APP 消息通知类推送的开启状态</h3>

**接口名**
```objc
- (void)getNoticePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| success | 成功回调，返回布尔值 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objective-c
[[TuyaSmartSDK sharedInstance] getNoticePushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收通知消息推送
} failure:^(NSError *error) {

}];
```

<h3 id="2.8">2.8 开启或者关闭 APP 消息通知推送</h3>

**接口名**
```objc
- (void)setNoticePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | 成功回调 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setNoticePushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```

<h3 id="2.9">2.9 获取 APP 营销消息类推送的开启状态</h3>

**接口名**
```objc
- (void)getMarketingPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| success | 成功回调，返回布尔值 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objective-c
[[TuyaSmartSDK sharedInstance] getMarketingPushStatusWithSuccess:^(BOOL result) {
	// 当 result == YES 时，表示接收营销类消息推送
} failure:^(NSError *error) {

}];
```

<h3 id="2.10">2.10 开启或者关闭 APP 营销类消息推送</h3>

**接口名**
```objc
- (void)setMarketingPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```
**参数说明**
| 参数    | 说明                      |
| :------ | :------------------------ |
| enable | 开启或关闭 |
| success | 成功回调 |
| failure | 失败回调，返回失败原因    |

**示例代码**
```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setMarketingPushStatusWithStauts:enable  success:^{
	// 设置成功
} failure:^(NSError *error) {

}];
```
