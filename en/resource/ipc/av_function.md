## AV Functions

The SDK provides some additional audio and video capabilities when play live video or playback.

### Recording

Once the video has been successfully played (either live or playback), you can record the video currently playing to the phone.

**Declaration**

Record the video and save it to the phone system album.

```objc
- (void)startRecord;
```

**Declaration**

Save the recorded video to the specified path.

```objc
- (void)startRecordWithFilePath:(NSString *)filePath;
```

**Parameters**

| Parameter | Description              |
| --------- | ------------------------ |
| filePath  | Save the video file path |

**Declaration**

Stop record and save the video.

```objc
- (void)stopRecord;
```

**Declaration**

The delegate callback at the beginning of the recording of the video.

```objc
- (void)cameraDidStartRecord:(id<TuyaSmartCameraType>)camera;
```

**Declaration**

The delegate callback for the video to stop recording and successfully save the video file.

```objc
- (void)cameraDidStopRecord:(id<TuyaSmartCameraType>)camera;
```



> Calls to start and stop recording may fail，the error will respond by delegate method: `-(void)camera:didOccurredErrorAtStep: specificErrorCode:;`

**Example**

ObjC

```objc
- (void)startRecord {
    if (self.isRecording) {
        return;
    }
    // Recording can only be started while the video is playing
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
		// recording did start
}

- (void)cameraDidStopRecord:(id<TuyaSmartCameraType>)camera {
		// recording did stop, and video has saved succeed
}

- (void)camera:(id<TuyaSmartCameraType>)camera didOccurredErrorAtStep:(TYCameraErrorCode)errStepCode specificErrorCode:(NSInteger)errorCode {
	  // start or stop record failed
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
    // Recording can only be started while the video is playing
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
    // recording did start
}

func cameraDidStopRecord(_ camera: TuyaSmartCameraType!) {
    // recording did stop, and video has saved succeed
}

func camera(_ camera: TuyaSmartCameraType!, didOccurredErrorAtStep errStepCode: TYCameraErrorCode, specificErrorCode errorCode: Int) {
    // start or stop record failed
    if errStepCode == TY_ERROR_RECORD_FAILED {
        self.isRecording = false
    }
}
```

> During video recording, please do not switch video definition, sound and talk.

### Video snapshot

When the video starts to play successfully (it can be live video or video playback), you can take a screenshot of the currently displayed video image. The SDK provides three ways to take a screenshot.

**Declaration**

Video screenshot, picture saved in the phone system album.

```objc
- (UIImage *)snapShoot;
```

**Return**

| Type    | Description                                                  |
| ------- | ------------------------------------------------------------ |
| UIImage | `UIImage` object of the video screenshot, returns nil to indicate that the image saved failed |

**Declaration**

Video screenshot, image saved in the specified file path.

```objc
- (UIImage *)snapShootSavedAtPath:(NSString *)filePath thumbnilPath:(NSString *)thumbnilPath;
```

**Parameters**

| Parameter    | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| filePath     | The file path to save the picture                            |
| thumbnilPath | Save the file path of the thumbnail and pass nil if you don't need it |

**Return**

| Type    | Description                                                  |
| ------- | ------------------------------------------------------------ |
| UIImage | `UIImage` object of the video screenshot, returns nil to indicate that the image saved failed |



Another way is to use the screenshot interface of the video rendering view `TuyaSmartVideoType`. This method only returns an `UIImage` object and does not automatically save the image.

**Declaration**

```objc
- (UIImage *)screenshot;
```

**Return**

| Type    | Description                                                  |
| ------- | ------------------------------------------------------------ |
| UIImage | `UIImage` object of the video screenshot, returns nil to indicate that the image saved failed |



**Example**

ObjC

```objc
- (void)snapShoot {
    // Only take a screenshot while playing the video
    if (self.previewing || self.playbacking) {
        if ([self.camera snapShoot]) {
            // The screenshot has been saved to the phone album successfully
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
        // The screenshot has been saved to the phone album successfully
    }
}
```

> When using the recording/screenshot method above, make sure that the App has access to the photo album of the phone, or it will cause the App to crash.

### Video sound

When the video is successfully played (either live or playback), the video sound can be turned on, with the default sound turned off.

**Declaration**

Enable mute of video.

```objc
- (void)enableMute:(BOOL)mute forPlayMode:(TuyaSmartCameraPlayMode)playMode;
```

**Parameters**

