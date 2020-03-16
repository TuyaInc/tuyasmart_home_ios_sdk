# Message Center


## Function Overview

Message Module contains message and push notifications function. as follows:

* [Message](#1)
    * [Get Message List](#1.1)
    * [Batch Delete Message](#1.2)
    * [Check New Message](#1.3)
* [Push Notification](#2)
    * [Get Push Notification Status](#2.1)
    * [Set Push Notification Status](#2.2)
    * [Get Device Alarm Push Status](#2.3)
    * [Set Device Alarm Push Status](#2.4)
    * [Get Family Message Push Status](#2.5)
    * [Set Family Message Push Status](#2.6)
    * [Get Notice Message Push Status](#2.7)
    * [Set Notice Message Push Status](#2.8)
    * [Get Market Message Push Status](#2.9)
    * [Set Market Message Push Status](#2.10)

<h2 id="1">Message</h2>

<h3 id="1.1">Get Message List</h3>



#### Get Message List



**Declaration**


```objc
- (void)getMessageList:(void (^)(NSArray<TuyaSmartMessageListModel *> *list))success
               failure:(TYFailureError)failure
```


**Parameters**


| Parameters    | Description                     |
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



| Parameters    | Description                     | 
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



| Parameters    | Description                     | 
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



<h3 id="1.2">Delete Message</h3>



#### Batch Delete Message



**Declaration**



```objc
- (void)deleteMessage:(NSArray <NSString *> *)messgeIdList
              success:(TYSuccessHandler)success
              failure:(TYFailureError)failure
```


**Parameters**



| Parameters    | Description                     |
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



| Parameters    | Description                     |
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



<h3 id="1.3">Check New Message</h3>



**Declaration**



```objc
- (void)getLatestMessageWithSuccess:(TYSuccessDict)success failure:(TYFailureError)failure
```


**Parameters**



| Parameters    | Description                     |
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



<h2 id="2">Push Notification</h2>



<h3 id="2.1">Get Push Notification Status</h3>



**Declaration**



```objc
- (void)getPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```



**Parameters**



| Parameters    | Description                     |
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


<h3 id="2.2">Set Push Notification Status</h3>



**Declaration**


```objc
- (void)setPushStatusWithStatus:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```


**Parameters**



| Parameters    | Description                     |
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


<h3 id="2.3">Get Device Alarm Push Status</h3>



**Declaration**



```objc
- (void)getDevicePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```



**Parameters**



| Parameters    | Description                     |
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


<h3 id="2.4">Set Device Alarm Push Status</h3>


**Declaration**


```objc
- (void)setDevicePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```


**Parameters**


| Parameters    | Description                     |
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


<h3 id="2.5">Get Family Message Push Status</h3>



**Declaration**


```objc
- (void)getFamilyPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```


**Parameters**


| Parameters    | Description                     |
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


<h3 id="2.6">Set Family Message Push Status</h3>



**Declaration**


```objc
- (void)setFamilyPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```


**Parameters**


| Parameters    | Description                     |
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


<h3 id="2.7">Get Notice Message Push Status</h3>


**Declaration**


```objc
- (void)getNoticePushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```


**Parameters**


| Parameters    | Description                     |
| :------ | :------------------------ |
| success | Success callback，return bool value |
| failure | Failure canllback，return reason for failure    |


**Example**


```objective-c
[[TuyaSmartSDK sharedInstance] getNoticePushStatusWithSuccess:^(BOOL result) {
	
} failure:^(NSError *error) {

}];
```

<h3 id="2.8">Set Notice Message Push Status</h3>


**Declaration**

```objc
- (void)setNoticePushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameters    | Description                     |
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

<h3 id="2.9">Get Market Message Push Status</h3>

**Declaration**

```objc
- (void)getMarketingPushStatusWithSuccess:(__nullable TYSuccessBOOL)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameters    | Description                     |
| :------ | :------------------------ |
| success | Success callback，return bool value |
| failure | Failure canllback，return reason for failure    |

**Example**

```objective-c
[[TuyaSmartSDK sharedInstance] getMarketingPushStatusWithSuccess:^(BOOL result) {
	
} failure:^(NSError *error) {

}];
```

<h3 id="2.10">Set Market Message Push Status</h3>


**Declaration**

```objc
- (void)setMarketingPushStatusWithStauts:(BOOL)enable success:(__nullable TYSuccessHandler)success failure:(__nullable TYFailureError)failure
```

**Parameters**

| Parameters    | Description                     |
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
