## Feedback

If user intends to submit feedback, he has to select the type of feedback first and fill the feedback content. After submission, a feedback talk will be generated based on the selected type of feedback. User may continue to fill feedback in the session, and the feedback will be displayed in the feedback list of the session. 

All functions related to the feedback will be realized by using the `TuyaSmartFeedback` class. Obtaining feedback talk list, feedback content list in the session and feedback type list and adding feedback are supported. 

### Obtain feedback talk list

Obtain the feedback talk list submitted by user

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
### Obtain feedback list

Obtain the feedback content list from the feedback talk. The `hdId` and `hdType` can be attained from the TuyaSmartFeedbackTalkListModel.

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
### Obtain feedback type list
The feedback type can be selected first when adding feedback. 

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
### Add feedback

Add and submit feedback. The `hdId` and `hdType` can be obtained from the `TuyaSmartFeedbackTalkListModel`.

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