| Parameter | Description                           |
| --------- | ------------------------------------- |
| mute      | Is muted，`YES`：muted；`NO`：unmuted |
| playMode  | Current play mode                     |

**Declaration**

Video sound switch result delegate callback.

```objc
- (void)camera:(id<TuyaSmartCameraType>)camera didReceiveMuteState:(BOOL)isMute playMode:(TuyaSmartCameraPlayMode)playMode;
```

**Parameters**

| Parameter | Description |
| --------- | ----------- |
| camera    | Camera      |
| isMute    | Is muted    |
| playMode  | Play mode   |



> After a play mode switch (switching between live video and video playback), the SDK does not retain the mute state of the previous playback mode.

### Talk to camera

After the p2p connection is successful, the real-time calling function with the device can be enabled. Before starting talk to device, we need to ensure that the App has gained access to the phone's microphone.

**Declaration**

Open the audio channel from App to camera.

```objc
- (void)startTalk;
```

**Declaration**

Close the audio channel from App to camera.

```objc
- (void)stopTalk;
```

**Declaration**

App to camera sound channel successfully opened callback.

```objc
- (void)cameraDidBeginTalk:(id<TuyaSmartCameraType>)camera;
```

**Declaration**

App to camera sound channel has closed callback.

```objc
- (void)cameraDidStopTalk:(id<TuyaSmartCameraType>)camera;
```



#### Two-way talk

In the video live broadcast, turn on the video sound. At this time, the sound played is the human voice and environmental sound collected by the camera in real time. Then, open the sound channel from App to the camera to implement two-way talk.

> Some cameras may not have speakers or pickups, and such cameras are not capable of two-way talk.

#### One-way talk

The one-way talk function needs the developer to implement control. When the talk is on, turn off the video sound. After the talk is off, turn on the video sound again.

**Example**

ObjC

```objc
- (void)startTalk {
    [self.camera startTalk];
    // mute video sound
    if (!self.isMuted) {
        [self.camera enableMute:YES forPlayMode:TuyaSmartCameraPlayModePreview];
    }
}

- (void)stopTalk {
    [self.camera stopTalk];
}

- (void)cameraDidBeginTalk:(id<TuyaSmartCameraType>)camera {
		// begin talk
}

- (void)cameraDidStopTalk:(id<TuyaSmartCameraType>)camera {
	// talk did stop
	// unmute video sound
    if (self.isMuted) {
        [self.camera enableMute:NO forPlayMode:TuyaSmartCameraPlayModePreview];
    }
}

- (void)camera:(id<TuyaSmartCameraType>)camera didReceiveMuteState:(BOOL)isMute playMode:(TuyaSmartCameraPlayMode)playMode {
		// video mute state changed
		self.isMuted = isMute;
}

- (void)camera:(id<TuyaSmartCameraType>)camera didOccurredErrorAtStep:(TYCameraErrorCode)errStepCode specificErrorCode:(NSInteger)errorCode {
    if (errStepCode == TY_ERROR_START_TALK_FAILED) {
    		// open talk faild, unmute video sound
				if (self.isMuted) {
        		[self.camera enableMute:NO forPlayMode:TuyaSmartCameraPlayModePreview];
    		}
    }
    else if (errStepCode == TY_ERROR_ENABLE_MUTE_FAILED) {
				// mute state change failed
    }
}
```

Swift

```swift
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
	// begin talk
}

func cameraDidStopTalk(_ camera: TuyaSmartCameraType!) {
	// talk did stop
    if self.isMuted {
        self.camera.enableMute(false, for: .preview)
    }
}

func camera(_ camera: TuyaSmartCameraType!, didReceiveMuteState isMute: Bool, playMode: TuyaSmartCameraPlayMode) {
    self.isMuted = isMute
    // video mute state changed
}

func camera(_ camera: TuyaSmartCameraType!, didOccurredErrorAtStep errStepCode: TYCameraErrorCode, specificErrorCode errorCode: Int) {
    if errStepCode == TY_ERROR_START_TALK_FAILED {
        // open talk faild, unmute video sound
        self.camera.enableMute(false, for: .preview)
    }else if errStepCode == TY_ERROR_ENABLE_MUTE_FAILED {
        // mute state change failed
    }
}
```

### Definition switching

In the video live, you can switch the definition (a few cameras only support one kind of definition), currently only high-definition and standard clarity two kinds of definition, and only when the video live support. A memory card video recording saves only one definition stream of video at the time of recording.

**Declaration**

