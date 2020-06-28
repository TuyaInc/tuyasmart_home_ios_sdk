# Debug Log File

In order to solve the problem that developers encounter difficulties when troubleshooting when integration the SDK, a component that outputs camera operation logs to a local file is now provided `TuyaSmartLogger`.

Add this code int Podfile, and run ```pod install`` at root path of project.

```ruby
pod 'TuyaSmartLogger'
```

Add the code int  ```AppDelegate.m```：

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // your other code
  [TuyaSmartLogger startLog];
  // print log path
  NSLog(@"%@", [TuyaSmartLogger getDebugLogPath]);
  return YES;
}
```

Run your app ，find the debug log file at the paht of `[TuyaSmartLogger getDebugLogPath]`。if you use iPhone debug, you need download the container of your app, just like this:

![download_container](./images/download_container.png)

