## FAQ

1. Why are errors reported in running the `pod install`? 

   Please confirm that the latest version cocoapod is used. Run the `pod --version` command to check the version of pod, and ensure that the version 1.3.0 or beyond is used. 

2. Why the `"Error Domain=NSURLErrorDomain Code=-999 is canceled"` error is reported when invoking the SDK interface? 

   Please conform that the object you request is a global variable, or the it will be released early, for example, `self.feedBack = [[TuyaSmartFeedback alloc] init]`;

3. How to enable the debugging mode and print logs? 

  Invoke the following codes: `[[TuyaSmartSDK sharedInstance] setDebugMode:YES];` when the SDK is initiated. 

4. The device do not report the status when the control instruction is sent. 

  Please check the data type of function points. For example, the data type of function points shall be value, and the @{@"2": @(25)} instead of @{@"2": @"25"} shall be sent for the control command.

5. In iOS 12, `[[TuyaSmartActivator sharedInstance] currentWifiSSID]` can't get ssid.

   Xcode 10 should open `access wifi information` capability to get ssid. This can be found at:
     `Xcode` -> [Project Name] -> `Targets` -> [Target Name] -> `Capabilities` -> `Access WiFi Information` -> `ON`

