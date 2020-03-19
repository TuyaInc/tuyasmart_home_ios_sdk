## Integrated SDK

### Use CocoaPods for Quick Integration (SDK Basically Supports System Version 9.0)

Add the following content in the `Podfile` file.

```ruby
platform :ios, '9.0'

target 'Your_Project_Name' do
	pod "TuyaSmartHomeKit"
end
```

Then run the `pod update` command in the root directory of project.
For use of CocoaPods, please refer to the [CocoaPods Guides](https://guides.cocoapods.org/). It is recommended to update the CocoaPods to the latest version.

