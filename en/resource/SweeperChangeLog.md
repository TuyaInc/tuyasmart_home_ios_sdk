## Change Log

### 1.2.5 (2020-07-04)

Dependency `pod 'TuyaSmartDeviceKit'`

- [Feature] ：Get a list of voice package download files by page
- [Feature] ：New extended attributes for voice download



### 1.2.4 (2020-04-26)

Dependency `pod 'TuyaSmartDeviceKit'`

- [Feature] ：Tuya Smart Sweeper Device Management `TuyaSmartSweeperDevice`
- [Feature] ：Provide MQTT Channel for Data Transfer 
- [Deprecated] ：`TuyaSmartSweeper` 和 `TuyaSmartFileDownload`



### 1.0.7 (2019-11-09)

Dependency `pod 'TuyaSmartDeviceKit'`

- [Feature] ：Voice download service
- [bugfix] : Fix this method: `-[TuyaSmartSweeper sweeper:didReciveDataWithDevId:]` to call back the current device data



### 1.0.6 (2019-09-27)

Dependency `pod 'TuyaSmartDeviceKit'`

- [bugfix] : remove log



### 1.0.5 (2019-07-03)

Dependency `pod 'TuyaSmartDeviceKit'`

- [bugfix] : Fix occasional crash



### 1.0.4 (2019-06-24)

Dependency `pod 'TuyaSmartDeviceKit'`

- [bugfix] : Remove mqtt's delegate when the object dealloc



### 0.2.0 (2019-05-15)

Dependency `pod 'TuyaSmartDeviceKit', '~> 2.10.96'`

- [Deprecated] : `-[TuyaSmartSweeperDelegate sweeper:didReciveDataWithDevId:mapType:mapPath:]`, receive laser data channel messages 
- [Feature] : `-[TuyaSmartSweeperDelegate sweeper:didReciveDataWithDevId:mapData:]`, receive laser data channel messages



### 0.1.7 (2019-05-15)

Dependency `pod 'TuyaSmartDeviceKit', '~> 2.8.43'`

- [bugfix] : Support bitcode
- [bugfix] : `- (void)getSweeperCurrentPathWithDevId:`, update the logic of cloud configuration
- [Feature] : `- (void)removeAllHistoryDataWithDevId:`, clear current sweeper history



### 0.1.6 (2019-03-21)

- [Feature] : Sharing device supports viewing history



### 0.1.5 (2019-03-19)

- [bugfix] : Get historical record interface adjustment, will be divided according to the latitude of the family



### 0.1.4 (2019-03-05)

- [bugfix] : The `TuyaSmartSweeperDelegate` proxy method only returns the MQTT message received by the device corresponding to the devId passed in during the current initialization
- [Feature] : `- (void)getSweeperDataWithBucket:`, download files based on bucket and path, complete callback download content
- [Feature] : `- (void)getSweeperDataWithBucket:`, parse OSS error information and return NSError
- [Feature] : `- (void)getSweeperCurrentPathWithDevId:`, get the file path of the real-time map / path
- [Feature] : `- (void)removeSweeperHistoryDataWithDevId:`, delete sweeper history



### 0.1.3 (2019-01-29)

