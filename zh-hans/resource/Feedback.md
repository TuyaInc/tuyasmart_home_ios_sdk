# 意见反馈

当用户有问题需要反馈时，可添加反馈，添加反馈时应先选择反馈类型，然后撰写反馈内容进行提交，提交后会按照之前选择的反馈类型生成相应的反馈会话，同时用户也可以在该会话中继续撰写反馈内容并提交，显示在该会话的反馈列表中。

意见反馈相关的所有功能对应 `TuyaSmartFeedback` 类，支持获取反馈会话列表，获取会话中反馈内容列表，获取反馈类型列表，以及添加反馈。



### 获取反馈会话列表

获取用户已提交反馈会话列表。



**接口说明**

```objc
- (void)getFeedbackTalkList:(void (^)(NSArray<TuyaSmartFeedbackTalkListModel *> *list))success failure:(TYFailureError)failure;
```



**参数说明**

| 参数    | 说明                   |
| ------- | ---------------------- |
| success | 成功时返回反馈会话列表 |
| failure | 返回失败原因           |



**代码示例**

Objc:

```objc
- (void)getFeedbackTalkList {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack getFeedbackTalkList:^(NSArray<TuyaSmartFeedbackTalkListModel *> *list) {
		NSLog(@"get feedback talk list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get feedback talk list failure:%@", error);
	}];
}
```

Swift:

```swift
func getFeedbackTalkList() {
    feedBack?.getTalkList({ (list) in
        print("get feedback talk list success: \(list)");
    }, failure: { (error) in
        if let e = error {
            print("get feedback talk list failure: \(e)")
        }
    })
}
```



### 获取反馈列表

获取反馈会话中对应的反馈内容列表，`hdId` 和 `hdType` 字段可以从 `TuyaSmartFeedbackTalkListModel` 中获取。



**接口说明**

```objc
- (void)getFeedbackList:(NSString *)hdId
                 hdType:(NSUInteger)hdType
                success:(void (^)(NSArray<TuyaSmartFeedbackModel *> *list))success
                failure:(TYFailureError)failure;
```



**参数说明**

| 参数    | 说明                   |
| ------- | ---------------------- |
| hdId    | 反馈 Id                |
| hdType  | 反馈类型               |
| success | 成功回调，返回反馈列表 |
| failure | 失败回调               |



**代码示例**

Objc:

```objc
- (void)getFeedbackList {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack getFeedbackList:@"your_hdId" hdType:(NSInteger)hdType success:^(NSArray<TuyaSmartFeedbackModel *> *list) {
		NSLog(@"get feedback list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get feedback list failure:%@", error);
	}];
}
```

Swift:

```swift
func getFeedbackList() {
    feedBack?.getList("your_hdId", hdType: hdType, success: { (list) in
        print("get feedback list success: \(list)");
    }, failure: { (error) in
        if let e = error {
            print("get feedback list failure: \(e)")
        }
    })
}
```



### 获取反馈类型列表

添加反馈时，可先选择反馈类型。



**接口说明**

```objc
- (void)getFeedbackTypeList:(void (^)(NSArray<TuyaSmartFeedbackTypeListModel *> *list))success failure:(TYFailureError)failure;
```



**参数说明**

| 参数    | 说明                       |
| ------- | -------------------------- |
| success | 成功回调，返回反馈类型列表 |
| failure | 失败回调                   |



**代码示例**

Objc:

```objc
- (void)getFeedbackTypeList {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack getFeedbackTypeList:^(NSArray<TuyaSmartFeedbackTypeListModel *> *list) {
		NSLog(@"get feedback type list success:%@", list);
	} failure:^(NSError *error) {
		NSLog(@"get feedback type list failure:%@", error);
	}];
}
```

Swift:

```swift
func getFeedbackTalkList() {
    feedBack?.getTypeList({ (list) in
        print("get feedback type list success:\(list)");
    }, failure: { (error) in
        if let e = error {
            print("get feedback type list failure: \(e)")
        }
    })
}
```



### 添加反馈

添加反馈，提交用户输入的反馈的内容，`hdId`和`hdType`字段可以从`TuyaSmartFeedbackTalkListModel`中获取。



**接口说明**

```
- (void)addFeedback:(NSString *)content
               hdId:(NSString *)hdId
             hdType:(NSUInteger)hdType
            contact:(NSString *)contact
            success:(TYSuccessHandler)success
            failure:(TYFailureError)failure
```



**参数说明**

| 参数    | 说明     |
| ------- | -------- |
| content | 反馈内容 |
| hdId    | 反馈 Id  |
| hdType  | 反馈类型 |
| contact | 联系方式 |
| success | 成功回调 |
| failure | 失败回调 |



Objc:

```objc
- (void)addFeedback {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack addFeedback:@"your_feedback_content" hdId:@"your_hdId" hdType:(NSInteger)hdType contact:@"email..." success:^{
		NSLog(@"add feedback success");
	} failure:^(NSError *error) {
		NSLog(@"add feedback failure:%@", error);
	}];
}
```

Swift:

```swift
func getFeedbackTalkList() {
    feedBack?.add("your_feedback_content", hdId: "your_hdId", hdType: hdType, contact: "email...", success: {
        print("add feedback success");
    }, failure: { (error) in
        if let e = error {
            print("add feedback failure: \(e)")
        }
    })
}
```

