# 侦测报警

涂鸦智能摄像机通常具有侦测报警的功能，可以通过设备功能点打开侦测开关。侦测告警主要分两种，声音检测和移动检测。当设备检测到声音或者物体移动时，会上报一个警告消息，如果你的 App 集成了推送功能，App 还会收到一个推送通知。集成推送请参考[集成 Push](https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/Push.html)。

报警消息通常会附带一张当前视频的截图。

直供电门铃设备，提供视频消息的能力。当有人按下门铃时，设备可以上传一段留言视频，这个消息也会通过报警消息获取到，消息体会附带一段 6 秒的加密视频。

## 消息列表

**类说明**

| 类名                   | 说明                       |
| ---------------------- | -------------------------- |
| TuyaSmartCameraMessage | 摄像机侦测报警事件消息管理 |



### 初始化

获取消息列表前，需要使用设备 id 和时区初始化消息管理器。

**接口说明**

消息管理类初始化接口

```objc
- (instancetype)initWithDeviceId:(NSString *)devId timeZone:(NSTimeZone *)timeZone;
```

**参数说明**

| 参数     | 说明                                                      |
| -------- | --------------------------------------------------------- |
| devId    | 设备 id                                                   |
| timeZone | 时区，默认使用手机系统时区：`[NSTimeZone systemTimeZone]` |



### 消息日历

可以通过 Camera SDK 查询到某年某月有报警消息的日期，以便于在日历上直观展示。

**接口说明**

获取有消息记录的日期

```objc
- (void)messageDaysForYear:(NSInteger)year
                     month:(NSInteger)month
                   success:(void (^)(NSArray<NSString *> *result))success
                   failure:(void (^)(NSError *error))failure;
```

**参数说明**

| 参数    | 说明                                   |
| ------- | -------------------------------------- |
| year    | 年，如：2020                           |
| month   | 月，如：2                              |
| success | 成功回调，返回当月有消息记录的日期数组 |
| failure | 失败回调，error 标示错误信息           |

>  `result` 为字符串数组，元素为日期字符串，如：“01”、“11”、“30”。



### 消息类型

侦测报警消息根据触发方式定义有多种类型，部分类型又可以划分为一个大的分类。Camera SDK 提供获取默认分类的列表，以便于分类查询报警消息。

**接口说明**

获取消息分类列表

```objc
- (void)getMessageSchemes:(void (^)(NSArray<TuyaSmartCameraMessageSchemeModel *> *result))success
                  failure:(void (^)(NSError *error))failure;
```

**参数说明**

| 参数    | 说明                                 |
| ------- | ------------------------------------ |
| success | 成功回调，返回消息分类数据模型的数组 |
| failure | 失败回调，error 标示错误信息         |



**TuyaSmartCameraMessageSchemeModel 数据模型**

| 字段     | 类型     | 说明                         |
| -------- | -------- | ---------------------------- |
| describe | NSString | 消息分类描述                 |
| msgCodes | NSArray  | 消息分类所包含的消息类型数组 |

> 在获取消息列表时，可以传入消息分类的`msgCodes`属性的值，以获取这个分类包含的所有类型的报警消息。

消息类型表示报警消息的触发形式，代码中体现为报警消息数据模型的`msgCode`属性。

**消息类型说明**

| 类型            | 说明         |
| --------------- | ------------ |
| ipc_motion      | 移动侦测     |
| ipc_doorbell    | 门铃呼叫     |
| ipc_dev_link    | 设备联动     |
| ipc_passby      | 有人经过     |
| ipc_linger      | 有人徘徊     |
| ipc_leave_msg   | 门铃消息留言 |
| ipc_connected   | 门铃已接听   |
| ipc_unconnected | 门铃未接听   |
| ipc_refuse      | 门铃拒接     |
| ipc_human       | 人形检测     |
| ipc_cat         | 宠物检测     |
| ipc_car         | 车辆检测     |
| ipc_baby_cry    | 婴儿哭声     |
| ipc_bang        | 异响         |
| ipc_face        | 检测到人脸   |
| ipc_antibreak   | 强拆报警     |
| ipc_low_battery | 低电量告警   |

> 由于设备能力的不同，能触发的消息类型会有差别。消息分类和消息类型不同，消息类型表示报警消息的触发方式，消息分类是将一个或多个类型的消息组合成一个大类，比如 `ipc_passby`、`ipc_linger`、`ipc_motion` 可以组合成一个分类为移动侦测。

### 消息列表

可以通过 Camera SDK 查询和删除侦测报警消息。

**接口说明**

获取侦测报警消息列表

