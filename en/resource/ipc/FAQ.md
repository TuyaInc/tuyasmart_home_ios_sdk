

1. After calling startPreview, there is no video picture and no error feedback.
   * Check if the camera object was created successfully. If the obtained camera object is nil, check if p2pType is "1". When p2pType is "1", `TuyaSmartCameraT` needs to be imported. Since this module is no longer maintained, it is recommended to contact the manufacturer to upgrade the camera firmware.
   * Check if the p2p channel is connected successfully. `startPreivew` must be called after receiving the` cameraDidConnected: `callback.
2. Crash after calling `-(void) destory` method.
   * In the old version, there was a bug. When p2pType is 1, calling destory method would indeed crash. This has been fixed in versions after 3.1.1.
   * Before calling the `destory` method, stop the preview or playback operation and call` disConnect` to disconnect the p2p channel.
3. When using the simulator to debug, the screen is green, or some cameras crash when previewing.
   * Some cameras use hardware decoding, which is not supported by the simulator, please use real machine debugging.
4. Audio and video are out of sync.
   * Please let the equipment manufacturer confirm whether the timestamp of the audio frame is the same as the timestamp of the video frame.
5. Playback fails during video playback of memory card.
   * Please confirm that you have requested to obtain the video clip of the memory card recorded on the day before starting the playback.
   * Please check whether the parameters are correct. `PlayTime` must be greater than or equal to` startTime` and less than `endTime`.
6. Already integrated other video solutions, after importing Tuya Smart Camera iOS SDK, compilation error or crash at runtime.
   * This is due to the conflict of FFmpeg library version. You can package the integrated library into a dynamic library to resolve the conflict.
