## 音视频功能

除了实时视频直播，存储卡录像播放以外，Camera SDK 还提供了一些额外的音视频能力。

### 本地录制

当视频成功开始播放以后（可以是视频直播，也可以是录像回放），可以将当前正在播放的视频录制到手机中。

**接口说明**

录制视频并保存到手机系统相册

```objc
- (void)startRecord;
```

**接口说明**

录制视频保存到指定路径

```objc
- (void)startRecordWithFilePath:(NSString *)filePath;
```

**参数说明**

| 参数     | 说明               |
| -------- | ------------------ |
| filePath | 保存视频的文件路径 |

**接口说明**

停止录制，并保存文件

```objc
- (void)stopRecord;
```

**接口说明**

视频开始录制的代理回调

```objc
- (void)cameraDidStartRecord:(id<TuyaSmartCameraType>)camera;
```

**接口说明**

视频停止录制并成功保存视频文件的代理回调

```objc
- (void)cameraDidStopRecord:(id<TuyaSmartCameraType>)camera;
```



> 调用开始录制和停止录制均有可能会失败，失败后将通过代理方法 `-(void)camera:didOccurredErrorAtStep: specificErrorCode:;`返回错误信息。

**示例代码**

ObjC

```objc
- (void)startRecord {
    if (self.isRecording) {
        return;
    }
    // 在视频播放中才能开启录制
    if (self.previewing || self.playbacking) {
        [self.camera startRecord];
        self.recording = YES;
    }
}

- (void)stopRecord {
    if (self.isRecording) {
        [self.camera stopRecord];
        self.recording = NO;
    }
}

- (void)cameraDidStartRecord:(id<TuyaSmartCameraType>)camera {
		// 已成功开启视频录制，更新 UI
}

- (void)cameraDidStopRecord:(id<TuyaSmartCameraType>)camera {
		// 视频录制已停止，并且录制的视频成功保存
}

- (void)camera:(id<TuyaSmartCameraType>)camera didOccurredErrorAtStep:(TYCameraErrorCode)errStepCode specificErrorCode:(NSInteger)errorCode {
	  // 开启或者停止视频录制失败
    if (errStepCode == TY_ERROR_RECORD_FAILED) {
        self.recording = NO;
    }
}

```

Swift

```swift
func startRecord() {
    if self.isRecording {
        return
    }
    guard self.isPreviewing || self.isPlaybacking else {
        return;
    }
    self.camera.startRecord()
    self.isRecording = true
}

func stopRecord() {
    guard self.isRecording else {
        return
    }
    self.camera.stopRecord()
}

func cameraDidStartRecord(_ camera: TuyaSmartCameraType!) {
    // 已成功开启视频录制，更新 UI
}

func cameraDidStopRecord(_ camera: TuyaSmartCameraType!) {
    // 视频录制已停止，并且录制的视频成功保存
}

func camera(_ camera: TuyaSmartCameraType!, didOccurredErrorAtStep errStepCode: TYCameraErrorCode, specificErrorCode errorCode: Int) {
    // 开启或者停止视频录制失败
    if errStepCode == TY_ERROR_RECORD_FAILED {
        self.isRecording = false
    }
}
```

> 在视频录制的过程中，请不要再切换视频清晰度，开关声音及对讲。

### 视频截图

同样的，当视频成功开始播放以后（可以是视频直播，也可以是录像回放），可以对当前显示的视频图像截图，Camera SDK 提供三种截图的方式。下面两种方式是`TuyaSmartCameraType` 对象提供的方法：

**接口说明**

视频截图，图片保存在手机系统相册

```objc
- (UIImage *)snapShoot;
```

**返回值**

| 类型    | 说明                                                 |
| ------- | ---------------------------------------------------- |
| UIImage | 视频截图的 `UIImage` 对象，返回 nil 表示图片保存失败 |

**接口说明**

视频截图，图片保存在指定文件路径

```objc
- (UIImage *)snapShootSavedAtPath:(NSString *)filePath thumbnilPath:(NSString *)thumbnilPath;
```

**参数说明**

