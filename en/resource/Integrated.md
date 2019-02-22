## Integrated SDK

### Use CocoaPods for quick integration (SDK basically supports system version 8.0)

Add the following content in the `Podfile` file.

```ruby
platform :ios, '8.0'

target 'Your_Project_Name' do
	pod "TuyaSmartHomeKit"
end
```

Then run the `pod update` command in the root directory of project.
For use of CocoaPods, please refer to the [CocoaPods Guides](https://guides.cocoapods.org/) It is recommended to update the CocoaPods to the latest version.

### Update the old version (please ignore this upgrade if your former development is not based on Tuya Smart SDK.)

Check whether the data for upgrade is needed. The data upgrading is needed to upgrade TuyaSDK to TuyaHomeSDK. The upgrade Version interface shall be invoked for upgrade. 

Objc:

```objective-c
if ([TuyaSmartSDK sharedInstance].checkVersionUpgrade) {
	[[TuyaSmartSDK sharedInstance] upgradeVersion:^{
   	 
	} failure:^(NSError *error) {
    
	}];
}
```

Swift:

```swift
if TuyaSmartSDK.sharedInstance()?.checkVersionUpgrade == true {
	TuyaSmartSDK.sharedInstance()?.upgradeVersion({
            
	}, failure: { (e) in
            
	})
}
```