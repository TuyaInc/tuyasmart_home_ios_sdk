# Message Center

The message management module contains message center and push  functions. Its messages have three categories: alarm, home, and notification, and each category supports turn on or turn off respectively.

|         Class Name         |                 Description                 |
| :--------------------------: | :----------------------------------: |
|     TuyaSmartMessage     | Get Message List, Batch Delete Message, Check New Message |
| TuyaSmartSDK |      Get Or Set Push Notification Status     |



## Message


### Get Message List

**Declaration**


```objc
- (void)getMessageList:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure
```


**Parameters**


| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，reture message list  |
| failure | Failure canllback，return reason for failure    |

**Example**

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



### Get A List Of Paged Messages

**Declaration**


```objc
- (void)getMessageList:(NSInteger)limit
                offset:(NSInteger)offset
               success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| limit  | Number of requests per page |
| offset  | Total number of messages requested |
| success | Success callback，reture message list  |
| failure | Failure canllback，return reason for failure    |

**Example**

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



### Gets A List Of Messages By Paging By Message Type

**Declaration**

```objc
- (void)getMessageListWithType:(NSInteger)msgType limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| msgType  | Message type（1 - alarm，2 - family，3 - notifiction）|
| limit  | Number of requests per page |
| offset  | Total number of messages requested |
| success | Success callback，reture message list |
| failure | Failure canllback，return reason for failure    |

**Example**


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



### Gets A List Of Detail Messages By Paging By MsgSrcId

**Declaration**

```objective-c
- (void)getMessageDetailListWithType:(NSInteger)msgType msgSrcId:(NSString *)msgSrcId limit:(NSInteger)limit offset:(NSInteger)offset success:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success failure:(TYFailureError)failure
```

**Parameters**

| Parameter | Description                                            |
| :-------- | :----------------------------------------------------- |
| msgType   | Message type（1 - alarm） |
| msgSrcId | Message ID         |
| limit     | Number of requests per page                            |
| offset    | Total number of messages requested                     |
| success   | Success callback，reture message list                  |
| failure   | Failure canllback，return reason for failure           |

**Example**


```objc
		//   self.smartMessage = [[TuyaSmartMessage alloc] init];
    NSNumber *limit = @15;
    NSNumber *offset = @0;
    [self.smartMessage getMessageDetailListWithType:1 msgSrcId:@"xxx" limit offset:offset success:^(NSArray<TuyaSmartMessageListModel *> *list) {
        NSLog(@"get message list success:%@", list);
    } failure:^(NSError *error) {
        NSLog(@"get message list failure:%@", error);
    }];
```



### Delete Message

#### Batch Delete Message

**Declaration**

```objc
- (void)deleteMessage:(NSArray <NSString *> *)messgeIdList
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| messgeIdList | Delete messageId list  |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Example**

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



#### Batch Deletion Of Specific Types Of Message

**Declaration**

```objc
- (void)deleteMessageWithType:(NSInteger)msgType ids:(NSArray *)ids msgSrcIds:(NSArray *)msgSrcIds success:(TYSuccessHandler)success failure:(TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| msgType | Message type（1 - alarm，2 - family，3 - notifiction）  |
| ids | Delete messageId list  |
| msgSrcIds | Delete alarm messageId list，nil or @[] mean don't delete alarm message  |
| success | Success callback  |
| failure | Failure canllback，return reason for failure    |

**Example**

Objc:

```objc
//    self.smartMessage = [[TuyaSmartMessage alloc] init];
    [self.smartMessage deleteMessageWithType:msgType ids:ids msgSrcIds:nil success:^{
        NSLog(@"delete message success");
    } failure:^(NSError *error) {
        NSLog(@"delete message failure:%@", error);
    }];
```



### Check New Message

**Declaration**

```objc
- (void)getLatestMessageWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，return dict type（ keys contain “alarm" - alarm，”family“ - family，“notification” - notification） |
| failure | Failure canllback，return reason for failure    |

**Example**

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



## Push Notification

### Get Push Notification Status

The message push switch is the master switch. In the off state, no messages such as device alarms, home messages, and notification messages can be received.

**Declaration**

```objc
- (void)getPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，return bool type；false - no message of any type is received |
| failure | Failure canllback，return reason for failure    |

**Example**

```objective-c
[[TuyaSmartSDK sharedInstance] getPushStatusWithSuccess:^(BOOL result) {
	// result == YES，means push open
} failure:^(NSError *error) {

}];
```



### Set Push Notification Status

The message push switch is the master switch. In the off state, no messages such as device alarms, home messages, and notification messages can be received.

**Declaration**


```objc
- (void)setPushStatusWithStatus:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | open or close |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Example**

 ````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setPushStatusWithStatus:enable  success:^{
	// set success
} failure:^(NSError *error) {

}];
 ````



### Get Or Set The Switch Status Of The Message According To The Message Type

#### Get Device Alarm Push Status

**Declaration**

```objc
- (void)getDevicePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，return bool value |
| failure | Failure canllback，return reason for failure    |

**Example**


```objective-c
[[TuyaSmartSDK sharedInstance] getDevicePushStatusWithSuccess:^(BOOL result) {
  // result == YES，receive alarm push
} failure:^(NSError *error) {

}];
```



#### Set Device Alarm Push Status


**Declaration**


```objc
- (void)setDevicePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```


**Parameters**


| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | open or close |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Example**


````objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setDevicePushStatusWithStauts:enable  success:^{
	// set success
} failure:^(NSError *error) {

}];
````



#### Get Family Message Push Status

**Declaration**


```objc
- (void)getFamilyPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```


**Parameters**


| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，return bool value |
| failure | Failure canllback，return reason for failure    |

**Example**


```objective-c
[[TuyaSmartSDK sharedInstance] getFamilyPushStatusWithSuccess:^(BOOL result) {
	// result == YES, receive family push
} failure:^(NSError *error) {

}];
```



#### Set Family Message Push Status

**Declaration**


```objc
- (void)setFamilyPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```


**Parameters**


| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | open or close |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Example**


```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setFamilyPushStatusWithStauts:enable  success:^{
	// set success
} failure:^(NSError *error) {

}];
```



#### Get Notice Message Push Status


**Declaration**


```objc
- (void)getNoticePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```


**Parameters**


| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，return bool value |
| failure | Failure canllback，return reason for failure    |


**Example**


```objective-c
[[TuyaSmartSDK sharedInstance] getNoticePushStatusWithSuccess:^(BOOL result) {
	
} failure:^(NSError *error) {

}];
```



#### Set Notice Message Push Status


**Declaration**

```objc
- (void)setNoticePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | open or close |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |

**Example**

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setNoticePushStatusWithStauts:enable  success:^{
	// set success
} failure:^(NSError *error) {

}];
```



#### Get Market Message Push Status

**Declaration**

```objc
- (void)getMarketingPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| success | Success callback，return bool value |
| failure | Failure canllback，return reason for failure    |

**Example**

```objective-c
[[TuyaSmartSDK sharedInstance] getMarketingPushStatusWithSuccess:^(BOOL result) {
	
} failure:^(NSError *error) {

}];
```



#### Set Market Message Push Status


**Declaration**

```objc
- (void)setMarketingPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameter    | Description                     |
| :------ | :------------------------ |
| enable | open or close |
| success | Success callback |
| failure | Failure canllback，return reason for failure    |


**Example**

```objective-c
BOOL enable = YES;
[[TuyaSmartSDK sharedInstance] setMarketingPushStatusWithStauts:enable  success:^{
	// set success
} failure:^(NSError *error) {

}];
```
