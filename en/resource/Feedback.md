# Feedback



If user intends to submit feedback, he has to select the type of feedback first and fill the feedback content. After submission, a feedback talk will be generated based on the selected type of feedback. User may continue to fill feedback in the session, and the feedback will be displayed in the feedback list of the session. 

All functions related to the feedback will be realized by using the `TuyaSmartFeedback` class. Obtaining feedback talk list, feedback content list in the session and feedback type list and adding feedback are supported. 

## Obtain Feedback Talk List

Obtain the feedback talk list submitted by user

**Declaration**

```objc
- (void)getFeedbackTalkList:(void (^)(NSArray<TuyaSmartFeedbackTalkListModel *> *list))success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| :--------- | :--------------- |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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
## Obtain Feedback List



Obtain the feedback content list from the feedback talk. The `hdId` and `hdType` can be attained from the TuyaSmartFeedbackTalkListModel.

**Declaration**

```objc
- (void)getFeedbackList:(NSString *)hdId
                 hdType:(NSUInteger)hdType
                success:(void (^)(NSArray<TuyaSmartFeedbackModel *> *list))success
                failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| :--------- | :--------------- |
| hdId       | Feedback Id      |
| hdType     | Feedback type    |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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
## Obtain Feedback Type List

The feedback type can be selected first when adding feedback. 

**Declaration**

```objc
- (void)getFeedbackTypeList:(void (^)(NSArray<TuyaSmartFeedbackTypeListModel *> *list))success failure:(TYFailureError)failure;
```

**Parameters**

| Parameters | Description      |
| :--------- | :--------------- |
| success    | Success callback |
| failure    | Failure callback |



**Example**

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
## Add Feedback

Add and submit feedback. The `hdId` and `hdType` can be obtained from the `TuyaSmartFeedbackTalkListModel`.

**Declaration**

```objc
- (void)addFeedback:(NSString *)content
               hdId:(NSString *)hdId
             hdType:(NSUInteger)hdType
            contact:(NSString *)contact
            success:(TYSuccessHandler)success
            failure:(TYFailureError)failure
```



**Parameters**

| Parameters | Description      |
| ---------- | ---------------- |
| content    | Feedback content |
| hdId       | Feedback Id      |
| hdType     | Feedback type    |
| contact    | Contact          |
| success    | Success callback |
| failure    | Failure callback |

**Example**

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