Gets the resolution of the current video, and the result is returned by the delegate method.

```objc
- (void)getHD;
```

**Declaration**

Switch video definition, YES is hd, NO is sd.

```objc
- (void)enableHD:(BOOL)hd;
```

**Parameters**

| Parameter | Description                |
| --------- | -------------------------- |
| hd        | Is hd, `YES`: hd；`NO`: sd |

**Declaration**

Video definition state changed.

```objc
- (void)camera:(id<TuyaSmartCameraType>)camera didReceiveDefinitionState:(BOOL)isHd;
```

**Parameters**

| Parameter | Description                       |
| --------- | --------------------------------- |
| camera    | Camera                            |
| isHd      | Definition state of current video |



**Example**

ObjC

```objc
- (void)changeHD {
  	[self.camera enableHD:!self.HD];
}

- (void)camera:(id<TuyaSmartCameraType>)camera resolutionDidChangeWidth:(NSInteger)width height:(NSInteger)height {
    [self.camera getHD];
}

- (void)camera:(id<TuyaSmartCameraType>)camera didReceiveDefinitionState:(BOOL)isHd {
    self.HD = isHd;
}

- (void)camera:(id<TuyaSmartCameraType>)camera didOccurredErrorAtStep:(TYCameraErrorCode)errStepCode specificErrorCode:(NSInteger)errorCode {
    if (errStepCode == TY_ERROR_ENABLE_HD_FAILED) {
      	// switch definition failed
    }
}

```

Swift

```swift
func changeHD() {
  	self.camera.enableHD(true)
}

func camera(_ camera: TuyaSmartCameraType!, resolutionDidChangeWidth width: Int, height: Int) {
    self.camera.getHD()
}

func camera(_ camera: TuyaSmartCameraType!, didReceiveDefinitionState isHd: Bool) {
    self.isHD = isHd
}

func camera(_ camera: TuyaSmartCameraType!, didOccurredErrorAtStep errStepCode: TYCameraErrorCode, specificErrorCode errorCode: Int) {
    if errStepCode == TY_ERROR_ENABLE_HD_FAILED {
      	// switch definition failed
    }
}
```

### Original video data

Developers can get the YUV data of video from delegate method. The pixel format type of video data is YUV 420sp, in iOS, corresponding to `kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange`.

**Declaration**

Video frame data delegate.

```objc
- (void)camera:(id<TuyaSmartCameraType>)camera ty_didReceiveVideoFrame:(CMSampleBufferRef)sampleBuffer frameInfo:(TuyaSmartVideoFrameInfo)frameInfo;
```

**Parameters**

| Parameter    | Description             |
| ------------ | ----------------------- |
| camera       | Camera                  |
| sampleBuffer | YUV data of video frame |
| frameInfo    | Video frame info        |



**TuyaSmartVideoFrameInfo**

| Field      | Type               | Description                                                  |
| ---------- | ------------------ | ------------------------------------------------------------ |
| nWidth     | int                | Width of video image                                         |
| nHeight    | int                | Height of video image                                        |
| nFrameRate | int                | Video frame rate                                             |
| nTimeStamp | unsigned long long | Video frame time stamp, is second                            |
| nDuration  | unsigned long long | When play video message, indicate the total millisecond of video |
| nProgress  | unsigned long long | When play video message, indicate the millisecond of current frame |



If the developer wants to render the video image by himself or needs to do special treatment on the video image, he can set the 'autoRender' property of the `TuyasmartCameraType` object to `NO`, and then implement this delegate method, at which time the SDK will not automatically render the video image.

If you want to asynchronous processing video frame data, please remember to retain first, or after the completion of this delegate method, video frame data will be released, asynchronous processing occurs when the wild pointer exception.

**Example**

ObjC

```objc
- (void)camera:(id<TuyaSmartCameraType>)camera ty_didReceiveVideoFrame:(CMSampleBufferRef)sampleBuffer frameInfo:(TuyaSmartVideoFrameInfo)frameInfo {
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)sampleBuffer;
    // retain pixelbuffer
    CVPixelBufferRetain(pixelBuffer);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // ...
        // release pixelbuffer
        CVPixelBufferRelease(pixelBuffer);
    });
}
```

Swift

```swift
func camera(_ camera: TuyaSmartCameraType!, ty_didReceiveVideoFrame sampleBuffer: CMSampleBuffer!, frameInfo: TuyaSmartVideoFrameInfo) {
		// ...
}
```