```objc
- (void)messagesWithMessageCodes:(NSArray *)msgCodes
                          Offset:(NSInteger)offset
                           limit:(NSInteger)limit
                       startTime:(NSInteger)startTime
                         endTime:(NSInteger)endTime
                         success:(void (^)(NSArray<TuyaSmartCameraMessageModel *> *result))success
                         failure:(void (^)(NSError *error))failure;
```

**参数说明**

| 参数      | 说明                                                         |
| --------- | ------------------------------------------------------------ |
| msgCodes  | 消息类型数组，传 nil 可以获取所有类型的消息                  |
| offset    | 偏移量，0 表示从第一个报警消息开始                           |
| limit     | 分页大小，最大数量为 200                                     |
| startTime | 获取不早于 startTime 上报的消息，传 0 表示不限制开始时间，使用 Unix 时间戳 |
| endTime   | 获取不晚于 endTime 上报的消息，使用 Unix 时间戳              |
| success   | 成功回调，返回报警消息数据模型数组                           |
| failure   | 失败回调，error 标示错误信息                                 |

**参数说明**

批量删除报警消息

```objc
- (void)removeMessagesWithMessageIds:(NSArray *)msgIds
                             success:(void (^)(void))success
                             failure:(void (^)(NSError *))failure;
```

**参数说明**

| 参数    | 说明                         |
| ------- | ---------------------------- |
| msgIds  | 欲删除的报警消息的 id 数组   |
| success | 成功回调                     |
| failure | 失败回调，error 标示错误信息 |



**TuyaSmartCameraMessageModel**

| 字段           | 类型      | 说明                           |
| -------------- | --------- | ------------------------------ |
| dateTime       | NSString  | 报警消息上报的日期字符串       |
| msgTypeContent | NSString  | 消息类型描述                   |
| attachPic      | NSString  | 图片附件地址                   |
| attachVideos   | NSArray   | 视频附件地址数组               |
| msgSrcId       | NSString  | 触发报警消息的设备 id          |
| msgContent     | NSString  | 消息内容                       |
| msgTitle       | NSString  | 消息标题                       |
| msgId          | NSString  | 消息 id                        |
| msgCode        | NSString  | 消息类型                       |
| time           | NSInteger | 报警消息上报时间的 Unix 时间戳 |



根据消息类型不同，可能会有不同的附件。通过 `attachPic` 属性获取图片附件的地址，`attachVideos` 属性获取视频附件的地址，通常情况下，这个属性只有一个元素。

## 视频消息

视频消息中的视频附件，是加密后的视频，需要通过 `TuyaSmartCloudManager` 提供的接口播放。 `attachVideos` 中的元素格式为："视频地址@密钥"，播放视频时，需要同时传入视频地址和密钥。

**接口说明**

播放报警消息中的视频

```objc
- (int)playVideoMessageWithUrl:(NSString *)url 
  									 startTime:(int)nStartTime 
                    encryptKey:(NSString *)encryptKey 
                    onResponse:(void (^)(int errCode))callback 
                      onFinish:(void (^)(int errCode))finihedCallBack;
```

**参数说明**

| 参数             | 说明                                                     |
| ---------------- | -------------------------------------------------------- |
| url              | 视频地址                                                 |
| nStartTime       | 开始播放的时间点，从 0 开始，单位为`秒`                  |
| encryptKey       | 视频加密的密钥                                           |
| callback         | 视频播放结果回调，errCode 标示错误码，0 表示播放成功     |
| finishedCallBack | 视频播放结束回调，errCode 标示错误码，0 表示正常播放结束 |

**接口说明**

暂停播放

```objc
- (int)pausePlayVideoMessage;
```

**接口说明**

恢复播放

```objc
- (int)resumePlayVideoMessage;
```

**接口说明**

停止播放

```objc
- (int)stopPlayVideoMessage;
```



**返回值**

| 类型 | 说明                   |
| ---- | ---------------------- |
| int  | 错误码，0 表示操作成功 |



视频消息的播放同云存储视频的播放类似，在接收到视频帧时，会有视频帧数据代理回调。

```objc
- (void)cloudManager:(TuyaSmartCloudManager *)cloudManager 
  	didReceivedFrame:(CMSampleBufferRef)frameBuffer 
      videoFrameInfo:(TuyaSmartVideoFrameInfo)frameInfo;
```

结构体`TuyaSmartVideoFrameInfo`中的下面两个属性描述视频的总时长和进度，单位是`毫秒`。

* **nDuration** : 视频总时长
* **nProgress** : 当前视频帧的进度

视频声音开关同云存储一样，使用下面的接口：

