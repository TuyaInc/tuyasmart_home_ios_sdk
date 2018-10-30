## Integrated SDK

### Use CocoaPods for quick integration (SDK basically supports system version 8.0)

Add the following content in the `Podfile` file.

```ruby
platform :ios, '8.0'

target 'Your_Project_Name' do
	pod "TuyaSmartHomeKit", :git => "https://github.com/TuyaInc/tuyasmart_home_ios_sdk.git"
end
```

Then run the `pod update` command in the root directory of project.
For use of CocoaPods, please refer to the [CocoaPods Guides](https://guides.cocoapods.org/) It is recommended to update the CocoaPods to the latest version.


### Initiate SDK

Add the following content in the `PrefixHeader.pch` file of the project. 

```objc
#import <TuyaSmartHomeKit/TuyaSmartKit.h>
```

Open the `AppDelegate.m` file, and use the `App ID` and `App Secret` obtained from the developer platform in the `[AppDelegate application:didFinishLaunchingWithOptions:]` method to initiate the SDK:


```objc
[[TuyaSmartSDK sharedInstance] startWithAppKey:<#your_app_key#> secretKey:<#your_secret_key#>];
```

Now, the preparation is fully completed, and the App development can start immediately.

### Update the old version (please ignore this upgrade if your former development is not based on Tuya Smart SDK.)

Check whether the data for upgrade is needed. The data upgrading is needed to upgrade TuyaSDK to TuyaHomeSDK. The upgrade Version interface shall be invoked for upgrade. 



```objc
if ([TuyaSmartSDK sharedInstance].checkVersionUpgrade) {
    [[TuyaSmartSDK sharedInstance] upgradeVersion:^{
        
    } failure:^(NSError *error) {
        
    }];
}
```



### Requirements for example codes

Unless otherwise specified, all example codes shall be in the implementation files of the `ViewController` class.


```objc
@interface ViewController : UIViewController

@end

@implementation ViewController

// All example codes shall be in here.

@end
```

We agree that the attribute of `prop` in reference like `self.prop` has been properly realized in the `ViewController` Class. For example:


```objc
self.device = [[TuyaSmartDevice alloc] initWithDeviceId:@"your_device_id"];
```

To run it correctly, the `TuyaSmartDevice` attribute has to be added in the `ViewController` Class. 

```objc
@property (nonatomic, strong) TuyaSmartDevice *device;
```

The rest can be done in the same manner:

### Agreement on returning error

In using SDK, the error returned from interface can be obtained by using the` error.localizedDescription`.


```objc
[[TuyaSmartUser sharedInstance] sendVerifyCode:@"your_country_code" phoneNumber:@"your_phone_number" type:0 success:^{
	NSLog(@"sendVerifyCode success");
} failure:^(NSError *error) {
    // Output details of error
	NSLog(@"error message: %@", error.localizedDescription);
}];
```

### Set common parameter
Pass public parameters to SDK. Currently, `latitude` and `longitude` are supported.
If you need to collect position information of device, you need to report the latitude and longitude. 


```objc 
[[TuyaSmartSDK sharedInstance] setValue:<#latitude#> forKey:@"latitude"];
[[TuyaSmartSDK sharedInstance] setValue:<#longitude#> forKey:@"longitude"];
```