| 参数         | 说明                                           |
| ------------ | ---------------------------------------------- |
| filePath     | 保存图片的文件路径                             |
| thumbnilPath | 保存缩略图的文件路径，如果不需要，可以传入 nil |

**返回值**

| 类型    | 说明                                                 |
| ------- | ---------------------------------------------------- |
| UIImage | 视频截图的 `UIImage` 对象，返回 nil 表示图片保存失败 |

**接口说明**

还有一种方式，是使用视频渲染视图`TuyaSmartVideoType`的截图接口，此方法只返回一个 `UIImage`对象，并不会自动保存图片。

```objc
- (UIImage *)screenshot;
```

**返回值**

| 类型    | 说明                                                 |
| ------- | ---------------------------------------------------- |
| UIImage | 视频截图的 `UIImage` 对象，返回 nil 表示图片保存失败 |



**示例代码**

ObjC

```objc
- (void)snapShoot {
    // 在播放视频时才可以截图
    if (self.previewing || self.playbacking) {
        if ([self.camera snapShoot]) {
            // 截图已成功保存到手机相册
        }
    }
}
```

Swift

```swift
func snapShoot() {
    guard self.isPreviewing || self.isPlaybacking else {
        return;
    }
    if let _ = self.camera.snapShoot() {
        // 截图已成功保存到手机相册
    }
}
```

> 在使用上面的录制/截图方法时，请确保 App 已获得手机相册的访问权限，否则会导致 App 崩溃。

### 视频声音

当视频成功开始播放以后（可以是视频直播，也可以是录像回放），可以开启视频声音，默认声音是关闭状态。

**接口说明**

视频声音开关

```objc
- (void)enableMute:(BOOL)mute forPlayMode:(TuyaSmartCameraPlayMode)playMode;
```

**参数说明**

| 参数     | 说明                                      |
| -------- | ----------------------------------------- |
| mute     | 是否静音，`YES`：关闭声音；`NO`：打开声音 |
| playMode | 当前的播放模式                            |

**接口说明**

视频声音开关结果代理回调

```objc
- (void)camera:(id<TuyaSmartCameraType>)camera didReceiveMuteState:(BOOL)isMute playMode:(TuyaSmartCameraPlayMode)playMode;
```

**参数说明**

| 参数     | 说明                   |
| -------- | ---------------------- |
| camera   | 开关声音的 Camera 对象 |
| isMute   | 当前的静音状态         |
| playMode | 当前的播放模式         |



> 播放模式切换后（视频直播和录像回放之间切换）， Camera SDK 内部不会保留前一个播放模式的静音状态。即如果视频直播打开声音后，切换到了录像回放的模式，声音还是打开的，这时关闭声音，再次切换到视频直播模式，声音还是关闭的。所以切换模式后，需要同步一下期望的声音开关状态。

### 实时对讲

在 p2p 连接成功后，可以开启与设备的实时通话功能，在开始对讲前，需要确保 App 已获得手机麦克风的访问权限。

**接口说明**

开启 App 到摄像机的声音通道

```objc
- (void)startTalk;
```

**接口说明**

关闭 App 到摄像机的声音通道

```objc
- (void)stopTalk;
```

**接口说明**

App 到摄像机的声音通道成功开启代理回调

```objc
- (void)cameraDidBeginTalk:(id<TuyaSmartCameraType>)camera;
```

**接口说明**

App 到摄像机的声音通道成功关闭的代理回调

```objc
- (void)cameraDidStopTalk:(id<TuyaSmartCameraType>)camera;
```



#### 双向对讲

在实时视频直播时，打开视频声音，此时播放的声音即为摄像机实时采集的人声与环境声音，此时打开 App 到摄像机的声音通道，即可实现双向对讲功能。

> 部分摄像机可能没有扬声器或者拾音器，此类摄像机无法实现双向对讲。

#### 单向对讲

单向对讲功能需要开发者来实现控制。在开启对讲的时候，关闭视频声音，关闭对讲后，再打开视频声音即可。

**示例代码**

下面以单向对讲为例来展示声音开关与实时对讲接口的用法。

ObjC