```objc
- (void)enableMute:(BOOL)mute success:(void(^)(void))success failure:(void (^)(NSError * error))failure;
```

### 报警消息与存储卡回放

报警消息和存储卡回放没有直接联系，唯一的关联是在存储卡事件录制模式的情况下，报警消息和存储卡视频录制的触发原因和时间点是一样的。

报警消息保存在涂鸦云端，存储卡视频录像保存在摄像机的存储卡中，且存储卡中的视频在容量不足时，可能会被覆盖。存储卡录制的开关和侦测报警的开关也没有关联，所以即使在存储卡事件录制的模式下，报警消息和存储卡中的视频录像也不是一一对应的。

但是存在报警消息发生的时间点有视频录像的情况，Camera SDK 并不提供这种关联查找的接口，开发者可以通过报警消息的触发时间，在当天的存储卡录像视频片段中查找是否有对应的视频录像来建立这种关联。

**示例代码**

ObjC

```objc
- (void)enableDetect {
		if ([self.dpManager isSupportDP:TuyaSmartCameraMotionDetectDPName]) {
        bool motionDetectOn = [[self.dpManager valueForDP:TuyaSmartCameraMotionDetectDPName] tysdk_toBool];
        if (!motionDetectOn) {
            [self.dpManager setValue:@(YES) 
             									 forDP:TuyaSmartCameraMotionDetectDPName 
             								 success:^(id result) {
                // 开启移动侦测成功
            } failure:^(NSError *error) {
								// 网络错误
            }];
        }
      	[self.dpManager setValue:TuyaSmartCameraMotionHigh
                         	 forDP:TuyaSmartCameraMotionSensitivityDPName
                         success:^(id result) {
            // 成功设置移动侦测灵敏度为高灵敏度
        } failure:^(NSError *error) {
            // 网络错误.
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cameraMessage = [[TuyaSmartCameraMessage alloc] initWithDeviceId:self.devId timeZone:[NSTimeZone defaultTimeZone]];
    [self.cameraMessage getMessageSchemes:^(NSArray<TuyaSmartCameraMessageSchemeModel *> *result) {
	      // 消息分类模型
        self.schemeModels = result;
				// 获取第一个分类的消息
        [self reloadMessageListWithScheme:result.firstObject];
    } failure:^(NSError *error) {
        // 网络错误
    }];
}

- (void)reloadMessageListWithScheme:(TuyaSmartCameraMessageSchemeModel *)schemeModel {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:@"2020-02-17"];
	  // 获取从2020年2月17日零点到现在的报警消息中的前20条
    [self.cameraMessage messagesWithMessageCodes:schemeModel.msgCodes Offset:0 limit:20 startTime:[date timeIntervalSince1970] endTime:[[NSDate new] timeIntervalSince1970] success:^(NSArray<TuyaSmartCameraMessageModel *> *result) {
        self.messageModelList = result;
    } failure:^(NSError *error) {
        // 网络错误
    }];
}

```

Swift

```swift
func enableDectect() {
    guard self.dpManager.isSupportDP(.motionDetectDPName) else {
        return;
    }
    if let isMontionDetectOn = self.dpManager.value(forDP: .motionDetectDPName) as? Bool, !isMontionDetectOn {
        self.dpManager.setValue(true, forDP: .motionDetectDPName, success: { _ in
            // 开启移动侦测成功
        }) { _ in
            // 网络错误
        }
    }
    self.dpManager.setValue(TuyaSmartCameraMotion.high, forDP: .motionSensitivityDPName, success: { _ in
        // 成功设置移动侦测灵敏度为高灵敏度
    }) { _ in
        // 网络错误
    }
}

override func viewDidLoad() {
    super.viewDidLoad()
    self.cameraMessage = TuyaSmartCameraMessage(deviceId: self.devId, timeZone: NSTimeZone.default)
    self.cameraMessage.getSchemes({ result in
        // 获取第一个分类的消息
        self.schemeModels = result
        if let schemeModel = result?.first {
            reloadMessage(schemeModel: schemeModel)
        }
    }) { _ in
        // 网络错误
    }
}
    
func reloadMessage(schemeModel: TuyaSmartCameraMessageSchemeModel) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let date = formatter.date(from: "2020-02-17")
    // 获取从2020年2月17日零点到现在的报警消息中的前20条
    self.cameraMessage.messages(withMessageCodes: schemeModel.msgCodes, offset: 0, limit: 20, startTime: Int(date!.timeIntervalSince1970), endTime: Int(Date().timeIntervalSince1970), success: { result in
        self.messageModelList = result;
    }) { _ in
        // 网络错误
    }
}
```



