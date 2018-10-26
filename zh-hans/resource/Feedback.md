当用户有问题需要反馈时，可添加反馈，添加反馈时应先选择反馈类型，然后撰写反馈内容进行提交，提交后会按照之前选择的反馈类型生成相应的反馈会话，同时用户也可以在该会话中继续撰写反馈内容并提交，显示在该会话的反馈列表中。

意见反馈相关的所有功能对应`TuyaSmartFeedback`类，支持获取反馈会话列表，获取会话中反馈内容列表，获取反馈类型列表，以及添加反馈。

### 获取反馈会话列表
获取用户已提交反馈会话列表。

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
### 获取反馈列表
获取反馈会话中对应的反馈内容列表，`hdId`和`hdType`字段可以从`TuyaSmartFeedbackTalkListModel`中获取。

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
### 获取反馈类型列表
添加反馈时，可先选择反馈类型。

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
### 添加反馈
添加反馈，提交用户输入的反馈的内容，`hdId`和`hdType`字段可以从`TuyaSmartFeedbackTalkListModel`中获取。

```objc
- (void)addFeedback {
//    self.feedBack = [[TuyaSmartFeedback alloc] init];
	[self.feedBack addFeedback:@"your_feedback_content" hdId:@"your_hdId" hdType:(NSInteger)hdType success:^{
		NSLog(@"add feedback success");
	} failure:^(NSError *error) {
		NSLog(@"add feedback failure:%@", error);
	}];
}
```