```objc
- (void)startTalk {
    [self.camera startTalk];
    // 如果不是静音状态，关闭声音
    if (!self.isMuted) {
        [self.camera enableMute:YES forPlayMode:TuyaSmartCameraPlayModePreview];
    }
}

- (void)stopTalk {
    [self.camera stopTalk];
}

- (void)cameraDidBeginTalk:(id<TuyaSmartCameraType>)camera {
		// 对讲已成功开启
}

- (void)cameraDidStopTalk:(id<TuyaSmartCameraType>)camera {
		// 对讲已停止
		// 如果是静音状态，打开声音
    if (self.isMuted) {
        [self.camera enableMute:NO forPlayMode:TuyaSmartCameraPlayModePreview];
    }
}

- (void)camera:(id<TuyaSmartCameraType>)camera didReceiveMuteState:(BOOL)isMute playMode:(TuyaSmartCameraPlayMode)playMode {
		// 收到静音状态的变化，更新 UI
		self.isMuted = isMute;
}

- (void)camera:(id<TuyaSmartCameraType>)camera didOccurredErrorAtStep:(TYCameraErrorCode)errStepCode specificErrorCode:(NSInteger)errorCode {
    if (errStepCode == TY_ERROR_START_TALK_FAILED) {
    		// 开启对讲失败，重新打开声音
				if (self.isMuted) {
        		[self.camera enableMute:NO forPlayMode:TuyaSmartCameraPlayModePreview];
    		}
    }
    else if (errStepCode == TY_ERROR_ENABLE_MUTE_FAILED) {
				// 设置静音状态失败
    }
}
```

Swift

```swift
// 当前在实时视频播放状态
func startTalk() {
    self.camera.startTalk()
    guard self.isMuted else {
        self.camera.enableMute(true, for: .preview)
        return
    }
}

func stopTalk() {
    self.camera.stopTalk()
}

func cameraDidBeginTalk(_ camera: TuyaSmartCameraType!) {
    // 对讲已成功开启
}

func cameraDidStopTalk(_ camera: TuyaSmartCameraType!) {
    // 对讲已停止
    if self.isMuted {
        self.camera.enableMute(false, for: .preview)
    }
}

func camera(_ camera: TuyaSmartCameraType!, didReceiveMuteState isMute: Bool, playMode: TuyaSmartCameraPlayMode) {
    self.isMuted = isMute
    // 收到静音状态的变化，更新 UI
}

func camera(_ camera: TuyaSmartCameraType!, didOccurredErrorAtStep errStepCode: TYCameraErrorCode, specificErrorCode errorCode: Int) {
    if errStepCode == TY_ERROR_START_TALK_FAILED {
        // 开启对讲失败，重新打开声音
        self.camera.enableMute(false, for: .preview)
    }else if errStepCode == TY_ERROR_ENABLE_MUTE_FAILED {
        // 设置静音状态失败
    }
}
```

### 清晰度切换

在实时视频直播时，可以切换清晰度（少数摄像机只支持一种清晰度），目前只有高清和标清两种清晰度，且只有实时视频直播时才支持。存储卡视频录像在录制时只保存了一种清晰度的视频流。

**接口说明**

获取当前视频图像的清晰度，结果通过代理方法返回

```objc
- (void)getHD;
```

**接口说明**

 切换视频清晰度，`YES` 是高清，`NO` 是标清

```objc
- (void)enableHD:(BOOL)hd;
```

**参数说明**

| 参数 | 说明                              |
| ---- | --------------------------------- |
| hd   | 是否高清，`YES`：高清；`NO`：标清 |

**接口说明**

视频清晰度状态变化代理回调

```objc
- (void)camera:(id<TuyaSmartCameraType>)camera didReceiveDefinitionState:(BOOL)isHd;
```

**参数说明**

| 参数   | 说明                                      |
| ------ | ----------------------------------------- |
| camera | 清晰度变化的 Camera 对象                  |
| isHd   | 当前的清晰度状态，`YES`：高清，`NO`：标清 |



**示例代码**

ObjC

```objc
- (void)changeHD {
		[self.camera enableHD:!self.HD];
}

// 视频分辨率改变的代理方法，实时视频直播或者录像回放刚开始时也会调用
- (void)camera:(id<TuyaSmartCameraType>)camera resolutionDidChangeWidth:(NSInteger)width height:(NSInteger)height {
		// 获取当前的清晰度
    [self.camera getHD];
}

// 清晰度状态代理方法
- (void)camera:(id<TuyaSmartCameraType>)camera didReceiveDefinitionState:(BOOL)isHd {
    self.HD = isHd;
}

- (void)camera:(id<TuyaSmartCameraType>)camera didOccurredErrorAtStep:(TYCameraErrorCode)errStepCode specificErrorCode:(NSInteger)errorCode {
    if (errStepCode == TY_ERROR_ENABLE_HD_FAILED) {
				// 切换视频清晰度失败
    }
}

```

Swift

```swift
func changeHD() {
    self.camera.enableHD(true)
}

// 视频分辨率改变的代理方法，实时视频直播或者录像回放刚开始时也会调用
func camera(_ camera: TuyaSmartCameraType!, resolutionDidChangeWidth width: Int, height: Int) {
    // 获取当前的清晰度
    self.camera.getHD()
}

func camera(_ camera: TuyaSmartCameraType!, didReceiveDefinitionState isHd: Bool) {
    self.isHD = isHd
}

func camera(_ camera: TuyaSmartCameraType!, didOccurredErrorAtStep errStepCode: TYCameraErrorCode, specificErrorCode errorCode: Int) {
    if errStepCode == TY_ERROR_ENABLE_HD_FAILED {
        // 切换视频清晰度失败
    }
}
```

### 裸流数据

Camera SDK 提供访问视频裸流数据的代理回调方法，此方法返回视频帧的 YUV 数据，颜色编码格式为 YUV 420sp，iOS 中，对应于 `kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange` 格式。

**接口说明**

视频帧裸流数据代理回调

```objc
- (void)camera:(id<TuyaSmartCameraType>)camera ty_didReceiveVideoFrame:(CMSampleBufferRef)sampleBuffer frameInfo:(TuyaSmartVideoFrameInfo)frameInfo;
```

**参数说明**

| 参数         | 说明                         |
| ------------ | ---------------------------- |
| camera       | 接收到视频数据的 Camera 对象 |
| sampleBuffer | 视频帧 YUV 数据              |
| frameInfo    | 视频帧信息                   |



**TuyaSmartVideoFrameInfo 结构体**

| 字段       | 类型               | 描述                                                   |
| ---------- | ------------------ | ------------------------------------------------------ |
| nWidth     | int                | 视频图像宽度                                           |
| nHeight    | int                | 视频图像高度                                           |
| nFrameRate | int                | 视频帧率                                               |
| nTimeStamp | unsigned long long | 视频帧时间戳                                           |
| nDuration  | unsigned long long | 播放报警消息中视频附件时，视频的总长度，单位是`毫秒`   |
| nProgress  | unsigned long long | 播放报警消息中视频附件时，视频帧的时间点，单位是`毫秒` |



如果你想要自己渲染视频图像，或者需要对视频图像做特殊处理，可以将`TuyaSmartCameraType`对象的`autoRender`属性设置为 `NO`，然后实现此代理方法，此时 Camera SDK 将不会自动渲染视频图像。

可以将`sampleBuffer`直接强转为`CVPixelBufferRef`，如果你想要异步处理视频帧数据，请记得先 retain，否则此代理方法执行完成后，视频帧数据将会被释放，异步处理时会发生野指针异常。

**示例代码**

ObjC

```objc
- (void)camera:(id<TuyaSmartCameraType>)camera ty_didReceiveVideoFrame:(CMSampleBufferRef)sampleBuffer frameInfo:(TuyaSmartVideoFrameInfo)frameInfo {
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)sampleBuffer;
    // retain pixelbuffer，防止提前释放
    CVPixelBufferRetain(pixelBuffer);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 处理并渲染 pixelBuffer
        // ...
        // 最后别忘了释放
        CVPixelBufferRelease(pixelBuffer);
    });
}
```

Swift

```swift
func camera(_ camera: TuyaSmartCameraType!, ty_didReceiveVideoFrame sampleBuffer: CMSampleBuffer!, frameInfo: TuyaSmartVideoFrameInfo) {
		// 处理并渲染视频数据
}
```
